Return-Path: <netdev+bounces-219730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24160B42CF9
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D399D189AEBA
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470F32E9EC8;
	Wed,  3 Sep 2025 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHjf7jeF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9019C560;
	Wed,  3 Sep 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756939813; cv=none; b=UE1Prv9qMSBt2yTSKCfulq+/oRA3UU40dmUVNG6w5+lE1gc/D3MxzuP4iX2JGxzusBCqdUHZ6NsL8lWi67KgtuXmH53FCd2Md7O/bFwtoYq873INjz2ccja5yHF3r2yAFXMIHs6UQ8OBDR6MYhrYX66fvX0MO1FdHsyt0Fn8hgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756939813; c=relaxed/simple;
	bh=As5rtX3D5LB2wVeZvRuFo1VLXRYr4qskDKDe3OpTwlI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RIDSsuCQ35wNrSuWiXZ/ueIkzkchc+1mzFmPnKSCb/BoVV0N1uHi+p0mouRZXXby9nwLN3xF0+nNz7+O7GWtjlWeYE1DkViHfqlTjmp2T4ANKmqkeEq+I+Ofr4fYYHWL3x3P5k/hmMUVwyPPUY7EPprOKoMZVpam4owxGgbC63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHjf7jeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2FCC4CEF4;
	Wed,  3 Sep 2025 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756939812;
	bh=As5rtX3D5LB2wVeZvRuFo1VLXRYr4qskDKDe3OpTwlI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHjf7jeFpYmeaUewcAb7SW4H4UtmZMhox1ss7yeUhnb+Mn4ahh6DumpoJKQtNSfcZ
	 PM+PVN0buemow0HOFJy7oO9Y0K8uh/48rXBxKTP+P3zAFH7rJtVxyJAUQ5XIvt0VMS
	 C9qaKLUu4B/zk6QOx+CTKpAkpsHgIjTqQC3takyihWrfTWQh1OvrnaNw4plvLY1o+/
	 2AXhmJRDALA9bFXunpxJ6832LDbJdBzJbbEOFEzsFfuaIwqt+ak7/ghMhtDxgxipX3
	 g7CqRMl1vU/26Gs2xtInqgY4wllW1nsZbAUJIVyV4lcA1Phq3oSFykIhHPp3QG91bU
	 5+/9rjbRD4rBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3F2383C259;
	Wed,  3 Sep 2025 22:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tools: ynl-gen: fix nested array counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693981774.1226328.5930762500179486996.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:50:17 +0000
References: <20250902160001.760953-1-ast@fiberby.net>
In-Reply-To: <20250902160001.760953-1-ast@fiberby.net>
To: =?utf-8?b?QXNiasO4cm4gU2xvdGggVMO4bm5lc2VuIDxhc3RAZmliZXJieS5uZXQ+?=@codeaurora.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, donald.hunter@gmail.com, horms@kernel.org,
 jacob.e.keller@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Sep 2025 15:59:59 +0000 you wrote:
> The blamed commit introduced the concept of split attribute
> counting, and later allocating an array to hold them, however
> TypeArrayNest wasn't updated to use the new counting variable.
> 
> Abbreviated example from tools/net/ynl/generated/nl80211-user.c:
> nl80211_if_combination_attributes_parse(...):
>   unsigned int n_limits = 0;
>   [...]
>   ynl_attr_for_each(attr, nlh, yarg->ys->family->hdr_len)
> 	if (type == NL80211_IFACE_COMB_LIMITS)
> 		ynl_attr_for_each_nested(attr2, attr)
> 			dst->_count.limits++;
>   if (n_limits) {
> 	dst->_count.limits = n_limits;
> 	/* allocate and parse attributes */
>   }
> 
> [...]

Here is the summary with links:
  - [net,v2] tools: ynl-gen: fix nested array counting
    https://git.kernel.org/netdev/net/c/b4ada0618eed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



