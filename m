Return-Path: <netdev+bounces-143309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D380C9C1EFE
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC292854B9
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FF91EB9E1;
	Fri,  8 Nov 2024 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hs4da6tp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7A1DEFC2
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 14:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731075497; cv=none; b=O2B+w0dINOFO0TiBzXimYU8kxCvq/Jfr3eXQzAVtwzyuQB6XQu9749igf8sq1jP0SPwDSzD+10ycjwinAUTUh/nS4DTX0Mb6I+XTcm9wWEIxtbQn0AgCjmGjMlFaFpdNYFqgTDOocsukaHFb5Z0ncOUpI5DU+Eq84Qogh9uictU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731075497; c=relaxed/simple;
	bh=VZ4x66RJI74iQ+5CMch5mxTEeYAqV/btvVSeLOMskSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFPX4+yO0nDmJVfErDJzdDWH5wa6twGT6YDa0Z2J/9oa5ULznGvnCu1cCpKFLBcoZiLXHCzYtgxJ4C/Req+BEvXjlag5tDkYQwpVAmDfUobvLXgQsa0GGIWD3cynHDfdIPOhFH6HPna+TMyUlo3zRsZNyMoLiYZ1ml3LwOCZC7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hs4da6tp; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b13ff3141aso139791185a.1
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 06:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731075494; x=1731680294; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ4x66RJI74iQ+5CMch5mxTEeYAqV/btvVSeLOMskSg=;
        b=Hs4da6tpDCy2VIenghc+mnpcVM8JpttD5VuadFEmKj/iV6Q2RJpkSflTyZmmo0qaa+
         EKeScbKoekx6KRuNefUAaPCuGcESzgaRSHBUoixcAaCPMSb2/PimXT93tOs6vKzyda+J
         xnv04la/utB5fx3DRnKLKTVYfbibIxJml3wBzQ4i8gEogpM1gRUVSyYPZgDfgr++iZO2
         IPKtw8QE/y9OGu3Ir3M2BD3qE8ZzpZPOCxVcTa1/6TPjUBxs1QPUwgMZ2rNytkmRpDtH
         v4Vu3AHIoKb23YDhZu3A/X5RF/MUy7J5tR+Yqe2Q9DjXEUv19KJzEOX+sWmbNbeSsvKh
         tIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731075494; x=1731680294;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ4x66RJI74iQ+5CMch5mxTEeYAqV/btvVSeLOMskSg=;
        b=lIep2mxHWZIkNEDrj95oFTH9isK9QM3VTLSQHJx5kJQnwfkK4DDVQOnU+vjwXSAvEK
         ItEs6bpXgiR5O/lIK7r7CGNFnru1zYkVRnPpPyzxyi3gCPvtlcQatZ13oTR8LGp/QLnn
         8MQzQR9LJ0DlcL4sTN87ldhNH7SB3KmdqGbe4lGECLQLJqEp+A04wp9uJZx77+P/AR/p
         vwJgj/t3tlgDsSrCwHIbyewO+p5TnvnL6/AeN6YTyBoVhDszDbns1/BKfNCuSfz4ECwq
         COO3USrczKd81xwaL87x0MG1eCQVsaJ5vpe3i+K+jXgtMBX3wmYB7TfULMFXJfQq+xbP
         xqyg==
X-Gm-Message-State: AOJu0YyZftIDTBUBTrDPb6bqN1OIT2nn/e7iH4o2TrAFDtwAUMZFJzFN
	q85P8T3TkLh4RQKfO5YITUsKpEdSJ4q0GbTVScnVkPnYTcGdaLymgliUVGG2bZrgrv28k7KJKLj
	6
X-Google-Smtp-Source: AGHT+IG3c3fEM8IzIPqRuYHdjK533ux2t/YAww987YAbZfjc2Mafi+5aXkrFHfn1tNjyvjE3jvlENA==
X-Received: by 2002:a05:620a:254a:b0:7b1:4df0:5580 with SMTP id af79cd13be357-7b331e60d6amr354441885a.39.1731075494492;
        Fri, 08 Nov 2024 06:18:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac2dd40sm162560885a.10.2024.11.08.06.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 06:18:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1t9PoT-00000002ZMb-04i0;
	Fri, 08 Nov 2024 10:18:13 -0400
Date: Fri, 8 Nov 2024 10:18:12 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net-next v2 4/5] page_pool: disable sync for cpu for
 dmabuf memory provider
Message-ID: <20241108141812.GL35848@ziepe.ca>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-5-almasrymina@google.com>

On Thu, Nov 07, 2024 at 09:23:08PM +0000, Mina Almasry wrote:
> dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
> its the driver responsibility to dma_sync for CPU, but the driver should
> not dma_sync for CPU if the netmem is actually coming from a dmabuf
> memory provider.

This is not completely true, it is not *all* dmabuf, just the parts of
the dmabuf that are actually MMIO.

If you do this you may want to block accepting dmabufs that have CPU
pages inside them.

Jason

