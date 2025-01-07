Return-Path: <netdev+bounces-155812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B6CA03E30
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BABA7A2172
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1731EBFF0;
	Tue,  7 Jan 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="R1iNg1cd"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B391E571F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 11:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736250457; cv=none; b=B3tOW+gVOduQUDEewgVK1SfkAm/BDGC5ljuLxAA/RrDQA7TOOwp8+zHroVyWe07TA3IUTxiT3+Uy7HjxMn9VxUmodpZ+g1YlJyPMoOt8d6mJ9z4fQlQEkR+o0e3zTV6Yel6nZHd55fp0+D0fur4iPsF6xgLUPirapc4pjkt8qIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736250457; c=relaxed/simple;
	bh=1kxZKLZGhjDjHgtIcYkrhDO6Jr1Tbj8kd51Jm/mwFF8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl9a8Y5DneuQ/ZxGu7tWQ5yRwbaVFNzUBi5CH74Psx0VGwke9H/n9K7I7LjA0Ng44SNVsRGGQjhVxrCUcQmozJAjyhfMXS+/p6P8Cv7aui+XpPDeTB4OpPxwGNElGGLH5uZ5xIwq7fvpF95rsJ5WYOZywkYYpDpy0afeYlPjwuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=R1iNg1cd; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A1F3E2067F;
	Tue,  7 Jan 2025 12:47:25 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hR71eGhto0tY; Tue,  7 Jan 2025 12:47:20 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2A9FF20854;
	Tue,  7 Jan 2025 12:47:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2A9FF20854
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1736250437;
	bh=zyhNFe1ufD3YJ0mfNQLw3CbnaKBwWbsZwK6/uMlw0fc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=R1iNg1cd3qa9in1rR7QNFzsDN5kGxzxWDvU9+gNzJukCkP1O+l5gOml/bFwxAhuJ+
	 HvGHX+xLGVtIJkbhpE3FzWJAg57wGRsTs+xD7Zzk32bb3J91icRYJ/EOyoNpMB5VKg
	 Lc6jDWesEyyqlfPCVu0FsGvMx2+JEHS0qD1sPaBM3HbQxWvybBw3e7D4VhHMCI50Xw
	 bfDNeOhDPWDjHqP0+V7zx4uCq9hNuLiq9uxSt8I1aYXuK9TDKnuPUC9c6vV2NLxM6z
	 MMrXDO+GXPbgnFo97QHGP9hwXoDQk+RM2Y0xg5/PRGyctt3Z/HzwpCHQkfyVAyigLa
	 rT3lUfK/iOQzg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 7 Jan 2025 12:47:16 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 12:47:16 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 6D13B3184216; Tue,  7 Jan 2025 12:47:16 +0100 (CET)
Date: Tue, 7 Jan 2025 12:47:16 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Alexandre Cassen <acassen@corp.free.fr>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, Raed Salem
	<raeds@nvidia.com>
Subject: Re: [PATCH ipsec-rc] xfrm: delete intermediate secpath entry in
 packet offload mode
Message-ID: <Z30URE1xbTYPv1Ro@gauss3.secunet.de>
References: <f417e151bc753428b66f4ca4762a78203623f83d.1735812447.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f417e151bc753428b66f4ca4762a78203623f83d.1735812447.git.leon@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Jan 02, 2025 at 12:11:11PM +0200, Leon Romanovsky wrote:
> From: Alexandre Cassen <acassen@corp.free.fr>
> 
> Packets handled by hardware have added secpath as a way to inform XFRM
> core code that this path was already handled. That secpath is not needed
> at all after policy is checked and it is removed later in the stack.
> 
> However, in the case of IP forwarding is enabled (/proc/sys/net/ipv4/ip_forward),
> that secpath is not removed and packets which already were handled are reentered
> to the driver TX path with xfrm_offload set.
> 
> The following kernel panic is observed in mlx5 in such case:
> 
>  mlx5_core 0000:04:00.0 enp4s0f0np0: Link up
>  mlx5_core 0000:04:00.1 enp4s0f1np1: Link up
>  Initializing XFRM netlink socket
>  IPsec XFRM device driver
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  #PF: supervisor instruction fetch in kernel mode
>  #PF: error_code(0x0010) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0010 [#1] PREEMPT SMP
>  CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.13.0-rc1-alex #3
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
>  RIP: 0010:0x0
>  Code: Unable to access opcode bytes at 0xffffffffffffffd6.
>  RSP: 0018:ffffb87380003800 EFLAGS: 00010206
>  RAX: ffff8df004e02600 RBX: ffffb873800038d8 RCX: 00000000ffff98cf
>  RDX: ffff8df00733e108 RSI: ffff8df00521fb80 RDI: ffff8df001661f00
>  RBP: ffffb87380003850 R08: ffff8df013980000 R09: 0000000000000010
>  R10: 0000000000000002 R11: 0000000000000002 R12: ffff8df001661f00
>  R13: ffff8df00521fb80 R14: ffff8df00733e108 R15: ffff8df011faf04e
>  FS:  0000000000000000(0000) GS:ffff8df46b800000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: ffffffffffffffd6 CR3: 0000000106384000 CR4: 0000000000350ef0
>  Call Trace:

...

> 
> Fixes: 5958372ddf62 ("xfrm: add RX datapath protection for IPsec packet offload mode")
> Signed-off-by: Alexandre Cassen <acassen@corp.free.fr>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Applied, thanks a lot!

