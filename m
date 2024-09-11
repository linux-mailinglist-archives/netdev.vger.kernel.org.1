Return-Path: <netdev+bounces-127538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A3D975B4E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80B21C22429
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF781BAEE7;
	Wed, 11 Sep 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c1iXHLLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C61B6520;
	Wed, 11 Sep 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085131; cv=none; b=oiDVP8cLUfSwqBc5YIKCSpq9NcnAO22Mgjw9ir7fvvcjyYj/N+wVWVs/gLJ00mfhWR+4q3gAeSLvCUaVk9nuH/o89TOvO2r/6ps/CUdyNJivQ7Iqv23tMnlNiC0vrfYOK6CvGz945HevzdaFoWmz1FHf0Iv5bwaQY3uWcNbwTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085131; c=relaxed/simple;
	bh=BGGJWAswA8ffqXoWn2WRpjkfvhMrhHpcl0tyR1z1gdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tp5mhfjobFQGlbwsOMD+0nZHTqX/9dgBPpMidFIjVzDZ0w6iwNyEnpiTO3EbUohFg2hxrTDGapKprGF55SlfSsHNnCnuXq9wnqLTG5bCPYyi0fXZPkyi5g/CLUjPmEdw/LCb+BH6FlkHJTjMN3xm608eGipkxg7qTb0MD188YBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c1iXHLLT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7db1f13b14aso227070a12.1;
        Wed, 11 Sep 2024 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726085129; x=1726689929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivMBY2bQfuVp9R4Vq5aDMeBR/4yT4ehm4tE8mXxc5a8=;
        b=c1iXHLLTQveYaYqL44QwGEWbzZ3SN42cYWVmFd2taP/f07QRenoAfinJQobZOiPJJQ
         xjC43pXoZSS/41DviNC/Dr1v0ANV4qsOiTffUP+QOYy5vn6cbCdQq38d2pD78k4fcCYd
         u81b+NeUydSEZ+8wAEzY6knHjY6qWx7vwYYH1z9YkWYCZRxABVaZ32jd6yGMiZjfQcNE
         DWfU1SX6SbCtnGZNSo1eFVpvepz18c8bk+C0X19i237PI6UlZx/gWnr35JGUMypfGFB1
         nJPJixSAdaTj8gFANVfs23KLySE9cv+fVRRRYJWm6og3b+t4suuMK7usSMs8cxUtT7Bz
         /GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726085129; x=1726689929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivMBY2bQfuVp9R4Vq5aDMeBR/4yT4ehm4tE8mXxc5a8=;
        b=O3ScbszQbHJmgPPbuqvjylQPRFQUCMkREPzfFk489CM1uAPWbfCcgPl7IkOaFijvBs
         lyM+vqajFL8bbWBrWXAfrm/V4LJ/GIzhqrUWraC+/Qz+kHnj88pKyOdW3y44Vihe0cvj
         rstLmB55lqBxZefeZwD9bN6afNabcz/gCdGDYyAuzh+YtFcV9oA7IDqgzkgt7AaF+07v
         MHAAct1ePCXwSPIzpsJoIAyaiUK302owm/TXg7XyVVXNLhls7Ng+PBxZBdjYH4b+eRE+
         7hdX/MVBuJ8Zn18vUYbdSMM2BR9iqemcGppF2161A8EO2ZL83APPGsklNIMl1YmpS+44
         nkeA==
X-Forwarded-Encrypted: i=1; AJvYcCV1TVDEN7oLtEm743oQwySK45elOT8K9bCik55ffLDmKgkk+UMOH6rHJWtTVqDuervPVfPeUanbrc0qQRM=@vger.kernel.org, AJvYcCWAkS7yd4iRglIOZVtamhC35zAWhz8GLSjTmbnkOhJaOc/eyI8c71fFXg5lk2GElEuNdHKMfXsL@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvSjeTQZN+VkHU+5MSyU6kJhmNyOrAh7gWgPS/ReBiPKhF+fd
	XRxvuceqMh92CuJaSJenOrlVy18sbO2ad5zAreJAdOqvjwVBMgM=
X-Google-Smtp-Source: AGHT+IG2FV0416Vjy6IKXlR5bgSc/K3v2qUnttfVoWysdyCU9uJla3VgOvqtAe4aBd19jJv6MSQfmw==
X-Received: by 2002:a05:6a21:58d:b0:1cf:5370:3b0 with SMTP id adf61e73a8af0-1cf75f00300mr646017637.12.1726085128598;
        Wed, 11 Sep 2024 13:05:28 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090b0286sm3469256b3a.146.2024.09.11.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 13:05:28 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:05:27 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Qianqiang Liu <qianqiang.liu@163.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check the return value of the copy_from_sockptr
Message-ID: <ZuH4B7STmaY0AI1m@mini-arch>
References: <20240911050435.53156-1-qianqiang.liu@163.com>
 <CANn89iKhbQ1wDq1aJyTiZ-yW1Hm-BrKq4V5ihafebEgvWvZe2w@mail.gmail.com>
 <ZuFTgawXgC4PgCLw@iZbp1asjb3cy8ks0srf007Z>
 <CANn89i+G-ycrV57nc-XrgToJhwJuhuCGtHpWtFsLvot7Wu9k+w@mail.gmail.com>
 <ZuHMHFovurDNkAIB@pop-os.localdomain>
 <CANn89iJkfT8=rt23LSp_WkoOibdAKf4pA0uybaWMbb0DJGRY5Q@mail.gmail.com>
 <ZuHU0mVCQJeFaQyF@pop-os.localdomain>
 <ZuHmPBpPV7BxKrxB@mini-arch>
 <ZuHz9lSFY4dWD/4W@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZuHz9lSFY4dWD/4W@pop-os.localdomain>

On 09/11, Cong Wang wrote:
> On Wed, Sep 11, 2024 at 11:49:32AM -0700, Stanislav Fomichev wrote:
> > Can you explain what is not correct?
> > 
> > Calling BPF_CGROUP_RUN_PROG_GETSOCKOPT with max_optlen=0 should not be
> > a problem I think? (the buffer simply won't be accessible to the bpf prog)
> 
> Sure. Sorry for not providing all the details.
> 
> If I understand the behavior of copy_from_user() correctly, it may
> return partially copied data in case of error, which then leads to a
> partially-copied 'max_optlen'.
> 
> So, do you expect a partially-copied max_optlen to be passed to the
> eBPF program meanwhile the user still expects a complete one (since no
> -EFAULT)?
> 
> Thanks.

Partial copy is basically the same as user giving us garbage input, right?
That should still be handled correctly I think.

__cgroup_bpf_run_filter_getsockopt (via sockopt_alloc_buf) should handle both cases correctly:
- garbage input / partial copy resulting in negative number -> EINVAL
- garbage input / partial copy resulting in too large number -> potentially
  EFAULT when trying to copy PAGE_SIZE-worth of data

Also, for the EOPNOTSUPP case, we shouldn't even bother copying any data.

Am I missing something?

