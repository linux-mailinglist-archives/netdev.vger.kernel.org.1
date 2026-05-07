Return-Path: <netdev+bounces-285415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HmMFqm4/GkqTAAAu9opvQ
	(envelope-from <netdev+bounces-285415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:07:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9504EBD1A
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17D863070A3F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1B03FE661;
	Thu,  7 May 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b55gFo+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D83F23B7
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169566; cv=none; b=QvsEzhutl7SmJllbMqby2wIwGwzPEKenQDZb3pjrHVuW3S0xBw4KB92NMk6g/LXbH80uNYyPGFF4P2CcxdBF1axydWoxoXeeJZ1ew5FHdCdBcSKq4WtIodqnOLqWpvWnO3lyoqBSVVwDZsSVvPxKRTwcSHIte7elq6EUBLzCDho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169566; c=relaxed/simple;
	bh=xbxW6AsscEAmZUeI5ulw6eIW4rrXbesUfF5YumpoOzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtQsdM/2bdVHbJSijLkVjYECZgrIsP0af8ExcScellAlmIXhWpeSYyIKTLlOty9hkC7mmujUj3B5O1bArqyfgRbQsc17HBDF1JM8MU8UH2umqk01K2qLjM9YAzPdyNhNZeXqPqndk/kckjD2Uq5jrW9VERd8gVJfwTtaRX43ksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b55gFo+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D356BC2BCB2;
	Thu,  7 May 2026 15:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169566;
	bh=xbxW6AsscEAmZUeI5ulw6eIW4rrXbesUfF5YumpoOzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b55gFo+CXPYb7NCMlRsisvQmeJJAf8d4VosspMIScjQs4e4sAP09lQH0jWCmFFmN3
	 bOHRGUr/yr/lgC8DyapqFFxoXX4dB8AhjqIpeJjKpNlVoZ3D2xmXgLFHz2DCva4Xd7
	 ENPwnPgTsuZUjrzpKlV8raqAYPLBIo0Ex2TtN2wPzYwJYKMSPd/BkQLFL6KjxyOSpj
	 +nUQMkPOIhOgwGj9gVnkSsvrCEcKWQPsdS7PuRKokRsDtJ71NoNPzmgyACqnSBtPzf
	 7UJGlmsifXbtDNiYQ3o3Cg7C9D8blJCuljoUVZ3oN0osVuduvQezQAvU7P29w/nsw9
	 mpVXp8INx+T4Q==
From: Jakub Kicinski <kuba@kernel.org>
To: eric.joyner@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	brett.creeley@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	prabu.ponrajthayalan@amd.com
Subject: Re: [PATCH net v2 1/5] ionic: Allow the first devcmd to trigger deferred probe
Date: Thu,  7 May 2026 08:59:23 -0700
Message-ID: <20260507155923.2537888-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506035706.12373-2-eric.joyner@amd.com>
References: <20260506035706.12373-2-eric.joyner@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AF9504EBD1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285415-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    ionic: Allow the first devcmd to trigger deferred probe
    
    There's a chance the register signature value is set before the
    firmware is ready to respond to the driver. This doesn't mean the
    device isn't there, but just means it's not yet ready. If the first
    devcmd fails, then return -EPROBE_DEFER so the device can be probed
    at a later time. As part of this make sure the reset devcmd, which
    is the first devcmd, is not so alarming when it fails by printing
    an information message instead of the standard devcmd failure
    messages.

[ ... ]

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> index 05f19489ec5c8..59ce35404e532 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_bus_pci.c
> @@ -260,7 +260,8 @@ static int ionic_setup_one(struct ionic *ionic)
>  	/* Configure the device */
>  	err = ionic_setup(ionic);
>  	if (err) {
> -		dev_err(dev, "Cannot setup device: %d, aborting\n", err);
> +		if (err != -EPROBE_DEFER)
> +			dev_err(dev, "Cannot setup device: %d, aborting\n", err);
>  		goto err_out_clear_pci;

Does this code leak the workqueue?

ionic_setup() first calls ionic_dev_setup(), which allocates the workqueue
via ionic_watchdog_init(). If ionic_reset() then fails and returns
-EPROBE_DEFER, the goto here jumps to err_out_clear_pci.

This bypasses err_out_teardown and skips ionic_dev_teardown(), which is
responsible for calling destroy_workqueue(ionic->wq). Because -EPROBE_DEFER
will cause the kernel to retry probing, could this leak a new workqueue on
every failed probe attempt?

>  	}

[ ... ]

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> index 3c5200e2fdb7d..91f89b9ff8075 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> @@ -603,7 +603,11 @@ int ionic_setup(struct ionic *ionic)
>  	err = ionic_dev_setup(ionic);
>  	if (err)
>  		return err;
> -	ionic_reset(ionic);
> +
> +	err = ionic_reset(ionic);
> +	/* firmware may not be ready to respond yet */
> +	if (err == -EAGAIN || err == -ETIMEDOUT)
> +		return -EPROBE_DEFER;

Will this permanently fail the probe with -ENXIO if the firmware is so early
in its boot process that the IONIC_FW_STS_F_RUNNING bit isn't set yet?

If ionic_is_fw_running() is false, ionic_reset() skips execution and
returns 0:

drivers/net/ethernet/pensando/ionic/ionic_main.c:ionic_reset() {
	if (!ionic_is_fw_running(idev))
		return 0;
    ...
}

If this happens, ionic_setup() returns success, and the driver proceeds to
ionic_identify(). When it issues a command and calls __ionic_dev_cmd_wait(),
the wait loop is skipped entirely because the firmware isn't running,
returning -ENXIO. This bypasses the -EPROBE_DEFER logic here and causes a
permanent probe failure.

>  
>  	return 0;
>  }
> @@ -687,7 +691,7 @@ int ionic_reset(struct ionic *ionic)
>  
>  	mutex_lock(&ionic->dev_cmd_lock);
>  	ionic_dev_cmd_reset(idev);
> -	err = ionic_dev_cmd_wait(ionic, DEVCMD_TIMEOUT);
> +	err = ionic_dev_cmd_wait_nomsg(ionic, DEVCMD_TIMEOUT);

Does this actually suppress the timeout warning?

The commit message says this aims to make the first devcmd failure "not so
alarming" by suppressing standard devcmd failure messages. However,
ionic_dev_cmd_wait_nomsg() passes do_msg = false to __ionic_dev_cmd_wait(),
which only suppresses firmware-returned error codes parsed by
ionic_dev_cmd_dev_err_print().

If the command times out, __ionic_dev_cmd_wait() will still unconditionally
print the dev_warn() for the timeout, so the alarming message might still be
printed.

>  	mutex_unlock(&ionic->dev_cmd_lock);

