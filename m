Return-Path: <netdev+bounces-198176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EA8ADB7B4
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAE188D939
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F199528851B;
	Mon, 16 Jun 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YofZZmVz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DD72607;
	Mon, 16 Jun 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094608; cv=none; b=F6O0ZSjAgLcAQ2FUPzii/+QvwJvDS00dd4wFCAgEVxhVUnKtelmtTVFnBxYUhtaOtYkvFwTDimHkj+CBfS8fRMU6llv2br2b+rt7dThIdDanLacuJV4Jb6YG5VoLlfzqQF7M2pYcsLrL3sMSdlLATcIjVUx8tVq5rejxds1dPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094608; c=relaxed/simple;
	bh=+l4ppMaVCu63D4oHT/VFaC9XIkU5AWpD2V0YNiZREaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNaeJ25hHa7WTqNq0ErarVLwmDOr/c7BF3xIT3V1ciFTi/e0ni2D8DfdWGpH6rB5+LCp47X0cp3nxDdyH41Lb6IlqPvzlEEjZPRHNt1+b9Qmb1kcEWREb5Y3ZJYJhil5VqFmr/o6Qz8dHBL0mCm9jkzwrrAcXzYRZsiFUVPNQow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YofZZmVz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313bb9b2f5bso5584603a91.3;
        Mon, 16 Jun 2025 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750094607; x=1750699407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bcecguv7Lx+rjWJW35AroK+WdqJscdUsmjDvoTT5PQk=;
        b=YofZZmVzKoPyNZUJdXusZh7H+xumzUNu+p1K3RC8+LNdSkYkVcz2R5WqanXsd7c5CA
         C7Pys5NGoVL8a8hZ4yEGHaS7pusXy3sM6IGOVKK60JHXq6YSaeDOJthrijU8LrFJ6OEz
         buTMQ6f6J/je9TSlkhsWvAyDbFOA/WFWnaSkQPgawsj2q0Hu5re99Oxh02MyBgZiTWOC
         rvicwg22nk9HITuuthwLCacQBoHpmIVm+i9vbaGEWq/SnTSVqIwVdvjompyU+2iTPk2L
         WexvPUWfdlE4OG7DJWtFaxuUs+v25HSsMuIlVI57bUONj7lWoXkx6++t6I4LlkQM4Q6g
         Yxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094607; x=1750699407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bcecguv7Lx+rjWJW35AroK+WdqJscdUsmjDvoTT5PQk=;
        b=n2eFlomyglPRjYOapt2dakhomxk2r00NgYxR4oaMDGnYHhRL4gyo6VHw3U/DRwV0fI
         dIuWBj9m9GVF42jVL1f7wBSrAifw3dOl/wH3sPLydZEX2gDN1nfXspehaWbNNVRiyPqR
         O8TsgPlyzdliycfTfZBCnYckOyhlK6AaoeAumphS6dG6QyQs4LBCi1PzwMnabyhSEz53
         ewKqawbOT6oTikglWOvJptk2KchTaaue5AtNIkqgZ6EsrOg8GH1aqTEKsg3xWu67cIKD
         b4NHEynC23OZk8wFB8AgJ2xE/gU3qgqVN4CeKQLX6FI1oTiHZlg5y3BLxIAkRr8Pkqkm
         ikJA==
X-Forwarded-Encrypted: i=1; AJvYcCVcyJ5ht6aweXeEWv8wiSIrSU0tCW6IY92CcHhga9QpPBXvj7j2nlj/bT6xGv62/kghU2f3QJaZp/R+aYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqquWRokEXigDdPFupAQHvFy26B0ZZ5XWMARjk8ATRMCnRnBVo
	FkLlg3gtalLVnPLT+i9EkCQFB2RO4Lnfe5fycLi4/c8XEzQ+1bQq0Bo=
X-Gm-Gg: ASbGncsem3J4EsoIjo8Z5YvsRRY3zLlIanfuuz7YMvT6Th7LcoSS9/IwolLeGMiB4J8
	6igecElqvCNntukc5UGi40fsLnC4r2Vp/H8S3Tf5aqj2wgduXZApE4HhYEHjQNaAEbybJ/mgvA2
	9NDMdiJ0YndT3wCe0nKf46qgOYaTpPj7hgherBcYMGEZy4C7y18zBv98AazFMs8DsYRKtncukOS
	DhXYecfJTBvdT2E1Lx5C0l1apd+E8G1+SCoJQY/PYlaELNii86gR8BrQiJt1ByM62Rynqlh+BTr
	74C4le5ktAvJCWfWRaU7PFHHxNJzMrk/sYpbsTmdB3HMK2cxfGYPSRH0I73jQS3xD5HOIokyK9L
	Bc+r7IWuJEYYJGQDGbpU/nij6Lr5BCW9Xgg==
X-Google-Smtp-Source: AGHT+IFfQB9Clm1X82qpx0OvfXc8H2gIYXEJfbAdy0qqZVrsr/8ozgKrWw0ODjmsciNUtolB2Tuv5w==
X-Received: by 2002:a17:90b:2dcc:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-313f1c3fb20mr17528197a91.15.1750094606695;
        Mon, 16 Jun 2025 10:23:26 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365deb0fb6sm63390435ad.141.2025.06.16.10.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:23:26 -0700 (PDT)
Date: Mon, 16 Jun 2025 10:23:25 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, willemb@google.com,
	sdf@fomichev.me, asml.silence@gmail.com
Subject: Re: [PATCH net v1] net: netmem: fix skb_ensure_writable with
 unreadable skbs
Message-ID: <aFBTDZPj97PAe-EI@mini-arch>
References: <20250615200733.520113-1-almasrymina@google.com>
 <aFAsRzbS1vTyB_uO@mini-arch>
 <CAHS8izMgmSQPPqu4xo1To=4vFvJi+cxP72KewhMJ+BqDbka0hQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMgmSQPPqu4xo1To=4vFvJi+cxP72KewhMJ+BqDbka0hQ@mail.gmail.com>

On 06/16, Mina Almasry wrote:
> On Mon, Jun 16, 2025 at 7:38 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 06/15, Mina Almasry wrote:
> > > skb_ensure_writable should succeed when it's trying to write to the
> > > header of the unreadable skbs, so it doesn't need an unconditional
> > > skb_frags_readable check. The preceding pskb_may_pull() call will
> > > succeed if write_len is within the head and fail if we're trying to
> > > write to the unreadable payload, so we don't need an additional check.
> > >
> > > Removing this check restores DSCP functionality with unreadable skbs as
> > > it's called from dscp_tg.
> >
> > Can you share more info on which use-case (or which call sites) you're
> > trying to fix?
> 
> Hi Stan,
> 
> It's the use case of setting a DSCP header, and the call site is
> dscp_tg() -> skb_ensure_writable.
> 
> Repro steps should roughly be:
> 
> # Set DSCP header
> sudo iptables -tmangle -A POSTROUTING -p tcp -m comment --comment
> "foo" -j DSCP --set-dscp 0x08
> 
> # then run some unreadable netmem workload.
> 
> Before this change you should see 0 throughput, after this change the
> unreadable netmem workload should work as expected.

Ah, so this is basically all netfilter, makes sense, thanks!

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

