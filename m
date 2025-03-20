Return-Path: <netdev+bounces-176432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EAACA6A40C
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 100B33BCD81
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF842147F2;
	Thu, 20 Mar 2025 10:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="JstFlWui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9FB2144BB
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742467670; cv=none; b=shTXjXh4dO7CpBB74YN/bE3Q/fFZh3p+L2+vkcFu/PF9aeE8xb2/PZka5Y5QlePkNIMRLjAmr6zbEIrlMtFJhfzywAb1yfmSoabqDHn1bK/ZvOZciXi6yGFniTONnFjsbjDa8a0SzgWAWFRg2REwslO8L0kc4M1Vj9L9on5CCU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742467670; c=relaxed/simple;
	bh=GGj0jOGN22ztBZhaMn/7v+LbyaRgZVijRKfdioC35oo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qr/GsyzVMssxSbgnVkpGi81+tr7dqe5EXNQk7eBSuk/eBFsbsKyNRdz/BfxGUgF41EuxlHZdN7XWLBJI23EZcdKBrw01mLwvCAsGuIlA38FVNlPHB5B1oT5If3EFppG2FXUitbW3G43CGF6t9gyzfvbKHHcZs4UqJg5fkuuVg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=JstFlWui; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ab78e6edb99so103749666b.2
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1742467666; x=1743072466; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHBxNIjHPQ2U+7TMy5Fzaa3ioPAl2tBzm/GfSmCJAVQ=;
        b=JstFlWuiVe2vqamZl1Eod+3+7SrZ5tEtvUXICbq9U3fIvioop0fNsxr8Iv7f+w+l/A
         jzpVFBRtoOmIVTLysM3E08Y8lHBmL60un+U5RIxK2A/9anwbsROe/V7csO6ulXL8FPA1
         +48K95JsqF9yhDeCTgnAzvbYDnKine93PxQOmoTYczAOJReT0sVmv8XbZWczMHyYY/7r
         hbuHi3IZsq36UL96PQFhZ/ZFbzHlohx1qSMg0Zl0ONFtLlqviGQEMLDJT86KSGD6tnqR
         3rcjYsNgcSUra864TzX6vfinjb0trNM8y99kq8HSTVeEajxHD527bs7Xp2MXXTJ/OgkY
         NYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742467666; x=1743072466;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zHBxNIjHPQ2U+7TMy5Fzaa3ioPAl2tBzm/GfSmCJAVQ=;
        b=lpIqZOfzHVSl2xVWUAfkhvAvtxF3bq/4thXpICmTx/N5cUJLd6mTvZxJ2iSRQtDEZf
         2wMKpt0gn/eLi/Qf6Yu8E/CwqYsOhDB0PaD6UCFzMTuSWylN+XQ+mMsh4ojOr0iM21/p
         O/vIuPop9PVd2+QJxrHgq3xWtizd6elVqadpZg7yUmv+sHzhWSUX70SV6/TxdQNVnSC4
         PEVf6F3lg6wypaRhbXg5PApwdAIWeE4WwjrHBVB5JnOMLaRkk3VdQNLbcTWXg9bYenru
         RbhZY+6/PdslFq3EzT8QqZEq9D5SCjQ6fzES1g9wMUgiury+TfgjYac7gG7AAx0Hjcv3
         37Xg==
X-Forwarded-Encrypted: i=1; AJvYcCXM1P5ntQAxluTYKA7SqfWQ8rXI4lko7ERAiQz5ugO0gH/NFug/xx3MyT0rX7YYQNr0b2FYuXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvlQXKB7j52ZffsZ9XDh8R58CDgF1Aywapyyhedoe/JMYrUiW
	tqS5PcTjgpAzajoy1gDMcfPlGm7PByHrfF8aq0Wz+eBAfrvClN/C8HUSr8zwwKpsAQZK0k8s1k+
	R
X-Gm-Gg: ASbGncv90fBY037OkxxvtQ6pLRpXKSCURXZYbt2D1MfgheH9KIb+jfCZQZxhlllwX40
	4pU7a71DOj8YMvQ4/mAmgKFV7S2MTlYoDA8D8st1wK+Wy9YTxbiG+A99ATFRZEiRvy5HbhamHdL
	of9qdFVgx3HJ22avwVla+rKZF+wbSJeh3FNLlhUbD2yy2RUEsaq/KKlYD44mYDtkxNIXCJ2wrUI
	vjMu6vEGHQzmZR/6PMMFKGjZSKMhiFMN+vfleKYeO0oNOARMaqNm1kGPx1YxWMysAY6OwYX/7cp
	KdyQkOMFqcEH5kxYb9y5s0302rMEG9WvW3HbnhrqyOsB6JMvK4bz99SO0nyEXzuNjsF/WQf0s1M
	=
X-Google-Smtp-Source: AGHT+IF5fyldpIKMBMPMoVyMOWjlkG0DwrJGbCQsMu9+8kEjtcBAnNh58BISDr7wLImUlFOOv39CeA==
X-Received: by 2002:a17:907:1c11:b0:abf:69e6:438b with SMTP id a640c23a62f3a-ac3cdf76c77mr277715566b.9.1742467665838;
        Thu, 20 Mar 2025 03:47:45 -0700 (PDT)
Received: from wkz-x13 (h-79-136-22-50.NA.cust.bahnhof.se. [79.136.22.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ec3bcsm1161029066b.62.2025.03.20.03.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:47:45 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, kuba@kernel.org, marcin.s.wojtas@gmail.com,
 linux@armlinux.org.uk, andrew@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, ezequiel.garcia@free-electrons.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net: mvpp2: Prevent parser TCAM memory corruption
In-Reply-To: <20250320105747.6f271fff@fedora.home>
References: <20250320092315.1936114-1-tobias@waldekranz.com>
 <20250320105747.6f271fff@fedora.home>
Date: Thu, 20 Mar 2025 11:47:43 +0100
Message-ID: <87zfhg9dww.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On tor, mar 20, 2025 at 10:57, Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
> Hi Tobias,
>
> On Thu, 20 Mar 2025 10:17:00 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> Protect the parser TCAM/SRAM memory, and the cached (shadow) SRAM
>> information, from concurrent modifications.
>> 
>> Both the TCAM and SRAM tables are indirectly accessed by configuring
>> an index register that selects the row to read or write to. This means
>> that operations must be atomic in order to, e.g., avoid spreading
>> writes across multiple rows. Since the shadow SRAM array is used to
>> find free rows in the hardware table, it must also be protected in
>> order to avoid TOCTOU errors where multiple cores allocate the same
>> row.
>> 
>> This issue was detected in a situation where `mvpp2_set_rx_mode()` ran
>> concurrently on two CPUs. In this particular case the
>> MVPP2_PE_MAC_UC_PROMISCUOUS entry was corrupted, causing the
>> classifier unit to drop all incoming unicast - indicated by the
>> `rx_classifier_drops` counter.
>> 
>> Fixes: 3f518509dedc ("ethernet: Add new driver for Marvell Armada 375 network unit")
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
> [...]
>
>> +int mvpp2_prs_init_from_hw(struct mvpp2 *priv, struct mvpp2_prs_entry *pe,
>> +			   int tid)
>> +{
>> +	unsigned long flags;
>> +	int err;
>> +
>> +	spin_lock_irqsave(&priv->prs_spinlock, flags);
>> +	err = mvpp2_prs_init_from_hw_unlocked(priv, pe, tid);
>> +	spin_unlock_irqrestore(&priv->prs_spinlock, flags);
>
> That's indeed an issue, I'm wondering however if you really need to
> irqsave/irqrestore everytime you protect the accesses to the Parser.
>
> From what I remember we don't touch the Parser in the interrupt path,
> it's mostly a consequence to netdev ops being called (promisc, vlan
> add/kill, mc/uc filtering and a lot in the init path).

Good point!  Indeed, I can not find any access to the parser in IRQ
context.

We still need to disable bottom halves though, right?  Because otherwise
we could reach mvpp2_set_rx_mode() from net-rx by processing an IGMP/MLD
frame, for example.


