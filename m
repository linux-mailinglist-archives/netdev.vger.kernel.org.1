Return-Path: <netdev+bounces-232071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A34C00945
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 12:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B101A02ABF
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 10:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300130B527;
	Thu, 23 Oct 2025 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frWti8oe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CC330ACF0
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 10:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216784; cv=none; b=dEDRDDxGkMhzbGsyYrjtsMWZmEZRKdx3AtQt3WGf5YpPxWSYPkjUgaJNPdsbJIKDlE0iX+aWtLDNoNY3dQR6Bxsu5MMHlRY5gAMaYFk91DZjQDs63WnTQwoelybmu2ohuboh2yiZ3orh7vp5eXT+Iybh/x9hfKJFYlFiVsw/gIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216784; c=relaxed/simple;
	bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krhAEZHY7ptX+joHE5ZbBly8cuQ+UUm6/jB80Z7h/mEgIiACt8q4go6ncv0QG5gFYOzGp0CxtLVtnFOduujubV+LjYStW18xIwo/71HYbedTjMPB9qH52oclGSASy6GTIjyoDMS0zRJOJ5+c+EmMAvg2PILKEnronSaThSaBQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frWti8oe; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42701b29a7eso344224f8f.0
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 03:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216779; x=1761821579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
        b=frWti8oeRBLu+QB6bESi/iuVYjSFqXMBUwngM/QfNOF/e3Ng1iNKsMJXQHBuypa2B8
         zpF5RBc8CR175HiU9jLzYLIZz9IXjGL3r3n0fPSwJuGUgb11GsYQ77bYUOczAu8Lrg3A
         PMb5rcR9NhLkCivvZJhr8sy5cGTi0zLNH6lSWgAbhYHWe+jPomKYPY+dCWcgttLYSKPc
         1muu8SIhdCkJYlcYpITu29QL2/ng1avo4uMNvD4Xfp4S60j4Kex2lPc3+O87fbxRIvgz
         dJuQ+ms/Y0+qonH80kIhtpGhPrjpR6iefBYv3T0tYa0lV3VucJMSWMmhO3UNl+Z4aw9N
         dLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216779; x=1761821579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vMUjxVk+nS+BilhYa3CMtB+EET0zgU8rBG6KfAsYNI=;
        b=diaBxdS3jx024zyic7SxCiFVUbHHGlXCvjnc4g/ijkrb8RJskGt7RQ1c3vYeYcxYYE
         xsGpqJpL91CM/4T0hQQXoKPIm/IAsC7jbEi7VtTvFNiyf+rQiZNDVy46HBNU0AvjO3SU
         QPPfAGPjlk03WC1FuTMkkMwjzvlUJV+s60c5RT+mX/7Z7FKJFcLDgxYb5dFYGfS4fdSW
         oUXrQkLEQfWEhRGLdkOEEm9Zw9cKHi9lvI0V395Xmw5872qmHehFVq1dF/9284DTJbQh
         vLWzikBc13tslHhdi0ChuJGm6vwnICLdlepebkheW7COWK2btT8x2fRGhe5xNoptyXde
         fnjw==
X-Forwarded-Encrypted: i=1; AJvYcCXpPwCewnqzAXeatEe1bahyM0rRAxwu7nRFg84l9IdMUPBgnwuvkpEpgeN+oMzpWZP49vViark=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFSMGP3mB6ZYBbeqdqqPNgGtN9XMyv3XSyUznTwPBY+kx3k6Kw
	WINCAkLv1A3EWE+JAvcmZbwT7nW4V2nyM6MmvijITDRWxk2KlQ+8OHMLbY7OS1XS2AekNYPMCUJ
	oNkXvIoIiNoPmdLhQt3+S4rV/WzxVLHQ=
X-Gm-Gg: ASbGncuenMS/SstWdWQ5C1yz0T258WHcBwXSFpqR7nYMlwRN7Xts8lFpn29CVeZAHas
	VzrFYyCXVQhWORhWwJmhbfLpbPj93w8HCXKWAye4//QKf1yLsZ3XUFsyMBuV5OBkdjTtII7nZPE
	755VQZr4CKhgccdsVzxCnEJOVBgi5Rli+aKiDziVW0x/tmzgkeRt2xqSEfvcExBIDNSZ1wBpqIg
	f2+2YvnWn33Y2MkTfDzkeHcl+/r8w/V3UwXI3vWObVf+NNINygMc0O/RuhCMg==
X-Google-Smtp-Source: AGHT+IEq+zNMHj9WPfjzhOgVqdeT8MY8s9ConstnjU+A+nm1h37hA1lLmbMQ890yX6bv5OV3H8gCIbax8AgydOiwcEc=
X-Received: by 2002:a05:6000:2312:b0:3e7:6424:1b47 with SMTP id
 ffacd0b85a97d-4285324c1ecmr5374774f8f.6.1761216779388; Thu, 23 Oct 2025
 03:52:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017151830.171062-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20251017151830.171062-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20251022181348.1e16df68@kernel.org>
In-Reply-To: <20251022181348.1e16df68@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 23 Oct 2025 11:52:33 +0100
X-Gm-Features: AWmQ_bkmX85GH1EUjJGjidbFOCdBNnjQxmkV7py__nnaP17JZzd2tI33jtRLgQg
Message-ID: <CA+V-a8un_DQdQcg+kQUs_HCRK15H-K3dW_yBtWXWzH9RMARJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] net: ravb: Allocate correct number of queues based
 on SoC support
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, 
	Paul Barker <paul@pbarker.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Mitsuhiro Kimura <mitsuhiro.kimura.kc@renesas.com>, netdev@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

Thank you for the review.

On Thu, Oct 23, 2025 at 2:13=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Oct 2025 16:18:28 +0100 Prabhakar wrote:
> > On SoCs that only support the best-effort queue and not the network
> > control queue, calling alloc_etherdev_mqs() with fixed values for
> > TX/RX queues is not appropriate. Use the nc_queues flag from the
> > per-SoC match data to determine whether the network control queue
> > is available, and fall back to a single TX/RX queue when it is not.
> > This ensures correct queue allocation across all supported SoCs.
>
> Same comment as on patch 1, what is the _real_ problem?
> Allocating a bit too much memory is not an stable-worthy issue.

Ok, I will drop the fixes tag and cc to stable and post it for net-next.

Cheers,
Prabhakar

