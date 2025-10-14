Return-Path: <netdev+bounces-229065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4148BD7E06
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C0CCE4ECC52
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0530DED7;
	Tue, 14 Oct 2025 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RMo/1SDz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67630DECB
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 07:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426815; cv=none; b=NpQfhL9gjxVHfgCiJO8bR86F/g4uzBTJgmMKZvZYTYMgbShoirZ1SsdBe5dTKfJ39VonVq3GyGIeGcDCcWwBzcnfEWB+cOC+tDdjmfMsbjPQvyYsHVlh0SO+e9JkY0I6NiIKhDp7hVSR2bhIzzFiedkFkP2vwVOoss7gA0p5RCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426815; c=relaxed/simple;
	bh=69j+nJDGYxV0SqldgYPw5p2967aw/hJq9L3JovCxY0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZlf3ODziSLRuxN2hGT56N/COiOZjKMr1kajj+5m8JvsP72ZGkNU0hxZKLA+jhwZVL5wJuB5V2K+beTPDuV+DItBvvrGrhbt66y+5XxglV3EuRW4LSnDCpJQxNc1/RYQvVRe0Ug4KcrzxLjoIkv6S+QSIti6/acx9uIlYm2b1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RMo/1SDz; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee15505cdeso4166032f8f.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760426810; x=1761031610; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1p4OZlxOY+NxPP/FLfk1SUzbR8cdY55J35+/tdhphko=;
        b=RMo/1SDzLvQCfVz1ubtkj+ohMe7hxvHOkxQK6nAyb6COgPjkD+YNqx9dM03dUwjTkU
         yx28ueUbmimBbnQvk8WrrQlIOA5Xqyyf2+A864An/mwCHN5ZLcSpw5BEbQQi9Czyd5gf
         1Tk3vzIdIswd+R4zM+EWeQnGpw92IXFZs0qgyWF6ypEAJYTTAB8zdOGffBYFEPgKhmvV
         LTlcAM7Mc1IHjS6uwMUd64V6H06feAgvT6mmqdoU9paF++Ue3FGdgZdTPayi9dR7GHrk
         7YJlVSxmDx+MQT7N8UA1ArcoSCqtljlRoEr9WURCfpvb1d0LSmoXdryjqeyNjhrE4nUx
         sxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426810; x=1761031610;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p4OZlxOY+NxPP/FLfk1SUzbR8cdY55J35+/tdhphko=;
        b=YLKQElCwHNw2kzcDNOpMjCHMKd4EWXLPMOCcKGqkAIZS6o8KeIi3CJ8ZShncnRiKcD
         zOTyRK6/WsGEBoT1TPYJAWdXfHJrL8vkD0mldWs/Rytv1sHuqFELybnXzj0g4V8EK+Bh
         7N9wJ27KqoVeI8PIkg8WX+bZo6OzFdGYRMxORJqYzKfJ6XtQO1LbT5eYGcncTvqVcGez
         hP8M6LbZWmKiDi6HUQGJd6sdlWlxsCq3x+4ta1FEvbPkb9ts1oHuqxZoAYTijUBLRVcD
         vKOgqQtQYmqtmqhZ7Ifl859FRjRsgtsQS0foPXEbI2DN6b0KdAYfruvGCuJJeH6yKARR
         Rh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpQUljgEGI9ibw5XF6FW2ZoH/PpZe3wse362PMFLA9GVPKjbQ7YyJDTHrpyYqt/+oR68qPwkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBtwjvbIslSzIjaWr0OIMMWeSmqLzE51iSiDHfPCgPa5qgJCc7
	c+WHEjOOQn2/rxxT5etlINKqTSwjnTTjuWfU4ttPmLx2D9R4wGq8nqIGhRZNKM+YW3o=
X-Gm-Gg: ASbGncsxfHFrxR57khBdJhgEOsPagmrqqXDS1tc64R1Jngc2o73DPwkx/gOqfoaXm6m
	JNgI4CHvtGclX/lY2lBkPGfNuncftOeqAg9Y3WTE0ABUfgsgX2IxQkTBLdVkcGxgxM1Qx+PjzrG
	TJdZTgulsm2uLmAomnwC0r/2SlUhjh60DNO7o49cflwgElvzgUFq0wditLmTdBE2XBTXDK8RfYh
	IZo++DCzAG6VvVmFx73Ja/nTYT2dSE+e/b75TIlujl1+PAwBzPM2Knowc565p52W/bixKpR9oJg
	IFqLkrm2a1KuUE6C2LvbNBkAdL2AtwMaMTh7oFQRINLjmYMR/OilR5ml/4suQadiDvPPjPGq/xU
	BB943ODsjacKMHPQgOkBcCpybGP2j/6gJQOWxS6RSRr0yBpWTkUumBGvtxJbeS7TI/AIlWt0a7A
	==
X-Google-Smtp-Source: AGHT+IG56u1B06cKrDgh7gziHnjqzu34szt4cpp5w6eBKrKwAL5+ACYASwYe1mymtdVAayUoB54vVg==
X-Received: by 2002:a05:6000:288f:b0:425:58d0:483a with SMTP id ffacd0b85a97d-425829a5a12mr19773929f8f.3.1760426810474;
        Tue, 14 Oct 2025 00:26:50 -0700 (PDT)
Received: from localhost (109-81-16-57.rct.o2.cz. [109.81.16.57])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb55ac08dsm217399135e9.13.2025.10.14.00.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:26:50 -0700 (PDT)
Date: Tue, 14 Oct 2025 09:26:49 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Barry Song <21cnbao@gmail.com>, netdev@vger.kernel.org,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Huacai Zhou <zhouhuacai@oppo.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network
 buffer allocation
Message-ID: <aO37Od0VxOGmWCjm@tiehlicka>
References: <20251013101636.69220-1-21cnbao@gmail.com>
 <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <927bcdf7-1283-4ddd-bd5e-d2e399b26f7d@suse.cz>

On Mon 13-10-25 20:30:13, Vlastimil Babka wrote:
> On 10/13/25 12:16, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
[...]
> I wonder if we should either:
> 
> 1) sacrifice a new __GFP flag specifically for "!allow_spin" case to
> determine it precisely.

As said in other reply I do not think this is a good fit for this
specific case as it is all or nothing approach. Soon enough we discover
that "no effort to reclaim/compact" hurts other usecases. So I do not
think we need a dedicated flag for this specific case. We need a way to
tell kswapd/kcompactd how much to try instead.
-- 
Michal Hocko
SUSE Labs

