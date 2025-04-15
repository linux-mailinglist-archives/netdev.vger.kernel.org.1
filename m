Return-Path: <netdev+bounces-182666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70800A8990C
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D479C170100
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A6A28BAB9;
	Tue, 15 Apr 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlpHCT99"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D2288CAA
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744711153; cv=none; b=INNgKjXd9PMP6pHVzlfodpNNjy/sDS6EJGTv76qnkLrein9mogLEYraEVH8sNoaLWxCRwnEqmnweWsgxdfGEAxdaFMqKpMJyKQfT7d6RpK67xxo/y/NbpUlT7Ym3MZoqXHllE4AsHBOpIbovtuRACnwbeYrgDaICN5iXSm3IJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744711153; c=relaxed/simple;
	bh=c6gwtQs3I8xjgjxSBbquWxZtfb4ibzo6iW5SzVk+pmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2qYaiYlZnGHjO6xABPm/PE+gSX/dKubJLKcKZCjKYlnqHu1JTfCyzvso3z8KN/UQ6qfrVSrYsvk1CYgTr6uO+4rCq61cERtZ9chWpMGKX4W6oDKpkZdN8U7ea8gF+KPhUrXUnxdIFHaBUJSnlUuVi9H9LJ4MMhziQKrlrKvbeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlpHCT99; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744711150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ihVgNY5xrIwWYln8+zw5s1JJi5SwtPL06jt3VEodaFw=;
	b=PlpHCT99udD2//tnFyFoniO35zndT/QlTLnXrvREYRpOZPLU3hovThUCxaT62pccLeS74m
	jHBtaMDZfsUNeS7eL34nj1dnxD6QBHbKMtxjSFttdfdD+P8gSflZ1JNxKGHmf4vOs+98SQ
	xJiB/egzIjG8YIZfSoqzGxagUXkZ3bY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-BfsoMXnzNd26NlqzUrmcjg-1; Tue, 15 Apr 2025 05:59:08 -0400
X-MC-Unique: BfsoMXnzNd26NlqzUrmcjg-1
X-Mimecast-MFC-AGG-ID: BfsoMXnzNd26NlqzUrmcjg_1744711146
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d734da1a3so27063525e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:59:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744711146; x=1745315946;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ihVgNY5xrIwWYln8+zw5s1JJi5SwtPL06jt3VEodaFw=;
        b=Y2E18GjPFDJxw1sQW0zDDjJzVNCyNgETtmxxbVHxoFkke1Wz186FR3x/p6/4bTl2kD
         Kg40oreSMypMAFjP/LDv+kh/9rKumIDfF6n8rnY6GjMo+0mLm8qHKR4O+ga0TpILCNHs
         Bmn18w85oDrBNU/lu0GZnHUi/HKAJKK0BakpmYIVEWBRSn3BGbEGZzPDrY+G9XcYQkyn
         gdzjiwHJgSDeie9eDaI76Tetpe2Dvzvvy37GOPmkDaly7zrUyVMwcSnhRO4qQROSl/1Z
         LC4vh4cz/lYBc+KJn/tCt+TRQnNeutAlzXAFNA9UheE6tE6cFguoXWAAyvxw9B/h+fPp
         lnUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXBMmcNDIS6jgFTITPGIeFu7523AG+F3EBJpTnvW5GOW/5/QyFWWNx9auDJaMxhlcwa17Caws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEHcJInc9wOa203i9R1onveCqR/eWqojWponx/bcvU0t5GvKSr
	QH4wPcvaZuzje/4/mCPkwcrUh7uOWSjrNPnP+yzezEG8wio+ilH7/uB1GNdpv11sGk7NSeDbcCu
	M5KmHYHFo56hgAsoq+mTT9lgQr/dm4CZNK64H/fUanhusgvj4DdSkqg==
X-Gm-Gg: ASbGncsGMbYsgcr1rmaoqTcSMtzK5iqk13JRY1ZGW6fsMoQTvb2yQqqnqLl7BuCL8PH
	Bj/VIkNibpuVokXyx/5ob+/i713+wTHy1hUOWh4Lqokp5hddXV3Ah8bB1xEekwGOAC77NWWznk1
	p9p3H25q67PSL4nMeSLAFSBNMhoiBJgiePgswm+hh3vc+AGB7eur4kp+F58GPjNHmx2HY98fji4
	AmuqE2+J2P+XwO7GNDfvQUy92MGTqfeWAM3/CNUt/ZnVOAbGU7ethAwGzQ9T/OX9yYq1wnLEZTn
	hKBuZDsrcoJb7yI70VN34Ns96eUypynvL5PmlMQ=
X-Received: by 2002:a5d:6d8f:0:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-39ea51ec9f8mr11957242f8f.4.1744711146485;
        Tue, 15 Apr 2025 02:59:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWENy6afwgs9SvCMpQLaSrR/V5m+63gKEP78ia82WzS8nrbGmua2lSxm6qfkE/q9x0TD70Ew==
X-Received: by 2002:a5d:6d8f:0:b0:38d:dd52:1b5d with SMTP id ffacd0b85a97d-39ea51ec9f8mr11957216f8f.4.1744711146042;
        Tue, 15 Apr 2025 02:59:06 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207cb88asm203451435e9.37.2025.04.15.02.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:59:05 -0700 (PDT)
Message-ID: <f8e571cd-804f-4f57-9fd8-d1697a7a2de3@redhat.com>
Date: Tue, 15 Apr 2025 11:59:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ipv6: ioam6: fix double reallocation
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 horms@kernel.org
References: <20250410152432.30246-1-justin.iurman@uliege.be>
 <20250410152432.30246-3-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250410152432.30246-3-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/10/25 5:24 PM, Justin Iurman wrote:
> If the dst_entry is the same post transformation (which is a valid use
> case for IOAM), we don't add it to the cache to avoid a reference loop.
> Instead, we use a "fake" dst_entry and add it to the cache as a signal.
> When we read the cache, we compare it with our "fake" dst_entry and
> therefore detect if we're in the special case.
> 
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> ---
>  net/ipv6/ioam6_iptunnel.c | 40 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
> index 57200b9991a1..bbfb7dd7fa61 100644
> --- a/net/ipv6/ioam6_iptunnel.c
> +++ b/net/ipv6/ioam6_iptunnel.c
> @@ -38,6 +38,7 @@ struct ioam6_lwt_freq {
>  };
>  
>  struct ioam6_lwt {
> +	struct dst_entry null_dst;
>  	struct dst_cache cache;
>  	struct ioam6_lwt_freq freq;
>  	atomic_t pkt_cnt;
> @@ -177,6 +178,16 @@ static int ioam6_build_state(struct net *net, struct nlattr *nla,
>  	if (err)
>  		goto free_lwt;
>  
> +	/* We set DST_NOCOUNT, even though this "fake" dst_entry will be stored
> +	 * in a dst_cache, which will call dst_hold() and dst_release() on it.
> +	 * These functions don't check for DST_NOCOUNT and modify the reference
> +	 * count anyway. This is not really a problem, as long as we make sure
> +	 * that dst_destroy() won't be called (which is the case since the
> +	 * initial refcount is 1, then +1 to store it in the cache, and then
> +	 * +1/-1 each time we read the cache and release it).

AFAICS the DST_NOCOUNT flag is not related to the dst reference
counting, but to the dst number accounting for gc's purpose.

The above comment is misleading and should be rephrased, to avoid
confusing whoever is going to look at this code later.



> +	 */
> +	dst_init(&ilwt->null_dst, NULL, NULL, DST_OBSOLETE_NONE, DST_NOCOUNT);
> +
>  	atomic_set(&ilwt->pkt_cnt, 0);
>  	ilwt->freq.k = freq_k;
>  	ilwt->freq.n = freq_n;
> @@ -356,6 +367,17 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  	dst = dst_cache_get(&ilwt->cache);
>  	local_bh_enable();
>  
> +	/* This is how we notify that the destination does not change after
> +	 * transformation and that we need to use orig_dst instead of the cache
> +	 */
> +	if (dst == &ilwt->null_dst) {
> +		dst_release(dst);
> +
> +		dst = orig_dst;
> +		/* keep refcount balance: dst_release() is called at the end */
> +		dst_hold(dst);
> +	}
> +
>  	switch (ilwt->mode) {
>  	case IOAM6_IPTUNNEL_MODE_INLINE:
>  do_inline:
> @@ -408,8 +430,18 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
>  			goto drop;
>  		}
>  
> -		/* cache only if we don't create a dst reference loop */
> -		if (orig_dst->lwtstate != dst->lwtstate) {
> +		/* If the destination is the same after transformation (which is
> +		 * a valid use case for IOAM), then we don't want to add it to
> +		 * the cache in order to avoid a reference loop. Instead, we add
> +		 * our fake dst_entry to the cache as a way to detect this case.
> +		 * Otherwise, we add the resolved destination to the cache.
> +		 */
> +		if (orig_dst->lwtstate == dst->lwtstate) {
> +			local_bh_disable();
> +			dst_cache_set_ip6(&ilwt->cache,
> +					  &ilwt->null_dst, &fl6.saddr);
> +			local_bh_enable();
> +		} else {
>  			local_bh_disable();
>  			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
>  			local_bh_enable();

Possibly move the BH disable/enable around the if statement for
smaller/more readable code.

Otherwise LGTM, thanks!

Paolo


