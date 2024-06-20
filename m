Return-Path: <netdev+bounces-105377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AE248910E5B
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 025E4B21976
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C231ABCB1;
	Thu, 20 Jun 2024 17:22:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46971A4F1D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904137; cv=none; b=Ucr1ul1XrVoTMptXQugMCHuUh+a1DpokhTQyzuoXH6AfyorIE0MykyBT2s+Zi60FN8rMw8hYbsQcSN9WoaDY9HZEZuscfCmv1/1If3V9QyA3TkzwnuNvriVN8p54QSln3w6UgizhuyvH5aY2A0YKqB4WI4+fW0OfL6qg2ONxFeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904137; c=relaxed/simple;
	bh=fflhweBhVf0+v8RzWg0NhrF2/RMV4BYoVW6DE3gBikI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SWrHRnryNMnC9YrdXjtv96XWdSIq8WkgxN1/dJ4SVmik96Kv++R2ihvBul4BpPmXHVwyNncjdsL7z1W0vvE3FSMVZd01RPkN9kDSFWCybfgBaoKpFi0M+qiuJ3pnOnZwnyZkUQwEzk8eIkBfr1zgsHxQUvq8YTBXFa3Y7Np7CeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=ovn.org; arc=none smtp.client-ip=217.70.178.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ovn.org
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
	by mslow1.mail.gandi.net (Postfix) with ESMTP id 764D1C1DAE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 17:14:27 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DCDEFF804;
	Thu, 20 Jun 2024 17:14:18 +0000 (UTC)
Message-ID: <89ce2aef-6ec4-4ab1-b180-f390188170f7@ovn.org>
Date: Thu, 20 Jun 2024 19:14:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, davem@davemloft.net, kuba@kernel.org,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>,
 Florian Westphal <fw@strlen.de>,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] openvswitch: get related ct labels from its master if
 it is not confirmed
To: Xin Long <lucien.xin@gmail.com>, network dev <netdev@vger.kernel.org>,
 dev@openvswitch.org
References: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GND-Sasl: i.maximets@ovn.org

On 6/20/24 00:08, Xin Long wrote:
> Ilya found a failure in running check-kernel tests with at_groups=144
> (144: conntrack - FTP SNAT orig tuple) in OVS repo. After his further
> investigation, the root cause is that the labels sent to userspace
> for related ct are incorrect.
> 
> The labels for unconfirmed related ct should use its master's labels.
> However, the changes made in commit 8c8b73320805 ("openvswitch: set
> IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
> led to getting labels from this related ct.
> 
> So fix it in ovs_ct_get_labels() by changing to copy labels from its
> master ct if it is a unconfirmed related ct. Note that there is no
> fix needed for ct->mark, as it was already copied from its master
> ct for related ct in init_conntrack().
> 
> Fixes: 8c8b73320805 ("openvswitch: set IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
> Reported-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  net/openvswitch/conntrack.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
> index 331730fd3580..920e802ff01e 100644
> --- a/net/openvswitch/conntrack.c
> +++ b/net/openvswitch/conntrack.c
> @@ -167,8 +167,13 @@ static u32 ovs_ct_get_mark(const struct nf_conn *ct)
>  static void ovs_ct_get_labels(const struct nf_conn *ct,
>  			      struct ovs_key_ct_labels *labels)
>  {
> -	struct nf_conn_labels *cl = ct ? nf_ct_labels_find(ct) : NULL;
> +	struct nf_conn_labels *cl = NULL;
>  
> +	if (ct) {
> +		if (ct->master && !nf_ct_is_confirmed(ct))
> +			ct = ct->master;
> +		cl = nf_ct_labels_find(ct);
> +	}
>  	if (cl)
>  		memcpy(labels, cl->bits, OVS_CT_LABELS_LEN);
>  	else

Thanks, Xin!  LGTM.

Tested with OVS testsuite and it works fine.  Also re-checked OVN
system tests and they also work as expected.

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Tested-by: Ilya Maximets <i.maximets@ovn.org>

