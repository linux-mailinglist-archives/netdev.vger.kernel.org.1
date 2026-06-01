Return-Path: <netdev+bounces-293833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOWuACS2HWrKdAkAu9opvQ
	(envelope-from <netdev+bounces-293833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 09169622BB2
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 18:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E690B3055C2A
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 16:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B92DF13A;
	Mon,  1 Jun 2026 16:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2xnAnGx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D522DF128;
	Mon,  1 Jun 2026 16:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780331113; cv=none; b=ft9muFr7fOmWl/aCseQBlZgBh/0BmXN2MAXdSyDRjyLGfqIRDJjb7RhNwL7C86Qb7Gsh0IK4SwiZu8ZC6d65jfbixN3QQ+t2hu0N3JKbCPsmvBIAMYsosb94TS5IcklkW/sYSd/hytQWWObGMa2hUfr2bqDFgRZucQIOa7sM/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780331113; c=relaxed/simple;
	bh=a/2j98RM30qIxdsZ3v45ThNelusFdBWUnni1djAh8jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9k1p+6BDl525OlkzkwP6wOyg04++eiS2H71pzbBqO9K/aGGJ5enaDDAOR3ahjOJc5OYvlzG2T16k9csWUrPgnw5Ip3zzni9UzB0sDLte9WMVINu3497+4nbjsaCo6+/LarKxtO7HENTv1hBnw5OcIeq2wsHJuctqjYIUBDsGNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2xnAnGx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6784E1F00898;
	Mon,  1 Jun 2026 16:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780331112;
	bh=7PAmwkD34UQye33gguhmlEOcOirCvsEcwdFyQYwGycI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=V2xnAnGxwg1z15e7bN9cciloH4mp5HBYj4E/iUO5cssQa7i+KdJ00L+/s5HGtnA87
	 Q6zu7ffDCd9R5pzrikt2HrRrGPXLIJ1nQOHpnX8TaaJBxFDU/ngSzSIz3LRnNMc/yR
	 GVn9boqSYVHTYio2Cj64cpx/muw4eiV/4FIa7efhAysIaUOROLYRqjzNxx8RiS2BhN
	 +EisjUdONtJK2NWxIRDmTUBio3N3iqQf/oqtEAPmmxyTZStHnXtjENmORlgoLLGvFC
	 lVbpvDpout4AStjVcBhB2jW3VQtvjdubkZzEC80yDf7c+h2jQ9S8E0G90/eCUgit8X
	 tenLNXJ+JwMSQ==
Date: Mon, 1 Jun 2026 17:25:06 +0100
From: Simon Horman <horms@kernel.org>
To: Carlo Szelinsky <github@szelinsky.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: pse-pd: disable IRQ before freeing PI data
 in unregister
Message-ID: <20260601162506.GY2256768@horms.kernel.org>
References: <20260527125551.2425511-3-horms@kernel.org>
 <20260530105031.3274303-1-github@szelinsky.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260530105031.3274303-1-github@szelinsky.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293833-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 09169622BB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 30, 2026 at 12:50:31PM +0200, Carlo Szelinsky wrote:
> Hi Simon,
> 
> Thanks for the review.

Hi Carlo,

Likewise, thanks for your response.

> > pse_flush_pw_ds() runs before disable_irq(), so an interrupt could
> > hit a freed regulator.
> 
> Correct, and it's the same bug. I moved disable_irq() above
> pse_release_pis(), but pse_flush_pw_ds() still runs while the IRQ is
> live, and it can free pw_d->supply. The ISR uses that supply via
> pse_pi_deallocate_pw_budget(). So the race stays open.
> 
> Fix: disable the IRQ (and cancel the poll work) before
> pse_flush_pw_ds() too. I'll fold that into patch 1 for v2.

Ack, sounds good.

> > cancel_work_sync() after pse_release_pis() may use freed pcdev->pi.
> 
> I don't think so. The worker only touches the kfifo and the
> pse_control list, not pcdev->pi. The patch 1 message says this.
> Did I miss a path where the worker reaches pcdev->pi?

I am concerned that this can occur if pse_send_ntf_worker()
calls pse_control_put(). In which case __pse_control_release()
may run, which accesses psec->pcdev->pi[psec->id].admin_state_enabled.

> 
> > Regulator ops still reachable after pcdev->pi is freed.
> 
> That is what patch 2 fixes for the disable path. Are you pointing at
> a different path than the regulator_unregister() disable flush?

I agree this relates to patch 2/2, and I wonder if you may have
missed the AI-generated review of it that I forwarded.

* https://lore.kernel.org/netdev/20260527122418.2410341-2-horms@kernel.org/

I think the problem here is that wile patch 2/2
addresses pse_pi_disable by adding a check for !pcdev->pi,
it doesn't address similar problems in pse_pi_is_enabled()
and pse_pi_enable().

I'd also like to draw your attention to the issue around synchronising
access to pcdev->pi in pse_release_pis in the review of 2/2.

> 
> > device still in the list / external consumers / power domain tied to
> > devm lifetime.
> 
> These look pre-existing and not part of this series. Do you agree, or
> do you see one of them as caused by this series?

Thanks, agreed.

> The pre-existing items above (list, consumers, devm lifetime) - would
> you want them fixed inside this net series, or handled separately on
> top? So I know what to do before sending v2.

For these last three pre-existing items I think it's best to handle them
separately. To avoid complicating this series more than necessary.

