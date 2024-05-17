Return-Path: <netdev+bounces-96958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312D8C8728
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 15:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43261C22EF6
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063F5102F;
	Fri, 17 May 2024 13:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g0crHxgN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFAD50A6D
	for <netdev@vger.kernel.org>; Fri, 17 May 2024 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951885; cv=none; b=lvKtjozXt0QsgdURV+s3ZrWiZ/z8fJD/dx4eDrJQGpvPoqCdbLqQ9CEyGcCsX4IeQPzrL1a1fOFLHTvVJuzgmedV7QcPxBcFdfhIZ4iUcCO3ujWms0Ib7gNy8KLnZnQrXlKqguQ1XzszE7HBGu+q1t3KDNHf8Y1YfsyTLgvueRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951885; c=relaxed/simple;
	bh=yx5udAj0FIQARDRWXfFKfpWOArLozQnHgWE/TVxriAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0vtZbC3HVOOjCDNMSgqCXt+K7wMKLOv5rCOxiPNOul3mFeTOyVFNgygUzqrvHw8WLOohNQTDbXLAeS/UwDhvGPxKu0nhr22ci5rWKpw87gI2XEmVDYSi9h3EubbW4CWUfb85TlLsIV+LBFXGznr/dLBRhMF49Q9hJ7pi8Q7EWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=g0crHxgN; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1715951884; x=1747487884;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NbXHnMBWr2j7rMFwzgwAvx3lRa4wjkb3+8fTmhx/HOg=;
  b=g0crHxgNJwiWGSNKb5aCMUeaLCX58JczCxUX3FA9MZh+ALAg0tzpBVod
   0zjM5VlBRc7WvsxxvZw68LIYAuqtdPMx5eSlVvaMy2SCT7B8FsOWBZ4T0
   9yC3j/DUAefeoS1rFHjqT2IQwRpv7lJCA7O0M63p1MjurOwLyUhKwqceg
   o=;
X-IronPort-AV: E=Sophos;i="6.08,167,1712620800"; 
   d="scan'208";a="397146354"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2024 13:18:01 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:60325]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.12.108:2525] with esmtp (Farcaster)
 id 67e13d9d-9422-4ad9-8d46-d6b07ad4e41d; Fri, 17 May 2024 13:17:59 +0000 (UTC)
X-Farcaster-Flow-ID: 67e13d9d-9422-4ad9-8d46-d6b07ad4e41d
Received: from EX19D002EUC004.ant.amazon.com (10.252.51.230) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 13:17:59 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D002EUC004.ant.amazon.com (10.252.51.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 17 May 2024 13:17:58 +0000
Received: from dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com
 (10.253.65.58) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server id 15.2.1258.28 via Frontend Transport; Fri, 17 May 2024 13:17:58
 +0000
Received: by dev-dsk-hagarhem-1b-b868d8d5.eu-west-1.amazon.com (Postfix, from userid 23002382)
	id C1FBD20D84; Fri, 17 May 2024 13:17:57 +0000 (UTC)
Date: Fri, 17 May 2024 13:17:57 +0000
From: Hagar Hemdan <hagarhem@amazon.com>
To: Simon Horman <horms@kernel.org>
CC: Norbert Manthey <nmanthey@amazon.de>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <hagarhem@amazon.de>
Subject: Re: [PATCH] net: esp: cleanup esp_output_tail_tcp() in case of
 unsupported ESPINTCP
Message-ID: <20240517131757.GA12613@amazon.com>
References: <20240516080309.1872-1-hagarhem@amazon.com>
 <20240517122238.GE443576@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240517122238.GE443576@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, May 17, 2024 at 01:22:38PM +0100, Simon Horman wrote:
> On Thu, May 16, 2024 at 08:03:09AM +0000, Hagar Hemdan wrote:
> > xmit() functions should consume skb or return error codes in error
> > paths.
> > When the configuration "CONFIG_INET_ESPINTCP" is not used, the
> > implementation of the function "esp_output_tail_tcp" violates this rule.
> > The function frees the skb and returns the error code.
> > This change removes the kfree_skb from both functions, for both
> > esp4 and esp6.
> > 
> > This should not be reachable in the current code, so this change is just
> > a cleanup.
> > 
> > This bug was discovered and resolved using Coverity Static Analysis
> > Security Testing (SAST) by Synopsys, Inc.
> > 
> > Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> > Signed-off-by: Hagar Hemdan <hagarhem@amazon.com>
> 
> Hi Hagar,
> 
> If esp_output() may be the x->type->output callback called from esp_output()
> then I agree that this seems to be a problem as it looks like a double free
> may occur.
> 
> However, I believe that your proposed fix introduces will result in skb
> being leaked leak in the case of esp_output_done() calling
> esp_output_tail_tcp(). Perhaps a solution is for esp_output_done()
> to free the skb if esp_output_tail_tcp() fails.
> 
> I did not analyse other call-chains, but I think such analysis is needed.
> 
> ...
Hi Simon,

I see all calls to esp_output_tail_tcp() is surrounded by the condition
"x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP" which I see
it is related to enabling of CONFIG_INET_ESPINTCP configuration 
(introduced in this commit e27cca96cd68 ("xfrm: add espintcp (RFC 8229)").

For calling of x->type->output (resolved to esp_output()) in
xfrm_output_one(), I see there is no double free here as esp_output()
calls esp_output_tail() which calls esp_output_tail_tcp() only if 
x->encap->encap_type == TCP_ENCAP_ESPINTCP which points to the first 
implementation of esp_output_tail_tcp(). This first definition 
doesn't free skb.

So my understanding is the 2nd esp_output_tail_tcp() should not be
called and this is why I called WARN_ON() as this func is unreachable.
Removing free(skb) here is just for silencing double free Coverity 
false positive.
Is there something else I miss?

