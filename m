Return-Path: <netdev+bounces-191186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C95ABA5BD
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923B21B68A72
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9663F1E6DC5;
	Fri, 16 May 2025 22:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h13szOE6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061BC1F869E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747432843; cv=none; b=t4gqysxfgwS7MfZrKni7B/Ix2zhTvIsSUszhkfn904XDPNYHx3IyeY+JW0uHft6Of0iJFwHMAGDwl7EQkPk8YA4LjbWIeMWfeARN0eyC4/zKwAxZBHoOmYKfqMxuyHQY9jHd0vrn7HFsDYBR5Jleki/HeCp9/nHuncKcwfPU8H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747432843; c=relaxed/simple;
	bh=5VZtF9AyznRPKuOqsiMV6dDZnc721hdFgFtzY4XMqgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1YJearAOpxWsXldg8nF2/8H1y99bDu/4+Eh+X40mIB+YeEqa9uU9tPqC9hfM4fouDPUl0fIZBE3+R8ZQqZAnMqjqyGW7hKwlrAsdrk7owHYev/uqR3HUaNI3QCtf5dd6Z3uGwQQmYpfs6IAS4OVoqCJuIwEDooObZ2QET1W4pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h13szOE6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3081f72c271so2348742a91.0
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 15:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747432841; x=1748037641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cpirbzKS7jiFqYIC2XpFKRSuU8HHsNv2ttRI5hFJeCM=;
        b=h13szOE6qYHBmSFthrQL3aZyvIa/HuSoV3PJmMV24PkZOCLVciuDganSXNkhm94dl2
         IIm5PSZuNRIieeUKPfDbSVDTrSnEQgKOHv2qy7ZX/o0mZqbma16HZURttAonRl+cwa21
         NOQQAirKfa3K3YT/DHBCu/W85RNhkAt1VRWSHmXRqXSD+TIT0CJVc1JDZW3nIMBaa5Sl
         GBP4Scaxcw8I0m5efKlmIt+RxVmpb0IrVRlyvquO74Q4OlsETp0Gsronu1Fd7mPh6eKq
         fmyGYMW6dwM1a0WIouTa9Dqeg02010XV8q34fLSxOy7GNzlbpzO7mqG+WPS8pIvC93vs
         iV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747432841; x=1748037641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpirbzKS7jiFqYIC2XpFKRSuU8HHsNv2ttRI5hFJeCM=;
        b=TSOmZxkliGqktTwJB78ytAxHKCtcz8ADoGkRZkui7LS9ACcDpbfw/inVkAKvudIU/b
         pwXM+tAqszdWmrfzMbb/rSot1qz+Dsr+cbIyNL17gnYGsD4TwlHCODm3D1MwDp47sHXT
         p/msRGOGXwnJTZc5W4tyAWs/TWEf0YW0Ao9l+bNbb3at+cAswMi/985WKxS6SBlyvEyl
         f2OahWSi/YZ624F7P1OBssNlLNUbdwJyJFgOoI11bBpLmmMeK3P/VPZwsglHHNRKWHah
         fm+fpdGKtSz1s1NIO3e5pa1Sye8cwlyG2EIN3UIa7BgSY2GWaGd8N2ZY+ALU6L2TRFHH
         n/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqUqJNbmk/ba4U62/UsVrckrzslrUtZjsGFaCP3SIWGRjw0zZVgWmngdpMY/pQAyb/GJtrCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu63mUKn90SPyIT0Md9JT/T13xcjKg8RrBdPdMWV8FfOOvCDM0
	BKjQqlQnTmC43MGSuG3tWJlQ3rmQgPWrkK4SHDsN5KTlGNBY9xIqMbI=
X-Gm-Gg: ASbGncvWJOfL9mLmF90mdrOLSqqyLjsQHjivWsJcpAV6fVdHje3H1pAnpWHOwP473S4
	xitJxwpxoQv50ucUX3ywjZ9cQ5KngvYCohj1X1ACXXsVOichEBd/WEXJMvIGMSHv8mZqcMVDleM
	lTyhe1CaQYa3jP1+uRGxIcKmg+ABFgdB3PirtawqO1nRVHDesxp2g6dkzI5EJxr6/yDmjocGUHM
	vfcVfKne5CJbfKDcrLXktc2gMwnuRGIkejrgl5ZrRZUqW7g61ihIhLG3GOtTpaY0HnRXXv/m7Wv
	YH9+0OrF7Ys6GmHUoZJsmXMJPbFS8MTFk4UVmKftpoEuHqHjOXiwn5aCd76+11wnq6g/BjNuv21
	8sKot2asbiBF5
X-Google-Smtp-Source: AGHT+IGUlj8O10zTWcNisoHTb84m6Id0Ei/3Wgu96diMrExwv4VRh4YQWiqeD6FHvGcc3aU0G15J0A==
X-Received: by 2002:a17:90b:52c5:b0:30c:5256:3 with SMTP id 98e67ed59e1d1-30e830c7a9fmr5621597a91.5.1747432841049;
        Fri, 16 May 2025 15:00:41 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30e7d489292sm2060337a91.16.2025.05.16.15.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 15:00:40 -0700 (PDT)
Date: Fri, 16 May 2025 15:00:39 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net v2] xsk: Bring back busy polling support in XDP_COPY
Message-ID: <aCe1h8tNaEqqUlO0@mini-arch>
References: <20250516213638.1889546-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516213638.1889546-1-skhawaja@google.com>

On 05/16, Samiullah Khawaja wrote:
> Commit 5ef44b3cb43b ("xsk: Bring back busy polling support") fixed the
> busy polling support in xsk for XDP_ZEROCOPY after it was broken in
> commit 86e25f40aa1e ("net: napi: Add napi_config"). The busy polling
> support with XDP_COPY remained broken since the napi_id setup in
> xsk_rcv_check was removed.
> 
> Bring back the setup of napi_id for XDP_COPY so socket level SO_BUSYPOLL
> can be used to poll the underlying napi.
> 
> Do the setup of napi_id for XDP_COPY in xsk_bind, as it is done
> currently for XDP_ZEROCOPY. The setup of napi_id for XDP_COPY in
> xsk_bind is safe because xsk_rcv_check checks that the rx queue at which
> the packet arrives is equal to the queue_id that was supplied in bind.
> This is done for both XDP_COPY and XDP_ZEROCOPY mode.
> 
> Tested using AF_XDP support in virtio-net by running the xsk_rr AF_XDP
> benchmarking tool shared here:
> https://lore.kernel.org/all/20250320163523.3501305-1-skhawaja@google.com/T/
> 
> Enabled socket busy polling using following commands in qemu,
> 
> ```
> sudo ethtool -L eth0 combined 1
> echo 400 | sudo tee /proc/sys/net/core/busy_read
> echo 100 | sudo tee /sys/class/net/eth0/napi_defer_hard_irqs
> echo 15000   | sudo tee /sys/class/net/eth0/gro_flush_timeout
> ```
> 
> Fixes: 5ef44b3cb43b ("xsk: Bring back busy polling support")
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

Looks good to me. But note that I never understood why those __sk_mark_napi_id_once
calls were there in the receive path in the first place. Presumably
because of the unstable napi ids. Now, with the napi config, it should
be safe to resolve both copy/non-copy modes during the bind.

