Return-Path: <netdev+bounces-192212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EEAABEEE7
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EA0188F377
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209E22356CE;
	Wed, 21 May 2025 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLO4lJgH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134D235368
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747818124; cv=none; b=XRWA7q3b+GIoVvGHNfS9xrLjer4w+jDxWeNqK213cmUQvgK8BCG1/wQ3zs/8nVbQcRk53URr+qtdh2FFh2/ehIvcVB8YQKjDppC8Vbc3UvFhJaEL1e4PlS1qGwx+eUAUcagHELCPkThhMdR8WtTrmNaPhl+NgqDZDV2UzcxkhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747818124; c=relaxed/simple;
	bh=0VgSwP5BioIojdUXUNIHYaT3n0OEMzXfB9SCMFJydNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JoYTfyZp8IJdnJ2ohVjVV/UL9cZmSkCE6jB+zdjt++f2Zmleq29WnE5eB5BvBOLREYNzloi9upnL071N4UBxDYWTTVPzujiX4Za/d+OYcjE4A2QD6bBZaBXtcmqIareUoaKqAi2Mhnfl4F7IK2bbACK9Qw3xZ7KpPC9SRzECPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLO4lJgH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12E7C4CEE4;
	Wed, 21 May 2025 09:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747818123;
	bh=0VgSwP5BioIojdUXUNIHYaT3n0OEMzXfB9SCMFJydNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLO4lJgHRJhVQe1iTqZDwyMAdfmSTcxUzHi9b4aZp+3hoXSmAFU9QNN7rqP+wyNhp
	 oWMLBHB2IB61jyZZ5/EbcfVR2yZfy80ewRB6W6Iqx9KS2/xNB29wfDRayJJLLd/9yR
	 PcXmxkFERrNQwOGWuTClfMxv4+R/I/rZhFlx8+1VXsfwCGZpoyQpdsd+qxEIEofXnC
	 jc4UxqNOXSRerobYOvvm0incRC9O6aMwgs94C3gqr9KBiuV7lZ33smXRo1QavTYbw3
	 9bNjq+WFx6lfjzkS/KyCTQdZJm6A8yKvOzjHJCRn47vrYAcGRal5WQCis3tJJZFxxC
	 uLUVQG0GKyTlQ==
Date: Wed, 21 May 2025 10:01:59 +0100
From: Simon Horman <horms@kernel.org>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: mctp: use nlmsg_payload() for netlink
 message data extraction
Message-ID: <20250521090159.GR365796@horms.kernel.org>
References: <20250520-mctp-nlmsg-payload-v1-1-93dd0fed0548@codeconstruct.com.au>
 <20250520152315.GB365796@horms.kernel.org>
 <c41a3d3d22c078eab43f8ccd4eeef25d668fa9f9.camel@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c41a3d3d22c078eab43f8ccd4eeef25d668fa9f9.camel@codeconstruct.com.au>

On Wed, May 21, 2025 at 10:05:36AM +0800, Jeremy Kerr wrote:
> Hi Horms,
> 
> Thanks for the review!
> 
> > > --- a/net/mctp/neigh.c
> > > +++ b/net/mctp/neigh.c
> > > @@ -250,7 +250,10 @@ static int mctp_rtm_getneigh(struct sk_buff *skb, struct netlink_callback *cb)
> > >                 int idx;
> > >         } *cbctx = (void *)cb->ctx;
> > >  
> > > -       ndmsg = nlmsg_data(cb->nlh);
> > > +       ndmsg = nlmsg_payload(cb->nlh, sizeof(*ndmsg));
> > > +       if (!ndmsg)
> > > +               return -EINVAL;
> > > +
> > 
> > But is this one a bug fix?
> 
> At the moment, we cannot hit the case where the nlh does not contain a
> full ndmsg, as the core handler (net/core/neighbour.c, neigh_get()) has
> already validated the size (through neigh_valid_req_get()), and would
> have failed the get before the MCTP hander is called.
> 
> However, relying on that is a bit fragile, hence applying the
> nlmsg_payload replacement here.
> 
> I'm happy to split it out if that makes more sense though; in which case
> this change would be initially implemented as check on ->nlmsg_len (in
> order to be backportable to stable), and then a subsequent rework to use
> nlmsg_payload. Let me know what would work best.

Hi Jeremy,

Thanks for the explanation. I think it might be best to add some commentary
to the commit message, as this was not obvious to me. But I don't feel
strongly about this.

So either way, this patch now looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

