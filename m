Return-Path: <netdev+bounces-29692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11817845CB
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB0528103B
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE071DA27;
	Tue, 22 Aug 2023 15:40:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5521C28D
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:40:16 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07B3CEE
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 08:40:03 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-tA653UeBNwqxcEs-SIXIXA-1; Tue, 22 Aug 2023 11:39:59 -0400
X-MC-Unique: tA653UeBNwqxcEs-SIXIXA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6C508015A8;
	Tue, 22 Aug 2023 15:39:58 +0000 (UTC)
Received: from hog (unknown [10.39.192.31])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D2FEB2166B26;
	Tue, 22 Aug 2023 15:39:57 +0000 (UTC)
Date: Tue, 22 Aug 2023 17:39:56 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, Scott Dial <scott@scottdial.com>
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Message-ID: <ZOTWzJ4aEa5geNva@hog>
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
 <20230818184648.127b2ccf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230818184648.127b2ccf@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-18, 18:46:48 -0700, Jakub Kicinski wrote:
> On Thu, 17 Aug 2023 17:07:03 +0200 Sabrina Dubroca wrote:
> > Commit ab046a5d4be4 ("net: macsec: preserve ingress frame ordering")
> > tried to solve an issue caused by MACsec's use of asynchronous crypto
> > operations, but introduced a large performance regression in cases
> > where async crypto isn't causing reordering of packets.
> >=20
> > This patch introduces a per-netns sysctl that administrators can set
> > to allow new SAs to use async crypto, such as aesni. Existing SAs
> > won't be modified.
> >=20
> > By setting default_async_crypto=3D1 and reconfiguring macsec, a single
> > netperf instance jumps from 1.4Gbps to 4.4Gbps.
>=20
> Can we not fix the ordering problem?
> Queue the packets locally if they get out of order?

Actually, looking into the crypto API side, I don't see how they can
get out of order since commit 81760ea6a95a ("crypto: cryptd - Add
helpers to check whether a tfm is queued"):

    [...] ensure that no reordering is introduced because of requests
    queued in cryptd with respect to requests being processed in
    softirq context.

And cryptd_aead_queued() is used by AESNI (via simd_aead_decrypt()) to
decide whether to process the request synchronously or not.

So I really don't get what commit ab046a5d4be4 was trying to fix. I've
never been able to reproduce that issue, I guess commit 81760ea6a95a
explains why.

I'd suggest to revert commit ab046a5d4be4, but it feels wrong to
revert it without really understanding what problem Scott hit and why
81760ea6a95a didn't solve it.

What do you think?

--=20
Sabrina


