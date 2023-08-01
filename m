Return-Path: <netdev+bounces-23027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B450176A6FD
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4002817FB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AF0629;
	Tue,  1 Aug 2023 02:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8681FCF
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 02:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F803C433C7;
	Tue,  1 Aug 2023 02:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690857080;
	bh=mTxd6HdQzFWXD+l9R8aNLIJTw4K0Wg96Ajxe6Cwzwpw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KAG52lTMe9zgens46rA1eqv/cVT1kaIN46yTHYubtyBonBbMQC7xVE46a34uehmga
	 31kWSsZKowpkD2MbkHQGzvlDaG+VeKKeumaCEJFWx1l38kPGdAx445eNnJf9W1AQYI
	 vl1/r2x6mzXlfvj/rLlL6MMd6XlCwD/U6U1THCHc1VAWGL2xf5wHhSbZVLSwvRh++6
	 qvWYTtlQ7AU1tja7v7JykjmZIrgOWlpI+j7yAb/QqsX6cQwhYaaajdO0Sm2Xevw57D
	 uta6SqTz1Cg2sKs9BKsapSAlYej0MqzS9/ntVSPABQsROacNQHjl3FFg0CgrRS4Rfe
	 B8hTP27zKtI8g==
Date: Mon, 31 Jul 2023 19:31:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lin Ma" <linma@zju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 fw@strlen.de, yang.lee@linux.alibaba.com, jgg@ziepe.ca,
 markzhang@nvidia.com, phaddad@nvidia.com, yuancan@huawei.com,
 ohartoov@nvidia.com, chenzhongjin@huawei.com, aharonl@nvidia.com,
 leon@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230731193118.67d79f7b@kernel.org>
In-Reply-To: <38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
	<20230731120326.6bdd5bf9@kernel.org>
	<38179c76.f308d.189aed2db99.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Aug 2023 10:00:01 +0800 (GMT+08:00) Lin Ma wrote:
> > > However, this is tedious and just like Leon said: add another layer of
> > > cabal knowledge. The better solution should leverage the nla_policy and
> > > discard nlattr whose length is invalid when doing parsing. That is, we
> > > should defined a nested_policy for the X above like  
> > 
> > Hard no. Putting array index into attr type is an advanced case and the
> > parsing code has to be able to deal with low level netlink details.  
> 
> Well, I just known that the type field for those attributes is used as array
> index.
> Hence, for this advanced case, could we define another NLA type, maybe 
> NLA_NESTED_IDXARRAY enum? That may be much clearer against modifying existing
> code.

What if the value is of a complex type (nest)?  For 10th time, if
someone does "interesting things" they must know what they're doing.

> > Higher level API should remove the nla_for_each_nested() completely
> > which is rather hard to achieve here.  
> 
> By investigating the code uses nla_for_each_nested macro. There are basically
> two scenarios:
> 
> 1. manually parse nested attributes whose type is not cared (the advance case
>    use type as index here).
> 2. manually parse nested attributes for *one* specific type. Such code do
>    nla_type check.
> 
> From the API side, to completely remove nla_for_each_nested and avoid the
> manual  parsing. I think we can choose two solutions.
> 
> Solution-1: add a parsing helper that receives a function pointer as an
>             argument, it will call this pointer after carefully verify the
>             type and length of an attribute.
> 
> Solution-2: add a parsing helper that traverses this nested twice, the first
>             time  to do counting size for allocating heap buffer (or stack
>             buffer from the caller if the max count is known). The second
>             time to fill this buffer with attribute pointers.
> 
> Which one is preferred? Please enlighten me about this and I can try to propose
> a fix. (I personally like the solution-2 as it works like the existing parsers
> like nla_parse) 

Your initial fix was perfectly fine.

We do need a solution for a normal multi-attr parse, but that's not 
the case here.

