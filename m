Return-Path: <netdev+bounces-259492-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLpZLNkjl2lvvAIAu9opvQ
	(envelope-from <netdev+bounces-259492-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:53:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694115FCDA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACA4B300C833
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB26633F8B1;
	Thu, 19 Feb 2026 14:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bczw2tbp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPliT0ae"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BCE33ADAD
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512786; cv=none; b=rii38lxKk6pPZcbem6jd39Awl3juftnOazQHoCuA3O8aBvyEII7mKXzvFMBhDe+SodNleynF3MJsC3Am2C71fjyqTsLnM2w2jUGjH6aO3LF1LjZ1eUbHQ3mu8MNVb+GwdVG/GXopZPGLRWwxBfW4V2wI8aY16jzR1RZmMHcSn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512786; c=relaxed/simple;
	bh=YpHtvL/nNiUQiVZ1236bGaFn0XrecGCIPgdOd5FCgtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B7rDVbAeMR5zPoV/0I5mK+bjqSGX60QkPDNVKPz/hyubYu9QxHeLTz31BwduLghwEJL/t6ueXnVU7EalkB0sLs/F5h+ikPfA/vdaBeg/nYVQ6ul5BtxPY3dWfIgDKQaAr4JX1cRdwuMFthigslGIGdiNYeDaqka13BNOLiWiq9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bczw2tbp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPliT0ae; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771512784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oTXM5mWF79iVt/J/kSt0hSDx3mzJgHP7bH6isxTtUeI=;
	b=bczw2tbpsuNZv8HlDftoghSbxRHZPtsBCUS6uSiWEqVU+QYzNTaNauEhuc7CV3pyiBF+fO
	Bpv3cy1fqsz9xl+KcZ+uwYKeujqLlgmYTuR0pVHeAUm8wZxSziaqWnGm/G93WMBmSyPgtJ
	sLl7k0iQHIaGHxljhCeRNzr1hUcDNYc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-D6S9D5AFMiGYyGQV_gv0cg-1; Thu, 19 Feb 2026 09:53:02 -0500
X-MC-Unique: D6S9D5AFMiGYyGQV_gv0cg-1
X-Mimecast-MFC-AGG-ID: D6S9D5AFMiGYyGQV_gv0cg_1771512781
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837a71903aso6506895e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 06:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771512781; x=1772117581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oTXM5mWF79iVt/J/kSt0hSDx3mzJgHP7bH6isxTtUeI=;
        b=SPliT0aeYUs4vL1F/W6oXAnu5EEF/4oUSMqzUUd/13fAo5YTRNuAEkALO/ntNrVEYx
         BVsjTKbTOPcJNSEBgJ7nUrC7yZO6UtW7998RcEQszWaeGQoGS1eDJydtYK2eEsqBUSDY
         miyaaq9wKOq65FtzvksD9F7cCCJvIo+B1SqrV6j/67XVuxt7ea6ry2/UW7bX3o2CRFkV
         gjXxuJtLGQ/NL4sizl7mldUH0mM32yMH/EgA9E5z7gQhcTYpXXb7ZlyQxpDIslU7Y3Fz
         Sfh4EuXMCVG0fjrT1pIxQiRKlmgY+nIFw0R4dMgKeag8Bg5eJRBhm9uCxDGg7jPbPeKe
         wUnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512781; x=1772117581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oTXM5mWF79iVt/J/kSt0hSDx3mzJgHP7bH6isxTtUeI=;
        b=sakVRJ2/fGXmOitf6TrviO0+CnBRzc7QZ8qAPBTAuj7+5P431fZyO+hF+ir5GI+S3b
         ilNGtilznvdW4jg7GJ8PIIbOlviAr+X8eAssC/GNs8W2UAWcm2gRmAM9KUjpNAYGBDBU
         mY977jPYlPIi3xD8lS957tzPZR3zXtwfZxALbpIwRHnyTTXFnInMLJ/norW7VCUsBRIG
         WSaLTGVX2f82EFG6yGJSujetz5ZMh5XP0hJDMkdmrqriyp7W4HOM2VxEO72VAwLlfrtb
         vEdOeh7mNUy69JDcNWT7hc7L4gd34kan/dJ2hrXTu9Pdw1x/QkiogTPh5jsOvGVVy8i7
         vleg==
X-Forwarded-Encrypted: i=1; AJvYcCXLNmqOK0onAGXHzfSCs2UFZ0GkJVIOQ9Mf33BQwJL6B3NrLL5+TMKg6vzQmyjJeHBmcOeKsUc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw26qnKUptS9prRQDA2HhOEWzMShn9yLgZSLbj+hV7Z8afmb5k7
	tstQ6oaO3bvQ2G+8PWOPghYd/dvqg0RKjRYivinur+Si3ECQyTqPgLsR4ri4WAnes1e5/dE3Ocn
	jS/v151XTaOJ9zgTCcpAMD36HCZAVU9Eiyo30IDBnLPmwCrUxW20+UQnNxA==
X-Gm-Gg: AZuq6aLumxxCsf6xmfqbpMdQ1NknJ6nO0Gm0hj/LBtjw6ITwLGK8L63GxlvPjdOO+7G
	D7Os1A7ofswm5RblZzrvuRvAfgwPEj0Pcf4ZyOPIjAOQzFSNLJTcctJFjdBmauHbhdJNIi7oTLf
	jrH8frxuRtsSpD8u2onv1DO3yFXPuzh9OAWNdC1V1HejEE/4qLuaaNQZlulHjAU1dEsI/SGXc0W
	kUTdKQwUKNq846vrTlw2/15HNydBWl2+krX+aFRhPcgA2bMSx/knuwhS7MYbpOGh0LSqT2GKPxy
	cP4uSx4x/7KwIaapgPYe7woor0fMgRyWvtKlsyMykklBs25hQCpdLmTzqSPZtNFtkNyicuAoaMU
	VDQ6UZTe8l3373z/XfGmcgsYJ
X-Received: by 2002:a05:600c:6814:b0:47e:e946:3a57 with SMTP id 5b1f17b1804b1-48379c42d00mr290024455e9.36.1771512781406;
        Thu, 19 Feb 2026 06:53:01 -0800 (PST)
X-Received: by 2002:a05:600c:6814:b0:47e:e946:3a57 with SMTP id 5b1f17b1804b1-48379c42d00mr290024145e9.36.1771512780901;
        Thu, 19 Feb 2026 06:53:00 -0800 (PST)
Received: from [192.168.88.32] ([150.228.93.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4839f990384sm32361335e9.5.2026.02.19.06.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:53:00 -0800 (PST)
Message-ID: <b796bd57-650a-41d1-8032-f124084634c3@redhat.com>
Date: Thu, 19 Feb 2026 15:52:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 3/3] net: hns3: fix CWR handling in drivers to
 preserve ACE signal
To: chia-yu.chang@nokia-bell-labs.com, linyunsheng@huawei.com,
 andrew+netdev@lunn.ch, parav@nvidia.com, jasowang@redhat.com,
 mst@redhat.com, shenjian15@huawei.com, salil.mehta@huawei.com,
 shaojijie@huawei.com, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leonro@nvidia.com, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20260216085143.40242-1-chia-yu.chang@nokia-bell-labs.com>
 <20260216085143.40242-4-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260216085143.40242-4-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[nokia-bell-labs.com,huawei.com,lunn.ch,nvidia.com,redhat.com,vger.kernel.org,davemloft.net,google.com,kernel.org,cablelabs.com,ericsson.com,apple.com,gmx.at,comcast.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259492-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nokia-bell-labs.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2694115FCDA
X-Rspamd-Action: no action

On 2/16/26 9:51 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Currently, hns3 Rx paths use SKB_GSO_TCP_ECN flag when a TCP segment
> with the CWR flag set. This is wrong because SKB_GSO_TCP_ECN is only
> valid for RFC3168 ECN on Tx, and using it on Rx allows RFC3168 ECN
> offload to clear the CWR flag. As a result, incoming TCP segments
> lose their ACE signal integrity required for AccECN (RFC9768),
> especially when the packet is forwarded and later re-segmented by GSO.
> 
> Fix this by setting SKB_GSO_TCP_ACCECN for any Rx segment with the CWR
> flag set. SKB_GSO_TCP_ACCECN ensure that RFC3168 ECN offload will
> not clear the CWR flag, therefore preserving the ACE signal.
> 
> Fixes: d474d88f88261 ("net: hns3: add hns3_gro_complete for HW GRO process")
> 
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index a3206c97923e..e1b0dba56182 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -3904,7 +3904,7 @@ static int hns3_gro_complete(struct sk_buff *skb, u32 l234info)
>  
>  	skb_shinfo(skb)->gso_segs = NAPI_GRO_CB(skb)->count;
>  	if (th->cwr)
> -		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ECN;
> +		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;

Similar question here. Does the above need to be paired with firmware
changes to ensure that the actual GSO packet contents will match the
ACCECN flag?

/P

>  
>  	if (l234info & BIT(HNS3_RXD_GRO_FIXID_B))
>  		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_FIXEDID;


