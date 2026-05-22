Return-Path: <netdev+bounces-290698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCwDKjQHEGqLSQYAu9opvQ
	(envelope-from <netdev+bounces-290698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:35:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 290E25B00AD
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2BC43024A0A
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 07:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7C2314B73;
	Fri, 22 May 2026 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ3BlM2l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD08360ED6
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 07:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435304; cv=none; b=fIqpxOOnNo50CNAQSHi0lwsEMRFuMJozxVZHqKbWg2fIwLY0G9wXQm5iiTAjpATHkr03PQ0HvY/SMEcjk4P4HBvhtx/EgU3behXO+QXAklBb9j/p3nGDdK1qt/Rxq/iZj1Utcaxd2esqm3Fd+PX8UPbIWJeyKvO2eSV0fiNtc4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435304; c=relaxed/simple;
	bh=lXFywJLybSBF9609KlpLsJZ5RVFPslKcmzlbiBLBuAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6V9mxXCOqI7vMNHt4iR7zbOabjV5MzsRYrNxA8LPCMj2Z+FlY1qAjbAZcbnhURnnWq4dzVXTYSiGeqNwR3Ghpz9vRvSk3x4uJmLkINQvySefT32vugEsKHmF5c7yOEx8rvG0xCFhtBZU4lJ2c/iuW5EWy9AoU2VMFClMlCLK54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ3BlM2l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCBE1F000E9;
	Fri, 22 May 2026 07:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779435303;
	bh=8JqPjFp/lpFvVXvsbfdxF1aCUq8vdxnHAOkzy7PuDJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UZ3BlM2lv56zGpaunndgC6KuyejeUh2p2kK6Ex48gB3Fq7dJUzuMCsFQJettZyj4P
	 BEaxHeGQNIt49fI4tIanh/6gA4u0o/OECaf4OInTNAs3Be3CuuaSeCWF9vCTq3BPoX
	 cwgVLEIemGMtyOxczzzfGmVWG/ucFs/9DCr//Imp3+K7CjEN94NPlDdjEbfp7giM6+
	 vD6YSfKH9e0b6N8BYRVQebNyYavEFqz8m8rYwsSEifOM/yqaHNWJpDZLaT1Qwcqr85
	 jhleUaFHq5tLJC5AsszYsBj78nJ2zCcT9DFpclufdfj8TFYcabA4IfcgziKunEgqDa
	 cQYcgJR/JD6AA==
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: 'Simon Horman' <horms@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kees@kernel.org,
	larysa.zaremba@intel.com,
	jacob.e.keller@intel.com
Subject: Re: [PATCH net-next v1 3/3] net: txgbe: rework service event handling
Date: Fri, 22 May 2026 08:34:56 +0100
Message-ID: <20260522073456.2032440-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519080048.7448-4-jiawenwu@trustnetic.com>
References: <20260519080048.7448-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-290698-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 290E25B00AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: txgbe: rework service event handling

This commit converts the link event subtasks to use test_and_clear_bit()
and changes how module detection retries are handled. It also explicitly
cancels the service task during device teardown.

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index 6755464b46371..ce82e13aa8ae0 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> @@ -93,31 +93,23 @@ static void txgbe_module_detection_subtask(struct wx *wx)
>  {
>  	int err;
>  
> -	if (!test_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
> +	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
>  		return;
>  
>  	/* wait for SFF module ready */
>  	msleep(200);
>  
>  	err = txgbe_identify_module(wx);
> -	if (err)
> -		return;
> -
> -	clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
> +	if (err == -ENODEV)
> +		set_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags);
>  }

Does this change prevent the driver from retrying transient firmware errors?

Since txgbe_identify_module() communicates with firmware via
txgbe_identify_module_hostif(), it can fail with transient errors like
-EIO or -ETIMEDOUT.

Before this patch, the WX_FLAG_NEED_MODULE_RESET flag was only cleared upon
successful completion, ensuring the periodic timer would retry on any error.

Because the flag is now cleared immediately and only re-armed on -ENODEV,
could a single transient timeout cause the driver to permanently abandon
module setup?

>  static void txgbe_link_config_subtask(struct wx *wx)
>  {
> -	int err;
> -
> -	if (!test_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
> +	if (!test_and_clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags))
>  		return;
>  
> -	err = txgbe_set_phy_link(wx);
> -	if (err)
> -		return;
> -
> -	clear_bit(WX_FLAG_NEED_LINK_CONFIG, wx->flags);
> +	txgbe_set_phy_link(wx);
>  }

Similarly, does this silently drop link configuration on failure?

Without a way to re-arm WX_FLAG_NEED_LINK_CONFIG, any transient failure
in txgbe_set_phy_link() will result in the driver no longer retrying link
configuration.

[ ... ]

> @@ -233,6 +225,7 @@ static void txgbe_disable_device(struct wx *wx)
>  	wx_napi_disable_all(wx);
>  
>  	timer_delete_sync(&wx->service_timer);
> +	cancel_work_sync(&wx->service_task);
>  
>  	if (wx->bus.func < 2)
>  		wr32m(wx, TXGBE_MIS_PRB_CTL, TXGBE_MIS_PRB_CTL_LAN_UP(wx->bus.func), 0);

Will canceling the service_task here leave the WX_STATE_SERVICE_SCHED bit
permanently set if the work is pending?

The wx_service_event_schedule() function sets WX_STATE_SERVICE_SCHED before
queuing the task, and this bit is normally cleared exclusively at the end
of the work function.

If cancel_work_sync() dequeues the work without running it, the bit is never
cleared. When the device is later brought back up, attempts to schedule the
service task will fail, which seems like it would permanently break module
detection, link configuration, and stats collection until the driver is
reloaded.

