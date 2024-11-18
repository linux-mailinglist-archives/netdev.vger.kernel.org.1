Return-Path: <netdev+bounces-145707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D92439D0766
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 02:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921711F22794
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 01:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E1F1BC20;
	Mon, 18 Nov 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b="jwURfuKy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6161BC3F
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892327; cv=none; b=YU4+TpEMInMsPoIx34oinbpp0mJT5lxxuVKi5wKckKyke13E+Zd4MkzTm1Mj2MWXTASL9CUDaoR98gjON0aZ7JfPsN0koNqyneW+/1q8HgIhwzUoeFgrdHZ2O0QHaYqXHhwOgeFb5Rh8QZOcbr92sc+GLFWztEWa6jhFmdg42HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892327; c=relaxed/simple;
	bh=8jguRpTCIFX5X4hwFVJsZtjemrkZFYD9SjCUJnKItdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUCBm8GXYaPAYVOtrpkWwYmmy/fV2uq6yUgNg54oiEtJlfZM8glbxuzi+W15nWdv6hopI0tEtdsgQoDkicSHdohUrZH/e8ADYFEfRvQqBjmneASs6Veo72+5LIP/Ef2oFxI4BsSY3Z1aafd2fIAhvJKgooaYGIPDKLJwx5lLVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in; spf=pass smtp.mailfrom=iiitd.ac.in; dkim=pass (1024-bit key) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.b=jwURfuKy; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c6f492d2dso13339365ad.0
        for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1731892324; x=1732497124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7XycAloiFoCMfmssnZcbAgPsNHHq3RcS44NRT2jaAI=;
        b=jwURfuKyWIi6U7Qg3dWQM3pz/EMpp/6U7KmIKnqOoSnY4YGIkuJefT5TNyrVWMcel1
         9vF3amvSz35vkJtufx8Y13SQzgwcrxtGSho47dupVvsDvyaphQ/8SlawbVzwrdu1+MzW
         OL5D6xgxScKgSyG8L0jD5ptijFHmCpVm27eNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731892324; x=1732497124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7XycAloiFoCMfmssnZcbAgPsNHHq3RcS44NRT2jaAI=;
        b=gX/e8yMH+s7c7eIk+MJcKu5NrePPa9nHPgX/wFRr9mYiGgwkmvsJP3FG11OqzPrhva
         h92lJ/aOC0EDvOjyeIkFNMeWzSgsdttYjvuxSQCAKmQigMo47Fek6PygNI1wdRRxX/Jz
         LdwfwLVtGep1C2UcP2GVCd0SAoial8xZeNPqX1n4QkuTNhUzIVEsTm/KlkVIAOHI1m3+
         np8YHLrtpFmwafxHaMIySvWlLg9FCbojCXsvLdCZmVRGLknkfLNWn9rUiD3SE5ewooW4
         0qyuqdKEbrsjsMnM+ppmgblovrhokJqTs3H42i/Z9aawqd+zkjhzyFpLxTIYRWCwTHLe
         06Mw==
X-Forwarded-Encrypted: i=1; AJvYcCUPKbOdxv/EF78FlJINuKC1rlspch81jCjbrH2bJ/SDdw6Pj3rBKnNehJUiQMSvX4PSyK5PaTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyykNiLt6RUDPLanXGz6YcK37Mtds4gJ11E1/cSIoR0J3fkB7yT
	ridAWhA22MG4BlzCNYFLFIwHBRiHAe/9/7ZaBRS0PZlsPvozZF1ci5am8/I1eso=
X-Google-Smtp-Source: AGHT+IHRSOFCwCSJbllUPYVx/zvEltTAQTSkv822oSEiRkDjFOTOd3vI//iN+/Xz+fTAre/iOFBDmw==
X-Received: by 2002:a17:903:22c4:b0:20b:861a:25c7 with SMTP id d9443c01a7336-211d0f1183dmr149393135ad.54.1731892323798;
        Sun, 17 Nov 2024 17:12:03 -0800 (PST)
Received: from fedora ([103.3.204.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea5fe3e689sm1449857a91.6.2024.11.17.17.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 17:12:03 -0800 (PST)
Date: Mon, 18 Nov 2024 06:41:50 +0530
From: Manas <manas18244@iiitd.ac.in>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Anup Sharma <anupnewsmail@gmail.com>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] rust: simplify Result<()> uses
Message-ID: <5qtqdzljvzly5onzhfdq63fzcqcj26ybktm2cgomijpnfnyrbj@ln2kbp73csf6>
References: <20241117-simplify-result-v1-1-5b01bd230a6b@iiitd.ac.in>
 <3721a7b2-4a8f-478c-bbeb-fdf22ded44c9@lunn.ch>
 <CANiq72kk0gsC8gohDT9aqY6r4E+pxNC6=+v8hZqthbaqzrFhLg@mail.gmail.com>
 <q5xmd3g65jr4lmnio72pcpmkmvlha3u2q3fohe2wxlclw64adv@wjon44dqnn7e>
 <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CANiq72kQJw4=qBEPwykrWBsqmycwS+mR27OE2dTPQd3tKjx-Tw@mail.gmail.com>

On 18.11.2024 01:54, Miguel Ojeda wrote:
>By the way, for the purposes of the Signed-off-by, is "Manas" a "known
>identity" (please see [1])?
>
>[1] https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
>
Yes.

-- 
Manas

