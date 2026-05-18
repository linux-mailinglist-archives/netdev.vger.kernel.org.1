Return-Path: <netdev+bounces-289201-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFzCC2GjC2ooKQUAu9opvQ
	(envelope-from <netdev+bounces-289201-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F5E5750D3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 01:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5412F3018D62
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E6339863;
	Mon, 18 May 2026 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcCuoIMv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219DC288C2F;
	Mon, 18 May 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779147614; cv=none; b=PDoDjsU5BtcWJpA/6IRfHlxsZ2VV+vQi3+akS8zr21OJVy56QB7jg6PkXNyNe6mmEdt03XjFtClQlDZ35FbGkIQHtn6FfT8w57WscA4TbzuTY9DYGGXYWE03pUrQUADXYaNh+fGwV154vjWR+LwtU8Ujtak5FS+LaPBdYcWPsSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779147614; c=relaxed/simple;
	bh=iTr589DozvIngmSVLR2l3PzYKcxJnBYqFPi6SZByA9A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P9ihF/hcI6APqjgymFOQjlMD6fUSYq7dOoc3HAcgiaj7WEcmaToTPFtvpGRWKgbkxmakkR4zSrvrU9qnlCtG8mOxu5v/yAV11kHjUjYiPUiX5lownLzQcfdmK8wp66Z4Yy2HrINCXSD8DdfR76H5FKz5n7QiLuIrMGSWTn7/+ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcCuoIMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25CAC2BCC7;
	Mon, 18 May 2026 23:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779147613;
	bh=iTr589DozvIngmSVLR2l3PzYKcxJnBYqFPi6SZByA9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LcCuoIMvTsoy0l5ByGAiLAor86+Z+Th3vt3BxyKO9ypoybPMGkv6EjLQqx0FC0soZ
	 mkEs9KTN05D9AL8mFMXda9YRGWfQXELlJB1HvDl54H2MkY5rw4/fv4lkoagD3ivR6h
	 Cm7T8pZi+3VhgeXnUd/tKxBnU8JVc1Qybsb5rKMZTcPINQrEBjtMF2S9BpHV8q3J0f
	 rzSaBXHGssXZkp/4D5Zjpbkm4OcGrc65jvvSp7pwb5acFzqJYGGgWK8HEhu/jiYUfn
	 W09B9EcRL3+U02390cGffqOH0QmzSnUfS9blkYCg4oMLiSFPjFk/6M3EXzU+9ATZ7c
	 m7s9i5Jx5eB2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A133930CBF;
	Mon, 18 May 2026 23:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] openvswitch: vport: fix race between linking and
 the
 device notifier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177914762488.2012201.13277593424692251967.git-patchwork-notify@kernel.org>
Date: Mon, 18 May 2026 23:40:24 +0000
References: <20260514184702.2461435-1-i.maximets@ovn.org>
In-Reply-To: <20260514184702.2461435-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dev@openvswitch.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289201-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C7F5E5750D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 May 2026 20:46:31 +0200 you wrote:
> Sashiko reports that it is technically possible that we got the device
> reference, but by the time we're linking it to the OVS datapath, it
> may be already in the process of being deleted.  In this case if the
> notifier wins the race for RTNL, it will see that the device is not
> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
> will take the RTNL and link the unregistering device to OVS datapath.
> 
> [...]

Here is the summary with links:
  - [net,v2] openvswitch: vport: fix race between linking and the device notifier
    https://git.kernel.org/netdev/net/c/bae3ee802c21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



