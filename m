Return-Path: <netdev+bounces-176817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F05EA6C460
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 778783A8C53
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 20:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE30230277;
	Fri, 21 Mar 2025 20:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0y4gIFM5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/+d3Xmy7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323541D5AD4;
	Fri, 21 Mar 2025 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589530; cv=none; b=pYxfL1cnVdckPYT/Ept+Ce9J20eidCzJbvGfmllcMrzQVeRMbPgTZL9MEJmndLNHy6jb63dWcP0Z5ULXTKJ5UE+0KrdlLUpIAFF9cot7VUEXSXJCMkFT1951lvg4TmcsnJoqsWdPuL9Q1Js9zV+yjOQmpaBUmwuzyZo2w3LhK/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589530; c=relaxed/simple;
	bh=8RjxbWDW/i69LK0w659MT1nZJrKwlwIZ1efwQ7T5VSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nNWAS26yndwold1g6unzzcZZeKWIw85f+5+YKVzxdr9P8Yl7aMHzJMxBGcZAYgD7dwljmFG1qdIkLBIbbPGbUk/SfuWehVMZzeNkJrU912hFlELRjw3o8osK/2GoZf/R51l0umIGOANpmZDefWoardHsvtDiLcOx/Tl7u+/BF54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0y4gIFM5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/+d3Xmy7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742589527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOtohB+AKI748h04VvFfjvO0Ky51rTdztfJFNReMd6c=;
	b=0y4gIFM5b1fRGq5GX5LD0gY6UEsfjqARtLJwS8pVDLjOwM8eSkp8Ih792VnsDCu2wyRxyz
	V6ivFe/h8F0eeNSQ4a++gAh36rYF1V6XhjWTLYRsAs8G9xUi1zF55ZnEJEWcmxUyNTq5ES
	dGWExdsAq9Mw+GXsIw6qg1XnibFCnM4PEmMj56JtVtEmYSAVm1X6gtugapg8uPifIKPvJm
	ZJLVPqlQu3gs8B9iZLONLzUf0i4GNpEUBB+SaNSdCMkpuFymCGrOMXbfga2vIF0XJsmeMU
	zSJmlohRq2t/43pVgBuaHYO+uxpbktDXD9cUaLCiLrUn5ZGgtxP+FbxHBRJAIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742589527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WOtohB+AKI748h04VvFfjvO0Ky51rTdztfJFNReMd6c=;
	b=/+d3Xmy7DvWBVqozBJgQVFKEFutX8Ih9amWjVC5+vZUnAZ6C7M+qacJIfmlR13zf9ANe8I
	CNw5JQAVw25dxbDg==
To: Andreas Hindborg <a.hindborg@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
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
In-Reply-To: <87jz8ichv5.fsf@kernel.org>
References: <20250220070611.214262-1-fujita.tomonori@gmail.com>
 <20250220070611.214262-7-fujita.tomonori@gmail.com>
 <Z9xnDzwixCbbBm0o@boqun-archlinux> <87jz8ichv5.fsf@kernel.org>
Date: Fri, 21 Mar 2025 21:38:46 +0100
Message-ID: <87o6xu15m1.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Mar 21 2025 at 20:18, Andreas Hindborg wrote:
>> Could you add me as a reviewer in these entries?
>>
>
> I would like to be added as well.

Please add the relevant core code maintainers (Anna-Maria, Frederic,
John Stultz and myself) as well to the reviewers list, so that this does
not end up with changes going in opposite directions.

Thanks,

        tglx

