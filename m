Return-Path: <netdev+bounces-176846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEBCA6C712
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 03:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8947A9387
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 02:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC31B3E47B;
	Sat, 22 Mar 2025 02:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULavpZtf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DA70813;
	Sat, 22 Mar 2025 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742609241; cv=none; b=M4z7pZzyxIIsKLUwUW0STvUnOjUvqBDiK6AnrdK1Lcbne8+xb7bqMxrh5YrrfgyVgLesggH4cvbxv1D8zqcZS6W8t8IGCykDdbSUes8jXdCcmHmpnhsZqXMAdSMIoZpIxl7cePGV+OQFUeF0D4Fu65v2gqNFjFvyyZvZq/YXFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742609241; c=relaxed/simple;
	bh=o+3A0+n4HCzWRjzZsDtvzIcEBqGn5AvcKHAl64U86Yw=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sQsVtpJZZCtGr1nRTjv5lblWL3JKF8F+BTTLMlEgNIRI48DSaRBUF/tmAHtG7udsNL5h0ezm/mjzHx3FSEnFhpShToq+4r6RLc2GV6YAqHnbkfGm0khQTsl6RLLjO80NIqCsg5lHWdOw1mo0Kif1l8kExPFhbSnru4/v2Ud1ipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ULavpZtf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225477548e1so49806085ad.0;
        Fri, 21 Mar 2025 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742609239; x=1743214039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgUGa8Zy4HnL9nENKrVNGHly8oBEx0+3uIbx2Khl3+4=;
        b=ULavpZtfYLzdal2RFrk1moqYZVRw8Qepg0Z++totlPLJAmJUr2hwlebFIuE/1SATHE
         9pLRLPPKAO7sKNLeGd+3/wuh6UJ1pAIlvaJhTZfKDWxbseFo55cAoLwscAPLYCI8mdF3
         MvAUEYonqo+nnHddSaUYGNjvUBPa1f5+iHSPh6QHS4+QNwR+uO218Sq4pNTdPeuEUH+H
         byf+YH9ehX54UImSr/ox4ERrB9bqDSRUjX/AVt8ga1L1gM8u/XOgGy6KylD5cR7OsfJg
         sldlXSgJvS7Tu3jVGPEJhBPGXOL4vzRqgW9qUcy5G+VlbcwBQShNtV7BWx3TZyuNn4nR
         CQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742609239; x=1743214039;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cgUGa8Zy4HnL9nENKrVNGHly8oBEx0+3uIbx2Khl3+4=;
        b=tPQFdtY4CZt1ygEaXq6RuEhGAZQW8uC4lrmLdssZd86LOFP4D4ZuZteJdroO3Erj1N
         R/NHExbiqNN82+/LrTpiVPnUGrWq4UIasqUjCaqqAjV3UkLT6kQRf7khUYl8EpD5/PsI
         EaViLc5hgzSfUhMexyLIDtLcTOn6VdCeHzMqp5zppTIhfrdjb2jXfV2OIpAqnBUs9fso
         111FH7deGwTirvyyOIENPo7ftrDqhBlJ2ddr+2ks1HJnPB1P7wU//bUC70UpyunboTOZ
         Lc9OWYGuNNZes/dsvhSftC2lufnYmYcBrP1a+F9Z4Or763Sooo+EYA9DrUfjAVkx040U
         1cQA==
X-Forwarded-Encrypted: i=1; AJvYcCU8CoaksI61q5574KfJEBCyFmusEHzjzW4NeQ3s7ynp7lgJilUO3SQ3K6egwTE+gW/dY1Iev/zZq0UWro4=@vger.kernel.org, AJvYcCWcafuFfo+7MuqA23XHlIRoV4+V0x9IugOWM4KZgfV5yYFfR3w3vqdomMkjuZ46pKgueGHssYxm@vger.kernel.org, AJvYcCWo7PUOrP5JLpa2pLGjVTuHpL7G0J8olXv+UhtUgfUdTBu4yfh03PIv6r2JHnlBMdJlY2Yz/+VlLml0cUHjHeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YymPxZz4VBPlaBfAOU9GPVWj//xuHtTVMmZy02u86+AW6obkPHe
	cqUli4rZJHTJwoe0O9W2YBc6HkK+bkHAvKq3qCt9M3oaOfEy49bv
X-Gm-Gg: ASbGncsciM8fIsBWTiquBTZsLiO8S4HCSjXTrGKSg6fWgOVpUl4mSDQBiK5nXCi4CDz
	5BrVaLKzDGCmMlaXakZF2uySKEFNPJOcHw+6/7l0pSHAHk9vILJAScZCe+yOWXBx0NNnx5PwfX4
	tIQcKGQAhoCDQvSCcYta2TDPgrQI6jyQKP/Dox4eZkM0TrDAAYBEfLR/ZVowqtbCj02oLHL6+x5
	+YDjMENIEAK7AAsXUcAL/N5G+axm1rmbkTndv8/ZBxYSvCrAVzp2joOzsqhwFNEDBrt3P5hdbpk
	dg9zLZLKcd92RG443pgKOI0jn+CbyLiCLIfifNKM5xv6pSHC/A7oiGSqOHYI+51Av2nbo5DL/ZE
	i23cy9bpBUuW5sEo4M50Q5MVp/Lw=
X-Google-Smtp-Source: AGHT+IGLVg32rMmKIzPpVWs9HZPMlOJIabBOGSAsw0vabqJF4egHETEku6hjipIWKkKg6BlmY1UAzw==
X-Received: by 2002:a05:6a20:d809:b0:1f5:709d:e0b7 with SMTP id adf61e73a8af0-1fe42f08f6amr10162334637.6.1742609239106;
        Fri, 21 Mar 2025 19:07:19 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af8a27db8e5sm2612747a12.14.2025.03.21.19.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 19:07:18 -0700 (PDT)
Date: Sat, 22 Mar 2025 11:07:03 +0900 (JST)
Message-Id: <20250322.110703.1794086613370193338.fujita.tomonori@gmail.com>
To: boqun.feng@gmail.com
Cc: tglx@linutronix.de, a.hindborg@kernel.org, fujita.tomonori@gmail.com,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, anna-maria@linutronix.de,
 frederic@kernel.org, arnd@arndb.de, jstultz@google.com, sboyd@kernel.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev, david.laight.linux@gmail.com
Subject: Re: [PATCH v11 6/8] MAINTAINERS: rust: Add new sections for
 DELAY/SLEEP and TIMEKEEPING API
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <67ddd387.050a0220.3229ca.921c@mx.google.com>
References: <87jz8ichv5.fsf@kernel.org>
	<87o6xu15m1.ffs@tglx>
	<67ddd387.050a0220.3229ca.921c@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Thank you all!

On Fri, 21 Mar 2025 14:00:52 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Fri, Mar 21, 2025 at 09:38:46PM +0100, Thomas Gleixner wrote:
>> On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
>> >> Could you add me as a reviewer in these entries?
>> >>
>> >
>> > I would like to be added as well.
>> 
>> Please add the relevant core code maintainers (Anna-Maria, Frederic,
>> John Stultz and myself) as well to the reviewers list, so that this does
>> not end up with changes going in opposite directions.
>> 
> 
> Make sense, I assume you want this to go via rust then (althought we
> would like it to go via your tree if possible ;-))?

Once the following review regarding fsleep() is complete, I will submit
patches #2 through #6 as v12 for rust-next:

https://lore.kernel.org/linux-kernel/20250322.102449.895174336060649075.fujita.tomonori@gmail.com/

The updated MAINTAINERS file will look like the following.

diff --git a/MAINTAINERS b/MAINTAINERS
index cbf84690c495..858e0b34422f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10370,6 +10370,18 @@ F:	kernel/time/timer_list.c
 F:	kernel/time/timer_migration.*
 F:	tools/testing/selftests/timers/
 
+DELAY AND SLEEP API [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	Anna-Maria Behnsen <anna-maria@linutronix.de>
+R:	Frederic Weisbecker <frederic@kernel.org>
+R:	Thomas Gleixner <tglx@linutronix.de>
+L:	rust-for-linux@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/time/delay.rs
+
 HIGH-SPEED SCC DRIVER FOR AX.25
 L:	linux-hams@vger.kernel.org
 S:	Orphan
@@ -23944,6 +23956,17 @@ F:	kernel/time/timekeeping*
 F:	kernel/time/time_test.c
 F:	tools/testing/selftests/timers/
 
+TIMEKEEPING API [RUST]
+M:	FUJITA Tomonori <fujita.tomonori@gmail.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+R:	Andreas Hindborg <a.hindborg@kernel.org>
+R:	John Stultz <jstultz@google.com>
+R:	Thomas Gleixner <tglx@linutronix.de>
+L:	rust-for-linux@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/time.rs
+
 TIPC NETWORK LAYER
 M:	Jon Maloy <jmaloy@redhat.com>
 L:	netdev@vger.kernel.org (core kernel code)

