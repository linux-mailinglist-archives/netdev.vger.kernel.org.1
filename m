Return-Path: <netdev+bounces-128942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C2A97C856
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 13:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E8CB237C3
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 11:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A0B19D084;
	Thu, 19 Sep 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgdgkW3D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0DF19D07E;
	Thu, 19 Sep 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744232; cv=none; b=cTbmLKAzkA0FEsKId37PMRgspVRSZ79F9jdFgxbP8Q5ipXFJqoD5FH8yX6ot6LWPuwnLX7s2PrzgmSkmo7Q0Zo7BYlY/60ROOZXuhjaF6fJZR+XRzxxzyWkEjWq0Dlzfc3wwZzEczU36WzCxS3TXMeAQTjjRSb7B0zBiiUvxFxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744232; c=relaxed/simple;
	bh=diJXi/NwpmsQ1uXzlBi4XqGqbhUTilf1YPshnyzUOnA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hb7g681Afu8rAJQYYXe8xuPDNcCdNAGkv/OwRfUymUrp+k0jrce7iNL3EX75PYfv4fY7C+FABsEcYAVqvPE5Vn/cXJFH2E+J3rkIy6Zo2iPppsESzTlW87EeafJmOZd8QQagz+k1xdyrqNRtVmHmCX695ymGP1lwulktlolcEmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgdgkW3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD53C4CEC5;
	Thu, 19 Sep 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726744232;
	bh=diJXi/NwpmsQ1uXzlBi4XqGqbhUTilf1YPshnyzUOnA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UgdgkW3DZ2bZQUOTrrPmqFCXWCwRsHFE9/5oU+p2Zn9RCk+YIWBWh3fxoYfHPsvMg
	 gsprUjvJ1PEHqLeeeiKLNeIXjST91yGWaErMR2DtBywupZTMJgaH1WmIL33nBGkesa
	 WydAvOYzBHleWW6X6M9ZuUBbRI03gdJEwKSTQU3hv7CA00Ny++D2CjfYt/H4Z+4Jg1
	 8JIOPUWvvn1CQmOLRmvpd2TvE8x3pZVh9WKyjCWI59yXIK3/MxaM1tecoDp6ZPlDuW
	 qVuQ01r56ONreL+KeAf2i+f4RY68WZMOhgFLdOb9rD9EnhjjvflUAKBN/ySyyd6iYj
	 ni9R3lneZ/ABw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3455A3809A80;
	Thu, 19 Sep 2024 11:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: xilinx: axienet: Schedule NAPI in two steps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172674423375.1512499.4301937661153323774.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 11:10:33 +0000
References: <20240913145711.2284295-1-sean.anderson@linux.dev>
In-Reply-To: <20240913145711.2284295-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: radhey.shyam.pandey@amd.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, michal.simek@amd.com,
 linux-kernel@vger.kernel.org, robert.hancock@calian.com,
 shannon.nelson@amd.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Sep 2024 10:57:11 -0400 you wrote:
> As advised by Documentation/networking/napi.rst, masking IRQs after
> calling napi_schedule can be racy. Avoid this by only masking/scheduling
> if napi_schedule_prep returns true.
> 
> Fixes: 9e2bc267e780 ("net: axienet: Use NAPI for TX completion path")
> Fixes: cc37610caaf8 ("net: axienet: implement NAPI and GRO receive")
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: xilinx: axienet: Schedule NAPI in two steps
    https://git.kernel.org/netdev/net/c/ba0da2dc934e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



