Return-Path: <netdev+bounces-83597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BF48932BA
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EFB21866
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 16:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFB146A71;
	Sun, 31 Mar 2024 16:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkHeGooj"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE388146011
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711902323; cv=pass; b=bJizO8BoDUsrohG+OkEsioZ/avbbjW+tQV+kzRxRKkZt0OXCD6n+rLc8OZ+y8zeNZHILCzqBuSzfQxlCCdm3Hq+BRJ8wwRI4UYtBT0Mk/nxrlgzD7gQtyZlrUPmfOhWQYHzg8iMjGzjLE0IG+DBZwVo86lDdwVwiNQefsxgQpyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711902323; c=relaxed/simple;
	bh=7L28Ihlv5klCNAmpmHkrFLMVHnx1wXWwionH0DX562E=;
	h=Content-Type:MIME-Version:Subject:From:Message-ID:Date:References:
	 In-Reply-To:To:Cc; b=c0FoEKURkW/gPwgoX/WPa6W1pmRUn/AsWmtJ5exLohX9GswLIaswdlkaz2kQ/IdjZsQBgezgDxkTn6ZcS9jZxECZBIDtRYXmjGBUuiyU4oHzXcRllfBiIRL5ohwAVHP3nAPWNCICK73Ui0JFtnFU/PC7m4H7ptglyc+c5Jyh758=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkHeGooj; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 87B35207C6;
	Sun, 31 Mar 2024 18:25:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JUg2rrbfEg_0; Sun, 31 Mar 2024 18:25:19 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B31EB207E4;
	Sun, 31 Mar 2024 18:25:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B31EB207E4
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id A5E5580004A;
	Sun, 31 Mar 2024 18:25:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:25:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:23:34 +0000
X-sender: <netdev+bounces-83474-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com>
 ORCPT=rfc822;peter.schumann@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQBYABcASAAAAJ05ab4WgQhHsqdZ7WUjHylDTj1TY2h1bWFubiBQZXRlcixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAbAACAAAFAAwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwAPAAAAU2NodW1hbm4sIFBldGVyBQA8AAIAAAUAHQAPAAwAAABtYngtZXNzZW4tMDEFAA4AEQAuyVP5XtO9RYbNJlr9VbVbBQALABcAvgAAAEOSGd+Q7QVIkVZ3ffGxE8RDTj1EQjQsQ049RGF0YWJhc2VzLENOPUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpLENOPUFkbWluaXN0cmF0aXZlIEdyb3VwcyxDTj1zZWN1bmV0LENOPU1pY3Jvc29mdCBFeGNoYW5nZSxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0aW9uLERDPXNlY3VuZXQsREM9ZGUFABIADwBgAAAAL289c2VjdW5ldC9vdT1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKS9jbj1SZWNpcGllbnRzL2NuPVBldGVyIFNjaHVtYW5uNWU3BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAUABEAnTlpvhaBCEeyp1ntZSMfKQUAFQAWAAIAAAAPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc
	2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAw5Lp8x1Q3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAGIACgAgAAAAjIoAAAUABAAUIAEAAAAaAAAAcGV0ZXIuc2NodW1hbm5Ac2VjdW5ldC5jb20FAAYAAgABDwAqAAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5SZXN1Ym1pdENvdW50BwABAAAADwAJAAAAQ0lBdWRpdGVkAgABBQACAAcAAQAAAAUAAwAHAAAAAAAFAAUAAgABBQBkAA8AAwAAAEh1YgUAKQACAAE=
X-Source: SMTP:Default MBX-DRESDEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 13158
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=netdev+bounces-83474-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 54A24200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkHeGooj"
X-Original-To: netdev@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711750231; cv=none; b=IrPn0B+QLyAdUaZCopfw/si6ejfpkPIazGHmyyQHQJzSju4WNu0Nz8Xf9BHWa1jrU0rYeYdOMQKlYm5RlqfF/6GsWVrcARzEFep6b7LEFHdzpFp3ADam7+P/tc7zhBBvIWqIjYgPIw6/CBtrVvg9lslrHBt07oIQEy9oSeSHzYY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711750231; c=relaxed/simple;
	bh=7L28Ihlv5klCNAmpmHkrFLMVHnx1wXWwionH0DX562E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JU/O/wSEVIJFg7x/FGT3zP76RgbC6Qw83tqSabVwHg3rGdS6uhViS7u6iHtqhSlLyNOUFqM5r3lirrkwu4heGBCtUl8Zbxy+gw/hOw2i4icxTk8Kkk8i/GDJy2xMvT2FUGr3nZwPYcrswjVdzCPzod/HSWH3HY7mw3kkGFMgL1c=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkHeGooj; arc=none smtp.client-ip=10.30.226.201
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711750230;
	bh=7L28Ihlv5klCNAmpmHkrFLMVHnx1wXWwionH0DX562E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PkHeGoojHg6DOekuh963+cYCXhycfhEbrFDOnqbu4CD+E5eHviEXeHM5QQBcrn3N5
	 VB+UW31YW9D6UfC0AuDsV8uHNirTG7y8azein1uAFcNmd0MFJIvxcSZRR8QwPywnkh
	 Pp2juwx5Mg3sGxA76UHGqjExffnXXZ+cU/Ul3XMnvDc2n2fMTyVzJWm1JJN04zfV0q
	 QStv/CBbWvSmm7LOiX9rfTFWEkA+2eaKR5Pw9yBlRKKPUHqu0VrN+NHwADQkjkwp3i
	 rGdpiR3VkwFO6d5LpEcWjZhew63l+YViLVZ5M/s/DSVez6ZmX5m4FD6MLF3b14x+J1
	 dH9Ry6o24EELA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] udp: small changes on receive path
From: patchwork-bot+netdevbpf@kernel.org
Message-ID: <171175023049.13425.17170361907257369970.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 22:10:30 +0000
References: <20240328144032.1864988-1-edumazet@google.com>
In-Reply-To: <20240328144032.1864988-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Mar 2024 14:40:28 +0000 you wrote:
> This series is based on an observation I made in UDP receive path.
> 
> The sock_def_readable() costs are pretty high, especially when
> epoll is used to generate EPOLLIN events.
> 
> First patch annotates races on sk->sk_rcvbuf reads.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] udp: annotate data-race in __udp_enqueue_schedule_skb()
    https://git.kernel.org/netdev/net-next/c/605579699513
  - [net-next,2/4] udp: relax atomic operation on sk->sk_rmem_alloc
    https://git.kernel.org/netdev/net-next/c/6a1f12dd85a8
  - [net-next,3/4] udp: avoid calling sock_def_readable() if possible
    https://git.kernel.org/netdev/net-next/c/612b1c0dec5b
  - [net-next,4/4] net: add sk_wake_async_rcu() helper
    https://git.kernel.org/netdev/net-next/c/1abe267f173e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




