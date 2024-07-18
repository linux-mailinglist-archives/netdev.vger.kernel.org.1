Return-Path: <netdev+bounces-112127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DD2935242
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EDB52833A1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE831448EE;
	Thu, 18 Jul 2024 19:48:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D311459E4;
	Thu, 18 Jul 2024 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721332115; cv=none; b=G78aDozr2CPLuorfSdTe3zvUacGBomwN46Tp08pFrHxd60BOxbWTa11UU88AbwYxYOy68LOj4oObD4zBZR2bsxHdSIVQ0bwh4EczT3TdQlgWn/KBQYYIjiCAyRmWzHgm0RlaoHta+RKpTyeRyLlmikV63MHMkhzo1xqtZeylrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721332115; c=relaxed/simple;
	bh=y9CFX7lS8m59Vz8H8XZtfuqVB1PPYP2PBFkuP8DaW8Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K2AQZKZ3xUJ70xRxR/UWFtVdx9KiAyi6LM/VD+3fv6WBeXb7BTQvpGehNsUvTbEwtNSSZaKgwmfocozmzPUBC85MtnZthnK0pjBZRhC1kVr+w9EP8MDmO2AdsKRdxaCI5lbBJKP84w7Z9uYIqsRTyFNIHI74ON93JjxBML4eCvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:6e0b:84ff:fee2:98bb] (helo=imladris.surriel.com)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1sUX6N-0000000006w-3EaI;
	Thu, 18 Jul 2024 15:47:43 -0400
Message-ID: <ff42f723b718c7ac8aee992ba0719cb56910ebe3.camel@surriel.com>
Subject: Re: [RFC PATCH 1/2] netpoll: extract core of netpoll_cleanup
From: Rik van Riel <riel@surriel.com>
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
Cc: thepacketgeek@gmail.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, paulmck@kernel.org, davej@codemonkey.org.uk
Date: Thu, 18 Jul 2024 15:47:43 -0400
In-Reply-To: <20240718184311.3950526-2-leitao@debian.org>
References: <20240718184311.3950526-1-leitao@debian.org>
	 <20240718184311.3950526-2-leitao@debian.org>
Autocrypt: addr=riel@surriel.com; prefer-encrypt=mutual;
 keydata=mQENBFIt3aUBCADCK0LicyCYyMa0E1lodCDUBf6G+6C5UXKG1jEYwQu49cc/gUBTTk33Aeo2hjn4JinVaPF3zfZprnKMEGGv4dHvEOCPWiNhlz5RtqH3SKJllq2dpeMS9RqbMvDA36rlJIIo47Z/nl6IA8MDhSqyqdnTY8z7LnQHqq16jAqwo7Ll9qALXz4yG1ZdSCmo80VPetBZZPw7WMjo+1hByv/lvdFnLfiQ52tayuuC1r9x2qZ/SYWd2M4p/f5CLmvG9UcnkbYFsKWz8bwOBWKg1PQcaYHLx06sHGdYdIDaeVvkIfMFwAprSo5EFU+aes2VB2ZjugOTbkkW2aPSWTRsBhPHhV6dABEBAAG0HlJpayB2YW4gUmllbCA8cmllbEByZWRoYXQuY29tPokBHwQwAQIACQUCW5LcVgIdIAAKCRDOed6ShMTeg05SB/986ogEgdq4byrtaBQKFg5LWfd8e+h+QzLOg/T8mSS3dJzFXe5JBOfvYg7Bj47xXi9I5sM+I9Lu9+1XVb/r2rGJrU1DwA09TnmyFtK76bgMF0sBEh1ECILYNQTEIemzNFwOWLZZlEhZFRJsZyX+mtEp/WQIygHVWjwuP69VJw+fPQvLOGn4j8W9QXuvhha7u1QJ7mYx4dLGHrZlHdwDsqpvWsW+3rsIqs1BBe5/Itz9o6y9gLNtQzwmSDioV8KhF85VmYInslhv5tUtMEppfdTLyX4SUKh8ftNIVmH9mXyRCZclSoa6IMd635Jq1Pj2/Lp64tOzSvN5Y9zaiCc5FucXtB9SaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+iQE+BBMBAgAoBQJSLd2lAhsjBQkSzAMABgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRDOed6ShMTeg4PpB/0ZivKYFt0LaB22ssWUrBoeNWCP1NY/lkq2QbPhR3agLB7ZXI97PF2z/5QD9Fuy/FD/j
	ddPxKRTvFCtHcEzTOcFjBmf52uqgt3U40H9GM++0IM0yHusd9EzlaWsbp09vsAV2DwdqS69x9RPbvE/NefO5subhocH76okcF/aQiQ+oj2j6LJZGBJBVigOHg+4zyzdDgKM+jp0bvDI51KQ4XfxV593OhvkS3z3FPx0CE7l62WhWrieHyBblqvkTYgJ6dq4bsYpqxxGJOkQ47WpEUx6onH+rImWmPJbSYGhwBzTo0MmG1Nb1qGPG+mTrSmJjDRxrwf1zjmYqQreWVSFEt26tBpSaWsgdmFuIFJpZWwgPHJpZWxAZmIuY29tPokBPgQTAQIAKAUCW5LbiAIbIwUJEswDAAYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQznnekoTE3oOUEQgAsrGxjTC1bGtZyuvyQPcXclap11Ogib6rQywGYu6/Mnkbd6hbyY3wpdyQii/cas2S44NcQj8HkGv91JLVE24/Wt0gITPCH3rLVJJDGQxprHTVDs1t1RAbsbp0XTksZPCNWDGYIBo2aHDwErhIomYQ0Xluo1WBtH/UmHgirHvclsou1Ks9jyTxiPyUKRfae7GNOFiX99+ZlB27P3t8CjtSO831Ij0IpQrfooZ21YVlUKw0Wy6Ll8EyefyrEYSh8KTm8dQj4O7xxvdg865TLeLpho5PwDRF+/mR3qi8CdGbkEc4pYZQO8UDXUN4S+pe0aTeTqlYw8rRHWF9TnvtpcNzZw==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Thu, 2024-07-18 at 11:43 -0700, Breno Leitao wrote:
> Extract the core part of netpoll_cleanup(), so, it could be called
> from
> a caller that has the rtnl lock already.
>=20
> Netconsole uses this in a weird way right now:
>=20
> 	__netpoll_cleanup(&nt->np);
> 	spin_lock_irqsave(&target_list_lock, flags);
> 	netdev_put(nt->np.dev, &nt->np.dev_tracker);
> 	nt->np.dev =3D NULL;
> 	nt->enabled =3D false;
>=20
> This will be replaced by do_netpoll_cleanup() as the locking
> situation
> is overhauled.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Rik van Riel <riel@surriel.com>

--=20
All Rights Reversed.

