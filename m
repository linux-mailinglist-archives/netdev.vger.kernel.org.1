Return-Path: <netdev+bounces-107644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F991BCE4
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 12:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F483282FEF
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 10:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A6313F44F;
	Fri, 28 Jun 2024 10:53:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A92139A8
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719572028; cv=none; b=G86UORnWRmnXE9KDtZzFHCVhI7M3lj25OeDMei7QNGn3uYpIufoRBxBmM3s3Xs4xHRA53JKAnh4ecb1M9U7uvQyhrS3h6cSp5UUH6Spf+5srswlxQYOQ18te9hbz0FYAQujuzKfYc7SByUQjPnH29m9ICqnMJxeiXlfcjuWIGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719572028; c=relaxed/simple;
	bh=TtrzVKdi5JzSAySRb4BW+dPkaFWclAXOVjyuN2jcGs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDCH2MnDht78YYTgdf2ufSvBGMoFi+la/E7+CKSzgoXxG826fGIKuooikHjZ7THLOHYAXJDxdhgEIhRSF+JwV1zUyvabXtTCg+wwcYxhFtL0tCLWS6UXgB0LiiDcRZk01aCMg0ke9n9gOrvTLJOezdUwHlgY2SdZ3iH0xQd4lgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sN9Ed-0003uX-78; Fri, 28 Jun 2024 12:53:43 +0200
Date: Fri, 28 Jun 2024 12:53:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Ian Kumlien <ian.kumlien@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>
Subject: Re: IP oversized ip oacket from - header size should be skipped?
Message-ID: <20240628105343.GA14296@breakpoint.cc>
References: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA85sZuGQGM+mNOtD+B=GQJjH3UaoqUkZkoeiKZ+ZD+7FR5ucQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Ian Kumlien <ian.kumlien@gmail.com> wrote:
> Hi,
> 
> In net/ipv4/ip_fragment.c line 412:
> static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
>                          struct sk_buff *prev_tail, struct net_device *dev)
> {
> ...
>         len = ip_hdrlen(skb) + qp->q.len;
>         err = -E2BIG;
>         if (len > 65535)
>                 goto out_oversize;
> ....
> 
> We can expand the expression to:
> len = (ip_hdr(skb)->ihl * 4) + qp->q.len;
> 
> But it's still weird since the definition of q->len is: "total length
> of the original datagram"

AFAICS datagram == l4 payload, so adding ihl is correct.

