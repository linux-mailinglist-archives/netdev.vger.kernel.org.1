Return-Path: <netdev+bounces-13902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADCF73DBF4
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE01C20837
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA61747A;
	Mon, 26 Jun 2023 10:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1731D6FB5
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 10:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79E3DC433C9;
	Mon, 26 Jun 2023 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687773620;
	bh=NPDnvfxHG4teJyg6Okjt3tJ2oHctXZtx/vdSbw3fPp4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tUs4w8ZqtfUN75F7f0yjMFmlo2n/nmPxAzXnnxAOly+JmLBnNkv4oP256yfpoAs5p
	 scY1zA2zy7HuEkV7dJDdgiUoqNbCyagCoSswjdYrrElWdk8pdAT3m7fcPUU/OlSiCt
	 rGjIHCyuJX8HljsLhBEpXiU4c8brW/5LNCslp2cgl/VRsTcZB5R5fmRzlYBcg7UB7/
	 4hUce8K55kD05RfMdXMp7g85vQxJPhPcYaO2eyvqip5i3qQH2aIj/FntTw95tUERDU
	 M2Ou77JwHbkB9AIdRaEVv1rXY75VzbUZFXLOYDMoVLM1AdULgtTVydCsusPXuv0WmB
	 bwwbEepQ99Zag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62333C41671;
	Mon, 26 Jun 2023 10:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] net: nfc: Fix use-after-free caused by nfc_llcp_find_local
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168777362039.27218.12767863885195813924.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jun 2023 10:00:20 +0000
References: <20230625091007.199624-1-linma@zju.edu.cn>
In-Reply-To: <20230625091007.199624-1-linma@zju.edu.cn>
To: Lin Ma <linma@zju.edu.cn>
Cc: krzysztof.kozlowski@linaro.org, avem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 simon.horman@corigine.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 25 Jun 2023 17:10:07 +0800 you wrote:
> This commit fixes several use-after-free that caused by function
> nfc_llcp_find_local(). For example, one UAF can happen when below buggy
> time window occurs.
> 
> // nfc_genl_llc_get_params   | // nfc_unregister_device
>                              |
> dev = nfc_get_device(idx);   | device_lock(...)
> if (!dev)                    | dev->shutting_down = true;
>     return -ENODEV;          | device_unlock(...);
>                              |
> device_lock(...);            |   // nfc_llcp_unregister_device
>                              |   nfc_llcp_find_local()
> nfc_llcp_find_local(...);    |
>                              |   local_cleanup()
> if (!local) {                |
>     rc = -ENODEV;            |     // nfc_llcp_local_put
>     goto exit;               |     kref_put(.., local_release)
> }                            |
>                              |       // local_release
>                              |       list_del(&local->list)
>   // nfc_genl_send_params    |       kfree()
>   local->dev->idx !!!UAF!!!  |
>                              |
> 
> [...]

Here is the summary with links:
  - [v5] net: nfc: Fix use-after-free caused by nfc_llcp_find_local
    https://git.kernel.org/netdev/net/c/6709d4b7bc2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



