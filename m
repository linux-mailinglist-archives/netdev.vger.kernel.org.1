Return-Path: <netdev+bounces-37026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE0A7B3378
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 156EB1C209D1
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17411A5A3;
	Fri, 29 Sep 2023 13:20:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A031A5A6
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:20:15 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA036CC3
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 06:20:13 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-iSaAYYJJO06RazDCH-kyKA-1; Fri, 29 Sep 2023 09:20:10 -0400
X-MC-Unique: iSaAYYJJO06RazDCH-kyKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D45C78002B2;
	Fri, 29 Sep 2023 13:20:09 +0000 (UTC)
Received: from hog (unknown [10.45.225.122])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D4AB1005E29;
	Fri, 29 Sep 2023 13:20:07 +0000 (UTC)
Date: Fri, 29 Sep 2023 15:20:05 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Netdev <netdev@vger.kernel.org>, linux-snps-arc@lists.infradead.org,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined
 reference to `crypto_has_aead'
Message-ID: <ZRbPBdu0ZJ86juff@hog>
References: <CA+G9fYu2DKDxOEFTeJhH-r_JD8gR1gS8e4YsSrW3rfGegHR4Sg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+G9fYu2DKDxOEFTeJhH-r_JD8gR1gS8e4YsSrW3rfGegHR4Sg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
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

2023-09-29, 12:41:51 +0530, Naresh Kamboju wrote:
> The arc defconfig builds failed on Linux next from Sept 22.
>=20
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>=20
> Build log:
> -----------
> arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined reference
> to `crypto_has_aead'
> arc-elf32-ld: net/xfrm/xfrm_algo.o:(.rodata+0x24): undefined reference
> to `crypto_has_aead'
> make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:36: vmlinux] Error 1
> make[3]: Target '__default' not remade because of errors.

Use of crypto_has_aead was added to net/xfrm/xfrm_algo.c in commit
a1383e2ab102 ("ipsec: Stop using crypto_has_alg").

I guess the problem is that CONFIG_XFRM_ALGO doesn't select
CONFIG_CRYPTO_AEAD (or _AEAD2?), just CRYPTO_HASH and CRYPTO_SKCIPHER.

Herbert, does that seem reasonable?

-------- 8< --------
diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 3adf31a83a79..d7b16f2c23e9 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -15,6 +15,7 @@ config XFRM_ALGO
 =09tristate
 =09select XFRM
 =09select CRYPTO
+=09select CRYPTO_AEAD
 =09select CRYPTO_HASH
 =09select CRYPTO_SKCIPHER
=20

--=20
Sabrina


