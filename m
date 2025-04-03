Return-Path: <netdev+bounces-179043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B609A7A330
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F77A61B6
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 12:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3324E003;
	Thu,  3 Apr 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvwLL3V1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BDB24C07E;
	Thu,  3 Apr 2025 12:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743685075; cv=none; b=fWwwRcZmJnwhZiN4ejSzfyE2gbLRQ3YGgYthosqril01oNkPrzKE9rPHyU/Yh5XIel8fvzToOMpkUOEP4XHJzYR0IICab//L5AN3rrdu0wSAtHOFcQozz20ccQHTu1Fm2fD69rsJalifkHJVOM7gJSIp/Nwn+jEDSDcxMNBWN9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743685075; c=relaxed/simple;
	bh=/1YxCcRTRvpxQ9KkKuxghPk2ylXH2ipD9xLYdo4JcEU=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=edWlphV4OuTR5YUnYdLd2lgp6Ml/xveG/9yyaNyEH3sDMVDas9NEUy7r+DsSjDPNGWlha7M8FLM/Zsk/PFiOspkiITU3wsAmLgXF0jvXAicJngx4UC4lAnQLt4AS64vquDl3lbPNt0bWxO6C1MqYuzj+MhAtz49bYn24wG+2j1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AvwLL3V1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7396f13b750so912292b3a.1;
        Thu, 03 Apr 2025 05:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743685073; x=1744289873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMvo80YrC/OUar0noVKvQwzuCcaGDRGPGFcmSwrZcwA=;
        b=AvwLL3V1aQGnMZv3+csMYdrPTa0JoMc2a6yqDwIpIJhsnBrvtEM5S+7Iv8tQX+ZU+r
         AzsdwR2xoVsZAwBo3jY7zlKCbhwOFGdKVrAejh45D7xDZDctuNbSKuwtljOBa/jD3MVt
         j8gFd3Tl6qgA3e6v66jP4Wse2k3qfhqG6hRjUd6xxE6foeCXtNvcNLJRiaGd9i388pg8
         Qj0dRiL3PbzbOtU2riNk5xtKIZ3O/EBT6OEcfp3c4h3cFeKHRnp43qejaMtnT8ot8+Vz
         2WhGX2I/xsfmyvlJfFphB916ZHuMwJAwk6sSKSPJlBCgziAvXfmJwK9OMBLWmbQekpJa
         Ir2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743685073; x=1744289873;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xMvo80YrC/OUar0noVKvQwzuCcaGDRGPGFcmSwrZcwA=;
        b=OL6/KcHGZPyciwmNKEdrQl8V3v2ybKaM+grCZr+foM/lNZP4yO0UtOWJacZuZqT7bC
         RKybe5Lsge1IXGlTTXjhWriySviHH6+zyevbckBHtuHdD4rGSLwJege2+//sgCDN62K6
         Nw6umMcUJWBrkyExU2vQ2Alqojf1KRiDkCMUpza2aOWachNaBdZ4taRDsH+BG6IaBn3d
         ig/w0R1ciF30KWRv3qsWMhSaJsy6yALZCOhGPYx6fleyeMOp7opYK0O47u2+szXmrpHQ
         5/YwHdUDPGqrP1UDXeC++ecXsmNZyR4Sssdb3tUE21kXhAfk0V8p4PCSwqPjQHKTl8q2
         9i1A==
X-Forwarded-Encrypted: i=1; AJvYcCUb3i/wfhz7ZVUSlhQ+cu18SeTxuDoWyaWpzPdcv+SiINCamE6HXPRZup+6ca1tQ7ifdyQn5GRE6h3OQvS9MvI=@vger.kernel.org, AJvYcCXIfunzFlLecWVxuWm5zfUuBmJTTciFfvaze8K70LE03ZtZ/E1GbxZO/LCiTIFcOxQeTRtoK8EyMbfpTl0=@vger.kernel.org, AJvYcCXj2GEGhnADq2lt+Hc2oxUSUr0l2TZdiNT3QoR+y/Bg29YxFa5ChrTAr2b/EraMuYEKqFhHn1uL@vger.kernel.org
X-Gm-Message-State: AOJu0YzpRf4YlWFulImolciz39qQsNCfLlKe1a6popDnrQRiWoSZdeOl
	c1K4bPxTE7fez2mHewpEKJlohY4aGV7YRqKUGkx0g+VRG76d1JAW
X-Gm-Gg: ASbGncvE3TkR/XUW2K8K9PzQC2tklGZLhhErFioydn2U5dSx11G/9hksYjqxbhJPHuI
	Jg4ZFtaUeoJIDSuLHIAa+sW3nJC31gvWbTmDHFi6Qd7P5nNLPCpKRQapUf6XQhHiWyoQuEQxwxi
	MPlzOb35ergTMXpj+J9adYu7a9bPTAZtPkJqtv8n1HQA6qgZkkPRUou/Mbdg2IJVzSImkOnqxgn
	6CfqcHLNLD6q6SHd+uXerBXN1gXg1Ur9sr7fdFAXUljF2dgc2GQieP05e/DgiF4IDIwHYbgWNBD
	5T8bFWOfhF1qjZtBpUxA7Zkf8sKwBlBr7V61iNEQxnARsaJXjMUHbSlUscIcsijvLT5CgY5SGvF
	JjU5fTXM2wxrbJUOhLvqZVDkUJVM=
X-Google-Smtp-Source: AGHT+IHiovceFK2chizolznq/Ml1WNiyNYVynJX9L1MmVpIhUck/y8sRKLzHQWYsF3XMiynXIRoDvg==
X-Received: by 2002:a05:6a00:238a:b0:736:5822:74b4 with SMTP id d2e1a72fcca58-739c7965d2dmr7803994b3a.21.1743685073171;
        Thu, 03 Apr 2025 05:57:53 -0700 (PDT)
Received: from localhost (p4204131-ipxg22701hodogaya.kanagawa.ocn.ne.jp. [153.160.176.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97ee7absm1415045b3a.58.2025.04.03.05.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 05:57:52 -0700 (PDT)
Date: Thu, 03 Apr 2025 21:57:45 +0900 (JST)
Message-Id: <20250403.215745.2138534529135480572.fujita.tomonori@gmail.com>
To: a.hindborg@kernel.org
Cc: fujita.tomonori@gmail.com, boqun.feng@gmail.com, tglx@linutronix.de,
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
In-Reply-To: <877c41v7kf.fsf@kernel.org>
References: <RK_ErPB4YECyHEkLg8UNaclPYHIV40KuRFSNkYGroL8uT39vud-G3iRgR2a7c11Sb7mXgU6oeb_pukIeTOk9sQ==@protonmail.internalid>
	<20250403.171809.1101736852312477056.fujita.tomonori@gmail.com>
	<877c41v7kf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu, 03 Apr 2025 12:54:40 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

>>>> You will need to fix something because patch 2-6 removes `Ktime` ;-)
>>>
>>> Yea, but `Instant` is almost a direct substitution, right? Anyway, Tomo
>>> can send a new spin and change all the uses of Ktime, or I can do it. It
>>> should be straight forward. Either way is fine with me.
>>
>> `Delta`? Not `Instant`.
> 
> It depends. Current hrtimer takes `Ktime` and supports
> `HrTimerMode::Absolute` and `HrTimerMode::Relative`. With `Delta` and
> `Instant` we should take `Instant` for `HrTimerMode::Absolute` and
> `Delta` for `HrTimerMode::Relative`. The API needs to be modified a bit
> to make that work though. Probably we need to make the start function
> generic over the expiration type or something.
> 
> If you want to, you can fix that. If not, you can use `Instant` for the
> relative case as well, and we shall interpret it as duration. Then I
> will fix it up later. Your decision.
> 
>> All Ktime in hrtimer are passed to hrtimer_start_range_ns(), right?
> 
> Yes, that is where they end up.

Ah, I found that __hrtimer_start_range_ns() handles ktime_t
differently in HRTIMER_MODE_REL mode.

As you said, looks like the API needs to be updated and I think that
it's best to leave that to you. I'll just use `Instant` for all cases.


