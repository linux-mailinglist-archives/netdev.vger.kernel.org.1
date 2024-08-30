Return-Path: <netdev+bounces-123622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5030A965C84
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 11:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCE49B22DCC
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 09:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74138166314;
	Fri, 30 Aug 2024 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YOfbBCbc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A7513AD2B
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725009438; cv=none; b=AcUH4DyJ7kIX7B4ioj+ngl0e6jHLVBM0q0AOgTjG0l7SJ46Qs7RPmEkoPqU126nYa0TtvBCtB3V48elJeIiuFvMt7jrrOc+QGrsZUolvkSEDny+5X/hrTpeIcfoGZw1VnIpss7UV6/e9XzQYYRmTZ/ZP31Kpf+WIJxwWy7FQeNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725009438; c=relaxed/simple;
	bh=lUhbIGgVdTdDdlzTf68KcIOihiSBKu2ISMVhd7jgCEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0usho6E8hSCCaX1UKzkAOBGSjF5Y797qbTTV+egJ1kk2VDR8A3q6RFuyyGdAoAeWUNWQdCNp/rM/myC3ss9okrzUkdOr7U7DEyVGbiFGADBbd6r0n14z5DiISZPSIG7mXgkmCK808wmX4W0w3Jy0QmWrRjY9KoOxb82Yfa8bc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YOfbBCbc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a867a564911so192373866b.2
        for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1725009435; x=1725614235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjbhANRsLiLEP8ACvzQx661EfN80OJ46IDQjwvRykNk=;
        b=YOfbBCbcdBp5ihpUjTVddzOm6jmQXR5oqCVKNsdCGaxCR/NCJB3VrbnM4TKeDWrxC4
         Q/8kdTSOLNZvdWEQ1Tqg09+CbcakuRnzMuwBCsgE8zyx3c24CzNWIbaqiY9OIfcBwxFx
         4kT2nFrR1DVp9xhVdXG2IgANnhCxV/A9jc8yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725009435; x=1725614235;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mjbhANRsLiLEP8ACvzQx661EfN80OJ46IDQjwvRykNk=;
        b=vZuABbrxriKC8grjzXKhV2I+QuyGxfvsQu/y+2GtvUY+XpGDAFx1zzzvZmq36bxOx1
         1TvKqGPn2VnFjf0x+pCrdoqbyuU2zFAvromOCfEQLYn3vRVl5yHZ0upxyv37lwdpcfW5
         2UBV3dJwhia0Ku9vzPEDRJpBOjEc5G2YSSdpEf12hoCNAJIajpxsBljad1lfCP8Puti8
         18fQb3MOvtsGbhz+zs3FOL8UcnGiCQ8oFLR4hy9l6KTUaUSCeBFLVLf0Yh9nKAKdjrPy
         xYhWgiRB6cpK7n8BSO7WP/tUMLPKIea4GGKf4nTuzGcbWzsDr9tRWwoRRWiT7Ig72Dna
         W93Q==
X-Gm-Message-State: AOJu0Yxk6T7vw6y4/lTJPHhrxFYbTEbY1DwwwCUE6F8aI8VbrOWiTq2k
	CEAHYJGhAXseClH8Mg/cUP2sJBDJOuYAsDHE9wylcVYmiKXg9c7fUBfohOIMpbU=
X-Google-Smtp-Source: AGHT+IGvqTirfFnspabaCx4RpI6+je3ukSoCMqmoPYqT5LMqR+mXndmFIwpMnxlEpvMyEHfTX/DeWQ==
X-Received: by 2002:a17:907:d19:b0:a7a:9fe9:99e7 with SMTP id a640c23a62f3a-a897f920091mr385108466b.41.1725009434502;
        Fri, 30 Aug 2024 02:17:14 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89972cf240sm114887566b.118.2024.08.30.02.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 02:17:14 -0700 (PDT)
Date: Fri, 30 Aug 2024 10:17:12 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 4/5] netdev-genl: Dump gro_flush_timeout
Message-ID: <ZtGOGMF-bp00zRsB@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, bjorn@rivosinc.com,
	hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240829131214.169977-1-jdamato@fastly.com>
 <20240829131214.169977-5-jdamato@fastly.com>
 <20240829150935.18b3e79c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829150935.18b3e79c@kernel.org>

On Thu, Aug 29, 2024 at 03:09:35PM -0700, Jakub Kicinski wrote:
> On Thu, 29 Aug 2024 13:12:00 +0000 Joe Damato wrote:
> > +        type: u64
> 
> uint

Ah, thanks. I just looked at include/net/netlink.h and it seems like
I can use get_uint instead of what I am doing in this
patch (and put_uint instead of what I'm doing in Patch 5).

