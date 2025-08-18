Return-Path: <netdev+bounces-214695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED9FB2AE7A
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 18:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054543BC166
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 16:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A1D23505E;
	Mon, 18 Aug 2025 16:46:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D722F30;
	Mon, 18 Aug 2025 16:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535578; cv=none; b=UJStN81u0fuf2B12eb5SsK18uk9uF2ZkIHHbq13LIGnuoKqmX5SdQ1r0MyolNT6qIW37qRFZdMr8UWjcsoAJQ8AMJOXAd4ECU0pGpHerhpU0p+1p4x53x+zahYynSdPjPU+nrUjsa2GmTRYy2SHWjFdTMu4pTirf5W5y1EiSGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535578; c=relaxed/simple;
	bh=iYZBCRkGWlqsq9n2KpK3cWf5WnuK8OJVtWX91GM5Y04=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=evz02gHYmrZFLDDsKmf2qOnCwbbvcu2pY2Dh4UdQz8LgC80IR/OKgbQH37eVPLJA3O/X19Ohdd/DZ4b/UtTwlKTq6P2GJnrtltDuHM7dRHnGOG7JyML9GP82x3jBmAAqPEyZozORMOJ2vd7EQb7K61NTyt6DTYqMQ2JI9BGmUfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea0bc1aso73828b3a.2;
        Mon, 18 Aug 2025 09:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755535576; x=1756140376;
        h=content-transfer-encoding:organization:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PfZtpxaBwToRw8IM0N9Q3IKfSVCElSplTAz81FDm718=;
        b=b8cR8zUVGNb5dcC64FwAU9fJ1kz/HyK8G3dt2yd3iDDr+Hf9M2uehu37UtY+YnXGOD
         ZUzcCOgFUgM6O2tYHZb6eG/xl16yms2UypWXM48KSCpry0oWojSqQiEAe2uAoWq5ilhZ
         yMWXVuZhTqLb+JMYWHyd/40/VcUKJMSgSKCgHAl2yMmG+BPrrl8O8JuPAN6vidyVJw41
         /xhmEMnwUBTtejKrb7cxRDuEMAUHUGTMZy+pdmm0K86WDI523rWD+HufztnfQD1qP2Y+
         QlKFlJwROZQ/TOGW7BoCQiSEzK66zjuuZMzMg88bhANzmYvQi415Y6DfsKOhRsLbn5Qw
         0fJg==
X-Forwarded-Encrypted: i=1; AJvYcCUTt5O1LifHkVTzUXx2uBASA4NBM+GYbXGoXpVafs4Pnu7VIya18IyVPuFUurR/K86KcnJwTDzv@vger.kernel.org, AJvYcCV7Z9rEQ3N7qsWWp4hfDx+8tk9Pqs7bdLDZkg8FvotHWpsUkSsyUM5gwSBO92St1p5Ww3gVW1LyzQdJPJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUPVG24MCfV9Dh5XTwBKCM1yqUKuBPZoBhKwt78mmmVHsBR77
	6dg/4dxYipg6YWq5chKOK640ztjEEQwp5NKxO0EAZGy8PxEXnrlOu2oAb5nuqw==
X-Gm-Gg: ASbGncukliGL3AC2RGzbd9jymYpnSYdw0LJtSBpw0rhifKrAfWkMdC7H7NwYOijGqZb
	vlMUWDeCglDI+AdJGopHBnvUzIG0lk2Juhed/52GJRAbkEWuyxGBpU2Rf1bibIDiYSFHtxIbcxX
	kgPKeeIZvGLcbzZRXTzcuGGtVGTwkYKjTFMWfakLcfOOgiaH9K6BPYA/IVMfKDSHBPc9LIgrio/
	wdWa2UQflAQqvq1YGQQdejw8miQSdid7TMHbSBb9J6R7jBGLG5ZzC4r5HiWFwJOr3JHiBPse+93
	dqM3RLa8ASap8z/ozrVONm3aR3c0wNuCg2fH9aBFhQKH7zIq7mEVoMk097AjX9Pk5EBjcOtxxHX
	+IggzRHUbksjLDHbyPQfAW5rbOTYjiPhLYRfLqaNWvoQ=
X-Google-Smtp-Source: AGHT+IGXg7SFfXvXlQhuGYRZJ0KW95XWEuKEc6wgCSaBEYsZvTUjPxgWzwonL+HIDTjQKj+cMMnBnA==
X-Received: by 2002:a17:902:c952:b0:240:2bc6:8ac4 with SMTP id d9443c01a7336-2446d6f55f4mr84284315ad.1.1755535576068;
        Mon, 18 Aug 2025 09:46:16 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f835f7sm11758344a91.1.2025.08.18.09.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 09:46:15 -0700 (PDT)
Message-ID: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
Date: Tue, 19 Aug 2025 01:46:10 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S. Miller"
 <davem@davemloft.net>, Florian Westphal <fw@strlen.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
 netdev@vger.kernel.org
From: Yunseong Kim <ysk@kzalloc.com>
Subject: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
Organization: kzalloc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi everyone,

I'm looking at the inet_twsk_hashdance_schedule() function in
net/ipv4/inet_timewait_sock.c and noticed a pattern that could be
problematic for PREEMPT_RT kernels.

The code in question is:

 void inet_twsk_hashdance_schedule(struct inet_timewait_sock *tw,
                                   struct sock *sk,
                                   struct inet_hashinfo *hashinfo,
                                   int timeo)
 {
     ...
     local_bh_disable();
     spin_lock(&bhead->lock);
     spin_lock(&bhead2->lock);
     ...
 }

The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
enabled kernel, spin_lock() is replaced by a mutex that an sleep.
However, local_bh_disable() creates an atomic context by incrementing
preempt_count, where sleeping is forbidden.

If the spinlock is contended, this code would attempt to sleep inside an
atomic context, leading to a "BUG: sleeping function called from invalid
context" kernel panic.

While this pattern is correct for non-RT kernels (and is essentially what
spin_lock_bh() expands to), it causes critical issues in an RT environment.

A possible fix would be to replace this sequence with calls to
spin_lock_bh(). Given that two separate locks are acquired, the most direct
change would look like this:

 // local_bh_disable();  <- removed
 spin_lock_bh(&bhead->lock);
 // The second lock is already protected from BH by the first one
 spin_lock(&bhead2->lock);

Or, to be more explicit and safe if the logic ever changes:

 spin_lock_bh(&bhead->lock);
 spin_lock_bh(&bhead2->lock);

However, since spin_lock_bh() on the first lock already disables bottom
halves, the second lock only needs to be a plain spin_lock().

I would like to ask for your thoughts on this. Is my understanding correct,
and would a patch to change this locking pattern be welcome?

It's possible the PREEMPT_RT implications were not a primary concern at
the time.

Thanks for your time and guidance.

Best regards,
Yunseong Kim

