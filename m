Return-Path: <netdev+bounces-138184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C73219AC867
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 12:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A67B22EB2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C311A4F22;
	Wed, 23 Oct 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEJwya1L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DB19DFAC;
	Wed, 23 Oct 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729681160; cv=none; b=GRRzdVgMrd/pMe4pWkWvmqru5D2r7BsBCs6PvL47aCgkSPQfE4hXg+qBp9YdbWHeH+0hYMh+R4EB0mEY7a9Z35XUeSiguRZPG9NyeqC64wfYPRWuZ/8t5EwHbex8ugIkE6ys+sAWJhpyzRjJKT/2k2WqGAJm9CJFXPlck1XG4+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729681160; c=relaxed/simple;
	bh=dQn3QKooFfpkED5AWgQUsidsNUhCz5rbmLpHrgZVl3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSh83b9nEgggmZDc9trlRimF3QknQJCRa5oToLjr2Xqlwj3EoU8naEAQLlLo2H0drBY4mir5LPNdQOPCY6l2idyq/gwhvdC7YYdyIjKJza2BxgNL68CnFxVjndWcA8ux/mb76Ra9Be2GKizXqa9fbi/diiWbpiXMPbLs9HswVJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEJwya1L; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso1274354a91.2;
        Wed, 23 Oct 2024 03:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729681158; x=1730285958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQn3QKooFfpkED5AWgQUsidsNUhCz5rbmLpHrgZVl3w=;
        b=UEJwya1L3oTNJQlsVK4/YDCffLxerD8YTC6pX5l1c1nH1kRPYnMXwKaiU+HJ2PshhX
         YKHZ4YoHPo5jAHo40gp9NrvX7gc2gQ1qISaL63CMaNeHM99IXI78iL5O0824BVcQYGHe
         13f5z9tW/hpz6jchO+c7BrHfGRuMP84HbIdFPNyRAMwtOygBBN9O+bN9Scth8E1Y+1mU
         4p5+YoIh4lkK842YVSwKR9sOnHp/Khhcv11vAxJisjY3AI0lXosmfU2I0T5cU6u0IXZ+
         QMM+ZF3XEg46oj/2TRr/g+lCDX5IpAIwiNNFb++fUTsxJ+Vmqvi73wq3Cjp3M355EamP
         qvqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729681158; x=1730285958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQn3QKooFfpkED5AWgQUsidsNUhCz5rbmLpHrgZVl3w=;
        b=OmpITayMuUrwrateU7zYkC71JEzvoGNs2nNbTNTB9zkuLTuMDxIH7Sg7lYotiLaVWl
         ceJaRGh5XGZa/D+a3WcKZg9/g0bXc3DOotOIC5rGfcH1G6QaxKWfUuiZQU9gFFXaibhH
         +PdwtwkD/0a2OVgqfTR//3BMzcpHLkWFRxx5CySx6YgW6Dq35MZlL8QPG4dvRnchQOjd
         eSglV+g4s93fp3sipEzB47GjY1GSGkvEPpOq75WLv5FGFzZR9LEcEz+4MR/NcZc/6OBD
         tmND8R2qjnUIEW3mxprVYA3rv8gNDTobMYL4qE5faVmXCct0pH/z2u4bb1ijf7V7cPAB
         uhbw==
X-Forwarded-Encrypted: i=1; AJvYcCU8opolXf6ew8Bx0nxrHru5aK0JfKCI1Py766zd/yfVz7PqejgNxfT+luCez80NpUzjVfA2hGZNcTaq7uw=@vger.kernel.org, AJvYcCUNPjc7WL8eSka0/AQ9Phq1+v7CMyGnruAUfi5HIoc5B5QKGt9Yhkk8d7VMfN/nFlKIRGoRf3rBYKbC8wuXF6E=@vger.kernel.org, AJvYcCUqzhsPEsetpbeGlUCEesmEXksCnVKGd527DomHb4z2TfDB5sxfK62CLT+2GUbYURZszOmhCOXx@vger.kernel.org
X-Gm-Message-State: AOJu0YzZzB3NvWEs6pXj/Zv0hQ5AcB77omhd/eTSYNCfc0JpY0GN1l6w
	v7Aj1LRERZLxZyywiKNJtfTbh6asJKONlDDnP8NH6L1eyQ/ACoMbHVvjcOFiDMHSDAxhVB3R5v5
	BKlwKoE9loDfN3RzBXHalh24+rqCjB+254DA=
X-Google-Smtp-Source: AGHT+IFO30ySqoMpYk7KKeOKqHfToaE9f7OcJTdBgyaCFCvOpkXkDtsvH7hgHzCdhYCHCR/4zVmRh5PtA0mhxdiLLlI=
X-Received: by 2002:a17:90b:4a83:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e76b6c3194mr984364a91.4.1729681156711; Wed, 23 Oct 2024
 03:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxAZ36EUKapnp-Fk@Boquns-Mac-mini.local> <20241017.183141.1257175603297746364.fujita.tomonori@gmail.com>
 <CANiq72mbWVVCA_EjV_7DtMYHH_RF9P9Br=sRdyLtPFkythST1w@mail.gmail.com> <20241023.155102.880821493029416131.fujita.tomonori@gmail.com>
In-Reply-To: <20241023.155102.880821493029416131.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 23 Oct 2024 12:59:03 +0200
Message-ID: <CANiq72nvMAMff7Oar-UCvajZ-sP4XdE9vNGW49L9CMsRzSTwCQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 8:51=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Can we add the above to Documentation/rust/coding-guidelines.rst?

Sounds good to me -- I will send a patch.

Just to confirm, do you mean the whole operators overloading guideline
that I mentioned elsewhere and what semantics the arithmetic operators
should have (i.e.to avoid having to repeatedly document why operator
do "not supposed to wrap" and why we relegate saturating/wrapping/...
to methods), or something else?

Thanks!

Cheers,
Miguel

