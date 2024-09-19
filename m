Return-Path: <netdev+bounces-129003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2397CE5B
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 22:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 319351F2399F
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 20:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748274D8A3;
	Thu, 19 Sep 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY0egIb4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDB82AF1F
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726776039; cv=none; b=undSkqrn0vudzIj6NGodnS9bmJexpJvsDoXkkWWKM3oypdS5kq74qI+WW5guqrvNMJqkpwx6AnNWvVxl90t6gpg5H8irdK+U2VnAiA+PGr69/FBPff3Si/Seqd4Ltzc78T14ZfjdaD5Eq9tEqoq4ZhCj/IyqHdm0eO2r/A2RYmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726776039; c=relaxed/simple;
	bh=vJiK07yNf9M8pgt8xqJwuP6vuVBL4unh857wSY6RpoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a7Z2CeVKkk8MRfN9f8Abhstj5WvmVLnO77Dk5WND/ZQ4SW5Uu7KtWz2lxjPfc9N5eJDzW5iN6nYyRWexGbktst25aZLGX+5sKHMlMKY78q2RPT9XAa/Te8cU4YAQqGmbNNkyikXNSla1xw51Kv3RZf8iispNBuN235GfoxcNCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY0egIb4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033C2C4CEC5;
	Thu, 19 Sep 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726776039;
	bh=vJiK07yNf9M8pgt8xqJwuP6vuVBL4unh857wSY6RpoA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=GY0egIb4/AqDuFcnKzn8tbJ3VWsswf1vAai4s1/bhU0CkTBA8pXbMoYWl5ygi5eEa
	 rBGLo9zEyyvmNbbLXfCvj2EZ0v+J/d5d1LqJk4e1uCAuP84+PGdIbrZDneG4udZ6dp
	 EKnADYWP4DpU+u7TOaudRPPsB+5KMJuV/8neH0hfXInG42xIv89LIAdRYmMt5EJM74
	 XB4r+dYLLckTpavplFoq6dJm8vFH1/4eQiDtxj+qVg53W02AFA8IHakaSOwGzGbtRF
	 f4+Rk9io2QO20sXbv3YmwjrZl+nSFfZDc9l7fsusEdNIXbXb5LhKL2hF0pG2iGBoru
	 hwmEbSBm4y/wA==
Message-ID: <05371e60-fe62-4499-b640-11c0635a5186@kernel.org>
Date: Thu, 19 Sep 2024 14:00:38 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] af_packet: Fix softirq mismatch in tpacket_rcv
Content-Language: en-US
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Ben Greear <greearb@candelatech.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>
References: <20240918205719.64214-1-greearb@candelatech.com>
 <66ec149daf042_2deb5229470@willemb.c.googlers.com.notmuch>
 <0bbcd0f2-42e1-4fdc-a9bd-49dd3506c7f4@candelatech.com>
 <66ec5500c3b26_2e963829496@willemb.c.googlers.com.notmuch>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <66ec5500c3b26_2e963829496@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/19/24 10:44 AM, Willem de Bruijn wrote:
> Yes, it seems that VRF calls dev_queue_xmit_nit without the same BH
> protections that it expects.
> 
> I suspect that the fix is in VRF, to disable BH the same way that
> __dev_queue_xmit does, before calling dev_queue_xmit_nit.
> 

commit 504fc6f4f7f681d2a03aa5f68aad549d90eab853 removed the bh around
dev_queue_xmit_nit:

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 6043e63b42f9..43f374444684 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -638,9 +638,7 @@ static void vrf_finish_direct(struct sk_buff *skb)
                eth_zero_addr(eth->h_dest);
                eth->h_proto = skb->protocol;

-               rcu_read_lock_bh();
                dev_queue_xmit_nit(skb, vrf_dev);
-               rcu_read_unlock_bh();

                skb_pull(skb, ETH_HLEN);
        }

