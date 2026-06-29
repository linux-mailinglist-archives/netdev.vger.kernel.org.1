Return-Path: <netdev+bounces-302626-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EIRpKIxtQmrE6wkAu9opvQ
	(envelope-from <netdev+bounces-302626-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:05:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D876DABAC
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:05:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b=UN0yR38q;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302626-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302626-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E33D03040C6F
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9084C4028E8;
	Mon, 29 Jun 2026 12:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C433FE363
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:52:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737551; cv=none; b=ROwX5U+5bqjB9YfVNFqPXlvgByoaOMjb9U6+27cVd66tg4xiMjDrYOSoqRKKFMrdmKusO5CBRcvaEMPscyQhkVe40ZFYUlw3MMiVWhBWFiZ4sEIbvIxvhLm9k2g64a31pwfmwNiPUAEoCvA76jVHaOys0alVvBMmdF01+3dt99o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737551; c=relaxed/simple;
	bh=e4bFcTetKCUY0BiWFDdCjYfdtTZJIAxrLcBYwnPJ6cY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ARg7t6ycX1bc1+Pkj9iWAMFjbYFRq2e/8hSiXiHgrYajm6+j4pbXe/6IeoxJq1FteOX4fk4UrTU8Wh3pRgBSQ0GwO9u9ocIrqFmwocT0o4zsySYOAI1B4PF7/7ti6afi2gT2j0TCLqmoFX0gzIYNl8EHKSXqJZtk5yuVQmbpgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UN0yR38q; arc=none smtp.client-ip=209.85.128.50
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so29038435e9.2
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782737548; x=1783342348; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0G67qeINcThvr9unh9wEXsyMZVKpN32CweVhhELeDY0=;
        b=UN0yR38qZupuDkHVCk/7Hw6NhlRMoDYZxkuznyZtluTSIlKTliB3H2zAN5W3JN5XJX
         3It6g+9/AbI5vhF67FeVYun6/SxR+ELAvUIyrGNVyVDX9Cp9uSTcYgQKpw0i0qTCdEjY
         0v4gQkM6+lFYw4iGeDH9lsabTOVM+hb2TwUcNvEMY5tFOByUKy/0nNve8VdAc979Km95
         LMN49H2i9WH1CD8N3CbrLJ+D4MPRrghzKy4PQSxZ7YQFhoaBXhLqf60Ej0qMfBumGDOr
         woxDdWTrhQn78SGuCMFTyQWUG5isIoBuNnqxQPxqzcE3VIFgDJRaprR2ZofQFN4Vmuj5
         bSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737548; x=1783342348;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0G67qeINcThvr9unh9wEXsyMZVKpN32CweVhhELeDY0=;
        b=LH1ZuTRk7UFL79e51CzkyWQNFWaOnGjkr4axIpI3iB5rGsh8CBHal8n8gjdQOjbfMM
         VmimCj0S2o9AEXUQYfTNy22cgIfV0XDCG7qLKaUyHKz4Ynx5h75IrblFTfa5L5WpYiTD
         JbWfH/5As1B3LhfdzZkgf6gqQCZdd5xu/wzbQVagcJ+JiRQnZquUgyJuodShV0TGhmEi
         IiI1qrW2eJT/XQCcqvkLSLNxcd5FUESfJAyWiGYgbs/j/P09xMHNfY9DhYAaZ8mMeXBE
         eWMeeWA901SZAuuE8NMCRqy1EDh+lA//x0z3t0H6T8/Xa3iYeH05A+iEi5kcneVaM7Ap
         0Juw==
X-Forwarded-Encrypted: i=1; AFNElJ/Qnj4JtYt6agkcGgdoQttWetgWPnARxzZFhVXexMf3uRR+GVSbmMfOo1OVamggtUR4uxpr9HA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74XhHChVVG6vCF21ZN2ZaoCNcdbL+KqS+Ve/bHCngAbaFOXz9
	ySS8Di2fT9KCCj1NtPjtituC8uD5GFjd8gCCntqvvW0mcJDmiaxs0KTxE2Q75cH6w7w=
X-Gm-Gg: AfdE7ckO8jgYRBZfmN3cenZgGVwnnbiXqy49Hp1bi9H2J6mBJmzhlufAsow7sIM26+x
	1r5EHZkPulImKhBM/sfGu1BwCzfEHIBKdGds8oCjza6K1bIjyweLg7IQvcnvAvXc+tBrFEzdbbq
	o4oSSYHq6fi+nLV1iyvRUmVVPBrXUrDyVIRrNXmOx54XskXiShUDHnLh0eXDtW7L1GDsTT1zPiw
	XFHFq3uomMgMVGqzOiWB96/O1MwmDV+KdoI6RJexADO/BCLkbo/gsn5It4+6wrAqNAnXSzXd6aC
	JUUgSLhncT/tB6HNBb8ZeCQ5iD7uBC1AEAzbIYjKxYIqfNsq9cLZTa4V8n4NQ4LzLzAjjVGTOO1
	/hCzisTTQL7dqZAb1A4KtSi7v+bCHqI3ahM4OrWxH9ASivv06A7uEiOCFxLOZWQilcgNJFfXkQT
	PlOAfy1ucJ+G4=
X-Received: by 2002:a05:600c:4f8f:b0:493:a75e:cf2e with SMTP id 5b1f17b1804b1-493a75ed171mr81258945e9.25.1782737548101;
        Mon, 29 Jun 2026 05:52:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1d21:f5d5:2d3c:23a7])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4926f94f213sm276984895e9.12.2026.06.29.05.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 05:52:27 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@kernel.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Philipp Zabel <p.zabel@pengutronix.de>,
  Paul Walmsley <pjw@kernel.org>,  Palmer Dabbelt <palmer@dabbelt.com>,
  Albert Ou <aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,
  Richard Cochran <richardcochran@gmail.com>,  linux-clk@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org,  netdev@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] clk: sunxi-ng: Add support for Allwinner A733
 CCU and PRCM
In-Reply-To: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech> (Junhui Liu's
	message of "Tue, 10 Mar 2026 16:33:53 +0800")
References: <20260310-a733-clk-v1-0-36b4e9b24457@pigmoral.tech>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 29 Jun 2026 14:52:25 +0200
Message-ID: <1jo6gta4qe.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302626-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jbrunet@baylibre.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:junhui.liu@pigmoral.tech,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wens@kernel.org,m:jernej.skrabec@gmail.com,m:samuel@sholland.org,m:p.zabel@pengutronix.de,m:pjw@kernel.org,m:palmer@dabbelt.com,m:aou@eecs.berkeley.edu,m:alex@ghiti.fr,m:richardcochran@gmail.com,m:linux-clk@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-sunxi@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:netdev@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:jernejskrabec@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,gmail.com,sholland.org,pengutronix.de,dabbelt.com,eecs.berkeley.edu,ghiti.fr,vger.kernel.org,lists.infradead.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbrunet@baylibre.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,baylibre.com:dkim,baylibre.com:email,baylibre.com:from_mime,pigmoral.tech:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,starbuckisacylon.baylibre.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5D876DABAC

On mar. 10 mars 2026 at 16:33, Junhui Liu <junhui.liu@pigmoral.tech> wrote:

> Add support for the main CCU and the PRCM module (R-CCU) found in the
> Allwinner A733 SoC. The clock architecture of the A733 is an evolution
> of the previous A523 design but introduces several significant changes.
>
> One of the key changes is the introduction of a "pll-ref" clock that
> normalizes the physical oscillator frequency (which can be 19.2MHz,
> 24MHz, or 26MHz) into a consistent 24MHz reference for the entire clock
> tree. Additionally, while the A733 inherits many module clock structures
> from the A523, the MCU_CCU has been removed, and the overall clock tree
> has been expanded to support more new functional units.
>
> Also update the sunxi-ng SDM (Sigma-Delta Modulation) helper to support
> a new dual-pattern register design. On the A733, the SDM enable bit has
> been moved from the main PLL register to a second pattern register
> (PATTERN1). The driver is updated to handle this register layout to
> ensure accurate frequency synthesis for "pll-audio0".
>
> This is marked as RFC because the parent clocks for several instances in
> the main CCU are difficult to determine as the user manual provides
> limited information on their specific clock sources. In these cases, the
> implementation follows vendor practices and previous SoC designs,
> generally defaulting to "hosc" where documentation is lacking. In
> contrast, the bus clock gates in the PRCM (R-CCU) are explicitly defined
> based on the Memory Map in the manual, which clearly associates each
> module with its respective bus. Feedback or insights on these specific
> clock parents would be greatly appreciated.
>
> This functionally relies on the RTC series for the A733 SoC [1].
>
> Link: https://lore.kernel.org/all/20260121-a733-rtc-v1-0-d359437f23a7@pigmoral.tech/ [1]
>

Tested-by: Jerome Brunet <jbrunet@baylibre.com>

> ---
> Junhui Liu (8):
>       dt-bindings: clk: sun60i-a733-ccu: Add allwinner A733 support
>       clk: sunxi-ng: sdm: Add dual patterns support
>       clk: sunxi-ng: a733: Add PRCM CCU
>       clk: sunxi-ng: a733: Add PLL clocks support
>       clk: sunxi-ng: a733: Add bus clocks support
>       clk: sunxi-ng: a733: Add mod clocks support
>       clk: sunxi-ng: a733: Add bus clock gates
>       clk: sunxi-ng: a733: Add reset lines
>
>  .../bindings/clock/allwinner,sun60i-a733-ccu.yaml  |  107 +
>  drivers/clk/sunxi-ng/Kconfig                       |   10 +
>  drivers/clk/sunxi-ng/Makefile                      |    4 +
>  drivers/clk/sunxi-ng/ccu-sun60i-a733-r.c           |  276 +++
>  drivers/clk/sunxi-ng/ccu-sun60i-a733.c             | 2375 ++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu_sdm.c                     |   51 +-
>  drivers/clk/sunxi-ng/ccu_sdm.h                     |   32 +-
>  include/dt-bindings/clock/sun60i-a733-ccu.h        |  289 +++
>  include/dt-bindings/clock/sun60i-a733-r-ccu.h      |   39 +
>  include/dt-bindings/reset/sun60i-a733-ccu.h        |  131 ++
>  include/dt-bindings/reset/sun60i-a733-r-ccu.h      |   23 +
>  11 files changed, 3311 insertions(+), 26 deletions(-)
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260202-a733-clk-0d4fc00a9f9c
>
> Best regards,

-- 
Jerome

