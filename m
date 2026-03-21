Return-Path: <netdev+bounces-270141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P1HLhn3vWm+EQMAu9opvQ
	(envelope-from <netdev+bounces-270141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F212E2CDE
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 02:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CCD63054BB9
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 01:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8613264CF;
	Sat, 21 Mar 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvPBY02d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9D23254A5;
	Sat, 21 Mar 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774057217; cv=none; b=qXbgKp7s7c7sAvgmnJmMm0ndLBDvhriprN+c0CZuMrlKgpvDeV7K6TN8xbneuE6RSxPHNLXMEKcTcZwrbgo2eZEksIxl3DmA5jqq4ihtNMl9nl0iRTy8Firwxer399EIlS+ZlGUeKesmEsb+EelIPga0YhwQSDR/3f/VopXHdXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774057217; c=relaxed/simple;
	bh=19ICB94KK6ZwPEG1T1jHxpQAuxS3CXqfg7UE4/zhEUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=liIucXHRXDITAVtbe3No8PnmTESfJ0QVCUGQtutDy2z/EDBmVsQCABbhC8QJjjH1RRpw8+nCWn7KDOPzm7OYP+EbXfqXBdDBQKiMIWcjBImKdfc0E8c64v3Z3DaDTISyDt7vXE9y8U5hiUgDVeH0bRujC4NiM8QzEKp3gEE3GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvPBY02d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425F0C2BC9E;
	Sat, 21 Mar 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774057217;
	bh=19ICB94KK6ZwPEG1T1jHxpQAuxS3CXqfg7UE4/zhEUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TvPBY02dRJLDS77icJ3yFjsx2dOp/oBCbU2GtxlQsIZHS01/rwvBiYNZ4NuWAeGr9
	 7s+FS+l1d50DZ7kLmaNn0kfFLbAb8rlJA1LnXWMyTcuUZrW9GST+LHZy6r3ARVUJLT
	 iaggOIFB5DdJxu3RaNCDjR+GBq0DXpoX/vnaKXCsPVO1CUtiCZwV+D6zFdqM8WsnX6
	 T/HcjJizpDnIaSENi9mOhSQLQNl3fGfDGxrQWo+5dOoFwsboQuyQOV7ClPrhZWvIoD
	 THbAM8kfaxi7IrTceJ8Oqur1v6KR2IldIM+srlvRywu1PVDE5TghlJS27f0pmXrtK5
	 P4/QVS3wexokA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCF33808200;
	Sat, 21 Mar 2026 01:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: defer tunnel netdev_put to RCU release
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177405720704.2718727.8145110435611039373.git-patchwork-notify@kernel.org>
Date: Sat, 21 Mar 2026 01:40:07 +0000
References: <20260319074241.3405262-1-n05ec@lzu.edu.cn>
In-Reply-To: <20260319074241.3405262-1-n05ec@lzu.edu.cn>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, pshelar@nicira.com, tgraf@suug.ch, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kernel@vger.kernel.org, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, tanyuan98@outlook.com, bird@lzu.edu.cn
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,nicira.com,suug.ch,vger.kernel.org,openvswitch.org,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-270141-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
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
X-Rspamd-Queue-Id: 33F212E2CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 07:42:41 +0000 you wrote:
> ovs_netdev_tunnel_destroy() may run after NETDEV_UNREGISTER already
> detached the device. Dropping the netdev reference in destroy can race
> with concurrent readers that still observe vport->dev.
> 
> Do not release vport->dev in ovs_netdev_tunnel_destroy(). Instead, let
> vport_netdev_free() drop the reference from the RCU callback, matching
> the non-tunnel destroy path and avoiding additional synchronization
> under RTNL.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: defer tunnel netdev_put to RCU release
    https://git.kernel.org/netdev/net/c/6931d21f87bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



