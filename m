Return-Path: <netdev+bounces-269443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH3GMpP3u2lKqwIAu9opvQ
	(envelope-from <netdev+bounces-269443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:18:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C8E2CBCDE
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 080DC30162BC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9643BADA7;
	Thu, 19 Mar 2026 13:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCtzb/wj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC436215D
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773926282; cv=none; b=JNGSKUdS6Khqu33dJwftjLXUzbjmDs8Gt5rAmPKFiqbw/vc+fDKCOZDlYr9w/N/v8zGc4TSJdPDkGiGcXFfurTq/fReqeVzrfU8kvObgmTrNCTR2h57nisbv0ep8l9E4vmMrpTk+F93sTAO61FbZz8o/9LDjL6OGrsyip91dx74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773926282; c=relaxed/simple;
	bh=020q6q1g66XqtXV4RFGZKPrxs0aV7xbkjhSGPWaEfbA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dQ8jpxS/ikXDDP027+h/FOstbYQoD4geDAkDScSwYHAZI4/XxOjcy9aAUXv8CjK4uswxvVPTvPoSQq7cvAe3Bhvae2mUSG9n7LefwHxk+Pr1c+MneNz0CAJzx2DfIU3JDti1FgQ4pTd3vVOTkOTHxr66KIlQB/OHDo6+xFGQ9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCtzb/wj; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64aedd812baso1074093d50.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 06:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773926281; x=1774531081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUYMlWd4GAiILCm5uY9PlYWlSUSO1SjJ9tBrIy3nZfg=;
        b=gCtzb/wjCO+tEHej2Ym/XFIokx5oX9sqcNJjJUEu4LVpHmQYe27yxKS7OFOnzQypF5
         kreay8lTNn2lbQvnj3ECnMY/m0HNUZZimqwtzUKpHBroNVf62QufKbPc6nQT6o/JuQ56
         w0VgRjJNvH2imFiiilAKZ81jSP+MK+xLgP892u3CgaFwDTB1o2Lo85BcwedNObUppOOh
         U0HtSrLVI+opk9NxRTGzemVVn3LD4MGpd1x8sbo3yLUw6glJZpOVyOYr5oK1OXR0qWYZ
         nQk4UnD/d4ZYPVioec1hTCvxIInD30wI774kHKxJ3Kh8cR08HwXmOLBl1ew0HuZuksdZ
         e+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773926281; x=1774531081;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sUYMlWd4GAiILCm5uY9PlYWlSUSO1SjJ9tBrIy3nZfg=;
        b=K/f0pkRDpx0asqup0RtE07BWQZV7wpsLDvzmxiACm+m2/fWshOeiRCkezCk7mN7Tpv
         eMfHnH0nuXFr6s3jxNpF8+FIioEBKGLJqmg/w+5o5tp/mxPYBldY69vHr37+RWyA9lJf
         YwSO4AoNxiqDolpUOhLrKl7+96xTZKMjQohRFqUOuQUSDM9rIsYzf9OVmEXeQPd6unRV
         EGn5Wt74w7vxrD25qOvyInsvYGWyyhTzOlopp35gDe59c4o6ZsnDnCOvdIkiBDP86RIV
         GkMtgGmgOsqY9RyE+9wPlS39YNTCKtylORil4pxT1hhiEEtUT90b1+EPyTmW+0+qWZnm
         aUvQ==
X-Gm-Message-State: AOJu0Yx9ICAwiN2MdHQLYvcGCSFP160ic32tBWCgq4yQaA5GLH08xEoH
	mE2jWyxmO9EJvkx7t1pkKs3L+bz5trr41Tl9yiQOVxcbbPRt5o5MI31X
X-Gm-Gg: ATEYQzyoRb1wil+t/o4RzgilhLsvGijq0G5eORVYEhAfA7kDf0W97daIKMoQLiU+Sh5
	L5GIhuR4ouT0aBUdkFla+T/Rh66UmWEHdygrrgsOXLLqBzNViRiO4vG3lHyPZuQ+TnkwqjxRUtj
	HZLHFwoZ3667uJjvUWSy4uXI9d6zmU5GtkJLoRF7YhT58wHkIesOuSOeN7n9L+qGz1snF8Y0eHT
	2Qt0aIdvB3pcTMvE0MAz0ecULyjyE8n6ii06qmkE4tPoUnhQ8hVvQVRf+BlgoO0NAOcVQY9RVmi
	sTGMTzJtUB1SymBHD5a3VPomnii/bMCe+Wp66rq8mPQEoXKkJCbfAyhWwjc8NGA0sVDxgGhZzdo
	MyArSOxLexPJrbP5cgVkP/lJFHxcaZyz8p0b+w6SZdSMw+d08N8P/pHTQx7Sj5GF0g7VRa+BmX5
	tqshzOaVcpEaXzLi3gEp6WhEaty5glhyqW28QJAIcxPWTb6SX2vMeV1rGWdbwiMquIHUhWVbZJv
	F64
X-Received: by 2002:a53:b7c1:0:b0:64d:29b4:d023 with SMTP id 956f58d0204a3-64e915bd1a2mr5148952d50.39.1773926280414;
        Thu, 19 Mar 2026 06:18:00 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e91a1cc32sm3525333d50.4.2026.03.19.06.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 06:17:59 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:17:59 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com, 
 Guoyu Su <yss2813483011xxl@gmail.com>
Message-ID: <willemdebruijn.kernel.c0bb5d182993@gmail.com>
In-Reply-To: <20260319005421.14908-1-yss2813483011xxl@gmail.com>
References: <0a25f57e-fe08-4fe9-9722-e1c6adb81e91@redhat.com>
 <20260319005421.14908-1-yss2813483011xxl@gmail.com>
Subject: Re: [PATCH net v4] net: use skb_header_pointer() only for DODGY TCPv4
 GSO skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269443-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.028];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 68C8E2CBCDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> The current direct skb->len check is not sufficient for SKB_GSO_DODGY
> packets. In the AF_PACKET/PACKET_VNET_HDR path, packet_snd() can build
> a DODGY GSO skb whose total length is large enough, while the IPv4
> header is not fully available as initialized linear data for a direct
> iph->frag_off access.
> 
> Use skb_header_pointer() to fetch the IPv4 header only for DODGY packets
> and clear mangleid_features conservatively if the header cannot be
> accessed or the DF bit is not set.
> 
> Keep the existing direct ip_hdr()/inner_ip_hdr() access for non-DODGY
> packets so that buggy internal callers are still exposed.
> 
> [1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> 
> Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
> Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
> ---
> v4:
>  - Move struct iphdr _iph to the outer scope so a pointer returned by
>    skb_header_pointer() remains valid when iph->frag_off is checked.
> 
> v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
> v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
> v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/
> 
>  net/core/dev.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b9..d47bf7b1fa99 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3805,10 +3805,20 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * segmentation-offloads.rst).
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> +		int nhoff = skb->encapsulation ?
> +			    skb_inner_network_offset(skb) :
> +			    skb_network_offset(skb);

can be moved inside the unlikely branch

> +		const struct iphdr *iph;
> +		struct iphdr _iph;
> +
> +		if (unlikely(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)) {
> +			iph = nhoff < 0 ? NULL :

why the negative check?
> +			      skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
> +		} else {
> +			iph = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
> +		}
>  
> -		if (!(iph->frag_off & htons(IP_DF)))
> +		if (!iph || !(iph->frag_off & htons(IP_DF)))
>  			features &= ~dev->mangleid_features;
>  	}
>  
> -- 
> 2.34.1
> 



