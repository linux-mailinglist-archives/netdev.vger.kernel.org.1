Return-Path: <netdev+bounces-121452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AF495D3CA
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 18:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1B31C21C3F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D2F18C346;
	Fri, 23 Aug 2024 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="CTh6LX8v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94F218E059
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432059; cv=none; b=ADhZ1j7n6mI7Vrx31/cCdhzfYREtUZjG5XoNhKpy4ZkqxcOkRDF5TeO7uo7v4dQ0ABWs4lxM7gjZvUNN2tRj/IZnVIiAR3fubbtkTjkF+SlF5cWruFxxegqS6zhyQrcVoGt88DLnuRuBJPCvIihSomjrTTdyU2mLhPaz/VdO9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432059; c=relaxed/simple;
	bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NzBMoZlVBjmy2CPI97XZgVJGlSJfFP/pOs3Oa4xjFfAhAd08qo40pOolAOoSPjVnLFxErrlnzHq5lWl1JyLlI+9nZmk2t1HizlQKrox/CzEWG50Vcx1nyqcMyBAH+Opyjea9LhPoFuE4Di62zvET4hJGQG2qxGgxR28yfCxaQhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com; spf=pass smtp.mailfrom=digitalocean.com; dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b=CTh6LX8v; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digitalocean.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digitalocean.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so2437667276.2
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google; t=1724432057; x=1725036857; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=CTh6LX8vfmq70xS2bf5iF08XblWbEXQl1P/S89D6K28fHKuGHn3tYHVHfxW+Y0Vqu3
         zgyxaPXJTRDPhEm0I6gaBqjhUOYzCR8u3sdAbnK2d9C2lYwTan+Ng1iHyGUUJZR6+0Tl
         QAP8nck6XZ2DHbb1R2UaSf7GlTkr8DNpa0qvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432057; x=1725036857;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLM8J7H2DsgRDxPVtS0CcqhN2nJId985NbMPevWwKAk=;
        b=FxohzeMeQJTdDjA2HVOlwWCL2nEzwtVM+XP63QaQiN3JYH1MrFM7ENhbn1Ptl+NSo0
         WeWFqcfeSAWCVQs3w3bPPakdAx7WcbxxqCRoSjbUolwFSWfFoCTc2hqmEaMAtf6WgZgp
         kxczGD+uz3VonEC+T1AJATXniIj7kfYMgVSzEgS4a4Feo2P+/zVkDJ+krwHnkRCnCW8X
         cQypUDYiGcvD0kFD4YOpw0MowSwyeiiOmeQ0xMW8CXYXckLF8TOc0pGbHwFjTQqokLVu
         2uVlf1sYE8jFhxVz5zZip9EO7WPJRunFZlZ9vik0luStwEq1OoEPEtXXtzZtlu/X30gb
         Y8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOzqkoQBFnvukl5BKhcxKgrNww3l/hrzxLJTp/qImqivbtO3DFRPAbu6dNEYsU8fj1ofRxdiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJvHDqljgrby67Y5Ias9pULLmTkB9DhZkWo4PqfdTBM7uSkD/f
	v8Is4K+SVR/k06VRXtESv8LGWaZK+3R/k5h3mlH3CzPW4SXnPA0gxdohHGiYkrs=
X-Google-Smtp-Source: AGHT+IH+lZIalG0ZppdDUStKyMfxmA2xRM0YnXPLiu2xPW0X1PX57ufunWwRCXTvVh1qWh0OpYdpBw==
X-Received: by 2002:a05:6902:2383:b0:e0b:e4ce:9047 with SMTP id 3f1490d57ef6-e17a83de244mr3495755276.18.1724432055984;
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:45f:f211:3a7c:9377? ([2603:8080:7400:36da:45f:f211:3a7c:9377])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4406b0sm720032276.12.2024.08.23.09.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 09:54:15 -0700 (PDT)
Message-ID: <33feec1a-2c5d-46eb-8d66-baa802130d7f@digitalocean.com>
Date: Fri, 23 Aug 2024 11:54:13 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: eli@mellanox.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, dtatulea@nvidia.com
Cc: virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, mst@redhat.com, kvm@vger.kernel.org,
 eperezma@redhat.com, sashal@kernel.org, yuehaibing@huawei.com,
 steven.sistare@oracle.com
From: Carlos Bilbao <cbilbao@digitalocean.com>
Subject: [RFC] Why is set_config not supported in mlx5_vnet?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I'm debugging my vDPA setup, and when using ioctl to retrieve the
configuration, I noticed that it's running in half duplex mode:

Configuration data (24 bytes):
  MAC address: (Mac address)
  Status: 0x0001
  Max virtqueue pairs: 8
  MTU: 1500
  Speed: 0 Mb
  Duplex: Half Duplex
  RSS max key size: 0
  RSS max indirection table length: 0
  Supported hash types: 0x00000000

I believe this might be contributing to the underperformance of vDPA. While
looking into how to change this option for Mellanox, I read the following
kernel code in mlx5_vnet.c:

static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
                 unsigned int len)
{
    /* not supported */
}

I was wondering why this is the case. Is there another way for me to change
these configuration settings?

Thank you in advance,
Carlos


