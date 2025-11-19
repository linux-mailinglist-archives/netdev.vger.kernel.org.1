Return-Path: <netdev+bounces-240021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D246C6F58A
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 15:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CED8F4F77B6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D706F2356A4;
	Wed, 19 Nov 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK68FZ10"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBAC278E53;
	Wed, 19 Nov 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562642; cv=none; b=GavT6SPyHgxNYQMArlnIPpuyjvrF+eDXf3O5RgYZ0Ac9FWy3ohlYzu1uU20ASq+IoJi5ibKIRKid1feZtMswm7t+Gky+Mb41mHRCdh3rvf5a84KPYHZfZiAKjiOirVgwO895CeRvbOqYLktGZGfH/r3bZ2ZPymm4f+l6eq5dH6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562642; c=relaxed/simple;
	bh=BwZ69VMzFOzMAhCNfuEn1G4/kYJvBPDd2luYOFErFS0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kdsl/+YJPmUbhla80ZiDX8b9OZAP4j3ucT/91q7Z6J0PdFRUsL+4Cw68o6YvWXwR4j6amVrTtAv+VbADW0DrEO96SLNy1wLGkvxvUQkn46lc3NQ1cLVpq7vgF/EaRB/ORGjhZa6RGRSM4WKaraa6n54/E4NVBux5a4DE4OvmndM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK68FZ10; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E925C19422;
	Wed, 19 Nov 2025 14:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763562642;
	bh=BwZ69VMzFOzMAhCNfuEn1G4/kYJvBPDd2luYOFErFS0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VK68FZ10itKRR5w4jeeL4PkRMlb2C392aYpZVOeRWp6Foduv8XyvKJT2wMpGrYyIF
	 0ffI4mkrbMosK5w04H9zpcKIO/0hJTQY++AtEumgHxAzogPtmeLuFO4Ecns9Zzntca
	 ioWc9t0l0kIzPkUe3ldsvJFAl3IgsAiWVQCNCWNc4BbqgJSf8Kqz+WA2OD0hm8kvWa
	 SKGyRmb3/B4Gwrxy4pq/8Tdz/I1pfO+GLmfQwN5CRdPn7Pc3JjqsoMe+ucGl67Qjl0
	 5LQZfRZWTQt3rNrfeg/9D6LmHpkvrOKPCDDy8FXVTwg9dpoT5priWEmPnY9bRmjT/n
	 VDAqNuqzd0JCQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E2C380AA44;
	Wed, 19 Nov 2025 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: Prevent race in socket write iter
 and
 sock bind
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176356260726.811862.764219010634757763.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 14:30:07 +0000
References: <tencent_279508EB2AECDECC2C79466F582D896E980A@qq.com>
In-Reply-To: <tencent_279508EB2AECDECC2C79466F582D896E980A@qq.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+9aa47cd4633a3cf92a80@syzkaller.appspotmail.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 16 Nov 2025 17:04:43 +0800 you wrote:
> There is a potential race condition between sock bind and socket write
> iter. bind may free the same cmd via mgmt_pending before write iter sends
> the cmd, just as syzbot reported in UAF[1].
> 
> Here we use hci_dev_lock to synchronize the two, thereby avoiding the
> UAF mentioned in [1].
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sock: Prevent race in socket write iter and sock bind
    https://git.kernel.org/bluetooth/bluetooth-next/c/1f738d68430c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



