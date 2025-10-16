Return-Path: <netdev+bounces-229880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6333FBE1947
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 07:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F43B19A5FFE
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 05:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787A823C8AE;
	Thu, 16 Oct 2025 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av5qglZ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF2B23C50A
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760593885; cv=none; b=ZN5OJnPm/xbRMbJ3HFCeObVjL9xiZEDWVgzJElULtMgaup1PGEsXlu9XM8uPLmCxiWt45n+QpYtlPxaoDY1879jXX/0R9s7FyX1Cv7abIybA+FdeRYzyi8Z1T+mochRfrHEtcZ/9WGwV7HZEUtdMusZRoZbysuH1SPm01HJ4reY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760593885; c=relaxed/simple;
	bh=35osGfz/UsYcs0vz8qgxIDHEkFfXYEwqGsdTSelz8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHmtfwOZiQGn6QUhmdzcGTv7BmNwqp+mv6MZ7SVuc9ZEeGyGJyo30OYCvI1Ckp00+p37lMt9noC+Cemm2Wz67aybnNpsUZpczLlbXppiS53jRXAl2OO2fUEO3D+zowTOS2aalSjI6c3bK0iY8v8lDWB7ckuMNjOV/60p5SwPCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av5qglZ2; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781010ff051so289655b3a.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 22:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760593883; x=1761198683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aSZMq5yMmVuZb+oZWLLy5zaeLBOUS7zf/wmcWk/+aM=;
        b=Av5qglZ2CHF8LJJ0YZOWgNmTsIjB5WNcfE+HtnhJJIP5JAR3AFmmR42fZri0/vR4an
         3jN2he8NiemFMacl+ofHLnNN3vidkpb5ljxeY2ViY84C3EHPhhjviar/pROME0mnR+5F
         x053/6ohLSo3G4BPny4Bu4oMB0R6ql6dY4YlUUbB1ql5pVhfXOwheb46wGN+EKP3KaIV
         MXcu1NjgW1Rbm9PXIzh9KBm9L3G1uybH1z4no2Jqhj79XEYtf8xgDmz44iUStzvMgiBY
         hlScS9ZB87kpl/HKqPFOtF6xXSBngpVyz209ZJGwlSOWWYeeR4nNPFI69q7M57/sTcw2
         gKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760593883; x=1761198683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aSZMq5yMmVuZb+oZWLLy5zaeLBOUS7zf/wmcWk/+aM=;
        b=DQ70yM38L1i8B5+6rbdW0Zy7r2Cf+/o4aYhMAB/bafUNNTgK6VqGdBFiv8F6A6o7Yu
         Uvj2D9EuLrU8wRS9w+OdQ88NEQVyKGEJ0JsfAD1jcKrFGFCDDYAjkDptVJ06/dW3Fpx6
         CL+6gGbPYuTgWoqc8mA2E+KqNIixHgIK6rsDF6ATeVSf4DmRut6k5J1GlLwE+p32JiAt
         EPUv+5+EkehF/TN0wBdnIcgGP2ZQXnwDOQP+fxslskzUfvkAXLYkKTBo9ozDGJH32bjd
         G1Yj7Hjta9KzBV8UZC18MkpPigGfLlsdE+Jsi1SACVAGeHCVqENhy3LdSuKTRJPQ/lKp
         6L6A==
X-Gm-Message-State: AOJu0Yx5OODC1TIpzsuL1yOFEPkTJ5Hwchrj49PA7DASTfN6swiAa7Va
	7eHgIF0MF2dMiHDXZgy8EgBOtesni+RfqBf7Ln1AJFJteq+ocBokDFpV
X-Gm-Gg: ASbGncup98BxNNc71VANwbcIzy71fl/0N02kvATFRHWq7ijYSIv2rgKaE5Nf53hu9a6
	b5VTufhwel8PHgRLSLNPNc6ylbcqiooFCpsDg8l53hufh0SRSJa6y5mzByl5N7xVBw7qcyeqIea
	2G06oJtseA32dFZOWb4goWUnhJSTrCQLDKO8QzG4LHrirMjaKXvjbiDy3Z50sZzTm49kIu7jwKV
	Xg+7q54YWoJZ0+t7h70fyPvv57xz36lBZq6K8Ft/GIjWRGFavq+dMMm1uFV8/a+dXYk+RVdz5AE
	CtqjPWOTTYjpSLZMjJvA8VJJJi+syCE8+aQTTLk2w9azgS/n6rFJhwV3cCex5Igjb1M5rfHbFdl
	NkiuaatC3oeqwxRI8dM1ExMA11B88Bxj5i2FYdfPmHj0Lix5QaE9pwiRSifmoi88xs4sHsFP4pK
	hhUzfTMRre4ZjGnww=
X-Google-Smtp-Source: AGHT+IHoYIYfKQs2kLPcFuU9SabAPB/yy7cPpiMl1wJ7+ONtj6cWkNfTK7FekCzni2aMcYm2pToABg==
X-Received: by 2002:a05:6a20:72a4:b0:334:a180:b7a7 with SMTP id adf61e73a8af0-334a180b993mr539787637.42.1760593882925;
        Wed, 15 Oct 2025 22:51:22 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb19a14sm20969138b3a.28.2025.10.15.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:51:22 -0700 (PDT)
Date: Thu, 16 Oct 2025 05:51:14 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Jiri Slaby <jirislaby@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] net: bonding: update the slave array for broadcast mode
Message-ID: <aPCH0vHFqHmBQY_i@fedora>
References: <20251015125808.53728-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015125808.53728-1-tonghao@bamaicloud.com>

Hi Tonghao,

Please add the target repo in the subject. e.g.

[PATCH net] net: bonding: update the slave array for broadcast mode

The patch looks good to me.

On Wed, Oct 15, 2025 at 08:58:08PM +0800, Tonghao Zhang wrote:
> This patch fixes ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad").
> Before this commit, on the broadcast mode, all devices were traversed using the
> bond_for_each_slave_rcu. This patch supports traversing devices by using all_slaves.
> Therefore, we need to update the slave array when enslave or release salve.
> 
> Fixes: ce7a381697cb ("net: bonding: add broadcast_neighbor option for 802.3ad")
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: Hangbin Liu <liuhangbin@gmail.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
> ---
>  drivers/net/bonding/bond_main.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 17c7542be6a5..2d6883296e32 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2384,7 +2384,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  		unblock_netpoll_tx();
>  	}
>  
> -	if (bond_mode_can_use_xmit_hash(bond))
> +	/* broadcast mode uses the all_slaves to loop through slaves. */
> +	if (bond_mode_can_use_xmit_hash(bond) ||
> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
>  		bond_update_slave_arr(bond, NULL);
>  
>  	if (!slave_dev->netdev_ops->ndo_bpf ||
> @@ -2560,7 +2562,8 @@ static int __bond_release_one(struct net_device *bond_dev,
>  
>  	bond_upper_dev_unlink(bond, slave);
>  
> -	if (bond_mode_can_use_xmit_hash(bond))
> +	if (bond_mode_can_use_xmit_hash(bond) ||
> +	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
>  		bond_update_slave_arr(bond, slave);
>  
>  	slave_info(bond_dev, slave_dev, "Releasing %s interface\n",
> -- 
> 2.34.1
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

