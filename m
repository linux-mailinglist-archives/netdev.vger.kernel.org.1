Return-Path: <netdev+bounces-167599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2081CA3AFE0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 04:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D73AE3AD0D0
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5346885C5E;
	Wed, 19 Feb 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP+OTTMM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA1135977
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 03:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739934179; cv=none; b=qI9jzaBP7HQ9hspgotuXcXuRfcbXiDU6HmlU6NPUiz/s7MXp3WX7Oo2F1+LFlkYIN7Ofzaq8L2ahCbf503D/q7neN7EFJKJcSoV9P6L1jTvEdi+lVTMuuGQjJry7aLu90dFZiGP79pVpKSWmqdW7N2JL4IIuBS9euSEZOaTFfxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739934179; c=relaxed/simple;
	bh=RsmX1l+teidMolSiQ3jyBLMn4vFDbeN7Oja9uRjcKfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X22OyRVac9M93N5YxZ0pXMV6YZ0jMDKnwpmOJdvf87jnZQdN2rf6l9P5B42ddyYLYMAUrXyy/AypJbtB1heiACzB2kRgF0GSJEs1MJMTzYJkc7p5s93YKDqQabEvPIACxsjxwsJCnSoI/w5bxYtl2PU9nUBx9DbCpmnq2RvR/uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP+OTTMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A83C4CEE2;
	Wed, 19 Feb 2025 03:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739934179;
	bh=RsmX1l+teidMolSiQ3jyBLMn4vFDbeN7Oja9uRjcKfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aP+OTTMM+8x3XYo7ti9M6a7EvMFvrkO6JGW3wevGkqSkC6FI0UFB6mfOjdMez4+eM
	 JNdJKuBnncK8BpImgqrtq7w9N0Kgy4O3+Tr5tMjesWYxk7+y3AQKy72YaZ6UR2l5/U
	 MMMrOpxaNgwTKxM7O1W9tVw6xcOLHFsTIV6bvFVYfzBljUiAbQ3DvWhRb8jPSheauh
	 viMVHFR2LEMpL/h9BFuqfEaM1MNR8+5aCa1CSV95LlkqP44IvvXA8EG3uCmwMgj1FB
	 cOvyyE+gyQl6vWbhnmUdTi8hlT3Fli3NGicmhGl5hGFnF6kG2DQKEOf2sD7FtYdR9+
	 YfR8/j2/DWeAQ==
Date: Tue, 18 Feb 2025 19:02:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v4 07/12] net: hold netdev instance lock during
 ndo_bpf
Message-ID: <20250218190258.5c82026b@kernel.org>
In-Reply-To: <20250218020948.160643-8-sdf@fomichev.me>
References: <20250218020948.160643-1-sdf@fomichev.me>
	<20250218020948.160643-8-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 18:09:43 -0800 Stanislav Fomichev wrote:
> --- a/kernel/bpf/offload.c
> +++ b/kernel/bpf/offload.c
> @@ -528,10 +528,10 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
>  		return ERR_PTR(-ENOMEM);
>  
>  	bpf_map_init_from_attr(&offmap->map, attr);
> -
>  	rtnl_lock();
> -	down_write(&bpf_devs_lock);
>  	offmap->netdev = __dev_get_by_index(net, attr->map_ifindex);
> +	netdev_lock_ops(offmap->netdev);
> +	down_write(&bpf_devs_lock);
>  	err = bpf_dev_offload_check(offmap->netdev);
>  	if (err)
>  		goto err_unlock;
> @@ -548,12 +548,14 @@ struct bpf_map *bpf_map_offload_map_alloc(union bpf_attr *attr)
>  
>  	list_add_tail(&offmap->offloads, &ondev->maps);
>  	up_write(&bpf_devs_lock);
> +	netdev_unlock_ops(offmap->netdev);
>  	rtnl_unlock();
>  
>  	return &offmap->map;
>  
>  err_unlock:
>  	up_write(&bpf_devs_lock);
> +	netdev_unlock_ops(offmap->netdev);
>  	rtnl_unlock();
>  	bpf_map_area_free(offmap);
>  	return ERR_PTR(err);

Any reason for this lock ordering? My intuition would be from biggest
to smallest, so rtnl_lock -> sem -> instance

