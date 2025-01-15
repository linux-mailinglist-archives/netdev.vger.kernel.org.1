Return-Path: <netdev+bounces-158560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B46A127D8
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 16:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B6A3A7879
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFC515B14B;
	Wed, 15 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qunw6Huf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B48724A7C4
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736956316; cv=none; b=agLM2jSLVo/KsMJlA7YRcJ+8i/MRQWH/j3O5r4ck7lp+aoQB9px1pRkCSFTNKfs4UcQ3F9xEJrJVSXMQPttLah+Qa9cmfQ53amYzkj3WkAp747wcDJaP4tLvN7p6CrxTFg2+QwmVfoHap4h5yduKy4WxERtcKAhAGqpzs4YnNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736956316; c=relaxed/simple;
	bh=vq7TaRrmt+cHZ7ljRtzXJQsFR/LIOZrEyYrVV4qPrmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+LAEbRXDragSgbv/jfZZx2jfN35sOnGOHtIcrOfivU1MdeR0B4nbQvjSxhibJu26NyzcHqaMS7Lci+DOtscGAsjFIvUkks2NP0caiaD1OFd8E027MJrMI1UZEg3q5i4s4eoC0s/EKtzwwqDDIxnE5B1mObfD71HG2Mrf2l4eoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qunw6Huf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED1AC4CED1;
	Wed, 15 Jan 2025 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736956316;
	bh=vq7TaRrmt+cHZ7ljRtzXJQsFR/LIOZrEyYrVV4qPrmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qunw6HufL0PWHrlPlWEGHFDd14NGzSC5MQHobhy3sIvLIfnvm4G5cr8PjlZvVAXJk
	 0Nk18N8ROIPuP/qDzIvKSu1/Au3HkgnbCFLyW19qAN+0G8iHIitXdAkrdChaVmJZUp
	 1bfVKTu3Cd/YRJ4I39sYDXX3V1vqH1Zkd6Z+OZSVECr5UaA9hylrRRr4pnstyOs6n2
	 FVpS7JdvBuY9IztyUST0jedI9aRA6bGq3vfMrYANSKCA95B+i1KsXHzOjJDaTrlXN+
	 gru10BVrzG6nI1x4BytAoEteWn2xz3drpCrMANH5Ms+sooiAB2XBK3W5LsHbL/ToHn
	 rtxRgo+ENzC/w==
Date: Wed, 15 Jan 2025 07:51:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 davem@davemloft.net, edumazet@google.com, security@kernel.org,
 nnamrec@gmail.com
Subject: Re: [PATCH net 1/1 v3] net: sched: Disallow replacing of child
 qdisc from one parent to another
Message-ID: <20250115075154.528eee8a@kernel.org>
In-Reply-To: <CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
References: <20250111151455.75480-1-jhs@mojatatu.com>
	<20250114172620.7e7e97b4@kernel.org>
	<CAM0EoMnYi3JBPS7KyPoW5-St-xAaJ8Xa1tEp8JH9483Z5k8cLg@mail.gmail.com>
	<20250115063655.21be5c74@kernel.org>
	<CAM0EoMk0rKe=AqoD_vNZNj2dz9eKSQpgS0Cc7Bi+FQwqpyHXaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Jan 2025 09:53:27 -0500 Jamal Hadi Salim wrote:
> > > I may be missing something - what does TC_H_MAJ() provide?
> > > The 3:1 and 1:3 in that example are both descendants of the same
> > > parent. It could have been 1:3 vs 1:2 and the same rules would apply.  
> >
> > Let me flip the question. What qdisc movement / grafts are you intending
> > to still support?
> >  
> 
> Grafting essentially boils down to a del/add of a qdisc. The
> ambiguities: Does it mean deleting it from one hierachy point and
> adding it to another point? Or does it mean not deleting it from the
> first location but making it available in the other one?
> 
> > From the report it sounds like we don't want to support _any_ movement
> > of existing qdiscs within the hierarchy. Only purpose of graft would
> > be to install a new / fresh qdisc as a child.  
> 
> That sounded like the safest approach. If there is a practical use for
> moving queues around (I am not aware of any, doesnt mean there is no
> practical use) then we can do the much bigger surgery.

So coming back to the code I would have expected the patch to look
something along the lines of:

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 300430b8c4d2..fac9c946a4c7 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1664,6 +1664,10 @@ static int tc_modify_qdisc(struct sk_buff *skb, struct nlmsghdr *n,
 				q = qdisc_lookup(dev, tcm->tcm_handle);
 				if (!q)
 					goto create_n_graft;
+				if (q->parent != tcm->tcm_parent) {
+					NL_SET_ERR_MSG(extack, "Cannot move an existing qdisc to a different parent");
+					return -EINVAL;
+				}
 				if (n->nlmsg_flags & NLM_F_EXCL) {
 					NL_SET_ERR_MSG(extack, "Exclusivity flag on, cannot override");
 					return -EEXIST;


Whether a real (non-default) leaf already existed in that spot 
is not important..

