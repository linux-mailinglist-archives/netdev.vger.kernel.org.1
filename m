Return-Path: <netdev+bounces-296671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Nw9AOD2JmqQowIAu9opvQ
	(envelope-from <netdev+bounces-296671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:07:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDF965912B
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:07:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BZWbwcZS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296671-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-296671-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCDF3013855
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 17:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1E733CEB0;
	Mon,  8 Jun 2026 17:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36E4315F;
	Mon,  8 Jun 2026 17:07:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938457; cv=none; b=dEY7iQZ9IeeLC2GArjcgp4CoTKpJd20vGBSjOaOP2QyCeOa0AZDoefUecp2B9yW5xucnzBQohzD9Ik+jJaqVxZg8+jP0n/rIWOftbO6SFa0ncwjD5VEzrOXBaAU6n3nCREh5+lVFvormp0F5W0t2Nh96UJSxfKTp0rEWOdnIMhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938457; c=relaxed/simple;
	bh=5cy9056yJkRwFbv0rjr5k8jqzWhvL0JLPC0ZsGHp4vI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hPcwOvCX/1rmUogj5Yrbr/5nflxzJgf2ru0PsMd3T4ELimbwsIbDbSa1X6t/DjRqGmYtuHk9jnExCIgR+hWmZ2Fu8NN1IRQ5Wg4gaEQOSudDrfJriQfmkANvBf5OGvM+uQhla7N0mPD2ky+7gvAB/xqfqedJy4nuYoIAr/88FTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZWbwcZS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248491F00893;
	Mon,  8 Jun 2026 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780938456;
	bh=gScCgqGHOpv0qq52VowbZ2TC3M1Bdb1fMHhIsQBOhXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZWbwcZSYyC7p2ntP/mF+VBbbh0FWhlDaRYCB9x4+7KjiIAZPWpOP3GHHv4Go7/rt
	 AFdj5Cu16VlycEhAGNOzHb9FmqmiQaVW8vyDgUWBG3v9HQnxJIDKP0/TKlgXjxEdL6
	 ynza+Lhclag8g0RAOd2z7Z4XKd1QWNk7WDQuS4bLoO8N6FB8/yoB0GCKwJPVeCIQwj
	 Q+dDTt+iO51zwPF66EFa0H6b2jL4XHQambIMwcQXqmYdd2aMaGbOVcS/Anlb8kJq6i
	 //m3jZExhcA0rbt+wwsQPCG/EV8Jh3DbVntuT7TMxmxhwWWLpA2pS00mAs0p8P1SSx
	 5Wbsi6zwplf/g==
From: Simon Horman <horms@kernel.org>
To: sam.moelius@trailofbits.com
Cc: 'Simon Horman' <horms@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sched: act_nat: only rewrite IPv4 packets
Date: Mon,  8 Jun 2026 18:07:13 +0100
Message-ID: <20260608170713.175154-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603180407.26100-1-sam.moelius@trailofbits.com>
References: <20260603180407.26100-1-sam.moelius@trailofbits.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-296671-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:horms@kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DDF965912B

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net/sched: act_nat: only rewrite IPv4 packets

This commit modifies act_nat to check the packet protocol before parsing and
rewriting the IPv4 header. This prevents the action from modifying non-IPv4
packets based on unrelated bytes at the network header offset.

> diff --git a/net/sched/act_nat.c b/net/sched/act_nat.c
> index abb332dee836d..34d6ba2d41432 100644
> --- a/net/sched/act_nat.c
> +++ b/net/sched/act_nat.c
> @@ -142,6 +142,9 @@ TC_INDIRECT_SCOPE int tcf_nat_act(struct sk_buff *skb,
>  	egress = parms->flags & TCA_NAT_FLAG_EGRESS;
>  
>  	noff = skb_network_offset(skb);
> +	if (skb_protocol(skb, true) != htons(ETH_P_IP))
> +		goto out;
> +

[Severity: High]
Does this code parse inline VLAN headers as IPv4 headers?

By explicitly passing true for skip_vlan to skb_protocol(), the check looks
past inline VLAN tags to evaluate the encapsulated inner protocol. If the
inner protocol is IPv4, the check passes, but noff and skb_network_header(skb)
are not advanced past the VLAN tags.

When the action later proceeds to call iph = ip_hdr(skb) at line 151 and
rewrites the IP addresses, won't it silently corrupt the VLAN tag and
adjacent packet bytes instead of the actual IPv4 header?

>  	if (!pskb_may_pull(skb, sizeof(*iph) + noff))
>  		goto drop;
>

