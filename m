Return-Path: <netdev+bounces-216057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5702FB31C2C
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1DD7BBF46
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 14:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B243309DAA;
	Fri, 22 Aug 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT6Bm49j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7CF305E33;
	Fri, 22 Aug 2025 14:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873598; cv=none; b=XTXC0n3v3+Fo/Oxkq0z5IHyOq/h0fKiYBJzga9Ecvh2GCaOq73ACI6VxU41Y7fdHnBpftpdyi1lVjfVdpE+Fmkw/FAPWyYA2dVtBG9zzFa/b5TnSMihzCtIk3eBx9AWqduRR5q0xE05BWTRhkbLFRunjZJLkVRhrYBKdyIomekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873598; c=relaxed/simple;
	bh=excmmn0rLz8jDLo6G5LPnwtgNJIKp38iA06yY5tt/ow=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cW5jUiddVciVfg3NnKdlYIVdSpb++xWZTr8N9XdTkJx2nIrxasEMl1Z7qPJ8YZ7kQLpHcQsnSPl/Xe6xwOYuygP+/rxRSi4u5O9/ZGN/y6z/rP4Ig2PBka/dN142IunOE3Syf3eoJW0kGqwD7FkFXnpK4Nzd+4wRLoh6obJlbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT6Bm49j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A4C4CEED;
	Fri, 22 Aug 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873597;
	bh=excmmn0rLz8jDLo6G5LPnwtgNJIKp38iA06yY5tt/ow=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GT6Bm49jh0UkAPm9GbxeW2EqxFGUhAg4Eb18z5SyqD8G4kcEnk5ErjAg2iOLKSVoT
	 5gwAZy8rdjXcBozw49l0RaCY8hEhip2ArQ6Sox5bPt/n5yCtHol8dwI3qwd3dFS4R4
	 Y6din6QooeQRvbrgm2fUqNeimb2BmL7mgTMgOWQXcRWyKyRwlehOsX8UbEBTsqnEWF
	 c3agk86kO0oiBIaHvcq+iyTjxIt3pKYYsC/KS3nFgtTpVwUXsHAW+V5Qtuw68LOn0K
	 pDFnP5NBpIQo+zrhM7qP+uVBYhKV9AgDDY3bEKrB/Lisa9xD8d+yu5Z7hx+gAxFhfU
	 I7uytKwf0rcgA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB4383BF6A;
	Fri, 22 Aug 2025 14:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_sync: fix set_local_name race condition
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175587360675.1857936.2078613470430464551.git-patchwork-notify@kernel.org>
Date: Fri, 22 Aug 2025 14:40:06 +0000
References: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
In-Reply-To: <20250822092055.286475-1-pashpakovskii@salutedevices.com>
To: Pavel Shpakovskiy <pashpakovskii@salutedevices.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, brian.gix@intel.com, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 Aug 2025 12:20:55 +0300 you wrote:
> Function set_name_sync() uses hdev->dev_name field to send
> HCI_OP_WRITE_LOCAL_NAME command, but copying from data to hdev->dev_name
> is called after mgmt cmd was queued, so it is possible that function
> set_name_sync() will read old name value.
> 
> This change adds name as a parameter for function hci_update_name_sync()
> to avoid race condition.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_sync: fix set_local_name race condition
    https://git.kernel.org/bluetooth/bluetooth-next/c/c49a788e88e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



