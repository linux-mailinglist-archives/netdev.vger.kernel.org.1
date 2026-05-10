Return-Path: <netdev+bounces-286339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL7zM4C3AGplLwEAu9opvQ
	(envelope-from <netdev+bounces-286339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:51:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BE1505362
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 928BF300C029
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BA83A7584;
	Sun, 10 May 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sl2I6zaP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054623A0B38;
	Sun, 10 May 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778431661; cv=none; b=KAJIqjKL03N0YE7AVv72T3KlHdSIu4B8Y4VVOZumsUnzo55qBdmtbv0Y2nZYyKWReDvNwwjuhkLFcz5ma+xjijnoptaHYCDnfC/6XE+cdKBOtE0QL7PcP4CwkrUIBfUUkbvaxBLwozDN/Li51QoKVlnEkMOMHhB+2jgJxh/XbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778431661; c=relaxed/simple;
	bh=NpbM4MnTQhnnHyItdeUqXfUQBKE0GeuFMoiQJPWJ5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oMemiFIf216Gp55CJXYz1oJ7pyGux4nuOfaY0GQtk89gS7Iigjzu3/NtCu9KRc/bmCcpQVjoCsL+88c1cfaBlKjlmMUPMOhQGpo82ZZ5P1+awVWAT5/Bc3kiRxX697ZmXeGa/cX76UoLiuedUz00YcwsrCisUeP+OKr6hxzYmxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sl2I6zaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52396C2BCB8;
	Sun, 10 May 2026 16:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778431660;
	bh=NpbM4MnTQhnnHyItdeUqXfUQBKE0GeuFMoiQJPWJ5/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sl2I6zaP9xMePXw+Z0TPBhlyV40vc07WexRrdhzbAZ7U4A8wUG+l7/CJRAoiqYghO
	 9p+1muYitvib+ld4pxUHXUUYnVCQGpHBUhZ2E5g5mTmzuUD2kS/tGIycIey4cdaQM9
	 OKJfhCvQcPQ+mQ3LG00VqgYo7cQXiadACa5GUWHBTrX/tl9603EMPszKt0HxKcQXl5
	 Dc55SJvvXuI9AP/KsjQYey6s+mKoZOfJCfgMYfBYpfIA1fRuw04aHP/9NuK2AsYK6j
	 7KfGqLWlCGyDuDpIOpBxh2xpNCC762dY8WoJy46U8r5VgB3sbS1qb8dPTuL6YKBMWT
	 uii8moO6qEDLg==
From: Simon Horman <horms@kernel.org>
To: jelonek.jonas@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bjorn@mork.no
Subject: Re: [PATCH net-next v7 1/2] net: sfp: apply I2C adapter quirks to limit block size
Date: Sun, 10 May 2026 17:47:26 +0100
Message-ID: <20260510164726.1401317-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507093301.1144740-2-jelonek.jonas@gmail.com>
References: <20260507093301.1144740-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 34BE1505362
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286339-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,armlinux.org.uk,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bootlin.com,vger.kernel.org,mork.no];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.943];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: sfp: apply I2C adapter quirks to limit block size

This commit limits the SFP I2C block size based on the I2C adapter's
max_read_len and max_write_len quirks.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
[ ... ]
> @@ -807,21 +807,29 @@ static int sfp_smbus_byte_write(struct sfp *sfp, bool a2, u8 dev_addr,
>  
>  static int sfp_i2c_configure(struct sfp *sfp, struct i2c_adapter *i2c)
>  {
[ ... ]
> +	if (i2c->quirks && i2c->quirks->max_read_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_read_len);
> +	if (i2c->quirks && i2c->quirks->max_write_len)
> +		max_block_size = min(max_block_size, i2c->quirks->max_write_len);

Does applying max_write_len to max_block_size inadvertently throttle reads
and break hardware monitoring?

The max_block_size dictates sfp->i2c_max_block_size, which subsequently sets
sfp->i2c_block_size. This block size is exclusively used by sfp_i2c_read()
to chunk read transfers. The write message in a chunked sfp_i2c_read()
operation is always exactly 1 byte (the register address), irrespective of
the read payload size. Restricting the read chunk size based on
max_write_len appears to cause unintended side effects.

If an adapter has a max_write_len of 1, the i2c_block_size becomes 1. This
forces 1-byte read chunking and explicitly skips hwmon device registration
since sfp_hwmon_probe() requires an i2c_block_size >= 2.

Will this change actually protect writes against the max_write_len quirk?

Looking at sfp_i2c_write(), it ignores sfp->i2c_block_size and does not
implement chunking. It unconditionally allocates 1 + len bytes and submits
a single i2c_msg. Any write where 1 + len > max_write_len will still be
rejected by the I2C core.

> +
> +	sfp->i2c_max_block_size = max_block_size;
>  	return 0;
>  }

