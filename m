Return-Path: <netdev+bounces-272324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD8xLLXixWkeCwUAu9opvQ
	(envelope-from <netdev+bounces-272324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:51:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2955433DF72
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BA63305F192
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89DD217733;
	Fri, 27 Mar 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNW0M4Pj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1D13AD05
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774576219; cv=none; b=oPbx9/JcfQ8/GWp5PULRUXOyzAticvipH1co4Z3zCL0dJRxiaUzsjVdRPodgQP0BxkS6e9sL9fLnmA/w1JQOwTJktSMBvb6xYc/hozpYGh0fmYZIpKVNJnPFL1VYhgh3ELi6jNOizGCyfXYyPSYEmNqlogiTAK8mMqb0rRHp3P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774576219; c=relaxed/simple;
	bh=T1O4b28BbEHhL6yLGeqMJA0Ma2/HKDqyrUeEDG3E1w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bdSo7ocgD5H6EfE55ZwWyT3xz74gKd2rMpSNLF8YCwzfJXPOozOVIC7eh1vVwETOCjt2et99Jwt6NVJ0WgwH2ABZxPaguZFsRitGtV40JggRfEeh3ljG8N0hgf6aB2UQbX1C+TkOlgJshmvVCtMJOWtzP8roHOyY8EBZIoReMBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNW0M4Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CB2C116C6;
	Fri, 27 Mar 2026 01:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774576219;
	bh=T1O4b28BbEHhL6yLGeqMJA0Ma2/HKDqyrUeEDG3E1w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QNW0M4PjYqR4IVd5TktLwE/PzxeOBvxgZoWS069x5mFTp7EWAVkr6PVyoKDKa/nBu
	 mvxbcqlfuxdjDlRNI9yDV7I/6knE4kUs246YJck1gxw8yogmpfSm/oYDgDzS4R80kL
	 I1x8qxKEkuEupbXzb+oTiWleWqQXohtmNWLnYjVZJ3v2yfwP/f+gV1MLgttwI6MC53
	 uc6N2HPPdQQFBG9E9ljtOoJcZ2AfUYJ09bytcgE+aGr54fddpj9d/ILolRa8UaR6VU
	 Kejgen022g39Bka2WGRQAWazSD4eWg+RoX7zezLuUbbT4YVZZ/wO4ijY0ExR68UdCu
	 cWauTUwouiksw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E9B3809A07;
	Fri, 27 Mar 2026 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] mpls: add seqcount to protect the platform_label{,s}
 pair
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457620555.3256339.18296172329190801679.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:50:05 +0000
References: 
 <cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net>
In-Reply-To: 
 <cd8fca15e3eb7e212b094064cd83652e20fd9d31.1774284088.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, ebiederm@xmission.com, kuniyu@google.com,
 gnault@redhat.com, tanyuan98@outlook.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, bird@lzu.edu.cn
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,xmission.com,google.com,redhat.com,outlook.com,gmail.com,lzu.edu.cn];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272324-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2955433DF72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 24 Mar 2026 00:25:57 +0100 you wrote:
> The RCU-protected codepaths (mpls_forward, mpls_dump_routes) can have
> an inconsistent view of platform_labels vs platform_label in case of a
> concurrent resize (resize_platform_label_table, under
> platform_mutex). This can lead to OOB accesses.
> 
> This patch adds a seqcount, so that we get a consistent snapshot.
> 
> [...]

Here is the summary with links:
  - [net] mpls: add seqcount to protect the platform_label{,s} pair
    https://git.kernel.org/netdev/net/c/629ec78ef860

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



