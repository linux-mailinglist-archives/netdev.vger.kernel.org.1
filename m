Return-Path: <netdev+bounces-31020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DA78A911
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CFFF1C2082F
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1206AA6;
	Mon, 28 Aug 2023 09:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D042F38
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 09:42:33 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95FFF
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 02:42:32 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-roygIhXMM0-hLGSViJHjJA-1; Mon, 28 Aug 2023 05:42:28 -0400
X-MC-Unique: roygIhXMM0-hLGSViJHjJA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED3218564F0;
	Mon, 28 Aug 2023 09:42:27 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 199BD492C13;
	Mon, 28 Aug 2023 09:42:26 +0000 (UTC)
Date: Mon, 28 Aug 2023 11:42:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Scott Dial <scott@scottdial.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Message-ID: <ZOxsAR42r8t3z0Dq@hog>
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
 <20230818184648.127b2ccf@kernel.org>
 <ZOTWzJ4aEa5geNva@hog>
 <a9af0c0a-ec7c-fa01-05ac-147fccb94fbf@scottdial.com>
 <ZOdUw66jbDWE8blF@hog>
 <76e055e9-5b2b-75b9-b545-cbdbc6ad2112@scottdial.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <76e055e9-5b2b-75b9-b545-cbdbc6ad2112@scottdial.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

2023-08-24, 13:08:41 -0400, Scott Dial wrote:
> On 8/24/2023 9:01 AM, Sabrina Dubroca wrote:
> > 2023-08-23, 16:22:31 -0400, Scott Dial wrote:
> > > AES-NI's implementation of gcm(aes) requires the FPU, so if it's busy=
 the
> > > decrypt gets stuck on the cryptd queue, but that queue is not
> > > order-preserving.
> >=20
> > It should be (per CPU [*]). The queue itself is a linked list, and if w=
e
> > have requests on the queue we don't let new requests skip the queue.
>=20
> My apologies, I'll be the first to admit that I have not tracked all of t=
he
> code changes to either the macsec driver or linux-crypto since I first ma=
de
> the commit. This comment that requests are queued forced me to review the
> code again and it appears that the queueing issue was resolved in v5.2-rc=
1
> with commit 1661131a0479, so I no longer believe we need the
> CRYPTO_ALG_ASYNC since v5.2 and going forward.

Are you sure about this? 1661131a0479 pre-dates your patch by over a
year.

And AFAICT, that series only moved the existing FPU usable +
cryptd_aead_queued tests from AESNI's implementation of gcm(aes) to
common SIMD helpers.

--=20
Sabrina


