Return-Path: <netdev+bounces-118792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D8F952CA4
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 12:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8327C28204A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 10:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C3C1BC088;
	Thu, 15 Aug 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="VuIST5my"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADCF19DF40
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723717385; cv=none; b=XTaKXnIZa8TShgBg2PjNAcXkdH2wBciAurZp7BhXe+h+1Vj0jt0K8UBpggruN//SJFCkq1PSiZTDnQmXL7WBxXOEUKfLvOxeOXszA2bho8z5jxgrhEP6BO9ANWy0iKL87wvj330IT6s69tKewjo7PJ17qQIdvyMC6H7RprI84EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723717385; c=relaxed/simple;
	bh=jyE+hLQ8pkbqTYJwWiYn5/uR3k4gGzfFdMNkZy0nq80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO1IuFm2Antuhpl8VsGHtrjEfMAdb3I60f5TsDPl8yPMs5K74id2xqu7+iDaXxk0sSh8dcColbVAI0XawUtQ68DAhXGM9f0LrJTG1P6lVjzaoLtqRKWOLZmg5EaDgo14Zz5wvYHkcxdo4+3i7O0LAE1zCCWYJEszkRPqrcYiZH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=VuIST5my; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428178fc07eso4636595e9.3
        for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723717382; x=1724322182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbsnFZH9IAeMkQGJJtoUFHpAfF+HiIlJJCpWSwAym4I=;
        b=VuIST5myus23tcf/F4O8t9+3AvwGuzfGIND/IuED+a2LlLnx7JOXKA/w12xYFu3S4Y
         tl0kraWzDCPvNvrfYpno9lcYQsewTTNDiDjm+hwiNiVngIBtQGDp/AQqgponc044F8YW
         W7tLbkpdvtifb2wM9X6vfjUYYCm97ejNsgEPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723717382; x=1724322182;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbsnFZH9IAeMkQGJJtoUFHpAfF+HiIlJJCpWSwAym4I=;
        b=Q6xq89jcwf/jnTHSnrhmnFksZTPxP5Ir+cuyRP4+oNvNBlufhWwUyPLDxe4z6ZTxcn
         IW6zFgWydU/yqfCbtPFt6HmFt+t94FBcSQ8E74QveKwnbjSsK5Omjy2LLFHpvs24qTKq
         S7doDia5b2W7BJsde4r7p9KHmskJ3+fFT74Yu3F1pX71f9qqr8HDUqADxN9LuR+bIuPe
         Tgzrla0TMbIy7tPsmS9KalfbjaThy53/wpYAQNU2Jq2No6EUQc8H9qbo0ilbZt9NtiBV
         GWDw+vd/roZkH6XKFHmrc16DmOBTxIWDHpeYSE1a8/GQA97zvHd8uPSw8YQFbQ7H38Yd
         fV+g==
X-Forwarded-Encrypted: i=1; AJvYcCWf3v51P7jKgsQzM2U/HeZ/hlmezVIFIjNk83Qt5bS+CCoJpJGmp9hNgJ83V/c1P6HKHP7Ed9o8B5kf+nPbsdV6ZzGUefJf
X-Gm-Message-State: AOJu0YwKO/OC1T18FKHXioLDl11ubUyahousRP/klgoVSQnEGmneu0By
	wZl8CYuJUPMly7Qna2FauECotudTpHt890PrernOTDEfmIzbOC61XpLVE24eIpPELORlG7r90bR
	7+T8=
X-Google-Smtp-Source: AGHT+IFRMnpq89Ndgm1XWkrIwkNFCLIoPM8Uv6CXkf8fMwmcHs21IKRm+btZ4KEJCdOrXMWmGT28lg==
X-Received: by 2002:a05:600c:4445:b0:426:689b:65b7 with SMTP id 5b1f17b1804b1-429dd264da5mr36184295e9.25.1723717382050;
        Thu, 15 Aug 2024 03:23:02 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189856b07sm1135018f8f.50.2024.08.15.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 03:23:01 -0700 (PDT)
Date: Thu, 15 Aug 2024 11:22:59 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shay Drori <shayd@nvidia.com>, netdev@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>
Subject: Re: [RFC net-next 0/6] Cleanup IRQ affinity checks in several drivers
Message-ID: <Zr3XA-VIE_pAu_k0@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, Shay Drori <shayd@nvidia.com>,
	netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	Jeroen de Borst <jeroendb@google.com>,
	Jiri Pirko <jiri@resnulli.us>, Leon Romanovsky <leon@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shailend Chand <shailend@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Ziwei Xiao <ziweixiao@google.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org>
 <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
 <ZryfGDU9wHE0IrvZ@LQ3V64L9R2.home>
 <20240814080915.005cb9ac@kernel.org>
 <ZrzLEZs01KVkvBjw@LQ3V64L9R2>
 <701eb84c-8d26-4945-8af3-55a70e05b09c@nvidia.com>
 <ZrzxBAWwA7EuRB24@LQ3V64L9R2>
 <20240814172046.7753a62c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814172046.7753a62c@kernel.org>

On Wed, Aug 14, 2024 at 05:20:46PM -0700, Jakub Kicinski wrote:
> On Wed, 14 Aug 2024 19:01:40 +0100 Joe Damato wrote:
> > If it is, then the only option is to have the drivers pass in their
> > IRQ affinity masks, as Stanislav suggested, to avoid adding that
> > call to the hot path.
> > 
> > If not, then the IRQ from napi_struct can be used and the affinity
> > mask can be generated on every napi poll. i40e/gve/iavf would need
> > calls to netif_napi_set_irq to set the IRQ mapping, which seems to
> > be straightforward.
> 
> It's a bit sad to have the generic solution blocked.
> cpu_rmap_update() is exported. Maybe we can call it from our notifier?
> rmap lives in struct net_device

I agree on the sadness. I will take a look today.

I guess if we were being really ambitious, we'd try to move ARFS
stuff into the core (as RSS was moved into the core).

