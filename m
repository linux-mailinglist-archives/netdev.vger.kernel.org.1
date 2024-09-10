Return-Path: <netdev+bounces-126943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 272DE9733AC
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D202F1F24698
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B4189BBA;
	Tue, 10 Sep 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gds3KSgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FD144D1A;
	Tue, 10 Sep 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964227; cv=none; b=Lq5eQogeiGblEnoK2TqIYJluTar9gn/3UyfPNWVmmwQ2lEDsxYczV6BrCz8Y/SLSfSwbWpQz/cqWhn+0Cw8mEVxhWSUv0JjbVwTmUuMJ5bZcS+7ANXs3Ofe9ZQ1cVzoXUwv2Mo2pThS3p2PTYwO2d8NrTn7/AZ9sDxFWk4uroL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964227; c=relaxed/simple;
	bh=U9f5Eq2E7XOCNqJwlEqZ76l7b7gecEXRp2RO12J8hPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YFkJz4DbjLLi1is+gabD02OKKWS9Iokb+NLxfcbOgY8vFX0s9rPPJO6+qDvf5+gjffLCUgToSyQCnsc4Ns186zaM2PK3LZ5t6caM56gwu2hjJG8QW/sk9ZWQAwGcrax7tv6ECCpkAPkVrKUnQpminld/k1aorcDaHkdxlIt90/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gds3KSgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764B5C4CEC3;
	Tue, 10 Sep 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725964227;
	bh=U9f5Eq2E7XOCNqJwlEqZ76l7b7gecEXRp2RO12J8hPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Gds3KSgImA9gXfgnESVY/c3t7kl/c7wT1EJg8NolEXJ7SVbgPZ4WmkLOronWKCUHq
	 +7DYbIzJkgAZJmx/D87WzhTKI593q7TXSwHkeEY5JlDlXLJx8RlOLR7PGn7cnqcnXi
	 VYhtgooxu7MqqcLE8UUqhApLK//TDe4EkTb3kRL8BBUL9oYrzOhJQyC+3Ydfpug3dn
	 0ExzcC0MD2D42pmiMi9XT3ETzonH6PIrruNxO+jlWOETAeMr/dWaNRrC6VmuHYtNP4
	 wnc+w2eJUckfUf0gtITa6blZsoC5LUuPw7Sp3mo9jy2qndscG8SNU9dBzrDUuWj3TA
	 8TraJFAvKo41w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCEC3806654;
	Tue, 10 Sep 2024 10:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] octeontx2-af: Modify SMQ flush sequence to drop packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172596422829.208623.12220342892679054459.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 10:30:28 +0000
References: <20240906045838.1620308-1-naveenm@marvell.com>
In-Reply-To: <20240906045838.1620308-1-naveenm@marvell.com>
To: Naveen Mamindlapalli <naveenm@marvell.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 6 Sep 2024 10:28:38 +0530 you wrote:
> The current implementation of SMQ flush sequence waits for the packets
> in the TM pipeline to be transmitted out of the link. This sequence
> doesn't succeed in HW when there is any issue with link such as lack of
> link credits, link down or any other traffic that is fully occupying the
> link bandwidth (QoS). This patch modifies the SMQ flush sequence to
> drop the packets after TL1 level (SQM) instead of polling for the packets
> to be sent out of RPM/CGX link.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: Modify SMQ flush sequence to drop packets
    https://git.kernel.org/netdev/net/c/019aba04f08c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



