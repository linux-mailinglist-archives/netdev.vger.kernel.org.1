Return-Path: <netdev+bounces-291418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIG9HnGXFGpfOgcAu9opvQ
	(envelope-from <netdev+bounces-291418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8BB5CDB99
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 607AA30166CD
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 18:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D91305684;
	Mon, 25 May 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+wNOP47"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282232036E9
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734382; cv=none; b=FT4GrTUSKbzE9Ps1jUckzVLaaKSSOGiUZF6NOU0svv6VKxAKI/ymdLwVDc6iDw3ffN43vmJFie1zfyAdHVA9FGHhqGobtoc93T9XfRrvY3RJyjYFqh5ipBrmm6IGraoA3MFUh4FIV2KC20r5Kf2WKD/6qv2Ey+JNBLBSFBlIXjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734382; c=relaxed/simple;
	bh=PJDFAWXaR6L4uYu0iC3KGYXdj5qCuBq9eXqnYOyFR6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QQCAC6Ee3TQ6oqu0Bm/HCiTLOzeLy1D0ByoU2uuZzaLIMZX9UJcIQ5HW/zC1QgWlzQ6Cpco98fDBCqZRYoYSlkcjH37ulxVr9gbJVLawAr7nXiqIQWousj2ZPYpsQ60rf0eWDsIaHvCEh28ej4C9u9xKPJPdvd5DgiQUvmJjjZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+wNOP47; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D521F000E9;
	Mon, 25 May 2026 18:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734380;
	bh=UjDs4ATgJmwUB8jTLWl6nDQrt3/iJO531yAfxd9H4Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+wNOP47sGyuAnn/uYRcNi8UnBrA2vlJi1XQ8VTRy3br1UaFx14jJ6mYuF5K67kpU
	 TqvO6aryMtujOl44vdrsolHE7qqH1ygiAC/ip+X1j73M4VXEgel6WXYPUTk/hZd4dj
	 u6p8QW0iahmrESpTvvoElcZREqBGSvy1NXHr3aruh9Qi2rwY7kLqx8MsyUYNZY9Kqu
	 5sgKBLfdTjO6K8D/BDZP3UhGDONoqcFBLnwzOOseTnbrj/MrXMQH/MTrPl4cn76H9x
	 sGfQ6tY7IOOdj3bFH27ayccjLHHxQRdNR5tyOQ5RXOXxkL1k88O4LS6H8/G4lLKLBD
	 KH4h0ueZNrquQ==
From: Jakub Kicinski <kuba@kernel.org>
To: vadim.fedorenko@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com,
	rmk+kernel@armlinux.org.uk,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4] ptp: ocp: fix resource freeing order
Date: Mon, 25 May 2026 11:39:39 -0700
Message-ID: <20260525183939.2381235-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522160903.2659871-1-vadim.fedorenko@linux.dev>
References: <20260522160903.2659871-1-vadim.fedorenko@linux.dev>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lunn.ch,davemloft.net,redhat.com,nxp.com,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291418-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: ED8BB5CDB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
ptp: ocp: fix resource freeing order

This change reorders ptp_ocp_detach() so that ptp_clock_unregister() runs
before the external timestamp sources are torn down, and adds a
synchronize_irq() inside ptp_ocp_ts_enable() when disabling, to address a
use-after-free introduced by commit a60fc3294a37 ("ptp: rework
ptp_clock_unregister() to disable events").

> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index beacc2ffb166..1ac58951188a 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c

[ ... ]

> @@ -4867,6 +4872,18 @@ ptp_ocp_detach(struct ptp_ocp *bp)
>  	ptp_ocp_detach_sysfs(bp);
>  	ptp_ocp_attr_group_del(bp);
>  	timer_delete_sync(&bp->watchdog);
> +	/* Disable interrupts on all timestampers */
> +	if (bp->ts1)
> +		ptp_ocp_ts_enable(bp->ts1, 0, false);
> +	if (bp->ts2)
> +		ptp_ocp_ts_enable(bp->ts2, 0, false);
> +	if (bp->ts3)
> +		ptp_ocp_ts_enable(bp->ts3, 0, false);
> +	if (bp->ts4)
> +		ptp_ocp_ts_enable(bp->ts4, 0, false);
> +	if (bp->ptp)
> +		ptp_clock_unregister(bp->ptp);
> +	kfree(bp->ptp_info.pin_config);
>  	ptp_ocp_unregister_ext(bp->ts0);
>  	ptp_ocp_unregister_ext(bp->ts1);
>  	ptp_ocp_unregister_ext(bp->ts2);

[High]
The commit message says "To avoid irq handler running on the other core
while ptp device unregistering, call synchronize_irq() after HW is
configured to stop producing irqs and no irqs are in-flight." Does this
pre-disable loop cover all of the timestampers that share the
ptp_ocp_ts_irq path?

The loop disables ts1..ts4 but not bp->ts0 or bp->pps, yet both of those
sources go through ptp_ocp_ts_irq() which calls ptp_clock_event(ext->bp->ptp,
&ev).

After ptp_clock_unregister(bp->ptp) returns, the matching put_device() inside
it can drop the final reference and free bp->ptp via ptp_clock_release().
Until ptp_ocp_unregister_ext(bp->ts0) and ptp_ocp_unregister_ext(bp->pps) run
later in the function (which call ext->info->enable(ext, ~0, false) and the
internal synchronize_irq inside pci_free_irq), can an in-flight ts0 or pps
interrupt dereference the freed bp->ptp?

ts0 is the GNSS1 PPS timestamper and bp->pps is the internal 1 Hz PPS, both
of which userspace can enable via PTP_EXTTS_REQUEST without ever populating
pin_config (they have no SMA pin to map), so ptp_disable_all_events()
walking pin_config does not necessarily turn them off. For bp->pps in
particular, when only OCP_REQ_TIMESTAMP is set in pps_req_map,
ptp_ocp_ts_enable() takes the early-return path:

	if (ext == bp->pps) {
		u32 old_map = bp->pps_req_map;

		if (enable)
			bp->pps_req_map |= req;
		else
			bp->pps_req_map &= ~req;

		/* if no state change, just return */
		if ((!!old_map ^ !!bp->pps_req_map) == 0)
			return 0;
	}

so even a disable from ptp_disable_all_events() can leave the HW enabled.

Would extending the pre-disable loop to also cover bp->ts0 and bp->pps
(using ~0 as req, like ptp_ocp_unregister_ext() does, so the pps early
return is not hit) close the same race for those sources?
-- 
pw-bot: cr

