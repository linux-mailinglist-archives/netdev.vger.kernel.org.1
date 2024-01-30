Return-Path: <netdev+bounces-67112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0429A842170
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCF7288E00
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE67664B7;
	Tue, 30 Jan 2024 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mEgNufMm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C90657BF
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610997; cv=none; b=Hr4nLhj5ZUjWkauKg0tDKpAQK/oWIr+YQAa/PiKIZR6y+sr0EaHOKCybVPACP3NdaXGvEoXyA8HAFTLHv6NQ4vCHjtrTNPykKaIpENbis1ZEYATKSN3tqLELhdhjtwG4SEinVzosvo8YWANd4GQSDCZeLNeFP63LmNIO62Ww50M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610997; c=relaxed/simple;
	bh=nhlEv7EFncYVj/ksi5PfvNlM0+y3kwpu6nvcylDqdPU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OtpKlaFoqFsxbQec9bXd7u3sOmP0cRkoZj6dgSaQjB6SH1LPZSszCa7tB3M8SM7JZiIsWTZrwoMpmaGsymK1r85V0gu375sZ1tyF0Xr338Ok3Z7jxuFtbKmPk7q+7gMs+2nlcnH6WauWaQBCSy0zpboy36JJWXb4IY05K3BhEcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mEgNufMm; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e800461baso51411935e9.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706610994; x=1707215794; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=u8utIHsLkZ5y1xjlHJ5QFLJ6fu1Nd8R5wW/SUGN3zsA=;
        b=mEgNufMm6P1toW5XM8v/htzH9BEypHUNJeolYMJiMXhB8iCK6SVc5M6bq47JC+S7P8
         x2F1Cv6iOwRsf35ar5rYkgLmKelTJKlQ3+670BtzQYSTUs4Ix0NFr3u2fc3PerRMr7o2
         y0YMZXIX1zDkcXRbeuDtk9UT0A+yrAPUDEG9SF6Lk8gnCy4Xm8BDYTKP8pfNrSXxzakW
         TKnt5BeQfjm1c/Cd2EtYF2NmS4HFARQ7YUz5dDRdQQGWcpN6vN1VonIFIgHodRwF2rDQ
         KNVxADAfDIKUa4xjtler0Mg48H7EvLwc9ski8/ASPHSlxEVKZAquswBmNINfUihedmjm
         Jl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610994; x=1707215794;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8utIHsLkZ5y1xjlHJ5QFLJ6fu1Nd8R5wW/SUGN3zsA=;
        b=bvjj+bkVHn3jJDP/WYdxQz7Z2aUWhM86+iEShx43ZgCjOfhcKxDcT3FD0rVh3IXRN2
         DTxpP3n44YoQ74XOJimSVdZIsNODkZ+HOTqo476gvXe7fE6FmBBHwJ3dYgxf2g/ufXXU
         NbNPjcypB4pR/fuQfasdvIPT7fMwkLW3CyWUfwbfL64EOYZcCIuRWTXOS8Li/ScOpQvn
         FVStQI1XzJtlaZEk8iv7Eak7sxJmK5mlBQqdZL4VCsV1z+9cLxeQx0DQrpl/hj2c52r5
         2qET/dURr/VAEmv+iQdXY1H6PDE1+opPtUI/ruz1/LfVFGNvMGKBks775Bvsn8WZUnfb
         2P5Q==
X-Gm-Message-State: AOJu0YyzovD5vIXpF3eCo3e6Kz6WB5Krgc6o6N4kTtvBYMubhvfjOUAV
	HJ54ELM3AKP4mT+65BXVj74gICf+liJWHi7HzE4El4msc7NDhukbwK32yvE/z9Xe2Ixb4XbO37M
	8C/Y=
X-Google-Smtp-Source: AGHT+IEIzkG4L4m2vwBim9dYJyCBaJVzl2ouUwx2bLA42pV6KRVaRaz8vsJwj8BkTIFFQqJt/Wvplw==
X-Received: by 2002:a05:600c:458a:b0:40e:dbdf:9fb4 with SMTP id r10-20020a05600c458a00b0040edbdf9fb4mr6220146wmo.23.1706610994233;
        Tue, 30 Jan 2024 02:36:34 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b0040efcd70cc2sm1843604wmc.45.2024.01.30.02.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:36:33 -0800 (PST)
Date: Tue, 30 Jan 2024 13:36:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: re: [PATCH ipsec-next 1/2] xfrm: introduce forwarding of ICMP Error
 messages
Message-ID: <71c2d6bc-ab8d-4fa0-9974-d4ed1f6d8645@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b30e07300159db93ec0f6b31778aa0f6a41ef21.1698331320.git.antony.antony@secunet.com>


Hello Antony Antony,

The patch 63b21caba17e: "xfrm: introduce forwarding of ICMP Error
messages" from Jan 19, 2024 (linux-next), leads to the following
Smatch static checker warning:

	net/xfrm/xfrm_policy.c:3708 __xfrm_policy_check()
	error: testing array offset 'dir' after use.

net/xfrm/xfrm_policy.c
  3689  
  3690          pol = NULL;
  3691          sk = sk_to_full_sk(sk);
  3692          if (sk && sk->sk_policy[dir]) {
                            ^^^^^^^^^^^^^^^^
If dir is XFRM_POLICY_FWD (2) then it is one element beyond the end of
the ->sk_policy[] array.

  3693                  pol = xfrm_sk_policy_lookup(sk, dir, &fl, family, if_id);
  3694                  if (IS_ERR(pol)) {
  3695                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
  3696                          return 0;
  3697                  }
  3698          }
  3699  
  3700          if (!pol)
  3701                  pol = xfrm_policy_lookup(net, &fl, family, dir, if_id);
  3702  
  3703          if (IS_ERR(pol)) {
  3704                  XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLERROR);
  3705                  return 0;
  3706          }
  3707  
  3708          if (!pol && dir == XFRM_POLICY_FWD)
                            ^^^^^^^^^^^^^^^^^^^^^^
This assumes that dir can be 2.

  3709                  pol = xfrm_in_fwd_icmp(skb, &fl, family, if_id);
  3710  
  3711          if (!pol) {
  3712                  if (net->xfrm.policy_default[dir] == XFRM_USERPOLICY_BLOCK) {
  3713                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
  3714                          return 0;
  3715                  }
  3716  
  3717                  if (sp && secpath_has_nontransport(sp, 0, &xerr_idx)) {
  3718                          xfrm_secpath_reject(xerr_idx, skb, &fl);
  3719                          XFRM_INC_STATS(net, LINUX_MIB_XFRMINNOPOLS);
  3720                          return 0;
  3721                  }
  3722                  return 1;

regards,
dan carpenter

