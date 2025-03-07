Return-Path: <netdev+bounces-172928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F4DA56861
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 13:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E827A7B7B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E5219A81;
	Fri,  7 Mar 2025 12:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6nm5wfh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C521218AC3;
	Fri,  7 Mar 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352358; cv=none; b=LsBBgBhaWy+PEr2OHCzRSl/rzFUWU3CSyatRyBXjrIF69H2Tq/3TZFvUJLhho6SPYbalUpE+B02AAUb5YXaDkvRkPlROYWGbAoYq8uRxgN/UfRk0fR3QHEPHL67y90iVjDXlQp814rKfqxIu91/053VORFU270zAQthMdlrVLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352358; c=relaxed/simple;
	bh=jaIDK7Fq4dVHOnnSVdRxDVakvGQal+OspeI/b/J6fOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RrwgDVu8YnMjPsQDqrWi9dLGNIWzgnlxtUIDrVgrRjGveOgZKj+/xUgbYg+39QpoW7gZ7rbXIPmpdS5gMWBwwuUicp1YsK/tt1ggxA3seDymnzxsRTil1H2xzt1S+N3/ZjQm2bLddvOUaZOEQPhDSl8RM/OUQi30Z0IH1b7pfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6nm5wfh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224019ad9edso44504215ad.1;
        Fri, 07 Mar 2025 04:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741352356; x=1741957156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQZEmTlUblH/vyrYcqRiI5vF5EDt8yhcInltkICsZDA=;
        b=i6nm5wfhmN8z4IbFnr1aFyI6pxhIufHlMBS4ghi2t3bD6XelMJ4jgPBwHrQLodyW7z
         g8XhVrrXNo1BG21n/jr7F1el9vaAmwqqlcJzxW5B+eLVsdCy873C4qvQdjOAgrW6F1ez
         Q2E8kFLqV4Ai/lol/GoTZgm8hY/eNSKv7oAsDdhc6fb4OiWjslIaTMXIgO5lAUgRMViY
         dXQwIdF3ewVahFkzSAvlCI89RXHFu3ZeTlcWhgfdFWtVO/hHM+klVfsQuKCxTLqJbTrt
         ro1EQVtN6sGeX6ZHjiEe1wSjxQP6cUrN+ZOiAHi7+XeUUKQ01e4UMR7S2BFYC3CEac7X
         UtvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741352356; x=1741957156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PQZEmTlUblH/vyrYcqRiI5vF5EDt8yhcInltkICsZDA=;
        b=qjuot5nr5y2ns4KGXt9jmyAkVP2aK3wYfW2NOd0tXg80wgl7uHKLAm50mwfEIMo8or
         u+qBpZARAmIm9nZuwFtsDWL3ghJao32Tapv7PGAZsf2XPN4LlpNJrHNYPmGJ9IUepJSR
         cbmEDveDuINEqGoORK7yNvGGD0LHsbzpMDlCvlLho9KxaJzuzNCvNYYfok0ROfF+WXYj
         i2hemlcgilVnaygpQGQhDKjZaaYpzBeL9TGlZfuhF6rb69sgRzBFMD6yoRG6D9agMOD3
         xWJ1l8EdEdeHZ7kFvAryEFDe5CdObJHJB7zDYBUOj0l7XG0/gLvuhzRG1NkzEKnxOuCv
         PcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlZBBverm5l5D9bFQcU5UvG7hlYXgIQnRnVOnmd7TSIdKXTn09zFRA80RA5L4lzgDLh+G7uOnh5v/hcrA=@vger.kernel.org, AJvYcCW/eUWwL0AkwfsrP2G8ywXWOHeam7xs4cDAD6v+hDeJR5Y3gT3Jekc+u/DrcTnzOKYJxLb9aTrW@vger.kernel.org
X-Gm-Message-State: AOJu0YzAk4/RzYdnj9OXprSEzGYGhdnimSL/TTDD9Vbqbw5xsVs/ap4k
	Q2x5ImYECvIcklulAnt0IpcfSVO3GiRZ954UNn4hDYAxIKF1mtqs
X-Gm-Gg: ASbGncuEMdZj0AfJad5gh2jyplEaroSCM2O/37xpBeZ0rfp5zVwBLOKrBC0IiU4swRX
	mmbTPitGDCFdmzkHhLH00cMWzEWFRkz1NhWNehxTlnZo/4Z3xX+gwSvPdUGg7NXUpU+V8QtUxTV
	1w16SBkIOPnN/lfu2sCeUTqndzgD/hfJLTSNG4XZOG1QAlgH9yT1FWL+4Qf+L/26bTppB/Qd4+Z
	xjetgmTPhm0N6Kn6ZppgLB9XBbJDkwGbtVRsqezMFAY4WxzWoZ58BnVRgbcy0kdlZQzb+oxIULh
	qGf2WAGDFjmDblDxcbfJ3hq9vQi4n8M/H0TyzYM92eZQRrkxF5j/aFccpz2EkkdQtFSw5k+9S2z
	HJbBzrqXQN4yzdjzkk4B5HhkjnmtXbmc=
X-Google-Smtp-Source: AGHT+IEt/uDSIgEFYoRGDQTYDcqJlI1BOtx9pSztYKovJPXukDkoC2bulGQ71gxd/ADZ0mgcNLMDEA==
X-Received: by 2002:a05:6a21:b94:b0:1ee:e2ac:516d with SMTP id adf61e73a8af0-1f544f3b130mr6954882637.30.1741352356484;
        Fri, 07 Mar 2025 04:59:16 -0800 (PST)
Received: from localhost.localdomain (p12284229-ipxg45101marunouchi.tokyo.ocn.ne.jp. [60.39.60.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f723asm3238072b3a.96.2025.03.07.04.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 04:59:16 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: bp@alien8.de,
	peterz@infradead.org
Cc: boqun.feng@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	ryotkkr98@gmail.com,
	x86@kernel.org
Subject: Re: request_irq() with local bh disabled
Date: Fri,  7 Mar 2025 21:58:51 +0900
Message-Id: <20250307125851.54493-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307115550.GAZ8rexkba5ryV3zk0@fat_crate.local>
References: <20250307115550.GAZ8rexkba5ryV3zk0@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Boris and Peter,

On Fri, 7 Mar 2025 12:55:50 +0100, Borislav Petkov wrote:
>On Thu, Mar 06, 2025 at 05:19:12PM +0100, Borislav Petkov wrote:
>> On Thu, Mar 06, 2025 at 02:45:16PM +0100, Eric Dumazet wrote:
>> > Hmmm.. not sure why local_bh is considered held..
>> 
>> Yeah, it looks like it is some crap in tip as current mainline is fine.
>> 
>> Lemme see what I can find there.
>> 
>> Thx and sorry for the noise.
>
>As already mentioned by Mr. Z on the tip-bot message thread, below commit
>breaks lockdep.

Thank you Peter for letting me know.

>Reverting it fixes the issue, ofc.
>
>$ git bisect start
># status: waiting for both good and bad commits
># good: [848e076317446f9c663771ddec142d7c2eb4cb43] Merge tag 'hid-for-linus-2025030501' of git://git.kernel.org/pub/scm/linux/kernel/git/>hid/hid
>git bisect good 848e076317446f9c663771ddec142d7c2eb4cb43
># status: waiting for bad commit, 1 good commit known
># bad: [f4444d22a90c3fb0c825195b4154455d42986f21] Merge remote-tracking branch 'tip/master' into rc5+
>git bisect bad f4444d22a90c3fb0c825195b4154455d42986f21
># bad: [6714630acf3cae8974e62a810389dcb191ac49af] Merge branch into tip/master: 'sched/core'
>git bisect bad 6714630acf3cae8974e62a810389dcb191ac49af
># good: [156a8975430b127b5000b9018cb220fddf633164] Merge branch into tip/master: 'irq/core'
>git bisect good 156a8975430b127b5000b9018cb220fddf633164
># bad: [468fad69db143874eaaeb472816f424e261df570] Merge branch into tip/master: 'locking/core'
>git bisect bad 468fad69db143874eaaeb472816f424e261df570
># good: [f5de95438834a3bc3ad747f67c9da93cd08e5008] irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
>git bisect good f5de95438834a3bc3ad747f67c9da93cd08e5008
># bad: [5fc1506d33db23894e74caf048ba5591f4986767] rust: lockdep: Remove support for dynamically allocated LockClassKeys
>git bisect bad 5fc1506d33db23894e74caf048ba5591f4986767
># bad: [9b4070d36399ffcadc92c918bd80da036a16faed] locking/lock_events: Add locking events for rtmutex slow paths
>git bisect bad 9b4070d36399ffcadc92c918bd80da036a16faed
># good: [337369f8ce9e20226402cf139c4f0d3ada7d1705] locking/mutex: Add MUTEX_WARN_ON() into fast path
>git bisect good 337369f8ce9e20226402cf139c4f0d3ada7d1705
># bad: [8a9d677a395703ef9075c91dd04066be8a553405] lockdep: Fix wait context check on softirq for PREEMPT_RT
>git bisect bad 8a9d677a395703ef9075c91dd04066be8a553405
># good: [5ddd09863c676935c18c8a13f5afb6d9992cbdeb] locking/rtmutex: Use struct keyword in kernel-doc comment
>git bisect good 5ddd09863c676935c18c8a13f5afb6d9992cbdeb
># first bad commit: [8a9d677a395703ef9075c91dd04066be8a553405] lockdep: Fix wait context check on softirq for PREEMPT_RT
>
>Author: Ryo Takakura <ryotkkr98@gmail.com>
>Date:   Sat Jan 18 14:49:00 2025 +0900
>
>    lockdep: Fix wait context check on softirq for PREEMPT_RT
>    
>    Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
>    PREEMPT_RT."), the wait context test for mutex usage within
>    "in softirq context" fails as it references @softirq_context.
>    
>    [    0.184549]   | wait context tests |
>    [    0.184549]   --------------------------------------------------------------------------
>    [    0.184549]                                  | rcu  | raw  | spin |mutex |
>    [    0.184549]   --------------------------------------------------------------------------
>    [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
>    [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
>    [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
>    
>    As a fix, add lockdep map for BH disabled section. This fixes the
>    issue by letting us catch cases when local_bh_disable() gets called
>    with preemption disabled where local_lock doesn't get acquired.
>    In the case of "in softirq context" selftest, local_bh_disable() was
>    being called with preemption disable as it's early in the boot.
>    
>    Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
>    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>    Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com

I'm so sorry that the commit caused this problem...
Please let me know if there is anything that I should do.

Sincerely,
Ryo Takakura

>-- 
>Regards/Gruss,
>    Boris.
>
>https://people.kernel.org/tglx/notes-about-netiquette

