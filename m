Return-Path: <netdev+bounces-105614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9639912051
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0E91F2417A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E08716D9DD;
	Fri, 21 Jun 2024 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGpx5J60"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A316C698
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718961630; cv=none; b=icaafjLojd3LuFMmAPQPjSBqLpawPVRTTmphu80IEbBbLwGpU0jjEFfSSZmML8MaR8sVShXP51QWcFVigyH4s1fjM5uj331hYzuF9n8W/3a4JcY2BvB31o9bV63VoIBGC4rVt9CZ0/DBA/PQ9usHImFYeiTcgs9bYWXuatNlh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718961630; c=relaxed/simple;
	bh=acBHPQls1UpUEKsSbyzwXznAywSXDrUPLPCRluJfzFU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LOU/3F55c8OMQGAymV83yJjfGcmq4HntNgi93iWD0exDvu9JvfXf0QAEEGeFYTa3ZYOR6dO/BivCO3M6w4xgpJqPBsPbiw/6PjqFIo6SgI+xBWvEqc/8wbDOBLWVV+T7+v24xin9Qv4l0KxxHWWN2LXh/eufjLcu8ts67a+jufs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uGpx5J60; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88C81C32781;
	Fri, 21 Jun 2024 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718961629;
	bh=acBHPQls1UpUEKsSbyzwXznAywSXDrUPLPCRluJfzFU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uGpx5J60unVVAxEFXwXxwpXPAOKcMLbxmlcVHGWOTzDIEyA8jeVr6VMgTmraHsXkg
	 puBkeNgEMKE44n32yX77Oj3I3hf+LQR6Ztt15l+0SRptgYbYhMokfBL4mDFqnD4YlS
	 PmvO6nT1OVAuXUgu2DPH4sS8c4Ra6rA3QrraS7a4KE/Wm3cpO4HZC7DnMTfaiPCyr/
	 urnqpDJZTDBIRFTJl9rRfOuH0inOxflr7WpyeUq8WmKHgDij5dmoJSq0oi75mRAd+C
	 eyDKfUJ0DTSWoMN6XA4rD/HcRRWj0wqj3mjA6bAKBZnsI7dVxQ3C4aXlrGjSCWpu2u
	 gyfy9TX3u9OYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79974CF3B99;
	Fri, 21 Jun 2024 09:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: get related ct labels from its master if it
 is not confirmed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896162949.20195.7630487856470718587.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 09:20:29 +0000
References: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
In-Reply-To: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, pshelar@ovn.org,
 i.maximets@ovn.org, aconole@redhat.com, fw@strlen.de,
 marcelo.leitner@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 19 Jun 2024 18:08:56 -0400 you wrote:
> Ilya found a failure in running check-kernel tests with at_groups=144
> (144: conntrack - FTP SNAT orig tuple) in OVS repo. After his further
> investigation, the root cause is that the labels sent to userspace
> for related ct are incorrect.
> 
> The labels for unconfirmed related ct should use its master's labels.
> However, the changes made in commit 8c8b73320805 ("openvswitch: set
> IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
> led to getting labels from this related ct.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: get related ct labels from its master if it is not confirmed
    https://git.kernel.org/netdev/net/c/a23ac973f67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



