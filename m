Return-Path: <netdev+bounces-280835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEfxMSBo6mkHzAIAu9opvQ
	(envelope-from <netdev+bounces-280835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:42:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDB74562A5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D66C30067AA
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714E43AE19B;
	Thu, 23 Apr 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KHM1jLB3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD5D36604E;
	Thu, 23 Apr 2026 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776969742; cv=none; b=tzdG3cseUfJY96FdLlLJW9O+OS/CG4kLlewTquMosjC9SqJRDuOIg9EkeBDgNpP+XHnWQriddMbSW0xhiZ+nqzw8GzrA1w8LmQwvNzZiJskRaCNIcn+U2U+nu8SVBIKmzqvhNHmjGCsb3+qzHo+UJuoAMKse7rWFJKjw8rvQVpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776969742; c=relaxed/simple;
	bh=WbCoSoiwc5ZyFGTdIGE32GPWpM0HWDFdoFoCYpEPS9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jG4fU/GYg3NQYW3RmbZtoQPV0yH9LU3bZAmJ2LGzdq1fA1NbNizTsryZYa7npNmug0eBTkuwkefh1ifbQvAyW4d0h278X9+4t7hd17IEK3mrH8/CDM0GsxKogZCjk+el9fyV0DbsAeWyTIjlbJMczfPSMZRA3HnlATQ9G3sVa30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KHM1jLB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A9FC2BCAF;
	Thu, 23 Apr 2026 18:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776969742;
	bh=WbCoSoiwc5ZyFGTdIGE32GPWpM0HWDFdoFoCYpEPS9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHM1jLB3PLZwoHbEuqjiCeJHo7KIuSYtEvO5SKUOM3cl2P6C2TDm273bSat2xmeSp
	 Yb1xQsiuhGr6TZoWPUedrPuYCUZUcz2uN9aItYjGqEqw4pOAT8eQgheR6nrj5hMWc1
	 CgxUg/BOmMmfquR8GadyrBIDOi4X4+EzMJ0pWYJDxcVifXaWZ77Usc0xc4CyUcpaDj
	 g+OoCHS5TIAQ+mGj3J26ubxuzP8zjZ7SaicTHfedheETCpO0jcJ65E+A6mkQANMltB
	 tcsV35cJ5SzHxkjkKlyViZ2bIS0Qg+DMTWV49aC7S6MTFVO61Dg3WJVLtkC0pxcCFa
	 MiAmpDF1bn4Gg==
From: Jakub Kicinski <kuba@kernel.org>
To: zhangdandan@uniontech.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,
	petkan@nucleusys.com,
	andrew+netdev@lunn.ch,
	andrew@lunn.ch,
	michal.pecio@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	linux-kernel@vger.kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-usb@vger.kernel.org,
	edumazet@google.com
Subject: Re: [PATCH v2] usb: rtl8150: avoid using uninitialized CSCR value
Date: Thu, 23 Apr 2026 11:42:17 -0700
Message-ID: <20260423184216.3235637-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <F20002D619544E87+20260421105145.11394-1-zhangdandan@uniontech.com>
References: <F20002D619544E87+20260421105145.11394-1-zhangdandan@uniontech.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,syzkaller.appspotmail.com,nucleusys.com,lunn.ch,gmail.com,vger.kernel.org,davemloft.net,redhat.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-280835-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 1DDB74562A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
usb: rtl8150: avoid using uninitialized CSCR value

This commit fixes an uninitialized variable bug in set_carrier() where
get_registers() could fail, leaving tmp uninitialized. The fix adds a
return value check to bail out on error, preserving the existing carrier
state.

Reported-by: syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db6c624635564ad813c
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

> set_carrier() reads CSCR via get_registers() (a USB control transfer)
> without checking the return value, so a transient control transfer
> failure would leave the on-stack "tmp" uninitialized and then be used
> to decide the netif carrier state.
>
> Check the return value of get_registers() and bail out on error,
> leaving the previously known carrier state untouched. A failed USB
> control transfer here may be transient (e.g. EMI, flaky cable, retries
> exhausted), so it is wrong to force the link down on such failures and
> cause the carrier state to toggle unnecessarily.

The commit message says "it is wrong to force the link down on such
failures" - but is this characterization accurate?

The original (pre-patch) code did not deliberately force the link down on
failure. It used an uninitialized value, which would randomly either set
carrier on or off depending on stack contents. The statement reads as if
the original code forced link down, but the original bug was random
behavior from uninitialized data.

The "force the link down" language more accurately describes what the
rejected v1 patch did, and why v2 changed the approach to just returning.

>
> This only addresses the uninitialized-value usage and does not change
> link-state policy.

Is this description fully accurate? The patch does change observable
behavior:

Before: on get_registers() failure, carrier state was set to a random value
(on or off based on stack contents).

After: on failure, carrier state is preserved unchanged.

This is a change from "set carrier based on garbage data" to "preserve
previous carrier state." While "using uninitialized data" was never an
intentional policy, the commit does introduce a new explicit behavior
(early return preserving state) that did not exist before.

Additionally, set_carrier() is only called from rtl8150_open() in this
driver, meaning the "previously known carrier state" at that point is the
default state from alloc_etherdev (carrier ON, since __LINK_STATE_NOCARRIER
bit is 0 in zero-initialized memory). On first open, a get_registers()
failure would preserve carrier=ON, which could report link up when the
register read failed.

> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 4cda0643afb6..76962dcd127d 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -722,7 +722,8 @@ static void set_carrier(struct net_device *netdev)
>  	rtl8150_t *dev = netdev_priv(netdev);
>  	short tmp;
>
> -	get_registers(dev, CSCR, 2, &tmp);
> +	if (get_registers(dev, CSCR, 2, &tmp) < 0)
> +		return;
>  	if (tmp & CSCR_LINK_STATUS)
>  		netif_carrier_on(netdev);
>  	else
-- 
pw-bot: cr

