Return-Path: <netdev+bounces-203765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52A8AF71AE
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 355BF4E2327
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55DDA23BF8F;
	Thu,  3 Jul 2025 11:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b="hOqYfXyW"
X-Original-To: netdev@vger.kernel.org
Received: from sysclose.org (smtp.sysclose.org [69.164.214.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B552DE70B;
	Thu,  3 Jul 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.164.214.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751540658; cv=none; b=RIvBFMIrJoMczd3DGC5fd0IgED7kcFMSsxepUwHj75ROVOtNg0vsBe0nZL34VlnaKjoAgL8QMbymq27i5CP6FZ25m/wxgw/tDyeuePFIKI4wGf5fRG6iYTg9iI4sFax63R7Yl1RvavXx1D6bwwUML/ObK1z3h57NANmTquxc6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751540658; c=relaxed/simple;
	bh=c4flVqe1KZrHKynpj0pEvcVyw5QP4gPBfrOfThsnwuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TAEfWAWQPAhvtarbq1dFp8LX9q44kq8tt3xkSQDLs4RQmiZL6b3dtb7TNAb79O8NRj4UMvOvFp4Qy51aI9T+4VX4jrtodp1a7LADvaqW5jdigunQk1aynI1wPnEpkKM/bu7hCj/o/FeV35bPiD7fmQE0AvhyIby/nQX3gFJ3/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org; spf=pass smtp.mailfrom=sysclose.org; dkim=pass (2048-bit key) header.d=sysclose.org header.i=@sysclose.org header.b=hOqYfXyW; arc=none smtp.client-ip=69.164.214.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sysclose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysclose.org
Received: from uranium (unknown [131.100.62.92])
	by sysclose.org (Postfix) with ESMTPSA id A0FE3396A2;
	Thu,  3 Jul 2025 11:04:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 sysclose.org A0FE3396A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysclose.org;
	s=201903; t=1751540655;
	bh=TuiyNT4htGIu981GyQzKvKNCKnpWWXh48AUCOlWIMoQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hOqYfXyWd3HPGK+JiywGF4mkaLwLyQrAVFuBCwUa2aLEV4Ptd9HrrIL9AfUtqhEF2
	 ZN4bAdYyQP4t4nyExdbgy0TzAvJtIqif6ATwZ4FJ2Re+AT2QXDLggyxRLGzY4gkwa8
	 e/y7li7eRmHEnXE084mTnzg4/uAyWuO/oSoRz0Hx0pvklhwqVniAJy1cLERTcci4yZ
	 tYxSz2FwnSZVeEsiV7VMApVutjYphJQslOFZfUIo9PdpjiO1tvB/IAoXDLulJrv7XK
	 JZTXhodM9jhlpZ3eXgCA5hppK7590IWpTTNewru6vONuZojl3OKuGAl3vbFkfxEt6A
	 oOh4ktYdTbtxw==
Date: Thu, 3 Jul 2025 08:04:11 -0300
From: Flavio Leitner <fbl@sysclose.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Simon
 Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: allow providing
 upcall pid for the 'execute' command
Message-ID: <20250703080411.21c45920@uranium>
In-Reply-To: <5c0e9359-6bdd-4d49-b427-8fd1e8802b7c@ovn.org>
References: <20250627220219.1504221-1-i.maximets@ovn.org>
	<20250702105316.43017482@uranium>
	<00067667-0329-4d8c-9c9a-a6660806b137@ovn.org>
	<20250702200821.3119cb6c@uranium>
	<5c0e9359-6bdd-4d49-b427-8fd1e8802b7c@ovn.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Jul 2025 10:38:49 +0200
Ilya Maximets <i.maximets@ovn.org> wrote:

> On 7/3/25 1:08 AM, Flavio Leitner wrote:
> >>>> @@ -651,6 +654,10 @@ static int ovs_packet_cmd_execute(struct sk_buff
> >>>> *skb, struct genl_info *info) !!(hash & OVS_PACKET_HASH_L4_BIT));
> >>>>  	}
> >>>>  
> >>>> +	if (a[OVS_PACKET_ATTR_UPCALL_PID])
> >>>> +		upcall_pid =
> >>>> nla_get_u32(a[OVS_PACKET_ATTR_UPCALL_PID]);
> >>>> +	OVS_CB(packet)->upcall_pid = upcall_pid;  
> > 
> > Since this is coming from userspace, does it make sense to check if the
> > upcall_pid is one of the pids in the dp->upcall_portids array?  
> 
> Not really.  IMO, this would be an unnecessary artificial restriction.
> We're not concerned about security here since OVS_PACKET_CMD_EXECUTE
> requires the same privileges as the OVS_DP_CMD_NEW or the
> OVS_DP_CMD_SET.

What if the userspace is buggy or compromised?
It seems netlink API will return -ECONNREFUSED and the upcall is dropped.
Therefore, we would be okay either way, correct?


