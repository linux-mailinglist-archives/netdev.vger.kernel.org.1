Return-Path: <netdev+bounces-118346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABFC951517
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 09:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B37CB26FA4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E07A13B5AD;
	Wed, 14 Aug 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="baUNqTM0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C22313AA45
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723619694; cv=none; b=BzvW6ZFWIf7AU7auodhbQCVQsK2/U2/zvSipVavzghmLMGQjddGB1T7jwkeCsRz9oGNxVp9bdpt4jyt4fxUvWiUBKbppcpsuqpMMICgI/MiZBUTZZqclK6iz6Qpw3VKMKMxi1JeDVcb56UfKOQTOGDBhP94CiqDnJqUihCiC/5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723619694; c=relaxed/simple;
	bh=6yPA/+naAsZnFRxGSIa3POveZV8QV3kkzHQ6Vv3c3Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BfBug89nbrKNTjG18QdnPVFJyLLp1JWbnhPWZG75xBiwGbzSS9xyrRttg5EdnjkYNhnN24dxu39Gl4Wt9mMJ5rpdij6UXB4wQxKjqDF7iTbib4WB6AKw7t/8H9y7s3/npw/KnH4x22kJ4ufHQvab1+y+lEf+CdB95/savPPljTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=baUNqTM0; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-368440b073bso333804f8f.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 00:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723619690; x=1724224490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snr1RwI8r35tpJfYm30yYMDnFOSDHF5r97Sqomh+D38=;
        b=baUNqTM0QpCQ1WAR8+3cqSqou+z5ix0GdCfhOwpKtKf+o+Mmx5a0j2WnYcMY5e5DEV
         6jNnsoMDRYipCw3fDY5Hf5qeEeorJtEdkMriS2PV8MMlKdKM1XZjgUNVTVlExx0GK2Nu
         sXZIlAUiNPcL0tMErM9Q08UqmKsjDwnKWv0Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723619690; x=1724224490;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=snr1RwI8r35tpJfYm30yYMDnFOSDHF5r97Sqomh+D38=;
        b=TQBmzIHAOCxvQQqesf3kxIT5zvOHZLJY69Si7/+dd8vhdQ8rQQ7A9mtDTHnzGXxf54
         kXjDedIGan7dARHRbSW6dxUmIM3zaHvDSxQ4er4RuYcF+STuYubb2Ik6ZKJg1SmyhoLr
         h2Ha5ITx5Il8ay+2U8xYguuqe82vEWZu5j/7gLPShNq/ZmeEiQx3GFGg1Kq0mKjCpWKV
         UGM81xPPbs4kMaw3f4sBRc0q3RstfPsAZTsZQkEbcmHktuUdcg7uhz+GP4PujVfu3O27
         CLDfIHxkgStbITnkXe2ZgYpYcdKqEkekCAAxg+Ci+9ic7LdNV50nkh0wAON4Rw0Q68zC
         wKiw==
X-Gm-Message-State: AOJu0YwqOfeYY3+FLNWx7ddpL/NC02XsOEPVoTyyvqvOFeBK7aZCVxaV
	ibU20L1Vpe3SE8Vl7bBtQqFoFiB9vAYScbLrU0+gmv2nwJ8uFnsnfzxnGKDV66M=
X-Google-Smtp-Source: AGHT+IGthAjObIOxhvEgDlsiHPqABWqYE1bIWj6p19KBBIYNbbJG8nCXI6l4Kn6mJsSbPxQNarJNzg==
X-Received: by 2002:adf:fb4c:0:b0:35f:314a:229c with SMTP id ffacd0b85a97d-371796915bemr790558f8f.28.1723619690346;
        Wed, 14 Aug 2024 00:14:50 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:7516:6986:2fe8:5b8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfee676sm12111994f8f.49.2024.08.14.00.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 00:14:50 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:14:48 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
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
Message-ID: <ZrxZaHGDTO3ohHFH@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
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
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240813171710.599d3f01@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813171710.599d3f01@kernel.org>

On Tue, Aug 13, 2024 at 05:17:10PM -0700, Jakub Kicinski wrote:
> On Mon, 12 Aug 2024 14:56:21 +0000 Joe Damato wrote:
> > Several drivers make a check in their napi poll functions to determine
> > if the CPU affinity of the IRQ has changed. If it has, the napi poll
> > function returns a value less than the budget to force polling mode to
> > be disabled, so that it can be rescheduled on the correct CPU next time
> > the softirq is raised.
> 
> Any reason not to use the irq number already stored in napi_struct ?

Thanks for taking a look.

IIUC, that's possible if i40e, iavf, and gve are updated to call
netif_napi_set_irq first, which I could certainly do.

But as Stanislav points out, I would be adding a call to
irq_get_effective_affinity_mask in the hot path where one did not
exist before for 4 of 5 drivers.

In that case, it might make more sense to introduce:

  bool napi_affinity_no_change(const struct cpumask *aff_mask)

instead and the drivers which have a cached mask can pass it in and
gve can be updated later to cache it.

Not sure how crucial avoiding the irq_get_effective_affinity_mask
call is; I would guess maybe some driver owners would object to
adding a new call in the hot path where one didn't exist before.

What do you think?

