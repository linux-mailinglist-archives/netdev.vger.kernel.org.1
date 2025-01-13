Return-Path: <netdev+bounces-157736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95095A0B709
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 13:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CAA166DB5
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 12:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435DA22A4CB;
	Mon, 13 Jan 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv+OfTPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456B22CF12;
	Mon, 13 Jan 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771850; cv=none; b=CNgl0J6wdfxHBSHckB5OUwkbjVNY736OIJHNB5y8P4i9LJ+1uDeV+0PxFKaBgEKUnroNxjUhmGDNzbkuFD8sKCI6WEntWgcEfwwU1NO7BUsELQq4jVlzAMe97ixA7OGyBitkc+IoN/9arj0jwWHO18nrb3w0gvQhBw1N8bB3ZNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771850; c=relaxed/simple;
	bh=iW6N7Hnc6zq4rgI/xQRXlRRdtJZXCWQpggeITXKakBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAn/jOr6IrGsn3sP2A4w7ipRCyyjCatdmrz9tLwnFMsXxH/oADMDH/+lVBmzgEArgYU0/+F+6XQy22e7DzqhfnsPXJdqhyw5OS6O8JIMQEOGZ9ueuAIqqGFC0UVPjsLL30QS0LPeH5/I9PjcMtDfEoxDTSFIZTm5XmKH6QAixvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv+OfTPp; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f441904a42so7395038a91.1;
        Mon, 13 Jan 2025 04:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736771848; x=1737376648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYspswNAJVbjIJeGSav8oevdZS2Al30TlAOrfrWoHgI=;
        b=Nv+OfTPpwPlwkM4RsDB0MfzRjgPWhPsD4C+Rj1854P2WW3qjDjIr81+97bcGL+sAem
         R8LsVPDAFBArkydUVw3ALkwXWvXempQnoylS2QnGzziG0AR6SVEPSUY08HdP1Gu/khs/
         2oQI/XrFTG3I1bn/67j0siQWzbOOFqsSSDfOm0aSvA1dos+5ICKcSXnhFQ/Y0Vy2t3JV
         +KFrj/3ECU6jcMxVahKoGaUTSaKfUybVqhGDMGECLDs8URRHNJbcuo6eJ+zamsXBDFTA
         CRODz/l/Z9MTQHtTNGbV0CmWxjlApvo5PtLSk08MJILWvuOnQ1ZdLogjqvrACfHu8U3y
         g5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736771848; x=1737376648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYspswNAJVbjIJeGSav8oevdZS2Al30TlAOrfrWoHgI=;
        b=BLPKSTyPaHlHiL6V/beA7mOr9y5NZsq7qQzwawABah5iTEdLxZOgz+n2fMl4hHShUP
         DjLCBgVvjMa5HBHSpkQ3DVX4iFqHylMKcic8CP5Qb5j+uNx3nlb1yvOM10+hlkBr0IOz
         xoOSH+zAac3O0ifP63UMTxoVdltO0zd7mluiemTPVYNQRzIxDO3yImjR7NzV9/1UDYs3
         ROzJwoyE4L0c9aniNY4/Iu8nQiu6oGcnDOcc4w15c38B3jRNoMpeuh8d2o8SZzOg5qGO
         HY9j+eID2aqvTWDNFulOWsKFPoOamRt60VA/37DSW1bZ5PZdzxgWs/TsRdNOfw6XtZ1A
         K+/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+D36lpiEG3kVHOfuXghgJDJLqCcZbN51Iad6LtzE0A9XkPJ0Lil38OuFBAca39EZ3KskBXo/pH6D+0Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi2JgIY9cJA9Fk8I1MLEolC0we/x1nQXNFDzng0CU7Nil7NmGV
	3udfjoghkg6n7GGZRISIeW+pmVILgi1nnd01Sk3P79HZcyaqpuP62BUA7g==
X-Gm-Gg: ASbGncub/jHcG7EP57EWFCQFMRSuCxHiikXjiSHSMcKlpV8fyis0/E4kWvjN1Vk2g9e
	du1JQEfWkQrHLRzanThE7IQodq6L5GYWdHL8PuRj4lG9eLKza5yBgMz4by/mlZxNMvvRp3INnRH
	0dXtK1jqj+wXnxI1XSh8MRb1EKKmXNM6Ziv5YbVTfzuHdBgvNgn5O9YLGw7Z82X/f0WY5Xk7JQw
	qbGt35Jm7UmpSJ5xSbp4L2mnJvPs4g8M++IBQKdls7wCWBNNCuDxQ==
X-Google-Smtp-Source: AGHT+IHe1pVSKvtAf8tEME92BvPU8bFiXiKYwUp2o19enb2ske+ljaAhyVZKHCMtZv5/6JQqhbrv8A==
X-Received: by 2002:a17:90b:53c5:b0:2f2:f6e0:3f6a with SMTP id 98e67ed59e1d1-2f548f3979bmr32049199a91.14.1736771847927;
        Mon, 13 Jan 2025 04:37:27 -0800 (PST)
Received: from localhost ([129.146.253.192])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f5593d07cbsm8624004a91.3.2025.01.13.04.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 04:37:27 -0800 (PST)
Date: Mon, 13 Jan 2025 20:37:10 +0800
From: Furong Xu <0x1207@gmail.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: <netdev@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, <xfr@outlook.com>
Subject: Re: [PATCH net-next v1 3/3] net: stmmac: Optimize cache prefetch in
 RX path
Message-ID: <20250113203710.000033dc@gmail.com>
In-Reply-To: <f20c339f-5286-477c-9255-e2e1fbeba57c@intel.com>
References: <cover.1736500685.git.0x1207@gmail.com>
	<b992690bf7197e4b967ed9f7a0422edae50129f2.1736500685.git.0x1207@gmail.com>
	<f20c339f-5286-477c-9255-e2e1fbeba57c@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Jan 2025 13:10:46 +0100, Alexander Lobakin <aleksander.lobakin@intel.com> wrote:

> > @@ -5596,6 +5593,7 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> >  		} else if (buf1_len) {
> >  			dma_sync_single_for_cpu(priv->device, buf->addr,
> >  						buf1_len, dma_dir);
> > +			prefetch(page_address(buf->page) + buf->page_offset);
> >  			skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
> >  					buf->page, buf->page_offset, buf1_len,
> >  					priv->dma_conf.dma_buf_sz);  
> 
> Are you sure you need to prefetch frags as well? I'd say this is a waste
> of cycles, as the kernel core stack barely looks at payload...
> Probably prefetching only header buffers would be enough.
> 

Yes, do not prefetch for frags is more reasonable.
Thanks!

pw-bot: changes-requested

