Return-Path: <netdev+bounces-143333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 215FE9C213C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D51A32838E8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A658D21B446;
	Fri,  8 Nov 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvag/G/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4196A201270;
	Fri,  8 Nov 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081241; cv=none; b=GFVCmXlhUikeJyQG/4pwc3Ca0DsPvkNfe8BDyRfcjv9dih6ZiUbi5joIjjxoTJtWqZVDLtvXgNcyFJnjYxECOe6cyr3sZGYDNgcJrX4sJKJQOqz8sa5LRRGQlFPEkevkKOjsUnpbhAMLuP8QuHa8PTwMJvrFzmRZSpPusd7pPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081241; c=relaxed/simple;
	bh=ZOFRyTJVIkQXwSBOmbuynIp04rtOCxHeMR0TidFTQCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIaLBzhRZCdQDcaJTXhdh4kePqB62JZ9BIRdXUPIhEnBsISu6vbZZ/OQWj3AJeM+km83VrLJlCCoZ70DVfcrPXJ4KQxi3awIpYu+HpzRYqINDwannjkcKP4ZY9zxRJA+8ILpX31XS4H4AvZOhV+F/M+XFu1IXbfDsCabTnL9IiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvag/G/u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7240d93fffdso1503629b3a.2;
        Fri, 08 Nov 2024 07:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081239; x=1731686039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GhXDskMHNObuJeZQL+8/3H11+e/JKvNdkRoXa+j/oZw=;
        b=Qvag/G/url0RcvdC3wko2pvUsVdycLipMHxZoTDsqXHrmRAFSgRh/k1p/Z2D27gvdu
         5hRdWshVo67nNnuTTb92h5kf4+M4HImwdTVoM6oMpbds41w7WwNNTS28XxY89AANmp9R
         dn1hr2zYrUNLkjCTcZhXRRRmuYMYDM7wLAURLcS8ZTBOPzR/k3UyWSDnIECNxZhXavMt
         l/e38cYqghKhnG5YdVJXiYgZBsvxIZusLWsgxojDqRmF7EzOgCNEL3da+H3MA6+M2QOI
         stMQy1Vr8WeD6klLUcRDRKCE67TISkiFdO+jWiw1EZlYzRp1sS+NDvpNHw89SvhCHmrV
         ul8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081239; x=1731686039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GhXDskMHNObuJeZQL+8/3H11+e/JKvNdkRoXa+j/oZw=;
        b=nSD0dUzjJMI3ncyk+PbQuyMjmv6l5CreJMWdy0cdEi7Ps0Z+Oayjz6z32OTMQeithV
         tkVvdI/78XoIZfakynBASs1wacd5q3Y/Q9DfaxQNTpd/T2s+xBc9q1e/3w4oDjIUM01H
         fVeZz6JcnDwzXuIjZTIsAlQZPV7RlOMyw7i00vUFfROX/kS8jedlRBEsa84CHXxzu//R
         ddA6h0slFw18rF/2IZ1dlU4XIyilRg3rEutHzmy1T1xwnllrhZ+CLwWAe3ruPIF4+N80
         pIcKOXzJCm3BC2iFBtQN8eNjdFh6nZc8PN0TQZA7V7cvoU73pw+lSgOFCNt4T9RVfojx
         4Yrw==
X-Forwarded-Encrypted: i=1; AJvYcCVsST700wpVt5o9FCEbX7w3qofw/iixJ7jyZfjuxBBb2sWSh9tP7wnfbl2rTPCrlWo57f5jgAgHpHU31/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDjMHKGqO9TcBvjKo7aCvDsuW0j3hsb+Ewdsbp0jHU8gnBxuZ4
	U5U2A/gqjVw19qXTTcrCiIVmEx1tOe9SEeOE5RHwFk+L4WPymWU=
X-Google-Smtp-Source: AGHT+IHICJG887c7stLG7bvJWJhNXVjlZl+XzcEQ2YYBgYFGyWwKo1mR65v+NY6JBoPcLMRALQAFAw==
X-Received: by 2002:a05:6a21:3d88:b0:1d9:1971:bca9 with SMTP id adf61e73a8af0-1dc22a47884mr3085515637.24.1731081239379;
        Fri, 08 Nov 2024 07:53:59 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079aa83fsm3833632b3a.98.2024.11.08.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:53:59 -0800 (PST)
Date: Fri, 8 Nov 2024 07:53:58 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
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
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH net-next v2 3/5] page_pool: Set `dma_sync` to false for
 devmem memory provider
Message-ID: <Zy40Fo8foRg_ECFU@mini-arch>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107212309.3097362-4-almasrymina@google.com>

On 11/07, Mina Almasry wrote:
> From: Samiullah Khawaja <skhawaja@google.com>
> 
> Move the `dma_map` and `dma_sync` checks to `page_pool_init` to make
> them generic. Set dma_sync to false for devmem memory provider because
> the dma_sync APIs should not be used for dma_buf backed devmem memory
> provider.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

