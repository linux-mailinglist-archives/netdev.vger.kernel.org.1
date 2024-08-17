Return-Path: <netdev+bounces-119380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6A29555AD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D41C214F4
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953BF823DD;
	Sat, 17 Aug 2024 06:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XlSylA3r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0188B657
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723874401; cv=none; b=LAhHr2SzWX5D29PLMkCOYDG2FGe4Xvtk8YSRUSTLR9Qe8voZx3douC5segbrDtSyqdVHoRC5ZSLLumF/FIuMAX+XLBQBxiD6pJAl0AkrMJxVQpd6bKS3mnkcL/yQDQlNCwxibD3zLlclRJrV3y07Aq0o3Ryw0Sp0TwGsheFk5Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723874401; c=relaxed/simple;
	bh=ClHPL5sFncN7E0OsiY0aIvbGPHjjyoszpAlY1kCcHkw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gatvpEOpTw/lkd64xLj7g34wroVvAJtfdigbZ2wx/kvzkISRFdr3SZZtvX9RkHOgFELACAetSSTMu0ceNIA/nO4dBf1/2g7iiNeBw3YRUumBQDWyOnIrT1nSRdmB7IjWalKzSXrFNWxV1hjzQrdyVVg7pNbxiOOArxmmsa6MZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XlSylA3r; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723874397; x=1724133597;
	bh=7pUWwLsU9+xxEd0s1ULlFBXrr/hVoB7oCxsFR5yXLCs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XlSylA3rqzuJI2amuMLlDAMSUEedlY1hjz+dP8FcNF8GrkP2Glth8MBFeoMMJkRzT
	 90hFyoGp0uHNiJ4qZt9z5UyUKBwvGnnNKsqPg6B3E7ZCzOQGHI/O2xfX3yCv5p0gzv
	 ZiXtd31tSieFwP3KkxHT1+4Gf6/kZcJcSUkPWMv/ViRi7+oxbF41tVkW3ivwGKJlwy
	 ywP3gi0PRG+43QE0snzIMh1SL2WWBV0w5xV01nXlKzc7lGMFxdpjnAscrdIIFI15D6
	 1S3eAKgt7XlMwaC+x7CaRKj1Fivcu4LnLubTvBXczVNwTnfy5MEJ3uvwEkGiWJC4b1
	 9EWtmjAJx2Pig==
Date: Sat, 17 Aug 2024 05:59:52 +0000
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, miguel.ojeda.sandonis@gmail.com, aliceryhl@google.com
Subject: Re: [PATCH net-next v4 2/6] rust: net::phy support probe callback
Message-ID: <68f93bce-268c-472a-aa7d-fb5cf26bd210@proton.me>
In-Reply-To: <20240817051939.77735-3-fujita.tomonori@gmail.com>
References: <20240817051939.77735-1-fujita.tomonori@gmail.com> <20240817051939.77735-3-fujita.tomonori@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 77b2a9fc391323bab9bf1bb5164398e109c56bc6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.24 07:19, FUJITA Tomonori wrote:
> Support phy_driver probe callback, used to set up device-specific
> structures.
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/kernel/net/phy.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno


