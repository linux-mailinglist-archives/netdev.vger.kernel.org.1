Return-Path: <netdev+bounces-272384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIZ0J/EnxmnQGwUAu9opvQ
	(envelope-from <netdev+bounces-272384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:47:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 018FB340002
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 07:47:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D93A8310B57A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 06:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E50D3A9D87;
	Fri, 27 Mar 2026 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="L71N49i1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074143B8928
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774593492; cv=none; b=K1SgT0J1xNngQ0LUnLYfTtfvP8Mds3ZlglPFSvmOzcr5AbvDE8XR+/NkhdCcoMEeC878PpxD6jDmu/JZbkjQjD3KFWPDpf5bW90PYBq5MFNQ0RoDPOrJBPPYVw7Yjv2IM/Imv72CUDH2s11kADb5Y4lioyJHzL1hh0E/qrkZ/54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774593492; c=relaxed/simple;
	bh=OalUvNka4rSqIza6cXGQTTpYwwa3mB6/6RhFkMnDUhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MDrh/sZx35rWnivsepI0NdAmZYHsPlDp27Lbr2PVhACfjeBPy6k3CNeRuiBKzK3itp2ixcjMmPRemOy3+M5fuRxW4vNwXv81crYsFmUv7iKT1EE1+aR/PADKXo2rklDpN5x42kWwFEQDYci3ME4DIQR9+zgsjQSw2p97F4XR/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=L71N49i1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fb14227cso21346395e9.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1774593482; x=1775198282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufslfVKbYiC1gJ1SBX0ye+COWeE+LMG8L5cvsaYvZjY=;
        b=L71N49i1Xq6q/qnSbgKhPq70Kf5C3xtcX4or9EHNMkTQBIsqr8OxkYpSWzo8ZodNx3
         7XDff4u5TIO/9nfLt4HDIne5QZoEDwJBg7dxlmOVyOJX5+W+cVYCT4VndiPltuUNzKSA
         Lpr0Q6aMr48Z13BkJrlF95ow2SB0TpfjlzsB1Ci5TIJ7AjtGWyl/Ej9og3pwGhgEKitC
         JE9n8yGXuIi9afytvy4bOy1M/UozzlRBNehSCab3Zs9QDwKt0unFBEd76y9eWz7cakw/
         m9NCvCmc4Nlq83eKZJOFxHmusAqfAnU6IPFpHw0iR8qXk0r6aLaaiWHIYRFw+Jwe4LbG
         Gaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774593482; x=1775198282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufslfVKbYiC1gJ1SBX0ye+COWeE+LMG8L5cvsaYvZjY=;
        b=hrKjFOeTK0jt81e6O2XUNonzTywDsPXR/5gAeIK8NQ/K61bDtjxIMymBWViIH7+4VP
         WJVsXvhlhQJLcvnPaOgt/HJ/tenNuhey7KVMzcX2s3uiXzd0f8BRwFQY3yfjEVTbG6ZW
         jamTd0gnmPPp+CrWca6fle5KecnUP+Oyq3WbNT5iG0ImJ7EPZWGsyV/AyehP4fn9fQ7f
         vB9d5UI9KSDkqhADgi1QM/1T/qIzNHvU7f5i7OKH3Jyof2+4KzRf+BrxdZtghkJ9+Obm
         vAQSs+cmaW3WF+87S5fDzyo4DwwTRxaY2v+0ynkYGvBjnCaC29sJHJb/Fm4gnK+Ves6w
         pQaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWuAVDxTHQOnxUvmKHm0OMDbvJVf+0ETevQUNb8mSaYSaS10/hIKeT/gP+8M71eTG6ZJVCOSWg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0e9oBBWpi5CmOTvRNZvuygxcuyDLMXmhIrHh5sYgs/ORpVDKt
	yX2GpOvBbD3ghxYBgmyzfL5qmi2lPv1Mc8iYMnGk976oDWSZ9gnulCgk8UWcdUa65Ls=
X-Gm-Gg: ATEYQzzH4UMjrRB3Y9oMHWRugikv45Ue1XLqUSMVhMY0T+g2Cla0TahegyXHrCWc85k
	VqgFPDWrZyoGnfuM/yxpdGJdudaDGVsz2tpKzMPemOHGcEgd0Crri5kbpcbGHuWlFxbUYHoqSO6
	/DL2yREzsWrkAfb4D9ojsd0mK31t/+k5cPL/u8wvJIFTdV27vy8/toNSUtRyfHXcWp0h35Lmhd+
	3jPMaO4aZAApldUJiKpUa+8vUK8w8Fl/GBBppHyKvcLyUtNDVnAt7evvCqEVvUOFcbzCKV2+8DF
	b531hZAPGTrdsVSvAXDJxTN0CjlnXGTOwciHZrQ3n0ED/StQOkviD2AeBXijWliCS/PdCcPwhVL
	uHl7xALYP2lo/R5m0/VqaK2IWufYaXVCNZco5bHJiPjD3DsQHJ4oy5YOAxQgQLuT+OF3bNVNf1F
	83kRi7AeHQykGmKwk0s9vnlyFrp1/sSpXNwA5fyweMJ8vaM9hNLQrLLA==
X-Received: by 2002:a05:600c:4685:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-48727ef67f8mr19564215e9.21.1774593481383;
        Thu, 26 Mar 2026 23:38:01 -0700 (PDT)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f58fsm121003165e9.11.2026.03.26.23.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 23:38:00 -0700 (PDT)
Message-ID: <4b0ce6be-1f9e-4f2d-b2db-16d39c8b133e@blackwall.org>
Date: Fri, 27 Mar 2026 08:37:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] bridge: br_nd_send: validate ND option lengths
To: Yang Yang <n05ec@lzu.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com
Cc: andrew+netdev@lunn.ch, horms@kernel.org, florian.fainelli@broadcom.com,
 roopa@cumulusnetworks.com, dlstevens@us.ibm.com, nb@tipi-net.de,
 netdev@vger.kernel.org, bridge@lists.linux.dev,
 linux-kernel@vger.kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn
References: <20260326034441.2037420-1-n05ec@lzu.edu.cn>
 <20260326034441.2037420-3-n05ec@lzu.edu.cn>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20260326034441.2037420-3-n05ec@lzu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackwall.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[blackwall.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,broadcom.com,cumulusnetworks.com,us.ibm.com,tipi-net.de,vger.kernel.org,lists.linux.dev,gmail.com,outlook.com,lzu.edu.cn];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[blackwall.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[razor@blackwall.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lzu.edu.cn:email,blackwall.org:dkim,blackwall.org:email,blackwall.org:mid,outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 018FB340002
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26/03/2026 05:44, Yang Yang wrote:
> br_nd_send() walks ND options according to option-provided lengths.
> A malformed option can make the parser advance beyond the computed
> option span or use a too-short source LLADDR option payload.
> 
> Validate option lengths against the remaining NS option area before
> advancing, and only read source LLADDR when the option is large enough
> for an Ethernet address.
> 
> Fixes: ed842faeb2bd ("bridge: suppress nd pkts on BR_NEIGH_SUPPRESS ports")
> Cc: stable@vger.kernel.org
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
> Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
> Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
> ---
>   net/bridge/br_arp_nd_proxy.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index af3d1e33f50b8..6b5595868a39c 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -288,12 +288,14 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
>   	ns_olen = request->len - (skb_network_offset(request) +
>   				  sizeof(struct ipv6hdr)) - sizeof(*ns);
>   	for (i = 0; i < ns_olen - 1; i += (ns->opt[i + 1] << 3)) {
> -		if (!ns->opt[i + 1]) {
> +		if (!ns->opt[i + 1] || i + (ns->opt[i + 1] << 3) > ns_olen) {
>   			kfree_skb(reply);
>   			return;
>   		}
>   		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
> -			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
> +			if ((ns->opt[i + 1] << 3) >=
> +			    sizeof(struct nd_opt_hdr) + ETH_ALEN)
> +				daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
>   			break;
>   		}
>   	}

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


