Return-Path: <netdev+bounces-250940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04693D39C14
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 02:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73B1C300F196
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226F3221F20;
	Mon, 19 Jan 2026 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTxVxdH+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345421FF2A
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768787108; cv=none; b=Tt33fKrlGH1Zzl+tnSkV4W1MNe1hYZ2H5D14Nrr1VuX3bNXMZIlgnXjlvO/lYfYL6MZhzPKi1yZCqL14lRbIMf9kiUmtLCtxWlAoD5NEdPuTyZcBhZmM1uM6f7RDqZvUsmAwzUNq9CZgXxeMId3VGlxObjoZ0GTE3aqxLkPHyoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768787108; c=relaxed/simple;
	bh=U8PNPh3IzoGoEPY4cEKOEaJDM5WYCHkHtLD8h7dHgf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aRnakGHE+2Unf979Cbtf9RDf+4vy1n33xGmUksRe10YSkz37uhgBOLu3FQg9oi4e2U14FOe/XPIvm/Q/Gat6q5et6vwJ3fjlHSI/XXI74TkX9s0mxk2lou6zT7anKiZ8sd0lvQx8MO5olX4kxb6ctea3mASNULElE59sAryxdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTxVxdH+; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ae38f81be1so4381013eec.0
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 17:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768787106; x=1769391906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8EOGYST1p2LOOGAv7v8y7rda0D/LyXqaBPdKVh+hRg4=;
        b=UTxVxdH+CDXUnn9O+wfOzieMoLHEXGPhijOrPsfpGoLc1SaOba9EEKXks720Lc1z03
         00vIKX8vb3lzXaNYzDHZOa+UGV32YgUj9Gj8q3kip6PLsMsow9++ijU5bcZjbgzvZ9/C
         HAYsirzDuT3Hotclop9tZHuje+RCqtf4TQkOkNwKGAXPyid9Y8uJXumf4zGs6C3Do1xP
         +j8Z/Qcz9187N2KUM/eUM/FPVckTvuhttVuXoQFbUQky7JXOXzRyzoPontzfS8ymYmnl
         eYlVvsvrYfCdqpa0OjyVEZJYlqTTbtAXG4/oBEpWmGqcqDWqYm/wxziNtQU5lc7yejpg
         yfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768787106; x=1769391906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EOGYST1p2LOOGAv7v8y7rda0D/LyXqaBPdKVh+hRg4=;
        b=Wzfe6tu1fMVT8aP+mz+mZddfUpoAmDe3dGhpNgISAGRNNmPGABQGqmnPacHwKD6qxw
         O1vtmB4OvqwiM9T60QNUKpunHFjShaW/lFWvwfHWNhXKTXnxcMOZGP0R8J4CQaWW3+l9
         Vg9k6B5/P6wZ/MWz+6CGNz2WddsFskDm+V3GD3caEM7fKKRwHBwZ3Vf438Q7BOQZ35Wy
         27+iKMjx0FmoSsQ3eZ2w09WkcQTl7VQ9DBrWXh8dxLEg+08Ei0hC1+hrhMlniZ/MKjx+
         yXzxu7PNx7TooWKVX8+XnGDrpcd7aIHWuQ1m0GZoigLtWKVL9J/rV5UUzbgWC3FCUIiw
         Xqqg==
X-Gm-Message-State: AOJu0YxI8HCFLlJ/6dnFa02lCPTU6lfYnscZVwqw7GHFkJi2Pbs9WSyg
	ht4SyejBl6/pOn/sY0qY53uxkBBSmqau4/ZjHpklvTA/Miwto2/rCSQ=
X-Gm-Gg: AY/fxX50PovlzqQYoGYuV/H7LRZ9Ao4NTbRBLnDRJUQlOUEZsm35LHZY/FlyL7n/ZBg
	eG7BXa1JiWsE6yBKkFE2fllTCsoEt9ihR2GhJsCys87Dna7+UGHY0SXm3E6NJBY+NGOdsNw6AOb
	Bp06oLFnlSJNRm16GY7qU4hWSYv56THljvqik2G29HS5MRwMvrcS9yiSMiV3fndDnifUD2wfRTP
	Jkqlojqq27a7HNSlIaXyASuXbJ3YD2SSfNHR5Un2HkkMSPBW0QvLpTEFGYC+Z3FMH1+u/bXJ8rv
	yiioVU4+X3xlyR7GpWHZXqFfE8sTGowZm4ypV0rmLGdsjoN+bMN19DVGSTBLpOVePnBiPqZS+JQ
	47ic3THswxftzj+J5l0VHDZTY6SzOgCk1Jyx+IlrwHpZ/g4sR8xUO76GkCYOFYO3DOyqRtTrdDw
	PznZbW1ryRUZ3D/X8xPnRHSa+45MitvUQHdiaBooavNIS94Si54ahp+jxqDyNllRoVx/utC8ypT
	yXvBuxMSIwj3vI4
X-Received: by 2002:a05:7301:4194:b0:2a9:97bd:a844 with SMTP id 5a478bee46e88-2b6b4e8cb91mr8200129eec.21.1768787105717;
        Sun, 18 Jan 2026 17:45:05 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm12601055eec.32.2026.01.18.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 17:45:05 -0800 (PST)
Date: Sun, 18 Jan 2026 17:45:04 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, razor@blackwall.org, pabeni@redhat.com,
	willemb@google.com, sdf@fomichev.me, john.fastabend@gmail.com,
	martin.lau@kernel.org, jordan@jrife.io,
	maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
	dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v7 06/16] net: Proxy netdev_queue_get_dma_dev
 for leased queues
Message-ID: <aW2MoKSFflEa3CtU@mini-arch>
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-7-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115082603.219152-7-daniel@iogearbox.net>

On 01/15, Daniel Borkmann wrote:
> From: David Wei <dw@davidwei.uk>
> 
> Extend netdev_queue_get_dma_dev to return the physical device of the
> real rxq for DMA in case the queue was leased. This allows memory
> providers like io_uring zero-copy or devmem to bind to the physically
> leased rxq via virtual devices such as netkit.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

