Return-Path: <netdev+bounces-112421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4F1938F7D
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7F51C21471
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 12:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BFA16D4D1;
	Mon, 22 Jul 2024 12:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Lo37DPtW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2816CD07
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721653082; cv=none; b=tpr7vYMZrOe9Iglb+EXuk63p2okbH5NPmv3RGWjg6IShMNnwANojUOVPX3QiZBTtqd5ybm58MJCfD4ZM6Ujn41B/y8x/nXeVWUy52lsYgaLwFOgvX8q/Rkgio3kk0pcxKOb53fyLW8sg9fip/1g268KAZ1JXgQ2rq9nmnwE5Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721653082; c=relaxed/simple;
	bh=zpvGzWjagUJbT+tBRs1I+pK766noVDsalbL5S5OQ/VA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHCcK6BBrfKSTSiMeP0CFdkp/nGjvRr8Q1VmwwLNdd+t4SMqzRnODQedXWZTtg0Vv5FKHBW7haRZ+YPC5tyG6b1/Rue6c7YUGiiwen1H37N5NrPyb/8n3/J5h5RpCrRs52FxgnBFTzg/ecGtQ9Zu0TJWidTWteTyD82wsrZagR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Lo37DPtW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3687ea0521cso2846873f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 05:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721653079; x=1722257879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Cw665BKFijDU6M6QF/AAWMgJ5QHnl6aJNUeL2ge/ZM=;
        b=Lo37DPtWf01Ng7byzUplOiHTVkIQuGI7xQWhz82ywUtRX8fPOtH0KMATZnm3bjmFRv
         NxzL3543KUGviJ0N/PVoJSPagoHAzb5EO/X6q5DFjMDQXS+01i3dGJCcv4V9jLCEP7sQ
         Ww9H0ABb5QmhQNGxat+JlkBe8hgoqxzkgxOPH7zGkks0SjKD4ujQ1ZwG5KgY1YSJC4j7
         TL98ARhkB4vp7wpeiZLk4LUA4Z1OhyGomSPFYEA+WwSV/YJ4YXxfNbnocj2tfr3f2Ttx
         5gB8Xk42+FDnVws61ZbqDDMxr9n8HtxP4W3fIXsg047H7mZGW+YjoRtRtqJMrzvXja41
         C+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721653079; x=1722257879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Cw665BKFijDU6M6QF/AAWMgJ5QHnl6aJNUeL2ge/ZM=;
        b=hxU8uRWa/GJI9Plgp2LbrYUeYf5/DKZrSnUVn5gNCasZdZp3w2fWFibXeDIer0xNtI
         JaQFH80F613m2EdD6MK926zBPXkuJkcFVoPPwmOXI46Y4/QY1sR9flNIN9jOhkoSD0Zl
         o2y8gUdn/V6ayYLG+EagNuR6x/zdje9XNb09QYDwsa8oh8PKUCrK+HdrJNpic6r//up/
         4sLR1RY/bvfZ/j6C71kNtG3kTbCbPo2sINKhhhP2X+T64KL+lAZtoYtquRCFzpzTSlmA
         yOr2wbZvpwUN9cW54HVXurD0xACNQsnkShr9T/+lHsICCax0j4w09qtKTisBIHxYgksV
         s7SA==
X-Forwarded-Encrypted: i=1; AJvYcCUngYsUTRiSq4f8RhBtOka1/kO1l/DU0gLtN421S22lEusoGX6LgULxyCJ2lM4y2tWD4E1bkrqn3gQLgKvvMkKlhV1hOgtX
X-Gm-Message-State: AOJu0YyVsI42Qsx91iY6mM32CcKhR/lHEOHQNvnzoUKMmfjiGCMZ2MlM
	b8MqL7Ncn3yyfEs3pB9+Npggi6Q5n5QsTVRaJtzIRZyP8C3HW9wk4L0+ZW6tUu65UgwVWRHRHCU
	nYDA=
X-Google-Smtp-Source: AGHT+IH1f0hqgUPCnwjNSW1Wa8N2G7bSYStrtqNXEOO9neu2VXreDY3l7pHKNRB4WJ9afg+pNl3zSA==
X-Received: by 2002:a5d:64ea:0:b0:366:f04d:676f with SMTP id ffacd0b85a97d-369bae3a43emr6151788f8f.12.1721653078778;
        Mon, 22 Jul 2024 05:57:58 -0700 (PDT)
Received: from u94a (61-227-67-19.dynamic-ip.hinet.net. [61.227.67.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd8dff753bsm29447165ad.243.2024.07.22.05.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 05:57:58 -0700 (PDT)
Date: Mon, 22 Jul 2024 20:57:49 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Eduard Zingerman <eddyz87@gmail.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Yafang Shao <laoar.shao@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	"Jose E . Marchesi" <jose.marchesi@oracle.com>, James Morris <jamorris@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Brendan Jackman <jackmanb@google.com>, 
	Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf-next v2 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Message-ID: <wjvdnep2od4kf3f7fiteh73s4gnktcfsii4lbb2ztvudexiyqw@hxqowhgokxf3>
References: <20240719110059.797546-1-xukuohai@huaweicloud.com>
 <20240719110059.797546-6-xukuohai@huaweicloud.com>
 <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5afdfca337a59bfe8f730a59ea40cd48d9a3d6b.camel@gmail.com>

On Mon, Jul 22, 2024 at 12:13:20AM GMT, Eduard Zingerman wrote:
> On Fri, 2024-07-19 at 19:00 +0800, Xu Kuohai wrote:
> > From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> [...]
> 
> > 
> >                         |                         src_reg
> >        smin' = ?        +----------------------------+---------------------------
> >   smin'(r) <= smin(r)   |        negative            |       non-negative
> > ---------+--------------+----------------------------+---------------------------
> >          |   negative   |negative_bit_floor(         |negative_bit_floor(
> >          |              |  min(dst->smin, src->smin))|  min(dst->smin, src->smin))
> > dst_reg  +--------------+----------------------------+---------------------------
> >          | non-negative |negative_bit_floor(         |negative_bit_floor(
> >          |              |  min(dst->smin, src->smin))|  min(dst->smin, src->smin))
> > 
> > Meaning that simply using
> > 
> >     negative_bit_floor(min(dst_reg->smin_value, src_reg->smin_value))
> > 
> > to calculate the resulting smin_value would work across all sign combinations.
> > 
> > Together these allows the BPF verifier to infer the signed range of the
> > result of BPF_AND operation using the signed range from its operands,
> > and use that information

I accidentally left the above paragraph unfinished, it should end with

... and using that information, it can be sure that that the result of
[-1, 0] & -13 will be within that expected range of [-4095, 0].

> >     r0 s>>= 63; R0_w=scalar(smin=smin32=-1,smax=smax32=0)
> >     r0 &= -13 ; R0_w=scalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3))
> > 
> > [0] https://lore.kernel.org/bpf/e62e2971301ca7f2e9eb74fc500c520285cad8f5.camel@gmail.com/
> > 
> > Link: https://lore.kernel.org/bpf/phcqmyzeqrsfzy7sb4rwpluc37hxyz7rcajk2bqw6cjk2x7rt5@m2hl6enudv7d/
> > Cc: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > Acked-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> 
> I find derivation of these new rules logical.
> Also tried a simple brute force testing of this algorithm for 6-bit
> signed integers, and have not found any constraint violations:
> https://github.com/eddyz87/bpf-and-brute-force-check

Thanks!

> As a nitpick, I think that it would be good to have some shortened
> version of the derivation in the comments alongside the code.

Agree it would. Will try to add a 2-4 sentence explanation.

> (Maybe with a link to the mailing list).

Adding a link to the mailing list seems out of the usual for comment in
verifier.c though, and it would be quite long. That said, it would be
nice to hint that there exists a more verbose version of the
explanation.

Maybe an explicit "see commit for the full detail" at the end of
the added comment?

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> 
> [...]

Will send an update for this tomorrow.

