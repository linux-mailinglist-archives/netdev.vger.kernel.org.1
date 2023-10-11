Return-Path: <netdev+bounces-40047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8417C58F2
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6496928231A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16C632C83;
	Wed, 11 Oct 2023 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOiW2Ch6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C249518B04
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E536FC433C8;
	Wed, 11 Oct 2023 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697040985;
	bh=9IheF/fvS5UVbhw8i80+xLg1OjTFS5M5vFXqMpyIuIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cOiW2Ch6JV9twWHuqhv9CXWG+i76WNwLoW8qEhcK32SZPTqRDq+gLgLzc/TRsizXv
	 AIm8nJpv/Cv86ePsSd1O340vOFEPhiKJfp7aMTbBct6H8pSFm5pXe34ouTUoV8vciy
	 TCAae0sSkDyDh1HGOJOwdCS/JiA5PXK20t+sayLAb89VWZ4hhMyXmqs41nSK7MMchV
	 /djwgwZkMRAlaE2sNXgb2Kya7RgYlpfuvNg8eoSPYnMhDXFyM9VXSyh78jBNVWy5Ia
	 kqVRPDk6aG4wxNehZJh8TpKAOBEdsvy4gFe9fVupTko+cphZZcWDNgPVpjE1uTYbeu
	 gJtHeZy+8lk3g==
Date: Wed, 11 Oct 2023 09:16:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
 johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
 mkubecek@suse.cz, aleksander.lobakin@intel.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011091624.4057e456@kernel.org>
In-Reply-To: <ZSanRz7kV1rduMBE@nanopsycho>
References: <20231011003313.105315-1-kuba@kernel.org>
	<ZSanRz7kV1rduMBE@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 15:46:47 +0200 Jiri Pirko wrote:
> >Thoughts?  
> 
> Hmm, I assume that genetlink.yaml schema should only allow uint and sint
> to be defined after this, so new genetlink implementations use just uint
> and sint, correct?

No, fixed types are still allowed, just discouraged.

> Than we have genetlink.yaml genetlink-legacy.yaml genetlink-legacy2.yaml
> ?
> I guess in the future there might be other changes to require new
> implemetation not to use legacy things. How does this scale?
>
> >This is completely untested. YNL to follow.
> >---
> > include/net/netlink.h        | 62 ++++++++++++++++++++++++++++++++++--
> > include/uapi/linux/netlink.h |  5 +++
> > lib/nlattr.c                 |  9 ++++++
> > net/netlink/policy.c         | 14 ++++++--
> > 4 files changed, 85 insertions(+), 5 deletions(-)
> >
> >diff --git a/include/net/netlink.h b/include/net/netlink.h
> >index 8a7cd1170e1f..523486dfe4f3 100644
> >--- a/include/net/netlink.h
> >+++ b/include/net/netlink.h
> >@@ -183,6 +183,8 @@ enum {
> > 	NLA_REJECT,
> > 	NLA_BE16,
> > 	NLA_BE32,
> >+	NLA_SINT,  
> 
> Why not just NLA_INT?

Coin toss. Signed types are much less common in netlink
so it shouldn't matter much.

> >+static inline int nla_put_uint(struct sk_buff *skb, int attrtype, u64 value)
> >+{
> >+	u64 tmp64 = value;
> >+	u32 tmp32 = value;
> >+
> >+	if (tmp64 == tmp32)
> >+		return nla_put_u32(skb, attrtype, tmp32);  
> 
> It's a bit confusing, perheps better just to use nla_put() here as well?

I want to underscore the equivalency to u32 for smaller types.

