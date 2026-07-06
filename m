Return-Path: <netdev+bounces-304886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bXwHN4FeS2oAQQEAu9opvQ
	(envelope-from <netdev+bounces-304886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6860F70DC79
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 09:51:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=tu-dortmund.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304886-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304886-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BA013257190
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 07:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DE4963B2;
	Mon,  6 Jul 2026 06:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9814A1399;
	Mon,  6 Jul 2026 06:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320631; cv=none; b=BeW26ykjgQp3KixJLyfI2aSdOkRPJjfQ6T3er1/Lj4Zk7Nv0T0g2RJjQe9oFIxpKrlyqqE5/2jugGo4OlZ/4QADqOpjlf8u1lv3GhpWOqK4XiyzGjwvDC8dnbZJvQ+ZPSEki5rom3mE1x6YLL9AufG3/vizji+LzyKZlSNvrc5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320631; c=relaxed/simple;
	bh=wn//s5w0hgs6ufiyHhdXrTuz3iRrO5q24YE9mr2oCEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHDD6WcttwOedwvypXsQoAon0/FGsr6/Qqa1JOnh0W8k2aBJAWEgsDZK0qMTVTbmiDqRfpbDypFCVY8zow+jxJRaJJRY9EuzZ+A52bVzEZ5YI0ViFrgkxcloDscXNO2sKJm8ZuF7KKsaZR89uPrkcJShduEdnfA3ybibJIAUqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6666ksni005709
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 Jul 2026 08:46:55 +0200 (CEST)
Message-ID: <f6d454f2-06d2-4296-b6c8-5de4972552fe@tu-dortmund.de>
Date: Mon, 6 Jul 2026 08:46:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tun/tap & vhost-net: make qdisc backpressure opt-in
 via IFF_BACKPRESSURE
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[tu-dortmund.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:brett@librecast.net,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-304886-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:mid,tu-dortmund.de:from_mime,vger.kernel.org:from_smtp,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6860F70DC79

On 7/4/26 13:20, Simon Schippers wrote:
> @@ -2893,8 +2899,19 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
>  	/* Make sure persistent devices do not get stuck in
>  	 * xoff state.
>  	 */
> -	if (netif_running(tun->dev))
> -		netif_tx_wake_all_queues(tun->dev);
> +	if (netif_running(tun->dev)) {
> +		for (int i = 0; i < tun->numqueues; i++) {
> +			struct tun_file *i_tfile;
> +
> +			i_tfile = rtnl_dereference(tun->tfiles[i]);
> +			spin_lock_bh(&i_tfile->tx_ring.consumer_lock);
> +			spin_lock(&i_tfile->tx_ring.producer_lock);
> +			netif_wake_subqueue(tun->dev, i_tfile->queue_index);
> +			i_tfile->cons_cnt = 0;
> +			spin_unlock(&i_tfile->tx_ring.producer_lock);
> +			spin_unlock_bh(&i_tfile->tx_ring.consumer_lock);
> +		}
> +	}

I think Sashiko [1] is right. I forgot to wake the disabled queues.

I will post a v2.

[1] Link: https://sashiko.dev/#/patchset/20260704112058.95421-1-simon.schippers%40tu-dortmund.de


