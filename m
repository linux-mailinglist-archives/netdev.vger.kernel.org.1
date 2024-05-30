Return-Path: <netdev+bounces-99420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03DB8D4D14
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 15:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EEAA1F2341E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5471862B9;
	Thu, 30 May 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gV4TeI7A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D408518629C;
	Thu, 30 May 2024 13:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717076810; cv=none; b=aWUcuOoVuFWWHpmhGcElvIjql4qIdgK4T92LVLxklTtANOJgaTCaHvQLWnuqMzWl2ZKh1gw/GAz0h8q+IuLL7dsJm4n+UY5dI8ru/p9AbCluLhTW3upcq49EyNFE6EJp6rInh9xlOskvEjbJoFBBenCcb+tL+W5wkUyZ+Eaykos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717076810; c=relaxed/simple;
	bh=xzsLYP3PvtzNldWn0y/DyKuFiLGEkM/otwUGFlTpVN0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=WJBNNR4oWesa/d1eJir8g3wH5DHb6q9rpoYMleEBNIq5t4z1RwfQ/Z0VQGtGVEvS6N+kvE1Te72le92sjoHnSdOjJrbyj5TdPwuwtnM5XTTFYvj7P1VBt0SSDJ1/STwqDad9ushOCTtHeHWv36YBPsXomzd/VwCITHfqIsd6SH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gV4TeI7A; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-794ab4480beso69184785a.1;
        Thu, 30 May 2024 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717076807; x=1717681607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOMlhJdODi5S81vxmDzTXqQ87xqgKAfMMIbljNey/4I=;
        b=gV4TeI7AtGBWejFpGb+V13wTMrGeFDTtGCkT2U2mML3ibx954ehyONFOFoylzhb8Ru
         Aj1xTOWBdQ/Ltaa/KwGofCthygttwhiiIt6RmIurcVSHdX1KmIeahEyGFFduO9gtsRK/
         V7nlhq69ZqWG30mEJWy8FNnZ/GDnRZIZJLYN+ix9R0xqaxMgGRewuttid9R2a3bWio9s
         RI6Umh8G+4x8nO43z3IhpJd5W4HBCDwOn84wZWXF7ePrl+Gk6DUrDL30ElyUMIYznxG6
         SJSz+6vnR6kHlqpo7GcO4ehK08PUqCfRigtEfYipelCICkg2HyzRaZ8ZXBF4pbfi+5+M
         ReHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717076808; x=1717681608;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOMlhJdODi5S81vxmDzTXqQ87xqgKAfMMIbljNey/4I=;
        b=DcdnB27Hei75Anu2SVFF+8cckQBG9oQETPfQ1Efw35BZvtkJCgBk5zFsqRipN8ClS7
         3zEN49YF08YulWJ6ZQRhbjEgxMzKK4sa4/DhelxmyR8JzpHUNfD6+BlG8c/kPqix1kFy
         GswkZke3eCYTg8G3S8il92uCxgBjCJdJiz6v64xkGjHXDBOY2grTjToDK2XKXa8Di1wF
         HQ5bAoR60aGSBwkgJaZC4GBNPa+A41ZohlUoJrAea3OykraPaFI4ANi+BVO3zPwr0zYR
         lT1wt6y/qEg3ye0VmWOgyxMlQbPvrWE02Ewqc3G341kolwO5PWF7+qPU7atLq+h5hWbE
         nskg==
X-Forwarded-Encrypted: i=1; AJvYcCUxeOtjxZzFPkRex1yelN40SY85eUG7A8ry8V6SlOxr0278Oz3Cubj1tisZvth7dacmf2P0dVEE4Ij7JWKsTnVZP6AwtMKhwqVP2zmA5PXddezAmGQkiNwahdaae+geV3zPodSW
X-Gm-Message-State: AOJu0YzXzxV1/pFjEplhBllM5DPlosjLR2QUZt6+pPGrled6Lhuzf8/K
	oyJdxZzc9FGWS6TFiE39VNyCZHS/PrpQzAjvbrjlMHnkh/kpsCp8
X-Google-Smtp-Source: AGHT+IHk8gB06uYJcTbM0d3rugqg/RHxJxqiOL7lqKc4wBBMn8XEVJk0W8XYP5CGKnJP59Ao+hpJkw==
X-Received: by 2002:a05:620a:2017:b0:792:bd32:bba7 with SMTP id af79cd13be357-794e9da643amr230268885a.25.1717076807598;
        Thu, 30 May 2024 06:46:47 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abd08e8asm555462585a.87.2024.05.30.06.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 06:46:47 -0700 (PDT)
Date: Thu, 30 May 2024 09:46:46 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Mina Almasry <almasrymina@google.com>, 
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <66588346c20fd_3a92fb294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240528134846.148890-12-aleksander.lobakin@intel.com>
References: <20240528134846.148890-1-aleksander.lobakin@intel.com>
 <20240528134846.148890-12-aleksander.lobakin@intel.com>
Subject: Re: [PATCH iwl-next 11/12] idpf: convert header split mode to libeth
 + napi_build_skb()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Lobakin wrote:
> Currently, idpf uses the following model for the header buffers:
> 
> * buffers are allocated via dma_alloc_coherent();
> * when receiving, napi_alloc_skb() is called and then the header is
>   copied to the newly allocated linear part.
> 
> This is far from optimal as DMA coherent zone is slow on many systems
> and memcpy() neutralizes the idea and benefits of the header split. 

In the previous revision this assertion was called out, as we have
lots of experience with the existing implementation and a previous one
based on dynamic allocation one that performed much worse. You would
share performance numbers in the next revision

https://lore.kernel.org/netdev/0b1cc400-3f58-4b9c-a08b-39104b9f2d2d@intel.com/T/#me85d509365aba9279275e9b181248247e1f01bb0

This may be so integral to this patch series that asking to back it
out now sets back the whole effort. That is not my intent.

And I appreciate that in principle there are many potential
optizations.

But this (OOT) driver is already in use and regressions in existing
workloads is a serious headache. As is significant code churn wrt
other still OOT feature patch series.

This series (of series) modifies the driver significantly, beyond the
narrow scope of adding XDP and AF_XDP.

> Not
> speaking of that XDP can't be run on DMA coherent buffers, but at the
> same time the idea of allocating an skb to run XDP program is ill.
> Instead, use libeth to create page_pools for the header buffers, allocate
> them dynamically and then build an skb via napi_build_skb() around them
> with no memory copy. With one exception...
> When you enable header split, you except you'll always have a separate
> header buffer, so that you could reserve headroom and tailroom only
> there and then use full buffers for the data. For example, this is how
> TCP zerocopy works -- you have to have the payload aligned to PAGE_SIZE.
> The current hardware running idpf does *not* guarantee that you'll
> always have headers placed separately. For example, on my setup, even
> ICMP packets are written as one piece to the data buffers. You can't
> build a valid skb around a data buffer in this case.
> To not complicate things and not lose TCP zerocopy etc., when such thing
> happens, use the empty header buffer and pull either full frame (if it's
> short) or the Ethernet header there and build an skb around it. GRO
> layer will pull more from the data buffer later. This W/A will hopefully
> be removed one day.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

