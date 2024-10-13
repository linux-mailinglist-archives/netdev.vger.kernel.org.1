Return-Path: <netdev+bounces-134919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E978999B8FB
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 11:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D66A1C20C35
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 09:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357CB13B590;
	Sun, 13 Oct 2024 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bM29k5wV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7522907;
	Sun, 13 Oct 2024 09:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728812901; cv=none; b=MzkcnlA8VhZvXSMW6+b9jZzHNSvuskyMig5jrDslQw1P4g3U+CFJCzqie5nwQYLQRJNq/BqfIgmEct74rm0Vy1ht9bEbJy450e29Ol4UfxYIE4IX64mGKsd1D7dpXUVMEjm5XLfSoanUEcuGcWYc3/DAxZaahWjCk+eDKQwQ4Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728812901; c=relaxed/simple;
	bh=lq/opFnvxZGVI7pWJkWGv6eRRNGzujrS1QRDQCBJkTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X+pNHWQV6bvDFyBFkB0uVhhMNiqPWSxAX5vjqKD8lb7rwTWWzhHMv8+8GY6Rl/wtvzVX18TKtvpFugcnF3EPMfAUqrw+qlcUynarLxCD60j0KXmzM9CRhQi9OuTo0PIMo7IidQvVR9Sxnuyj1Mp5quxvyIO52uf3GLOdAA910Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bM29k5wV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so574183a91.1;
        Sun, 13 Oct 2024 02:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728812898; x=1729417698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lq/opFnvxZGVI7pWJkWGv6eRRNGzujrS1QRDQCBJkTg=;
        b=bM29k5wV5dXmmr4SZycJDBwodmjiO8Mhom1L0oX6vh8VilJbKuZcSL5hTSFD0ETIkc
         tqHyW5EG/S2tNTuLDl/81oceMyKIa97NebOg1D4Px/56VZM4XkbGDJGm6ShUtEjdAqhE
         dF50/quB35rBYCcn9UHFtQlIkXEf6J6/eBSX7BP3UGyUuGpQWoSqMP8RmfFLlEtsqRRL
         xGl5rQ6it7VcMkhSqHW7xBkyrjrPGRZNwbZXBwgT1/BGknuZzGdz2RdzvMvu9omAEGnZ
         KpnQ9n5kCZ/PWOPKSB+pZbMX2ixOHjNwhcmQ5pKRDEDaUnF+wasrco9CbkJfF7K/GW7f
         ZR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728812898; x=1729417698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lq/opFnvxZGVI7pWJkWGv6eRRNGzujrS1QRDQCBJkTg=;
        b=bsbwz+GyR/nRmz4GpOKXDj+1XUfCQXddZiUoQcMoEh3Z/OboEltwh7NhGqdHDAm2kO
         bmoEJPMlzJ9thmlrWCcy3pC3EQn5m2yYx5K2E/ype9BqIXEF0SVLFe7uxKuoCN7p8Qrv
         DtSST8GYE+lNaUTuEkWLhsQT4W5/T5ZJ7mJcvTJ4nRxUac1CJswCJ2xYKRMreWlpDAdT
         6V+YeJp1eMG1RDIkdH8F6EmJEQ+0IouM4BF4HQISB6m1l2A5Z1e8+0Vx+xOeyX4Ro9TG
         zq9Q5y0Mp6t/MEseSsks4M/qUpUj5s+sn/zauEFjOBHyfxpU0T0Mmd9UNlCCvByqxa5E
         C0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYeuJpdgPhDpypJLe61WCCjAIZM9aVSovX5yLcDbpPuUFS5cc4CMEKmH5ZG4RgRg14q8m+O4pRm6sQzSJqYBg=@vger.kernel.org, AJvYcCVkY6dAXtuTmDxRw6MjyN2mwqgGDhB8UM3MC72/0RKCOlAm3a8jg3pnswNyeFEZUvDRG+AJUjdq@vger.kernel.org, AJvYcCXRsuftgKQIYUs+xlOy9HOhB9t63Q8gK/YpOf+I19L7QA7xWgPDZUyRbkpa57oOq0QRMc+2xabbaFw95TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSYnf36R5yvtBbBuFzN6IF2S340lu8GKYxsIYuUkdLtIFJRBQO
	LLabjG/LRJ5mVwviyPJsT8t0YBswORSkBWneiKVFZ+4zWKi1LCCCqRLFOTYfYM0ylEnXfop/oC0
	7utcvrQFD6gLFNp0Y50n46Ed+f0s=
X-Google-Smtp-Source: AGHT+IFTWgyck+SK903gIAugnj/pVYE/NlAxOB3/1UrP2RXy7SFep7yMJ9rsMP+xGfsD1Ry3RHH55vn4NwwQ6lUiGAk=
X-Received: by 2002:a05:6a21:6d8a:b0:1cf:308f:f87b with SMTP id
 adf61e73a8af0-1d8bcf9bb16mr6126576637.4.1728812898013; Sun, 13 Oct 2024
 02:48:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013.101505.2305788717444047197.fujita.tomonori@gmail.com>
 <20241013.115033.709062352209779601.fujita.tomonori@gmail.com>
 <Zws7nK549LWOccEj@Boquns-Mac-mini.local> <20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>
In-Reply-To: <20241013.141506.1304316759533641692.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 13 Oct 2024 11:48:04 +0200
Message-ID: <CANiq72=yW6rHSjRS_bDveeq+qm4xwitDLhP4KThQoQGXZzC8BA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/6] rust: Add IO polling
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	aliceryhl@google.com, anna-maria@linutronix.de, frederic@kernel.org, 
	tglx@linutronix.de, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	jstultz@google.com, sboyd@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 7:15=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Seems that I misunderstood. The plan for the future layout is
> documented somewhere?

Not yet, but I think either would be fine.

Cheers,
Miguel

