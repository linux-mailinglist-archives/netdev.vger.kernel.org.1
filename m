Return-Path: <netdev+bounces-226113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 173EBB9C5C0
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231E41B259F0
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 22:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43562882A7;
	Wed, 24 Sep 2025 22:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRfjKh/O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33E246BB4
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 22:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753096; cv=none; b=MuXbb9GziotjQGL7M547vqFXmTOWf+FI3bv1Tquue66wH4YmT184DJwSIbFZpYGpthFiCwr5h5j0Z4ZXxzQ33RxDmEKXMbxMv/HqQtbf4cxzJpThbphr4T/2fUxvnyT27GSD0Gb9hFUc5U29wErQsgcyLMPj6smOdjZWZj63dQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753096; c=relaxed/simple;
	bh=E3mp818XeEDGifzwzdOnw8G4qn3w2nYXo2kiXHXmH1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJbHLHFK01kOpGnAcUZXo+phONCB03/ezmxmh2dNvJsmEEy0W1OiiPTEMMoJT2HZxq7BT7aJe7ujdgQ9wFwplEpU0nvA3qDAP1UtblLKNZTpvT7Wf8GG5avoVvea5YAJ7Oc8vL8AUVAvRRPt7FLu8SFHjWp6Fl2mclupwalZ69k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRfjKh/O; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2697899a202so11915415ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 15:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758753094; x=1759357894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWJ481WqwYt03Qs8yEQYxXt74IruS1KgxQpyoMD3fOU=;
        b=SRfjKh/Oa3qxnxurXBHLFYIKs7j1n9CLuhpwWHyYUxayMNFcNQVXm4ZASByYSs9Lbk
         UT1NcZXphV3AcX1QZwHuB+i0IQxjOHFIGekrxQeZ/k9qIlf4pvJSlt2Frf+XtH3CpO7M
         8kbiBObSyIDfnpr/7/A3T9TztmBRgfKYvoFRtGkm877SIQWugPpJBRRZtqVwXw6dKEK/
         pPfLTqVhpueuVrrB21n8NBKHfE6Lyvz4T10wCpJit5xP5jWQxjZIatn6DLt1pjcqAVis
         KMGYztjABG5OSGd+81koCGFMBFGIIDqCI2YGpjTPXXfh8jO890vihlBAdjDIFjTC4ywg
         KL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753094; x=1759357894;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWJ481WqwYt03Qs8yEQYxXt74IruS1KgxQpyoMD3fOU=;
        b=lPivP7J+KBGAshwBqEykMRl0CvGb/UFo8QpZXHUNBGCPxebaFrs4aM8DuoNLaN3nPz
         RZe50s84NuE1lQ1IY025Gno0bcGPtE3VRv20S4kr2I+cnuvMo8OTRo7RUJmVuy35ubud
         3jRSgbfrxrvfpk1dXsm6Tc1hUTW/oaHIDiIKlBaWgUtCZPBvvi3n9vnPRNu1/gZhDDrp
         P7Rk/U9AnCT2P7F2RCQdjFkz7IY6OKshyJ0k1iuEFwCmnZ6HPy5Bo1Gst5wkicNB3Hsx
         SensowH6dJ6Z1FLpGwmwZ1MAp+ubqVWOchnbcBugJyR+1txO7bJJ13pwmfWx3axEf7TD
         /UUw==
X-Forwarded-Encrypted: i=1; AJvYcCUBW1+lEOBrOkCS8JvE5K8U4fWKpF0j4qVw9oZXw1rZr/9F1qR48yheys67W+37PlsxMubsHYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjfP5gMe3ubbYDJfj+JpWJGFw77x0prowyLcGYtkb3aPBxb7av
	0OC+c8klqV0CihEqMzkKxkRWZTw1WbRO1xxsqDoO6bRZvuNUjwkpsNQ=
X-Gm-Gg: ASbGncuBaDv1180fapUCTsTVmJpUomoaAuuhSYFog5iERiXMWZT7cXmRQEkWcgl8q2T
	4zuO0QL1SVi9khjEuLA1/orNGRWzxVmDwV7EonvlKZIFNjkyWKJjmz32PNSm0u4nHUNU50CULe0
	+pd8+W0V0mZysuGSZnHKPYS8banVdU1BR16fTeXkwWLAbD7o3fWeeby0AULh7lJEGDMVbYwmIOh
	yrGhQSBvkCAelVo51/UZgnQsU5gGcscKDMDXQIQ1e/vnKdFv6ab+grYKv88i7KPqxv8BxPjRHjq
	SDSTf+b8nN948JnUVYpubi28b+KpN74xl6yVu6J/KyLoonOMjViu7q23A60G4avtzXqfNeXuSad
	4PzThmkcYHzc3SxnY6R4SwrRVoJ0iASX9jAcEeKR2eYi/8WVc9HjahtFnDIwT6A3GWCgxiFn/Ph
	Y6cxvGfbYZAEDhaDQ8jXqd9Z7hmhBiuoftC6J3MyQVzLfc2pJYblmz+RxBjVdwTMsJrYyxQmLov
	Yb6
X-Google-Smtp-Source: AGHT+IGqXSUCi05Q6A/shBANKJJ+7L6thhmdeK778FmwuGU+D6HEICoXlQ65iZTp1I/QU4cKU7BZPQ==
X-Received: by 2002:a17:902:8210:b0:267:44e6:11d6 with SMTP id d9443c01a7336-27ed6aca024mr3396525ad.6.1758753094437;
        Wed, 24 Sep 2025 15:31:34 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-27ed6886f4esm3083585ad.80.2025.09.24.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:31:34 -0700 (PDT)
Date: Wed, 24 Sep 2025 15:31:33 -0700
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
Message-ID: <aNRxRRSfjOzSPNks@mini-arch>
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
 <aNMG2X2GLDLBIjzB@mini-arch>
 <f103da72-0973-4a45-af81-ec1537422433@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f103da72-0973-4a45-af81-ec1537422433@gmail.com>

On 09/24, Mehdi Ben Hadj Khelifa wrote:
> On 9/23/25 9:45 PM, Stanislav Fomichev wrote:
> > On 09/23, Mehdi Ben Hadj Khelifa wrote:
> > > ---
> > > Mehdi Ben Hadj Khelifa (4):
> > >    netlink: specs: Add XDP RX queue index to XDP metadata
> > >    net: xdp: Add xmo_rx_queue_index callback
> > >    uapi: netdev: Add XDP RX queue index metadata flags
> > >    net: veth: Implement RX queue index XDP hint
> > > 
> > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > >   drivers/net/veth.c                      | 12 ++++++++++++
> > >   include/net/xdp.h                       |  5 +++++
> > >   include/uapi/linux/netdev.h             |  3 +++
> > >   net/core/xdp.c                          | 15 +++++++++++++++
> > >   tools/include/uapi/linux/netdev.h       |  3 +++
> > >   6 files changed, 43 insertions(+)
> > >   ---
> > >   base-commit: 07e27ad16399afcd693be20211b0dfae63e0615f
> > >   this is the commit of tag: v6.17-rc7 on the mainline.
> > >   This patch series is intended to make a base for setting
> > >   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
> > >   the right index. Although that part I still didn't figure
> > >   out yet,I m searching for my guidance to do that as well
> > >   as for the correctness of the patches in this series.
> 
> > But why do you need a kfunc getter? You can already get rxq index
> > via xdp_md rx_queue_index.
> 
> Hi Stanislav, When i was looking at the available information or recent
> similar patches to populate the queue_index in xdp_rxq_info inside of
> the cpu map of an ebpf program to run xdp. i stumbled upon this:
> https://lkml.rescloud.iu.edu/2506.1/02808.html
> 
> which suggests that in order to that, a struct called "xdp_rx_meta" should
> be the route to do that. In my navigation of code i only found
> the closest thing to that is xdp_rx_metadata which is an enum. I tried to
> follow was done for other metadata there like timestamp in order to see if
> that gets me closer to do that. which was stupid with the information that i
> have now but for my lack of experience (this is my first patch) i tried to
> reason with the code.So yeah, since xdp_md is the structure for transfering
> metadata to ebpf programs that use xdp. it's useless to have a kfunc to
> expose queue_index since it's already present there. But how would one try
> to populate the queue_index in xdp_rxq_info in cpu_map_bpf_prog_run_xdp()?
> Any sort of hints or guides would be much appreciated.
> Thank you for your time.

I don't really understand what queue_index means for the cpu map. It is
a kernel thread doing work, there is no queue. Maybe whoever added
the todo can clarify?

