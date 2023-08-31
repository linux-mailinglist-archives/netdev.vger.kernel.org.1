Return-Path: <netdev+bounces-31596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A210078EF55
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC9931C20ADD
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 14:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F211C8F;
	Thu, 31 Aug 2023 14:11:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28211707
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 14:11:25 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F72B8
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 07:11:23 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-zI_WNUMnOF6tT_us97ScKQ-1; Thu, 31 Aug 2023 10:10:58 -0400
X-MC-Unique: zI_WNUMnOF6tT_us97ScKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C608C101CC98;
	Thu, 31 Aug 2023 14:10:44 +0000 (UTC)
Received: from hog (unknown [10.45.224.12])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id B06D5140E950;
	Thu, 31 Aug 2023 14:10:41 +0000 (UTC)
Date: Thu, 31 Aug 2023 16:10:40 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Scott Dial <scott@scottdial.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next] macsec: introduce default_async_crypto sysctl
Message-ID: <ZPCfYLsLycX68IeG@hog>
References: <9328d206c5d9f9239cae27e62e74de40b258471d.1692279161.git.sd@queasysnail.net>
 <20230818184648.127b2ccf@kernel.org>
 <ZOTWzJ4aEa5geNva@hog>
 <a9af0c0a-ec7c-fa01-05ac-147fccb94fbf@scottdial.com>
 <ZOdUw66jbDWE8blF@hog>
 <76e055e9-5b2b-75b9-b545-cbdbc6ad2112@scottdial.com>
 <ZOxsAR42r8t3z0Dq@hog>
 <2d34e8a8-24c2-1781-2317-687bfcbeafda@scottdial.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2d34e8a8-24c2-1781-2317-687bfcbeafda@scottdial.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-08-28, 15:04:51 -0400, Scott Dial wrote:
> On 8/28/2023 5:42 AM, Sabrina Dubroca wrote:
> > 2023-08-24, 13:08:41 -0400, Scott Dial wrote:
> > > On 8/24/2023 9:01 AM, Sabrina Dubroca wrote:
> > > > 2023-08-23, 16:22:31 -0400, Scott Dial wrote:
> > > > > AES-NI's implementation of gcm(aes) requires the FPU, so if it's =
busy the
> > > > > decrypt gets stuck on the cryptd queue, but that queue is not
> > > > > order-preserving.
> > > >=20
> > > > It should be (per CPU [*]). The queue itself is a linked list, and =
if we
> > > > have requests on the queue we don't let new requests skip the queue=
.
> > >=20
> > > My apologies, I'll be the first to admit that I have not tracked all =
of the
> > > code changes to either the macsec driver or linux-crypto since I firs=
t made
> > > the commit. This comment that requests are queued forced me to review=
 the
> > > code again and it appears that the queueing issue was resolved in v5.=
2-rc1
> > > with commit 1661131a0479, so I no longer believe we need the
> > > CRYPTO_ALG_ASYNC since v5.2 and going forward.
> >=20
> > Are you sure about this? 1661131a0479 pre-dates your patch by over a
> > year.
> >=20
> > And AFAICT, that series only moved the existing FPU usable +
> > cryptd_aead_queued tests from AESNI's implementation of gcm(aes) to
> > common SIMD helpers.
>=20
> My original issue started with a RHEL7 system, so a backport of the macse=
c
> driver to the 3.10 kernel. I recall building newer kernels and reproducin=
g
> the issue, but I don't have my test setup anymore nor any meaningful note=
s
> that would indicate to me what kernels I tested. In any case, I didn't
> bisect when the queuing behavior was changed, and maybe I misread the cod=
e,
> and maybe my test setup was flawed in some other way.
>=20
> 1661131a0479 wasn't obviously just moving code to me, so I didn't trace b=
ack
> further, but looking at the longterm maintenance 4.x kernels, I can see t=
hat
> the AES-NI code has the same cryptd_aead_queued check

Yes, that's more what I meant. The check exists before and after
commits 1661131a0479 and 149e12252fb3.

(and FWIW, RHEL7 doesn't have it, but that's not a concern for netdev)

> so I think you are
> correct to say that you could revert my change on all of the maintenance
> kernels to restore the performance of MACsec w/ AES-NI.

Ok, thanks.

> Whether that causes any ordering regressions for any other crypto
> accelerations, I have no idea since it would require auditing a lot of
> crypto code.

Herbert, can we expect ASYNC implementations of gcm(aes) to maintain
ordering of completions wrt requests? For AESNI, the use of
cryptd_aead_queued() makes sure of that, but I don't know if other
implementations under drivers/crypto would have the same
guarantee.

[context: we're considering reverting commit ab046a5d4be4 ("net:
macsec: preserve ingress frame ordering"), but Scott is concerned that
the issue he saw would happen with other types of acceleration]

--=20
Sabrina


