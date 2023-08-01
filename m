Return-Path: <netdev+bounces-23080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2ED776AA91
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 10:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973DC1C20DE2
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 08:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D621ED26;
	Tue,  1 Aug 2023 08:11:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CFC1EA9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 08:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0373C433C8;
	Tue,  1 Aug 2023 08:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690877482;
	bh=OWZu55Ufaewrwq61zbQVPkXisyIVRzmtL9NXkGrrT08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVLDGFUjKNL9YQvEJbi0QhgdkVVETRueKCZ2xE2fcWVDSDYQjcZ3ajuQn8FA75WES
	 QzJwkFIXIl53Hvt9giwEdNL08L9HRCrKEw4pZ3ieIyitW1B3bSZIIFjA1DSdoNNZsO
	 /gxpzFmZuvW72e6fhmdqoFGybN5rw84F3gdG4ydJcOjopWXtNHsCtQeEqkrVAl4lRv
	 Y9Ym7C7ibhuPCPwt2u0ZfZG66iMhiW0nNoAUH5NhRTGaeHmvy2GlP37pDtSuU2Q710
	 wcoQYCuFKCk0tVd78iILIpWMKQLDwpnMM8MpM3+shJ4ZL6N4nv2nfQX6Fv/4tENdGt
	 133UkLROCpQ1Q==
Date: Tue, 1 Aug 2023 11:11:17 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, fw@strlen.de, yang.lee@linux.alibaba.com,
	jgg@ziepe.ca, markzhang@nvidia.com, phaddad@nvidia.com,
	yuancan@huawei.com, ohartoov@nvidia.com, chenzhongjin@huawei.com,
	aharonl@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net v1 1/2] netlink: let len field used to parse
 type-not-care nested attrs
Message-ID: <20230801081117.GA53714@unreal>
References: <20230731121247.3972783-1-linma@zju.edu.cn>
 <20230731120326.6bdd5bf9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731120326.6bdd5bf9@kernel.org>

On Mon, Jul 31, 2023 at 12:03:26PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 20:12:47 +0800 Lin Ma wrote:
> > In short, the very direct idea to fix such lengh-check-forgotten bug is
> > add nla_len() checks like
> > 
> >   if (nla_len(nla) < SOME_LEN)
> >     return -EINVAL;
> > 
> > However, this is tedious and just like Leon said: add another layer of
> > cabal knowledge. The better solution should leverage the nla_policy and
> > discard nlattr whose length is invalid when doing parsing. That is, we
> > should defined a nested_policy for the X above like
> 
> Hard no. Putting array index into attr type is an advanced case and the
> parsing code has to be able to deal with low level netlink details.

Jakub,

IMHO, you are lowering too much the separation line between simple vs.
advanced use cases. 

I had no idea that my use-case of passing nested netlink array is counted
as advanced usage.

Thanks

