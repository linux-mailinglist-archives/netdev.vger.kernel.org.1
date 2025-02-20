Return-Path: <netdev+bounces-168010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC29A3D232
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8616326B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3341E7660;
	Thu, 20 Feb 2025 07:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="38RZC3hs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zGiCXFDl"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60C51E0B8A
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036421; cv=none; b=IQ+A8yLKKxrSD8bohLQ95J1+4r6iTxWwRup2ha+PlEJzLJBGKONNu6a5WAyPFlFNq2NlOIi8Nu77fiHZZgA4bc/lCA8EVIHrRPx6g2jI9k4yaHzbNtU/Go1onzmWh7u2O2hd/Y4ZFmkmjDE/pP/nX2R2qY+lOcsXPDmX3Xq2H/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036421; c=relaxed/simple;
	bh=VxMtNU8Y3oUv8bcEvYJRt88AK994Q1dtwsvdER1kUyY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ujyCISSfd2rNDRs4D4r2qc3C1fXISfUnzYfgEcAJM86HOJPg8cjrhI+ZaRma/8q9bdXJmCd/mYlsQ1QHzRp1O8dPBFacKmDtCdlPXisskLlHJEcgtScvcXe98anmrtdnuHZcadBdEVwZSgtDpg/QDuRHMdhAdLJ8uztjdhSkNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=38RZC3hs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zGiCXFDl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740036417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxMtNU8Y3oUv8bcEvYJRt88AK994Q1dtwsvdER1kUyY=;
	b=38RZC3hs4Nrz2lGYqsNpNOKSO33ADu3pcmP3zXEr0Ptx/3pIDr7tBpDgN0xK6g31Wtbehz
	jDjqxT11Z7YOV4pHaLC/AAa1i373Pn7MnlmV5YZCcfUCSRzJ+xnOOnlg6e5zcI3lPOg1ob
	JxoVGWg7pfr8miR6WgEM7/c5jNFOW3F2ExpG1GTkvvM7T6fJVweqhT32gNV2nec6FX0iBD
	/0ucQ/+BoEcU2Wwc/T/C2UR2/evrZswWa08oh8txsYEE1MLP5kPKsMyKzSkPkWn6u3kNWT
	ZnSxAv/QRc/IqKOHnlY82UEyfozZN0FWAfReyoxrY45dUkDOK9K25EnnNMpWsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740036417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VxMtNU8Y3oUv8bcEvYJRt88AK994Q1dtwsvdER1kUyY=;
	b=zGiCXFDlZSBgprSDd2hC1eDApS3z8E2SYytJk/t3Ic4NlaoC/F6m8BS2E/hVfWxJSBOHi6
	jeqDZx3sMC8LGCDA==
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com,
 stfomichev@gmail.com, petrm@nvidia.com, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v2 3/7] selftests: drv-net: add missing new
 line in xdp_helper
In-Reply-To: <20250219234956.520599-4-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
 <20250219234956.520599-4-kuba@kernel.org>
Date: Thu, 20 Feb 2025 08:26:55 +0100
Message-ID: <87jz9l3wlc.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Wed Feb 19 2025, Jakub Kicinski wrote:
> Kurt and Joe report missing new line at the end of Usage.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAme22T8THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvL5EACdj6JIFwM27AwltwWqq57MIpVBCu98
iWXdB2fnINdCKpYATeYscDqlKdzFD1aD9amLx6CI/KMmZKLwujvjHzjX8FxETs/a
NyUiOnXLZ8cZczmCmFuccy4SUplgOioDlTVBX4QabIt6vcmphBZHBMSUutJRqEIA
E21jrg+VBJe+oHSC4O/v1JSuYPxbaNyWVrhaCqSKeOv4YfdGd8Zw9fiIH75t7i8k
gqQL+WuudYGNlEK8fSkim83drx5hZdGnpa+7B/Z03F8A8qh6vHyDbvrRGhJHOtwS
kdRn8u1+eb44IaaXF5p05vlRzbWknl0hpllalXtwP9taWy7s92ZOSJFuLgcBN5hK
5NHe/PMVW0SFid0FW7i2KYBlYaUKidMC9yfq3bNqNCaGbdfDxInlMqOpHfBp1LSS
ZP1C2cZFZfsD8Zwa29VwWljOGvYAzbgz/iG8+WNZEypEBjkL3Mjpnn1M3sbErq/X
nMMqUgbtMqBT2Msgw6QBLpvf81WhtuYvNfecn/EIoKopjPrpCs9NKpPwcckwIuM1
3X8NOFHnjGwnrlHaDiml52sixxh3YDDAYyR/XgEmqcUhDSkM7UeD2wn/yatm2HDA
EFVEyFBUAK063n/nVU8Ps3RxyLHt1z/jkxQNiRpymRcmL8/hXesp4deFeiOAav0u
FN187gnB9PLZdA==
=WTRp
-----END PGP SIGNATURE-----
--=-=-=--

