Return-Path: <netdev+bounces-226256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71E4AB9E99E
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212463AC31A
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E842EA141;
	Thu, 25 Sep 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="USxf87E4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E12882A8
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795535; cv=none; b=J6OueUNdcE0s4rpttxJCe24vIXdF6Kclgf0SejpIixCMoE4rI9Ol18fTTRVrFXgSPBMuu7ML4li6NBm7sleNCDBkRAo02GIno0hk5ILvSypW0Vvr/un7BPQQgd1SNmzlrJShTmonYA256LN8u755sZWtktLVowJY/QDBAuDMBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795535; c=relaxed/simple;
	bh=0szZ/1t2vF723fTx+0uYOJw7RgMxwYGlCm1Nqaxh6Dg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=McNlmjpa7H2Jqwn6NJB9NzsJFreAhF4JdyDba8nnCs3cum+XgFT8lG8n36IQ5RRD+4DB73bXmyhUJ82u4xLTgdt5Hlxh2rROdM/fFyGjBIj2m9IishFIcZ1W+bEGXI/icQe33IRCOpeaW32gfQOZBrMsEOxvmALy51MhTVtl6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=USxf87E4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63486ff378cso2371153a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758795532; x=1759400332; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=USxf87E4a3wTPwlQzSRSmfEXT1sLetG19ySjUwclrh0qTKXbdaU9jd8qe66cTEFrtP
         O9UGT5VYl6Y23dmY+p/PBSsXThAwFZa0DX7KGCGYPpQSP2NKshcaPNCOorZvY/pid57D
         uciVqr55gTbLgzDUUKU6g+kAUfjPki2ii59/JLcvloX/SAqVezNrg5ifnb+6KhgdB8go
         Da3sb6Xvimh2VUYGRIqDI9kKs4GjtQdWaSohKjpfkeq1Aj6lOlE3wqlAGYojXHJ8IBvT
         6aLFlQ2h61v7IvSoLXpAp1U/yxd76FHgEs0tn5Id8GOjhDn2kCiGlk8wVVARiKtB3hjH
         /x4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758795532; x=1759400332;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opLUmUG+lsRAbSy1R5a7UUs1ZFkf867TQlaVzzmhmQI=;
        b=amzvsSzpbFuLUfpFNmKpvzltcSvRQWMBFG9fQPcPLTGIrvLd0/z4OQ6o6zDb2IYkdd
         zMXlwNYegLhMNQGcFlDaUy4qLK3SevKCK9Qs027F2WhE/nHbigFZ0FylaOjUQr0ZYZsW
         nHeWECu8OZD4a114aLNRKeyfRKOhKcV2e1UlUoN4pjRQFfg9YkeTgz6sqQnRxktJklzJ
         vysSe+4a2PWeqBDvbBHbPKbE+YP5f13OIuFSiuAWLPguETVvTMt+c5xQq7LbBZJF9te/
         4HpLASo5L/3hCMjzhOZrqKXYTsaN2V+Yys1KFpayvXaGaecxEi6hpkIThaTgarD/4ORj
         2gfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHyeWus3gTGQMETLn/Xd/tQo0YiY6nuek4ObzsKtYAuLSBaoh0+rYbmELP1XDKhhks/peq4II=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7jWJw8tssPwnKnWWopbr5NQLe8djNT8LZqalwnGy5tKGDMoPh
	K58EKV/kdb/0o7EeVsIX/v1WHQ3bLJ38NzRO3WWkvljgvJBWzyc/ybEmmxI8xdEXKgA=
X-Gm-Gg: ASbGncsO35abk7dpGm2oAD7FOgvoXL6bB/QAgyt2vgmq6MlTslZjT5dRrH2m10Z+FoS
	cT93P280fEBmPaITZMuZ6dxZEG6R3FWyu/m/KUf0hWqZcpuuNBB8fjxIauPX5mDfn2SLW9z+u+E
	hwc/F+WA5IhX5Lp1Bj95ZM3TszmD2jqXHDZOP6mNx10loAcoeH8ulmAmR++8czJssBFnSnaTypY
	hiEi1vMNKocIeaMl1GkZpheaTDLAoweCDtpgQ08R+4UfF63MwfMjzFPQvKUE8rMvYZCOfo3oQJv
	luP/AHV755nQyIVvz23Dtq8auEZAS7V/eBVcnHEzNk/frxAQ6Zg09ZhgZQBvJDX9uducgu7rmiL
	9uNu7C3XqimWm3Zb6/MLTlLjbUQ==
X-Google-Smtp-Source: AGHT+IFhft95WME5prTDF0IZI8kkYS3aAO32jFFFBf65s/9jPTkMU0F9cjZ8kCcS0fWYH8vfDPruLQ==
X-Received: by 2002:a17:906:6a02:b0:b35:cc60:9fd1 with SMTP id a640c23a62f3a-b35cc7000a9mr165718466b.18.1758795532196;
        Thu, 25 Sep 2025 03:18:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b35446f758csm139119666b.53.2025.09.25.03.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 03:18:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  donald.hunter@gmail.com,  andrew+netdev@lunn.ch,
  ast@kernel.org,  daniel@iogearbox.net,  hawk@kernel.org,
  john.fastabend@gmail.com,  matttbe@kernel.org,  chuck.lever@oracle.com,
  jdamato@fastly.com,  skhawaja@google.com,  dw@davidwei.uk,
  mkarsten@uwaterloo.ca,  yoong.siang.song@intel.com,
  david.hunter.linux@gmail.com,  skhan@linuxfoundation.org,
  horms@kernel.org,  sdf@fomichev.me,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RFC 0/4] Add XDP RX queue index metadata via kfuncs
In-Reply-To: <0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com> (Mehdi Ben Hadj
	Khelifa's message of "Thu, 25 Sep 2025 11:54:59 +0100")
References: <20250923210026.3870-1-mehdi.benhadjkhelifa@gmail.com>
	<87h5wq50l0.fsf@cloudflare.com>
	<0cddb596-a70b-48d4-9d8e-c6cb76abd9d2@gmail.com>
Date: Thu, 25 Sep 2025 12:18:50 +0200
Message-ID: <87348a4yyd.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:54 AM +01, Mehdi Ben Hadj Khelifa wrote:
> On 9/25/25 10:43 AM, Jakub Sitnicki wrote:
>> On Tue, Sep 23, 2025 at 10:00 PM +01, Mehdi Ben Hadj Khelifa wrote:
>>>   This patch series is intended to make a base for setting
>>>   queue_index in the xdp_rxq_info struct in bpf/cpumap.c to
>>>   the right index. Although that part I still didn't figure
>>>   out yet,I m searching for my guidance to do that as well
>>>   as for the correctness of the patches in this series.
>> What is the use case/movtivation behind this work?
>
> The goal of the work is to have xdp programs have the correct packet RX queue
> index after being redirected through cpumap because currently the queue_index
> gets unset or more accurately set to 0 as a default in xdp_rxq_info. This is my
> current understanding.I still have to know how I can propogate that HW hint from
> the NICs to the function where I need it.

This explains what this series does, the desired end state of
information passing, but not why is does it - how that information is
going to be consumed? To what end?

I'd start by figuring that part out. Otherwise you're just proposing
adding code that serves no actual purpose.

