Return-Path: <netdev+bounces-189048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A505CAB011D
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA93501B62
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B63A284B35;
	Thu,  8 May 2025 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/kiMkaK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765BA17A2E2
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 17:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724242; cv=none; b=mruJaLYUZVdqSolfiVXhmC9vI8GN0VmfGRfmxCsxHLewjkASmd19rzMXoa1Tvgj6AIo0Yn0RDKWZOnPk2eeOUCjM6tGQJPsjSDnP4ly5cosT36Y0Ce1OeBxq0wUC+w0DE+Q+Wavv9IiMlClvNGYvZZDJgYkpzECZdGqgOtQae1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724242; c=relaxed/simple;
	bh=WB+EppGf9MLxqD1iTyPTgOFAqwUUBSsNmIijcNpDE+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8+lAXPDQQkCHbWk3XjAADOMnYvFplX9UBzFGyV8MQDeW7cUgblJfkljeYhlVcLPuQv43BlLiyz3cZAtMWKe0p5xLP7WHk6MmlOimSxGmJ2/Dxa7oF5SzMG9skzpsYND+ilDg8Htl4EqBZL2a7CjnsPFr9XGX7jIrbFjg74ooJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/kiMkaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22849C4CEE7;
	Thu,  8 May 2025 17:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746724239;
	bh=WB+EppGf9MLxqD1iTyPTgOFAqwUUBSsNmIijcNpDE+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/kiMkaKAwWwb7Vk+xQYenI8EQsck5ZVnzpdF3S9XY5WrZhAnCxdG8RCARJrNocMU
	 scE9D5Sr/eqUBfk/5tLhnE6qvd2w+hQKtIwL0oYC3hRVN1Al5XnRtIFbDYKFDQhozP
	 wgblM70l01gZ7SUTNy5SVSObaVDhJkHCIIUNnRB8Vn4SvXS1XD9d3i2xZyR12Eploj
	 MRjnIEZNPi9ltJ4MWSsumyutVQc09cKYIE+LzhrPrCNr5CrpRgjeuHBzyC6UcNmyL3
	 lAoWVObqgo2sDJ1NBXqQV5jtbXoz4H5afevRohfTqG8KAZkMT+YBVQ6Y8WNn1/AgLU
	 KE8PjLViQLUlg==
Date: Thu, 8 May 2025 18:10:35 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
	syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: mctp: Don't access ifa_index when missing
Message-ID: <20250508171035.GM3339421@horms.kernel.org>
References: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
 <20250506160753.GU3339421@horms.kernel.org>
 <20250506175830.15aefdbb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506175830.15aefdbb@kernel.org>

On Tue, May 06, 2025 at 05:58:30PM -0700, Jakub Kicinski wrote:
> On Tue, 6 May 2025 17:07:53 +0100 Simon Horman wrote:
> > > +	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
> > > +		hdr = nlmsg_data(cb->nlh);  
> > 
> > FWIIW, I think the scope of the declaration of hdr can be reduced to this block.
> > (Less positive ease, so to speak.)
> 
> We wouldn't be able to sizeof(*hdr) if we move it?

Yes, of course.
Sorry for missing that.

> 
> I have a different request :) Matt, once this ends up in net-next
> (end of this week) could you refactor it to use nlmsg_payload() ?
> It doesn't exist in net but this is exactly why it was added.
> 

