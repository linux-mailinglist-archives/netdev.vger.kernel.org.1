Return-Path: <netdev+bounces-118938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD00E953910
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 19:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558DE1F24124
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2B4778C;
	Thu, 15 Aug 2024 17:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2fk/tckh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A13940862
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743343; cv=none; b=sQ3I7Xge4VL0bnuWnqkTlvPwY3bM4miyU8ylRQIhOpY5wbUb3kGgPWmIvznxTOsMZyF5RqcPF7A7HTBU7SSkZr+na5kZIXQWOAQlGwBwtqu/Hj7Sas+DlU3Hh0X0byxQM9DKuyD/JxD721R5ril+PIXQ5RMoAVicQyECrX/XgWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743343; c=relaxed/simple;
	bh=yTQ3x9UK8HBDNuDJlzJOqJNNTmm6uXlvMqRj0y1jNzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTCJZRM6G0FBCVQ5gCEgrbBTme8uCQ6cZeIVZUDVeiMw4C67R3eGKIthfav1zZHCFmM9htStCe63yxLS7Hu+PE8Ep7Y4rMM9zikUZjFd3mwnh1r2DtzottZK5uinzpCKZ1TAC6Lrm1sHvfdrOQZSmFlR7IdpmmZvqGZcpCpeu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2fk/tckh; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f8d55c087so5434739f.2
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723743341; x=1724348141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=2fk/tckhwHrgEPxypfU57kGwGU79+ji1zWxkBnG+t2cczJnyCfZy2W4Ojwn4f0/U5d
         VM9DJIx0d5RN7w4CcgODgkQ18seVXLstHSfsAaQUZS5zw6gdQVr+xcbgCjqKKGKiNcAw
         V5fALKlo/YAEE8ho6hnBvhlYY2coj1fgdHzzwzxBokTNwTGTXCgu/WwJh0Eicsdlcuum
         wQ1nrNXo7Igvh42zh3LcplUcxH5V0gBzIYMHvVa0sI96Ok/iCwv1m97AjBujczK2UJ8Q
         xdICV1pLGQym7JPgWs14OXr8QPjZNKqPZhjgkfKL7rNkSdqVqv1WxnnyQh03ZPCYlkQw
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743341; x=1724348141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=jrs47cAeSRqVjTdkE+iI9w3WRJ2qSlRwVQm+Vjjh84bHtFqxbpddw1/9kDVlJSLBL2
         zq/Bp5n/B89VY7O3dQgmtaqP/AW41jQR6IfdCTAsCyFf2/PZoLEXCPTNIj6TBvLzTpVa
         BZmDRtBm0funkiwBzJLhbWBlyJI4U7w1zFC04mvJdJh/KdFj6S1vf72+DakHvd6v4r5G
         HwoFSsBVPj5boqGXKgxVR1o6u8wV2wC5xH3V6hj7XJbo35dZbcqlqI8oBIQZTI3sjbV6
         QU9ogNTd+HiOFSQgDPOR8deFjCv8h/0twDIBJDfWu2HLrTEvaCWHoi8p9qsh6MHBdhrq
         DVbg==
X-Forwarded-Encrypted: i=1; AJvYcCVk70yslz/3DN+tIL0vdsX9q2nTohsNg2uzThFe+WDs0R+wHK4nuKuTT0ye+N63DC1V6qfr2NrxwmSDVakRI1vrCYccN1XN
X-Gm-Message-State: AOJu0YxmC12B1VKQb+Qx5XlxoGYlERwdgfpUhfjkJg/OUYzkBaMEWRt5
	NURXR7nSOfaMsXLWt7lsdSkXBRHJ3mIDkevAOkRAzmy4CWKqipIc3EFPR/TpaxI=
X-Google-Smtp-Source: AGHT+IE5ACwMUbOKC8B7NJcnH44RVQzKIjxHde1N8h+vFIG7O/NuCcv1jNns9/9MwYQlU/mxJD+4BA==
X-Received: by 2002:a5d:9f4d:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-824f26e3004mr33789339f.2.1723743340509;
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e9395csm617646173.38.2024.08.15.10.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Message-ID: <8db12b3d-08f7-4c3e-a403-177285b0bcec@kernel.dk>
Date: Thu, 15 Aug 2024 11:35:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] softirq: remove parameter from action callback
To: Caleb Sander Mateos <csander@purestorage.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org
References: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
 <20240815171549.3260003-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240815171549.3260003-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 11:15 AM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the entry
> in the softirq_vec table containing the action's function pointer. This
> pointer isn't very useful, as the action callback already knows what
> function it is. And since each callback handles a specific softirq, the
> callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter, so remove it
> from the function pointer signature. This clarifies that softirq actions
> are global routines and makes it slightly cheaper to call them.
> 
> v2: use full 72 characters in commit description lines, add Reviewed-by

No need to resend because of it, but the changelog bits go below the ---
line, not in the commit message. Whoever applies can just take care of
that.

-- 
Jens Axboe


