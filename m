Return-Path: <netdev+bounces-297877-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6JSdEq4VKmr6iQMAu9opvQ
	(envelope-from <netdev+bounces-297877-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:55:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8184566DB7D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 03:55:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=tbpY+li0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297877-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297877-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2047B30B2C1A
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 01:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8591523A99F;
	Thu, 11 Jun 2026 01:55:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874822E3F0;
	Thu, 11 Jun 2026 01:55:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142951; cv=none; b=oGc5FXDF3cZwUXzAfDccTtxPk/Un0vkleojxBlzlExVSocMmWnEl7XvF6/56m7PCbC2EvRcUnEm+XnCv2ozk7rcQnlaxUCq1YiOIGEOzmOe24BEjbmIndH2IaxexY7FpuWpCw8y9jxJAzQa+fojEajjIhlZ/5lnyxxzEBUkn5/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142951; c=relaxed/simple;
	bh=uICGC2yxGlAniXxit1OUkqRwByVAR45ztTbIMmRpvPI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=DtR2VunRbfG1TRmKAoKmD+PqLbljqbqpSk18LHrFb7ugTVSxjKzuo1hBEHTOX/cftKabS1OWPce9ffLWjQp087sj8PPF85Im2dzy+ParwsXh/t4DNBPzEPmJiKLBTh/jg/8Ol/aPx2rxyuAdgtx6r86Rynul8ZluQomXJMJqFFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tbpY+li0; arc=none smtp.client-ip=115.124.30.100
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781142946; h=Message-ID:Subject:Date:From:To;
	bh=ssfM3bgYmJ7PMTz5aWvZ74bFGz6EBIGbRO1Dwbi+lpE=;
	b=tbpY+li0fs7nH3zRXWzSrMoEV0Oy1lzya/wYJBb63wkAPxUWd6lOE4D6pBtPOfMrBmbjWD4gH/QZzf2ZUk4bX2TvLbwmtduKTXg+oQ1TxWWVonMWylrdwtRwtyPMbRqKKm3ZZyQ0stY5ahl/x7nSyD26x656VW8A70sOaq2Q6Fg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0X4c2ryc_1781142945;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0X4c2ryc_1781142945 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 11 Jun 2026 09:55:45 +0800
Message-ID: <1781142936.5492013-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 1/2] virtio-net: fix len check in receive_big()
Date: Thu, 11 Jun 2026 09:55:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 minhquangbui99@gmail.com,
 bestswngs@gmail.com,
 Xiang Mei <xmei5@asu.edu>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20260610232936.1176094-1-xmei5@asu.edu>
In-Reply-To: <20260610232936.1176094-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:minhquangbui99@gmail.com,m:bestswngs@gmail.com,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-297877-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xuanzhuo@linux.alibaba.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,gmail.com,asu.edu];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8184566DB7D

On Wed, 10 Jun 2026 16:29:35 -0700, Xiang Mei <xmei5@asu.edu> wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

> ---
> v2: add 2/2 for robustness
>
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;
> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>
> --
> 2.43.0
>

