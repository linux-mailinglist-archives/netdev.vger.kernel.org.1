Return-Path: <netdev+bounces-81193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E702D886809
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 09:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED66B24274
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 08:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D56168A8;
	Fri, 22 Mar 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Br2BceTo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4612315E80
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711095285; cv=none; b=dxTHl0oZzQhXN0wP1GUAWV7tIoZvjVUuay+z7dCPsR6YmdKKFtxP+EE4ROyLsERo/DWD3zTx6eXscmo93o5D3ekehjkrwdp5uWI1vtFPBzvNvPHGr/RoDZ6YJhm2RRy0XM9yXplPSYZXoUZkEjaRUK3sp+Ly8lkWbymuSVD/70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711095285; c=relaxed/simple;
	bh=JFzNhkP5QLtkYpC2D1YDRejHvg7JEJlRfxAlH2w3BRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qn5ZB+4bjBiy9lHOo12gmgFHruQclglJxukWk9QAa0Y2FQ7LUGcy7ri5QO7/Qa2Zx3btRwV6vwhwoT6V5LSxBf6xLGcLtetpF2d468dRgfoWLoJpSKxneXVB/g+mrfz7lwHXcI5/RSVWUMJoymkfT8pwyMWzys7Tzu02nmE+v7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Br2BceTo; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-414783a4a4eso6879095e9.0
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 01:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711095282; x=1711700082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KeIG0pthg0gbWT+jSh1Vhdjz7oX1y5VPjP2QtnJca+s=;
        b=Br2BceTok8JRWsNodtS2A7oYZafx+CQUcfpZI8sOCgBu660RtRaJ5jECqGVr6ybOyG
         9rWRn7MfVyuWawm5bA5JxDmOMcnoyOXc79JUC5I2AQMbLLxeZbRQWZBlmGShdXaEmWsR
         +j2UrHVWArOy5M2Vt5XyfeZ4f/GwFt03mJXsSOgd/vKS0/GaUNAUpsJBF0xJ2kjQLYkG
         8zK9SDSV8d11T2lZMD7HvF5gU9HYBkQGTgt2d4LJTKE4cCArvupuyVkPe+JYQssxdQNK
         YA0rjD+aA0hwHrP5OSLmtvRgMIVw+sVLLFpavyGkKHL5mlpMBwrm4pL00KwZr34SYeNv
         qHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711095282; x=1711700082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeIG0pthg0gbWT+jSh1Vhdjz7oX1y5VPjP2QtnJca+s=;
        b=JT+0YgnjRlrdh3OKzRpFIo/ctjgfyJx0cMPsrwQiQOQ3C7avBx4UIc1uygcK7fN33P
         UfBHkdXlL83BK8OGu6lg/d08t89n+g0KIvWb9j511YI6txp/Lv9YJ4S1j8hmHOH9QNui
         rS7rOVF+xIUzGPyXcv3tnJktloYr2J/LFAmOGN2SJ6NRhNjXDo7sO3N1pPnbIgnHOHFB
         VxRV7x0Z0UZxxEPRF+mQzK/hvQ39zsDNNeiXV7oR07hK51rDQS+i8wq3OxLMw7Iulz1C
         IfQ4EQ6/+8qYkBQIsw07IdAFeSHuJeL+n24tzXRl9d4wmw/5DvRai6B3SoDLR4/tfWc6
         6UWw==
X-Forwarded-Encrypted: i=1; AJvYcCUAGi6MvM78PW0pLoj72E2t8LfvdZAOXChePHNlCkjKULFmbOk4mDm5qzDu47OWZaylvB2+5TGWU1N6xiCY1wdynYVZjrT8
X-Gm-Message-State: AOJu0YzxmRCINNAgGP697FtPYUYULk28nFE5B7IEzI4bsmosTc0rMzfq
	ZoyMJmZEKhx2c6F7iOpnAbC7QDj1gxn+BggE6RTunwmxWRh7xESDVKtazlLXYIA=
X-Google-Smtp-Source: AGHT+IGwPz6767RcrrY0790mUk4LkwVLzF/Op5LJewSUE4Y+wELU0U25oX+98+rlzwQTxKWavG11Pw==
X-Received: by 2002:a05:600c:5491:b0:413:e63b:b244 with SMTP id iv17-20020a05600c549100b00413e63bb244mr1043452wmb.7.1711095282555;
        Fri, 22 Mar 2024 01:14:42 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s16-20020a05600c45d000b00413f4cb62e1sm2303693wmo.23.2024.03.22.01.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 01:14:42 -0700 (PDT)
Date: Fri, 22 Mar 2024 09:14:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: gaoxingwang <gaoxingwang1@huawei.com>
Cc: mkubecek@suse.cz, idosch@nvidia.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yanan@huawei.com, liaichun@huawei.com
Subject: Re: [PATCH] netlink: fix typo
Message-ID: <Zf097_S2K9uxGsR5@nanopsycho>
References: <20240322072456.1251387-1-gaoxingwang1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322072456.1251387-1-gaoxingwang1@huawei.com>

Fri, Mar 22, 2024 at 08:24:56AM CET, gaoxingwang1@huawei.com wrote:
>Add missing colon in coalesce_reply_cb
>
>Fixes: ec573f209d (netlink: settings: add netlink support for coalesce tx aggr params)
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>
>
>Signed-off-by: gaoxingwang <gaoxingwang1@huawei.com>

Also, please make sure your name is properly formatted. "gaoxingwang"
certainly is not.

>---
> netlink/coalesce.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/netlink/coalesce.c b/netlink/coalesce.c
>index bc34d3d..bb93f9b 100644
>--- a/netlink/coalesce.c
>+++ b/netlink/coalesce.c
>@@ -93,7 +93,7 @@ int coalesce_reply_cb(const struct nlmsghdr *nlhdr, void *data)
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_BYTES]);
> 	show_u32("tx-aggr-max-frames", "tx-aggr-max-frames:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_MAX_FRAMES]);
>-	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs\t",
>+	show_u32("tx-aggr-time-usecs", "tx-aggr-time-usecs:\t",
> 		 tb[ETHTOOL_A_COALESCE_TX_AGGR_TIME_USECS]);
> 	show_cr();
> 
>-- 
>2.27.0
>
>

