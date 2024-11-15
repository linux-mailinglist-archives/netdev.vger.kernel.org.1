Return-Path: <netdev+bounces-145129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E39CD538
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29544B22092
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BEA139D0A;
	Fri, 15 Nov 2024 01:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NlkUy8vl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6752D7BF
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 01:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635957; cv=none; b=u7f1ZlA7UWEs/sfDaR3I87Be9lGtHrP7uLXqzJnV9bo78+L+dV6reRJywAFAwX43QbFR2FgtVzqhGETySgIhPRlQmSH6Gj5M5ENKNN7ggLjoGxUIJvpP6kqJcLGaBWslcJrsnW57cAyCc88wsue+LzxUbB3cTGGt+NMDMw9tWzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635957; c=relaxed/simple;
	bh=9dskGBysdln+lYQVGRohOKlI/bgLYL0kJNpAhLRteA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY8vQV4J/rUxydCMeDQNZwG6Kkz+keM65sjkMq66PxVG6ssy67cn8wo/Tpb9ft7VH92ip8cgyuNuBUApHjiSA1ABy7imBE0bVeRvBLPfp93D6Km9ry1oSgf7AG7+UzmrOM2YkaSG+5RdIh9rOtvJ1Z3m9p8hMi6m4SVLGn3RymM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NlkUy8vl; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460af1a1154so1628781cf.0
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1731635954; x=1732240754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm3KvGlpNbi42Zh2FXESOlpQoGT8BcmT00IYzj/PJNs=;
        b=NlkUy8vlVVYq711xx66haWi+y24Dj5tQGU7+iMqzcvkib3MZqoUuD6n7JDjzVPW/8a
         KfBl+LREFQ+/WVrLscJeN8hOKykW2T8rn7WqhNuafz6WmN4yLO3oGFFaZrDPiv+x39Ax
         uaXlqYHTNHaPEiE3C3XJMpkZJKx5vUKyuvhucedMX1lmOH2gZNcRI96BJ57a5UaksPQy
         q1JOpmIUL5+Y7ijKuRFbjXSQnElONvXO7S90kFjjf39qHNFc43Rkq/phITEEWa+MR2He
         u/HqxrAbkWlzICssz2oPA4rXF5yUsqIv/8VtE7+eynS30AfjLNvRtJHW1pKqbO3v1Pzl
         WQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731635954; x=1732240754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hm3KvGlpNbi42Zh2FXESOlpQoGT8BcmT00IYzj/PJNs=;
        b=TAf3qgKCifGB5Hi3r5+edWPh1+FyOW0P9DQLhETZuQketH3+5ysrKYtAi26hFMpJeC
         uBuD1rprGp7Wb7KEEJPnYcZdnuKH2l1lc7+rE+ENypEb1OTUOagzqjSDO2FJ1D6Off6E
         jpMEZUfJ2ZA3+9Te2YXcFcXUjS8jDYhFx6xorj1GLSFXSB3XpkrPwoPmPMdhmyAcsEI6
         cxnhbpN9PSi+Gg5LzURoIihr+doMZIbKoIOxDIFPlq5aUL9Ceavsfz8C1BNO/HM9n59L
         TtHGxZ8pK0w/t2qSwxASgbg/jPr8Mrw2iuS+oQRZNUr9L+mjXHWV0ZqJvt7dlLCDQDTH
         mkYw==
X-Gm-Message-State: AOJu0YzzB27XQM78J5XiB1vnpBuloBFaLvwhCIvTWLAefUjWXTw/8kvj
	LNVky49EYqZxcKXtWKAVsr5anEY6vE52lB6YtOspakAtAI5rgnezKe5HEDJ9ND8=
X-Google-Smtp-Source: AGHT+IF+aeMqV2rKAuv61HduvUq1HkREkex7cEjAy7nPtVPfuS68jcRhASn6Dsq8GkYqaHel7bXwwA==
X-Received: by 2002:a05:622a:58cc:b0:463:1577:2416 with SMTP id d75a77b69052e-46363e2e5b7mr16159931cf.32.1731635954588;
        Thu, 14 Nov 2024 17:59:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4635a9e97f4sm13129521cf.22.2024.11.14.17.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 17:59:13 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tBlc8-00000002LdN-1jZw;
	Thu, 14 Nov 2024 21:59:12 -0400
Date: Thu, 14 Nov 2024 21:59:12 -0400
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
Message-ID: <20241115015912.GA559636@ziepe.ca>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com>
 <20241108141812.GL35848@ziepe.ca>
 <CAHS8izOVs+Tz2nFHMfiQ7=+hk6jKg46epO2f6Whfn07fNFOSRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izOVs+Tz2nFHMfiQ7=+hk6jKg46epO2f6Whfn07fNFOSRw@mail.gmail.com>

On Fri, Nov 08, 2024 at 11:01:21AM -0800, Mina Almasry wrote:

> > If you do this you may want to block accepting dmabufs that have CPU
> > pages inside them.
> >
> 
> How do I check if the dmabuf has CPU pages inside of it? The only way
> I can think to do that is to sg_page a scatterlist entry, then
> !is_zone_device_page() the page. Or something like that, but I thought
> calling sg_page() on the dmabuf scatterlist was banned now.

I don't know. Many dmabuf scenarios abuse scatter list and the CPU
list is invalid, so you can't reference sg_page().

I think you'd need to discuss with the dmabuf maintainers.

Jason

