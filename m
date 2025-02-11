Return-Path: <netdev+bounces-165192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD6DA30E30
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC0E162A80
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880C424E4CF;
	Tue, 11 Feb 2025 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Y512ZHj3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36D41F4E41
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739284042; cv=none; b=CZq6B+xqjnpMZ+p8UPt0ENYRzsC1jW8Wnk5tahwVicY9Nb9zA/6SmwibQxmfRtXpnkZlKh7XSky8iNwl8+jqxr0RiBf2ViJH+qpgH73FdlBfUlhEFhs95MFfP6lj+H/ryuo1h0TP3F3ov3CpPpH+iSrYLXeUfms1079GVTiLeRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739284042; c=relaxed/simple;
	bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p/oMDK1N+Y1i2/0LbRhaccBsYj3RVV/6HvnKWeswR9ckY+oAVcebhP/WYrMDZGV9qiYlZIrFQNkw3Kas2uG34m8d7C+bhZ6lkzOK3vwIConl0BUNtt+lIUeNXnIOb7hE9bla7337YRtWbz9ZIqVcQQr79Qggx3nduVRlheHmJb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Y512ZHj3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so17608705e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739284039; x=1739888839; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
        b=Y512ZHj3qYlOWzZxZSE41D3b5CBN0+Pdng2iCT6szcLj0NAsa0+a4Z7TrFXSdeYscf
         nz4D9z/j5lDD25RJGpggp28WUJavwEToCPb6cx/Fk9SpnR7Bq6I2cVyFXyKphHvOj+0H
         wNtDCEaWFn3nnJq1jdHIvHAFX2UlIFC/BtzqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739284039; x=1739888839;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnXsRvx0qvVPqkiqQcEbMTmrC4zDv2zOi5HZ3TdtuVM=;
        b=jPECslMmLWjxQY6xTEA4w5VVoKSLfjbaUL83AXjSIyElRAeJR+87y/4/P3RCz5ESvY
         A+KYkeQeJRB02yoOow/vpLNcsI2kJw7WzdCppTtBFsWQsZiwoO/6NRpoF+Q9bQYnc/8T
         r2giUp3k50JotbgVvNigtQL+wooTx9mLh3wxyncypup6UvfrBsrXn0qIN+lSN7cRAcQD
         9ona9QFvVeI9GCClh7++GvVxCS7WyUa7thvQIBA8VsosHJLSIqRyRe45C2Qc3U4yY24j
         4oUnMQMJtmAtqx8RJz4d6aL06yMYv0+hZkrJwOaO8c+ZkIwmJaELWEgsvZc6dKneKfN1
         p5FA==
X-Forwarded-Encrypted: i=1; AJvYcCVm92npJn4CcWW1JM45pNwT9YVmc+T3CH+hNIHVWmpsaNwJLBe/KrXZabV/Ak9pwCkS4NUruqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7SGoj5ymw+oDLaLBjCSjR+QoE45Dp255Qux06Wlz35pMGf/lV
	s6VLhlGLG2xKV3VlHX2l5knid/MI+YudnDPWxSSmBW70cTjR0+rhEYASV95liZfRiuyhjy/Dha8
	MCiDSV93WfqbVIjZrAWsQ7mzjwJ740inOei1X
X-Gm-Gg: ASbGncsaVjDXs8eVH7OK+0pNXn3mmf8D8mxaV+fHCL+ZvoDY3n1YJLYCMzE+2owop0N
	CVo53tOHlxv8HWbPuSS/O5eY9+npw2ZEdsbk6gNylLXpmft3YB5t4d6082OOp6CcH84myNgBq1Q
	==
X-Google-Smtp-Source: AGHT+IFW7u3ksUwAMmyoe75NSXKQw3EDTiEgPEkojwwD1QDJJuhHYXuBrsR8LCMPEx+0bgTRETrP9rJoVdQsTMQzrYE=
X-Received: by 2002:a05:600c:1c9c:b0:434:a929:42bb with SMTP id
 5b1f17b1804b1-4394c82a79cmr38871705e9.18.1739284038988; Tue, 11 Feb 2025
 06:27:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com> <10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
 <20250206164449.52b2dfef@kernel.org> <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org> <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org> <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org> <20250211075553.GF17863@unreal>
In-Reply-To: <20250211075553.GF17863@unreal>
From: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Date: Tue, 11 Feb 2025 09:27:08 -0500
X-Gm-Features: AWEUYZm-CIvbNlYRQ_mzQIY1n8Q1iLl7J8dNt2g_9kIBamNTxj7FCsKs0Luw5rc
Message-ID: <CACDg6nWiSbBV=Ls=Rts=vsx0V7pKHX0ZztbKJL_UM0+u34uiZg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>, 
	Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	"Nelson, Shannon" <shannon.nelson@amd.com>, Michael Chan <michael.chan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 2:55=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Mon, Feb 10, 2025 at 05:04:23PM -0800, Jakub Kicinski wrote:
> > On Fri, 7 Feb 2025 21:16:47 -0400 Jason Gunthorpe wrote:
> > > On Fri, Feb 07, 2025 at 01:51:11PM -0800, Jakub Kicinski wrote:
> > >
> > > > But if you agree the netdev doesn't need it seems like a fairly
> > > > straightforward way to unblock your progress.
> > >
> > > I'm trying to understand what you are suggesting here.
> > >
> > > We have many scenarios where mlx5_core spawns all kinds of different
> > > devices, including recovery cases where there is no networking at all
> > > and only fwctl. So we can't just discard the aux dev or mlx5_core
> > > triggered setup without breaking scenarios.
> > >
> > > However, you seem to be suggesting that netdev-only configurations (i=
e
> > > netdev loaded but no rdma loaded) should disable fwctl. Is that the
> > > case? All else would remain the same. It is very ugly but I could see
> > > a technical path to do it, and would consider it if that brings peace=
.
> >
> > Yes, when RDMA driver is not loaded there should be no access to fwctl.
>
> There are users mentioned in cover letter, which need FWCTL without RDMA.
> https://lore.kernel.org/all/0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com/
>
> I want to suggest something different. What about to move all XXX_core
> logic (mlx5_core, bnxt_core, e.t.c.) from netdev to some other dedicated
> place?
>

I understand the logic in your statement, but I do not want to
separate/split PCI driver from the NIC driver for bnxt-based devices.

We can look at doing that for future generations of hardware, but
splitting/switching drivers for existing hardware creates a poor
user-experience for distro users.

