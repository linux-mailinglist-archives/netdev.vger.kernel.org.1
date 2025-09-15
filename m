Return-Path: <netdev+bounces-223001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD1EB57749
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 12:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61BB189DAEC
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 10:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027F82FD7B3;
	Mon, 15 Sep 2025 10:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DC92D77E4
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757933759; cv=none; b=islIRDoTsqlpmhQgeGJ8g6PIPiBGYF8BDt+NdXXTlh1P3U0rPuF7L0SfpWm8LSc+uImdkye76vqkG7QIRr/cM1B8R88KWxDbV2T9P73IyhzoVHk55RxLJNXJjyZpc78u/TVAe68HUZKta2wziLecRYC9tYBkJDegbeegjznEvSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757933759; c=relaxed/simple;
	bh=GEJSgsO5Z2xGs50BWLMifrD/+7zn62SbW5k2WUWfB+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pf8L8m7ecv+w5LAUAcOEkB4PTOghyPJxcqE3d6WtoOp3nhxN6Aw/NUozLL3zF3nUfYunV9zZ3Kgs8OAfjITh2bvobOqFrDom/Wx1vCYixW7fLBQkUuegi7KOM8dDvDY+as6oO1dfAL2CzRNrxyF5MfweLrNWpz0i9/e+nIowQZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b07ba1c3df4so593458766b.3
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757933757; x=1758538557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ojo6oKzvqX8/j4uhWlFtqoPQT5IbRZtxXM8tJo4BfVE=;
        b=Aj8dlxgGuVk/bE4hLoX8teCi77zOjsNJrku7Z17rZwuL2jReA8XvkgHgY9++R8rYJB
         g1MUPhvvCC7GS3KuIstqJ0DG78un56MhnQnQke9mtP45BCXBqOEp3V66ORuK1PboVyVU
         0ZEVNI8DbrxyjtdGogYUpo8ng0AK63LmC4EuEzUz2p637+vleL2Cc5ZAsbI9VPH2CWPZ
         3TPLcWBv6egzPvWLXDSJ2oGjgopu48AeWft5FlMlMlqO6WaBLmlOIxprK6u5Onnnm9dj
         kSJHXENTtGFSxNpiJpCaRZaQjXm+ZhipDXniCjQXHlh5wYf5TXdp8h4qyMj7pVR/Srbq
         dMiw==
X-Forwarded-Encrypted: i=1; AJvYcCXxkRRGoWpLwya+gzuqQxEzDpUxmm9mNLLG1+5m/mfq0hjfEV7KZnGjpfBUIiCxn6jvOhOCfFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWHeZjPbc93kXC24OxqOhi2k0lgm9waMzR1uZYZIbMV+4w33Y/
	jva5kx13LIMZPGk95vLVk90yKvi84oIwhotwT8/5XGw4be5osbGQHMHJ
X-Gm-Gg: ASbGncuzWl5E9CzTQ6jiHla0TmDzn9bE+Wlk2djfBIERE/s/yAEWGWkSidCsQYG8PmN
	uOY6Q5jobuBGfrZdgxha0EnEppVI37u0WZWBo0wdWayLLgduDHdtY5yQapc3+r83jIiKFDP1Lcs
	6Ng8jcoFvdwyHYKNgemKLiye8F459NbRn807cipa05QqnQ8xxO+eSjkskmyNMNzlFBxWlIBooi0
	nCgJY/+5iyRJu2KIDZIr2vvYcLBAtIg7AWIQH/CZbfo/t606kyjF9/g/eL9DurMkYKzlufO/FdK
	eBKLsCnLD1P4S+s8vOCPp+mX3r/Fa2lZM4SnWpi7z2Jwz4KFf+se0ek2zZjLGhrsDBtR/JbDwma
	paorD5wYpSEKOyeUNNchJTvQ=
X-Google-Smtp-Source: AGHT+IF8ft3JrAFd5dlXi0U7soWJ7mf7bjTrn94XFIguC2L7TjKvuFQf7Q0Ve+zesz+ofCw1EhAFPQ==
X-Received: by 2002:a17:907:8689:b0:b04:84db:c83 with SMTP id a640c23a62f3a-b07c35ccf80mr1242336566b.27.1757933756489;
        Mon, 15 Sep 2025 03:55:56 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd601sm917014366b.60.2025.09.15.03.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 03:55:55 -0700 (PDT)
Date: Mon, 15 Sep 2025 03:55:53 -0700
From: Breno Leitao <leitao@debian.org>
To: Lei Yang <leiyang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, kuba@kernel.org, 
	Simon Horman <horms@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/7] net: ethtool: add dedicated GRXRINGS
 driver callbacks
Message-ID: <glf2hbcffix64oogovguhq2dh7icym7hq4qkxw46h74myq6mcf@d7szmoq3gx7q>
References: <20250912-gxrings-v2-0-3c7a60bbeebf@debian.org>
 <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpAL=zn7ZQ_bVBML5no3ifkBNgd2d-uhx5n0RUTn-DXWyPxKQ@mail.gmail.com>

Hello Lei,

On Mon, Sep 15, 2025 at 06:50:15PM +0800, Lei Yang wrote:
> Hi Breno
> 
> This series of patches introduced a kernel panic bug. The tests are
> based on the linux-next commit [1]. I tried it a few times and found
> that if I didn't apply the current patch, the issue wouldn't be
> triggered. After applying the current patch, the probability of
> triggering the issue was 3/3.
> 
> Reproduced steps:
> 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 2. applied this series of patches
> 3. compile and install
> 4. reboot server(A kernel panic occurs at this step)

Thanks for the report. Let me try to reproduce it on my side.

Is this a physical machine, or, are you using a VM with the virtio change?

Thanks,
--breno

