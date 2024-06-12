Return-Path: <netdev+bounces-102781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07B190493D
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FA7285093
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF3FBF0;
	Wed, 12 Jun 2024 03:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT3d79ty"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF772DDC4;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718161234; cv=none; b=fIIeyK5oXqQN5HGnVRzSWAzgORCFIQqVPvtDv2UGER/nBr7UWQCqX/tgr9/5BMXMB/gaWthb2R2C/SLeFDDFrnHPpuAVpP7ZWZSfxj6cRC1s43pd88HtFCoBYQeGfK8sA5ykuOyIXT5mEnu41PQHd8b2H4gCY5XzkvHnmutpPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718161234; c=relaxed/simple;
	bh=2M+qM0U4qxV/y34cPtE7EHwJ5OefFeMyZddnNuriUP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iwttMzxGt5Jk2wxAkeCmAVJAwP0ewlnpA5mbKuZwc63JBsosa6IJ+WCJ+GNXJ7zUY0zDYrq4FgjR8gXIDvlVZo3JEEnkjwQGhxRtlbnCVwDkPGzhuqZvs4ADxQnwe9sZ/RhmIdrY0Z8I28ukJQni5IoNeUcmj1PDmm0/QeaLlb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT3d79ty; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B85AC4AF4D;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718161233;
	bh=2M+qM0U4qxV/y34cPtE7EHwJ5OefFeMyZddnNuriUP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NT3d79ty/pLboaP/rGNEZigh8GGJY4RYGRik3PQ//2nEp+Mzx2QfqpNuNuRCaAG3O
	 Yra1gD7uxr0M6lHVpuQ98GgXh9C0jM8fHUAkZ2AoTbvH+UBHVZxTFQ6jUcJ/tuB2Ih
	 fW8j0Z7Uje7CKrkAHHR3paE66Ln/T0uF0rOzXWvN9gwT/O1zAPNTFI3BDwWA4fRbLo
	 h+BvZHb4qHDsx39Ao347C3MkSpL0jDvFKumSlgvZ4WSSUoKx2J1686TR1EE+xjHy42
	 070F8T7kPoa3UIAmLrfnXmWPh3MuKmf83YG/7p3E9/7G9RzLblJxULgJLnxCJSGMVM
	 rMffux4HWEkkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A5E8C4332D;
	Wed, 12 Jun 2024 03:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] gve: ignore nonrelevant GSO type bits when processing
 TSO headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171816123349.11889.11987638058865473120.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jun 2024 03:00:33 +0000
References: <20240610225729.2985343-1-joshwash@google.com>
In-Reply-To: <20240610225729.2985343-1-joshwash@google.com>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 stable@kernel.org, pkaligineedi@google.com, hramamurthy@google.com,
 willemb@google.com, edumazet@google.com, avagin@gmail.com,
 jeroendb@google.com, shailend@google.com, pabeni@redhat.com,
 rushilg@google.com, csully@google.com, bcf@google.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 10 Jun 2024 15:57:18 -0700 you wrote:
> From: Joshua Washington <joshwash@google.com>
> 
> TSO currently fails when the skb's gso_type field has more than one bit
> set.
> 
> TSO packets can be passed from userspace using PF_PACKET, TUNTAP and a
> few others, using virtio_net_hdr (e.g., PACKET_VNET_HDR). This includes
> virtualization, such as QEMU, a real use-case.
> 
> [...]

Here is the summary with links:
  - [net,v3] gve: ignore nonrelevant GSO type bits when processing TSO headers
    https://git.kernel.org/netdev/net/c/1b9f75634441

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



