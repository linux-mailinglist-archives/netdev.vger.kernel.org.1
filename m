Return-Path: <netdev+bounces-225720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834AB97841
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 338AF3A34D0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF55305068;
	Tue, 23 Sep 2025 20:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORs4JD8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7372F56
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758660316; cv=none; b=TVwZjXjl2oTb1IF7yDlimh1LJp7AGncAKJKail8LloF9WNXD71waE/pmhEpKCNm9BFoO8fhz3ppOpaOuGQm0tB3uTDCUOEpS00tzeiP6NYESHxxgUSe+F3IjYXryscjutC+39tePxI7q2DBcNfkNnBdLjrmyqLLgIJ85W6cUXhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758660316; c=relaxed/simple;
	bh=nGwmEIjf0Z80ZC/Qqkye+v7lXX7+Uyfj55BEPrjCfjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfqnMpJSgCbnk+UIxLiEuj6fK8ATRWrCN4zrhT1ufl5NK/RTMRAEYCmNznLjfynpLl+0OIAho1aBunXYaH32VO8v293/wjOBZ/VZ2Vt14OTkkhuRF4yKd3Gc7Ksp7wOJoetnN4nE5UXA7+f1aeUd2objZUXc5X4bmBRYMzXJOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORs4JD8W; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24457f581aeso59824165ad.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 13:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758660314; x=1759265114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sipScXl1CFAIZEiqAz6v2zuPdeVOTifZUwgP7G5st/0=;
        b=ORs4JD8Wq/POKafG29v8kG7lpNbTfeh62uOMPMZa3MrkfXUFlFPRvg95ct0NJ1UrMm
         LZ5HwUAW0eNIzXL7+4s6lxO0j6/gvRMRdgnlwGwfe9FCHh0xiyDRXJMi3ilgSIKm/QM6
         luv3G1al2u2FzioMDZwy3W+PF1kxxsO8QHINbx7D0mbUxPQZGfYmKzHRuLUYNEpohoNQ
         8UvOAhQePxRRuq2iveUfhotQCBG2/+QUTOK13fjvEnkIjPGAC4CsEuYKwfwYtPj+32Vu
         RkdT4s6VKwSm6KIJGwK8uqhL2h95jQU2rGJju/4RY9cFVB16H2lNTrp3CS1vAYfDDaIa
         ywuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758660314; x=1759265114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sipScXl1CFAIZEiqAz6v2zuPdeVOTifZUwgP7G5st/0=;
        b=nknrSAot9jGOR1kQ7MgodnVhbIfyLCAV+Zw9zCDoG1P0UQ9tkABOhqIfTucY24Hvls
         7xZ1qN7LoR0LuzvJ6ETebyxUIPPbGyq3LUTP5mVlD+65GHW1dQLPtLOQ5kcR1gEjSEu2
         IrGZEJySfw6+DrEwUvnD/QqWPsf4Se6pwZTIf3TqjKik0PMcOn6b0TivLP7vgDap31xz
         z+kcWs/L4Ag8rcgNDVBkVXDsh7fVfKeXp8QDQKYUB9W6bsxYnijkzHLFqD+3dNIJWFsl
         BbYhil40iKUWfOB8aWT2DTXfLSLFC4Al6bEroThPoWNH+CBc9jMSlNra1MvI5Dz6OHdT
         gvmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj1Qqj5XsttJTmroxjnbdSp6KUrD9Fm7lMjxJECxmkJoUSUQJJIFR1NByOhQD0VW97KOxgQ1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1pukFnLyj6d1TeBYpiCGr9SX0/MPVescsiPljGTO4Nr34Z5yM
	uJnZGlXaD80SRDltPbpbrSnARc72EltNWympH7BGQC9ObJjSE4KR3jM=
X-Gm-Gg: ASbGncseC3j7gjzXDMIcAoSTwJSQMZZscuKFABbFLjLBiRJ1DdpcltrYc05Jzca9hrF
	NZqqGQw47er/6hylrpRHFgDQMlWoHdYS8vWIiyFcMNGDncfOICV2HGXG/9PK9LdWPMqtSIk+lDL
	5VDjb5e7Y9LJ4ntnIKLxYWx5eslaAyuZc1pYHSolWy1ojat2urM6rGfmvxF0qKhXROrZ9orYvZ7
	dS1bFSliy4Y2xj5ck2Wq93hs6TxcGWq/iosQmfuTRSe5OdKQE5pjmOC5a6AGj5kj/700aB9ks6d
	N9lv+cUmvfRDyHZyRXO86qDf6+U0pB1EaCXvtOjytOzIwORobT8p7PEgoRFWhztygU4HX4f1qxb
	IM4q13tJiLhmt1JIo2de/aOHn+t/aLuBrxBsdtaaaLAYUvWF+W8O+pAFCpJqn/yqyBDoNdpuATF
	Ge4bX40KwAbceNTk+16h7uSf265dRkdXWI3Kg4il8AOo9a8ztcZeHA+ptaqHqDbBREfgxgcl0GS
	Uvv
X-Google-Smtp-Source: AGHT+IFlpvsj7lKaK/ZqzoeecXc8ehWZkc0IxVgAN+LI3oeEEkFfcubTmnGuNVbCi3mV+UCdDzJmEg==
X-Received: by 2002:a17:903:190:b0:277:9193:f2da with SMTP id d9443c01a7336-27cc0dbb137mr49147325ad.5.1758660314194;
        Tue, 23 Sep 2025 13:45:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2698016c098sm166380315ad.33.2025.09.23.13.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:45:13 -0700 (PDT)
Date: Tue, 23 Sep 2025 13:45:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, donald.hunter@gmail.com, andrew+netdev@lunn.ch,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, matttbe@kernel.org,
	chuck.lever@oracle.com, jdamato@fastly.com, skhawaja@google.com,
	dw@davidwei.uk, mkarsten@uwaterloo.ca, yoong.siang.song@intel.com,
	david.hunter.linux@gmail.com, skhan@linuxfoundation.org,
	horms@kernel.org, sdf@fomichev.me, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
Message-ID: <aNMG2X2GLDLBIjzB@mini-arch>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>

On 09/23, Mehdi Ben Hadj Khelifa wrote:
> ---
> Mehdi Ben Hadj Khelifa (4):
>   netlink: specs: Add XDP RX queue index to XDP metadata
>   net: xdp: Add xmo_rx_queue_index callback
>   uapi: netdev: Add XDP RX queue index metadata flags
>   net: veth: Implement RX queue index XDP hint
> 
>  Documentation/netlink/specs/netdev.yaml |  5 +++++
>  drivers/net/veth.c                      | 12 ++++++++++++
>  include/net/xdp.h                       |  5 +++++
>  include/uapi/linux/netdev.h             |  3 +++
>  net/core/xdp.c                          | 15 +++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  3 +++
>  6 files changed, 43 insertions(+)
>  ---
>  base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
>  this is the commit of tag: v6.17-rc7 on the mainline.
>  This patch series is intended to make a base for setting
>  queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>  the right index. Although that part I still didn't figure
>  out yet,I m searching for my guidance to do that as well
>  as for the correctness of the patches in this series.

But why do you need a kfunc getter? You can already get rxq index
via xdp_md rx_queue_index.

