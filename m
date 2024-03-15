Return-Path: <netdev+bounces-80004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073EF87C6D8
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B531028283F
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 00:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3819F;
	Fri, 15 Mar 2024 00:54:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C817E9
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710464045; cv=none; b=ETr/ik7qC9CN6FIoygSieVP4EIuQdUaCqGWn1WlAzkCy17rhSfwnckbVxffjxoBjS9t29YhBvMjbxslbtjrj/A25N1zGIjWIFCmvUESi1hnwglIp/bZCnabMGw0eHuKRiz1LmGDL/byEuI6bTnkikNX09dOEVVt7tUG/lwZwxHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710464045; c=relaxed/simple;
	bh=+7fXd/kc8GVioLZNH5IaBf4XKLDzQvVjAKcuTWcfkqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXvbGLeByATFkLPwEoI2jGZSO+KTZ9LZVTdTCMGlD7LMbBkJxOnPyaCv4y46fDrncFopeUhIjAOKJkYGOw1XUgEpvi4vCX0zL7lDVtl3TX44aIBRa0eTA7h22IX4bVO3Ug/Xip8ibuOOruKfwV/t2nA4W/qAGRYN2v+A62F/sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rkvpT-0002LQ-On; Fri, 15 Mar 2024 01:53:47 +0100
Date: Fri, 15 Mar 2024 01:53:47 +0100
From: Florian Westphal <fw@strlen.de>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, anjali.k.kulkarni@oracle.com,
	pctammela@mojatatu.com, andriy.shevchenko@linux.intel.com,
	dhowells@redhat.com, kuniyu@amazon.com, netdev@vger.kernel.org,
	zzjas98@gmail.com
Subject: Re: [net/netlink] Question about potential memleak in
 netlink_proto_init()
Message-ID: <20240315005347.GA8896@breakpoint.cc>
References: <ZfOalln/myRNOkH6@cy-server>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfOalln/myRNOkH6@cy-server>
User-Agent: Mutt/1.10.1 (2018-07-13)

Chenyuan Yang <chenyuan0y@gmail.com> wrote:
> Dear Netlink Developers,
> 
> We are curious whether the function `netlink_proto_init()` might have a memory leak.

Yes, but

> The function is https://elixir.bootlin.com/linux/v6.8/source/net/netlink/af_netlink.c#L2908
> and the relevant code is
> ```
> static int __init netlink_proto_init(void)
> {
> 	int i;
>   ...
> 
> 	for (i = 0; i < MAX_LINKS; i++) {
> 		if (rhashtable_init(&nl_table[i].hash,
> 				    &netlink_rhashtable_params) < 0) {
> 			while (--i > 0)
> 				rhashtable_destroy(&nl_table[i].hash);
> 			kfree(nl_table);
> 			goto panic;

... this calls panic(), kernel will crash intentionally.

Perhaps best patch would be to remove this error handling
and panic straight away, this is pretty much dead code.

