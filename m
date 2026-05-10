Return-Path: <netdev+bounces-286362-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BxqMsPCAGqJMQEAu9opvQ
	(envelope-from <netdev+bounces-286362-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:39:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28453505765
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E57B23018BD6
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD033B3890;
	Sun, 10 May 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnjtfzHT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE63B2FC9;
	Sun, 10 May 2026 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778434512; cv=none; b=i0lePm8F/jeIdamggFAGuBSVhKKxK7BbDuTmscnuqV90R7XxQ+Y/Le6cwdYtpTt2xrUIwmBtgO+rmOIeXxqLhtEGVptKt3oTHiN3W11hYENC5AjHmYd7fp26xa9JdzNUkMqxkEwk7XjYV35uJiJys4R29ygSeZmxRODgdHEu6ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778434512; c=relaxed/simple;
	bh=5EWgF5u1LQVhh4BHRahQTBHFRRuASQs4CgCGgwRZg3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/nYon/h0P1FPUXowlbE+vaI+gvy+WbYMVG5wXes2rAXX0ZlZ7Ufe5PDSn5QsHJME/v2WCvNFmgke4VzA7C8swe92KOcSxupGaGb72bVLvCPiannqhY83A9WpCqNIl4AClLxvOCl9p9ww+87YZHY3OjAOf61TuWdqsHAZr2MQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnjtfzHT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D98C2BCB8;
	Sun, 10 May 2026 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778434512;
	bh=5EWgF5u1LQVhh4BHRahQTBHFRRuASQs4CgCGgwRZg3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnjtfzHT8w5ZP7+nkWKA2jh5y3XOrNEZl5f1Aa1uTcgCUAu80JRISZ/61MbzusCr2
	 iY0lMj2eZ8E7OgeadyqsiJjFD+Vj1LguPxQqHVBGpl3dJjbysbEUG6/Y1DYUdzohBX
	 hfUWK7SFGZxtTKucaj4UohZCb20as91F5XN7Eyx3yVJYIVYQl8mR0LmCHQPkvfIPIN
	 apT1vfOaKv3eLG7b9bFtrLbGD6nC8Pkrr0hz+R/KLKVBBR3eeD8fV2TbL7RmjaEAlP
	 DpFYHHLEH2XJAWWZ2HlPfswhNb3OfS8vGISa0ZN285aSpQN8OSmItAxxdSS4iB2VmU
	 I004TYK1FADHw==
From: Jakub Kicinski <kuba@kernel.org>
To: luizluca@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linusw@kernel.org,
	alsi@bang-olufsen.dk,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v3 2/8] net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration
Date: Sun, 10 May 2026 10:35:10 -0700
Message-ID: <20260510173510.3919983-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-2-1d87c5f85a3b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 28453505765
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
	TAGGED_FROM(0.00)[bounces-286362-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.910];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: dsa: realtek: rtl8365mb: use dsa helpers for port iteration

This commit modifies the port initialization to use DSA iterator helpers
instead of manually iterating over ports. It introduces an initial blocking
phase for all ports and updates the isolation rules for CPU and user ports.

> diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
> --- a/drivers/net/dsa/realtek/rtl8365mb.c
> +++ b/drivers/net/dsa/realtek/rtl8365mb.c
[ ... ]
> @@ -1974,44 +1977,58 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
[ ... ]
> +	/* Start with all ports blocked, including unused ports */
> +	dsa_switch_for_each_port(dp, ds) {
[ ... ]
> +		/* Start with all port completely isolated */
> +		ret = rtl8365mb_port_set_isolation(priv, dp->index, 0);
[ ... ]
> +	userports_mask = dsa_user_ports(ds);
> +
>  	/* Configure CPU tagging */
>  	dsa_switch_for_each_cpu_port(cpu_dp, ds) {
[ ... ]
> +		/* Forward to all user ports */
> +		ret = rtl8365mb_port_set_isolation(priv, cpu_dp->index,
> +						   userports_mask);

Will CPU ports be prevented from forwarding traffic to downstream switches
in a multi-switch configuration?

Since dsa_user_ports(ds) only includes user ports, the userports_mask will
exclude DSA cascade ports.

> +		if (ret)
> +			goto out_teardown_irq;
>  	}
> +
>  	cpu->mask = dsa_cpu_ports(ds);
>  	cpu->enable = cpu->mask > 0;
>  	ret = rtl8365mb_cpu_config(priv);
>  	if (ret)
>  		goto out_teardown_irq;
>  
> -	/* Configure ports */
> -	for (i = 0; i < priv->num_ports; i++) {
> -		struct rtl8365mb_port *p = &mb->ports[i];
> -
> -		if (dsa_is_unused_port(ds, i))
> -			continue;
> -
> +	/* Configure user ports */
> +	dsa_switch_for_each_user_port(dp, ds) {
>  		/* Forward only to the CPU */
> -		ret = rtl8365mb_port_set_isolation(priv, i, cpu->mask);
> +		ret = rtl8365mb_port_set_isolation(priv, dp->index, cpu->mask);
>  		if (ret)
>  			goto out_teardown_irq;
>  	}

Does this leave DSA cascade ports permanently isolated?

In the previous code, the loop skipped unused ports and applied the CPU mask
to all active ports, which implicitly included DSA cascade ports.

Because the new setup explicitly targets only user ports and CPU ports, it
appears DSA cascade ports (DSA_PORT_TYPE_DSA) are never unblocked after
being isolated in the initial blocking phase.

