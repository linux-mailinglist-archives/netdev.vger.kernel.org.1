Return-Path: <netdev+bounces-284416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOFQEC/x+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40594CE896
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D80A93047BDC
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC7247D93A;
	Tue,  5 May 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IVZZ23lJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A101F47CC70;
	Tue,  5 May 2026 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987859; cv=none; b=MDoJE68PNGEQMHUuVWAKSrxbAtrF+gcWLbbsvwn4+GQ2eD5f9QEBb7qudtOKRzQiliPqsd+qiYSZs9OmPkfwv25lxUGADU+DMCdtwCiRsrHb20R22+zajp9OyxolqmBGOcxf5zqw0JUuaRqqyfXnHmnILhxRmz+e2K8dOoz5qlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987859; c=relaxed/simple;
	bh=RAydYRsEHZiy1yx0tUy/q+12EcV+wsVQKZxmIUbla3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ksv8t2Uhewj5EnUQSiIM3XGe6S2nm6DH0TxZjC4ASyfUi44mgcWVTvJKa2X6Hh7LczlSaR7BupPyuTPG2RGvgHdft8wJ+VU6GweQNNiTMGq5NLcv4Cd74hVgMJGFQKpzsIXYRV/TO7rC66m+E6Y6LJAt7JVDdVjacHAAaCijTKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IVZZ23lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8FEC2BCB4;
	Tue,  5 May 2026 13:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987859;
	bh=RAydYRsEHZiy1yx0tUy/q+12EcV+wsVQKZxmIUbla3Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IVZZ23lJSqzmXvQMwbcgKSs5Z0Ja5mmNB/jxbNFgYv8oTG3BBNGbPZoUVQMhBXvUj
	 dAJCFrKKUCnMv93dXpGN8eSezXtSp1QxWXQUd9i0CQbv0vLKZBuUGXsi0jZapmwDnG
	 Zd9hPu8aSOPoF62qOv9f7AEisnAPxqs7PPas56YzKLSoi8RFp3CBm9BXvqqxqBWCjm
	 H5dZKkbH6M8DNayWTW/VFpKE8M2YQ8QL4aCPi/vuqc+gUa8tv+T7RJCRt0cG+0+hy6
	 67eF82ASyhIkPeSfVXfHD4xZu3VaWftqcEVsp9czmGwkmEgfxE1F6966xHko7MbjQW
	 FKKqYTGRFDmFw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02BEB3930234;
	Tue,  5 May 2026 13:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] openvswitch: fix self-deadlock on release of
 tunnel vports
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177798780980.2056981.7235049038599637901.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 13:30:09 +0000
References: <20260430233848.440994-1-i.maximets@ovn.org>
In-Reply-To: <20260430233848.440994-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, tanyuan98@outlook.com, n05ec@lzu.edu.cn,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: B40594CE896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	TAGGED_FROM(0.00)[bounces-284416-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  1 May 2026 01:38:36 +0200 you wrote:
> Two patches - the fix for the actual bug and the selftest that reproduces it.
> 
> I missed the self-deadlock in the original patch that introduced the issue,
> because testing required code modification in the ovs-vswitchd to force it to
> use legacy tunnel ports.  I thought I made the change correctly, but apparently
> something went wrong and the tests were run with the standard LWT infra instead.
> The selftest added in this patch set will at least prevent this kind of mistakes
> in the future.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] openvswitch: vport: fix self-deadlock on release of tunnel ports
    https://git.kernel.org/netdev/net/c/aa69918bd418
  - [net,v2,2/2] selftests: openvswitch: add tests for tunnel vport refcounting
    https://git.kernel.org/netdev/net/c/05416ada37aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



