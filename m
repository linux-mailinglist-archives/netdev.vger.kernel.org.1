Return-Path: <netdev+bounces-190709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07105AB8555
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 13:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072B38C59CC
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E9298987;
	Thu, 15 May 2025 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJfvRO6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB42298275;
	Thu, 15 May 2025 11:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747309887; cv=none; b=jtYheQbg6oAN4a6JpUojtGeLnXmOH+KXMBm8RHqS7zpMhvK+SNdsjP6ZOp5Gemab2uMqP+9UdS6/1PRkNiW4JL/NURLiCK4/hkBXgpqmG6BRFVDQQXFN49uC+BCm4LxE/0NSN0luK1tDmzCo5vOG6ba4PwnW69wo80s2mQnPUdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747309887; c=relaxed/simple;
	bh=Pn1x88vt8t8XfQnNFYh2BMvM4VJhxms399YKeJqiN9w=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7FgGXISuUpq13XxjQuTHI0K0RGz3S+Dvf4GRbFX+fNKidaBncxuI0h8+T1zdAPU0ysMBj3tnsMC2+idLgTqN/o2IosIxZ0t0HaYc9AntZb7K7ZkRphE1EG9U8BfttQ/4RomOKpEVJQ8rw5xNh7whPd9LEBzhn0ebpwewvq7SBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJfvRO6; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a1fb17a9beso453817f8f.3;
        Thu, 15 May 2025 04:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747309884; x=1747914684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9zmgkesflJuPhSQoDyK0piIEMqShbw1zJHD67ef6Uo0=;
        b=XQJfvRO6AnzpTSEq9C50jzQUU96DQfNvDM4lZMjJIvK/7CCA7pwQ11SkaZW2RmGJQK
         IVdbD+Z6lg/IVIK+ouaogggE+s8z/HTgVqf3aRX7IjYjjtpEh4h2hRMEqOfgqi+LDMFH
         fBlwhzg/YBbDVgvU6tmxbcQr72wDxOymGmiTJP3sGokrEKXxWdgxsZWAAsaDLxn6X0Qv
         +CDUuPJMD7eDBYzisKxKUCQ1OSXOThiijjNHzzJw+YYJrpuBSPK0UrUeDh2G/Ejk88ZM
         j6bSNeoLdk2mORm4GSccFEB13k2Hek6ZQ/6m/tKaGaYszGAlL3o6xtVdA97HpeZBGR2l
         Lv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747309884; x=1747914684;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zmgkesflJuPhSQoDyK0piIEMqShbw1zJHD67ef6Uo0=;
        b=UiHb9GQKc7hmFV0Y8JPfP8nql/WncT6eCpnibLL5ALOo0GKL2mU8sfdaJXbdSxHpcu
         F+Xr0neyHBQiPSbk/jqi6cV6Bxej0f0NqKGvD1cQCI8Lbhalwh43DuAcLjNe5qHEwo02
         oHM+TsyAE+Hfn5Ekzwm0pxir+Ei7NNRDuJHIiq9vM5In2s8oGd+uI+qJrPKZ7pBbnlPD
         jy2QV5GFFml5Yn0xtMj6HV/fqYhjde2Wk81ykrm7I0lP3p8pme0qwfkcTUqy8FAz7nLJ
         WN6II0GEecA9zEPfkSB3amaeQjRyH1LFEg4UqwXzoML+Z8f/W6rxVwDKMwglSYBKJ5dV
         eZ6g==
X-Forwarded-Encrypted: i=1; AJvYcCWg4+SWjXGKFHo0E4uKbioX7m2yupIwO3Is8GMoisrAyE6FE7Lknb1MLktx/ADvfzqskvjGVif4@vger.kernel.org, AJvYcCX+yo+lNhKE6H7PAj025EtT60aEwfFoCbC5uLuyOulUQ9ONDnYK9TZqYXpqmR9BLXcskOmcMRyYph71X2l6zZo=@vger.kernel.org, AJvYcCXm/teM+qFVD4VfZy36p5prADvDiVkAOTZznsU6iQNG5aLCx9Pk8hYFiXY4mkK7D8TVKNwEFE8vxgFAo/dJ@vger.kernel.org, AJvYcCXpRH+sASS7g8Y+/HZsBcUTIPvCaJSYpXapVD1yYmpbtC6PbjfFzYPWXUhHNy5ng0QxX8J4IlQe8x5H@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XLH2EcqYtgrm348tql/H+XZrv4XRMvlsJV/DXufYgK2XptSD
	yzNOnmiB4YuKyIgImgGuagjHaVBvvf3eA9ceNaSOoqoKK0jLgXFD
X-Gm-Gg: ASbGncuDKp4zZiCQq8vaC0e5lQqKjfDu1q3LrEQkqT5tym2Yq5cyI6/zU1FfzDAJ/zs
	4VXnVEN87Eajs8+NWHUAdEqPuFkYcst0W6as+v99kX8iyAqE8I5YkVpPeuGIx99jTgF8zCScJsl
	A4iWUn4wH9yX9UV1uaAiEK+dRHj4XbV7Rj3U6M44X5KGVxmB/rj8jFpTnk18QAFUMlHS3hHpcgy
	UQ0IMC6Rx9jerI/V2kudrP+2a9Dd8fd/79NLf6KbvceOujlK71GVPf38MgrgoOLYItlhvp/vj6i
	XVy3sxQWKvo+LqjnDGrni/JhijcflGkUqYLd2EB4EJirIggFlrs0vDw/qchyeUV0jopATKYxaUs
	SuNgsFV0=
X-Google-Smtp-Source: AGHT+IF3jsOfCZneijOp46ln4kPwgCR9XEGZEt5wYBYyy5vj+5Nx02qSVZ0ccOg63iO5n6plZVjWvg==
X-Received: by 2002:a05:6000:3103:b0:3a1:f537:9064 with SMTP id ffacd0b85a97d-3a3496c0063mr6676871f8f.25.1747309883581;
        Thu, 15 May 2025 04:51:23 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc2esm23060948f8f.90.2025.05.15.04.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 04:51:23 -0700 (PDT)
Message-ID: <6825d53b.df0a0220.36755a.ca22@mx.google.com>
X-Google-Original-Message-ID: <aCXVOBnQUc8WkzbM@Ansuel-XPS.>
Date: Thu, 15 May 2025 13:51:20 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Andrei Botila <andrei.botila@oss.nxp.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Trevor Gross <tmgross@umich.edu>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Michael Klein <michael@fossekall.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [net-next PATCH v10 7/7] rust: net::phy sync with
 match_phy_device C changes
References: <20250515112721.19323-1-ansuelsmth@gmail.com>
 <20250515112721.19323-8-ansuelsmth@gmail.com>
 <D9WPMD7Q4XRN.32LF8UDPK1IBI@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9WPMD7Q4XRN.32LF8UDPK1IBI@kernel.org>

On Thu, May 15, 2025 at 01:49:35PM +0200, Benno Lossin wrote:
> On Thu May 15, 2025 at 1:27 PM CEST, Christian Marangi wrote:
> > Sync match_phy_device callback wrapper in net:phy rust with the C
> > changes where match_phy_device also provide the passed PHY driver.
> >
> > As explained in the C commit, this is useful for match_phy_device to
> > access the PHY ID defined in the PHY driver permitting more generalized
> > functions.
> >
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  rust/kernel/net/phy.rs | 26 +++++++++++++++++++++++---
> >  1 file changed, 23 insertions(+), 3 deletions(-)
> 
> You probably should do this in the same commit as the C changes,
> otherwise the in-between commits will error.
> 

You are right, I will fix this in v11 but I would really want to know if
the Rust changes are correct. It's not my main language so it's all
discovering new stuff :D

-- 
	Ansuel

