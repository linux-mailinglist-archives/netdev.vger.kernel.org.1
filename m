Return-Path: <netdev+bounces-221370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D0CB50583
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A41547A49
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29230301492;
	Tue,  9 Sep 2025 18:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="EboQ7x1c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700DA3019CF
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443511; cv=none; b=KtqtMR/651lLFzhBKQXg+zamu09+S4767Vi65lc9Fz5abzwHmpy714Cx12E05//s1XBbQrL3/g+0GytrCJDlY3Ni6opXrxt82Rf5b4MlKpOe6VaGX6roZfNTrxYv15wyK3dhxwnFV9a0QXPEwPwHFMLuPhOqd218KPlwU5ST8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443511; c=relaxed/simple;
	bh=ELhCpGURmEZ0qDE5+JbrvimAqXiUNXZVVk/weXlRNXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph62ViCPmV6avTc5nen0UtMVunV4avsbXDgsZF/rozVqt7BppKXHt6Ox8qe7TcXv2di+Kb1g8paF7r9WVr9CZUnmvzI7KHuF6LpVmfSAO6mcNJ+TVeuclsHTP55oLlOHBRmWbltH/dDMpDPLWOb72eONCJkkaXJOII9G0WaOWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=EboQ7x1c; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55f6b0049fbso6747706e87.0
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757443507; x=1758048307; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/BpXy00opGRVLyvdGIrHoQ40ONgsKK/Q8KgnmsNF6U=;
        b=EboQ7x1cLAlBBD5sNJfhj/g2Y8g9g6n0+rFZiONugkveiPGjxjs0RMhibxrtuRBkQI
         kS+bUqUHgh+px65axpPPRYCUlBsQ0VmaBj0tdPm1eU0F2ErsAiUSCSSq38T7dnXNBEhh
         w4bx26o2bbIEFKsg8ng8iKgX0cIdtHXClx52OqJV26mYetXbgQLApVDIqLP1zqjO/crQ
         NfdBFERZfNbBWdw2ePYxde39Z8mnRwcKu+kQLjv6TmLqFXvfNH9+MRfF0DpTYgocjm4I
         fUA9vsHuGPk0YoiuTUgWZgYeQuxMFHIY3c8pOI/DTQpc1KBlHGTTgU3HAzASbx3jTOMe
         oWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443507; x=1758048307;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/BpXy00opGRVLyvdGIrHoQ40ONgsKK/Q8KgnmsNF6U=;
        b=ZTic2MubGp6hBHRRI6h+pK5ucfp2VEs6vY5NQ/F8io3dScd2ChtPaXwYmQ421JEdSR
         c9ifBCkNhKQMtMJeBrKiSsMz74OZMGV14BY887eOoKAsTlSG+HYQqwbRc93HGNG1dt/j
         ycw9zRGuvjnC1lYPMm4SKjYZMT/Kz9weP6Vg+P7cB/efKr2p2AFLt1aLQZ7BAL8E2G0+
         NClTBh8fwn6MuenKXu3oJX57oy3H0C+y3FySuFLeitp90FwP7A3oaygLhl50wl3rBDQN
         bXZcyimlFnbt1ZgESPuo1dyrSAvwXOsP65OwxTJFTJgfN4nBNzjNJlxZgvevleqJR3gr
         hBiw==
X-Forwarded-Encrypted: i=1; AJvYcCUcblj6gnyqzgsPQkfHxUpIdEGKS6bx95ZnacLGA116xnvc4/BUxOFbInV+UPagVUSyojOP2qM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FjcC4BbVk2Gfv3DdBmIFnbE+mdQ2gNbW9XYPJ4HCIEtkCB17
	9pUjx1Ole+5HryEYNYtuMM6a9EMbyEzBMb6Dbg8nJKULRWpwkz5qDl4CMEmDw8D2dgc=
X-Gm-Gg: ASbGncu/01atehOvQkbdAxcN3ssQTCunqR+rN//3xdpQx2moONmPDUUSKVjmp0hDpIn
	NHMnExKgGffB7uQRRMF5hnT57VnF7ystsUpdn2E3lSw9UDgZ+ASJvZK+uixA9TgN5o19UrkXU3B
	DF1IDIjivD9ZjLm8lHaRbRUoTODVr3M3wKFd78SmGrpRg9tgTH2m7Rpy27q16g7h8xifdjZC+dP
	zOYSV98mNEe6TfXVW/aIuS9k54/Lfjym+pbWMdrRo+ApLECGfuzICBo+QzTphD2PQbJHEpiLWCo
	+KkzH3HVcn6r95eb8Rvz+PXOvQ/P2+A7VEu20+/3AdRVAqRRa97793RrGWtjAmR7RpqnIkoFiIM
	6ext1uuJvLaUBYiDrKEOqd804zDgETcdvqGveoOSzCDX/rcpNsfjNUM/9E5IvYK2p/viQP/hZ5n
	N6i+/2BqST1ciF
X-Google-Smtp-Source: AGHT+IG3FhB8wUTg33iTiXWNmG8OlkLsweyMQJMyaf5VudFYD/YUJhl6f05flBYFp+BFv6453qTJUQ==
X-Received: by 2002:a05:6512:3b10:b0:55f:4fb6:20af with SMTP id 2adb3069b0e04-562639b64a3mr4755107e87.51.1757443507374;
        Tue, 09 Sep 2025 11:45:07 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5681853d17dsm666564e87.116.2025.09.09.11.45.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:45:06 -0700 (PDT)
Message-ID: <3191547e-6f63-4d0f-870f-6fba9c97e7c2@blackwall.org>
Date: Tue, 9 Sep 2025 21:45:04 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 6/7] bonding: Update for extended
 arp_ip_target format.
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-7-wilder@us.ibm.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250904221956.779098-7-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 01:18, David Wilder wrote:
> Updated bond_fill_info() to support extended arp_ip_target format.
> 
> Forward and backward compatibility between the kernel and iprout2 is

iproute2

> preserved.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>   drivers/net/bonding/bond_netlink.c | 30 +++++++++++++++++++++++++-----
>   1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_netlink.c b/drivers/net/bonding/bond_netlink.c
> index 28ee50ddf4e2..1f0d3269a0b1 100644
> --- a/drivers/net/bonding/bond_netlink.c
> +++ b/drivers/net/bonding/bond_netlink.c
> @@ -660,6 +660,7 @@ static int bond_fill_info(struct sk_buff *skb,
>   			  const struct net_device *bond_dev)
>   {
>   	struct bonding *bond = netdev_priv(bond_dev);
> +	struct bond_arp_target *arptargets;
>   	unsigned int packets_per_slave;
>   	int ifindex, i, targets_added;
>   	struct nlattr *targets;
> @@ -698,12 +699,31 @@ static int bond_fill_info(struct sk_buff *skb,
>   		goto nla_put_failure;
>   
>   	targets_added = 0;
> -	for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
> -		if (bond->params.arp_targets[i].target_ip) {
> -			if (nla_put_be32(skb, i, bond->params.arp_targets[i].target_ip))
> -				goto nla_put_failure;
> -			targets_added = 1;
> +
> +	arptargets = bond->params.arp_targets;
> +	for (i = 0; i < BOND_MAX_ARP_TARGETS && arptargets[i].target_ip ; i++) {
> +		struct Data {
> +			__be32 addr;
> +			struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS];
> +		} __packed data;
> +		int level, size;
> +
> +		data.addr = arptargets[i].target_ip;
> +		size = sizeof(__be32);
> +		targets_added = 1;
> +
> +		if (arptargets[i].flags & BOND_TARGET_USERTAGS) {
> +			for (level = 0; level < BOND_MAX_VLAN_TAGS ; level++) {
> +				data.vlans[level].vlan_proto = arptargets[i].tags[level].vlan_proto;
> +				data.vlans[level].vlan_id = arptargets[i].tags[level].vlan_id;
> +				size = size + sizeof(struct bond_vlan_tag);
> +				if (arptargets[i].tags[level].vlan_proto == BOND_VLAN_PROTO_NONE)
> +					break;
> +				}

indent seems off

>   		}
> +
> +		if (nla_put(skb, i, size, &data))
> +			goto nla_put_failure;
>   	}
>   
>   	if (targets_added)


