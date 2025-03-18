Return-Path: <netdev+bounces-175651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB233A66FFC
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D9D880266
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F376720766A;
	Tue, 18 Mar 2025 09:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iG0iEvUL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952601F8BC8
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290603; cv=none; b=d5m2nrFyb/NXpHMV6ce/NnktjYxE0Egq421+hL9A/F/A5gChmoEa0O8oqUozqumCxvzCtOnujpnD2NN3JVi/101yWH2tFj4eyxlMKYuJCxGPyO3lwJL0bg9YJ8Ikm2VTcueKYdwfTYPstLx+3BMdQ1EWLBL+F6BJ/aJBJvjS754=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290603; c=relaxed/simple;
	bh=mzBMBkkZzeq6MOHImrnUvgj4qWJoLUYsd5OZKQZmC1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbJOBq4VyRhrRoNWf0yAgWKL66VYdVXKrpUln9xlxJXjCO/fd5l+y0DciRZl+Qs3EeBsHIdm+cz10YPrz8t1aAgtWGDYUnt5RnVosuauXjtbpr83+v0v2k0zXzyQQM0ixr2eRC4PUdF52OvDtEs66611gBVZoZz98+UuHI1E3Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iG0iEvUL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742290597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
	b=iG0iEvUL8+VtbE6zdFVucDa037degQVqv658HHC5kf1BECEbMRf048UYfDFyIHQPLs+Qb/
	lW290sToxyACbUk0oObJSSR8cIgv6fyJXrL/TkcpzPIx+mLtBVMQ2h6zo/miiQ4UdII0tm
	GFNfG/FRE/4KVJuHZ5w5SogkNKF7nMs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-R8LWOmYVMGSZCBvOLw059w-1; Tue, 18 Mar 2025 05:36:36 -0400
X-MC-Unique: R8LWOmYVMGSZCBvOLw059w-1
X-Mimecast-MFC-AGG-ID: R8LWOmYVMGSZCBvOLw059w_1742290595
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43d22c304adso13331685e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742290595; x=1742895395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvKDg3JDHn9jOPRmkfFXXZUafsnEo6j8hP0TAoVHOek=;
        b=Gp2yejBrqau0umpVK8khjrowDFsbm7TnwkFRke1n3p+RTbiMo+wZyIjm/c2TFR4LSe
         66HKesFctAGudBOdXmv/TzVGjS8k8k8MWrDXkfDi9XscXWP3eX0RnY0qn2CXOl2xGznN
         q1C2aiagMt5LPLk+HyIMr/gmKLlprsHOxKmSS220/eKBNthFwXjHtBZdq+xDV59R+ike
         WrlLc2oRMLmgRM72YiUm8YWectin+m0jcARyKxEsYFBKcVtn7Kyyi5lSfFrDa6PuueBT
         ncI7wq+MZ6MWashLXwgSj5FGJlPJbLZ0Ijg7+q7V6O4PoLkpoZqXkkHhUK/yPejVv/1b
         vO3w==
X-Forwarded-Encrypted: i=1; AJvYcCVFQW5Zhdtnl6egwL1c5qzzmh306xnUcI26cjShcuEQ2xBYrc/H2Wrh5z49rBJXTyq1LkyoOZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxikPYCHD62JCsHPYofFg8h+N7uybTh9RSWUS2p1t1boZJ7bX85
	aUrQ2wBWOx/C+7gHYcWyDnq123xu814Eq3AcdPZSMwl7biiKq/lSWj5Z+rx6FpZivNoQdZ/djfu
	IbTCW2lMqJ4hHyz+GK62yZXwl/lI6iZG6brAxyOn/iX4d2cjpR20Ujw==
X-Gm-Gg: ASbGncs1K3cnLp0iZ/nS2xDa5NKqim6o0pN4VwR42lT+e5Y6ahDjMF+BzzQNdasr80n
	5+CL1ySF9+9e51usMRyekvWNUc3AV+t99Hg620FdUK9vFILWatGrVGJWn7K/hF2O+sKUc+lGegU
	lTd6EbvmcZdw+s1rIiXC9cueO3rLip8zYKBL/sAz5E1GI1q2uM0IJl1jryxgbI6xDn4X0PPgGUD
	KZ4Qv6kHvW2zm5GUh+iSU/t8CX8yUeGdZhYV4ytajZ9hQowpYxk2wNgDd1CLnzjdTU3kbDSa0qJ
	vrEzK+ZQI5SsziCxHPVBz7nTzF4Cd2sp6AHVspHePP4G9Q==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252785e9.4.1742290595254;
        Tue, 18 Mar 2025 02:36:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3vTKKmwKw0Z8Ob8YbB5NUPivxHGNKx120DzCxn23HNlzcDtLNTUy32hinrYTNPH+w/sR52A==
X-Received: by 2002:a05:600c:4f4a:b0:439:8490:d1e5 with SMTP id 5b1f17b1804b1-43d3b981324mr14252415e9.4.1742290594821;
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d28565b17sm94485335e9.37.2025.03.18.02.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 02:36:34 -0700 (PDT)
Message-ID: <65bfbea3-8007-43ec-af58-2d61f5488a88@redhat.com>
Date: Tue, 18 Mar 2025 10:36:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add support for setting parent of
 nodes
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
 <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1741642016-44918-5-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/25 10:26 PM, Tariq Toukan wrote:
> @@ -1018,3 +1018,105 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
>  	node = parent_priv;
>  	return mlx5_esw_qos_vport_update_parent(vport, node, extack);
>  }
> +
> +static int
> +mlx5_esw_qos_node_validate_set_parent(struct mlx5_esw_sched_node *node,
> +				      struct mlx5_esw_sched_node *parent,
> +				      struct netlink_ext_ack *extack)
> +{
> +	u8 new_level, max_level;
> +
> +	if (parent && parent->esw != node->esw) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot assign node to another E-Switch");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!list_empty(&node->children)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Cannot reassign a node that contains rate objects");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	new_level = parent ? parent->level + 1 : 2;
> +	max_level = 1 << MLX5_CAP_QOS(node->esw->dev, log_esw_max_sched_depth);
> +	if (new_level > max_level) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Node hierarchy depth exceeds the maximum supported level");

Minor nit for a possible small follow-up: it could be possibly useful to
add to the extact the current and max level.

/P


