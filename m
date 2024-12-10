Return-Path: <netdev+bounces-150574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB039EABFF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 10:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D0C28BB14
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 09:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A5B3DABEB;
	Tue, 10 Dec 2024 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="CsvKRGEf"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08316238745
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822932; cv=none; b=Cna9LpTOYzO4j1zLPP5+aHiiQePrFFFqaXhQSQrQM6og55+V434JOpzbLFdI6/3Y3cp2ye37f3S0WfKox0qnHW9uiUgDTMIbDNvl6F4+xefhBEt+oi6CNl8Bf3A5n3luvJqoAoz0V2NKkJG/LmxJ+PbtnmC8lC02hd5BRYX75xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822932; c=relaxed/simple;
	bh=rSN1Tp/7L2ph4zvBpbC6czpaxx1pKMN11jmYzMvL7Ag=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SApPgoOU5if2zikVJgW+WXPLi3dUUeLHbE+5f4zjnjhCh/1Hm71X/N+1JoVmt+r2IiASEH5X9bOBa4xt1AUa1RWGOt8ST+ZSwiJiFlZ+hETvSrSCcr8QzQWNDtfAPaI3GqChpRcAMcmmg+N3GED+UzTY2C2afKrcVcDmt5YBipc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=CsvKRGEf; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 6D5E7207CA;
	Tue, 10 Dec 2024 10:28:41 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eHosSaCoZBNT; Tue, 10 Dec 2024 10:28:41 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E81C12065A;
	Tue, 10 Dec 2024 10:28:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E81C12065A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1733822920;
	bh=pKOCERCIKT/hcIJ/1u68klnZHBPqnO9wFT/Bw0M0xRs=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=CsvKRGEfuMzqzVaT1+eFGdMQ3k8/n2M5qG5gMkT89fdxoBrDf5PS8mwhvIq0gnL7s
	 5wjIeEtP5wbnD8G1IGIcjhqI8FSSSQH2l/m2e9BvNyg97YXFV9d3A/9WRzDicJc+fL
	 mHyA1oYsP+uKYSS1hPh+8f+obgpkKeNGZsEpBhtHohrZOFDS/MSy7KJTMFss9eLafz
	 Ux6KF+PLSUg2o11aWoAvK5I8Xv9NFQx3ka9GF4OaQqTH9PL57JCuyURahvJduwTzIT
	 KVvIgo2sJV5CQ5o62iMQVX39GPtNhb63eyh5TKBbw5hHdb8yVXuW0bUshNcDQTZhjt
	 BcPq0bjKO+xOg==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 10:28:40 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 10:28:40 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 60C3B3180DB9; Tue, 10 Dec 2024 10:28:40 +0100 (CET)
Date: Tue, 10 Dec 2024 10:28:40 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Feng Wang <wangfe@google.com>
CC: <netdev@vger.kernel.org>, <antony.antony@secunet.com>,
	<leonro@nvidia.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
Message-ID: <Z1gJyHRCmreRcx8h@gauss3.secunet.de>
References: <20241209202811.481441-2-wangfe@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241209202811.481441-2-wangfe@google.com>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Dec 09, 2024 at 08:28:12PM +0000, Feng Wang wrote:
>  
> +static int nsim_ipsec_add_policy(struct xfrm_policy *policy,
> +				 struct netlink_ext_ack *extack)
> +{
> +	return 0;
> +}

Returning 0 here is apparently wrong. If you want to add packet offload
support to nsim, you need to implement everything what a real packet
offload driver plus HW will do.

> @@ -728,7 +730,27 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
>  			kfree_skb(skb);
>  			return -EHOSTUNREACH;
>  		}
> +		if (x->if_id) {
> +			sp = secpath_set(skb);

secpath_set is expensive, this will slow down crypto offload
for no reason. This has to go to some driver specific
codepath.


