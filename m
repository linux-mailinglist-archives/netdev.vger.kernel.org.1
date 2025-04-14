Return-Path: <netdev+bounces-182045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336C8A877BC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B8A7A1C09
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197EA191F95;
	Mon, 14 Apr 2025 06:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgiR4Wde"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9667428F4;
	Mon, 14 Apr 2025 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610808; cv=none; b=oQzVpdje7Gg379hbD+9vSp3f3JlGIi5ADT6eNEqlHVg9kG+7Kqfb/8xR8nYqZXlScJNS7Nyz8ZSB0s41dfu5JoZo/DtF4dXWVbsoxklKLVrOQVZToLFMuq0S/+wP2+kePT67DJK1sOrgSXNmVTRYSwsZpcclold4X2VpqOl4VtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610808; c=relaxed/simple;
	bh=9mJ1ouKP6AUJco+IEEwgsZRlDCRhET75JLATzGghxnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsQOUf9dRNMM3RosvKRo2IJjMMF2xSvsThRYK8ndfzlSt2wg+mCfhiDgnHxZCd/eR6JwkYasuAis48GSYJP7mwaoEzZ62x3QhRP6wKagbCg7VL2roT51MZ5+TqmNOnVCo/CCSAdZM9vV7jTf4OPfE3bvEcYeguSUV0GFV/RY35c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgiR4Wde; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22403cbb47fso40012775ad.0;
        Sun, 13 Apr 2025 23:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744610806; x=1745215606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxIaHbBXZ+RwgLgvB4tQny1ra/FHDti7NjCX7XAn8CI=;
        b=lgiR4WdewkCN8KItHOYLXd7fkB8WSnrz6OY+5tch8oZPpLXZ62wzLjRd0REtJGQfbg
         pOnBVzB540qKww+ERekMNh3oHJEGRZakdUJsZcain1Mb3hclWP55MFptP5gPaFTk611t
         6wAlBeSEOeRyB3AYhYOWj1qr0xhYd9z0+Xh/uvqE2V3rPdKIw99YuGo3o2u52kyHg9E2
         eQTvch/I8vAMS8iBRqnzW8Ol3f4q6432Y2+TTeYOJDLxjh7rYxg8LSwcL7dhmXA4Bd1S
         Ya3OPEA99nKXy3E82kLJSVbX1FMtju+LoBix/yNBQFxBjCXIMH7t91D8C1zYDadFCJJ0
         dXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744610806; x=1745215606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxIaHbBXZ+RwgLgvB4tQny1ra/FHDti7NjCX7XAn8CI=;
        b=TIkfH6LXdb6oSvb9u/VjPU7FVISFjnv+sMtBaAAPoD0h/5u5o7Cg3e7r0wyoLxTXDN
         199fcXSd3Cu9JmMgcs1bJZfZFQVXH+xq0c+bSGIyYbIdDem6ixAykPI/eakZWyd3XH8M
         c46Xm/9fvXRo/LMrm+Qtx7BxNG2u19iPJtPT0luexB4DtXcnwpeHTewX8ShN4HMrFJ9e
         vJatCMNVNMvSZgiiOew5n+VoGbCcuj5/+o/XykTArvugcJB7dY9kmNMVtgRpYuu0KzLR
         iAgaSVWFo5ohxLSyrGCERjHikF24cn2sSm4Z1DsKEUEthgD+nT3Ok1lkktebWCvarBv1
         Lfxw==
X-Forwarded-Encrypted: i=1; AJvYcCUvkZDIk8IAc69wXurIill/2gpi9B3DkW2CDrVJ+1Wb89iM31lHvHbZAqamNC49Wyh15gSNTW4+eGIOauA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRU3w5Y8g9rB7bTj6Ce+QRhqpUfKfGItr3kAnCc4zeD7sagpSy
	eEKu5Y34tLC14qJkthnNIpfDCqciK7A59HvLaBZ4e6/1xCIdIp6C
X-Gm-Gg: ASbGncvsgARs75Hi54e1OSnxaTTOxraR9vESvBbfObIiFZuVlO8Af42plVQ0GE8feD/
	tqFBS+l1HiH27zM6cKzc+VWNPmJmMDlXOOz7U2LGrBoY+o5LYtX3wwDg+uz88ffnOZoXwQRaveb
	h+b84xF5mlY1Q9XU2wze3dOG3l2plGfsdY4x1kegT0XqrCp7PSh7ayzzjlJC4Xkt22b+MBtOdRI
	TJMEQchV5jfTbQI6CcPolfSsTHPZOy4rnF3cj5n+zULTgNIzVaexpc6ZzefGzgATIMI6s9XmS9a
	xmKiR7F9w4LVq2IZn01mn5Qg722gIrILNbMnh2YDv6XhLYcXdeY=
X-Google-Smtp-Source: AGHT+IEqkd3bo9jG14/uA5feef7+vpo4LRa0tq592FJ1o8s6/vtXDY497Yo7Vmw0Crv9MiyXUqBpBA==
X-Received: by 2002:a17:902:eb8a:b0:224:1e7a:43fe with SMTP id d9443c01a7336-22bea50df42mr155742075ad.46.1744610805520;
        Sun, 13 Apr 2025 23:06:45 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb536bsm91840835ad.201.2025.04.13.23.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 23:06:44 -0700 (PDT)
Date: Mon, 14 Apr 2025 06:06:38 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Simon Horman <horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 net] bonding: use permanent address for MAC swapping if
 device address is same
Message-ID: <Z_yl7tQne6YTcU6S@fedora>
References: <20250401090631.8103-1-liuhangbin@gmail.com>
 <3383533.1743802599@famine>
 <Z_OcP36h_XOhAfjv@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_OcP36h_XOhAfjv@fedora>

Hi Jay,
On Mon, Apr 07, 2025 at 09:35:03AM +0000, Hangbin Liu wrote:
> > 	So this patch's change wouldn't actually resolve the MAC
> > conflict until a failover takes place?  I.e., if we only do step 4 but
> > not step 5 or 6, eth0 and eth1 will both have the same MAC address.  Am
> > I understanding correctly?
> 
> Yes, you are right. At step 4, there is no failover, so eth0 is still using
> it's own mac address. How about set the mac at enslave time, with this we
> can get correct mac directly. e.g.

Any comments for the new approach?

Thanks
Hangbin
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 950d8e4d86f8..0d4e1ddd900d 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2120,6 +2120,24 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
>  			slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
>  			goto err_restore_mtu;
>  		}
> +	} else if (bond->params.fail_over_mac == BOND_FOM_FOLLOW &&
> +		   BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP &&
> +		   memcmp(slave_dev->dev_addr, bond_dev->dev_addr, bond_dev->addr_len) == 0) {
> +		/* Set slave to current active slave's permanent mac address to
> +		 * avoid duplicate mac address.
> +		 */
> +		curr_active_slave = rcu_dereference(bond->curr_active_slave);
> +		if (curr_active_slave) {
> +			memcpy(ss.__data, curr_active_slave->perm_hwaddr,
> +			       curr_active_slave->dev->addr_len);
> +			ss.ss_family = slave_dev->type;
> +			res = dev_set_mac_address(slave_dev, (struct sockaddr *)&ss,
> +					extack);
> +			if (res) {
> +				slave_err(bond_dev, slave_dev, "Error %d calling set_mac_address\n", res);
> +				goto err_restore_mtu;
> +			}
> +		}
>  	}
> 
> Thanks
> Hangbin

