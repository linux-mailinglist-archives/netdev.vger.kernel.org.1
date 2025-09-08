Return-Path: <netdev+bounces-220835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A084B49054
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9533162BB1
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D680830DD1D;
	Mon,  8 Sep 2025 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="bbB/Pwx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiczgfT8"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B33112BB
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339372; cv=none; b=oqKLP26k/cmu3+fuliaUx2V+aod/pjlIAKxEvy3VHLj/rfB4PyZ5jRE2bB8TVSlzrGeIrdj1YqYDT7/ODLMt+UDh65x97f8K65dtthVtYHrTluV7GlF+EbLmNFaLx+dLAxGJB1kjPgAQ0MJYYNdM+UhnSjUMxh+qsUDl8QMd8bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339372; c=relaxed/simple;
	bh=pU8hxK14b7VOs9c05p0BS/LF2mKEeQT6Do4KU6h4fco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArsYJxEILdbR9OnTqssWmkW65InbHNt9TPrSrKTCbhSDaCo7tHcS0aMtVgSpI4RBBFftddErs5BTJXobrwWIGEb2Jqy+qr6R/10DiQ1nhAFTOdBbEniGEgX792LCXc43/wCibSpUQLYSW0ZM2uGoWQ8I3Y3cdgL+n2nGeT6l2uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=bbB/Pwx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiczgfT8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D6591D0013A;
	Mon,  8 Sep 2025 09:49:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 09:49:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757339368; x=
	1757425768; bh=8WdeMzW0DZFnQ5L78oCeYFJFNMPS6hM1Et77lK5M8B4=; b=b
	bB/Pwx5IwbUIUzW3AZPNsfvB1L4yPFHo8z73e4kKce0v9Vgl16ex/LBs4qI9qVkz
	L5XYIjyjdVjV/sVSn5FN5Uby8ZjAdJmqovyiT8d+XjG0RLZQcmTLGdeJG7A7xVMz
	ULkWm2WoTXvjGcPhbizQkrEfwzXsBcDBAxNbZGo0PXhle/HD2ZzvQJNW0byhiHS7
	3FIRnqgdBe5BAzxT7tCRczSLpl24Naq8AqkfaXWqZQs2LVoosQlMQkJoGWl0gKoe
	2MkchZsqiLUBPfXY1kRmV/v+WYEnAOjQF09sxgAnxz4oa7NjKQ+Qm2w0sHB3V1Xm
	DsrCMXpBcWBQjaW2+WCRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757339368; x=1757425768; bh=8WdeMzW0DZFnQ5L78oCeYFJFNMPS6hM1Et7
	7lK5M8B4=; b=KiczgfT8GK8x/i6SZTRApX2jTmgqjGb4n09pVFs48ANcON+wHcT
	rvqVxZ93u3WXfogVhlmqiiQBN7LNOVAeHEQA4rILX8fV6ZU+IFZUBeSGAcq8E+R/
	HQnF49maFwekRpubHEWhizSgz+6ybOux8L9KPh+Hji6aih56794kUZodmc9GMqBc
	UdULH1qjf50nXmxCcAUe878xtsIJcHu5U1NVbwDK36CFC5lsfdpxJoA9ernPvt2Y
	IcCPJy3Rq/RyHBunAq3T5g7YCr9jp4zu+DUE1S1+V9ElshOOSzAyr+ST7XgCdXWc
	iCEKjXh23VfQo4JZA+ScZJdkdlcaqpwwKHg==
X-ME-Sender: <xms:596-aM_gtATuahbtuBuGOmYKkAdYiRuRtYpZEQ3QZ8v5jU7jVfLipw>
    <xme:596-aAbrd7dvWFTVnUgV-9AuIDBfCJcISP4G8sHNtxEdeHv9o-msg_vocLCUjsI4d
    5OJvvShWwGED-LXzHk>
X-ME-Received: <xmr:596-aOd2M-kRnaDKiTPYrB99_ecN9miUeCQdgWprweJo7OMojV3EaG36aGaq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepuddtpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthho
    pehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhh
    grthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphht
    thhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmihgvrd
    gsrghinhgsrhhiughgvgesghhmrghilhdrtghomhdprhgtphhtthhopehrrgifrghlrdgr
    sghhihhshhgvkhelvdesghhmrghilhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:596-aFkCz9KLt7dgTNLQBhgg7P4QnaLntClp7LKGHmOjHyeY5K58ZA>
    <xmx:596-aG1tTu-SlidCEFQG39JoZmT-tKkjZM2W4UrKkdNN9AcfYVprvQ>
    <xmx:596-aGfu8FTi-1JvqoddLwancb0ee3Rt1-273KoiyVkInRiUoACTyg>
    <xmx:596-aIYcLHyiOyNSJPVmQld0CZZdcTU2HtaUYtqWz5JmjP870s1U_g>
    <xmx:6N6-aIgNbwA-EsnoSQFNC9a5LlclGL3RMF5MuidslLKNTVaCaHOs5ECW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 09:49:27 -0400 (EDT)
Date: Mon, 8 Sep 2025 15:49:25 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Abhishek Rawal <rawal.abhishek92@gmail.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 1/9] ipv6: snmp: remove icmp6type2name[]
Message-ID: <aL7e5R0ZexuevTcF@krikkit>
References: <20250905165813.1470708-1-edumazet@google.com>
 <20250905165813.1470708-2-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250905165813.1470708-2-edumazet@google.com>

2025-09-05, 16:58:05 +0000, Eric Dumazet wrote:
> This 2KB array can be replaced by a switch() to save space.
> 
> Before:
> $ size net/ipv6/proc.o
>    text	   data	    bss	    dec	    hex	filename
>    6410	    624	      0	   7034	   1b7a	net/ipv6/proc.o
> 
> After:
> $ size net/ipv6/proc.o
>    text	   data	    bss	    dec	    hex	filename
>    5516	    592	      0	   6108	   17dc	net/ipv6/proc.o
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv6/proc.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

