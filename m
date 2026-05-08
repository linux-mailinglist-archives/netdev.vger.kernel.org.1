Return-Path: <netdev+bounces-285978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPOcE7VM/mllowAAu9opvQ
	(envelope-from <netdev+bounces-285978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:51:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 972814FBA4B
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 22:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 139673020A57
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 20:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2513D565B;
	Fri,  8 May 2026 20:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+PzjAfG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C25E27979A;
	Fri,  8 May 2026 20:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273458; cv=none; b=NIhY4q1/iwn47OnSOWyNsA99HR4Ndvu3aiZwPkcrOj1JmtWTZx0/yvg3n2hvF0HpP+pOBGDadc8zlUlWfidj4Iax4QY575tvjYytfsjyudszcqaYBkCa7vUXxeezk2JGKtKDdBRJ1M3TcM2D1iCIgGb5LfiJPlVe1sunwdH1fJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273458; c=relaxed/simple;
	bh=EdkMVJWYxM7ydC46+t4W/1YQcJrEaMzpphAuTXL9O8w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uIL/JHU9KbNmEHsRc7gvbHlN9AqJqsTz8ffeeo7GVk+xStwwpZR9Y7HA6veQu26bicu92SMRXcm15qdwho6coEcvzQ1Ddgmg/wRezsrBU0QGaC2GexQTKMnGjPMHHDCAA5vz0SMDo65fe0iuCKZcsTdkrkFfvqeYpEuCXAC3yPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+PzjAfG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D9C2BCB0;
	Fri,  8 May 2026 20:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273457;
	bh=EdkMVJWYxM7ydC46+t4W/1YQcJrEaMzpphAuTXL9O8w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J+PzjAfGXSrA9OVdp7AMB22X4Z5vLDGKgoYcZKBB1eRS4X6gyTDYc4VTXLf2NKZU/
	 LXW9c/GwTsyBhJ883bP7ro6vLM4Kz657IxdxCBVnvjD5duDFjbtzK/30QQZmNwlHCl
	 W20vbabg2uoHDhUr1FhkPOE8BdOxoBailzoG+rsakMeXPqm8IYBUweO0AytumqMYOZ
	 q1ivNBWtpYoEvr95XklC/3PaTCCR5KrbEKAJj+7m22aff7YjP8gItr2xhHoU4krYGy
	 dhUcLeIgpdc01fMQx76YgyZl8svX3jK1TAXNxvlKe71rYXmikBkU2zswAYXGlrKywt
	 NUrG/NmLBUjnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0DD38119C3;
	Fri,  8 May 2026 20:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] bpf: Free reuseport cBPF prog after RCU grace
 period.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827340608.844515.12414699446325110304.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 20:50:06 +0000
References: <20260426012647.3233119-1-kuniyu@google.com>
In-Reply-To: <20260426012647.3233119-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kuni1840@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, eulgyukim@snu.ac.kr
X-Rspamd-Queue-Id: 972814FBA4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,vger.kernel.org,snu.ac.kr];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285978-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Action: no action

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun, 26 Apr 2026 01:26:43 +0000 you wrote:
> Eulgyu Kim reported the splat below with a repro. [0]
> 
> The repro sets up a UDP reuseport group with a cBPF prog and
> replaces it with a new one while another thread is sending
> a UDP packet to the group.
> 
> The reuseport prog is freed by sk_reuseport_prog_free().
> bpf_prog_put() is called for "e"BPF prog to destruct through
> multiple stages while cBPF prog is freed immediately by
> bpf_release_orig_filter() and bpf_prog_free().
> 
> [...]

Here is the summary with links:
  - [v2,bpf] bpf: Free reuseport cBPF prog after RCU grace period.
    https://git.kernel.org/bpf/bpf/c/18fc650ccd7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



