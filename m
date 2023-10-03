Return-Path: <netdev+bounces-37748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F37B6F28
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E019BB207C5
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE32538BA4;
	Tue,  3 Oct 2023 16:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F182E628
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:59:21 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA762A6
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:59:19 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-689-xuwW08IkPQyY_aY8uirDQw-1; Tue, 03 Oct 2023 12:59:02 -0400
X-MC-Unique: xuwW08IkPQyY_aY8uirDQw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B175F3C1ACE5;
	Tue,  3 Oct 2023 16:58:44 +0000 (UTC)
Received: from hog (unknown [10.45.224.63])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 70EB64A9B0C;
	Tue,  3 Oct 2023 16:58:42 +0000 (UTC)
Date: Tue, 3 Oct 2023 18:58:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ayush Sawal <ayush.sawal@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rohit Maheshwari <rohitm@chelsio.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] cxgb4/ch_ktls: Fix undefined behavior bug in
 struct chcr_ktls_ofld_ctx_tx
Message-ID: <ZRxIQF8BHM_woghk@hog>
References: <ZRvzdlvlbX4+eIln@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZRvzdlvlbX4+eIln@work>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-10-03, 12:56:54 +0200, Gustavo A. R. Silva wrote:
> `struct tls_offload_context_tx` is a flexible structure, which means
> that it contains a flexible-array member at the bottom. This could
> potentially lead to an overwrite of the objects following `base` in
> `struct chcr_ktls_ofld_ctx_tx` at run-time.
> 
> Notice that flexible-array member `driver_state` in `struct
> tls_offload_context_tx` can grow up to 16 bytes:
> 
> | include/net/tls.h-170:
> | #define TLS_DRIVER_STATE_SIZE_TX  16
> 
> | include/net/tls.h-173:
> | #define TLS_OFFLOAD_CONTEXT_SIZE_TX                                     \
> |	(sizeof(struct tls_offload_context_tx) + TLS_DRIVER_STATE_SIZE_TX)
> 
> | net/tls/tls_device.c-1119:
> | offload_ctx = kzalloc(TLS_OFFLOAD_CONTEXT_SIZE_TX, GFP_KERNEL);
> 
> Fix this by placing the declaration of object `base` at the end of
> `struct chcr_ktls_ofld_ctx_tx`.

AFAIU, chcr_ktls_ofld_ctx_tx just misuses the extra space allocated by
tls_set_device_offload. There's no bug, but the code is a bit
confusing. I don't think this patch works, since chcr_ktls doesn't
allocate its own memory for chcr_ktls_ofld_ctx_tx.

As part of a series of cleanups that I'll submit soon (hopefully this
week), I updated chcr_ktls to use the driver_state part of
tls_offload_context_tx (instead of the cast in
chcr_get_ktls_tx_context), and then removed the flexarrays from
tls_offload_context_tx and tls_offload_context_rx (since they're
actually a fixed size).

-- 
Sabrina


