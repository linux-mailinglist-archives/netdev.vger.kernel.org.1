Return-Path: <netdev+bounces-44501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB177D8504
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4DC1C20F3E
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9B92EAF9;
	Thu, 26 Oct 2023 14:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF7ufj5M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27602EAF1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 14:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F5FC433C8;
	Thu, 26 Oct 2023 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698331496;
	bh=cHHlxSDS/KB9AboQcfw5aoNzZSQbx4Wy8Hiz7M3HW9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uF7ufj5Ma49kO7XhqisyeJRLWupMwP1a6BUkFV5j3B90dZm7fXPYlDsubYR6ReGju
	 ei47gxcs3yrcudnAdFEwbZMad6GjXyWUzIrxr5s63ZBhwgwCkDJgKRyvaQCRk8k9yh
	 4wEz+uiIjZ7ap2B+fStn7HfVbs4gtn+1U0KUl6bFl3tA4fvDQ+MkMykr+P9QyKHkz3
	 D77KC7ORJfpKnzuhouhnEfwuJuL67x1K3euvqkQqgDWIDW57KSJEJmfvTQpe1vmL6O
	 eitybu9hQKYTf44Eg/JLRWwJTq5nVSg3YN8qHRsEBnjlntv9ZjQVQbgG6p2RZ9ic2w
	 MqCm3S8XrbSFg==
Date: Thu, 26 Oct 2023 07:44:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Haseeb Gani
 <hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
 "egallen@redhat.com" <egallen@redhat.com>, "mschmidt@redhat.com"
 <mschmidt@redhat.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "horms@kernel.org" <horms@kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "wizhao@redhat.com" <wizhao@redhat.com>,
 "konguyen@redhat.com" <konguyen@redhat.com>, Veerasenareddy Burru
 <vburru@marvell.com>, Sathesh B Edara <sedara@marvell.com>, Eric Dumazet
 <edumazet@google.com>
Subject: Re: [EXT] Re: [PATCH net-next v2 3/4] octeon_ep: implement
 xmit_more in transmit
Message-ID: <20231026074454.767a8a2f@kernel.org>
In-Reply-To: <PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20231024145119.2366588-1-srasheed@marvell.com>
	<20231024145119.2366588-4-srasheed@marvell.com>
	<20231024172151.5fd1b29a@kernel.org>
	<PH0PR18MB473482180622D7C163B487ADC7DDA@PH0PR18MB4734.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Oct 2023 07:57:54 +0000 Shinas Rasheed wrote:
> >The recommended way of implementing 'driver flow control'  
> is to stop the queue once next packet may not fit, and then use
> netif_xmit_stopped() when deciding whether we need to flush or we can
> trust xmit_more. see 
> https://urldefense.proofpoint.com/v2/url?u=https-3A__www.kernel.org_doc_html_next_networking_driver.html-23transmit-2Dpath-2Dguidelines&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=1OxLD4y-oxrlgQ1rjXgWtmLz1pnaDjD96sDq-cKUwK4&m=FyJHTb5Z2u9DTFSYPU38S5kPcP5KvwGWzY-DPcqOl1gdnm7ToZhTFpyvhLMqh1hd&s=dBMmwfWKAi0UH3nrz7j9kYnAodDjuN3LZ5tC2aL_Prs&e= 
> 
> >> In the skeleton code above, as I understand each tx desc holds a skb frag and hence there can be possibility of receiving a full-sized skb, stopping the queue but on receiving another normal skb we should observe our queue to be stopped. This doesn't arise in our case as even if the skb is full-sized, it will only use a single tx descriptor so we can be sure if queue has been stopped, the write index will only be updated once posted (and read) tx descriptors are processed in napi context and queues awoken.  
> 
> Please correct me if I'm wrong anywhere (sorry if so) to further my understanding, and again thanks for your time!

Could you please do some training on how to use normal / mailing list
style email at Marvell? Multiple people from Marvell can't quote
replies correctly, it makes it hard to have a conversation and help
y'all.

