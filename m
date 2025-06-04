Return-Path: <netdev+bounces-195142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFCACE48F
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4B818988C3
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892D1E1C36;
	Wed,  4 Jun 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X51E8hV/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E9320F;
	Wed,  4 Jun 2025 18:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749063505; cv=none; b=DIOqG7nX+rVEZECLBVeDRAiQZLnuAhQOYiLqPQ6TaNrGoimjCdNogjBRaZIpD8+UfpYg4wZOr0fCJCXsLK0AMPVZJcflLUsFqYugHgyqbWiNsmuITeeGdyAnUpRb6Go49iBiOpIj6K5iXrLg/CnCYNAvgZg7TED1/fghvFJetM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749063505; c=relaxed/simple;
	bh=mzGOHlpXmqwWMa0Wr+MTGcZeDudXFPUN2a3kzEWMULE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bHa0oGRzJBh2uBiQ1ar/h7irz9NO1yHSGps+TuRFVM3fuwWfZFUOAhkYD+wBXzxO6D3t6Qi5CoyLUWxw6Je2Mbsu7PT0AZ1UX7uXAneiZAjLULFByvKdvWK0/UIEN3rYXoAqk3JE4yhoD/5sU5RJkzhDWNX+HYam8aLp3nYUXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X51E8hV/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2301ac32320so1741525ad.1;
        Wed, 04 Jun 2025 11:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749063503; x=1749668303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMYbwbXYccHSVQPKYSpzbCZ+y7pvWM10sRF6pDZbbxY=;
        b=X51E8hV/dtYUNi8t+bisa9U/xdT5c0e25qniKfgHiFX635wiZdoWYls3uQOlC2HRx6
         clFyKEkxmADDY56ycp495bf42QeHbOxU1er763YgZR44Vz7gljfIBy+WZMC/5SRwa6SY
         1f3TTc6VjdzfQejXRpcnSaActdUUXPD8qYfLXohmzjYr+q8AbVNgEw8HOOniJ8m68A2Q
         WDggG5b479pxGOlub4geHMlqLMOF1LZIyB3xsIXCFS/Ct2Zkt1xh5SH7SUk5jxqfUvP1
         pA63yBjPrHHJ7szYs+Z+akoociYNf364r5ex/UxQcQyb4WxDQIWhJF175/ArH6+gBsc+
         bKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749063503; x=1749668303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AMYbwbXYccHSVQPKYSpzbCZ+y7pvWM10sRF6pDZbbxY=;
        b=Vm5mCfxw5EqDnl+ksG/Y5HjlEYUsVQxocZCOTRABRFU9LKka6JikyIBHFGlsCWozIY
         csgQxgNQDeqs3bl84K1sin2NmCL2N5VqSGcbqMKNhN1ZKyEA5eBkSExKbVPhyIJpp9mu
         WfpMcZflLLYOd7DipCF1RcXgDsg7TCLagzp94TVgPNneg/T4iYeYE6yYds9E5bakdo6Z
         8XJUBP5l8lkqUuaCfElz2xemTVHBvbxeONfGbLarEKdYyylFp/+axpN3jm+qIX9WQdPy
         jnMZPw2Yr3ZL9tsb/BVD7k9pGB7qF5TPNdYwb10agvRbJzCLDHgjPCATED/pQAhnKUoN
         Gcow==
X-Forwarded-Encrypted: i=1; AJvYcCWB0BIgYyzYb7VTGieO7+HouVxM+raVMu9xKRvDlEKPKLhTG6E5D7wA0+l5bUI15sa54slztSXbCUra1Mw=@vger.kernel.org, AJvYcCXz8/3XPobA7g3+z/Hp6AesnRvYkmKsnaVCI3XOz/nHa+KEykhhw0AbhGot/mJf5dfNOk81X32o@vger.kernel.org
X-Gm-Message-State: AOJu0YzLphT5d+1WkdmAFkyE1HJK0dugHN0bvu5Mtp60lE17rpBbCqTg
	v8hdg7C1N+rcmkMh0Qp3yO0XZBynbaBeCJr9gs+65I9Qb+zS5c2eH28=
X-Gm-Gg: ASbGnct0Ny7PxsNjmopLYUvoPKYFMcIIAyRJSa7cdmHhAb3w5OmxCw37t1dCKIxsfFy
	HZYKHUfpaMe3wG24JoIXU+hMrs4xg1sWb3TeTwFbxjoW/NEfzMj2HFfbjVsPBxKVxXlmTNW1pG8
	VQxGo/THrW7/dzlgST+CfkQY8qX7fq7dkhZoADld4/0qITB6fRZ3Zebr4Nt/5fw1oz8lQ1SUI4k
	NqFH0xDCugj7A5goKbhNrDL0L/x3UREcFNXy3NtV6V2+p2fefmnYlgqlVPPt8Z+JMHK+y/U0ZPA
	xSWdDsi0lkdCHYfmqkbxQeXOi8++
X-Google-Smtp-Source: AGHT+IFGNavVpVXbSNDzCNHh541HFTvUZ/3LSwb0lEij0rwquG0taUQdVUEvneaPNYwhjS5e4aBOpQ==
X-Received: by 2002:a17:903:a50:b0:235:e71e:a396 with SMTP id d9443c01a7336-235e71ea9a9mr26420135ad.51.1749063502848;
        Wed, 04 Jun 2025 11:58:22 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506bd939asm107532785ad.70.2025.06.04.11.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 11:58:22 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: luka.2016.cs@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [Bug] task hung in rtnl_newlink in Linux kernel v6.12
Date: Wed,  4 Jun 2025 11:56:39 -0700
Message-ID: <20250604185820.147956-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CALm_T+0emUog-74YTfGnpY4AAgh=jFsYBmttc-uesXFRoyofhw@mail.gmail.com>
References: <CALm_T+0emUog-74YTfGnpY4AAgh=jFsYBmttc-uesXFRoyofhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:18:55 +0800
> Dear Kernel Maintainers,
> 
> I am writing to report a potential vulnerability identified in the
> upstream Linux Kernel version v6.12, corresponding to the following
> commit in the mainline repository:
> 
> Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

Please run syzkaller on the latest upstream or at least the latest LTS
release.

> 
> This issue was discovered during the testing of the Android 16 AOSP
> kernel, which is based on Linux kernel version 6.12, specifically from
> the AOSP kernel branch:
> 
> AOSP kernel branch: android16-6.12
> Manifest path: kernel/common.git
> Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12
> 
> Although this kernel branch is used in Android 16 development, its
> base is aligned with the upstream Linux v6.12 release. I observed this
> issue while conducting stability and fuzzing tests on the Android 16
> platform and identified that the root cause lies in the upstream
> codebase.
> 
> 
> Bug Location: rtnl_newlink+0x64c/0x12f4 net/core/rtnetlink.c:3772

You can find a bunch of similar reports in the mailing list or the
syzbot dashboard, where too many threads waiting for the same global
mutex, e.g.

https://lore.kernel.org/netdev/tencent_A3FB41E607B2126D163C5D4C87DC196E0707@qq.com/

When you don't have a repro, please make sure there is no duplicate
report before posting.

Thanks

> 
> Bug Report: https://hastebin.com/share/omisagagir.bash
> 
> Entire Log: https://hastebin.com/share/cetuxoduko.perl
> 
> 
> Thank you very much for your time and attention. I sincerely apologize
> that I am currently unable to provide a reproducer for this issue.
> However, I am actively working on reproducing the problem, and I will
> make sure to share any findings or reproducing steps with you as soon
> as they are available.
> 
> I greatly appreciate your efforts in maintaining the Linux kernel and
> your attention to this matter.
> 

