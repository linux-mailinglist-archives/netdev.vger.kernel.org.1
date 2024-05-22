Return-Path: <netdev+bounces-97512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F356B8CBCC5
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA87B21AD0
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 08:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FC07E575;
	Wed, 22 May 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="c7hZG5N8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDA5C138
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716365851; cv=none; b=Li3wZ6MNU69HzisScU3OKSgflyuDQzhmWntIUGdciPiLwaKyq94grHkuhVtAMcnM24oh4QghLkTQbH6gtofSvKQ2hIpRc9FPBG/8m2DhQ4e5F9j86LM28OoQjH1v16wT8pFrDSB4PyoVCUgMsMLLZzcdP5LxoPSHB9L7Uv3SRx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716365851; c=relaxed/simple;
	bh=JpAPXBGTodsPSy3NwwfJ8SNzxC6FDxFhAbszrLfwads=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5B4wKYskhVPA6hHI48j2ZaL/o3IVcZFjB8d0vI0Q8ce6Hqdl8pqaVvrf1fbF8zwU9f+Kf7lhKHiaGEDdksW6bHanJhOHFTsBUEBCvHww+r8ZYTvv7hAvCj9vdNf7uBgHNpJEx6jea7jpxQBLHNq5Di7QN/hDOTgbUJRbwZt0LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=c7hZG5N8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a5a4bc9578cso921432166b.2
        for <netdev@vger.kernel.org>; Wed, 22 May 2024 01:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716365848; x=1716970648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUlOf7PiQ+Iis+GSXHl45zjGGmyQX2YyD93PWV/kmtQ=;
        b=c7hZG5N8J2jZui5NvzVuxZIqXd/5iH5iiHnwtnFRk+oJWcgcTEbUIWM9PIIPKzNPn1
         E4WeqUe24db96m3XCdiV4BRfiNTAQFN259Iq0du4sB8UPOzNx2Xu07MgqMXQ5rW9uKeZ
         b+LGbP7Yp8vX239i/xnIgW3GR4zyUbEsXtSlkxJEVbWTBhiwgdABrXHb8UN14PK6SyTf
         nzqT99wjxxCzcJwWJca8QPVoZuD39eeH72b9i5ZtnzeLIVL22SOsvKq1+BwbC/50JYe/
         tHRYjs5V5+DwB2neX18QUaBz++ObedPUbLXCSFaKTW0hINzSPZBrxGCOU7M2PonCJnqM
         xKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716365848; x=1716970648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUlOf7PiQ+Iis+GSXHl45zjGGmyQX2YyD93PWV/kmtQ=;
        b=hIHzqphmT00pwsx6rikCI+fIFk0O+6V4VBBGawku2AiCVWJfNmb2Pcp8q0uGvxhzvZ
         7ZYWccl0Eziwc+IaxeZ97qSZUv+VSMcca/Dw/T3Kc6TCRvh+LK54Yv1QUVShBEVUnhUN
         pfXHqzgQUSO/EKefgLxRnzyqOcpmUruMRMDGZHb90KE3CzsymzhXD3oJYu1n2AFV0uPu
         6zxOG/rPhcTC/cR7X1McE8/S1v+pgdu+qJBMWoLnVefkH8FJVSn0lBMaSKiHYysr4twG
         X5Z5ZNCeEhxIEufCGGVrCM6RmW5Fq9qVJZMxWN2jntIKnmPIYcI/UPda/BWJyLXYP1e1
         X2gw==
X-Gm-Message-State: AOJu0YwQBqbqkfIuIDHEEDlLt7hfWJ1bxVGknFMw0mfretv2BAAPoaMZ
	uX4fNUKZJi01vyCE2H5VWhKHswk1QEPB3JUs/vSvB6yy8UaLSG6+3vc6P75zlEY=
X-Google-Smtp-Source: AGHT+IF2u9M8wmL3gHSyXUK5Xk6BEDD6Xpgeh4DJe8nj6573+HCok4jIjRA3nd/ZBlqBD9qjjds3sQ==
X-Received: by 2002:a17:906:cf87:b0:a5a:1bd8:b7d9 with SMTP id a640c23a62f3a-a62281466d5mr123517166b.46.1716365847825;
        Wed, 22 May 2024 01:17:27 -0700 (PDT)
Received: from localhost (78-80-19-19.customers.tmcz.cz. [78.80.19.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cfbd73547sm799554566b.171.2024.05.22.01.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 01:17:27 -0700 (PDT)
Date: Wed, 22 May 2024 10:17:25 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net 1/2] virtio_net: fix possible dim status unrecoverable
Message-ID: <Zk2qFRSKRkbxdfjJ@nanopsycho.orion>
References: <20240522034548.58131-1-hengqi@linux.alibaba.com>
 <20240522034548.58131-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522034548.58131-2-hengqi@linux.alibaba.com>

Wed, May 22, 2024 at 05:45:47AM CEST, hengqi@linux.alibaba.com wrote:
>When the dim worker is scheduled, if it no longer needs to issue
>commands, dim may not be able to return to the working state later.
>
>For example, the following single queue scenario:
>  1. The dim worker of rxq0 is scheduled, and the dim status is
>     changed to DIM_APPLY_NEW_PROFILE;
>  2. dim is disabled or parameters have not been modified;
>  3. virtnet_rx_dim_work exits directly;
>
>Then, even if net_dim is invoked again, it cannot work because the
>state is not restored to DIM_START_MEASURE.
>
>Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

