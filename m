Return-Path: <netdev+bounces-187038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4485AA48F3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 12:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 231907B7BA2
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A6248F7D;
	Wed, 30 Apr 2025 10:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7aZyR/G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20E4248F53;
	Wed, 30 Apr 2025 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009675; cv=none; b=DtAFo3OcwQheaxGGJjAevIPeHjsNXWHBK9LxwfhIiStrmC3HXB8sTPuZAVOemN7J6TJotFwOKJnfyauoRPLfRZEYXpjefGiiElSbkvUyLn6lav1gGyWtAZ1yTAKj5ljhRYNbzMIDQ+qidtZqR7zlx54X8eICzcTI/wjKDNPtMFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009675; c=relaxed/simple;
	bh=7EHO5rSorRu3k28Y4Fuh+mSOK59EsFkKnQjXc1jHJMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Message-Id:Date:
	 MIME-Version:Content-Type; b=j30uTTu9/HOyLsO+FFsz/W7q1HL3OPo+SIF/QPpsTw38TCvTgo6L6mEA/gpJDUvhjuMXE32UGApRF7/Qyh1aVf1m6iHhCATat1GgWkC9fZ+YBDdO/StorZcbNg+NMmEP67SJTggAwP2QG9gvLaaEYxq/tKNblxhjYBqMjHxJYa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7aZyR/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F299C4CEEA;
	Wed, 30 Apr 2025 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746009674;
	bh=7EHO5rSorRu3k28Y4Fuh+mSOK59EsFkKnQjXc1jHJMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M7aZyR/Gho2A0/1BcF3xDcsaFcDO/TeVnHtbtjkiglYZycTG+l4FTyFSuhBl2nJDs
	 +V6SsZkebiQbsgIMalOEU6gfATCRvVraZr4/rNw4sq05Lju/gvTUmxoSlJ25mKZJoL
	 k6In9ulxhzn6bsrbrlRbfFRvWSOhxvZNzblmrJcb7vpHBcpvT8h8MoEQVzTRnGIVYK
	 /Jo1UlTnDJzsrCwL/1vPk8ZJn/jx8deJNk0R41uDP4VijDI2XMj7AoiCEUjnt0xoXZ
	 Kt7vvUr8r+/lkVxP6xTExnR5xyUB1/0z7WjkvGurORS0I6ObnFPyV8KGEMGPYKvRVB
	 WC6CCOOCUWTVA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: rust-for-linux@vger.kernel.org, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch, 
 hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
 benno.lossin@proton.me, aliceryhl@google.com, anna-maria@linutronix.de, 
 frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
 sboyd@kernel.org, mingo@redhat.com, peterz@infradead.org, 
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
 vschneid@redhat.com, tgunders@redhat.com, me@kloenk.dev, 
 david.laight.linux@gmail.com, boqun.feng@gmail.com, 
 Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v15 0/6] rust: Add IO polling
In-Reply-To: <20250423192857.199712-1-fujita.tomonori@gmail.com>
References: <20250423192857.199712-1-fujita.tomonori@gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Message-Id: <174600955829.1115960.2726659134001048870.b4-ty@kernel.org>
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev
Date: Wed, 30 Apr 2025 12:40:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"


On Thu, 24 Apr 2025 04:28:50 +0900, FUJITA Tomonori wrote:
> Add two new types, Instant and Delta, which represent a specific point
> in time and a span of time, respectively, with Rust version of
> fsleep().
> 
> I dropped patches related with read_poll_timeout() in this version,
> which we haven't reached agreement on yet. There are other potential
> uses for the Instant and Delta types, so it's better to upstream them
> first. Note that I haven't changed the subject to avoid confusion.
> 
> [...]

Applied, thanks!

[1/6] rust: hrtimer: Add Ktime temporarily
      commit: 1116f0c5ff3385658ceb8ae2c5c4cb05bd7836d7
[2/6] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait to Ktime
      commit: 3caad57d29b5f64fa41cff0b12cc5d9144dacb04
[3/6] rust: time: Introduce Delta type
      commit: fae0cdc12340ce402a4681dba0f357b05d167d00
[4/6] rust: time: Introduce Instant type
      commit: ddc671506458849c1a1c882208bbffed033e770c
[5/6] Dropped
[6/6] MAINTAINERS: rust: Add a new section for all of the time stuff
      commit: 679185904972421c570a1c337a8266835045012d
      [ Changed T: entry branch to `timekeeping-next` - Andreas ]

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



