Return-Path: <netdev+bounces-189404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB097AB2040
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500E51BA2FC1
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B331266EE3;
	Fri,  9 May 2025 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jx2mDIIS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54EB266B66;
	Fri,  9 May 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833395; cv=none; b=n7Bp+dtwSZkNZPZy9lXYfPepth+snAOChGEt6asIhNfM7OaOZFa20UNeL3Zl6qGjfX3Pw+Sk0XuS0rTmlhgqgUdOe+5Sq7VOShTwg2ytgOeSXhy21jKS+6ULBWJ0Y74BUMVW2VV1Zn725Xpjds4Gtcmsmt1qR/zt2aesXU6VVmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833395; c=relaxed/simple;
	bh=s4SCu8hAtzR/dHa5zmpaOaTNRXp7YbgGtlIUiys975w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n940GgFaM14r0b9eSpIt3asMXnKqcMaClgqKjKqLsAuVJXZNrArgmNRGqAQIdHS0KocV5bVceiqhaN5bNR4lYspvhTrUGfB5cyL2g6Z0FgOKrL5cO5JCAfusIfan5Aby/POUO9XqNNlK0P0LHTF19FIFex0wnGc3mryrYlarCCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jx2mDIIS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A17C4CEE4;
	Fri,  9 May 2025 23:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833395;
	bh=s4SCu8hAtzR/dHa5zmpaOaTNRXp7YbgGtlIUiys975w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jx2mDIISOVk+qbkcJNUVXBZ79ndrIQP/v+1/040Y/c/rpNrzOmstkYZmFTILcINr+
	 3oT9jDBPgT5ZPFUAQUi409PqOK4nZx+NNA7aRFRjlkxdL3k6vY4DSUmaLNogy6fy4H
	 V02HaDXJrMEikdb765TLSVqJOU3DzuNmTgmwDQ5W8QWcPSOHRhj9Pz3fEg1Pxqkvd0
	 RdC0wocbkuiiggVWuiHpbsg5FtiKc7XNfSC4CoFkvBdDHTuyvhwwVFZKK9ErpGNM17
	 uW47Ika5mCoU2he89fQ6hiGQp8hwknRy+VR+XcaNV92Cm56QeK8lpjI6DdO3UW+N+o
	 jitz1OzjefokA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC4A381091A;
	Fri,  9 May 2025 23:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: Ensure keys maintain only one ref to
 corresponding dev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683343349.3841790.11374991133112180926.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:30:33 +0000
References: <20250508-mctp-dev-refcount-v1-1-d4f965c67bb5@codeconstruct.com.au>
In-Reply-To: <20250508-mctp-dev-refcount-v1-1-d4f965c67bb5@codeconstruct.com.au>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 May 2025 14:16:00 +0930 you wrote:
> mctp_flow_prepare_output() is called in mctp_route_output(), which
> places outbound packets onto a given interface. The packet may represent
> a message fragment, in which case we provoke an unbalanced reference
> count to the underlying device. This causes trouble if we ever attempt
> to remove the interface:
> 
>     [   48.702195] usb 1-1: USB disconnect, device number 2
>     [   58.883056] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
>     [   69.022548] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
>     [   79.172568] unregister_netdevice: waiting for mctpusb0 to become free. Usage count = 2
>     ...
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: Ensure keys maintain only one ref to corresponding dev
    https://git.kernel.org/netdev/net/c/e4f349bd6e58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



