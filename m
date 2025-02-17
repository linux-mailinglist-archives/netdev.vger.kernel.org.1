Return-Path: <netdev+bounces-166854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 424EDA3791E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 01:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7E816C9F5
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 00:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143C7EBE;
	Mon, 17 Feb 2025 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQegHQV6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FAB372;
	Mon, 17 Feb 2025 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739751021; cv=none; b=bmTvjXIU20hT0JsDaSovLurPoFPgUdIJpUb9MExlInfUfPhMAHyKqirpJ8JaIaXJCh+zRPR2wnjdtVk/lGRHuyWZic1btWKY0qGcfncN/LrDUj8WexlfEYWcnpIFbt/738rVRe0EstBwi35xPwvbjQWRwnH/ZnsCV2Prv8aeJ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739751021; c=relaxed/simple;
	bh=3cbz5T9dWjwcE8bACWKVwDdL67Jyo8olEYlqpTmJe60=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=njq5edk3A1BwX/atZ1iUnFM7073Xkr0Z9eN2MqhOcShRLzs31ndiJ+5slkaE+MSOoxhNCy3dnbl+qBZ69MgIK2jT4K4lM/XVgItCi2/0acuETyssg9c48JsRIrej6dhRJ6kO2DO2Uxf0mgbyzMvO0Bt7ecPrSncranaV/F4c6OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kQegHQV6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fbffe0254fso7065473a91.3;
        Sun, 16 Feb 2025 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739751019; x=1740355819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOyckpAB1M5l9vVDvm7vTiKfe8H6EV3gsz1q0DN3TFA=;
        b=kQegHQV6lFPmm+gfoZaOFtzKHR2QpomQMEGBj1AHX9VM7r1ZeMrnvFHlawVD9zodaY
         iHdN+B1no2lbSjou5sUid17HM82NPFpLooNhNLjiQ9rnKTYppjBrrQ3xJvlEyKyMC4ia
         YiqYfAOpBbwO77sydXMp/ZcQG0i+jZznmDY8Eq7VwOhCZoeaaYz1fWKVZBK/8PtjrVJK
         2v3EC4jB+uuS4qt+RcYjYq0fDOYy8DQ/Ca8tlVlZfHO2FEci0cB91V3vmvIVK2yDzSA1
         KsBq3A0+TnN9dx9KWypgDMxvRx78EYewH03GSmg6d2G6K6+Zv+FbmqumH3NLATf+PARa
         VGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739751019; x=1740355819;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YOyckpAB1M5l9vVDvm7vTiKfe8H6EV3gsz1q0DN3TFA=;
        b=CTtP+UDrGWxlSlcZMLtFDnOTOoM5SupvdEd/WX/7KFpGV+x438cMeJqh4dMDYxzzNs
         IhVO1jynDYxFvdtj8cjjJzTMIo6/LQd0vrxVamvTN5w5mgWpDeyeuYo0CKRkaXYCmMEw
         X+19sI8ORI2HyQmNbahTb83NsAKZrGZm+OVlJmwNm6uDnQCCR2w1hSgyxskE6rp52ucl
         ninp+eAg00naHVZJjZrTD5vZKRg93rVrB5tLDSr0v9ERYO0DSeEpGRG0O3C/NPm3vgob
         WlG7ZnjQlLtQmZ0yIwryg6+KePOaUKO+b1PLtdHnynALKjIHV7HszeAD3zzDkJ251nij
         TCCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjq61v/Tf78EOzyHGEtKdB+Zt4F8a/K3KwNfNHh2ZLvrFvEItygCPqofaOxdavDb1I0bK6o5PMBHQeycPMNVs=@vger.kernel.org, AJvYcCWzzvI7LTPtL5OGXXPCEMhQ1Cl0J1aqmtHIPMZEp8yoe4j/cq26kDvnow5z0MCL1rysLp9zHbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFSx390R63NA/qgHhLyAVUScaIQDuXrOhqIeFpdPDrH6rml/K
	68gcgSEBu8NPvD3pMskZaJlRf2tfmLkTSSUunVl4Ffh3GVZvmSOg
X-Gm-Gg: ASbGncvoE67pQU28CUcJA4XA5aT8cFqaoUayow/sM9/uB/oU1xnDuvrMLoh79kEtH63
	X0S9vuDPAsXOKwyyfPRaOPhcqweVL9vDouy0uY4XEBj3C+J3YdOWO4m++RLuthh+2KMgx0ZfsTG
	a3DxJhmdggLcIv1J5mGWDbsGSSpK8+JCltBeDdNuucIOEmNCcPAz9kia04HIE8iAAvmRQQLpeD1
	aBPF0fKS8exCURWkvWMebFaFh3s1Efn3hdbw07L4GKd04XnqNGkp1+XLvicmPc75YvdVeIC9wKk
	lYmIHprRDqG885rzXnxZqSxrmEue34o6JcMZ6Z00qbc1Uc42ha3x5196cYVnfiHfjNBNo3lP
X-Google-Smtp-Source: AGHT+IEovMlmLAtfgVM28puXaF5TqCZBfp6QtFyYhKBd0gbsDSkEfXrSTPFBNlYbyjCfuM/3623nwA==
X-Received: by 2002:a17:90b:510c:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-2fc40d14c1emr11723123a91.5.1739751018763;
        Sun, 16 Feb 2025 16:10:18 -0800 (PST)
Received: from localhost (p3882177-ipxg22501hodogaya.kanagawa.ocn.ne.jp. [180.15.148.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d05cesm8870850a91.18.2025.02.16.16.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 16:10:18 -0800 (PST)
Date: Mon, 17 Feb 2025 09:10:08 +0900 (JST)
Message-Id: <20250217.091008.1729482605084144345.fujita.tomonori@gmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de,
 jstultz@google.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 tgunders@redhat.com, me@kloenk.dev
Subject: Re: [PATCH v10 6/8] MAINTAINERS: rust: Add TIMEKEEPING and TIMER
 abstractions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20250207132623.168854-7-fujita.tomonori@gmail.com>
References: <20250207132623.168854-1-fujita.tomonori@gmail.com>
	<20250207132623.168854-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 22:26:21 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> Add Rust TIMEKEEPING and TIMER abstractions to the maintainers entry
> respectively.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c8d9e8187eb0..987a25550853 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10353,6 +10353,7 @@ F:	kernel/time/sleep_timeout.c
>  F:	kernel/time/timer.c
>  F:	kernel/time/timer_list.c
>  F:	kernel/time/timer_migration.*
> +F:	rust/kernel/time/delay.rs
>  F:	tools/testing/selftests/timers/
>  
>  HIGH-SPEED SCC DRIVER FOR AX.25
> @@ -23852,6 +23853,7 @@ F:	kernel/time/timeconv.c
>  F:	kernel/time/timecounter.c
>  F:	kernel/time/timekeeping*
>  F:	kernel/time/time_test.c
> +F:	rust/kernel/time.rs
>  F:	tools/testing/selftests/timers/

TIMERS and TIMEKEEPING maintainers,

You would prefer to add rust files to a separate entry for Rust? Or
you prefer a different option?

