Return-Path: <netdev+bounces-256056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOXnMBJLgWkPFgMAu9opvQ
	(envelope-from <netdev+bounces-256056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDDDD33F6
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 02:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57FA0302D598
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0291E25F9;
	Tue,  3 Feb 2026 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noAZDf+y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF61DDA24;
	Tue,  3 Feb 2026 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770081009; cv=none; b=lrzmLZtZTCZhlUQJ2mn3uZcXjUMm2KHQZCS5v4kAGaO/YFES7ugoq0myv1qlR+SyAJRzysrtZLVUoUqzyoN67KlVetiaoOojxr9Jk8hHGy8RRdMD83LcsgaUuvvgkCdp9jwlnCHMBPHoCq8B9xGV42zJO3OPbGvIJJku6+Sloz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770081009; c=relaxed/simple;
	bh=t5UEjdnk8962JZc/zFm7GA2DjFWkePTDWGZc48zQvf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SbV+0YGUNS1AaG8ecEEwoB+RYzcyssCJybYuUKVGUCI8y1NFhw5wMWHN8kHn9iuoTY/btZlWs6YX8CUVKVbEUrqYJCPTW3wcb1OgfdT2i0c1LGcKwhZSNxDIxkrkP8Jsv6g8oJvsX6kl8tSkziZuEx09F4ZimZteW1qzKg7KXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noAZDf+y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2CCC19421;
	Tue,  3 Feb 2026 01:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770081008;
	bh=t5UEjdnk8962JZc/zFm7GA2DjFWkePTDWGZc48zQvf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=noAZDf+yMbOpRmvdZztCBWeGfNbhedMjGFVWaOWtlXr7RfahcePhtxXxzWL69GfjI
	 KjqQy6kUBm3iklW14wlo8LCzZcmzXXuBxhLs9ICsYbanGfAXfX/ZdwNAQ7akHEaetD
	 e/1B657TNE+PWE0mytKuuYCM0qYDmkfgdm4LhSpHs9vBbVdjL/NODCHi1t0vq0It/b
	 zAZEPOtOtVr9gzqp4xkEvPnMB94liYv0X1sVP3+8Y01ku40fqdvGZgAF+Hyph0S10Z
	 9bp3LOOZIJqxynLSRoWdq/T9matPhpHYa8J0wgz+yDhqL+doywMCAzciddni0WCGN5
	 W1w92kCsJWl5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 910D13808200;
	Tue,  3 Feb 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] linkwatch: use __dev_put() in callers to prevent
 UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177008100538.1258089.15333188222179575362.git-patchwork-notify@kernel.org>
Date: Tue, 03 Feb 2026 01:10:05 +0000
References: <20260201135915.393451-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260201135915.393451-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+1ec2f6a450f0b54af8c8@syzkaller.appspotmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sdf@fomichev.me, marco.crivellari@suse.com, linux-kernel@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-256056-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
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
	TAGGED_RCPT(0.00)[netdev,1ec2f6a450f0b54af8c8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FDDDD33F6
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Feb 2026 21:59:10 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> After linkwatch_do_dev() calls __dev_put() to release the linkwatch
> reference, the device refcount may drop to 1. At this point,
> netdev_run_todo() can proceed (since linkwatch_sync_dev() sees an
> empty list and returns without blocking), wait for the refcount to
> become 1 via netdev_wait_allrefs_any(), and then free the device
> via kobject_put().
> 
> [...]

Here is the summary with links:
  - [net,v3] linkwatch: use __dev_put() in callers to prevent UAF
    https://git.kernel.org/netdev/net/c/83b67cc9be92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



