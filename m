Return-Path: <netdev+bounces-126757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1EB97263E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 02:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1022CB22DEF
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1E3383A1;
	Tue, 10 Sep 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy3NgntA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA04C36134;
	Tue, 10 Sep 2024 00:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725928827; cv=none; b=DVKEWDnsm8zS5aWyRBmQz29dtbIhnTP9blVJai+7DAuieq9faJt9LQ8B11ZXB552azEptOD6vO0N1as2UUmbo4hZCyuqdqXe4knrjRBq96K4mnMIkC06IiGLlf8988zn8zYhPuanaKmt3NucO194/IFm7DurpIpuwDmEPk3vSwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725928827; c=relaxed/simple;
	bh=cWlpEWfw/A0iuBMaJp3jtpvIseMQ8n1c7QwkVVtppjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pG2X3tGGeVzI9CjB4Ie+4PaL9O5B+bGQJn/qKhzZdZogMqB+FjRijRKW/DE0vD+D7Uueo+MT/yafCOkhtmCtGmGgilpArIfJqd6M7l1IVzTL+RC+Jpqn5oqUzVHMpvZnPK10RsnsFrtPkGEMdSB9DT8BSwpXQs8wiMjNOiEVD9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy3NgntA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3ACDC4CEC5;
	Tue, 10 Sep 2024 00:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725928827;
	bh=cWlpEWfw/A0iuBMaJp3jtpvIseMQ8n1c7QwkVVtppjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gy3NgntAKEJiPEgyXGdozU+OoO3luonUzb7of1osiPd1HmC4M+wd/nKl8cuP7ydey
	 Ti5NaLOhloqoPK+bwCtJf0RzXt6KYa01hBAntcZRye+wEJC9um0ncpSNHKrZ5q06hg
	 9kDMTwDXVaZ64Z85/BY0KLylW5ox7JOGRqbeGe0jB4UWt0bjGba5EQWYXR1Nl7qGqK
	 uak+aM0+5CuF01QYVQ5PyPr/gfFbnO0HXtOgVxvQVDXU0jGNTrOrmvMfLygEbUDQUY
	 qKGaL1qKzb1gA0txS+yrLI/PW+TbcBKIrGrcu0PA9P3x4QYOOmJiux8gwV0TTPy47B
	 t5mW988b31/VA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD433806654;
	Tue, 10 Sep 2024 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fou: fix initialization of grc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172592882877.3968469.15818018121459375059.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 00:40:28 +0000
References: <20240906102839.202798-1-usama.anjum@collabora.com>
In-Reply-To: <20240906102839.202798-1-usama.anjum@collabora.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, kernel@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Sep 2024 15:28:39 +0500 you wrote:
> The grc must be initialize first. There can be a condition where if
> fou is NULL, goto out will be executed and grc would be used
> uninitialized.
> 
> Fixes: 7e4196935069 ("fou: Fix null-ptr-deref in GRO.")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> [...]

Here is the summary with links:
  - fou: fix initialization of grc
    https://git.kernel.org/netdev/net/c/4c8002277167

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



