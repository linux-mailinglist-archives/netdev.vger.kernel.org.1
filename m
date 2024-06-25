Return-Path: <netdev+bounces-106433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E43891652F
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF641C2130A
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0F5149C61;
	Tue, 25 Jun 2024 10:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="oBzMNycY"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6518146A67
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310903; cv=none; b=USaFVwAXT1QntkfY6W3mNq+GUiHPrur6dBuou2L5bJvybrF4FknSnVcJFaig37RG07rXYB0X6lM/6su2TZy6pwp5+AlH4uiHBCbvFtBpy7CqUxfmTA26zFdpEs2IGCYbJGHi7/mu/+aZUCoUEcGIIe60s2UhPntyLz1oPjd0L9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310903; c=relaxed/simple;
	bh=PstR7eSg4FQj4j32k7xHIKtAKslYFWHQmxktfaqcoPA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4FE+rkc1xuSSLoQUQUdNfRGHjE4L9ZFLj4t1EN6UzYSXxg4vqVXsa2aLaFvxuyC8+bNODGVJuM8Wg0dftcOxQx2S5AjwNz+HqyNAKeo5vl6Wx/BgYaZlq+sxtW0hXx+NT2oIdIZMXD7jtQCMWxV5IQHzGZcammgwdEpBSPc6rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=oBzMNycY; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id ACD0120612;
	Tue, 25 Jun 2024 12:21:31 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FbHt7qULNDLe; Tue, 25 Jun 2024 12:21:31 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 1ECDB205ED;
	Tue, 25 Jun 2024 12:21:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 1ECDB205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1719310891;
	bh=ELtTUT8QjQWQc+aaQpx3XlZkpXh6EBil2vozNpQCXRs=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=oBzMNycYa79N2DdXkNJ36xp7gBixpMiGFWYB+4yeoxP1yxID61ILWn+Pm9wYlegy6
	 S/Ay+i82nbB6JBr2qYVMqtnGApfuWPI9eSy73PJ5egZUY5wKBCF4Xr+Y26dt4OKIWv
	 FX2yCf0H4DT1gDsmMlMuDj/n8TlRv++wLvK+H9AXPbAIBStUol0y7K6g/gjL5ezxoX
	 29xUXHnk4vpF8qCzi+MIfCqHvNj59x7l2IFlITh2c1f091ag7sP8nM4QsJqJ0ubHyq
	 WvgqIsFndy1FDyWSUvjeWdAHi49WS4hUdtgEGyTtkRZdUpQBvgJazXd6MUj0pfqS/c
	 C/w5KZR5LAKkw==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id 17DBA80004A;
	Tue, 25 Jun 2024 12:21:31 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 12:21:30 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 12:21:30 +0200
Date: Tue, 25 Jun 2024 12:21:28 +0200
From: Antony Antony <antony.antony@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <pablo@netfilter.org>,
	<paul.wouters@aiven.io>, <nharold@google.com>, <mcr@sandelman.ca>,
	<devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [devel-ipsec] [PATCH ipsec-next, v4] xfrm: support sending NAT
 keepalives in ESP in UDP states
Message-ID: <ZnqaKO2Mz/ZR6sNT@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <20240528032914.2551267-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240528032914.2551267-1-eyal.birger@gmail.com>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, May 27, 2024 at 20:29:14 -0700, Eyal Birger via Devel wrote:
> Add the ability to send out RFC-3948 NAT keepalives from the xfrm stack.
> 
> To use, Userspace sets an XFRM_NAT_KEEPALIVE_INTERVAL integer property when
> creating XFRM outbound states which denotes the number of seconds between
> keepalive messages.
> 
> Keepalive messages are sent from a per net delayed work which iterates over
> the xfrm states. The logic is guarded by the xfrm state spinlock due to the
> xfrm state walk iterator.
> 
> Possible future enhancements:
> 
> - Adding counters to keep track of sent keepalives.
> - deduplicate NAT keepalives between states sharing the same nat keepalive
>   parameters.
> - provisioning hardware offloads for devices capable of implementing this.
> - revise xfrm state list to use an rcu list in order to avoid running this
>   under spinlock.
> 
> Suggested-by: Paul Wouters <paul.wouters@aiven.io>
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>

Tested-by: Antony Antony <antony.antony@secunet.com>

thanks,
-antony

