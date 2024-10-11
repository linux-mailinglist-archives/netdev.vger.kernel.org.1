Return-Path: <netdev+bounces-134721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A719599AECD
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CAE1C21682
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8CC1E0B60;
	Fri, 11 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roAXh8m1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924EA1D4336;
	Fri, 11 Oct 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728687028; cv=none; b=k0BKUalUpTOIvmz+mC6KtYZI4YvuCUwKmN3aIv3RXh8MKVmn9NlU9uvf7goqnhCHE6vL30zaOccMy/oPHwWl3C1rYe6Hh4H1F7SdRvb0psJM0Wk/qNKubMm22ELHhazAuk9isxG0nO4FatZtSVxot31QgFHO/LEVcljk4OO6hjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728687028; c=relaxed/simple;
	bh=kXPAbdzBQ5lsXpHo5aujwn0RTu4gEfdHPJJ28FdpBs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ADY5POYe2Bpt6foGh7gB53ur4chnNyubdb1H9K1NHTmASt4kEwey3QPyH/uz9u+BtdrjZ3fH23Yk3ak6OaXLQz5qPDYYXNf37mbOgMdjFUcYiNZJpXHMp4oTCHK4Jalt5204xbeM89R1fBQZ9wyK4pr4R9yBpufkPQ1Dh2itIoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roAXh8m1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B40C4CECE;
	Fri, 11 Oct 2024 22:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728687028;
	bh=kXPAbdzBQ5lsXpHo5aujwn0RTu4gEfdHPJJ28FdpBs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=roAXh8m1yaFRe0i87B3c6iMzKvnX3qFRMUIAD0SZcZDk83+NMa6KX6fu4PHLkExp9
	 U3UZgmj57ZACCmVQJCcVfQ4LaCo/vELYaQVbt+Y/1TGD5ot+sZtTrPJ9s7KHmuDlcR
	 82q6TManrZ2mPvo6s/XStyLXSnqCW8zt/8PTpqPOhcZTF7TwXRlktxY2S2oAQ4TTxv
	 2Sf1SZ3KOs9Hq/qiMole7G4hi5yGS92sE5hEqGjaIK0HYsQVbWiYPtxzi/mETTsbQW
	 LS80IoT04pjcnU9T4oHKbPxTX1832OmGE7LYNidHDR+0KqRDqzDjqxlsr6D7kHC0FT
	 xMDqDOETzxhoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13938363CB;
	Fri, 11 Oct 2024 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sparx5: fix source port register when mirroring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868703275.3018281.7758535089888571331.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 22:50:32 +0000
References: <20241009-mirroring-fix-v1-1-9ec962301989@microchip.com>
In-Reply-To: <20241009-mirroring-fix-v1-1-9ec962301989@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Oct 2024 14:49:56 +0200 you wrote:
> When port mirroring is added to a port, the bit position of the source
> port, needs to be written to the register ANA_AC_PROBE_PORT_CFG.  This
> register is replicated for n_ports > 32, and therefore we need to derive
> the correct register from the port number.
> 
> Before this patch, we wrongly calculate the register from portno /
> BITS_PER_BYTE, where the divisor ought to be 32, causing any port >=8 to
> be written to the wrong register. We fix this, by using do_div(), where
> the dividend is the register, the remainder is the bit position and the
> divisor is now 32.
> 
> [...]

Here is the summary with links:
  - [net] net: sparx5: fix source port register when mirroring
    https://git.kernel.org/netdev/net/c/8a6be4bd6fb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



