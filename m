Return-Path: <netdev+bounces-204100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C8AF8E96
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C1445602C8
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F5B28B419;
	Fri,  4 Jul 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="mdiZoBaD"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AE328935D;
	Fri,  4 Jul 2025 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621230; cv=none; b=lH4h9XYBgnsr6pSXR1Zd24VwslbSMb7+vHdwGNYLW0+6ww+l0HJUeBU6Sw6SuRaLK3E7clVjjb22J92ILF7C0Sr4E0LXeRs5E8CP3qpLnoqjOwIryrtLYxSjAiGyZHthuXIxU4p1BXp2ur1klUMFkBqoI/UtKEELYPLsiaIBCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621230; c=relaxed/simple;
	bh=5wbbXxgvDFyK+G+2mifhOPF7TDkBVwZWONUdtH31LPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jKdHgol/78GuewsXjiaGhyrEp5Rqw7FoQvp0H1J8SiGhdJc/9UHG97S2LHWrj3QHzlgMoU+wFEiM2SIpZAoaIbAddFiLrJhORHmqh5f7JX9NUWymGCZvJCUiK7+QTWHtYJMDYBSW3FVaGKQUUxx8BrPVLSmIkKnHqg9J1myIJ2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=mdiZoBaD; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=f7
	CFGDQq6f5U6xjFHBlUjqg91tFfHeHfYWC9ZkGkvEo=; b=mdiZoBaD3GX8nr36/8
	1ux/cdjFvWgwWNccweBuly87T1hwHo7s/Meo4FMPqSQfBdYo8ObKxkS0Ha85Qof6
	9q4CXlyB4DD/nrs+/C6py0E5iZQAKZJwUq2bUFTleS7ciGbg3X/W6+saF2ZQ2n9p
	qjhH9UEW/Xmbk787KyJoS81ec=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgA3y+NFnmdoo9YvAA--.6682S2;
	Fri, 04 Jul 2025 17:26:29 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: david.laight.linux@gmail.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	davem@davemloft.net,
	ebiggers@google.com,
	edumazet@google.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stfomichev@gmail.com,
	willemb@google.com,
	yangfeng59949@163.com,
	yangfeng@kylinos.cn
Subject: Re: [PATCH v3] skbuff: Add MSG_MORE flag to optimize large packet transmission
Date: Fri,  4 Jul 2025 17:26:28 +0800
Message-Id: <20250704092628.80593-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250703124453.390f5908@pumpkin>
References: <20250703124453.390f5908@pumpkin>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgA3y+NFnmdoo9YvAA--.6682S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy8GF1ftFW7trW5Cr18uFg_yoW8Ar1UpF
	W5J3srtrs5Ca1jyrn2qw4xWw45t3ySgr13Aas0v34Fk3909rykWFy2qF4xKF95JrnFkFyY
	vw4qgasrCa4Yv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRcTmhUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTgKAeGhnnH40IwAAsO

Thu, 3 Jul 2025 12:44:53 +0100 david.laight.linux@gmail.com wrote:

> On Thu, 3 Jul 2025 10:48:40 +0200
> Paolo Abeni <pabeni@redhat.com> wrote:
> 
> > On 6/30/25 9:10 AM, Feng Yang wrote:
> > > From: Feng Yang <yangfeng@kylinos.cn>
> > > 
> > > The "MSG_MORE" flag is added to improve the transmission performance of large packets.
> > > The improvement is more significant for TCP, while there is a slight enhancement for UDP.  
> > 
> > I'm sorry for the conflicting input, but i fear we can't do this for
> > UDP: unconditionally changing the wire packet layout may break the
> > application, and or at very least incur in unexpected fragmentation issues.
> 
> Does the code currently work for UDP?
> 
> I'd have thought the skb being sent was an entire datagram.
> But each semdmsg() is going to send a separate datagram.
> IIRC for UDP MSG_MORE indicates that the next send() will be
> part of the same datagram - so the actual send can't be done
> until the final fragment (without MSG_MORE) is sent.

If we add MSG_MORE, won't the entire skb be sent out all at once? Why doesn't this work for UDP?
If that's not feasible, would the v2 version of the code work for UDP?
Thanks.

> None of the versions is right for SCTP.
__skb_send_sock
	......
	INDIRECT_CALL_2(sendmsg, sendmsg_locked, sendmsg_unlocked, sk, &msg);
	......
This sending code doesn't seem to call sctp_sendmsg.

> The skb being sent needs to be processed as a single entity.
> Here MSG_MORE tells the stack that more messages follow and can be put
> into a single ethernet frame - but they are separate protocol messages.
> 
> OTOH I've not looked at where this code is called from.
> In particular, when it would be called with non-linear skb.
> 
> 	David


