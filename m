Return-Path: <netdev+bounces-108224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF62D91E71D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 20:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A6BE1F25273
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C23316EB6D;
	Mon,  1 Jul 2024 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XECpPafA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C215AD9C
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857230; cv=none; b=UitUhRihVyZVNYrPyNOGV+PmBJAG18dY+T0368Eek9nLqA0Y+7X4EKTMNMOCpStknHgQn4jK1UbpFh0SU0WyEaDuVbxtu8+fPYJiCWO8Tc4VTjYzszt7sGbvtFPhQMz3bvlRBEINIUKPimRdU25nxXGISAX4bEjtQGsh7PMvGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857230; c=relaxed/simple;
	bh=PqCbUSD5Oyl86Q23YUElECRHeATmh6Zs2I/aT1Uqg+4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m5wy7V1HKuGU9tZJz2cBV8XMyYQRPrB+xuFg8ojQ3OP7oPlyu3ZGbtVuHxLZe83bHIt+fvJi/7h6rYRT+hNSmoKLefYmmIuq0CCOkIMhBEb7ra9JxsySLaOsgvVSpPgtWEsWS2fpyv6H7THQ922dJHSqnUsHmuhWiI0kqnsSnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XECpPafA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719857227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7Wk3J7M209SdEsOn3OM5BYDNTbN4sUJMhSJinPyYFE=;
	b=XECpPafAezqQccfMcEVW799MbLXaQKFuE3v561ruTG20bvLPisH8aLjTztCg3wjvlK8V9p
	V5bQ3O3moL+n1kFiT7ingSBWPY2iRuLEk7R6BvkIadPz31Ui5T1AZPtoGfnsoLvtHqogIi
	MpLmO998qQSpon3qzYhGWMGXdMNnY90=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-Phsk171ZOeGZlR3FunY5Pw-1; Mon,
 01 Jul 2024 14:07:03 -0400
X-MC-Unique: Phsk171ZOeGZlR3FunY5Pw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 298B819560B0;
	Mon,  1 Jul 2024 18:07:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.8.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 731923000229;
	Mon,  1 Jul 2024 18:06:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Ido Schimmel
 <idosch@nvidia.com>,  Jamal Hadi Salim <jhs@mojatatu.com>,  Cong Wang
 <xiyou.wangcong@gmail.com>,  Jiri Pirko <jiri@resnulli.us>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v7 02/10] net: sched: act_sample: add action
 cookie to sample
In-Reply-To: <20240630195740.1469727-3-amorenoz@redhat.com> (Adrian Moreno's
	message of "Sun, 30 Jun 2024 21:57:23 +0200")
References: <20240630195740.1469727-1-amorenoz@redhat.com>
	<20240630195740.1469727-3-amorenoz@redhat.com>
Date: Mon, 01 Jul 2024 14:06:55 -0400
Message-ID: <f7ty16lvveo.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Adrian Moreno <amorenoz@redhat.com> writes:

> If the action has a user_cookie, pass it along to the sample so it can
> be easily identified.
>
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

>  net/sched/act_sample.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/net/sched/act_sample.c b/net/sched/act_sample.c
> index a69b53d54039..2ceb4d141b71 100644
> --- a/net/sched/act_sample.c
> +++ b/net/sched/act_sample.c
> @@ -167,7 +167,9 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>  {
>  	struct tcf_sample *s = to_sample(a);
>  	struct psample_group *psample_group;
> +	u8 cookie_data[TC_COOKIE_MAX_SIZE];
>  	struct psample_metadata md = {};
> +	struct tc_cookie *user_cookie;
>  	int retval;
>  
>  	tcf_lastuse_update(&s->tcf_tm);
> @@ -189,6 +191,16 @@ TC_INDIRECT_SCOPE int tcf_sample_act(struct sk_buff *skb,
>  		if (skb_at_tc_ingress(skb) && tcf_sample_dev_ok_push(skb->dev))
>  			skb_push(skb, skb->mac_len);
>  
> +		rcu_read_lock();
> +		user_cookie = rcu_dereference(a->user_cookie);
> +		if (user_cookie) {
> +			memcpy(cookie_data, user_cookie->data,
> +			       user_cookie->len);
> +			md.user_cookie = cookie_data;
> +			md.user_cookie_len = user_cookie->len;
> +		}
> +		rcu_read_unlock();
> +
>  		md.trunc_size = s->truncate ? s->trunc_size : skb->len;
>  		psample_sample_packet(psample_group, skb, s->rate, &md);


