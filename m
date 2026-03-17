Return-Path: <netdev+bounces-268688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4M/gLYuGuWlyIgIAu9opvQ
	(envelope-from <netdev+bounces-268688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:51:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 410BA2AE87D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97C49314342F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741003EF0B8;
	Tue, 17 Mar 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Xw8x+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FEC3ED127;
	Tue, 17 Mar 2026 16:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765782; cv=none; b=fUCdmJZw6XFXr2iA7us0EpEj83pYZhC+3HUlXPitdjo+LL2ehblNza7k4mZ9ou72KzZbhLDurLatlSSZm9q+vhD2MyYzZiyOpn42TvO3HBn94ZJxchR91a1nwWKyVhGjsbTUJ4he/S46Ud0MvtoAfD8sR6XhLoJ6yzzWUD5Ygt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765782; c=relaxed/simple;
	bh=OK58WmdS4rXXuIIrWD8sszGj5LIGPCYK6dg9+ZC+TjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fv81Mb8nLOd4r8o0wO/8mSWuGYhf2z9IizJ/uDx1AewOxW1ycoF2KqoWUbIxN2ciwAMQFC4CGPmnZgt50r4Vmd+Knl/cHhoT5SKQ8SqnoQhJ3RTWybp7Sv5vKANFDoG6D2YnfFStyGAQKJGwZnmPKhg4ANRSkH2Lko1SzJEjXzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Xw8x+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE75C4CEF7;
	Tue, 17 Mar 2026 16:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765782;
	bh=OK58WmdS4rXXuIIrWD8sszGj5LIGPCYK6dg9+ZC+TjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3Xw8x+D+xr4sSDCfsTzFqv5waudgjgvuRIw8+vpO0pSFIr9Do2qsn6ihe02eV76E
	 cZ6wcB1WpMlEsFRi66T0X1x/lGYZHp1xGpHPkPbhUxGfp73wIF/JNzHuIOz+fvQJ2D
	 3XleK/VWgcs7GZ0J4Z7fjGZ73qoIfMvnukNMaJx7g5h5pA1HobOUeTXnNoqKvvwxLK
	 A9SA75h6cdZS0pAIwhUEKRDpKyUH0xU/lwlBZTdHMmXOiBXg0j1G6q6DJ8pPxAzlfu
	 a1bkvaU/HkxijuL1nzMjFIz08utlN+9OhxB7bhxpfG2X8kChOV5bNt3PjNfMBpGzMI
	 pQPNsm4+lnJ9w==
From: Simon Horman <horms@kernel.org>
To: rafael@kernel.org
Cc: Simon Horman <horms@kernel.org>,
	linux-acpi@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net
Subject: Re: [v1] net: fjes: Drop fjes_acpi_driver and rework initialization
Date: Tue, 17 Mar 2026 16:42:14 +0000
Message-ID: <20260317164215.1766861-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <5113731.31r3eYUQgx@rafael.j.wysocki>
References: <5113731.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-268688-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 410BA2AE87D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: fjes: Drop fjes_acpi_driver and rework initialization

This commit reworks the Fujitsu Extended Socket (fjes) Network Device
driver initialization by removing the ACPI driver interface and
creating the platform device directly during module initialization.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]

> diff --git a/drivers/net/fjes/fjes_main.c b/drivers/net/fjes/fjes_main.c
> index b63965d9a1ba..efb399eb15e0 100644
> --- a/drivers/net/fjes/fjes_main.c
> +++ b/drivers/net/fjes/fjes_main.c

[ ... ]

> @@ -1518,16 +1506,7 @@ static int __init fjes_init_module(void)
>  		return result;
>  	}
>
> -	result = acpi_bus_register_driver(&fjes_acpi_driver);
> -	if (result < 0)
> -		goto fail_acpi_driver;
> -
>  	return 0;
> -
> -fail_acpi_driver:
> -	platform_driver_unregister(&fjes_driver);
> -	fjes_dbg_exit();
> -	return result;
>  }

In fjes_init_module(), if platform_driver_register() fails, does this
leak the platform device?

Looking at the new code, the platform device is successfully registered
earlier in the function:

	fjes_plat_dev = platform_device_register_full(&pdevinfo);
	...
	if (IS_ERR(fjes_plat_dev))
		return PTR_ERR(fjes_plat_dev);

	...
	result = platform_driver_register(&fjes_driver);

But when platform_driver_register() fails, the error path only calls
fjes_dbg_exit() and returns:

	result = platform_driver_register(&fjes_driver);
	if (result < 0) {
		fjes_dbg_exit();
		return result;
	}

Since the module init fails, fjes_exit_module() will never run, so
the platform_device_unregister() call there won't happen either. Should
the error path call platform_device_unregister(fjes_plat_dev) before
returning?

