Return-Path: <netdev+bounces-75198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966C86898C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7D78B23966
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B0A537FC;
	Tue, 27 Feb 2024 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="OgYsK68o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3716F4CDE5
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709017612; cv=none; b=I+WlpyWcEAf6esVIjFn+o62MhiED8UmCbPfkdihlTefmmu4MREGexbZVg4rByBB4jDnEXVrQW4Ysf8/oYhh59X3RY8VC/GWAUyu8Z0fgOxBZMXlu47NlUWcxtY+alot6hPUiS5CHvccoJFW8EghMte9ClzcG5xWtHq5utDezgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709017612; c=relaxed/simple;
	bh=z9zNuRwIwP46i0rkzfEzN6Wmh53XtINqXxUMwiUENCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ag6B1bnJckdbW2Zq4pzzaEDQ4rKGHI6DmyqkLJl4pY28UIYFW88zBAMqQnDMW48U0bJaywR8Z9vGw2RaTYCQIGzUw2vc1esH+nCz5UQuJ3KZXgIqwAzvsjSge2To8LWP60ymbQNY5tbL4RnSrD77cULyrbGczt4BZheFenC0QYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=OgYsK68o; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d6f1f17e5so2748433f8f.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709017608; x=1709622408; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bLO3rq3IMFZ9RzZK5R2MKgoFJm4lJR3ZfN07iLrelss=;
        b=OgYsK68oDJsluqrOXLdPnx2/PelKmi7cXFG8ec6fIDeUmTr5UzenrDUjbkXgs0JHFL
         Q41Gm230wLAvQ7//g9vH+pTJR7xBvid2CLd8jX0sFGmqKvzVagNikXRQ0nfL7HKHTK6m
         HQG0rq/DgT73c6Q3MSVTTqqawaRMWd44QHlR7jwl1QGP5Ro+IbBlupD80nw+C6UdxOZF
         suROd0qD+3hRcL/na1DnqNFbT6P3aWThGlpJR5MupqaYy8cxXBgJgHx/WhE3lNbERuWq
         B67ZgYIY9E8za9il+nLizgs7CcSMWSyOt7t3SDBq3VnlLQpaAaMNAtYOlYCUKShpqDpQ
         /tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709017608; x=1709622408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLO3rq3IMFZ9RzZK5R2MKgoFJm4lJR3ZfN07iLrelss=;
        b=obdHHoemkSw+HLalZzAroNvpoa52DI4Jw4JusMw2F4rNoq+Iwg3oPMephTT/c1dcwx
         F7OfZWVK+zNUi0NiMKLV5FQP5wKWSm9agOuXGBw69cLe7jYw6+iq3ia0HeGKJNtPe5O0
         SfzxTxqqcHfkhs+OXLeIheP1CD/g6Shpsers+vQU0e6FZbWhtZWEulNm8zqTmePqVVhJ
         8E0uDl9J+LMjGVheLop+evaERqdR8YUptGO9MpWE/oHWSLtnUBFK9ribNvx/UhMqLeoR
         F2AKTfm6thijR+lT0Y4YKWJjIBNDUNEBSxkMNT5SKYNIDQCaDtHc4Fj8sCEi4eeClMTr
         nFag==
X-Gm-Message-State: AOJu0YxV2ubgU8jklKoY/li8nPu5rZj1ulXfnGE7Gbxgf3SVh6Y5Lko6
	INFGk9R7n5ix9wIFeiAKXj2EGeOIqoKiFtgUFHsWWlG8k4R5JuqIP79VAkmJ8K4=
X-Google-Smtp-Source: AGHT+IFSbDEDStotCoZ93hO2I26eP20c+cNlQyBDmdI3fxbhEBoYaiShBr8ZTHWl6QNa302T9fqRzQ==
X-Received: by 2002:adf:ec8d:0:b0:33d:f457:ab55 with SMTP id z13-20020adfec8d000000b0033df457ab55mr145079wrn.52.1709017608339;
        Mon, 26 Feb 2024 23:06:48 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id eo8-20020a056000428800b0033dcac2a8dasm7622379wrb.68.2024.02.26.23.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:06:47 -0800 (PST)
Date: Tue, 27 Feb 2024 08:06:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com
Subject: Re: [PATCH net v2] stmmac: Clear variable when destroying workqueue
Message-ID: <Zd2KBc6uDj2G5gZi@nanopsycho>
References: <Zdy04YvIFlkOl3Z-@nanopsycho>
 <CGME20240226164337eucas1p196a1049cb7e766984910eee2f99bae4e@eucas1p1.samsung.com>
 <20240226164231.145848-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226164231.145848-1-j.raczynski@samsung.com>

Mon, Feb 26, 2024 at 05:42:32PM CET, j.raczynski@samsung.com wrote:
>Currently when suspending driver and stopping workqueue it is checked whether
>workqueue is not NULL and if so, it is destroyed.
>Function destroy_workqueue() does drain queue and does clear variable, but
>it does not set workqueue variable to NULL. This can cause kernel/module
>panic if code attempts to clear workqueue that was not initialized.
>
>This scenario is possible when resuming suspended driver in stmmac_resume(),
>because there is no handling for failed stmmac_hw_setup(),
>which can fail and return if DMA engine has failed to initialize,
>and workqueue is initialized after DMA engine.
>Should DMA engine fail to initialize, resume will proceed normally,
>but interface won't work and TX queue will eventually timeout,
>causing 'Reset adapter' error.
>This then does destroy workqueue during reset process.
>And since workqueue is initialized after DMA engine and can be skipped,
>it will cause kernel/module panic.
>
>To secure against this possible crash, set workqueue variable to NULL when
>destroying workqueue.
>
>Log/backtrace from crash goes as follows:
>[88.031977]------------[ cut here ]------------
>[88.031985]NETDEV WATCHDOG: eth0 (sxgmac): transmit queue 1 timed out
>[88.032017]WARNING: CPU: 0 PID: 0 at net/sched/sch_generic.c:477 dev_watchdog+0x390/0x398
>           <Skipping backtrace for watchdog timeout>
>[88.032251]---[ end trace e70de432e4d5c2c0 ]---
>[88.032282]sxgmac 16d88000.ethernet eth0: Reset adapter.
>[88.036359]------------[ cut here ]------------
>[88.036519]Call trace:
>[88.036523] flush_workqueue+0x3e4/0x430
>[88.036528] drain_workqueue+0xc4/0x160
>[88.036533] destroy_workqueue+0x40/0x270
>[88.036537] stmmac_fpe_stop_wq+0x4c/0x70
>[88.036541] stmmac_release+0x278/0x280
>[88.036546] __dev_close_many+0xcc/0x158
>[88.036551] dev_close_many+0xbc/0x190
>[88.036555] dev_close.part.0+0x70/0xc0
>[88.036560] dev_close+0x24/0x30
>[88.036564] stmmac_service_task+0x110/0x140
>[88.036569] process_one_work+0x1d8/0x4a0
>[88.036573] worker_thread+0x54/0x408
>[88.036578] kthread+0x164/0x170
>[88.036583] ret_from_fork+0x10/0x20
>[88.036588]---[ end trace e70de432e4d5c2c1 ]---
>[88.036597]Unable to handle kernel NULL pointer dereference at virtual address 0000000000000004
>
>Fixes: 5a5586112b929 ("net: stmmac: support FPE link partner hand-shaking procedure")
>Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time, send v2 as a separate email starting new thread. Thanks!

