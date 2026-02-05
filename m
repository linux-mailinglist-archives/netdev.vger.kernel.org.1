Return-Path: <netdev+bounces-257250-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMxOF8DFhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257250-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:30:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8908AF541E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BFFC300826A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035343C043;
	Thu,  5 Feb 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EDaoZY9U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBJjBV+m"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D27439017;
	Thu,  5 Feb 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309048; cv=none; b=EhABOhexOALm5J9DbZtaDb8qThsbzNgDfbPFaozJiOTBCKVG7jgml8MpBhZxztQPI7DA2OXdpv/QtDQ4CH7erZ3YHC2+WY0Xxrz+yFzNPkHl4xtxv4gK2wJSUsrUsdvZViSI9+fF6TvXdDHEXoQYzk5Yw5wqTbmbrMvy2lGpv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309048; c=relaxed/simple;
	bh=b/RK4YfEJ6LjRYGG3D8XpalGo1fhHhQPL3nV/WNEyvQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gffWA+rRrW41F4dHdkAuADy1C8TsRLsdDIWMEOOKFgJsgiETiqlZZeSdZkgvoziBI0FOY+qJlrZXhnrb1RrGNTrg/9E6R+71Am8U2OJyBmj46Enc5sXvLaqIyWi7Wpyi1zcqxQorPksr8kySwSKRzRbwFz5x6/jATpjS0zgYy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EDaoZY9U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBJjBV+m; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2C707A00D1;
	Thu,  5 Feb 2026 11:30:46 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Thu, 05 Feb 2026 11:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770309046;
	 x=1770395446; bh=RTt5sALSq/4lsSaUmu+ztCimXVGv2aIpBOPi+eTIUSY=; b=
	EDaoZY9U/vNZh9s+3zSHiUpOQCqlemeDtNUDJ7h3WAFq7qdgZqLW1OHKoNdKD+pC
	rmQQHMUOtTrcSeLZHKwrJa47DnizV4iiu/B+BY9rzygejckjqNG2AwSwIhJ/NYP/
	IgAXUjsS0/qNFaxRgUoVCWYaadM873rs7jzCau0vrSwDdBN7og9G0UOeyVjvTPSg
	4ymoYzfV5YWU6Fb/CL8WGj1ZmcbZzGTYJ71cVXRxZQknJY5rbW3BEYzKmzLD0bzz
	tYLIK88JtqbxGrAlw2JCJ6T8uC3dZPWzHQaXFEOPBJpl7bYcxaqVfy15ELLbZ5H8
	pEhaGNitFB3aD21MsLO2Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770309046; x=
	1770395446; bh=RTt5sALSq/4lsSaUmu+ztCimXVGv2aIpBOPi+eTIUSY=; b=t
	BJjBV+mh42ZSa9EJ/LgdJ4NIDBRbGqL65ZR3o6O3EI4krVAECiqceOyLgi1odkgs
	bKOAjwHsjlcpVC1nrlaJPQLNEvtrunJbFuKLmuZBuyeEcIyc/3vZehQ47uEyLZul
	6roMVPKePkfNBkzKOoSHGEmkSBRi6m0JX1amZQN5GKQQPNTPFwGHzF6IEuuLDBQu
	loBFOX0wFlrHADrm0ukiLe+IF/biXDs/gRhnkYwdWaDSQgvVI5NyoZX177eUihZW
	0JBfkHZwlqfN6dSj/nhqXICwGz3N/JHXpN3TMOjysg7A5Tyo/c99Bz8NTq+4elrn
	3HbOBDygnU45uuw16Jizw==
X-ME-Sender: <xms:sMWEaVD_uAxHldqhQB4EJT7l7YmPoxuqu5E7jXRBKUofv7ObHrTE1Q>
    <xme:sMWEaeVodTmN27F3PESONkjjYwLLWYYe7YNHmMqrgvITHp8G-ePJo3dypqGH1j-eA
    FkR2hPd2dp0EGBHwEYZOU3-AOFI_CqhjGzu7ropLq-VoabFQrcFWqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeehjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehjvghffhesghgrrhiiihhkrdhorhhg
    pdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhiohhvrghnnhhi
    rdgtrggsihguughusehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepmhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehkvghrnh
    gvlhdrohhrgh
X-ME-Proxy: <xmx:sMWEaXHR8D9imz-E8hP3LtZTxtBarbAvOuz1kpMYjlcsHvUU5wraTA>
    <xmx:sMWEaZ4SlFs3ibLSVLjjLwcyEgGNV-EI9huLXqlP0qwZrhp53dJaVQ>
    <xmx:sMWEaStpv0gAuoCD9scir_zGcp76gcR_oDCh-U7E0Mx-zhq2sfgvhw>
    <xmx:sMWEaV-nJg-mi3g1ALTPjm0Ievw-1nZrfSCWDRjGERpvKQUkomm2kg>
    <xmx:tsWEaeVW_X_XG7ToecHUKNvyhsepp74lKzgdIaHzUd2AoE0eCMw8lI60>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A81AF700071; Thu,  5 Feb 2026 11:30:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Av9uZl4W_4Uo
Date: Thu, 05 Feb 2026 17:30:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Jeff Garzik" <jeff@garzik.org>, bhelgaas@google.com,
 "David S . Miller" <davem@davemloft.net>,
 "Thomas Gleixner" <tglx@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch,
 giovanni.cabiddu@intel.com, Netdev <netdev@vger.kernel.org>,
 gallatin@myri.com, brice@myri.com, "Ingo Molnar" <mingo@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Eric Dumazet" <edumazet@google.com>
Message-Id: <e561be10-ab09-41b6-8326-773ece90ac32@app.fastmail.com>
In-Reply-To: <20260205045743.2412516-1-kuba@kernel.org>
References: <20260203230501.832872-2-arnd@kernel.org>
 <20260205045743.2412516-1-kuba@kernel.org>
Subject: Re: [2/2,v3] myri10ge: avoid uninitialized variable use
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-257250-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.991];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 8908AF541E
X-Rspamd-Action: no action

On Thu, Feb 5, 2026, at 05:57, Jakub Kicinski wrote:
>> @@ -2238,6 +2250,8 @@ static int myri10ge_get_txrx(struct myri10ge_priv *mgp, int slice)
>>  	status = 0;
>>  	if (slice == 0 || (mgp->dev->real_num_tx_queues > 1)) {
>>  		cmd.data0 = slice;
>> +		cmd.data1 = 0;
>> +		cmd.data2 = 0;
>>  		status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SEND_OFFSET,
>>  					   &cmd, 0);
>>  		ss->tx.lanai = (struct mcp_kreq_ether_send __iomem *)
>>  			    (mgp->sram + cmd.data0);
>>  	}
>>  	cmd.data0 = slice;
>>  	status |= myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_SMALL_RX_OFFSET,
>>  				    &cmd, 0);
>
> The initialization of cmd.data1 and cmd.data2 is inside the conditional
> block. When slice > 0 and real_num_tx_queues <= 1, does the subsequent
> myri10ge_send_cmd() call for MXGEFW_CMD_GET_SMALL_RX_OFFSET use
> uninitialized data1/data2 values?
>
> Simon Horman pointed this out in his review of v2:
> https://lore.kernel.org/all/20250622162715.GA297140@horms.kernel.org/
>
> He provided a diff showing that the second cmd.data0 = slice assignment
> also needs cmd.data1 and cmd.data2 initialization. This feedback does
> not appear to have been addressed in v3.

Indeed, I thought I had addressed this, but somehow ended up
rebasing to an older version of my original patch. Sent v4 now.

     Arnd

