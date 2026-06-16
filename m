Return-Path: <netdev+bounces-299695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W8XuEk6nMGrCVwUAu9opvQ
	(envelope-from <netdev+bounces-299695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:30:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3887A68B451
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 03:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Hx/ymYIa";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299695-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299695-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 893EB301E47E
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AAA3793B6;
	Tue, 16 Jun 2026 01:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AB8322C88
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 01:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781573318; cv=none; b=mV+ZNd50TaTBUslYrxgqaUz77YXoWClrHErDgIK8+DBP091Q3ZBx3gTIp4V4P8tebR4tKBpeY/sCfDMzPlVFaR/OZG2byjT3n3PBswdGX1i0smXcphMWO1K3Xe6i4qTWh5SLptNCjZmOxdO73nRZxN3MMPvhuJu1Vv8iguFayn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781573318; c=relaxed/simple;
	bh=Jfj/qST2SynNhgunrW/TikyhLckofUnsfRusM6W2AjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alCkp8Re1BM6+EbsPNO6rF5o9wmY6F+h58PnCiaz1dKuno6IHTW2h8xXSyFI9rxhnWMF44huZqFaRpQHmVgMsmL21vH3NDJlXp8gjClDGhJA8D73eoXpqQr8CbyWssKYeGmcDD9gx3CZtB577YhsSuH8nFfd2tIpKr5FY9QWvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx/ymYIa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B9C1F000E9;
	Tue, 16 Jun 2026 01:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781573317;
	bh=gSyUofyLXOVTQd+RwXpSZRUGlZReLxUO8C/6tz2LHBk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Hx/ymYIahQU3R6ULVGOjS95v3SJjVRMaCmuGfQbTGZ5JV+T1+vBhc4w9NTkjTW+pb
	 t4rjLWcRoZmEq8W1cWw0L00sKEAbDfDBsyqfkQhaa2+hTqBVMr1W0Y57gGGwVmBpc1
	 TcCEq2/6Cqkm3Oy6OKHppwGiHlL+AopaVSMzJqwtsFUz2a8rpdjsxNb6F1i5YH0qKM
	 2pQb7PqXb9voYdFh1Tc9uSBZAUIEUlgNrTfAhe0ArlSR7ZBu401opNCMGMwb8NJHMt
	 qSUSXkG4cKDCNd5JeMYXqQyimgNVroIzfrs6wx2DR1xIYK3QnU8lmHxXAdqsSqbtrF
	 zZ/bbHWt3uSrA==
Date: Mon, 15 Jun 2026 18:28:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Creeley, Brett" <bcreeley@amd.com>
Cc: Breno Leitao <leitao@debian.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, brett.creeley@amd.com,
 eric.joyner@amd.com
Subject: Re: [PATCH net-next] eth: ionic: delete the incorrect
 link_down_count reporting
Message-ID: <20260615182836.24b0b329@kernel.org>
In-Reply-To: <3193fb6f-d786-4b8a-ace3-d63264c95529@amd.com>
References: <20260615170153.592171-1-kuba@kernel.org>
	<ajAye8LnVeqkcGLZ@gmail.com>
	<3193fb6f-d786-4b8a-ace3-d63264c95529@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299695-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bcreeley@amd.com,m:leitao@debian.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3887A68B451

On Mon, 15 Jun 2026 10:29:54 -0700 Creeley, Brett wrote:
> >>        memcpy_fromio(p + offset, idev->dev_cmd_regs->words, size);
> >>   }
> >>
> >> -static void ionic_get_link_ext_stats(struct net_device *netdev,
> >> -                                  struct ethtool_link_ext_stats *stats)
> >> -{
> >> -     struct ionic_lif *lif = netdev_priv(netdev);
> >> -
> >> -     if (lif->ionic->pdev->is_physfn)
> >> -             stats->link_down_events = lif->link_down_count;  
> > It seems this is the only place where link_down_count is read. Maybe you
> > want to kill it as well?  
> 
> It still shows in debugfs, but we'd be fine with it being removed 
> completely in favor of the correct implementation from Eric at: 
> https://lore.kernel.org/netdev/20260614205303.48088-5-eric.joyner@amd.com/.

TBH I missed that Eric posted v5 already and assumed he won't make it
before net-next is closed. Sorry for the noise...
-- 
pw-bot: reject

