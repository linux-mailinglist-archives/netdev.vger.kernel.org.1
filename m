Return-Path: <netdev+bounces-283055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDUvBeb+82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3AB4A9852
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 83FF63012E7D
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FEF2DEA94;
	Fri,  1 May 2026 01:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brfdpKgk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447292DE70D;
	Fri,  1 May 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598162; cv=none; b=XUyi6MujO8akr29mbqpH5S2wWzTw6Uh2wUoHKIBrj4OEYrj9Ps24RqvoLGM2Segxns2dk1fMcTPOYsAhWjcKLgwewfwulISoeX/hBxkK7JG68KYBaveOY/uGORCs5LtE3nTkKVSfv1QMXjD76Jm9Y1Ew8Qw/keG5quybWPnBK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598162; c=relaxed/simple;
	bh=ngL/SCzyDDBySzCH6KewEFzjQ7ltMA/20XJ5OAl08rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQSisGcDeyjDMeOVo7UK0gIBN07McZEM+FJu87MdoDNAVgOyxqN4948CbwiBJiL6IQ4IxGeCDCl86+7BEFJgG2xFHed1fIeS44VuDcEuxLXJMPgpCnrg3KP7dfP7s0IJflb5BQJG6eW9usRM0nQKLcGDE7bb16Uo/kD08MHx/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brfdpKgk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60053C2BCB8;
	Fri,  1 May 2026 01:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777598161;
	bh=ngL/SCzyDDBySzCH6KewEFzjQ7ltMA/20XJ5OAl08rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brfdpKgkCbWIGB9RWdDtV5RWGTuzj0e87nTN1/DUPNiaFoflCu0pm8vz98FLWeMTO
	 XA7pnEe+su5SWaBc5WQF5G+Lm3Bb6A5lITiidJgVc1My1JjI5HDJ77zY0wRXTIuMNH
	 fBweStdIXNROEeRY1SMh76CiXgY005+gVsgrXA+wBIcomrg4uFP20piWl41T62bVEa
	 tsaUYf/UVOPuLU4XNM/duKWqxUXjXJc0gAh6zBTV1iH4FeKJOoWIRm63jXd887Qu2e
	 k7KbcqyLasA/NorOzcHFy506RO1x3LDU5AmflGqlGpKsDsKA6F/AGVQLxlz/wkieYo
	 vl2HmZdw11uVg==
From: Jakub Kicinski <kuba@kernel.org>
To: mail@birger-koblitz.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hsu.chih.kai@realtek.com
Subject: Re: [PATCH net-next v2 3/4] r8152: Add irq mitigation for RTL8157/9
Date: Thu, 30 Apr 2026 18:16:00 -0700
Message-ID: <20260501011600.3154202-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429-rtl8159_net_next-v2-3-bab3cd4e4c66@birger-koblitz.de>
References: <20260429-rtl8159_net_next-v2-3-bab3cd4e4c66@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CE3AB4A9852
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283055-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: Add irq mitigation for RTL8157/9

This commit clears bits 0, 1, 2, and 7 of USB register 0xcf04 in
r8156_init() for RTL_VER_16 and later, with the stated intent of avoiding
intr URB completions with urb->status == -ESHUTDOWN on RTL8157 and
RTL8159.

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 2a07dde289e2..9fcad3dac76f 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8452,6 +8452,12 @@ static void r8156_init(struct r8152 *tp)
>  	else
>  		r8153_u2p3en(tp, false);
>  
> +	if (tp->version >= RTL_VER_16) {
> +		/* Disable Interrupt Mitigation */
> +		ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04,
> +				  BIT(0) | BIT(1) | BIT(2) | BIT(7));
> +	}
> +

The subject and changelog describe this as adding "irq mitigation" /
"interrupt mitigation code", but the in-tree comment says "Disable
Interrupt Mitigation" and the operation is ocp_byte_clr_bits(), which
turns a hardware feature off.

Would it be clearer to phrase the subject along the lines of "r8152:
disable hardware interrupt mitigation on RTL8157/9" so that someone
bisecting or searching the log for when this feature was "added" is not
led in the opposite direction?

The same sequence already exists in rtl8153_unload():

	static void rtl8153_unload(struct r8152 *tp)
	{
		if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
			return;

		r8153_power_cut_en(tp, false);

		if (tp->version >= RTL_VER_16) {
			/* Disable Interrupt Mitigation */
			ocp_byte_clr_bits(tp, MCU_TYPE_USB, 0xcf04, BIT(0) | BIT(1) | BIT(2) | BIT(7));
		}
	}

That copy was introduced by fd3c7d080df5 ("r8152: Add support for the
RTL8157 hardware"). Now that the bits are cleared during init, does the
unload-path copy still serve a purpose, or can it be removed as part of
this change?

The register 0xcf04 and the bit selection BIT(0) | BIT(1) | BIT(2) |
BIT(7) are bare numeric literals, while most of the file uses named
defines (USB_MSC_TIMER, USB_U2P3_CTRL, U2P3_ENABLE, and so on). Could
this change also introduce a symbolic name for the register and for the
individual bits being cleared, so reviewers can check the mask against
the datasheet and tell which bit is the enable versus threshold versus
reserved?

On the causal chain:

The changelog links the register write to intr URB completions with
status -ESHUTDOWN / -108, but does not explain how a MAC-side
interrupt-mitigation setting produces that status.

-ESHUTDOWN on an intr URB is normally posted by the USB core when an
endpoint has been disabled or the device is disconnecting. Could the
commit message describe the mechanism by which clearing these four bits
prevents the host controller from observing endpoint shutdown, and cite
the datasheet naming for bits 0, 1, 2, and 7 of 0xcf04 so it is clear
why exactly those bits (and no others) are the correct set to clear?

