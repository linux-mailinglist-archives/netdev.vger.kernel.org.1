Return-Path: <netdev+bounces-268606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOd+JgNYuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:32:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F22AAE90
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C133430B6B3F
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A6624C692;
	Tue, 17 Mar 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcay63gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0B81A23AC
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754225; cv=none; b=tOTzqUezWdP2hNxaLWIaESK2PUoueVuXpn5mhE5pwzL5GilqbtGpPHgADHl4yAswpnDeQA6pCsgc7WQ2pmh+AFnjbwspNUFnk+dYn87gz1R7Ak4HgRp9eyhFLdhWOKsvgD1KLxlqUWZjQlOlTI5G2osiBO3zJZIgJQ4Ne1IssiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754225; c=relaxed/simple;
	bh=WTklFd+xAu4hGzmNTuliFYPoc4TDU1mCc0XJBj9j7Ic=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=GsW+rRabUEWaApythJKrQBX2wwKQQ40nDZEtYg3nUI3MsauFJjSgQ7AcVEU+gsqSMLJTWcMKK8v1bzFjVZ+VZEaTbzxassC00K5X4Wu1E0EB3BQEeacepJSLxXin2MfVM0Q9LW1eFskhhMePfAp9CrwkFza6TKQUw46GwIGVxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcay63gh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a2ee65171so30832547b3.2
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773754222; x=1774359022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+OZHdz7JUIXbfLO4py8nXeTNKDtHpNLhBh45s0nxME=;
        b=dcay63ghRmUbcvLXKdLJlS+RJrvic4H2PSNKb0ztxbdB4pkFo2kKaw3Qk1nbIppe+I
         rFhSqt80K3+F8PdhvQVyLpiAZ1kS0p5pTXDuUiMnqwsqTYYoEDLFycvmltjewaxhYb87
         VAKMefKwMAL9KUf1lpcjybKayzgoAxdUqg/Wp0cvbE1nQsTYHCkfapyxd7fjR9AKG862
         qtr1Ha9mXF8nz3Pl5eyYW/2G5FZcPwS8ydAKPK8HXphVtdCD5I425K6Wh1QAQYV86Ymk
         ef9kpb0wSUVmWKHuToc0PEkyNYBIlqHsz7n+PLV2sk1OraYVl5aPVTspBzdSkj83EGme
         N9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754222; x=1774359022;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o+OZHdz7JUIXbfLO4py8nXeTNKDtHpNLhBh45s0nxME=;
        b=QiavjHTut+pDNrGhr7arGym20erheCTltf3lz1o4a3xOQOFbrGB7KahZsEYxP3XDbj
         QYKXLQBktfs3UKFMx4ZYqSnMnj1QYTEkAwPQ6WT02Bfw0oatrSQv+7I+3eD1TzQU3Evv
         cs3msXn5sc8Z4+Lrbc0YUT5IfvjD0tdgETDts8fm2rVERHYcVNhM1wGVsEbuT5AS/B5v
         H1Lqdvdv3W2WDrY3ufM2Juh3F4rTc7Ndf/Z5xJSRm3Pa7d8myjYNh8cRp5cp990mfWL2
         bT9pa+naowwYvJEBb9zL3ZF+Id+4DCuH1N7cAH2L4VYTBQ6ohu8FHdthm10erRmG7e/o
         yHzg==
X-Forwarded-Encrypted: i=1; AJvYcCXOrK0YoUqpEnMh7njFELxmJlq9MKHERBKCU4nnoB/nNRdYQEOv6X0uWb+hHKEUrJT7gaSuGo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJjyv4IWX4lKn/fM7LiL0GGanv0TFKyGxC4RJYt+qjCoho3+pb
	zZ4rs9a8hpd65IKkOjghPMXBQiJ23ZFMDZCxMxZfuLciVTtMa0mgBNyF
X-Gm-Gg: ATEYQzyDB+oeXnYHWKBx9ASNvCYkrFE/zjG/4oyFAu0+xKLhrMAQPzsCVNBtHat6TT9
	+BYYGpNKNoadoZEO4cOC4FuionD8uksuy1cD0LsAMVLRZCP9YtA5/xtPV44jwoha5LjKg4B4TKG
	fe4G1x2l/m5tKuMdmgzyYJGC/6QVsc+PAMdqMhNnBZdsTk7hOyUWD5+iMZEAPXe54dsrsSnY+Yn
	u0346GsvIp2VaXZLv/Y91KcPkm2Tn7NvojxXwdudELbh6eeqcK+yuAPLHLTWHoOty8tn6YWKaC+
	GVBRF+93Icmwo8Yff1sp+0lud1et3DIZfR0GmZeEi8QHXmJUcBW82ySkMhnBLc+hXVdzZan3k1v
	r1y3JDuoMsRxrlZLkSgJELbnBmvFXhdEpOFGhrfTA1OlzIvGnd+AoWKZGTkln0MjXjK4QZlTaf2
	Ik+/nXA7ZHmWZnev8ic4Ht073CIcYRffKlrKQsNiedTpsc0Sg3A8W2JFXBBnEYA8Jf80AaNPAKS
	WfB
X-Received: by 2002:a05:690c:84:b0:798:c349:7207 with SMTP id 00721157ae682-79a1c0ab6f1mr165122397b3.4.1773754221917;
        Tue, 17 Mar 2026 06:30:21 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a1688ca84sm78216867b3.48.2026.03.17.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:30:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:30:20 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.4f5a568542ec@gmail.com>
In-Reply-To: <20260317121429.2399539-5-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-5-nhudson@akamai.com>
Subject: Re: [PATCH v1 4/5] bpf: add guard rails for new DECAP flags
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268606-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 3B3F22AAE90
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Add checks to require shrink-only decap, reject conflicting decap flag combinations, and verify removed length is sufficient for claimed header decapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>


This patch probably should come before 3, as 3 enables the features
without the guard rails in place.

> ---
>  net/core/filter.c | 45 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ac7e1068fe4c..437e0da34f84 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -56,6 +56,7 @@
>  #include <net/sock_reuseport.h>
>  #include <net/busy_poll.h>
>  #include <net/tcp.h>
> +#include <net/gre.h>
>  #include <net/xfrm.h>
>  #include <net/udp.h>
>  #include <linux/bpf_trace.h>
> @@ -3745,20 +3746,46 @@ BPF_CALL_4(bpf_skb_adjust_room, struct sk_buff *, skb, s32, len_diff,
>  		return -ENOTSUPP;
>  	}
>  
> -	if (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> +	if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +		u32 len_decap_min = 0;
> +
>  		if (!shrink)
>  			return -EINVAL;
>  
> -		switch (flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) {
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV4:
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L3_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_L4_MASK)
> +			return -EINVAL;
> +
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK) ==
> +		    BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK)
> +			return -EINVAL;
> +

Are these equality tests shorthand based on knowledge that each only
have two options, so equality implies more than one option set? That
is not obvious/self documenting. Please add a brief comment.

> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_MASK) &&
> +		    (flags & BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK))
> +			return -EINVAL;
> +
> +		if (mode == BPF_ADJ_ROOM_MAC)
> +			len_decap_min += proto == htons(ETH_P_IP) ?
> +					 sizeof(struct iphdr) : sizeof(struct ipv6hdr);

MAC is not a GSO related decap, can be used for insertion/deletion of
L2.5 headers. This should be dropped.

> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP)
> +			len_decap_min += sizeof(struct udphdr);
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE)
> +			len_decap_min += sizeof(struct gre_base_hdr);
> +
> +		if (len_diff_abs < len_decap_min)
> +			return -EINVAL;
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
>  			len_min = sizeof(struct iphdr);
> -			break;
> -		case BPF_F_ADJ_ROOM_DECAP_L3_IPV6:
> +
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
>  			len_min = sizeof(struct ipv6hdr);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
>  	}
>  
>  	len_cur = skb->len - skb_network_offset(skb);
> -- 
> 2.34.1
> 



