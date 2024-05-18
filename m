Return-Path: <netdev+bounces-97104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC2E8C913A
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 14:55:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 143171F21AF5
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 12:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E6E2BD18;
	Sat, 18 May 2024 12:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uxzheDy7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DFA28379
	for <netdev@vger.kernel.org>; Sat, 18 May 2024 12:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716036919; cv=none; b=W4CiVf6jZv5wInPu4Ca7Dkl0vuXNphrlSqzmtqqrzuuZh8hfhM5oKZZINYATHU1U38KG9ufMqEKAxOuQSfIBPpdkQQlmcRaoN5OObr86UVPzU3Yv5a4lPnDhM/goa5Ate9uXrp9YvPUfCXUL+srQhEbm/ySpOj6zYIIUBdLwwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716036919; c=relaxed/simple;
	bh=j1OkeHB51DnH91RK0vXnIN/nA8VFkbY7bZMyLfmmGGI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ/6j7eGmo7AgKz6/9kVGe6CaoWRVqzrkFPikbFWfeO5KGBgUJoy+lzLm2RZ3S5s0u73Xmce0Ra7ClmzluI78pWG5S5PWiCFDCHPe3vL+ij7QpeEHZrLFjFrUeGvlRQQVVJK2ZhmQkfb7mWmRspwItFqROlt31umtyw00Qtuoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uxzheDy7; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1716036918; x=1747572918;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ow8Gx2zKDxEfTe7rolkjr/tijY1jZp9Dx6orpLrIFX0=;
  b=uxzheDy7ukK4JSSqPNb/QP4lj0LBDiDSutoZMdhM430VHeDewMOZxfk4
   gesdRKbzqcj86SAofze/2IvCNH5d4t+5eHQXNV8UDDSOu7xF8c211tl1k
   fLYPZeH7kHut4jT6tH/RmxUlSghgZDYcniU0TNrSeIlEM9LdG/ZHxGQDo
   I=;
X-IronPort-AV: E=Sophos;i="6.08,170,1712620800"; 
   d="scan'208";a="726633150"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2024 12:55:11 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:19784]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.39.9:2525] with esmtp (Farcaster)
 id 581277a6-3f97-470a-9e99-74ee9cc1cd1f; Sat, 18 May 2024 12:55:09 +0000 (UTC)
X-Farcaster-Flow-ID: 581277a6-3f97-470a-9e99-74ee9cc1cd1f
Received: from EX19D002EUA004.ant.amazon.com (10.252.50.181) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 12:55:09 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002EUA004.ant.amazon.com (10.252.50.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Sat, 18 May 2024 12:55:09 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Sat, 18 May 2024 12:55:08
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id 1D19D20AC2; Sat, 18 May 2024 12:55:08 +0000 (UTC)
Date: Sat, 18 May 2024 12:55:08 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: Norbert Manthey <nmanthey@amazon.de>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <hagarhem@amazon.com>
Subject: Re: [PATCH] net: esp: cleanup esp_output_tail_tcp() in case of
 unsupported ESPINTCP
Message-ID: <20240518125508.GA9885@amazon.com>
References: <20240516080309.1872-1-hagarhem@amazon.com>
 <20240517122238.GE443576@kernel.org>
 <20240517131757.GA12613@amazon.com>
 <20240517155707.GG443576@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240517155707.GG443576@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 17, 2024 at 04:57:07PM +0100, Simon Horman wrote:
> On Fri, May 17, 2024 at 01:17:57PM +0000, Hagar Hemdan wrote:
> > On Fri, May 17, 2024 at 01:22:38PM +0100, Simon Horman wrote:
> > > On Thu, May 16, 2024 at 08:03:09AM +0000, Hagar Hemdan wrote:
> > > > xmit() functions should consume skb or return error codes in error
> > > > paths.
> > > > When the configuration "CONFIG_INET_ESPINTCP" is not used, the
> > > > implementation of the function "esp_output_tail_tcp" violates this rule.
> > > > The function frees the skb and returns the error code.
> > > > This change removes the kfree_skb from both functions, for both
> > > > esp4 and esp6.
> > > > 
> > > > This should not be reachable in the current code, so this change is just
> > > > a cleanup.
> > > > 
> > > > This bug was discovered and resolved using Coverity Static Analysis
> > > > Security Testing (SAST) by Synopsys, Inc.
> > > > 
> > > > Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> > > > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> > > 
> > > Hi Hagar,
> > > 
> > > If esp_output() may be the x->type->output callback called from esp_output()
> 
> Hi Hagar,
> 
> FTR, I meant to say "If ... called from xfrm_output_one()",
> but I don't think that effects the direction of the conversation
> at this point.
> 
> > > then I agree that this seems to be a problem as it looks like a double free
> > > may occur.
> > > 
> > > However, I believe that your proposed fix introduces will result in skb
> > > being leaked leak in the case of esp_output_done() calling
> > > esp_output_tail_tcp(). Perhaps a solution is for esp_output_done()
> > > to free the skb if esp_output_tail_tcp() fails.
> > > 
> > > I did not analyse other call-chains, but I think such analysis is needed.
> > > 
> > > ...
> > Hi Simon,
> > 
> > I see all calls to esp_output_tail_tcp() is surrounded by the condition
> > "x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP" which I see
> > it is related to enabling of CONFIG_INET_ESPINTCP configuration 
> > (introduced in this commit e27cca96cd68 ("xfrm: add espintcp (RFC 8229)").
> > 
> > For calling of x->type->output (resolved to esp_output()) in
> > xfrm_output_one(), I see there is no double free here as esp_output()
> > calls esp_output_tail() which calls esp_output_tail_tcp() only if 
> > x->encap->encap_type == TCP_ENCAP_ESPINTCP which points to the first 
> > implementation of esp_output_tail_tcp(). This first definition 
> > doesn't free skb.
> > 
> > So my understanding is the 2nd esp_output_tail_tcp() should not be
> > called and this is why I called WARN_ON() as this func is unreachable.
> > Removing free(skb) here is just for silencing double free Coverity 
> > false positive.
> > Is there something else I miss?
> 
> Thanks, I missed the important detail that calls to esp_output_tail_tcp()
> are guarded by "x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP".
> 
> Assuming that condition is always false if CONFIG_INET_ESPINTCP is not set,
> then I agree with your analysis and I don't see any problems with your
> patch.
> 
> It might be worth calling out in the commit message that the WARN_ON
> is added because esp_output_tail_tcp() should never be called if
> CONFIG_INET_ESPINTCP is not set.

Hi Simon,

Thanks. yes, I will update the commit msg in rev2.

