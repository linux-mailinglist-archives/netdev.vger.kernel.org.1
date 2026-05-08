Return-Path: <netdev+bounces-286037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO2tGfNp/mmIqQAAu9opvQ
	(envelope-from <netdev+bounces-286037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:55:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8C24FC87C
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8493034662
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A86390230;
	Fri,  8 May 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYb9LAMf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3B33D515
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778280910; cv=none; b=TKCabuE7YnbYch+SchIr3zpOUAy9TYU2YKoVj67Rkor2o9vvi58egUn7XJ/cljxf9gJJK0INbTIoeSAHdcfc6Ml4dqE04vsDrhRBg58LBYpEFfBWJ0F4sqw7iYBJVIsBYJ74uN3oBlXHEuwwGjWi7LsNOgmHGZo3aTyN10B+TYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778280910; c=relaxed/simple;
	bh=1zWI+LqID15NmPEIovlhBcmvzLkD+SE1qFthydKUNH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cD1IIlkWGLDhMuh8DPCtNJH76+Ji/dytYTkFEDkeoP9nGosOxl9yK+I+40Sd7EwTVl45RVPKKQrhst7ED/M9nXhfSIHCQ6k1m9wl61mfuaieCfjoUQI16/aZ4qwtLNVhslyPF7p0mV163gH6N1gW1vRu8uGGNXB99236k4o5Wt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYb9LAMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DE0C2BCB0;
	Fri,  8 May 2026 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778280910;
	bh=1zWI+LqID15NmPEIovlhBcmvzLkD+SE1qFthydKUNH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYb9LAMflyJ/KvuoVS8tZ714RKy1+ryJUplyRqm9VIabaczprcyd+pAPE+Vuhfr7j
	 YRY9rUYkST7IAhCHtU5W8Xk1LRv02/8H9zW+ZcKvP5ta8h/UcgxngIBrpNrbu4wUI/
	 LwArjqTokc+tIJy11A1TXOHYbq+IKqmx98EUiNmC3gqk/iAUcZolsYFUbuuHAgeaOP
	 cVhuZsceCxrsXl1lfO6CXdrB8pTc0I5Kw0wxCbyQQRoqMYwLdVO/l1RpWBhulxLpag
	 wiLH0CZKaio2WaZ+ZSmfxLxM0H8iV9enp6kEct6nHF2Qryt2XHVBnoLugHrWNBMPc6
	 VL8C72oj22nRQ==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 1/5] ionic: Small improvements in devcmd retry logic
Date: Fri,  8 May 2026 15:55:08 -0700
Message-ID: <20260508225508.3420208-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506043526.64301-2-eric.joyner@amd.com>
References: <20260506043526.64301-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BA8C24FC87C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286037-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ionic: Small improvements in devcmd retry logic

This commit aims to preserve the -EAGAIN error code when a device command
times out on its final retry. It also reduces the sleep time between retries
from 1000ms to 50ms to allow more attempts before timing out.

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 3c5200e2fdb7d..92f2ec0bd5af9 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -554,6 +554,11 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
>  
>  	if (!done && !time_before(jiffies, max_wait)) {
>  		ionic_dev_cmd_clean(ionic);
> +
> +		/* allow caller to manage EAGAIN from previous attempt */
> +		if (err == IONIC_RC_EAGAIN)
> +			return -EAGAIN;

Could err be uninitialized here?

Looking at __ionic_dev_cmd_wait(), err is declared at the start of the
function but is not assigned until later via ionic_dev_cmd_status(). If the
initial wait loop times out on the very first attempt (for example, if the
firmware is unresponsive or the system stalls), execution falls through to
this block. Checking err here would read an uninitialized stack variable,
potentially leading to unpredictable driver initialization behavior.

> +
>  		dev_warn(ionic->dev, "DEVCMD %s (%d) timeout after %ld secs\n",
>  			 ionic_opcode_to_str(opcode), opcode, max_seconds);
>  		return -ETIMEDOUT;

[ ... ]

> @@ -568,7 +573,7 @@ static int __ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_seconds,
>  				ionic_error_to_str(err), err);
>  
>  			iowrite32(0, &idev->dev_cmd_regs->done);
> -			msleep(1000);
> +			msleep(50);

Does this logic abandon retries prematurely?

The surrounding retry condition still requires at least one full second of
remaining time:

    if (err == IONIC_RC_EAGAIN &&
        time_before(jiffies, (max_wait - HZ))) {

The - HZ check was likely originally added to ensure there was enough time
left for the 1000ms sleep. Now that the sleep is reduced to 50ms, requiring
a full second of remaining time means the driver will abort retries during
the final second of the timeout. If max_seconds is small, it may not retry
at all, which seems to contradict the intent of increasing the number of
retries.

>  			iowrite32(1, &idev->dev_cmd_regs->doorbell);
>  			goto try_again;
>  		}
-- 
pw-bot: cr

