Return-Path: <netdev+bounces-155521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57118A02E27
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046EF3A5B7B
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66FD1DC046;
	Mon,  6 Jan 2025 16:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgHprREb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824CF1D5AA0
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736181968; cv=none; b=mMdlqLxn3ZvSXp4EXKJbmy0vIoM2Fs3N0iF9ROiPIhhBe+UyaNGeBBFaT51w5cqzob0rDctYnoctNGc4rpUeipE1T6ZhP7vwE2pwZek8e0UmjIPe+aG5Hm1gPgaXCfV5fy3jx9svC22O//8bOS9nHoExF/Ab8Ju0XGjXNbPdPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736181968; c=relaxed/simple;
	bh=RKMrMJFMDaHrX0VeLM8GS+y71ZXDzdrF8CMBSf0Pjmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVi2t6h/m4lfYoHBWl6z2fNkhevGpHSpOZqWHp2NdrBLxfEPFHqJddxaZ4ei/08LrJzA9yY+eXGIalMal6LscHAbpka+WlGgiNFRiH6nLWr9PWZHM4NGhQoUCB4616SwsrywgcObV27UW/2RlCiB680D1Sb58yznQKD5C0lnUVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgHprREb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso208533625ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736181962; x=1736786762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OMbl8FQx5wUrRjaLnp3X1Ya8LSP9nmOHzIvG7Itr12w=;
        b=SgHprREbumkaoxNZvqiameaXGNSIJqMPkokwi2++w+y0SLLqieU8p9fkgm/1sybj82
         XzHCCkI6Ue06E50mma4WwwU/24FcporLQxiUe4U0MooQfqyU92+3y8wKMLyVPNh12dJe
         W7Sr4Vtli5cJQLIQEZkhwPIr+udTkYaHwiMj4q+EyAiP65HqhknOfjYhm10vsODA1q0D
         itryBXAt6URXYb19VepRU14AHB95+Qg1YdN1OmBQJg2oIJs7tpu/0C+oni1Dk9k5O6K7
         1mbRjNBjrI1qw5i6xvs11RLTAUPNEXZiu/lBuRymk+dRW5c5kggeEa6fVN5U8DtsWmmw
         +seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736181962; x=1736786762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMbl8FQx5wUrRjaLnp3X1Ya8LSP9nmOHzIvG7Itr12w=;
        b=sdpsFDer0Y+kU2uGfP50STTkL208yYOHWV4CVKWx8crpy1ek9rhEKDhwzYs/uvF1xG
         LKFWD74c3Nb2R2o9mq4QDeJB06ZyuFbTMTNLu4v8a0V1P99ekOQYTb0LBcqo62XxP8Z+
         xxzi74wHSLVCoyOKRUHQyR7IJwQK/6fY9YO9sogJnv42hd1J6al/K6xD3/dvDKYzbARj
         3Vnv5rhOll69I85FmuXRHMSwO7cVkClliMBzJX48SUgvdTbPoXjD3kemfh/Qe+GYxWpr
         Kau0/GpTnJnokdFMd6zggiJbVhIaYFjDH6/9im7dtN1q9j1kVio/Rq/BmGXwpwve0wVX
         JwLA==
X-Forwarded-Encrypted: i=1; AJvYcCW7zTjAdHLSLNLWr/Mr0A/mbCcqR9HX2lw0w1t9LlSivefKb0ah7JYoTuQW0fyMyBWqoTZSXe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznH0ioEYHcubvEuoJ8s0yYCLIfxOgKCQT9NybnFi2+0imcSnWV
	Iix8DjStsRY13spdtAOBXKTH3js5jaCN0CIOOrkyxRCYyAY3bVE=
X-Gm-Gg: ASbGncvQwj03daqI9bd2d2qb4TEi58+8Z7XvNlG+A+bdeocyFY1UnVw0ViqMUcjixAp
	s1EAT+vCbB/ErERXCtfM5N0emeB37i4jXSR0MIC9uqZaVTyhW5qkPvL/OI8A6plOLSP6zCFIps8
	0YjhMY4ijv9NKfuNkEVxIHPQF7skDGed0+/zr4u4S0vMY5Mc2LmgussERFIC4E2glnbZ/QIgisV
	J3efFs1bDZwN35kTP6lwdYpLb0qeGk2KVwzBjUsedZfXHqvmBSoGuXA
X-Google-Smtp-Source: AGHT+IFqVPH7vu2KXYqpMVBlJYG0bOiI6KFQn1CT5rMXsGISfFfBGLkc2vMBTqugt4VSH8ZtXo46Dw==
X-Received: by 2002:a17:902:db11:b0:216:2f9d:32c with SMTP id d9443c01a7336-219e6f262ddmr865211645ad.53.1736181961778;
        Mon, 06 Jan 2025 08:46:01 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d94c4sm293170975ad.115.2025.01.06.08.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 08:46:01 -0800 (PST)
Date: Mon, 6 Jan 2025 08:46:00 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dw@davidwei.uk, almasrymina@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net-next 7/8] netdevsim: add debugfs-triggered queue reset
Message-ID: <Z3wIyBqT1sBy-L_d@mini-arch>
References: <20250103185954.1236510-1-kuba@kernel.org>
 <20250103185954.1236510-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250103185954.1236510-8-kuba@kernel.org>

On 01/03, Jakub Kicinski wrote:
> Support triggering queue reset via debugfs for an upcoming test.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/netdevsim/netdev.c    | 55 +++++++++++++++++++++++++++++++
>  drivers/net/netdevsim/netdevsim.h |  1 +
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
> index 86614292314a..65605d2eb943 100644
> --- a/drivers/net/netdevsim/netdev.c
> +++ b/drivers/net/netdevsim/netdev.c
> @@ -20,6 +20,7 @@
>  #include <linux/netdevice.h>
>  #include <linux/slab.h>
>  #include <net/netdev_queues.h>
> +#include <net/netdev_rx_queue.h>
>  #include <net/page_pool/helpers.h>
>  #include <net/netlink.h>
>  #include <net/net_shaper.h>
> @@ -29,6 +30,8 @@
>  
>  #include "netdevsim.h"
>  
> +MODULE_IMPORT_NS("NETDEV_INTERNAL");
> +
>  #define NSIM_RING_SIZE		256
>  
>  static int nsim_napi_rx(struct nsim_rq *rq, struct sk_buff *skb)
> @@ -723,6 +726,54 @@ static const struct netdev_queue_mgmt_ops nsim_queue_mgmt_ops = {
>  	.ndo_queue_stop		= nsim_queue_stop,
>  };
>  
> +static ssize_t
> +nsim_qreset_write(struct file *file, const char __user *data,
> +		  size_t count, loff_t *ppos)
> +{
> +	struct netdevsim *ns = file->private_data;
> +	unsigned int queue, mode;
> +	char buf[32];
> +	ssize_t ret;
> +
> +	if (count >= sizeof(buf))
> +		return -EINVAL;
> +	if (copy_from_user(buf, data, count))

[..]

> +                return -EFAULT;
> +        buf[count] = '\0';

tabs vs spaces got messed up here?

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

