Return-Path: <netdev+bounces-279035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LNbGJXW4GlymgAAu9opvQ
	(envelope-from <netdev+bounces-279035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:31:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6195B40E349
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 14:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7533300C361
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6223B8BB6;
	Thu, 16 Apr 2026 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMyIhcMB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12BA3B7B9E
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776342610; cv=none; b=jJdJ5yx7lcKySyE3+3S3YtchnYpU+RG/aFTpb650hw/rZBb5+XBcMGwV3XUM6EE3eQ0hUSFLf1GWQndf1bdi++A0trSc17GeYz3uU2AFhhGRYiCn7jJfcVn6VIF1G8dyJBOA+eeKBrHlJFG22Y8mHX3W1lwqvGj7Q4YNS8di8KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776342610; c=relaxed/simple;
	bh=K/4afwQ5p31SSvbXjWdzi0L0oqupXfEEFTghGQ4JcSM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/WT4z7UWPl5Q1qqoJ1FOVmxyg9rkph/NH8oiq3TItpJrVIf5wmqZ3OxN101Gt2HKYr7DyRymAO5n6dOeeV1QQ+PEj6NN21+Iwb5zcsZwrdO9cTDahRRflJ9BX+hIdWpXeWjtv/n05Bq5HRQHmda+Q7ly3TQst+dA63hHt/rV2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMyIhcMB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so122430225e9.2
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 05:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776342607; x=1776947407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wD5n29vJmomxS6DITZYPjUM6os1Itf/93DfNIu2KPog=;
        b=SMyIhcMBhud7E9S0oZfY4dPtDZqiIEqLPYjB6s4KMU/0r83YLgF5ZbDmBOKyocj9ZY
         qrYE7AXH6tRIrCBZ2stUl3Qi0p1ekSMzV/bw635qeh1plkYWcNycJtCcJhUXvLmdYZkQ
         ak84/JBnez1KRfcmlMpgZ++CuFvu085GXxYYRhr73LFU4mA8rLyuOYJFvhMOOSuhDheC
         cVlzWB5L4UqeH/Dt9xlmzSUVQmUeJPE5kIcqSfdNeq+fT/ncidGLUeITziIc3LIGoSlb
         mIEymQGy7PCqcWSexrvq+2z77t5rI8LX0YHsKA3o8o949yKU9SPV8ckeT8kyG1heRNFK
         DfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776342607; x=1776947407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wD5n29vJmomxS6DITZYPjUM6os1Itf/93DfNIu2KPog=;
        b=B/4emDmTlK0S9QYojX4pBHmlftf36wxS8aYaoEB0xgNI+Q6rdliiBw4+hsCrmUPidh
         K5X/0bj83YyRVRou5xDAztWQTBuzKiFSDLukThm/y88ud8ZhJvhi0M+ggY5DweJwPF6o
         8KQw1B3ohvt6rd9kP3L5ENSffbyWAvAm9fYJJxPaJN9gfe4z4H4m70B6qQnF8/7ehQ4Z
         JXNe+7MmJX42PyrQx1MvvLatSdKxq5OE0EznyQ//I/1+DDFbUVpXKgDf3qD6/KuBYNcu
         P7i4oSnFlGSS2dd5e6OA5XDcqAmdBYSmskNGc0bg9GbN2QI1qY3Cu1GEsIcXQLjdicGg
         BQGQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nYdrPJyr6Ebxxfz1ajG8ui7wCr3Z9xTQ4avmT6Q9uVMqjm3jtVAk1LIgYIjTTmYkt4FNerlE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz07TNtXTj52JCDZcSvwGuG6HU4uNh2vPxLyyibwRKBWacBpQFS
	KJkxRvyUWJKInHwZooT1dUYWF7HgyHF2bIiAy+3XFwz0N7Sul+jsgC9s
X-Gm-Gg: AeBDiesavddyYrB4HqNj0dC/scTRPdP2UMV2hdDcQKmKeLd4iKReIHnMLCgbprBqu79
	cDQwkvt7NqKzzC+TvlP1iLT8Sy+Et42JITvWRhV9fd5QK4VFYR2BXCFM+oSiaHXm0Y8ruh11iSe
	OYQV2p+aOimMfsPoHzuYpeQvUPRWPgCK48t2veg55cdljbFD9NkB35NaDrEVrAopz6BHhN+L46y
	kc9yHTcAqJgTBjO8sPXyjlTocmQ5yfsMC5nsgT+7fFDI8byBftnE7xIVjD8QqSGEBDSuk3rIone
	aoM5GAXA4TaGaKzglCnyFWc7YRxzcm1jh2KnepALcueg495mMXZE2NkgpE4cEN6+HVdPX8OENRP
	ipX5IeWgLwAkNeblc5QhyAv5K7WWSvyyzl3fgNx8HgSI4+EpK4cAU5U8Xc3rSJa48bMM2tKdn9U
	zElWqC8PVP4dDgLCq1YvOQECGMpGaLzPx85rRyAlgoGhKiOH5UnGVomoQdf1LjmX1S
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr355637165e9.28.1776342606991;
        Thu, 16 Apr 2026 05:30:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9c668sm69981255e9.4.2026.04.16.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 05:30:06 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:30:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: chensong_2000@189.cn
Cc: rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, viresh.kumar@linaro.org, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, bmarzins@redhat.com,
 song@kernel.org, yukuai@fnnas.com, linan122@huawei.com,
 jason.wessel@windriver.com, danielt@kernel.org, dianders@chromium.org,
 horms@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, paulmck@kernel.org,
 frederic@kernel.org, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, atomlin@atomlin.com,
 jpoimboe@kernel.org, jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
 joe.lawrence@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 live-patching@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] kernel/notifier: replace single-linked list
 with double-linked list for reverse traversal
Message-ID: <20260416133004.07bd2886@pumpkin>
In-Reply-To: <20260415070137.17860-1-chensong_2000@189.cn>
References: <20260415070137.17860-1-chensong_2000@189.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[189.cn];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[189.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6195B40E349
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 15 Apr 2026 15:01:37 +0800
chensong_2000@189.cn wrote:

> From: Song Chen <chensong_2000@189.cn>
> 
> The current notifier chain implementation uses a single-linked list
> (struct notifier_block *next), which only supports forward traversal
> in priority order. This makes it difficult to handle cleanup/teardown
> scenarios that require notifiers to be called in reverse priority order.

If it is only cleanup/teardown then the list can be order-reversed
as part of that process at the same time as the list is deleted.

	David



