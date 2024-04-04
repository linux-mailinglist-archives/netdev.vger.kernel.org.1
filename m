Return-Path: <netdev+bounces-84907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E91898A02
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EE429236D
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7F912CDB2;
	Thu,  4 Apr 2024 14:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="KY0KY1Vi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lcXXYC8Y"
X-Original-To: netdev@vger.kernel.org
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB0912D75D
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 14:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712240577; cv=none; b=IDLruEc+kacRmwSRodVeCNDdDNxN4kiWJR7OcoPskOxYEcfLVg6GlzBt1bIxg9xV0bMloRJEyr2b9oKL89NnQNYlQbQa1pYuh0mPKgQo3LMQyYwWvtueWKAlZ6tWZGyjh4Oa+uNgKrgbvNhOiUfpRKYHj7nrrVADNo1l49Ka3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712240577; c=relaxed/simple;
	bh=KvV8i2mza6Xrm9xeRfr9wFUfejI2n2epPX3YKNIYjTw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=J1qHQc86DDokZZrINb546jIQxpaEqWnNIFYlljjRfSRbmL06jAPRw/+gFtBcZAbhcPyulBuEt28CeEpx32YH7WHYxHBOUl0uLy8lAUtqU8oviEey6Fcgw+u18uYQmrozhpBMYrJnviaouwwYXO/stwSgEgasV0aPIhJhIR3//yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=KY0KY1Vi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lcXXYC8Y; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7C90F1800194;
	Thu,  4 Apr 2024 10:22:54 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 10:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712240574; x=1712326974; bh=XAU2F/1ezQ
	3YAWEhYcCTWS9VTOQJPd0Y6O6MZHkcBc8=; b=KY0KY1Vi2hJVsQ4C2l97igIlRT
	3sC5tVtgXqGpJJx565N+p6sjQ07f/iIzDr0WFHHjv9hkbHXyeEg4/bL7CeSCe1w/
	k1BZHIR7zZ9jTxubGj+O4go5NT3T688UX5SF/bbZCULWtwZfsm08RN7FC363fngt
	DJfVeTm+gr1/D2bga2smjVVG6817FgbHM+oaZFz9COcJ3GFmSnIXMuoc1x1QbpNW
	s8h++Dum+ZmGkvsbN/9SvPTehT/5XS8HbLahAG9v2sqE6EmAOPAvlB5taQogQDry
	PqdYGF+/jL6bTygbHMFZ/oYCkdS4Jr8+i8LI5naOGxgLm8I0wXcIhdiLdS1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712240574; x=1712326974; bh=XAU2F/1ezQ3YAWEhYcCTWS9VTOQJ
	Pd0Y6O6MZHkcBc8=; b=lcXXYC8YV7lPmneMoZyQmJuYFdgXs9LMn8nwhc/pgCg6
	ZvMAQgvGHG7U43ejeOXNSeQplmEAOiBQwIzcPElJyczkYyATWq2S2xqX1DYhZz1P
	1nBknnIEcsFYTBnP+/ByrhF08LE2cwLrM7nKHfrkVC8GKXFdWmmixa7A1Fjw3qO4
	yypYel/BBwnYRST11LGmfvNd7fb7M5te22LfI9gPIU/8ttSrpxNPNxH90RNjb6fT
	gYekd115tyqu4XnMPRaripQ8+AT5jTmoZX66IWAHpk/0v2b4iCmyMymA+FvpduLC
	ym0h6VfjxGyIMzpBTaCbLXu57Y6EhZNkdfqtV32sng==
X-ME-Sender: <xms:vbcOZlQ7zl_EHI_Qe5w2m6HJN-janJgUsZXd2BBjtE1pVYQIlfC-BA>
    <xme:vbcOZuzWguXa-5v8M5M-ynr58rvfZF2sCFJF__sYSTonxNk82jWMj6ElPQZVvlwmX
    EbQdxnGtXvdeFfam2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:vbcOZq3ivQYp107V1q6_uPDGpagJY9EeRF5VRNaCTmVcy__nel5T9A>
    <xmx:vbcOZtBd4LrHMpgG4bPkV_Ddtzh-rylvZ4rRoyjBxOwFBGwKwJIeFA>
    <xmx:vbcOZuiV1D1e9scgtu9orAGR-EuO-65dEs_9iJ5gPyBU2fP9h4Sclw>
    <xmx:vbcOZhrg-DR9TDTdjaRDx_Xa8EJVSGwefVIpnp9QK56i8vwiYaoDGA>
    <xmx:vbcOZnXQDgCnBMjcSGQCBr_bRc7GLQl_xxo7zseYYpisQ2dXkAfsadE8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8D73DB6008F; Thu,  4 Apr 2024 10:22:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c5685daa-9962-4a43-af72-59c776a861d6@app.fastmail.com>
In-Reply-To: <Zg6yMB/3w4EBQVDm@mev-dev>
References: <20240404135721.647474-1-michal.swiatkowski@linux.intel.com>
 <Zg6yMB/3w4EBQVDm@mev-dev>
Date: Thu, 04 Apr 2024 16:22:32 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michal Swiatkowski" <michal.swiatkowski@linux.intel.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Cc: Netdev <netdev@vger.kernel.org>,
 "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: Re: [net-next v1] pfcp: avoid copy warning by simplifing code
Content-Type: text/plain

On Thu, Apr 4, 2024, at 15:59, Michal Swiatkowski wrote:
> On Thu, Apr 04, 2024 at 03:57:21PM +0200, Michal Swiatkowski wrote:
>>  		pfcp_node_recv(pfcp, skb, md);
>>  
>> -	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, flags);
>> -	ip_tunnel_info_opts_set(&tun_dst->u.tun_info, md, sizeof(*md),
>> -				flags);
>> +	__set_bit(IP_TUNNEL_PFCP_OPT_BIT, tun_dst->u.tun_info.key.tun_flags);
>> +	tun_dst->u.tun_info.options_len = sizeof(*md);
>>  
>>  	if (unlikely(iptunnel_pull_header(skb, PFCP_HLEN, skb->protocol,
>>  					  !net_eq(sock_net(sk),

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>

