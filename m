Return-Path: <netdev+bounces-292038-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKQIMXxJFmqUkQcAu9opvQ
	(envelope-from <netdev+bounces-292038-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B165DE3EC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB9073014252
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E33305698;
	Wed, 27 May 2026 01:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrCNXCmh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6637131715D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845415; cv=none; b=GTMpchk/HZE1RBEZ3rdjkQdGAmK8VplymSHaVvurjYPGfjSnAlkZG4wV3pcjhmOnDpY5/c2+EWaoqZzXjBupQvoXz793q9gffqL49V5vg6MX+I5QmGCezskiZU8vCOFMNerCSdoS7kNGBF4zsfF5uc3lfTCkU2FB3H0lxlKYf8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845415; c=relaxed/simple;
	bh=7vT19sIl3Q9+t3tbRGH26qmkXHgt72j+N6Lv2fIYPdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i33Ogf0soYVUNpMQPn0SXhZ0oNgJmaG00/avS6oOf9VziqJZE54vg4XXSMaATfXoOgeWZzA2BMrrBb4Bj5KuJWckG2qHoTg14sUOUtKo1FF/so9rxnrxr+GdBGgUo/1WxKKWFpjC92sh1Q+s54Ger90VuJ9sBMm1+gKIMqQWGxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrCNXCmh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D821F00A3C;
	Wed, 27 May 2026 01:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845413;
	bh=0ydQFosR+nLRxDjYae3CHk11toZXFY6axBJHsyfLZqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PrCNXCmhXXZIwUoOO2qOEbuyZxPMS96lwGYMiZdXEM01TaPuoH6aJAx9sKlg+Q+lR
	 HSg2ZSXZnh7O1GXCrD/7dRPqk1I19QIEce+u/V07ZzxPmDhrBrqc8LRzN3d9gJLkAZ
	 c0fvJ5Fm1A1wPMKjRfleweKOw3qMVXBvQ/SdQv0fOgHK/do9BI+ImwgelbVNOyD8xE
	 tRvcR69ssR9Qj0wNIJq94f/SIoI9IpgLgodWgHN8flL7QxuvYGDb0sPVB8+eVg7nL5
	 x+aRc/Ga8LCzggqawLoSHynOqsk0HKJ7sWzul/QmCc75DT1f5SO2knjes4UhHVpG5c
	 tCARGsga3VPIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A37380CEED;
	Wed, 27 May 2026 01:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: do not reuse cached ip_hdr() value after
 skb_tunnel_check_pmtu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541939.4041297.1723728768792340106.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:19 +0000
References: <20260525203642.2389723-1-edumazet@google.com>
In-Reply-To: <20260525203642.2389723-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, sbrivio@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292038-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C6B165DE3EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 20:36:42 +0000 you wrote:
> skb_tunnel_check_pmtu() can change skb->head.
> 
> Reusing old_iph afer skb_tunnel_check_pmtu() can cause an UAF.
> 
> Use instead ip_hdr(skb) as done in drivers/net/bareudp.c
> and drivers/net/geneve.c.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: do not reuse cached ip_hdr() value after skb_tunnel_check_pmtu()
    https://git.kernel.org/netdev/net/c/7d9ef0cb2715

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



