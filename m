Return-Path: <netdev+bounces-263108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOhgKmuxpmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:01:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2345B1EC3B0
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 11:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDC1030774DA
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 10:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DA038F655;
	Tue,  3 Mar 2026 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnGaK1LL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE81A3909AA;
	Tue,  3 Mar 2026 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532010; cv=none; b=GVZkvv84lSUbHUlBn5y8O1B1hG20xArkJHo81WNRkorpc+SnSRF2JD8hltEANWd8gitYE5RX46SfyyZ2y6Ukv4OMNs426BqOyf/rtauogYniAy+UcQ/lmXOdi5g98h2vpd8S6R6p4zrdla1cJJp14fZmAoI34G8hkFS16EGCPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532010; c=relaxed/simple;
	bh=2XJmhHdjfoxa8F7+fhCdXOQGrgSRsK9e7VLWwQnm3c4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SysZ1r54breypFdXc3sNxl7miWIPdsNILvZldyGUzpdbcJWjVhjF8/l9tf1gPdjpVTkvFc4r8S23X2OdOxaKsTapPAkVVd1HYaPb9fNmKQrVddZn+IqUirTpHYEt9tONvFIOusBq0IR3oD84XLgBw7UGbHfM4XX8JKxX+JzUd7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnGaK1LL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A76C19425;
	Tue,  3 Mar 2026 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772532010;
	bh=2XJmhHdjfoxa8F7+fhCdXOQGrgSRsK9e7VLWwQnm3c4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bnGaK1LL7eOE7q7B7wgiek/S9+W5NRvZ9MqmFXWRNFRGolXx5bmQczYH9b/iyV4LA
	 LkViQ2Qa214PHGpeEGaGhRh0fya7PGaHRNUGF15Y+LYJRN5LtZ+A0QbrQE5NucWo7J
	 +3QaJlV7kMzo0iM+CKPCF6kWLA9Wuv3abaNqIsmpr9bcWO0IxZK4QWazUAeQfI05g7
	 xRYTxNbh9K0SEQ01vDfx8fH9i/JxD260l4LbcMrx3m/mbGIQaJ7CYL0C5AbRCVOgMy
	 mfz7ENktqZEKQJXS5ZfJsF9GdZZT3wtY3cmHZhAfuFmdRoUIyTPgFHY45k7lRX1SIU
	 SzQlcmrQtuCww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D72380A961;
	Tue,  3 Mar 2026 10:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 0/2] bonding: fix missing XDP compat check on
 xmit_hash_policy change
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177253201154.775036.12280212702681060217.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 10:00:11 +0000
References: <20260226080306.98766-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260226080306.98766-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, andrii@kernel.org, eddyz87@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 jon.toppins+linux@gmail.com, joamaki@gmail.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 2345B1EC3B0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263108-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,shopee.com,jvosburgh.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,linux.dev];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,linux];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 26 Feb 2026 16:03:00 +0800 you wrote:
> syzkaller reported a bug https://syzkaller.appspot.com/bug?extid=5a287bcdc08104bc3132
> 
> When a bond device is in 802.3ad or balance-xor mode, XDP is supported
> only when xmit_hash_policy != vlan+srcmac.  This constraint is enforced
> in bond_option_mode_set() via bond_xdp_check(), which prevents switching
> to an XDP-incompatible mode while a program is loaded.  However, the
> symmetric path -- changing xmit_hash_policy while XDP is loaded -- had
> no such guard in bond_option_xmit_hash_policy_set().
> 
> [...]

Here is the summary with links:
  - [net,v1,1/2] bpf/bonding: reject vlan+srcmac xmit_hash_policy change when XDP is loaded
    https://git.kernel.org/netdev/net/c/479d589b40b8
  - [net,v1,2/2] selftests/bpf: add test for xdp_bonding xmit_hash_policy compat
    https://git.kernel.org/netdev/net/c/181cafbd8a01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



