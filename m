Return-Path: <netdev+bounces-99660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5E48D5B3F
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 352AD282C9A
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF00C17E9;
	Fri, 31 May 2024 07:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="pvc02RBF"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BB1103
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 07:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717139439; cv=none; b=TbgSNTRnjl9WnhT/xtoaO2CQtm1bePvPlrsi8akv9Es/lqHfdzlPSrhDBHrgIBU2Bs4Ml4oeVhcIBy6P1qXdTtSxN4dU4pXYKB3RQGtNxxNumqBhN1pAE59fILuEbP1GbVM3ZeyiFzlAdEB87/sfP7T7dKblMC0IIL2F1sbWyGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717139439; c=relaxed/simple;
	bh=TLYQ0oEs1QTSohY5kYuPCAc8yu9mFrhzKPa5nggoFDw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t94GtWT1UGTvo6d2gUQawAGaKdm/u2MqaIo4EAv4YfONyanS0WQnY//2+vTtgqVsWTwYVcISVPRpBmrYJ9mIeuzcO/MUclerURSzWhT9AG2Ta6f5lQVF8nIh9PQCpXGaCUqdZcNQ/IIpiqvS4tLk3QcXHFfcNNcIKTUX8D03S8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=pvc02RBF; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 78FD220897;
	Fri, 31 May 2024 09:10:34 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QY5v3XCLXFlL; Fri, 31 May 2024 09:10:33 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 26CC5207BB;
	Fri, 31 May 2024 09:10:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 26CC5207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1717139433;
	bh=x44p7PJM+Vw/jw5bXrIe+vLqbEHy7J3YFdQhJI0VOK8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=pvc02RBFdyRbpgGELRC/Dypf7u3grYZ/e6ldM7OyZVpgSD82fWbxMa6ATKDFN3v1W
	 i6Qeta/aRpkNAgzRJOX2IqTQDx7w2A86e7q3L7icTMOgj06bvQ60RH/Bg67yIqRA2o
	 v7J5jFPOWbMQmvAvjG0lXdKhQvB4uWGNgcOOCJ5uDx9Fh6ijKwLSoEAlcboyLv8sST
	 TSR4Jsvm29mFGPB0sHsELClN9aBrlO53HmDUBuxv1xRkJfaQWqx6iOLy0f213aWqtO
	 cQ56Cc0EkAfVaM7XORsfGmqq8W9gKTB5vhF2VHewUKv6uGaoyeyqqCDUIuAzQcYoXU
	 lJKnG2Kbyt2wA==
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 196EC80004A;
	Fri, 31 May 2024 09:10:33 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 May 2024 09:10:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 May
 2024 09:10:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 62A0B3181AF3; Fri, 31 May 2024 09:10:32 +0200 (CEST)
Date: Fri, 31 May 2024 09:10:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Eyal Birger <eyal.birger@gmail.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <herbert@gondor.apana.org.au>,
	<pablo@netfilter.org>, <paul.wouters@aiven.io>, <nharold@google.com>,
	<mcr@sandelman.ca>, <devel@linux-ipsec.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec-next,v4] xfrm: support sending NAT keepalives in
 ESP in UDP states
Message-ID: <Zll36DEoF5QfV9dr@gauss3.secunet.de>
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
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, May 27, 2024 at 08:29:14PM -0700, Eyal Birger wrote:
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

Paul, you said you wanted to test this, if I remember correct.
Do you still plan to do a test?


