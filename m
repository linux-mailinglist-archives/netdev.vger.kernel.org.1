Return-Path: <netdev+bounces-29024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7947816B8
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CEF281DEE
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6B65B;
	Sat, 19 Aug 2023 02:38:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34483632
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180A0C433C8;
	Sat, 19 Aug 2023 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692412691;
	bh=oSkCuPAKXtvGAJIRmzBOrV+jlKSk2VzCCDit/Nm5mbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kZle1zR3yL3S8NsbcSOizysqQjSY0B1GiZFlJAH8CoXUvTzjgMN+gralGiVI6//cu
	 IdZoYXRMQPG7Dm/PlqQ9AY8W5QEZNXYtYW55WcGFmUdTobLtiXKRbGxR4S0sDQUXPt
	 xuvBvWiKrHN0Z7dl1VJQOOpU2H9pdJ9fZ/rgWU/ONxebV71FTDiA7pPC1uQeV7ZpfO
	 vNA9miObq54SV4zVNbpP958nhJRXykhp7X4vQCe9X2+2Seo3lqzpIYzY3P52r8SWIz
	 8Pb22Ebjpelc7ZUK6q66VjFQP5hcxmhTRmtjhnPcb89e47VKT79kmF+C5TcNGJlscc
	 W60FWbi8W0Y+g==
Date: Fri, 18 Aug 2023 19:38:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
Message-ID: <20230818193810.102a2581@kernel.org>
In-Reply-To: <ZN5DvRyq6JNz20l1@work>
References: <ZN5DvRyq6JNz20l1@work>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 09:58:53 -0600 Gustavo A. R. Silva wrote:
> Subject: [PATCH][next] net: sched: cls_u32: Fix allocation in u32_init()
> Date: Thu, 17 Aug 2023 09:58:53 -0600
> 
> Replace struct_size() with sizeof(), and avoid allocating 8 too many
> bytes.

What are you fixing?

> The following difference in binary output is expected and reflects the
> desired change:
> 
> | net/sched/cls_u32.o
> | @@ -6148,7 +6148,7 @@
> | include/linux/slab.h:599
> |     2cf5:      mov    0x0(%rip),%rdi        # 2cfc <u32_init+0xfc>
> |                        2cf8: R_X86_64_PC32     kmalloc_caches+0xc
> |-    2cfc:      mov    $0x98,%edx
> |+    2cfc:      mov    $0x90,%edx

Sure, but why are you doing this? And how do you know the change is
correct?

There are 2 other instances where we allocate 1 entry or +1 entry.
Are they not all wrong?

Also some walking code seems to walk <= divisor, divisor IIUC being
the array bound - 1?

Jamal acked so changes are this is right, but I'd really like to
understand what's going on, and I shouldn't have to ask you all 
these questions :S
-- 
pw-bot: cr

