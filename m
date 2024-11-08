Return-Path: <netdev+bounces-143335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39679C214E
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB6E1F235C3
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4A21B438;
	Fri,  8 Nov 2024 15:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/tJclOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866445023;
	Fri,  8 Nov 2024 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081505; cv=none; b=XEDIbZ5jgA4i3VylOTJ881XNVBN5VhttNeyJJKOR4MeqXSVLStTfQmbbh7ZXqSAnhL5AxEzRaa3iY+i5oio5Wf+PAUbU9uPM729BOrfLcjhc+PfTeppiMh+OT2dDnuC6Q6iq+YTgiGFmdME7Zrh5/7GV5qQWEy6xVU8g1120JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081505; c=relaxed/simple;
	bh=afozFiRkE7iEPjrWijZ2708D4/HZmkMXYMnhbTLwWMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVcznnuF7t4Di3Uz9ewyJ7L3/K7fOYOIncx39pUCoE+LqnooDt9wP9yWPGWIYM8WVEwhGwvSQ74ISNj0Nzn8sMA1yY5pR2gEjjc3XPDwUoKm4xphCOxL27dnwD/uSocY3sIoNgfbf5KtRmclLFfoc7fJ91cQtoWysWxL2gMJ20E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/tJclOB; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20ce65c8e13so25838215ad.1;
        Fri, 08 Nov 2024 07:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081504; x=1731686304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itUxA9/J4nvQf93kLWnaD5cp88YiYORj9PPmK3mprgY=;
        b=m/tJclOBSiSSqdZ9Ie84LdZLqEd36HavOvKChPmQFRH0DHq9nI2JKLVXVeUwgE7RjG
         B6ZbBJiQfnfz83XI90MeY9H6K1e597IEKzfrVeffTGG38ewqNyNpbVaNo8X+SMKS7eTk
         JO95hm7g9gQ44wWPJfpjkIl0nJEQzZUBaP528RyTVEHaNizLznnO7bVkNvceWs3CgQn0
         b4aqp3oDEM9XcP7h7DCSZxgcTXKc1ji0QAUFMe6/cstvlEEc+cErilgy8u3ToSNRzvIx
         tJLIu1BXSlvorW/o1kBwALuz4tfMWbvD1A/Y8APIqndhvpJfdk1nsb+HPUq9RT948H/x
         oZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081504; x=1731686304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itUxA9/J4nvQf93kLWnaD5cp88YiYORj9PPmK3mprgY=;
        b=kFsoEXN3a9ghTgGNOA8uw3x35/1drT82k+Oo/Bi/124gT5MPno/N1U2Ilk5DKJ6uFc
         WLAIzsWbla7nU7/a4Yw9bD+0P0LUUuiol+7AphTyQmGlcZhWbeTHGPgsVu5eS1B+AKkk
         dsu1b70isWhu+jJtQ1liZYoe7gVbXJ89zmu+Ls+xS5lCOh8Sfbxobu4bczh7Slu73zS2
         T69Ti4cIqdEyGhh6aoPGI8WVzxn+3up8RpuAxeDshO3WiHfPaNT+BaJbviSCGblV3fcT
         h/J3oPhF7QKINa0moz3Dd1X5P9M0gYh7qSVMb03Xj794e5bJoNVK2FjwB/kRId2g9WOr
         YA5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlNoyMCNMUGq0SXoBMA8RTAloA9Jruy88VSX0d+pbpMHsfuEhUYm0+dEt1vogu2SLRmeULXj+h55mCors=@vger.kernel.org, AJvYcCXfzy3RGg5YalO+TboOoiWiQIWT2/CT82qSizcnGyDPGNzaitWJsOL6CSLbuakkvPZLff+4My7q@vger.kernel.org
X-Gm-Message-State: AOJu0YyLZxUS/4mL9UT2PUrYE3aPmL4mqzVrGyf9rbABCCtZRVedyyFL
	2VLXveJpazjvQHksuZFzXiRXmQQb60fZNFMzZHLj48zSN81m1sw=
X-Google-Smtp-Source: AGHT+IEyfC0g95d/JDeImgVis8VX1x1WtznA74VvzXF1brv3tF+QYl505poAyz4PgLcJIz6zx59chA==
X-Received: by 2002:a17:902:f651:b0:20c:aed1:813a with SMTP id d9443c01a7336-211834fcd5bmr48680325ad.14.1731081503915;
        Fri, 08 Nov 2024 07:58:23 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e45e8fsm31138925ad.128.2024.11.08.07.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 07:58:23 -0800 (PST)
Date: Fri, 8 Nov 2024 07:58:22 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <Zy41HkR5dDmjVJwl@mini-arch>
References: <20241107212309.3097362-1-almasrymina@google.com>
 <20241107212309.3097362-5-almasrymina@google.com>
 <20241108141812.GL35848@ziepe.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241108141812.GL35848@ziepe.ca>

On 11/08, Jason Gunthorpe wrote:
> On Thu, Nov 07, 2024 at 09:23:08PM +0000, Mina Almasry wrote:
> > dmabuf dma-addresses should not be dma_sync'd for CPU/device. Typically
> > its the driver responsibility to dma_sync for CPU, but the driver should
> > not dma_sync for CPU if the netmem is actually coming from a dmabuf
> > memory provider.
> 
> This is not completely true, it is not *all* dmabuf, just the parts of
> the dmabuf that are actually MMIO.
> 
> If you do this you may want to block accepting dmabufs that have CPU
> pages inside them.

We still want udmabufs to work, so probably need some new helper to test
whether a particular netmem is backed by the cpu memory?

