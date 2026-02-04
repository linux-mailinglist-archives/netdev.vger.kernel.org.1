Return-Path: <netdev+bounces-256540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGjANea9gmk4ZgMAu9opvQ
	(envelope-from <netdev+bounces-256540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:32:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74034E147C
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 04:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70B9F30292DD
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 03:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3728853A;
	Wed,  4 Feb 2026 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKbYsGPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2E9280317;
	Wed,  4 Feb 2026 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770175972; cv=none; b=WgoCZwjKFEP+VOHPLjo+gzmlw6CBSnD74xx41GqvOMEp44dKIjXugbZwQqBUY53w1gU2Hs+L+TzAvhBxmC1b/g9sJqO3+9uKAhgm3oFhJhPje7DmHqBgEai8dCpJuxEJrgUYVlYXwTiTL9L6Pp8oNP/wf1zrTaasf+71x9gvH8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770175972; c=relaxed/simple;
	bh=M1JPvMMT8q4Z5/bTCfDtPkwP9RPhBYH4L5O09MEYovU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRddVKD7f0671XHLU00zopL59aZrQXl94hC/Li9WrQax1VWEXkcFSxIfZQYp7WJ8HWqyEkhNXlkS7lOEBQJvkTVRyaITGVXH5g+1Xnw2MlJoMapGewG+YlGhWoRtXWck2oCy/GGFDq84NIlh6Dod5/twnt+OWDKNSggwEVslZnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKbYsGPB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B563C4CEF7;
	Wed,  4 Feb 2026 03:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770175971;
	bh=M1JPvMMT8q4Z5/bTCfDtPkwP9RPhBYH4L5O09MEYovU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bKbYsGPBwegC2zp7jEs5nTobbs72TPpGto1qLFUBzScj9fnqUkSe0XFDNLO3DxLvX
	 wk3XiwTwQAzi5s1GGXw2hgfbixH9IH2Ev2pG/L2k59bd+JN5z30JHLsFn0eiM1QS79
	 k4Ntob3UlzVwendF+p40YSfHxiolilG10fpSPNzPLddM+7u80xxsFSY0/2j0HRAXTG
	 ApKvle0NdMnyCHK7SwyWR+ZpiCgTD8T+3ENiNaa/4kR9seKDRCyXT2IwUykQYPmM09
	 KDHnCRe440uK4nqvYipFemfhCboxngwAMFk4HUli64QHzedaoOvOdsxD/uRl+BIbd9
	 tJ1Ts8Kg3Cf0Q==
Date: Tue, 3 Feb 2026 19:32:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Chris Snook <chris.snook@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Russell
 King <linux@armlinux.org.uk> (maintainer:SFF/SFP/SFP+ MODULE
 SUPPORT:Keyword:phylink\.h|struct\s+phylink|\.phylink|>,
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net 3/3] net: ag71xx: call phylink_destroy on failure
Message-ID: <20260203193250.6059a63c@kernel.org>
In-Reply-To: <20260202214634.72738-3-rosenp@gmail.com>
References: <20260202214634.72738-1-rosenp@gmail.com>
	<20260202214634.72738-3-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-256540-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74034E147C
X-Rspamd-Action: no action

On Mon,  2 Feb 2026 13:46:34 -0800 Rosen Penev wrote:
> phylink_create has no devm equivalent and must therefore be handled
> manually in probe and remove.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Missing a fixes tag. Also missing (in patch 1) the ability to compile.

I defer to the phy folks on the question of using
devm_add_action_or_reset
-- 
pw-bot: cr

