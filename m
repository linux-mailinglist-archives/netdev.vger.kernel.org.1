Return-Path: <netdev+bounces-88769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5A688A87DE
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59C9328762C
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97A15E1ED;
	Wed, 17 Apr 2024 15:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+99Pr3c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6E815DBC5
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368215; cv=none; b=M2cBQjN3ZT2HgbekhzVTmux4QBX9laDGGsye+Hcj66vODJkMIpwVIQ3Kl0XVzAiai2Olwaj65rwRvEZ4HQm61Cum8GIJoo/8ZWi0XEQUAwLqz4gwbZbqCgDzhIVONn5A+fU3i7nFFPfFZuDIM/Wg3MkWMtd/V4AEDiy6FweBEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368215; c=relaxed/simple;
	bh=VkAi+Oi4732nOvULuO6QyMuVfUyFo4erU9B5Jnc2p4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxB87evOD03LDLrk0nwS7VEKVFoX62AVC2yvCg4xseFvQk5jFwfpCNEZVZktRCG2D4dAPu7XP/8jnVTpVyhQof76Q9ShZTDHaS+zILJqCPfaWTjOSpGUwrs6/SO6O0SDM+jIqYKS2Zdk452+xaeLrlI7GD3Zu4P2EmJnT/RiEBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D+99Pr3c; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso9140919a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713368211; x=1713973011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bvO3DPqx3lPlx1hH5TlbDiIQHROw2ymM8pak9u0Y0jA=;
        b=D+99Pr3c6W7Sidd+fw/ApoUcPvUve3fxrOYJiWrGmBd/s/i3P/B1lTWzon+KKiNWBC
         1iPpBvRbZF6t0H+1K9LCrNujvObQ+CSpvJlk3UuJajZiLhJ5pR1JsDA4JxCYtZ/ed9v1
         5Ou7JcAYjhu/LCRlTsevx2wjZcqe9VR+rKT8S4KfnFfQLo2mop39j78wJe0qrgLcNUDO
         q0HR2ps4Z+nwhqEGv2exdD0nP7us6QXCzr8df4RP/yvZg2K4Aqc+rjQlue+cbUU0wdVR
         7nYEVHU/iL6yqtRoZiMRGwI0VRygCEu/pNc4nmqcPHSEW+xF7+cjSsd8KlYXEFBZ3YFG
         8NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713368211; x=1713973011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvO3DPqx3lPlx1hH5TlbDiIQHROw2ymM8pak9u0Y0jA=;
        b=lX5/qP1LlCiOHjtmaNcTeQgQA3ensaaMcMFwwaXbYLEo8aIrJEZ/r16WpVGmMrALc/
         rKMqInCk3RvsQwWyMa86Wk5AwIc/sTB5fXvs5igO8Ox/vTgp98qA9Xrs4tov46nCN8DT
         Px+C7GFOQC0vn4L9juhQ3tUN5c8QpUOnxpGuKTePQeyvK+mY8bQy4fwrCDMtnKJK18DM
         LdG6lrj7pxX5eG/SmsbjJ5udRL9CT0DcgQPXKX8xINiSjiuMybFB/bAaC5Pyi7fJ8jHU
         lqht3fij3dphzxgrWvyNaVvjaqPg372r2hpBhQwPoqRD3zI0lpr5v/TtQI0D9ZA/RBtn
         UTDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBEk3fad29VU7tcGDWT/XJBvayOl6U5lg1oiSu0blT7bjfvouHB0djl1adcG5mjai6GaE/uqYG4rHY8WkefijjSgtDFn6b
X-Gm-Message-State: AOJu0YxCu5YK0nLAr8HoWYKLo+lT3rE4PHFLswe2SCfGVXE8xKxJqaaw
	YZ8hV2Q8qa5gceq3PuDT76Oq59AYNlhffnLi6LqH/NDCAsLGL6nBDGsZBIPNppA=
X-Google-Smtp-Source: AGHT+IEdQvhkYcwfNYVttvD+PCK3mX+DoNc33SzybShtY3KJ9yRVUTT3HdyR6ktTrphXTccneM5pDg==
X-Received: by 2002:a50:8d0b:0:b0:56e:2e6a:9eef with SMTP id s11-20020a508d0b000000b0056e2e6a9eefmr13109528eds.2.1713368211355;
        Wed, 17 Apr 2024 08:36:51 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7cb86000000b0056e3707323bsm7327192edt.97.2024.04.17.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 08:36:51 -0700 (PDT)
Date: Wed, 17 Apr 2024 18:36:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Geetha sowjanya <gakula@marvell.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH 3/9] octeontx2-pf: Create representor netdev
Message-ID: <d5ce5cd4-3d4f-444d-be1d-e201c1439421@moroto.mountain>
References: <20240416050616.6056-4-gakula@marvell.com>
 <a55c4d98-030c-420e-b29d-3836e1ce0876@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a55c4d98-030c-420e-b29d-3836e1ce0876@moroto.mountain>

On Wed, Apr 17, 2024 at 06:24:13PM +0300, Dan Carpenter wrote:
> f9a5b510759eeb Geetha sowjanya 2024-04-16  132  int rvu_rep_create(struct otx2_nic *priv)
> f9a5b510759eeb Geetha sowjanya 2024-04-16  133  {
> f9a5b510759eeb Geetha sowjanya 2024-04-16  134  	int rep_cnt = priv->rep_cnt;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  135  	struct net_device *ndev;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  136  	struct rep_dev *rep;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  137  	int rep_id, err;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  138  	u16 pcifunc;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  139  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  140  	priv->reps = devm_kcalloc(priv->dev, rep_cnt, sizeof(struct rep_dev), GFP_KERNEL);
> f9a5b510759eeb Geetha sowjanya 2024-04-16  141  	if (!priv->reps)
> f9a5b510759eeb Geetha sowjanya 2024-04-16  142  		return -ENOMEM;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  143  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  144  	for (rep_id = 0; rep_id < rep_cnt; rep_id++) {
> f9a5b510759eeb Geetha sowjanya 2024-04-16  145  		ndev = alloc_etherdev(sizeof(*rep));
> f9a5b510759eeb Geetha sowjanya 2024-04-16  146  		if (!ndev) {
> f9a5b510759eeb Geetha sowjanya 2024-04-16  147  			dev_err(priv->dev, "PFVF representor:%d creation failed\n", rep_id);
> f9a5b510759eeb Geetha sowjanya 2024-04-16  148  			err = -ENOMEM;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  149  			goto exit;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  150  		}
> f9a5b510759eeb Geetha sowjanya 2024-04-16  151  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  152  		rep = netdev_priv(ndev);
> f9a5b510759eeb Geetha sowjanya 2024-04-16  153  		priv->reps[rep_id] = rep;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  154  		rep->mdev = priv;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  155  		rep->netdev = ndev;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  156  		rep->rep_id = rep_id;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  157  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  158  		ndev->min_mtu = OTX2_MIN_MTU;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  159  		ndev->max_mtu = priv->hw.max_mtu;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  160  		pcifunc = priv->rep_pf_map[rep_id];
> f9a5b510759eeb Geetha sowjanya 2024-04-16  161  		rep->pcifunc = pcifunc;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  162  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  163  		snprintf(ndev->name, sizeof(ndev->name), "r%dp%dv%d", rep_id,
> f9a5b510759eeb Geetha sowjanya 2024-04-16  164  			 rvu_get_pf(pcifunc), (pcifunc & RVU_PFVF_FUNC_MASK));
> f9a5b510759eeb Geetha sowjanya 2024-04-16  165  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  166  		eth_hw_addr_random(ndev);
> f9a5b510759eeb Geetha sowjanya 2024-04-16  167  		if (register_netdev(ndev)) {
> 
> err = register_netdev(ndev);
> if (err) {
> 
> f9a5b510759eeb Geetha sowjanya 2024-04-16  168  			dev_err(priv->dev, "PFVF reprentator registration failed\n");
> f9a5b510759eeb Geetha sowjanya 2024-04-16  169  			free_netdev(ndev);
>                                                                                     ^^^^
> freed
> 
> f9a5b510759eeb Geetha sowjanya 2024-04-16 @170  			ndev->netdev_ops = NULL;
>                                                                         ^^^^^^^^^^^^^^^^^^^^^^^
> Use after free
> 
> f9a5b510759eeb Geetha sowjanya 2024-04-16  171  			goto exit;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  172  		}
> f9a5b510759eeb Geetha sowjanya 2024-04-16  173  	}
> f9a5b510759eeb Geetha sowjanya 2024-04-16  174  	err = rvu_rep_napi_init(priv);
> f9a5b510759eeb Geetha sowjanya 2024-04-16  175  	if (err)
> f9a5b510759eeb Geetha sowjanya 2024-04-16  176  		goto exit;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  177  
> f9a5b510759eeb Geetha sowjanya 2024-04-16  178  	return 0;
> f9a5b510759eeb Geetha sowjanya 2024-04-16  179  exit:
> f9a5b510759eeb Geetha sowjanya 2024-04-16  180  	rvu_rep_free_netdev(priv);
> 
> rvu_rep_free_netdev() also calls free_netdev() so it's a double free.

Actually the rep->netdev->netdev_ops check in rvu_rep_free_netdev() was
supposed to prevent the double free.  But since rep->netdev is already
freed, then it's another use after free.  You could use a different flag
instead of rep->netdev->netdev_ops to mean "don't free this".  But
really, it's just better to write it how I have suggested.

My patch adds some duplicate code but when you remove the conditions in
rvu_rep_free_netdev() and the "ndev->netdev_ops = NULL" assignment, then
overall it's fewer lines of code this way.

https://staticthinking.wordpress.com/2022/04/28/free-the-last-thing-style/

regards,
dan carpenter


