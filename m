Return-Path: <netdev+bounces-45601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9505A7DE823
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 23:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EF61F223CF
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A25A96FA7;
	Wed,  1 Nov 2023 22:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637021C6A4
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 22:31:44 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B91119
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 15:31:42 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-JsZcU_SuNIKlpQF22l2FmQ-1; Wed, 01 Nov 2023 18:31:36 -0400
X-MC-Unique: JsZcU_SuNIKlpQF22l2FmQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB53828CE1;
	Wed,  1 Nov 2023 22:31:35 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF7C0492BFA;
	Wed,  1 Nov 2023 22:31:34 +0000 (UTC)
Date: Wed, 1 Nov 2023 23:31:33 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net] macsec: Abort MACSec Rx offload datapath when skb is
 not marked with MACSec metadata
Message-ID: <ZULRxX9eIbFiVi7v@hog>
References: <20231101200217.121789-1-rrameshbabu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231101200217.121789-1-rrameshbabu@nvidia.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2023-11-01, 13:02:17 -0700, Rahul Rameshbabu wrote:
> When MACSec is configured on an outer netdev, traffic received directly
> through the underlying netdev should not be processed by the MACSec Rx
> datapath. When using MACSec offload on an outer netdev, traffic with no
> metadata indicator in the skb is mistakenly considered as MACSec traffic
> and incorrectly handled in the handle_not_macsec function. Treat skbs wit=
h
> no metadata type as non-MACSec packets rather than assuming they are MACS=
ec
> packets.

What about the other drivers? mlx5 is the only driver that sets md_dst
on its macsec skbs, so their offloaded packets just get dropped now?

--=20
Sabrina


