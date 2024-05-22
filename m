Return-Path: <netdev+bounces-97554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 154888CC1B9
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 15:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 477531C20D54
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100D213D61B;
	Wed, 22 May 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b="g457eROh"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nohats.ca (mx.nohats.ca [193.110.157.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84B8757FD
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.110.157.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716383078; cv=none; b=sKRyoK+kpPSkGoy/vDVQLgStmx+bKp3QoEbqFEZnzwNcDDqwYEJCbahxhUBTwglW/GODg9EouSAotdvJYEbDjjt11XCbQi1g2qjRYr6SGbM8Oyp/Xb5hkicR+sMWoKwOcOXm7nu1IE23DksPqcb8Xjh+4hfbGtpHydsn6FAZcGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716383078; c=relaxed/simple;
	bh=0JhWG8kiaWSPXwKKdbsl/tqGSTuvcshQkwZGQVrlR0w=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=U0yLGuL0Uad4hRzYUcT2gicv0r4g+SVP7yXTMndeC8AlyP/zQweEzPt4/HTewRaBmrPhNBkN3IU4ZLp4uZfBLhy9vdyZGIWPmoJe1XQkrkKMrrNHxo1rmtl0BvEJwWIBDFM4urhS7cTLMtUNerdEUudHt4P05XZuCckwwHecRx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca; spf=fail smtp.mailfrom=nohats.ca; dkim=pass (1024-bit key) header.d=nohats.ca header.i=@nohats.ca header.b=g457eROh; arc=none smtp.client-ip=193.110.157.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nohats.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nohats.ca
Received: from localhost (localhost [IPv6:::1])
	by mx.nohats.ca (Postfix) with ESMTP id 4Vkrs23YqBz3Sy;
	Wed, 22 May 2024 14:56:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nohats.ca;
	s=default; t=1716382566;
	bh=zS2fFkdXtszfXqnxlX+pgL6dxsuK3xqFir8xwQof6jk=;
	h=Date:From:To:cc:Subject;
	b=g457eROh6x4wArCT7UE9TSb5oYoICWPCqekLNiE7Sf9R1OHhH9GkAZc+olv8bmyNA
	 6i+WRH3JFwc4lqsCTwpi+H8tNsxoTkwOzhKvqaNNb2apSNesBINsSsO7BzpGhytiqM
	 tDdu/vw+KXqQmBAhsx8ZR2PbVZvH8n3a3CBP3Kl0=
X-Virus-Scanned: amavisd-new at mx.nohats.ca
X-Spam-Flag: NO
X-Spam-Score: 0.562
X-Spam-Level:
Received: from mx.nohats.ca ([IPv6:::1])
	by localhost (mx.nohats.ca [IPv6:::1]) (amavisd-new, port 10024)
	with ESMTP id A93JnplE56wJ; Wed, 22 May 2024 14:56:04 +0200 (CEST)
Received: from bofh.nohats.ca (bofh.nohats.ca [193.110.157.194])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx.nohats.ca (Postfix) with ESMTPS;
	Wed, 22 May 2024 14:56:04 +0200 (CEST)
Received: by bofh.nohats.ca (Postfix, from userid 1000)
	id C521211FEAB3; Wed, 22 May 2024 08:56:03 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by bofh.nohats.ca (Postfix) with ESMTP id C19B711FEAB2;
	Wed, 22 May 2024 08:56:03 -0400 (EDT)
Date: Wed, 22 May 2024 08:56:02 -0400 (EDT)
From: Paul Wouters <paul@nohats.ca>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
cc: pabeni@redhat.com, willemdebruijn.kernel@gmail.com, borisp@nvidia.com, 
    gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com, 
    Steffen Klassert <steffen.klassert@secunet.com>, tariqt@nvidia.com, 
    Jakub Kicinski <kuba@kernel.org>
Subject: Re: [RFC net-next 00/15] add basic PSP encryption for TCP
 connections
Message-ID: <1da873f4-7d9b-1bb3-0c44-0c04923bf3ab@nohats.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Jakub Kicinski wrote:

> Add support for PSP encryption of TCP connections.
> 
> PSP is a protocol out of Google:
> https://github.com/google/psp/blob/main/doc/PSP_Arch_Spec.pdf
> which shares some similarities with IPsec. I added some more info
> in the first patch so I'll keep it short here.

Speaking as an IETF contributor, I am little surprised here. I know
the google people reached out at IETF and were told their stuff is
so similar to IPsec, maybe they should talk to the IPsecME Working
Group. There, I believe Steffen Klassert started working on supporting
the PSP features requested using updates to the ESP/WESP IPsec protocol,
such as support for encryption offset to reveal protocol/ports for
routing encrypted traffic.

It is not very useful to add more very similar encryption techniques to
the kernel. It scatters development efforts and actually makes it harder
for people to use functionality by having to change to a whole new sub
system (and its configuration methods) just to get one different feature
of packet encryption.

> The protocol can work in multiple modes including tunneling.
> But I'm mostly interested in using it as TLS replacement because
> of its superior offload characteristics. So this patch does three
> things:

Is this issue related to draft-pismenny-tls-dtls-plaintext-sequence-number ?

https://datatracker.ietf.org/doc/draft-pismenny-tls-dtls-plaintext-sequence-number/

If so, then it seems it would be far better to re-engage the TLS WG to
see if instead of "having no interest, do it but elsewhere", we can
convince them to "there is interest, let's do it here at the TLS WG".
I could help with the latter.

Paul

