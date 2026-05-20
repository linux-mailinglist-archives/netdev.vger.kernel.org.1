Return-Path: <netdev+bounces-290133-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIJ6ITFIDmoM9gUAu9opvQ
	(envelope-from <netdev+bounces-290133-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:48:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 826D159CE8F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8FAFD3008695
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 23:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2991C3A3E9C;
	Wed, 20 May 2026 23:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDxZ6ogw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB229ACC5;
	Wed, 20 May 2026 23:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779320529; cv=none; b=Q9nAITq7LSj/QEIRVQZFisgTy0H/jWL2qRtMOtWB0Y9BXQkKxjCCirgZlBrrhwmy8DoHSH+tKyJD5YUltqZAKPDp3FTRw4kZd12eAnQquHZWsVEfnTvwOK0FBOzuQ4tUAIfOZFHvWbHZJpzUUehBvHW8Y/FcAsDvqWM0f6nWJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779320529; c=relaxed/simple;
	bh=BOtmQnYwhiD/lkLj7nvNX5pKXq4V5b/qhtNiaDxQv2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsynjQObX7f0QSSHdrPV6s0qpfv+BilpAAU59vN5s7ouRh9xg+Bm54wdV+LmeP6oeblgiJqInsVZzDCIQ18xfwO2Kiz9c6bJHlkD7/+dqx2ldf3qfAaNwttwqQacA4mPfJivzl2HOg4qsPj3VxA3gueiL36xstGOemq9qLwwlDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDxZ6ogw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F031F000E9;
	Wed, 20 May 2026 23:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779320527;
	bh=Znm0sW9BUElCtQxN4X2/xze8HSvMbyOGeRSsJW5nkro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDxZ6ogwfaH15kq8Y368rvBDNUaUez5YAKKjeVpAukTeTWDR7OQXmzSCcVyF81O7f
	 dpvpN6qiQLelsF2DLxBuJxtdLkNzABNLkZ02lnF22nzVcLyUzEmb4Wop4KO3g1G1Ma
	 SOoyB/TwUd4EfEYvdY7LAL5UfkCCDxcUaowyEorjeIlbKXqtysAMPHd+2z9/jN+QAC
	 EWAF6vSgPr3TXR4w/OXnplpuqSVIwRTVG3Hzdf51AtTc6jRpUQd9CNOrWrf648gqsU
	 M7qWFxzFBJ0XJGWrVu7R5tiKmAu9rQLhIcndYEm2Od6IOUpWSp6cxFzdjt5JfGGfpu
	 8/SbQl2i3ffHg==
From: Jakub Kicinski <kuba@kernel.org>
To: jelonek.jonas@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no,
	horms@kernel.org
Subject: Re: [PATCH net-next v8 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Wed, 20 May 2026 16:42:04 -0700
Message-ID: <20260520234204.565333-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516135442.2234729-2-jelonek.jonas@gmail.com>
References: <20260516135442.2234729-2-jelonek.jonas@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290133-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 826D159CE8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: sfp: apply I2C adapter quirks to limit block size

This patch modifies the SFP driver to respect I2C adapter quirks when
configuring the I2C block size. It restricts the maximum block size
based on the adapter's max_read_len and max_write_len fields.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index bd970f753beb6..e58e29a1e8d27 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -807,21 +807,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>  
>  static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>  {

[ ... ]

>  	} else {
>  		sfp->i2c = NULL;
>  		return -EINVAL;
>  	}
>  
> +	if (i2c->quirks && i2c->quirks->max_read_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
> +	if (i2c->quirks && i2c->quirks->max_write_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);

Does this limit the read block size incorrectly based on the write limit?

The write portion of an I2C read transfer is always 1 byte for the EEPROM
offset, regardless of the read block size.

If an adapter has a max_write_len of 1, max_block_size will drop to 1.
Since sfp_hwmon_probe() checks if sfp->i2c_max_block_size < 2 to ensure
atomic 16-bit reads, does this inadvertently disable hardware monitoring for
adapters that have a small write limit but sufficient read capabilities?

Also, for actual write transfers, sfp_i2c_write() prepends a 1-byte register
address to the payload. If max_block_size is set exactly to max_write_len,
won't the resulting message length be 1 + max_write_len, which still exceeds
the adapter's quirk limit?

Additionally, looking at sfp_i2c_write(), it does not appear to loop or
chunk the buffer using sfp->i2c_max_block_size. Does this mean the new
limit will be ignored during writes, and the function will still attempt
to transfer the entire buffer in a single operation?

> +
> +	sfp->i2c_max_block_size = max_block_size;
>  	return 0;
>  }
-- 
pw-bot: cr

