Return-Path: <netdev+bounces-184158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5594A93871
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C3B9204DA
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112918DF6E;
	Fri, 18 Apr 2025 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jj1mHBhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D602189915
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744985653; cv=none; b=N9I5gQAUPSjIA/Qby5tQGItmC+3Re60Xq4udPWI8wvf9gtXw6CU4+FS8OXUwstRmdJ9Ll9sQkp4Er6Bkwp5F/RsFkQKcVxWdqAE7g6/5z37/Hrux+k8kY8Vip1yQ7s3L+JdjT3RHCZZlWZJci8AvCggtL7NS+vJMtbjXGVZbPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744985653; c=relaxed/simple;
	bh=+s14ujFBBxr6ZBLibix6s/f3Zmt1IGlZJv/wTUCAZj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6OBm2bepkLL27Mmg6wDyTWFCheMPDfrgc91LRNVzMuNuebftPuILOE+0DQD+a2siglH9EOKw8Pcw+RXZuHYFLlLDk/tF1lvkhZnguLg8rU6PD2f/ctYb7LDsFdDsRuU1x7elMB9M6U9no3tICBLJqXLPEAl+mBEYki5I8pSWvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jj1mHBhi; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b0db0b6a677so1022580a12.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744985651; x=1745590451; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJVqYWfvxsMwajl2MePkR1VsXo/YFcgeoMoojX0CTzo=;
        b=jj1mHBhi7HnwV1pQQzoTHPz6ir2u6SKcskfAq7zU/vLdmN/Buc3cO/pJT/JjiGWxlS
         mxBU0zJ3nyuTivRcxZQUm0zQqukUj8Fus+aMld35IYsSLSC0IsvLRZqaCuZm8oqP0UWY
         N4QaXdb+W75lJ1Un70ZzXXnQn1Vk6w3A22XlkogLPDYzR9DOfp+shP9Rrf4hKr2yX9ae
         UjGX4DZFyEhv8+LoXU9mcK8po5d+n0VyHJq2z0lNGQzDhNEBSKw58tIVplC8cPv4MSNf
         8io14CrPfl35lP/Z1MErkzzH1L6ff4ANJM+430vSAcj4WQYvNM1bN8Vn6odMuW8DDJgr
         sI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744985651; x=1745590451;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJVqYWfvxsMwajl2MePkR1VsXo/YFcgeoMoojX0CTzo=;
        b=n4Gm/O56m5v+Zq5Im2qBMMGWEKkkO0KG7lTHpiUl11j15JeeRXqr+Cpc5ijT+bXLAQ
         1u3lWa+dmRQn2dXbf6Wh3pfolXBcJ2JwOg3GVkzlScaV8llAyFyL6EoFMC3+mlulx6lw
         zVGSYA20f0Yfts8r78w5AZW+FyMRtmVPzPRM3LmXOftu4NnRK5arDImDoMH49p9QrJxx
         LW+agUfGZcQG+63yrzYqSVcU38nVkNyAtsGpRIDRvaBStW9srWROCbqwhxD9cjnFfMhv
         bXUhkiDokZf2GK4RyBQaJFjsmsGGXMAQBLcjctnHvUHpMy3kvn2NY+bh0Ra6X83CmnhN
         8m5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa6plCEtef6z/H/VSy95IBnMl1y5VKYNOBaLpjNZCwpTkY+gZBfq1POagNsxAoMqif8wg4ikI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFl5IYp2FJkHGYSYkskJbAMtMgK5rBgOuHVTo+saWX4gA7EcAl
	7j9pho0GZSHxE2cWUxjmMfeqIFrvB7dxZXiIuuDNfqZw/MMh9y8=
X-Gm-Gg: ASbGncvka4L7qJETCREuZ+Ya1Z580k8GkOhR4WUz2wV4qATcLMX3QOkxghmnfGDhPZS
	i1YLRBRYVE5dH1knk8L3Mt6OOReOqGYQ/yZ6FkwzGO1RzZuc3vQ/eQP/axtYhIfmotWeWdbZPFx
	stToBAQvmn6Ms+2uFudtHtR1yQwVdawKfjMOFXD1p6VvTju/O/o+DSQbIXWaVPMFEWWghALfJ0G
	EDMBLWGrN7HrO3FyfcON6Zra3TT6leOhAxALOzB+6ctr5gSLxkHit52PG6oXsEugFolCbG40Cj/
	hk2Elxa6g82kLPwGgv3Zj1Uu87EUcTF/MkhUXxfh
X-Google-Smtp-Source: AGHT+IHJNqp1s/y/9go5qiH7g/2jUGRLtSymcEVqKPAQRWreeDuASeA4kh6gFuKJVofQG9cmGLPYdA==
X-Received: by 2002:a17:903:1b0c:b0:224:76f:9e44 with SMTP id d9443c01a7336-22c5357a13dmr39724755ad.8.1744985651415;
        Fri, 18 Apr 2025 07:14:11 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50fda402sm16877175ad.232.2025.04.18.07.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 07:14:10 -0700 (PDT)
Date: Fri, 18 Apr 2025 07:14:10 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com,
	sdf@fomichev.me, ap420073@gmail.com
Subject: Re: [PATCH net] net: fix the missing unlock for detached devices
Message-ID: <aAJeMtRlBIMGfdN2@mini-arch>
References: <20250418015317.1954107-1-kuba@kernel.org>
 <CAHS8izMnK0C0sQpK+5NoL-ETNjJ+6BUhx_Bgq9drViUaic+W1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMnK0C0sQpK+5NoL-ETNjJ+6BUhx_Bgq9drViUaic+W1A@mail.gmail.com>

On 04/18, Mina Almasry wrote:
> On Thu, Apr 17, 2025 at 6:53 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > The combined condition was left as is when we converted
> > from __dev_get_by_index() to netdev_get_by_index_lock().
> > There was no need to undo anything with the former, for
> > the latter we need an unlock.
> >
> > Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Mina, the same (unlock netedev on !present) needs to happen for
https://lore.kernel.org/netdev/20250417231540.2780723-5-almasrymina@google.com/

Presumably you'll do another repost at some point?

