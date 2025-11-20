Return-Path: <netdev+bounces-240540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C77C7625B
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 21:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 90C5F28F19
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 20:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC4130505F;
	Thu, 20 Nov 2025 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi1WRbFQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE6A269D06
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669546; cv=none; b=UXN7LIFX8zY8AgeWfnvziFFFN7AYdSU3x58KZiPmbfd5EJiDFVPzTYjScqijNWk26gdOthN3/8QNKS96eYR3e/2lk1YsQFY2GVmibly64fIuc8hUEz4yHduL1svevUSzRBtFG6ZGWKfo2CIpR4Yu0T3yJHfMCXTUTXs8p6/d8k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669546; c=relaxed/simple;
	bh=lP6d5dwYL+W6nv5Kz56dzsnhy+cIECD/isjPtt4lNjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nD6LSOWtJZS2kklaz6vjmKeD2F4ZMRMRgxKWz+UTLgdG5E1WsFiZvgzlvZTbiaiozLVHUEHtFSsY4VmYmYfPE9CIhGF6j4aGJL1Ze8B26madIuhJAKEMroXmp0CVpVzjhfv9hGIYgAPkmHD5ebylnBSKdi5W/D3u6fDe989RXtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi1WRbFQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7866375e943so11174427b3.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763669543; x=1764274343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArLBssIhqmPzhIFPuYuwBivCUg4rQV57fxyLID3UDrQ=;
        b=bi1WRbFQ7sCxsCI+jCTjZn2Mxk7PHMhdp8VrnlosX/Vv7Gq7p66NSBPgKLBY5WxHFJ
         LG2izDHdvjj9vfpZdbrDJkAoDhMglH/ysyqMMlf3oKuTElc8hMRjG14JdFMEHes4O+9h
         HMQvldKtgRjHILpT/WKNAEydZXbf/bFTiaxRkb4S8XPeDKCEcRtb4X1K9+ADMl6IT8pt
         tFbCAWuHYJk8I6GfDqCeI261m+Q8tJ7J05Of0EgVKqujuIfRxdvFyiPN45GrYlFVAUlx
         wxDLc5OvQEnTFDJ95pQcBpMbJsPfDIlkP5Lzm818ackHF/V+e2JEYPmoIgmGYC6cYlMB
         0Yjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763669543; x=1764274343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ArLBssIhqmPzhIFPuYuwBivCUg4rQV57fxyLID3UDrQ=;
        b=lImfp+/S6T3uoRh2U0+RGcliMITofqcPDL3+H6M4h1CVBw0CzL3KOIfnHoIE0Mv8S/
         iisspYUzXARSlBufVBNV1Nm+NvDEFC/qQPGVpxLWkpb3OKu+90pVOZdJYUzDWh00TOln
         KjX7n9cBu+Im7qxM0mxSxyseoPJtZMay3E6Deg1k3gwtG0MiogVfcg7awRwxi3jqzXBB
         AXL3ut/KvditSqOllKD/H0qRrIBmdT60Ly9xGbUymydpN/jqRKCuo+X2RYj5YvFuvteB
         Yal9BViKIBrZz50zrD39NeN8KSNmvUlUElIZ7JO8V/YfBrcf+NM1pMXkCefbkpzmjzNN
         rpHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSG3x+8OPvjsqUU1dfDwFHuswj617Zej0f/c1/h1djpcLUMh/p+NkyWKpbQeLZ+0v1wsJZs5o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJI7o6BQaXkTlfK0U0VxGbGemRHdS//Ds9ztnDOv3AGVHtlFG
	rTQx9oC2jgKlACoo9dAb+fx6/AFZcctNpQRreYDtO8doyHCz90ibVokCjurrGEMjzqwKFtqzyen
	jl+T+ICpwC5cd2s4uakbeoP2TfiFt88s=
X-Gm-Gg: ASbGnculiaRYgGNh/0fQmcWIkTqmjeyXiE1Go694BhpeTXeQSphVgVAuXrAeyON44GB
	mmULHSlfL9Sig9hNNEa0tmOYSNxOpo0ILzLuE35Qoj2ty2xBDTAtn6BC6gLMoftKwEiNH9KyaZf
	OxRI1A0OtgApIB+Ms5f3WpxUmglsml5Gavn5xM8lVc+wnsjB5awqQSwlX99H6283nER2EIOrRm4
	E6HbUQ4IIqn9V4QJwtmY95iQwlnVs0Jwf5QcZo7qAF/P1uygfWc9vE5MMfkZMyZCpHEG+Ybix3n
	j25HbwLuK4Y=
X-Google-Smtp-Source: AGHT+IGHCLO2HZXDfY2Lh2C6v0dezhGL+uyOjdWenNvCCppd3pfq3EZcOR1/4+hPB+0UBNjcVEwv7WmexiAJTCJeKSQ=
X-Received: by 2002:a05:690c:7243:b0:786:5789:57ce with SMTP id
 00721157ae682-78a79607f78mr35271707b3.43.1763669543514; Thu, 20 Nov 2025
 12:12:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117191515.2934026-1-ameryhung@gmail.com> <CAP01T74CcZqt9W8Y5T3NYheU8HyGataKXFw99cnLC46ZV9oFPQ@mail.gmail.com>
 <20251118104247.0bf0b17d@pumpkin>
In-Reply-To: <20251118104247.0bf0b17d@pumpkin>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 20 Nov 2025 12:12:12 -0800
X-Gm-Features: AWmQ_bk2-fHm4Nt0R2y5_0QXWfg5bB5o2vYXDx09DXPnSNfJW8icAeGFOBUwRto
Message-ID: <CAMB2axPqr6bw-MgH-QqSRz+1LOuByytOwHj8KWQc-4cG8ykz7g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/1] bpf: Annotate rqspinlock lock acquiring
 functions with __must_check
To: David Laight <david.laight.linux@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2025 at 2:42=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 18 Nov 2025 05:16:50 -0500
> Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> > On Mon, 17 Nov 2025 at 14:15, Amery Hung <ameryhung@gmail.com> wrote:
> > >
> > > Locking a resilient queued spinlock can fail when deadlock or timeout
> > > happen. Mark the lock acquring functions with __must_check to make su=
re
> > > callers always handle the returned error.
> > >
> > > Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > > ---
> >
> > Looks like it's working :)
> > I would just explicitly ignore with (void) cast the locktorture case.
>
> I'm not sure that works - I usually have to try a lot harder to ignore
> a '__must_check' result.

Thanks for the heads up.

Indeed, gcc still complains about it even casting the return to (void)
while clang does not.

I have to silence the warning by:

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-result"
       raw_res_spin_lock(&rqspinlock);
#pragma GCC diagnostic pop

Thanks!
Amery

>
>         David

