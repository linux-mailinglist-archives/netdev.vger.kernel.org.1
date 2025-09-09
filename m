Return-Path: <netdev+bounces-221379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67659B505A3
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF273441808
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 18:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37753168E1;
	Tue,  9 Sep 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="cQU9u2uX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2FC279DAA
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444141; cv=none; b=pAdDUQ1qsBZA0sbQdl9wR/g5VIKKBZd989yQ6RmlAQpOEV2sTu3laxvfZh1NgOU1wUWUSR2+tPlg8P7xNfwuRh9m9hvQ8B/Ix5bRasVcvQsZ7Jg2vY9t4sIOxTy6Pj4up1SEGM1X56X/Ymmm8xChGkmfpw1t1rZW1RoJAl2v6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444141; c=relaxed/simple;
	bh=HsxQ4W3umwpUg8Vp3ikhZUCn4vtiieHjxAE/m0OpYeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RnBNGvCRQNxWrMTo4xaFD9EZe2MXtCfRUH85Cmdprus+/NgNDtCUVgG0ihdb/lc1CXWk6Ii/rBZrVIvWQ+hM6CRurJZvNUigV+SoSvUnNDDCg9FQnx96fChjTfb0FfnVgWQ9AgEpUK6gchrFDVEEabzm9kf0qBjGk5u0PyQAV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=cQU9u2uX; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-336b5c44a5bso59394201fa.1
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 11:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757444138; x=1758048938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M297Ti2au+sDZW9K2NwBF/ba4sNyc2eVtYryoGpMC7c=;
        b=cQU9u2uXP1DbuKF+XaYoQ8TKI+TNW3Cf92+TRJ6AY4rNJXX0YA+yM0IRB5BQwZHlf+
         ghcUrIzx91Sszxxe2YWSuP8PFOkb2AMXT2pNgt22o+WexOQSrieR/ishaJxYFybUx+sn
         cEVyBYbFgkY4spXm00LkdRzTLnOiFKMFDFT40+0090GcR/19HqAW51h7qDKega0z4u5I
         GJ/EuQr9RT24icHJ8bw129+/A0vySZAB8wKps5a8/4Bd2kDpmH9qU9qVOzdcFMRF2NbC
         Rx917Z+YkQ9IcTpoWvNHPYZlkC2Lf62hV+yQz6V+fE1MoCU6HMkeHmfKlWjqESq6ED9Y
         0xTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444138; x=1758048938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M297Ti2au+sDZW9K2NwBF/ba4sNyc2eVtYryoGpMC7c=;
        b=MoanrYa3A2+Jy+hEQbuoSWEDP6x54wiKLtq8N/mOqeWC2rxGd5amlH/sq1eowu78Fj
         gfddcF0I/qINLBtKsMUkaYzoJ9UignET9t9SJXQxjzVeZHRqFF/Fz2nCcLueaKsgecyB
         X54r1vUzRjACxWg0sL5qzhJfUBv3bTJ6FAha9oejuNFMzcwBfmC8g53eonh02xITZxiZ
         5V9fn8XBgujN0TiDVoLukL/2rL1JUC4e+k6P+2w704wulxp96x7g74hmECNkZkZZjatT
         LyqO+ib6UBVU4nXSxLxg2JXesKWBCDEBV2gDbnkXmtXNNgcgjRvTuvC/LaHq34thnhxC
         fP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQXUBuTekc+EtxJePFP4RzcrDA4eK/ZSdtfdxH+jRki2Ip36WVvqYNcUVbGZw3H11rqrFl4NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthBBfPhHS9/VIlzuH0ssoNq7rG+gJSZG2iDU4AYDM2JEA4zDc
	PNoUCIV580zc9N9SzJael5P2b/Zyl32tNtFAAt0Xjpi5iXKYOAflI8L5eSlnYi5+W5c=
X-Gm-Gg: ASbGnctclUPNyaS3hFNPN/KMI3dFhr5QGDyB0wc7XE6aSJOOsmeiW7mCx1CxCNBbKSL
	pjQqT1zcy1y8YJRlC+4ZgoL8qnscAZJwIWQFXOtAoGrPikf0wQ3dd+C8JBRoU61eqrQEueNhVyO
	HzQiPofC+DNzssreSasLrrcjo/p6s3Ih8TknTw0XqmYqF0SDTd8eOCUNBZlHh9jNpCj0LbdhYrh
	2XxLf5LYtO6h43TPn2WlLkGwOraZ1vyEcg9hhNe3UueLwedfd3vw/E7nhvjBoZlebQbX5x98Qlv
	cuuiaOv7VESgG2yTYQ9nJR6+kTbUZCtkr5slBkNgoP9DqPHvFrqv7s/av9lL5ZqwezrPu3q5f9t
	O/yfT4D0JBI5TlCrAG95B0p9x5ocinfXST2EFwvz3hMXDsc0VU7nD8e9Bi2fPfom52993lh8rFp
	PeRQ==
X-Google-Smtp-Source: AGHT+IEYn14F1g5y38ut8NvNsPOCh13jJxZ4g466s8Z2fx4SSE93KrpkKaxd0avvB8TAouF/kO2W7w==
X-Received: by 2002:a05:651c:211e:b0:335:352a:3c3 with SMTP id 38308e7fff4ca-33ba999ac7cmr32720311fa.8.1757444137930;
        Tue, 09 Sep 2025 11:55:37 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f4c90eb9sm39593781fa.22.2025.09.09.11.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:55:37 -0700 (PDT)
Message-ID: <2c0f972a-2393-4554-a76b-3ac425fed42b@blackwall.org>
Date: Tue, 9 Sep 2025 21:55:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 5/7] bonding: Update to bond_arp_send_all()
 to use supplied vlan tags
To: David Wilder <wilder@us.ibm.com>, netdev@vger.kernel.org
Cc: jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com, pradeep@us.ibm.com,
 i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
 stephen@networkplumber.org, horms@kernel.org
References: <20250904221956.779098-1-wilder@us.ibm.com>
 <20250904221956.779098-6-wilder@us.ibm.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250904221956.779098-6-wilder@us.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/5/25 01:18, David Wilder wrote:
> bond_arp_send_all() will pass the vlan tags supplied by
> the user to bond_arp_send(). If vlan tags have not been
> supplied the vlans in the path to the target will be
> discovered by bond_verify_device_path(). The discovered
> vlan tags are then saved to be used on future calls to
> bond_arp_send().
> 
> bond_uninit() is also updated to free vlan tags when a
> bond is destroyed.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>   drivers/net/bonding/bond_main.c | 22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7548119ca0f3..7288f8a5f1a5 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -3063,18 +3063,19 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
>   
>   static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>   {
> -	struct rtable *rt;
> -	struct bond_vlan_tag *tags;
>   	struct bond_arp_target *targets = bond->params.arp_targets;
> +	char pbuf[BOND_OPTION_STRING_MAX_SIZE];
> +	struct bond_vlan_tag *tags;
>   	__be32 target_ip, addr;
> +	struct rtable *rt;
>   	int i;
>   
>   	for (i = 0; i < BOND_MAX_ARP_TARGETS && targets[i].target_ip; i++) {
>   		target_ip = targets[i].target_ip;
>   		tags = targets[i].tags;
>   
> -		slave_dbg(bond->dev, slave->dev, "%s: target %pI4\n",
> -			  __func__, &target_ip);
> +		slave_dbg(bond->dev, slave->dev, "%s: target %s\n", __func__,
> +			  bond_arp_target_to_string(&targets[i], pbuf, sizeof(pbuf)));
>   
>   		/* Find out through which dev should the packet go */
>   		rt = ip_route_output(dev_net(bond->dev), target_ip, 0, 0, 0,
> @@ -3096,9 +3097,13 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>   		if (rt->dst.dev == bond->dev)
>   			goto found;
>   
> -		rcu_read_lock();
> -		tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
> -		rcu_read_unlock();
> +		if (!tags) {
> +			rcu_read_lock();
> +			tags = bond_verify_device_path(bond->dev, rt->dst.dev, 0);
> +			/* cache the tags */
> +			targets[i].tags = tags;
> +			rcu_read_unlock();

Surely you must be joking. You cannot overwrite the tags pointer without any synchronization.

> +		}
>   
>   		if (!IS_ERR_OR_NULL(tags))
>   			goto found;
> @@ -3114,7 +3119,6 @@ static void bond_arp_send_all(struct bonding *bond, struct slave *slave)
>   		addr = bond_confirm_addr(rt->dst.dev, target_ip, 0);
>   		ip_rt_put(rt);
>   		bond_arp_send(slave, ARPOP_REQUEST, target_ip, addr, tags);
> -		kfree(tags);
>   	}
>   }
>   
> @@ -6047,6 +6051,7 @@ static void bond_uninit(struct net_device *bond_dev)
>   	bond_for_each_slave(bond, slave, iter)
>   		__bond_release_one(bond_dev, slave->dev, true, true);
>   	netdev_info(bond_dev, "Released all slaves\n");
> +	bond_free_vlan_tags(bond->params.arp_targets);
>   
>   #ifdef CONFIG_XFRM_OFFLOAD
>   	mutex_destroy(&bond->ipsec_lock);
> @@ -6633,7 +6638,6 @@ static void __exit bonding_exit(void)
>   
>   	bond_netlink_fini();
>   	unregister_pernet_subsys(&bond_net_ops);
> -
>   	bond_destroy_debugfs();
>   
>   #ifdef CONFIG_NET_POLL_CONTROLLER


