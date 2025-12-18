Return-Path: <netdev+bounces-245373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56000CCC6D1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6046630399B1
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 15:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE0334B40C;
	Thu, 18 Dec 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOVUhfKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7417A34B186;
	Thu, 18 Dec 2025 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766070802; cv=none; b=QRR9G6i78QaHSUizOY3ZQ7JXDDAXCuls0gHeNw0QnOUrQuqD4AqeRsaSKJi01+LClXos/fL//PH/w389UxrybOkTEAlDSwknjENRe+mmHF3U99Sv/3izZBCkE9ivPE/XCsFUPJV63KkOij8tb4ppc5Gtxs5aHZyrhYUk1RYnILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766070802; c=relaxed/simple;
	bh=Xm7sRCSfgKCTIopXk+SzWP28RvLTf73nbF4cNetOmrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J1QJJPxACkTEm2IYtfmHHXr8EweBQko7/3FHwARr1sThmZG3T/NlQ14tdpjawmZXMDqVZJ39mqVb2W29T3Y+/Ol/sY6tPHj9q1kBJ8YkOnpjZwRMfIplq5qkt/u1IhcNNhASG3jTyENl14QudgOAaxoTYRnmiCOMWnw8lldhSnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOVUhfKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53158C4CEFB;
	Thu, 18 Dec 2025 15:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766070802;
	bh=Xm7sRCSfgKCTIopXk+SzWP28RvLTf73nbF4cNetOmrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VOVUhfKXBmfSEFmUSOkQU3uVT46RS5KzpOYfju1uY6C46n8Zp/IUDQmgZEV1xtvIT
	 J+bUvaxXRqCn4wFRd95BYjhnV1bbPuffIlKeerT63OXkegUeiKcRHwwNc/NfUq7SkO
	 IvlT8p/+IhPvxEnn6qlgJ/cggyZVh09+0O/lVAjBcHGVvFKMt/6YHRfBBfe1I/tQUV
	 BLELlwFFWs6baDKh7ynggUaDKpYZWkI7xb6jD51EKmiRYDjYTxozVzPyOIRdgkmaJa
	 du8aDyjXjjzxXLCX/1flVWDXjBN5Rvl+FE3uYrM/pOlT+66vsGm59Wxblav9rgyf7G
	 tXcZCZETJ5vpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2AB1380A963;
	Thu, 18 Dec 2025 15:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/handshake: duplicate handshake cancellations leak
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176607061177.3000958.13778061126255337955.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 15:10:11 +0000
References: <20251209193015.3032058-1-smayhew@redhat.com>
In-Reply-To: <20251209193015.3032058-1-smayhew@redhat.com>
To: Scott Mayhew <smayhew@redhat.com>
Cc: chuck.lever@oracle.com, kernel-tls-handshake@lists.linux.dev,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Dec 2025 14:30:15 -0500 you wrote:
> When a handshake request is cancelled it is removed from the
> handshake_net->hn_requests list, but it is still present in the
> handshake_rhashtbl until it is destroyed.
> 
> If a second cancellation request arrives for the same handshake request,
> then remove_pending() will return false... and assuming
> HANDSHAKE_F_REQ_COMPLETED isn't set in req->hr_flags, we'll continue
> processing through the out_true label, where we put another reference on
> the sock and a refcount underflow occurs.
> 
> [...]

Here is the summary with links:
  - net/handshake: duplicate handshake cancellations leak socket
    https://git.kernel.org/netdev/net/c/15564bd67e29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



