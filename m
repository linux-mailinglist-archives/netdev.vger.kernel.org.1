Return-Path: <netdev+bounces-268696-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGQaIiuQuWk5KQIAu9opvQ
	(envelope-from <netdev+bounces-268696-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:32:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E912E2AFC35
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 18:32:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCBF1306B787
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754C637B02D;
	Tue, 17 Mar 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNibuoxW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5209237700A;
	Tue, 17 Mar 2026 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768559; cv=none; b=VYqPXBIPzpO/h7D9dh9jYlGfYgPMCY7NeM9LEjaGWvqEBtZ27KcHpU/2CHz09/E18C8VTKogloHhD3HD+rb8tICf3Q/K07T8avJiPPWifDGm8sVpNqnkgDxDuh+9mmIFDuVBseNRLlLmInyYLJMwA/po2n8s54/x26N5rPOBlTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768559; c=relaxed/simple;
	bh=WGMObAJi/euI8LFo0PTJCWsPy2rtVFq+5S45GogiQRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SaEJQdPJDSLETVEEweh2sPBQpeG7Z5SFdr+n+SgkHe20A5Ok5xfOugyXx07ymT/efEhmmw5FghnTve5p8c2VeVJnQnh4XM0H6EnIkANonaI2RBfJMMJAL28QA/kZC39Ch0V2e3APbs3SavXhNP3ObwHE+1a1zX4fsJTt/Fq59+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNibuoxW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A08EC2BCB0;
	Tue, 17 Mar 2026 17:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773768559;
	bh=WGMObAJi/euI8LFo0PTJCWsPy2rtVFq+5S45GogiQRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rNibuoxWR5CB2WFVCZB1arM82Ub+U5qdWWJtsdvADWci4IrE+Xej8wMBf+3PbxIhH
	 Zn0tqiTF3ncow+imSw6GnodnRIigAhL0dm6Nl3enPiD8kmKuH5iQ0e7r99h5zx42ej
	 LaAfhzA/S0wzJhLho17dNdPf88bFla3uYMLw2OE8PbO2qThSLKY5qBYFcetNvk4dN/
	 wJDvcvAQh8HYt4zGGqlti25afZVdbh3/EvNWoGfB4QwBBDF8OU6R6E03/kjWydEq8v
	 QS/tE9UqyGZjA6bDwdC5z8XvjHyXy4hGyL0igB/JORDfjlFDLdUBKpJE+yVDAyu3XE
	 +kUrjDyDvWe7g==
Date: Tue, 17 Mar 2026 10:29:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, <horms@kernel.org>,
 <edumazet@google.com>, <sdf@fomichev.me>, <aleksandr.loktionov@intel.com>,
 <ast@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>,
 <hawk@kernel.org>, <nxne.cnse.osdt.itp.upstreaming@intel.com>,
 <magnus.karlsson@intel.com>, <pabeni@redhat.com>,
 <jacob.e.keller@intel.com>, <daniel@iogearbox.net>,
 <maciej.fijalkowski@intel.com>
Subject: Re: [net-next,3/5] ice: migrate to netdev ops lock
Message-ID: <20260317102917.14743543@kernel.org>
In-Reply-To: <21a23b98-5014-4330-998f-53acfe705d67@intel.com>
References: <20260310220624.537917-4-anthony.l.nguyen@intel.com>
	<20260313014628.1509116-1-kuba@kernel.org>
	<4537e162-6610-4c3f-b8d5-e62415322282@intel.com>
	<20260316161630.2d9ac04e@kernel.org>
	<a95fa7f2-909e-4b1c-b25a-1ee88b292ecf@intel.com>
	<20260317085025.6459821c@kernel.org>
	<21a23b98-5014-4330-998f-53acfe705d67@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268696-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,fomichev.me,gmail.com,vger.kernel.org,davemloft.net,lunn.ch,redhat.com,iogearbox.net];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E912E2AFC35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 09:15:46 -0700 Tony Nguyen wrote:
> On 3/17/2026 8:50 AM, Jakub Kicinski wrote:
> > On Tue, 17 Mar 2026 16:30:26 +0100 Alexander Lobakin wrote:  
> >> BTW, if it's not top secret, how do you run these AI reviews? Because
> >> Tony used the same link as these reports provide to deploy a setup, but
> >> we didn't manage to get as meaningful results as yours. That's why
> >> several respins of this series only due to your AI reviews, sorry =\  
> > 
> > Nothing secret, I didn't push it to the main NIPA repo because it
> > mostly vibecoded crap which is embarrassing. You can see it here:
> > 
> > https://github.com/kuba-moo/nipa/tree/air
> > 
> > It is just Chris's prompts + semcode. We run the prompts with
> > sub-agents enabled (the "orc" prompt). Right now it runs on Claude,
> > the subagents are supposed to pick the model by themselves depending
> > on complexity.
> > 
> > I don't think we do anything special, if anything it's probably the
> > mode (orc mode thing) that makes a difference?  
> 
> That's possible. I'm still pursing it but, at least so far, I haven't 
> found a way to get orc mode working with my tooling.

I guess you have a different LLM? For Claude Code its enough to tell it
"do X in a subagent" and it just spawns one.

