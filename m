Return-Path: <netdev+bounces-108569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E86992468B
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 19:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C612855A5
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366081C8FAB;
	Tue,  2 Jul 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpICmlnb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A501C0056
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941753; cv=none; b=AJ5MPjvaECmXWUUNPvUu/aWK5h3WRfTru7N8LZ6519DIvLrdocR05uixX5fia03gGMLpicJdzURy1yCjitFNWaH35TXtZOorL21ClIaiRdHSsNSn/IyrNtEjMqJcnOPKxkPHXhoAhmd21DrqJ52GqIsT54l9UVk2gBsq34rWQpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941753; c=relaxed/simple;
	bh=NEKrRKMOly4RyOqQW5DuHPtvTr5bAsYeA6jrfljXxzQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ToKj/MGOCiEuT6JlLPYy8yfptiPKx7BjzidQ7anXEQgJgYUusPDti97bPAPs4WGSdIhbVnxdF/TrSIfvM8NqichN9CXmGV+j6JfGACt3ckxV+kB2HLXwPx/5psIMpr8r6T9oNLP4w/M8XxHs4lLmQwOIXyt94Suk3D0qI9+53jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpICmlnb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-424ad289949so32595385e9.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 10:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719941750; x=1720546550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i9OdqMsbcRZ7kiShEp8RLl5kFE6Pk3vU6GTPf+SL3qI=;
        b=DpICmlnbNsF7jma4usdamdrbNWYjbQE6+kyqphEeBiH44yTJoA73mH1qNKNBPEFxnP
         RcuyrJs/V3IpDDnFTLS1hpWPe+dwtdzf+Tr3S9nsip3wVbFrYl6kT2NCComv1XIvAMTI
         oO70AKS+HOLQF7k8SS6Tb2VZVd9Dfqdf+YqXXxCLY7EhCYlKwE9Z0Qrg65Gq07SBIeNM
         ba6dZUI1w7eW2tqae+OPF15ATzYXZAGDXlBP9Bi8YBgA109vrjUpnbjW2H5QXbJqFNIT
         ksz8eIUnupUyM3v2DU2vIY+WnFcl9kPd1Leb2kpdJyw56+0ndjMkZgLYWVs4cBopG+CN
         Ogow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719941750; x=1720546550;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9OdqMsbcRZ7kiShEp8RLl5kFE6Pk3vU6GTPf+SL3qI=;
        b=DcDgowTnzqrMBHOwh+XGgeP0HXEGDVM1ZAgDzYzrNFYHpWUejfXitbcAtX3WKPExKg
         Ot4GTRYzFhI9B0cJhcm48F9IpMFbIXm19kfTtKEtdaZ4wLw9hGqXsDRQifB0u8tYMSJY
         U8XghnXiJzqgUjrsW4LKF0GiMelBKICRzW+uRiL7XexdNfg6sYthZ1MmBtqonyDOf+dK
         GfoLKFf1tWiWJ5KJ8RTc+7ec7zElrJXl6fl0NYT08zfzzf64u7qg0ZW6squkNZzl1qvO
         OImkVf9iGFWurDoK51uxa3FHtHs4clRF3aUb6CQjDcoNV5og5tSCJM+UaeuVJuUOJM5D
         6hsQ==
X-Gm-Message-State: AOJu0YzTskT5YcniOeMLgz6rWC/apH4x+S5EQIwlWgyq7Tv8lLc09o+L
	GkQqIbfABih8GJd4G45kxHEQ3BunXvkkp0UJcE8quo3Ey0eS8FSJ
X-Google-Smtp-Source: AGHT+IFve6+ahz9n0XotmEfB5f5KcfNsWmum8mQqjU1Aub1spnsr02+nVYpr9zfjromcL7XGX+4nVQ==
X-Received: by 2002:a05:6000:154f:b0:367:47e6:c7e8 with SMTP id ffacd0b85a97d-3677571ff44mr6478082f8f.53.1719941749825;
        Tue, 02 Jul 2024 10:35:49 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0cd634sm14004404f8f.9.2024.07.02.10.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jul 2024 10:35:49 -0700 (PDT)
Subject: Re: [PATCH net-next] net: ethtool: fix compat with old RSS context
 API
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 przemyslaw.kitszel@intel.com, andrew@lunn.ch, ahmed.zaki@intel.com
References: <20240702164157.4018425-1-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <3730656b-8bce-bba0-ae0a-7ada427abca0@gmail.com>
Date: Tue, 2 Jul 2024 18:35:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240702164157.4018425-1-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 02/07/2024 17:41, Jakub Kicinski wrote:
> Device driver gets access to rxfh_dev, while rxfh is just a local
> copy of user space params. We need to check what RSS context ID
> driver assigned in rxfh_dev, not rxfh.
> 
> Using rxfh leads to trying to store all contexts at index 0xffffffff.
> From the user perspective it leads to "driver chose duplicate ID"
> warnings when second context is added and inability to access any
> contexts even tho they were successfully created - xa_load() for
> the actual context ID will return NULL, and syscall will return -ENOENT.
> 
> Looks like a rebasing mistake, since rxfh_dev was added relatively
> recently by fb6e30a72539 ("net: ethtool: pass a pointer to parameters
> to get/set_rxfh ethtool ops").
> 
> Fixes: eac9122f0c41 ("net: ethtool: record custom RSS contexts in the XArray")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

My bad, I should have re-tested that side of things after the rebase
 onto Ahmed's changes, instead of just testing the new API via sfc.
Thanks for catching it so quickly.

