Return-Path: <netdev+bounces-299049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j+AOMmjELWr1jgQAu9opvQ
	(envelope-from <netdev+bounces-299049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:58:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F0567FBF0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 22:58:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BCaRzmT3;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299049-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299049-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED642300DE07
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 20:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E6C346E4A;
	Sat, 13 Jun 2026 20:58:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04F175A98
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:58:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781384293; cv=none; b=nuqvT8QvJyKgnWmmf6gsqX2/u2P9QB51fav6qt/4ZKI002jIQhUVHHJsAlkzAT5+Tlw0yrKUnhcHcl7gfXwMWmoqKDmKTcue18/A0f242dqU19/M1bmd246Qp3MQZuKmHyDnejR4g95dBOua7J/QOizC3IZ8CCh5crWypeQTIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781384293; c=relaxed/simple;
	bh=3nBhZeYiHMX2zMnpYVDOAT9NHkw6oeaoPdhfAUWbryw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Si69CnpuY/f5oPHKsPIMg9nwXhnAjWqt7RyrPWmIVI4fhrquQ2Rd2lf1yIoqMgGXPXewrQ5nNzCJnvBgvlmf0UJX8VcDWGXtqo/znrAnMy2+54ScnMAoV0eOabSpZSYuTZ+0YpRsc+LCzU0LHODpFilinvQVomIRhUxABfuUKcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCaRzmT3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FC31F000E9;
	Sat, 13 Jun 2026 20:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781384292;
	bh=B2/g24u/B3IlVlFIdF4xAGM6NUHRm2qY0j8rAQtLGZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BCaRzmT37JDvwz2hITBFT514RZEJOs4ct+rJzw/gftB2wOCkSVKIRX8zF3z7L7CvL
	 QXymi7WIO68JEczcwOSJy7mQPF/HCtNS8bsrrnXXzIwwo4v/DAl7JN8FNFI159UH96
	 5i8B1yu7CKnzuuXhlL+rDV3iWPu0XVOwCp38QldqDVeHegpMf82LO7xpwIFWE8N4y9
	 i5We5/RZ7j+26MePBUC9WWytbVjmLQIm0E99ZltIUXGUXVURanfyUetvgIqcNx0Goc
	 OVtA+256fcqJOa1ZGV9MCPQI72mCpMs+viFstSeYLXz8HoTYMjFIMtePE9wdIezeUK
	 aWGlkxqfWzeSA==
Date: Sat, 13 Jun 2026 13:58:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "Rao, Nikhil" <nikhirao@amd.com>, <netdev@vger.kernel.org>, Brett
 Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Eric Joyner
 <eric.joyner@amd.com>
Subject: Re: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and
 host backed memory support
Message-ID: <20260613135811.1b1f7e65@kernel.org>
In-Reply-To: <1264de6d-a669-4afa-ad08-594d956e101a@intel.com>
References: <20260608223256.12357-1-nikhil.rao@amd.com>
	<75c74b95-097a-47c9-9a55-a4150394abf8@amd.com>
	<41d3815e-f060-4003-9974-42530addc641@intel.com>
	<9e0a17e1-006d-473a-adff-ab76bf91d0ab@amd.com>
	<1264de6d-a669-4afa-ad08-594d956e101a@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299049-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jacob.e.keller@intel.com,m:nikhirao@amd.com,m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:eric.joyner@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 20F0567FBF0

On Thu, 11 Jun 2026 11:53:13 -0700 Jacob Keller wrote:
> On 6/11/2026 10:15 AM, Rao, Nikhil wrote:
> >> The preference is to use generic names when possible/feasible. I think
> >> at least some of your name choices could align with the generic ones.
> >>
> >> Could you explain why fw.mainfw was selected and fw.mgmt was deemed not
> >> suitable?  
> > 
> > This component handles both control and data path, so fw.mgmt didn't
> > feel right since devlink-info.rst explicitly excludes data path from
> > that definition. We went with fw.mainfw to indicate it's the primary
> > firmware component
> 
> It might make sense to extend or add a new definition in this case.
> Technically you could also report both fw.mgmt and fw.app together, but
> I think that would be more confusing.
> 
> Perhaps Jakub has a suggestion on the name or policy here. The
> maintainer preference has generally been to use or extend standardized
> names first unless the name or component is clearly unique to the device.

If it covers both datapath and mgmt then shouldn't it be just "fw" ?
Right now driver reports something "running"-only as "fw", looks off

