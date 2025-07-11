Return-Path: <netdev+bounces-206207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200BB021C5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 18:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F577AEAB9
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80A92EF667;
	Fri, 11 Jul 2025 16:29:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22282ED161;
	Fri, 11 Jul 2025 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251384; cv=none; b=p7NtWvKrMm1Tl0PTIkDFLj5ci2dOZOy4AW252jpG6dm29aRHIEMutRfUL8lqsQ/GHupMMcoNi4eBqn+OAZylafJIL3UggJGfphaYanxV8pnARzIbUtfxCusNoRkSQNKSaqNkRCsbSYOdhLLFcY3ZGKOXoqeDyvrBCLiE5wI5nOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251384; c=relaxed/simple;
	bh=Ultbj5aAvjf2i2FBVeLspqO/Pt6abvUu+kiGcpxdHEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvFhPqpjvxX3ZQ3LhfmpKyftjEHkpwIgXjgcPnt1zdqN1OfFk7P8BpV25CNnK0NyfLAUpQcD0OnctlezkGcBm5tEjsfahC+LmX8xhREphVxmjLwXy48ghd3Nh16FnnLOsKnNMqarZj6iBOfRRGJH/8urxh8792DMnsGNHuE/Pcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-604bff84741so4367326a12.2;
        Fri, 11 Jul 2025 09:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752251381; x=1752856181;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOf42JVX0DNZGJ6nN0ZcSyKq/2lB3CkluzXYH2APlPs=;
        b=E7jO8B8ZO1c61GhamkuWq5YomhlSJm7q/u9avKmY+fN4i+aBaM3mBZrGdHZm3djzIg
         pHSDW+LZNRiVTlo42tZ7Gbyt7ubgJ/b4p6K5HHuxT4dfPX5dDJzS24eNhWDYFkGm89I0
         ceI7BXI8EPgp0Csd4TQXsegIUCo6Q90oIJnWJ4acwhpQi5XSfKhN2E2w4DZCsXBejGxO
         bz/1294ko17dNBFgKYLY5/5ZUqLo/8RFe/d2Ewrj22WVkLZfalmihuQwBb0jq4r5uKPE
         WsBG4zox7iqUGCYj3sb+BBBDg36ysdaXXQ08SXLntluEaQ7tUkWsguqkSpszZ+EnAifT
         VuAg==
X-Forwarded-Encrypted: i=1; AJvYcCUxP0qx11FwrQQyN9gVqZhUO/ynOvt3GFzn5SeADAobJ+IXb8xApedk8BGttlHZzLrdT7Pb2GVcBs4qRqQ=@vger.kernel.org, AJvYcCVTUfy1wv9YMDgEN9zAlBsa+uvx+HEOxbl5IJeQlsmjy0uM2SDjBthKQDH7SVstgd42N9VGYYzv@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfo/ncAF5vD1aGY1Jz1C+vkYgJJoZsj4ChVVX1CtrzFNXDusN+
	7l2s50aVaGbcc9hgsB2FRM/fFAqGcNGl8kRmuGdBnXKaQ9UFE5G48aAn
X-Gm-Gg: ASbGncuodAWEitcBUB9m64LlODyg3jJdU4iH7yI0UUXoWa6U7kHLKIBc9+1civAVYuR
	2d2GXG3piQlgf7XFsKt3C0BNdZFJriHxay9+Ky7XFFUp2r8scF4QoDQ5bqPq8Eu6OF0Klgpzq7F
	bIWVvrJ7RQuK/FrEbnHyIf4rVKXXVnGCZbG8eKUclJL3gB4Ehi3D+Mu+GTd1EuIdfaFSWQGNWQR
	fJCkjyD5olLRYb0fafEt+YcwYYGqKGekZVOSkKR5u8oiUwxgHW0UK71AIi4V17KiAH5/eNCJV8Y
	/cfapc4WcPm9Pc9gMZEgr06Ke2BOVzbsf2LUGEWt/FFQtVUCauUHw0IBE9qxTe5Vjhzbbk5tTVT
	nDG6BRiX5Z41Pf2jgSW8J3tA=
X-Google-Smtp-Source: AGHT+IFTR/x2rOzjfShJFDjaTJRRDT/KRfp5F8jOeyMsaXdaQpXQ6Zfy72nSIupUE0YuKFTtsUwA+w==
X-Received: by 2002:a17:906:730b:b0:ad5:4a43:5ae8 with SMTP id a640c23a62f3a-ae6fbc63f70mr440148166b.12.1752251380802;
        Fri, 11 Jul 2025 09:29:40 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e91c81sm323374166b.37.2025.07.11.09.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 09:29:40 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:29:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v2] netdevsim: implement peer queue flow control
Message-ID: <p22efbdqaaypgp7wu4csohhtzowpgrzrtelev7waumidabryty@lq4txzalfbfl>
References: <20250703-netdev_flow_control-v2-1-ab00341c9cc1@debian.org>
 <20250708182718.29c4ae45@kernel.org>
 <aG5FrObkP+S8cRZh@gmail.com>
 <20250709143627.5ddbf456@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709143627.5ddbf456@kernel.org>

On Wed, Jul 09, 2025 at 02:36:27PM -0700, Jakub Kicinski wrote:
> On Wed, 9 Jul 2025 03:34:20 -0700 Breno Leitao wrote:
> > 	+
> > 	+	synchronize_net();
> > 	+       netif_tx_wake_all_queues(dev);
> > 	+       rcu_read_lock();
> > 	+       peer = rcu_dereference(ns->peer);
> > 	+       if (peer)
> > 	+               netif_tx_wake_all_queues(peer->netdev);
> > 	+       rcu_read_unlock();
> 
> That's sufficiently orthogonal to warrant a dedicated function / helper.
> 
> In terms of code I think we can skip the whole dance if peer is NULL?

Sure. We can use rcu_access_pointer() to check if the value is set, and
then get into the slow path.

       if (rcu_access_pointer(ns->peer))
               nsim_wake_queues(dev);

> > Also, with this patch, we will eventually get the following critical
> > message:
> > 
> > 	net_crit_ratelimited("Virtual device %s asks to queue packet!\n", dev->name);
> > 
> > I am wondering if that alert is not valid anymore, and I can simply
> > remove it.
> 
> Ah. In nsim_setup() we should remove IFF_NO_QUEUE and stop setting
> tx_queue_len to 0

That makes sense, thanks!
--breno

