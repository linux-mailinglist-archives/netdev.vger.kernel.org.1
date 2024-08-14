Return-Path: <netdev+bounces-118492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0260951C70
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5078DB2165C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745211B3721;
	Wed, 14 Aug 2024 14:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPEMgoXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1147B1B32D7
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644026; cv=none; b=gPsKtzzFhctMHFJG0GAGn95RT8h31Pusf8N94QhBKRu+rnvLn41UQVivYi2CjicORkjG0bt3VlO2Tr8kfJxsyGybojyQgic521fE9yYzVI2sU8ePRDB76y+QQ7W/jLTqHjdGo+Ti+HSk/whM8AGM5rtVuuIvNZvLogrMKzdfu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644026; c=relaxed/simple;
	bh=Rm/3lW+0YffOquvhbtAmA9ex5ArcP5gTJnxyJkmvq/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbW6QjEkHhk0K4okNuxlysgVJblM0aVBcscbYRym+dztI4rAQVTKaz/ioz1sT/gF2KKvPWxRITv+ebPVP12XXeML0Q05QUadIulzEfDn/UgW7tGzx3zjFoEQXn13Ftkk9eO/PkHYCC416FnCxg4AtAxvbVgAxr/S8hg7gVEjRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GPEMgoXs; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7c3d415f85eso36509a12.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723644023; x=1724248823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=GPEMgoXsSmAEvWDQVhP2rFop9ZJNj/3fFNafVSOWaTwYSBOlJuKNzKXFQ9KwxG2bsL
         MczgC/FPJ8/gK9YONMDqMXYAhE9phmsVUK2C8Z5BQKKYipxOef2+wgIlXFjniDg1IccP
         kMNg5iFv6ARx+mU8XPwGQK9oFPTRIBbxadeHjetJ3Mxp+yZFsxMSiC8hUOkEEuoulVF0
         /qvVLc8bZk1RXo4s/y+YPWm1rokwlGI88+jTXLXqIgPq9tTjl8gWENDDSbLVyW0zOMuz
         JjLEgL4NKbq/X1de6faEUlJFErtODtoA9Z/t+6fKaEPDUExdBo9pt9n0/DLXbqppdYsN
         OKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644023; x=1724248823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=boVNcWbzJYAOCsH1Fp0qDx5z2eTYTi5RN7VbtWJNv+bXIu9mqe3i0w2eyOstRiUz39
         k5VbAUrJnyUPOBSDdxCoY76S3oDyquYRyx4oXwZ5tNnDsGl7kPZ3/JsNCIBHVKZhaPw4
         AKbBxhYbH8x9N57AKUPFK98J+ZUB5QxV1Q/lGhBse9bevGR8n5VD4b48RbsdDFAsVltV
         pv9s/8rucguL4tCgpwDt0fWuqHv1s8rcioYH+m3lq+aOO8VqqkpKkrUNhudzd7QqK1UP
         JQzdmPQYBXd+9CN6YJnrvbidFcgNlJcN9mTpYeeJg3ikIdgFaFFR/SgjPyh+MmT550oM
         j//Q==
X-Forwarded-Encrypted: i=1; AJvYcCUB3MQIrJNLH3kjtjL3OjmofbExRpQuBd9YM9fO3vCUnVJYk8hWfgjHFMP0fBpDPin7VCjkJow9YYG8DNbVJN5fnh/WPTGQ
X-Gm-Message-State: AOJu0Yx5DxN1F8uG67tmq0Q3ltYtGtSmjswyDZJRRPF9O4bsqzsuFisz
	hZO83woFpixUasqrwA0XOe2ftgOCyAYVmJFJG2f2CaBgZL8lnoxqNXGkct7g/Iw=
X-Google-Smtp-Source: AGHT+IFej6G9ENKms8sCLz4PlMZguobfmGkOJPwW8ux5QRbbPWvSalJ7KlkeiZXZ2VIdS4yhHVtNqA==
X-Received: by 2002:a05:6a00:3915:b0:704:173c:5111 with SMTP id d2e1a72fcca58-712673ee118mr2053455b3a.3.1723644022755;
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a0b5dsm7350482b3a.47.2024.08.14.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Message-ID: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
Date: Wed, 14 Aug 2024 08:00:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softirq: remove parameter from action callback
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
References: <20240813233202.2836511-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240813233202.2836511-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 5:31 PM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the
> entry in the softirq_vec table containing the action's function pointer.
> This pointer isn't very useful, as the action callback already knows
> what function it is. And since each callback handles a specific softirq,
> the callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter,
> so remove it from the function pointer signature.
> This clarifies that softirq actions are global routines
> and makes it slightly cheaper to call them.

Commit message should use ~72 char line lengths, but outside of that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


