Return-Path: <netdev+bounces-273767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNF+MrlNzGksSQYAu9opvQ
	(envelope-from <netdev+bounces-273767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:42:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C637275F
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 00:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBF6130015A8
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 22:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A43EC2CB;
	Tue, 31 Mar 2026 22:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s90I5FAB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236172F9C37
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774996916; cv=none; b=p15tw5LcVywOU8Bhjdfph1OV4sl9hqycWFe9NOU9fGGeGk5XKwYpksJ9Ov/74FMYDZ8M4WQLEmOE3FKs2ziXaA3P7IqbEBg4+stgoD4nytAF6sctm3TINVCWAHuIUE0NfPoX/sk3e4QZ2l8qw8HsD9j1gEVy3dLJVQZa5pWXu8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774996916; c=relaxed/simple;
	bh=yJ7hUJmHZ9BD/NAgfc3y9DkZZw6ma2PdZTTlwvhtnuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6D/9axD6S59zUS6CuZSuebw8rP2+ZLVpYet3OglNZR85hNRCIx24UefGDHQP1gctbbiqPc3mFGBijEYsqncaBnpPg4CsPEF3/alHXQdwYuEtyXHEOHk4ZN7AKKNrJRAfhYCz2OZ8XzJ7NmK/aQhuoFFfdosP/jv8L/Vh2eNPhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s90I5FAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A90C19423;
	Tue, 31 Mar 2026 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774996915;
	bh=yJ7hUJmHZ9BD/NAgfc3y9DkZZw6ma2PdZTTlwvhtnuo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s90I5FABWMfL1UHf1sBVOZSYM8qU3ebIL6DKE6OSqozVmfsECKiipM7xg7xCdgGh3
	 W/9As0Vh1GLoB0GVy8nRwu8n6WJY/dju8VoEZduHjP4mPRyzbUhM5tdSpoQwu1LWlW
	 PKU4nWjpSnKsImHPcaRRuFtfnNBsdjIS1hW+nF6//liyLcE00hNWchZf0eDRCZ4vEd
	 sJYFHfYpjc1OfGtRBBEWIu2JuSS6WQMxqvfxwfVqOY/TKSZ0XUi4td+NF68B6vSxXR
	 BnptvktWJcGaDy8jC84dpCA8tXDuObw2/+S+1EuJcgfnwQ54KkdswXVqCxiRrxFMis
	 jJF0xDr+g70lQ==
Date: Tue, 31 Mar 2026 15:41:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, Yiming Qian
 <yimingqian591@gmail.com>
Subject: Re: [PATCH net] ipv4: nexthop: allocate skb dynamically in
 rtm_get_nexthop()
Message-ID: <20260331154154.317437c4@kernel.org>
In-Reply-To: <3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
References: <20260331115943.10404-1-fmancera@suse.de>
	<20260331103538.103e3778@kernel.org>
	<3025cc67-ddbf-43f6-a313-602193979ace@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-273767-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C62C637275F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 31 Mar 2026 19:40:38 +0200 Fernando Fernandez Mancera wrote:
> thanks for sharing. As I replied to Eric this is the main reason why a 
> V2 is needed. There is also another bug I discovered while fixing this.
> When dumping the stats NHA_HW_STATS_ENABLE is being included twice per 
> group. I am fixing that in another patch that will be included on the V2 
> series.

If you remember -- please try to slap a pw-bot: cr on your own reply
when you notice that a follow up is needed, especially if the patch
is breaking selftests. We still lack automation to attribute failures 
and bad changes get stuck in the testing branch :(

