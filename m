Return-Path: <netdev+bounces-174020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C4A5D06F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD84189F492
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9737264F96;
	Tue, 11 Mar 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3Wr1mqj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B87C264F8D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723628; cv=none; b=hUUSP9brG+aTcJUpnJndp2sLoGbJko9tJoZ6sO1xUeh5zwieVUK/h7uAmFH+Y0K8aDtxf85xQ3AXRBGjBJOaCy/LZRtYeqGqEk6PsNenvD3ksVbxqCtO/JJbnEUsqVBhkhCGcqtaPXk2cFw2IPmws6qothaLDNBBgSgZ6wcjkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723628; c=relaxed/simple;
	bh=gk5rI3PaB7/qQeF/i4ZRcgEGOTxbw/Uwdbviq6YicMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exVI21hanjBvrrVFsFwmIdWLWzCIT3X5JF+d1FQb2hjInGvyqBocyHf8W8zLNjZoCFCUHTHkBi17kCBhW6o2yqWUx74NtO0+WIX1g+e+B4LyJxvEgRenKx+ThkxyUGs3fkjTUFmtmE8ieZzdr7pOcAuTYAV9FFIkt6t1vYqpE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3Wr1mqj; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff694d2d4dso8668157a91.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741723626; x=1742328426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s+wJPonUl6ROUmTS7OQPORU7j++iVBxmc9NH8tejtmc=;
        b=D3Wr1mqj3iFnipZOXYgB28jfLPMouyFfyjcq50ZmzrMNlk4jr34fPvbOjWm0HMHPvR
         qJ+qyYTWtIDrX89kjPhBcIJulwQn9YJEWFVUDhssbTGAn1+wkCIawShvv+V2B2wc5ul2
         ajDQbXKQjJaN46tagkbSVuDvMWT71oS9mDlECBAYqio+UAlgsddZU8SUgQEoGMtGSWai
         xfIyaGf2+bW60x2mEuMOzH9G4ENGyEQro2Q5Kb8gy9V9ugdz/i68mwYn3qZ3nfaDlMmJ
         f8hsIYTokD6YeQUuOZNaslZiyBEPLgwUv03QYtKK4m/vo43X+AfyMhfWaav0bWfBnzby
         949A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723626; x=1742328426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+wJPonUl6ROUmTS7OQPORU7j++iVBxmc9NH8tejtmc=;
        b=cGHpejNgKCi8IB6XXfwgUjFzDI4XweUdlgdwHD0yChRDYHJBsmJsxhvyGzrRKOBLUo
         b6qgfKWI9caHL0lLJH4OslXX7oaPcU33gjCmozHHvY6m11ZBDk1KwwCEQeJKMj9oDIAP
         Y4M4FJjc/ux5/8YB0yh73C/N+QlWVkjpNoPS+omB8y4DFZSk2Tnpcm9KosOemVFBIVyi
         1krHT+B6WntebzDnPe5MuYbwWRIg9lEYc0HFdvygRS5rlPLicdOm3/h5751cfsZ+z1m8
         uCjVXa6KrrBuqMR/OhYOxBQtAqlbljEoUeywo5KTXhGVG6pFJx1osn9+PirdY5HqvhzZ
         exeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpwHjMKjVd7/oJD89KDFDubpmjh5szoO3So4OFYP8mMXxGUiD6ySYwQOvUij61QdnmDxeU8FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE3E6MmY8yMpmTc1lJsP81A7kgYvHNJM9UR0vSZr+Hpzv47NkQ
	U2bTOgNXcWqVttX1GsZPBLjgoW7snVi0b39Dxz5zMyb0MzUMuUZ/
X-Gm-Gg: ASbGnctBI9xRmLgQ41iXWyXsjV2as+jpJQNxSQxrByQwlxuuU+7bmpFjAOi5YezRZtv
	RAiSjBi+l/YBXDQ1uemgE0YA0ua4sNfCX3CkrF81zhPY3UyU2b5RT596J6d7juTJLMDJf4+NrZq
	EJRHNjqlnpZaxZU13n3kU/mAPZQqt8345av3LIBcaF4oQ6192hOWZ1d1rw5L/jTO/nl84d2OSq0
	z1DfgvknxX3szoQxEaDgk7qHBihX/HL9y9o3nks5E/VEqsvDy8PBa//RkZrn1BHr1gh1G2tDHRz
	/fElEX+ZJCuK7s8WBWVKeMBCyQfxmtJ1kDOwPcPMjEsTXnmL
X-Google-Smtp-Source: AGHT+IFOyoBLEHmkIguebfEegFFu36i0vWylQY73aumaN1ZU/zhq3QVWnJj+6EZVkZi3o0/2J7G+4Q==
X-Received: by 2002:a17:90b:17d0:b0:2ee:ee5e:42fb with SMTP id 98e67ed59e1d1-2ff7ce7abc1mr28641438a91.13.1741723626294;
        Tue, 11 Mar 2025 13:07:06 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3010db4691esm959316a91.2.2025.03.11.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 13:07:05 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:07:04 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	jhs@mojatatu.com, jiri@resnulli.us, mincho@theori.io
Subject: Re: [Patch net 1/2] net_sched: Prevent creation of classes with
 TC_H_ROOT
Message-ID: <Z9CX6IKX9pL+NPYU@pop-os.localdomain>
References: <20250306232355.93864-1-xiyou.wangcong@gmail.com>
 <20250306232355.93864-2-xiyou.wangcong@gmail.com>
 <20250311104835.GJ4159220@kernel.org>
 <17414eab-445d-4669-89a9-855a872f7c16@redhat.com>
 <20250311160449.GP4159220@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311160449.GP4159220@kernel.org>

On Tue, Mar 11, 2025 at 05:04:49PM +0100, Simon Horman wrote:
> On Tue, Mar 11, 2025 at 01:47:32PM +0100, Paolo Abeni wrote:
> > 
> > 
> > On 3/11/25 11:48 AM, Simon Horman wrote:
> > > On Thu, Mar 06, 2025 at 03:23:54PM -0800, Cong Wang wrote:
> > >> The function qdisc_tree_reduce_backlog() uses TC_H_ROOT as a termination
> > >> condition when traversing up the qdisc tree to update parent backlog
> > >> counters. However, if a class is created with classid TC_H_ROOT, the
> > >> traversal terminates prematurely at this class instead of reaching the
> > >> actual root qdisc, causing parent statistics to be incorrectly maintained.
> > >> In case of DRR, this could lead to a crash as reported by Mingi Cho.
> > >>
> > >> Prevent the creation of any Qdisc class with classid TC_H_ROOT
> > >> (0xFFFFFFFF) across all qdisc types, as suggested by Jamal.
> > >>
> > >> Reported-by: Mingi Cho <mincho@theori.io>
> > >> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > > 
> > > Hi Cong,
> > > 
> > > This change looks good to me.
> > > But could we get a fixes tag?`
> > > 
> > > ...
> > 
> > Should be:
> > 
> > Fixes: 066a3b5b2346 ("[NET_SCHED] sch_api: fix
> > qdisc_tree_decrease_qlen() loop")
> 
> Thanks.
> 
> Looking at that, I might have gone for the following commit,
> which is a fix for the above one. But either way is fine by me.
> 
> commit 2e95c4384438 ("net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT")

Indeed it is. Sorry for forgetting about it.

Thanks a lot!

