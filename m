Return-Path: <netdev+bounces-278083-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHOoAhPy3GnZYQkAu9opvQ
	(envelope-from <netdev+bounces-278083-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F83ECA35
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D389F305DA45
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 13:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4423CBE63;
	Mon, 13 Apr 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fwZFNMk1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="k4c+wzs4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15304330D25
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 13:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087110; cv=none; b=OACshSFqPdKmNGp9w9og9x7Ts/bSaTLOo6InyXTcQeGuuO5ufVToJ8eC9TJwcoX/1s3Yqz6UbZ79iuvwnoAGELgwyQtUVJwFr0/AP19Kn/x/x4gGXreEScdkTm6cZvtlUMIb6/MYp++7kpP0gTpFb9cZWsUNi1s/LtIwyRkiA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087110; c=relaxed/simple;
	bh=xxT/fy6/UObnhRxc4ECkdOpyQ+/HUtxYSWW3PtJ0LQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mg2fAvQFzfRec3sr/cEtu3fREdsAkSaoHM2UK+1hiuPsu4fAZbi8dxr0vknkY8kjj1UqEN1oIGW6282c4JcvCRCU0mV3y1dagkPcAEUjxNUGuFkTI6VYMQ1AvmYOKBOMUFzyLekFkm0em+DUL8pcNyyvLDpuTYxjxuDoixPeoiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fwZFNMk1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=k4c+wzs4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776087108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FC7co2loVELcleMxkvuZPl6ziMWocTcQ0HRSUD7DVoQ=;
	b=fwZFNMk1w2sFx9CN3hB5CPlotp+k/JoEAODldOERfDWTV02A1R4m6jh+2MPRNg5UalcsN8
	H7CxUQLaSmO8M8L1Oz+CmvayiylxbUcRuFWkvrtiFDxcId9o/c5XU8sKOK1dQVJo9FUpKc
	Owz0azmbyU7MZCGaOyY+VauRfoxRHr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-Ggrl2Vf5PQCz2tu6fSZaAw-1; Mon, 13 Apr 2026 09:31:46 -0400
X-MC-Unique: Ggrl2Vf5PQCz2tu6fSZaAw-1
X-Mimecast-MFC-AGG-ID: Ggrl2Vf5PQCz2tu6fSZaAw_1776087105
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d1fec59c9so2418389f8f.0
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 06:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776087104; x=1776691904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FC7co2loVELcleMxkvuZPl6ziMWocTcQ0HRSUD7DVoQ=;
        b=k4c+wzs4XFHtyjwK2VFJS9WEowGqnpjxR/B40/DvjT2iJrFhDO+kFEKR5P/cf3BAQW
         yf1GymJxHTjd7Ru7kkuf9b80y71UASPiJremjU49TGR+YXSrPSqPWwdEyqEIAoKx7WPq
         IH5SRI8ZXs8edpvdaQdrbdXlqDo3Gkmvw9r9PpDowYKoFSPy8HjITFJgSEviVSzMKOA5
         AV7lanBFLPRkam3RrI1BAItzVIgsocehUCa9FiQJPHIwOZ5B2HDL2PLVPExCVeVAMF1D
         rzRviE5Ssi1O5jPAkz2mQ2ZCzNLuUGF8uiBmiaRBQkzPd0Qk9Jlnxx6TqetHHcHswxmN
         meGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087104; x=1776691904;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FC7co2loVELcleMxkvuZPl6ziMWocTcQ0HRSUD7DVoQ=;
        b=GWULvvmyOVYix8g9ZoLKHyD+CGehMhi5YqiKx0qx3WpYUFXM7eeGo2HHekKYCoSyj4
         ggR9z4iBUZnkCO0hdd4WjI8VvmS53kE+oKU+f6pwi4wiIxtDTwNUdQb+5CwqXzeiQJ4H
         O5fJ80o/PLg4Ng5wVm976SBK0er3wTTcucIzCgY+GA5g/BLxZb81Hztu+XlD0eAU5NiE
         o4DdUHpbwTqM2+bwuMOTyGNT71m9an35/xUh5epIHyvf7QaRGXvI/aXzYemaFfChOfQl
         qTVyyw+4gKeGPzFBpDsoBEMN24SXJi0dSNq2pbvPNYtxddu4NQWxq6ZWqokIIK+OcdLK
         ctRg==
X-Gm-Message-State: AOJu0YwjaLVMKe2aFwrAvfgwGZDzTvTc5BHXq+vU/lESTp888Zqz05Jk
	KFJtb4L1GjdRFpSLkpd6ZbhEhI8zUK89zRVXoTYtIOsBt5czeMdvXGHD8Bj/7XHq5cgS+TlHiTN
	Xban5e+34RR2Hqfz2KKDqN6sv2Ozo32AJATA4UpyLCONSNv3zX9d4fRl0vQ==
X-Gm-Gg: AeBDietKcQpEWfLZN+fy0ulq+xQhERpHhwuugbFjNQBfiNXA4k+XozMC1g0piZ6YNBF
	L09GrwVhtdT8c7Rx2fyWNiJ/qS+XXkzhBY+LOgmnn/0Kg6h7XPfiu9d4FxsGLK8DaChZyluCPwA
	MPCyf32DrRPiAXfX2pjAkQEjUirP6jrftym1VuTonqSjgemuBPzxVK0f6xJ3QkTr50N6x5I9A6t
	/LXP2Z+u3eF2qJts+y9U0c2vqcEq6RAWAdv3FG2erNIDu+Sp2mvPsAMWmzzP7/vGYtK63jX5PnH
	pbEun3BSW4b+X8PlcxR2x2lrhKWOXX5NFpNKoNrowjm4i5/bv6R3PKmlEcre1FsByxz0BffWACs
	98cQnwgodkmS5osw37MNRltd/1D/jVdcJP/coIoFBcLPhUy2YbV3C2cvL
X-Received: by 2002:a5d:5f44:0:b0:43b:8e96:d3d2 with SMTP id ffacd0b85a97d-43d5958edb7mr23667137f8f.13.1776087104388;
        Mon, 13 Apr 2026 06:31:44 -0700 (PDT)
X-Received: by 2002:a5d:5f44:0:b0:43b:8e96:d3d2 with SMTP id ffacd0b85a97d-43d5958edb7mr23667080f8f.13.1776087103849;
        Mon, 13 Apr 2026 06:31:43 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46713sm34024811f8f.21.2026.04.13.06.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 06:31:43 -0700 (PDT)
Message-ID: <77d813af-bfc8-495c-ad50-7401b86065a5@redhat.com>
Date: Mon, 13 Apr 2026 15:31:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] net: mhi: Enable Ethernet interface support
To: Vivek Pernamitta <vivek.pernamitta@oss.qualcomm.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189@oss.qualcomm.com>
 <20260409-vdev_b1_eth_b1_next-20260408-v10-1-6d44ca48f189@oss.qualcomm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409-vdev_b1_eth_b1_next-20260408-v10-1-6d44ca48f189@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-278083-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7B4F83ECA35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:08 AM, Vivek Pernamitta wrote:
> @@ -208,17 +235,20 @@ static void mhi_net_dl_callback(struct mhi_device *mhi_dev,
>  			skb = mhi_net_skb_agg(mhi_netdev, skb);
>  			mhi_netdev->skbagg_head = NULL;
>  		}
> -
> -		switch (skb->data[0] & 0xf0) {
> -		case 0x40:
> -			skb->protocol = htons(ETH_P_IP);
> -			break;
> -		case 0x60:
> -			skb->protocol = htons(ETH_P_IPV6);
> -			break;
> -		default:
> -			skb->protocol = htons(ETH_P_MAP);
> -			break;
> +		if (mhi_netdev->ndev->type == ARPHRD_ETHER) {
> +			skb->protocol = eth_type_trans(skb, mhi_netdev->ndev);

Sashiko says:

Is there a risk of an out-of-bounds read or kernel panic here if a malformed
or fragmented packet is received?
eth_type_trans() assumes the SKB has at least a 14-byte MAC header and calls
skb_pull_inline(). If the linear portion of the SKB is smaller than 14
bytes,
__skb_pull() will trigger a BUG_ON(skb->len < skb->data_len).
Should we call pskb_may_pull(skb, ETH_HLEN) before parsing the Ethernet
header?

> +		} else {
> +			switch (skb->data[0] & 0xf0) {
> +			case 0x40:
> +				skb->protocol = htons(ETH_P_IP);
> +				break;
> +			case 0x60:
> +				skb->protocol = htons(ETH_P_IPV6);
> +				break;
> +			default:
> +				skb->protocol = htons(ETH_P_MAP);
> +				break;
> +			}
>  		}
>  
>  		u64_stats_update_begin(&mhi_netdev->stats.rx_syncp);
> @@ -306,6 +336,9 @@ static int mhi_net_newlink(struct mhi_device *mhi_dev, struct net_device *ndev)
>  	struct mhi_net_dev *mhi_netdev;
>  	int err;
>  
> +	if (ndev->header_ops)
> +		eth_hw_addr_random(ndev);
> +
>  	mhi_netdev = netdev_priv(ndev);
>  
>  	dev_set_drvdata(&mhi_dev->dev, mhi_netdev);
> @@ -356,7 +389,8 @@ static int mhi_net_probe(struct mhi_device *mhi_dev,
>  	int err;
>  
>  	ndev = alloc_netdev(sizeof(struct mhi_net_dev), info->netname,
> -			    NET_NAME_PREDICTABLE, mhi_net_setup);
> +			    NET_NAME_ENUM, info->ethernet_if ?
> +			    mhi_ethernet_setup : mhi_net_setup);

Sashiko says:

Does changing the name assignment type from NET_NAME_PREDICTABLE to
NET_NAME_ENUM break backwards compatibility for existing legacy interfaces?
NET_NAME_PREDICTABLE instructs userspace to leave the kernel-provided
name alone, while NET_NAME_ENUM signals that the interface is a generic
enumeration and should be renamed. Applying this to existing interfaces
like mhi_hwip0 and mhi_swip0 might cause them to be unexpectedly renamed
on boot, potentially breaking existing userspace network configurations.

please have a look at the full report:

https://sashiko.dev/#/patchset/20260409-vdev_b1_eth_b1_next-20260408-v10-0-6d44ca48f189%40oss.qualcomm.com

/P


