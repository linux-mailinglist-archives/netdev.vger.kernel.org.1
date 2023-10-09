Return-Path: <netdev+bounces-39311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB37BEBF2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 22:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE52D2819AC
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB0D3B2AA;
	Mon,  9 Oct 2023 20:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C0F3B789
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 20:51:22 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C639E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 13:51:20 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-bmcZf56xOXGWfbljuxAX8A-1; Mon, 09 Oct 2023 16:50:58 -0400
X-MC-Unique: bmcZf56xOXGWfbljuxAX8A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE69B3822E89;
	Mon,  9 Oct 2023 20:50:57 +0000 (UTC)
Received: from hog.localdomain (unknown [10.45.225.111])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9A1336E1;
	Mon,  9 Oct 2023 20:50:56 +0000 (UTC)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>
Subject: [PATCH net-next 00/14] net: tls: various code cleanups and improvements
Date: Mon,  9 Oct 2023 22:50:40 +0200
Message-ID: <cover.1696596130.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series contains multiple cleanups and simplifications for the
config code of both TLS_SW and TLS_HW.

It also modifies the chcr_ktls driver to use driver_state like all
other drivers, so that we can then make driver_state fixed size
instead of a flex array always allocated to that same fixed size. As
reported by Gustavo A. R. Silva, the way chcr_ktls misuses
driver_state irritates GCC [1].

Patches 1 and 2 are follow-ups to my previous cipher_desc series.

[1] https://lore.kernel.org/netdev/ZRvzdlvlbX4+eIln@work/

Sabrina Dubroca (14):
  tls: get salt using crypto_info_salt in tls_enc_skb
  tls: drop unnecessary cipher_type checks in tls offload
  tls: store rec_seq directly within cipher_context
  tls: rename MAX_IV_SIZE to TLS_MAX_IV_SIZE
  tls: store iv directly within cipher_context
  tls: extract context alloc/initialization out of tls_set_sw_offload
  tls: move tls_prot_info initialization out of tls_set_sw_offload
  tls: also use init_prot_info in tls_set_device_offload
  tls: add a helper to allocate/initialize offload_ctx_tx
  tls: remove tls_context argument from tls_set_sw_offload
  tls: remove tls_context argument from tls_set_device_offload
  tls: validate crypto_info in a separate helper
  chcr_ktls: use tls_offload_context_tx and driver_state like other
    drivers
  tls: use fixed size for tls_offload_context_{tx,rx}.driver_state

 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.c |  43 ++--
 .../chelsio/inline_crypto/ch_ktls/chcr_ktls.h |  36 +++-
 include/net/tls.h                             |  21 +-
 net/tls/tls.h                                 |  12 +-
 net/tls/tls_device.c                          | 101 ++++-----
 net/tls/tls_device_fallback.c                 |  23 +-
 net/tls/tls_main.c                            |  62 +++---
 net/tls/tls_sw.c                              | 198 +++++++++---------
 8 files changed, 244 insertions(+), 252 deletions(-)

--=20
2.42.0


