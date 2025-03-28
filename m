Return-Path: <netdev+bounces-178167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F147BA751AA
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E0C172087
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288201E8357;
	Fri, 28 Mar 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdtdVYXj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A414AE545;
	Fri, 28 Mar 2025 20:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743195202; cv=none; b=RAVKTHi7wqj7Ur9EMN3SXxVO6uigwbBp2CuslH5o7pWVA1HbVcTWrzTgZ6v8N731lggU583Tgfdx/KYhxAEJYai2SlyPE2vS98SlZFd/GZjce5M3Rre6NDDUH+FDJaBoljba9i2YUasOG0if9Y7xOdLpvH7QIxNQinbKgfV2mDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743195202; c=relaxed/simple;
	bh=L1sxyt2yym+IHesz0d2Q6lVQk6i2aCG+WS1RD3gldYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZXyFOtT/zKfVxh8Sa5yytPDZwXTjUqPfNIvgkOgTm8c0wFbj/CVhlN6eSqLH1fwXrImTtrHv36L6tmn1IOSUXVsm1DTWaVrn4SM8Xd6GKgC3ayY+IE+z3q55WrywfsESMOjunpU0UkUUeKbbgd7PXl2pwXkVGagsRJdh30zcO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdtdVYXj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227aaa82fafso56196595ad.2;
        Fri, 28 Mar 2025 13:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743195200; x=1743800000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GJQ1Sn7f/nJpTYs+G8/LKPPbwUGACYMbIrHKliEJEzc=;
        b=BdtdVYXjthhpNy9+tzfYA23YlIhRTnMpXPh1l1A2GXSm11cyX1NvjAZQxw0cJ4IkC2
         nfKdQmgElKgcIW2x4RLFqSTtBNYyiZ6uZXoYuh6OeGV4j1vCAiRw0qzeHvxUHCLo67jq
         FQqFDCMLF9QA0zIgnFESjva+eCO5vP5+8zL47HkIPgcMBGDAnaLGqQdE6rAoiG9alHWg
         jvkkDyGCuriclWlAWisirmHEVNFEHvMJFtOSa6sLNdIZCI5XC9Rm7w07LfnwHnh5sNL/
         vCbo51jW3s2S433Gdhto7A1S97t1U6W+TLecIOgq3udzko8NL1ERbR91TyjCqBh4NlIr
         qvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743195200; x=1743800000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJQ1Sn7f/nJpTYs+G8/LKPPbwUGACYMbIrHKliEJEzc=;
        b=NQ8A1KlRccF9cG23R09HzaDcPnst4CTSYSBTmRPgfIgAb+pL1NADMC/VVCut8h4+4B
         8+P2Kjkb9FEDG5Lc8HPYPcyvPOCNGVnedfCI93fGHAQeq6oV4/iWmjDRoYCXJeEUtjiD
         3dzGxoss19Tf5muU0iMZtgCPRTfVIvTzl7B4z2TCQE7GrFUNZv167zt9FvU0a4fA0LHL
         kxrUsh4d/ZxUDK5WKRPLLrMfRBFKT0064jxrPCh60Oat8w87pW5FLX/quyGmiypE4Xsk
         FGZiKlxOgr963HMWyTbbRoOpE7Mee0KcrjImI6gNRoUHci4fCuUHPnZJgbUPHfIli/Yi
         j+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCW2cvpT6YHSIy8dEfAMC7uYxv1mUHpqA00yDrUSacOI34R3U8bdAPw22Z5Hu8vh64dso4nGnlxy@vger.kernel.org, AJvYcCWNJhi710PhEDIKvyM5VZsJo/H8um4S/FLDmUxihXIub/irlvcDiO8s5EBcxYca231wSeW1ubMRyIe4MGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcPQyWy+NicAC4KdqGs3l+VIW+Ot9IJ1jA1Q3Cx+vTF817GDc
	f3cyPSHWBr3Hi5ezyMo0Qc0v7nCIIxE0e/dGkBVPG57gZQ8TiV25
X-Gm-Gg: ASbGncvIZsSQH/HFO2Z7sWIOK6hvkjShlcC2gptTa48IeKx8Qa8x2h550aLXlC5cHpC
	+MFCK8K+cf5zHWay7d4DkGiJWmdd/wqf3/RIN3rU0I+UfFONE6ssbstyEd9ZJ9fvJXwpGY1e4Bn
	IyGKwvn/rbsdgfXuZLrSmn5X97pUS+SDicG9ezMpBcCUe/o+kx4XNUxUa/hG1tWHoKIdAQXio1u
	0ZuCsPHNaLpf4bwxUz7zkVguOP0NJA1nfofFOjap7GLkeZFoTCswUduFBXP0pWOczK/vIr/25og
	QPuUBqt9XKa4sqaFJ9AJGByXfSHxubNSojQQTpNgu/p4delM
X-Google-Smtp-Source: AGHT+IFDeGZ9vPA9qpQBzEUA3zSpURmz+wGI4PNW09mhj213tqyA/4063foRlK1avSu9yQpmRJpiPw==
X-Received: by 2002:a05:6a00:1395:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-7398034e500mr940648b3a.3.1743195199526;
        Fri, 28 Mar 2025 13:53:19 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970e271absm2340148b3a.51.2025.03.28.13.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 13:53:18 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:53:18 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: syzbot <syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] kernel BUG in skbprio_enqueue
Message-ID: <Z+cMPsPQfpEFJz60@pop-os.localdomain>
References: <67e521f9.050a0220.2f068f.0026.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e521f9.050a0220.2f068f.0026.GAE@google.com>

On Thu, Mar 27, 2025 at 03:01:29AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a14a4c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=46a07195688b794b
> dashboard link: https://syzkaller.appspot.com/bug?extid=a3422a19b05ea96bee18
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=109e343f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1037abb0580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmlinux-f6e0150b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d/bzImage-f6e0150b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a3422a19b05ea96bee18@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> kernel BUG at net/sched/sch_skbprio.c:127!

I am looking into this bug.

BTW, it is not related to my qlen_notify patchset since it is not yet
merged and this stack trace does not even involve qlen_notify.

Thanks.

