Return-Path: <netdev+bounces-273566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDzcI1Cly2mhJwYAu9opvQ
	(envelope-from <netdev+bounces-273566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:43:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DA7368364
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 12:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 382B53066BF2
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 10:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3D3A381F;
	Tue, 31 Mar 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJD8YkNE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieRaqIX/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417DA3A75AC
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774953390; cv=none; b=Kk7/VcvFVM+pkDZVSiaGoRd8WCpioyAaqetlCV4iojYjnRvbCH1aEPgnhm0jDNcpJ6PzBLvMWFV086tgQhgU1e4XgjuB7jCAdjYMEk9yM/b265chZt7DBexzIhnp/r8Suh3v7+ug0YouBZDcIt1Dda6jdjMgyd6IdkrXtN9b89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774953390; c=relaxed/simple;
	bh=Xr0KXUuwWyloJuKvsuv9vPbJibUbCJ1c3H4AyRVjmpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZYhibaCEoQ9vqry8tmi9kONgAVU3LqUcDAQ+Nf2YCYHag27YqbdAsk+EhNHuASF1PCn+Yu+MqP17POtzD3ndangtkD0r22A/ts+ZYkBeiPjZvY6ku/iVbJ2PCs1bdkqR2GYLXXx8IxuGJ8hb9Q7ebitSsFpggtxsb7vDqVHEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SJD8YkNE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieRaqIX/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774953388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mmDBnBQF5qqKpPAwNyURFB8rLMz1U2kEtshU27z56VM=;
	b=SJD8YkNE3kVtfwt8wVzNVXuSqrJnZ0fNQ48T0b0l34EwJFEKH4AAryqNqBhTafvod9a6nE
	lvNC+e0F0G/nwBKD2suOoSdak+NWpAGqFI9ezAMlfLgpXBS808EviK9cL1noGmaCIufnhf
	1hAPd6+Q3raHxOFq4y6h+P9YPUvv14o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-l2cGYuFDN86UZ_476JWe0A-1; Tue, 31 Mar 2026 06:36:26 -0400
X-MC-Unique: l2cGYuFDN86UZ_476JWe0A-1
X-Mimecast-MFC-AGG-ID: l2cGYuFDN86UZ_476JWe0A_1774953386
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48535f4d5e1so60597675e9.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 03:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774953385; x=1775558185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmDBnBQF5qqKpPAwNyURFB8rLMz1U2kEtshU27z56VM=;
        b=ieRaqIX/BkGtO5L2k8P9t4FU9JUVnlXjlI/DmEr2tUtP0MbSuCxwL09mpzbcRN1sc5
         2CjppFa1Cbdzlk3/Ox1ZvQO08LTQ2YoCGlDq4NQGepZw8Wq85ICOc0UiH6O1FRBQaUJd
         m3LPksbxr+Iykx+jBptK2yzPv8APHAvGMn59OXkJN3BYmMbYaAkZQAJCZ/9lnhhhFtFr
         c/ZJIOPtP9XuRXes54K0FmbX5xf+hJOGrd2RVenCylhdz0ZwKG71pjRMakdhlXo05nEq
         n1UNwJB0v4eEby7Dvdnstul74QOlvjU5V00ZUzkbpW2VnvnFgsqOU58BeRjNFpOzhj0C
         TrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774953385; x=1775558185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmDBnBQF5qqKpPAwNyURFB8rLMz1U2kEtshU27z56VM=;
        b=FeKpO9C94+ogKvuPjWMwr9aKgH8FDfzZvGy1imfjvuu7ADpzWSREW/Nc4LuW2NThaZ
         tCVy3dlNuY8U7ym5iwhcE6SZcj9X5+Dxb/KMM85DL4uKz3M4xQi5mFkZM5aJowjW4VaJ
         9FgIEFrdl7MYsbLlHGwN5Nj6utiVcvvj9dtMSNZEB3fcUf42FcgR+3xg1/FHEjOuEf5L
         +vmGWQITAuk9ye1vv4Dh3AcY8sVseYopSs86kR8Y+s7Jh0YqgdWrotFYyXCqYcBMqd4k
         ZutApLk8APOaHw31nixaEfjP1Bp0NW9KVDCRAcQl0wDPNojRhhtXHVYKJVNzWlEr4Xh6
         u18Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIEM/rf0mEjS2vPj5OLfpN67oCgjIsKAlxHrvi2hwmvsWM0l0TBKFdCdqKY+LdGMunqbrtf9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXTchl0l8kgSaP9cuF6BW33SsKDirpXnXMNzTtFIcsZxDU1S0g
	5voYCN4ABc4UNgb66F0fGACjEf/dvH/K2otkA8acQyM1uC3b16UHFdG/QMmRAmCayiUE1/XxPnV
	t83tlG9k2E2NJrfWc3kS/Dv7VmuNI21A2ZYd7J5Nkcxyz3vaX9bQOlFmayQ==
X-Gm-Gg: ATEYQzyWMPu/xbIwgn4UC8kSBzGvYufr2VS98YtPEZZYg3aawCXP0oDsXvEhzW3rejp
	YEFLwc5d/DnFXc9WJx48OfcgpOE0tUZI1XZuSq2u9LHB98g5Iljnc4WvcyGSdeCqhk7lRfRS8Em
	CuQgB0TTtGofiLHBZhGrFNyY9banmYzChSTUrFCcLNQZFxL1jgdv47uIST4JMUpMoLGByCbweCR
	FReh3oEzL6eLLOOOQ+VkzbBu9sa/e1yHAgXlg7V53mmZW3tvWyIZDQqHWNrZVzRjKEL+byqU0Bh
	4aopY2A6k5r9Dz008FHHyaQycpQ9yjwbYyO1wk0u4wkmFXhAHeg1N8Ojk20e/2Lh0l5nioa7CU7
	A2Lhshgt8Dw64n27VSP73OYzsWPiaRYO6OVqZzRtvseAcW6MmMjd6o4h5
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48727e908e7mr268869035e9.10.1774953385543;
        Tue, 31 Mar 2026 03:36:25 -0700 (PDT)
X-Received: by 2002:a05:600c:c490:b0:479:1b0f:dfff with SMTP id 5b1f17b1804b1-48727e908e7mr268868395e9.10.1774953385003;
        Tue, 31 Mar 2026 03:36:25 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e967badsm32084815e9.14.2026.03.31.03.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 03:36:24 -0700 (PDT)
Message-ID: <b3997b77-d76b-4297-bc67-a2c57c7da601@redhat.com>
Date: Tue, 31 Mar 2026 12:36:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 net-next v2] ipv4: handle devconf post-set actions on
 netlink updates
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: horms@kernel.org, kuba@kernel.org, edumazet@google.com,
 dsahern@kernel.org, davem@davemloft.net
References: <20260327120202.4761-1-fmancera@suse.de>
 <20260327120202.4761-2-fmancera@suse.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260327120202.4761-2-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273566-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 07DA7368364
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/27/26 1:02 PM, Fernando Fernandez Mancera wrote:
> When IPv4 device configuration parameters are updated via netlink, the
> kernel currently only updates the value. This bypasses several
> post-modification actions that occur when these same parameters are
> updated via sysctl, such as flushing the routing cache or emitting
> RTM_NEWNETCONF notifications.
> 
> This patch addresses the inconsistency by calling the
> devinet_conf_post_set() helper inside inet_set_link_af(). If a flush is
> required, we defer it until the netlink attribute parsing loop
> completes.

IMHO the above deserve some additional self-test triggering the relevant
code.

> This ensures consistent behavior and side-effects for devconf changes,
> regardless of whether they are initiated via sysctl or netlink.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: handled forwarding notification and disabling LRO
> ---
>  net/ipv4/devinet.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 8300516fb38f..a35b72662e43 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2161,6 +2161,20 @@ static bool devinet_conf_post_set(struct net *net, struct ipv4_devconf *cnf,
>  					    NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
>  					    ifindex, cnf);
>  		break;
> +	case IPV4_DEVCONF_FORWARDING:
> +		if (new == 1) {

AI reviews says:

Does this check miss cases where forwarding is enabled with a value other
than 1?
The sysctl path allows enabling IP forwarding with any non-zero value. If
a user sets IPV4_DEVCONF_FORWARDING to 2 via netlink, forwarding will be
enabled but this check is bypassed, leaving Large Receive Offload (LRO)
enabled. Could this cause LRO-coalesced packets to be forwarded without
proper software segmentation?

> +			/* it is safe to use container_of() because forwarding case
> +			 * is only used by the netlink path
> +			 */
> +			struct in_device *idev = container_of(cnf, struct in_device, cnf);
> +
> +			netif_disable_lro(idev->dev);

AI review says:

Is it safe to call netif_disable_lro() here without holding the device
operations lock?
While inet_set_link_af() runs under rtnl_lock(), netif_disable_lro()
modifies device features and calls netdev_update_features(), which
asserts that the device operations lock is held. Calling this without
the lock might trigger an assertion or expose the device to data races
with concurrent feature updates or BPF/XDP attachments.
Should this use dev_disable_lro() instead, which acquires the required
lock before disabling LRO?

/P


