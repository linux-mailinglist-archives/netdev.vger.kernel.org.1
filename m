Return-Path: <netdev+bounces-136652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6DC9A2969
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D0F1C269B3
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8C41DF98E;
	Thu, 17 Oct 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxDbWaMY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5EE1DEFE2;
	Thu, 17 Oct 2024 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183530; cv=none; b=Qv9PCAvqPlex1cNKCVcN2dXbmZZGKRHO0TfJUO+RLYDQqY34lOOFc0ZzzqKY5JIylm8iVsYoMQorpc4LpzzV/uFDfvK5YUKm7MKApGbhaBWBO1j+z9ESah+OMriPji8cBsIWmUgydn/yhlH1gchYQ+LD5NaUwA4mJqL0dx+iU3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183530; c=relaxed/simple;
	bh=mcCUzeXXlnqf/limPhOzfBMV01vv91GtjVpxLhxy9oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YC7nftq7I4VvVAmzBkw71bcKa7DPhOgIoskozOcXpkY64/SLMke5cdUkEQD7T8u2RaGM39y7h5yF4g8PEnVJPilOCuEMy1GFLKUuJYTvhT0QFYLlB0Cxim8yYLxYMqdRKq0T7QptC+b+cOuDdgpWFDtSieh1jVPrI2GlDa9HIlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxDbWaMY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e29497f11cso178302a91.2;
        Thu, 17 Oct 2024 09:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729183525; x=1729788325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcCUzeXXlnqf/limPhOzfBMV01vv91GtjVpxLhxy9oA=;
        b=VxDbWaMYHoPkxrwN735s0Cr7pKRaDjPI4wLrCkeEk9u2BGJiUvBwHzb9XT9Zotozkx
         nDqTH/lFtf5kNV1KXb2G9zoGcH1dqx6AaF7m548Jqxso3Kk+MGswVH6Y5fMw0K6RauTu
         sKR9deOHxVWcifN9y7d7VY3KVltWoDgHhCbExf1am/id5FSOLowfnFeptftSDYM8ssNg
         K7SUr5ZtP63266q/cwiazIiLnCV+7QdSu6N+CdbyhKFPFYIYd2o166quREpAVMwqdbal
         IT5iPPisUkUNHDmablBF27SRkqdQi7mhVmpCHNfzg4IFUHMEnwz6zW/V6yXEjmPeGKuG
         ZuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729183525; x=1729788325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcCUzeXXlnqf/limPhOzfBMV01vv91GtjVpxLhxy9oA=;
        b=clsWhPAXznEy0wymfxPTA5kY0vjeBKjBFc0KCkr7KIB7IAvmiP3ewhWFU1AQQD0CfW
         0Ed14Kdmo/dKdIwmhM51QSvTFsHRqH1iCxE8iBG5PmV/HWgIyF/2JAOBodMuSQcjJ+ap
         IXXJn/C1HITY3ioPZO+kNOmNRiV63gda/iNmDSELvSy+qjg/2ePwRPyuhIw5txQTlf+G
         2VwWLzbw03Kyh4Wz+DJbPwm4hbYxXWgAijrCswp4mDeUkCHj3GapeM6mDlBscU3hgGAN
         ymM3IPqgGE+u/iusWQ/4TQvOaUMGReP/Y8ETgjg7LAnEOi7zMNp2P6rTF9lcSsAF+RY+
         yC8g==
X-Forwarded-Encrypted: i=1; AJvYcCVG1wOk0k1YCSa7+vrmNhgyOhEMsmXCsRIJH5HXQBGVOzHLMlm1OF4y19pe5uCihsAmhbIZxinZAoJl/tY4qfQ=@vger.kernel.org, AJvYcCWP1IDPXnP3EXj3JFMuXWG6SfPe1Dl80oy00+2UwU3RP8UPdxkJpvoxwUAfzAtdIjXhQn+8JVtc577gu+c=@vger.kernel.org, AJvYcCXCN3lCfLEVXl/5AQPAAdXJ9q5r0jKiPDsPC+VTzJFB3lBPqdo/I/g+w/SSS9XWwr30lMdC1XWo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp0MjV7MTflgUkBROKPAwEJXwWSAbC4JW+raBSSm7MelVd9uu4
	FoRcfinS+98e+e/MfhJkg5ke9cDPMcrFqpFVMxtEEW5ZVnjF22lzXyOJb6vUxKuloebIJD/cmjR
	S80YecBCaRfJm+3i/Lch7wBsKpLd6VhyM
X-Google-Smtp-Source: AGHT+IEZ/ui/WWQTx0Ex+vbnYBARRrpyCEM94UWKhfXvnrgnk5ObXl96Hg+jcwk/C2LmKNJtaLaQdYsLROOoM7IM0lU=
X-Received: by 2002:a17:90b:1c8d:b0:2db:60b:eec with SMTP id
 98e67ed59e1d1-2e3dc294eb7mr2032178a91.7.1729183525086; Thu, 17 Oct 2024
 09:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com>
 <20241016035214.2229-4-fujita.tomonori@gmail.com> <CAH5fLgjKH_mQcAjwtAWAxnFYXvL6z24=Zcp-ou188-c=eQwPBw@mail.gmail.com>
 <20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
In-Reply-To: <20241017.161050.543382913045883751.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 17 Oct 2024 18:45:13 +0200
Message-ID: <CANiq72nGoT9DxLwDbg8gZVxk0ba=KqvXLAVz=hRNFMqtCeGNvg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] rust: time: Change output of Ktime's sub
 operation to Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com, 
	tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, jstultz@google.com, sboyd@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 9:11=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Surely, we could create both Delta and Instant. What is Ktime used
> for? Both can simply use bindings::ktime_t like the followings?

I think it may help having 2 (public) types, rather than reusing the
`Ktime` name for one of them, because people may associate several
concepts to `ktime_t` which is what they know already, but I would
suggest mentioning in the docs clearly that these maps to usecase
subsets of `ktime_t` (whether we mention or not that they are
supposed to be `ktime_t`s is another thing, even if they are).

Whether we have a third private type internally for `Ktime` or not
does not matter much, so whatever is best for implementation purposes.
And if we do have a private `Ktime`, I would avoid making it public
unless there is a good reason for doing so.

Cheers,
Miguel

