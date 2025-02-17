Return-Path: <netdev+bounces-166880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858ADA37BA6
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41673188DB34
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E8018FDAE;
	Mon, 17 Feb 2025 06:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bsc5QVQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5A118DB3A;
	Mon, 17 Feb 2025 06:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774699; cv=none; b=bBpueUULvsfOWqUhMr/Rlhk7dbofL4tyV0WAjRSNCUng68WVQBNkXXgk1vseKkGXIFB+rhc7M01lDUBY8bbhTaCcRpNt7EAnQz6LTgsdM5q+r1QllWJ6rj+NQQ+rNktNxEyA2YFiay/4I4HnHxYjxdxmlQG6CqiedjPW+gJI7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774699; c=relaxed/simple;
	bh=md/lpDnAo609oAWNd+abGOkZvNFG+kd6vqP4C+99RjA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JMqZkKVxjRazapd+dIgpXN+L3hDSpQbhTVABBlPEWbxUiwv9BGJ9zLhwZsKS0+9WlKGxL3WUOk6tzESyNcy1xdGiarBTLBlxdNIEP92xlE0kgFtLhjRMQuojOO3qpIsH36+VzNAanCjMbV18o09ZJ8OwUSSpuml0j/+bj5VurGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bsc5QVQu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22101839807so40494115ad.3;
        Sun, 16 Feb 2025 22:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739774697; x=1740379497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7stU1qzbS/iaAbPz24YCnz+4u8W0DRjOhkh5NvOXgI=;
        b=Bsc5QVQuiN5ssw+IXhm7kRP4DNJjwae3CF5XUf6GjVTrjf8Q/9azKtha71L4Vy88bD
         hJu8D87FjOiFrmsqWYcKGVvrgMU0RuHs3h+bwS4Gv3TZ4qsMK7ZqILkktIF8qJ7TZqhk
         lI5uvF5ZYvQcPhkaSjoEpEEtFBq3JdhDdtCHoKU7Ab7R5SfvUDUnWQAQiS3UEyE9KYlB
         lajSzaxgrULaqhDoxJNJ+h+hiDvpOl0B9L2Tv2yk16z9f4hYiYI0fgZ8j3KP/ZHDIOJG
         G/6sqtWVOIsZwbrBAo1U9Y/1NT63E59jrBpIyWywb9aDPNbQpKaRwJucuHFFkM273cMp
         58uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774697; x=1740379497;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v7stU1qzbS/iaAbPz24YCnz+4u8W0DRjOhkh5NvOXgI=;
        b=EgvECrVYapN2W/cd0I7EdjbBleUImPgXRAVfFrwowvKokac5+SlREgXF/Yr+dhjX+0
         tnJQVDeUzFZ/cGk6Rx5qG7jZ8HNAiN8z1safcAoeWTurBPPz+hUNNWOfcJGioRglvzCI
         Qxk6WHwsJL0BBsKWIfXEY2pVhHzafUjEtZKxo/tzzMQ8EyPp+Mb3yZA5rWZP5OeaRzVm
         Z6lp2B46YgEhnc9rb8KRBQIBPDllp2i1xEx4gjrx62eyJICoBt5DpeLmEl0oiteK5Wtx
         04cZ9IUk2FT/Zk0UNYf+1QN30K1HyROGdUsvxfevJ+OshX8igTAiDuYrqNkVKr2o5wcf
         GQPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBopICEWSIsP43ih7cK6lfGnObN2gEtnR5z7JmRviar3Ec1eN+DMInbfi3sMA4EnusIA0kVbfhiSO/uCTXeQQ=@vger.kernel.org, AJvYcCWDCIG1f06a+Dgoh+aAyIajf10l59zE3S2+zOVbiEUCM69z00liDBx89h660CH0cAQUPA3Qx/J0@vger.kernel.org, AJvYcCX4yJ10yGRsQclsc4IkxHsqyEujOALIkwvkh0fO8IFKGxfHOntBwkwufmQe0dTn27YAGZOoYBdMkBVpM9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMu9JQ16tFUqEse+qcdyeElouh5AmIa0BH+A7pDRebjLSjbg07
	Mizx6gwZcUYbfO5jiRd+CIsZAQ40MIed3NbYwp1QhE5iegZ7yXI0
X-Gm-Gg: ASbGncvoesasoGSCsZsahD5LYQR4IiYsSOoxhNZ/+WW4I1oC9UW1mNu5auJSaA2ctwJ
	Imu9RP2+ENDQHpTNmFC6f5v7FOUsXtOCyzcCYZmIy3AUp4/RPl/9OrbE3d4R7861mhG3pAchTtW
	A3LhHaObzDT0aJN8d2rCPN0KwR6ft2FAPgWl0ompV25yijQPwsXyDA07HOOjSw2hraNAg2hAgoo
	CgoWJfgg/kdC5uaZ/Cyk+iigz5KJiUWb32ByC3Un2SaMVqDEIVCJCTQjp+GSNJ80xb2+94HpW/W
	ZOBPGEt2An8ktiaPpb2FWr4DAEzYcrvyf49HCTNc/Q5EOVkh3tzA1yY7eW0vASEKRgI5WInG
X-Google-Smtp-Source: AGHT+IFoyTYrN7NiqiTez+ONY52wDTsauvubF4UeNibcYm8CqC6HKwCfDSOyA8bozM6HLAJY7r3A8w==
X-Received: by 2002:a17:902:e5c6:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-221040bccafmr126358905ad.37.1739774696790;
        Sun, 16 Feb 2025 22:44:56 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d638sm64440855ad.147.2025.02.16.22.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:44:56 -0800 (PST)
Date: Mon, 17 Feb 2025 15:44:47 +0900 (JST)
Message-Id: <20250217.154447.1251064594176317463.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: aliceryhl@google.com, fujita.tomonori@gmail.com,
 david.laight.linux@gmail.com, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de,
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de,
 jstultz@google.com, sboyd@kernel.org, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 1/8] sched/core: Add __might_sleep_precision()
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <Z7KWJGc-Dji3Kacu@Mac.home>
References: <20250208.120103.2120997372702679311.fujita.tomonori@gmail.com>
	<CAH5fLgiDCNj3C313JHGDrBS=14K1COOLF5vpV287pT9TM6a4zQ@mail.gmail.com>
	<Z7KWJGc-Dji3Kacu@Mac.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sun, 16 Feb 2025 17:51:32 -0800
Boqun Feng <boqun.feng@gmail.com> wrote:

>> > >> +                                  unsigned int offsets)
>> > >>  {
>> > >>      /* Ratelimiting timestamp: */
>> > >>      static unsigned long prev_jiffy;
>> > >> @@ -8740,8 +8723,10 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>> > >>      /* Save this before calling printk(), since that will clobber it: */
>> > >>      preempt_disable_ip = get_preempt_disable_ip(current);
>> > >>
>> > >> -    pr_err("BUG: sleeping function called from invalid context at %s:%d\n",
>> > >> -           file, line);
>> > >> +    if (len < 0)
>> > >> +            len = strlen(file);
>> > >
>> > > No need for strlen(), just use a big number instead of -1.
>> > > Anything bigger than a sane upper limit on the filename length will do.
>> >
>> > Ah, that's right. Just passing the maximum precision (1<<15-1) works.
>> >
>> > The precision specifies the maximum length. vsnprintf() always
>> > iterates through a string until it reaches the maximum length or
>> > encounters the null terminator. So strlen() here is useless.
>> >
>> > Alice and Boqun, the above change is fine? Can I keep the tags?
>> 
>> I'd probably like a comment explaining the meaning of this constant
>> somewhere, but sure ok with me.
>> 
> 
> Agreed. The code should be fine but need some comments.

Of course, I'll add some in the next version.

Thanks!

