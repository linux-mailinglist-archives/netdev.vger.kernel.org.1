Return-Path: <netdev+bounces-173129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B88A577E0
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88C463B6431
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9112CDA5;
	Sat,  8 Mar 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inyxdyag"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB38F66;
	Sat,  8 Mar 2025 03:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741404789; cv=none; b=MGWoxmlMT8rPbNd+izUB66QJ3AWQJhdYn/uuJxezv6l6RIU0e3DuND1p775HG3x+cfXXbsGgEe3bhoChfSSvTzsHn/rVMBm16xX5c0328FrxEI1XAwRhomcdUsOg8e0+YuF+8CRxZUBvnfGeg2hq4LVqN+wvPUPgWEjyU7cZDLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741404789; c=relaxed/simple;
	bh=J3GOrkHlYe1f1Ad/hqfBmcN6lLCGyERRLaUQ6yh6PBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkkVuSokSjyyoJcuq4uVu7HzIgtjU/K1KZmfiqAuigiUoZNUp2tEDICGi1abFFphaxmVttIDnmQFOGTw6SKobJzpRzWxO+EFQhAJZNUgDbJ5rxf5CdHx3yh+/atNvR7p0NTFwBpaWfH431i4NAwOSzepa0wqPIE9kHOoidT6s94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inyxdyag; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff6a98c638so4877270a91.0;
        Fri, 07 Mar 2025 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741404787; x=1742009587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UvgrHzEVnpT8/G3HmHL6s2DUgeJhb4IX0T9xLTixKK0=;
        b=inyxdyaglmnaUGTgkJPVxFICV3m+PZ5TUcKLW+so57VklDWFcAGHURt/yd99lMlolr
         QHcLwDhrW1WFGrfr2XLKkdMmuoUNxagZE7RRSuDB8HxHl8cyRfnuj16DHsZvPv4I14NE
         gkINESDz9Nw7620Za6BJHQju8a9iphambpXA/DujONrEcr+ApeJCVsfMXFt38Pgg1FCW
         9KR90kdYTjpxWG+FthSohTt1aAS49thzXBBBklM+YH7yGyscEKc1yqJAciRVJH+xV/1j
         B81I/sI6GoTX4ddHZnKxiCjHLCEXWQ7ifIuVzzMlyNY4zO6IksSuXXj6KtyrqBJp6sZN
         M3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741404787; x=1742009587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvgrHzEVnpT8/G3HmHL6s2DUgeJhb4IX0T9xLTixKK0=;
        b=L3BnQhzhqKtkwtV0CKfycymbj6GwtO8vzMSFyEtdTeVbbIz5ktiuKvfO28/H/RC0AR
         4RnxKJaJ4/dfO74p8SlVNgaNdfJZQTkzlSxeT5Cyqw9pgTWVNQ//vRg2y4nMHQCOOwWx
         3qlUgoKxAz1VK4duIrzEqyk/1gUe0kr0VFmFTdLb86C6aJhCzYnIhvTER3d8nJcHCbWZ
         5cXeLvQb/1yc5KjDuZQ5r2Z3nkgSxcXZm//z6lmbeSrroGHTZaX195fkZ74UNLqyqKUD
         nWviSFC7Xpy6Q9WwH7wrnu1r9uphzQr31a+RuFkdn5NYg0487bSsQ+Cdrx32zqRrlMsu
         B8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWloRRLDVUp8oMS7e23iU4qxKKbj2H21WZU97zRylf3pEKqByrUFdVsRmLk8ePYIGh54EvQfLq8@vger.kernel.org, AJvYcCWvYIeO3eV6nSJHDqL87d8vKoVZ7aicLiitbNOBydaKdxScTZUGfS6GjvE9PK6rAgEPbnlozUyC2voneOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSExuceZYmh4jy37ul+tT0F1ahy40gwYHbT/dO5Xhj3zRgF4c
	DTPyN5yNtUEJJG6j8u22qAcyyO6PoNv577ugdJCHhGCnnNnhHLk=
X-Gm-Gg: ASbGnct70mqTDqIuyzFRw4CyHdbj5H/mqDxSO29T5V4G0I6xM4sl+Tzv0/+nkyOL5Nv
	yU1jZiZvpMRpRX1M+/Bs/iPOvDCRmf9BoFIz3vVhoXowjCc/Pz8xCP4qAo2GBrvMoZqpA8Dg28f
	GqLLc/FdSRf2w5jyOxGhOAjj1qIR0Sx1MM/6w/O1D/Xa+1EHgwH5vNR5ikE+EN5+vlryWGyLjFS
	yVy4xRryUgdgIDytDA2GE5eFjw9x9rAvHYemsEXjyBTQ0lE3cfcq8X+KqP6A423qEE0xfRQd1vH
	etu3hLC8Q479MS0JGWCP5Mx0Q4DTmB2f28Gc5ooBQtov
X-Google-Smtp-Source: AGHT+IHPRXLJpetfEwSMQ7twdjphQ1M6P53SRY3QIktwMixPny5Lf92aBO0J+9e1YgZJgGzLPwmEoA==
X-Received: by 2002:a17:90b:390c:b0:2f9:cf97:56a6 with SMTP id 98e67ed59e1d1-2ff7ce63ffbmr10417495a91.14.1741404786689;
        Fri, 07 Mar 2025 19:33:06 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109e97d0sm38247115ad.79.2025.03.07.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 19:33:06 -0800 (PST)
Date: Fri, 7 Mar 2025 19:33:05 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, horms@kernel.org,
	donald.hunter@gmail.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch,
	jdamato@fastly.com, xuanzhuo@linux.alibaba.com,
	almasrymina@google.com, asml.silence@gmail.com, dw@davidwei.uk
Subject: Re: [PATCH net-next v1 0/4] net: remove rtnl_lock from the callers
 of queue APIs
Message-ID: <Z8u6cSJGzUGRFjkX@mini-arch>
References: <20250307155725.219009-1-sdf@fomichev.me>
 <20250307192234.2f8be6b9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307192234.2f8be6b9@kernel.org>

On 03/07, Jakub Kicinski wrote:
> On Fri,  7 Mar 2025 07:57:21 -0800 Stanislav Fomichev wrote:
> > All drivers that use queue management APIs already depend on the netdev
> > lock. Ultimately, we want to have most of the paths that work with
> > specific netdev to be rtnl_lock-free (ethtool mostly in particular).
> > Queue API currently has a much smaller API surface, so start with
> > rtnl_lock from it:
> > 
> > - add mutex to each dmabuf binding (to replace rtnl_lock)
> > - protect global net_devmem_dmabuf_bindings with a new (global) lock
> > - move netdev lock management to the callers of netdev_rx_queue_restart
> >   and drop rtnl_lock
> 
> One more note, looks like this silently conflicts with my:
> https://lore.kernel.org/all/20250307183006.2312761-1-kuba@kernel.org/
> 
> You need to add:
> 
> #include <net/netdev_lock.h>
> 
> to net/core/netdev_rx_queue.c, otherwise the series together break 
> the build.

Noted, thanks!

