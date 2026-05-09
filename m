Return-Path: <netdev+bounces-286064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBUpLBKL/mlasgAAu9opvQ
	(envelope-from <netdev+bounces-286064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:17:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13084FD37F
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 03:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40655301905A
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 01:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993B41A6819;
	Sat,  9 May 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tlt/eQPc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D7288D0;
	Sat,  9 May 2026 01:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778289423; cv=none; b=B3MKHf1k7mznSJV1L+1bdtWY4EQFLjp3SBTrUldpFPVKAebw3isBR+/rd9dScnInDs0FlVk6ub0+SeNLGIlo7WSul/zJJbWQslcvBVUwfYhngvhb3Wu4YFlxH208EGZR+L6WE8vierME7CtgT4j0DZec815WpYyokS0aMdRD2cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778289423; c=relaxed/simple;
	bh=dPkMj4NBvZKoQQ9ueMiEJT1/8Z/wl4tV1g6E9c1ZxGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrhRvyZEfuTBZnLg9RfU+Xcy80L25WKWztR6TES1eetVY08benZtRgBq/9EJApit9yMV9ccCXw7rY2424bg6T8/JZe28pKFqXF0JAjSDf/kyeI2U0KEx/dPmXGgfhLQG3KrVSAilYXbRJAX+nohOx46URdehM6KypiUKYyISeQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tlt/eQPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6CB7C2BCB0;
	Sat,  9 May 2026 01:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778289423;
	bh=dPkMj4NBvZKoQQ9ueMiEJT1/8Z/wl4tV1g6E9c1ZxGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tlt/eQPcFTFtRSkZdBMPvHaqTX6vVY7XWCCtihQ6Rqfd0ST/vhpakNbP+rSBiRm8h
	 ii5LPlR4R0aMVr87yDsjuCmHX71L9LVOaaKdQX7+CiLbVCVgoIAvCzPPOJESVMwE4y
	 qI4NjTfFWSxdQUgHs0v3i/3DSJIWE1dtVrAfqdF7T3gxyYDoXOn6XVNYlh8y+clHBd
	 ioGKhTL8Owbf19VcO4LPQMNZuhZrDCe3VK1cSB9aqB2psTI4dFuVu/4XY/K2ZVJ5J9
	 F7vsxgOwjq3mUa1t2zpH3qm9WLpxu2TdH2NsVbcrn/885POy4UiT8VZvbsfX9lO6jU
	 btW5z8wGTx9Aw==
From: Jakub Kicinski <kuba@kernel.org>
To: sajal2005gupta@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	petkan@nucleusys.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: usb: pegasus: replace simple_strtoul with kstrtouint
Date: Fri,  8 May 2026 18:17:01 -0700
Message-ID: <20260509011701.3536125-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506152653.52329-1-sajal2005gupta@gmail.com>
References: <20260506152653.52329-1-sajal2005gupta@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F13084FD37F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286064-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: pegasus: replace simple_strtoul with kstrtouint

This patch replaces the deprecated simple_strtoul() function with
kstrtouint() when parsing device IDs in the pegasus driver. It also
adds error checking to abort on invalid inputs.

> diff --git a/drivers/net/usb/pegasus.c b/drivers/net/usb/pegasus.c
> index db85f40734d7b..d45f08f8f22ee 100644
> --- a/drivers/net/usb/pegasus.c
> +++ b/drivers/net/usb/pegasus.c
[ ... ]
> @@ -1327,15 +1327,29 @@ static void __init parse_id(char *id)
>  {
[ ... ]
> -	if ((token = strsep(&id, ":")) != NULL)
> -		device_id = simple_strtoul(token, NULL, 16);
> -	flags = simple_strtoul(id, NULL, 16);
> +	token = strsep(&id, ":");
> +	if (token) {
> +		err = kstrtouint(token, 16, &device_id);
> +		if (err)
> +			return;
> +	}
> +	if (id) {
> +		err = kstrtouint(id, 16, &flags);
> +		if (err)
> +			return;

Does this stricter parsing silently break previously working module parameter
formats?

In the original code, simple_strtoul() would leniently parse an empty string
as 0. If a user provided a trailing colon to omit the flags parameter
(for example, name:1234:5678:), id becomes an empty string.

Since kstrtouint() strictly rejects empty strings and returns -EINVAL,
this will now take the error path and return. Because there is no logging
on this error path, device registration will be silently aborted.

Could this be updated to either handle empty strings or log a warning so
users know why their configuration stopped working?

> +	}
>  	pr_info("%s: new device %s, vendor ID 0x%04x, device ID 0x%04x, flags: 0x%x\n",
>  		driver_name, name, vendor_id, device_id, flags);
-- 
pw-bot: cr

