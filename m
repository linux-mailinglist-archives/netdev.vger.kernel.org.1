Return-Path: <netdev+bounces-241003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 674ECC7D56B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 19:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 43F864E1935
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AA268C42;
	Sat, 22 Nov 2025 18:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1fHufNs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B26156F45
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763835773; cv=none; b=aV/9E8sJuGrtigbaImJaKgFsjMdi5F0QGrP58Zui9K95Vcs3wa+Trmo8htcRu0m7PyTtYFOQgjB2hfzUP1K3VuX7lt2Q8Q6GYUwNZOVpE2HioKiaYJMMiIi4n37GXKdMz6Sb2+VZr5NFX6FBco11P/j0RwJp1xCozUYnCcpxX5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763835773; c=relaxed/simple;
	bh=gTKxfZanTNwPEGnD3+Jyqm34pi7VWu9M8QMGxwaW1I4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4HUe0P8KNZduYI6jYMsYhtGvvjEpPAYS4Cy9DPe/Cm2KAb+8s5WjmI7v2B18QWR0YomJYiZNlJ8n0P8oFJu9USprxGKpUwiqlk/bl2yCvfBJxjxpeIx0/eztE73EtUneWu5u/LA8CnJvJNv5eCkrZSCwmz9sVHYoK8rssrB9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1fHufNs; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297dc3e299bso30917625ad.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 10:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763835771; x=1764440571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTKxfZanTNwPEGnD3+Jyqm34pi7VWu9M8QMGxwaW1I4=;
        b=T1fHufNsZXI4gKl74SaCDAqum5GkZ+dicwbgGvn7RuSM9BslivgyE5Nf1oJ2FR9FAm
         VnfBq0T1kc+9iZL1rSKAVuotk0Nnu1XG78mB1fpw8lCejHtpTu26iLAToGaMOsRziqgL
         eeD2oCHEShYpcSbQkYIoRhq7+heFCq1j4GIhjkClnr1nzh+PwlK0Np1CnV8oxmL5B2W8
         aPaoZHKhT2vyXWQ4R9Kh3V7HcMxn+Ue9/qD7b5pIcWRYQhIzCM8jCNFiFu32bpMFoHGy
         oezjnJ+E8yp8k+6cYYlQ5bmKxUnkBW3BmXaxUuicGlCNi0+MDPVq6GRIjOKxAI8M64UQ
         OQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763835771; x=1764440571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTKxfZanTNwPEGnD3+Jyqm34pi7VWu9M8QMGxwaW1I4=;
        b=bRJCVw6mOPthRSbD/uxDI2Sf70SmwvT/IiOSVQVAJG/E7UZikIDc5MBxAk1VIY6OHh
         xY8kWION8FPfH5aSecbLAR7gVn3FJzd2uFEDLTv6SxHdqzZ/ddCQe9KZ+ePkhlS3tfL9
         tRUMFfp7RCFW+Vhw2aqKhePKuh2fjmA7tiQGtNjR1G//l8ZHgTXNAY5BYNsvYqZptRHs
         lmdh3czqufoPaptzS9Y0cKfEvJcJacNqOUJ0f08E6ik53mkUuwQVQIui2IhDb5KFXjWk
         eEb53YLQEtvDbmWxmoFTPJPvrVNnO0yj5nAxhC0aKtn5Nk/ooKsXA3Q4rJJOmuywB+MR
         /iUw==
X-Forwarded-Encrypted: i=1; AJvYcCXSBf4KP183mSlgc4uy23QoURL2X7yAeLcfD5pVGcQl10fO28TYD2zQkAWDI7cYI7cCMafFEHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbey2vEOxEB+i7Q4epfQTznZ+ImkCUAzqK0b7yfA803Z7FIQyh
	WXf+o3TvJcoDfwpi/GyOAWVq72JD4iZdCThDlquY9SsPml13RbKjdO8a
X-Gm-Gg: ASbGnctHZTvDOk1tv4BbJrQ60n6rxJ37nnYzxXkvHo6nDT0I9/LPo8R/0vgquEpmOEa
	2Ib/3gZxloBGEbAZDev2Mt81x39zhGOTW/kQRox3g7tvLIOjAijwitWnM3sZ8m7tmkipBGrGVW9
	aeO3FgsFihLjC/x0pjO9W7LJIKMUqV/7F11NcDEwLSM6+MulVjWKiqXKrz450tObYpWe3K9nTdV
	SbizCKFLAH0jdnd6ew8Au/5W9ZYIAExSjOfP5PHK+y8t/wajP9zihPQt/3ooxB1zSgeIkkul5wm
	9PqUpjTe8UGtNPMVDrB7Sxq9ENLA2Ld27aY0Pt1RiUBuJPvUAwnV68dkZMtVGcU1NZMbouehGNG
	qqIKmSYmKTA34DyxlAqb+h30FY1GhLScUvNMMbqEaKx1CtcF/C6vqMd1aCK9/SOvQE/5J736y9u
	hO4bgoAEwoTPY4Au+hpqBr6/d7rqZF
X-Google-Smtp-Source: AGHT+IHxN1RK79zzyWeGPG4gEHxwZkKWtf3hekH5QjVDvXQquB4F0zwzMEKH5SbJDxSVXencvQIUIw==
X-Received: by 2002:a17:903:1b6e:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-29b6bf6a70dmr72025085ad.46.1763835771328;
        Sat, 22 Nov 2025 10:22:51 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:4cfa:6cea:94d3:bc41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b138c08sm87994465ad.25.2025.11.22.10.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 10:22:50 -0800 (PST)
Date: Sat, 22 Nov 2025 10:22:49 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: =?utf-8?B?7KCV7KeA7IiY?= <jschung2@proton.me>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, will@willsroot.io,
	savy@syst3mfailure.io
Subject: Re: Fw: [Bug 220774] New: netem is broken in 6.18
Message-ID: <aSH/edrbyD51K1Zo@pop-os.localdomain>
References: <20251110123807.07ff5d89@phoenix>
 <aR/qwlyEWm/pFAfM@pop-os.localdomain>
 <CAM0EoMkPdyqEMa0f4msEveGJxxd9oYaV4f3NatVXR9Fb=iCTcw@mail.gmail.com>
 <oXMTlZ5OaURBe0X3RZCO7zyNf6JJFPYvDW0AiXEg0bXJwXXYJutLhhjmUbetBUD_pGChlN7hDCCx9xFOtj8Hke5G7SM3-u5FQFC5e4T1wPY=@proton.me>
 <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoM=i6MsHeBYu6d-+bkxVWWHcj9b9ibM+dHr3w27mUMMhBw@mail.gmail.com>

On Sat, Nov 22, 2025 at 12:24:43PM -0500, Jamal Hadi Salim wrote:
> If you can talk about it: I was more interested in what your end goal is.
> From the dev name it seems $DEV is a wireless device? Are you
> replicating these RTP packets across different ssids mapped to
> different hw queues? Are you forwarding these packets? The ethtool
> config indicates the RX direction but the netem replication is on the
> tx.
> And in the short term if a tc action could achieve what you are trying
> to achieve - would that work for you?

I am not speaking for Ji-Soo, but which tc action are you talking about
here?

Personally, I am not aware of any tc action could achieve the same netem
duplication. gact offers some randomness, mirred offers duplication, but
it is not trivial to just combine them to be same as netem duplication.

Regards,
Cong Wang

