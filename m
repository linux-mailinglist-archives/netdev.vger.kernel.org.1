Return-Path: <netdev+bounces-275821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP6HMSJj1GlAtgcAu9opvQ
	(envelope-from <netdev+bounces-275821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:51:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465EA3A8D0C
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0D0E303C53A
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45232253B73;
	Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5Ju5qll"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CF250BF2;
	Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526643; cv=none; b=MwKH3URGe4lFbIN3lcbFoWS0aLyVEgzdWgq92ht6tI5KuE65Q0lagFjRbnDo4qscnWp+FkNiiXjolP/xNY7VodKTB355TjsczfvkApGi9YE8TCVsRpIuFtJqUAqoFvq+JhqRxWEGOQtMkSOKM6VaeqygABYnjM2N3oh5cX26zUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526643; c=relaxed/simple;
	bh=4cABJcrKrP1rtJVcjJUJFB6jIA/+r8G0msOGJbi9zOs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RO9p8NrD7+hsZgZR7ijI2BqIcVoF8rNGLCwE2bgGXmRsZx+pAejtXYxsfbkweoZLvczqKNlb3/hF+zJNb4sxsz91Rg8lZKE51+3Shs4GU9S3Gjtoz7SiWMR1Er2UwpXISZFeiK5vGFzj6zfVXRm6CaoUxJjtAX/+36jKepIzdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5Ju5qll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042A9C4CEF7;
	Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526643;
	bh=4cABJcrKrP1rtJVcjJUJFB6jIA/+r8G0msOGJbi9zOs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5Ju5qlllMRbw8nuE8mI9X63nPaS6wyePSDnLfEpukjgRuUdy+WyTse7N6Z/Vaeb5
	 PCb5m20eycpR9sfj3wPqUnnu96YWAEP/+VMQLM7+acH7SqYbb+9tSEsZHoHHPOfzaz
	 m8YDc8tZjdnZgbnwwYO8Fb3ExePX2KggsDkwFn5s54Be+gUpNN1tUGz/CGHV4Q95cX
	 jdeocQC9aEgF7rB7ES9gJZ5TABYaX6pGwiYgGARsgCO6WZ+SrEM9PjWEFd0J4dgtfy
	 gdx6LDQfu4MShpMGmJBlg3u/E0ADTz41JTWxCyDfOrDP+yBCiBB14TRnpRXH/26wdU
	 AF3xPSyHbe69A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDCC3809A28;
	Tue,  7 Apr 2026 01:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vsock/test: fix send_buf()/recv_buf() EINTR handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552662129.3337768.3699528809798023594.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:21 +0000
References: <20260403093251.30662-1-sgarzare@redhat.com>
In-Reply-To: <20260403093251.30662-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, avkrasnov@salutedevices.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275821-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 465EA3A8D0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 11:32:51 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> When send() or recv() returns -1 with errno == EINTR, the code skips
> the break but still adds the return value to nwritten/nread, making it
> decrease by 1. This leads to wrong buffer offsets and wrong bytes count.
> 
> Fix it by explicitly continuing the loop on EINTR, so the return value
> is only added when it is positive.
> 
> [...]

Here is the summary with links:
  - [net] vsock/test: fix send_buf()/recv_buf() EINTR handling
    https://git.kernel.org/netdev/net/c/24ad7ff66889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



