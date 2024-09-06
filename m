Return-Path: <netdev+bounces-125950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F7696F620
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1226E28296D
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E808B1CF290;
	Fri,  6 Sep 2024 14:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MMv/IHBp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833F156F5F
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725631299; cv=none; b=uGV+2AUC60Mr48/GsRueQfRvsLXzpf+phl28chipsksgrfT/uZ7gLq6WK9J6c7RBQ/PjiGxY6y6/9+yao6VFQ/EYRgGBPQx2tarXXjr8bgHBcFQ0xJaN4173dRG9wZAoPdM7xANEtA2DB4ufGadnRxQrSx57DvGQiEXhv7vomw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725631299; c=relaxed/simple;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/7TkB+3fUb6fHiyjE+eeHNyFivlbcP8QlbSbmtyfs7VmIytuop1xXOebE0/cnqumg4KJPFCvdKxcbTeZdeO8wDSu6PHbtIgywBo0XJVHSJm3CwK27crKNIKBBBu70aJrXqKHvHJTnE9smMuXaL3gTaROY6ArCF5HzDsMH6v6gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MMv/IHBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725631297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
	b=MMv/IHBp0+sgtSayIpCeaSYj22+gNT2RidcllNXg9f80LxaJaOhCwHomwR8AxHvhEK2//O
	ebD89rpgS/D8FlbGoEEuO1QQb3RNRqwRuU9zqoySOD10WT1v9TH06K1tYhl8yfc3ORVw7Y
	ShVBdtlPVJdEyjUzMJzFCrTZa5z2CoU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-GYLijxQNPZ2dUGhCtCsekA-1; Fri, 06 Sep 2024 10:01:36 -0400
X-MC-Unique: GYLijxQNPZ2dUGhCtCsekA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53437950a52so2055036e87.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 07:01:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725631294; x=1726236094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9Qvvrts7066PRTQiTdtz7Ndcp7RKGYi8p8LT9X2boA=;
        b=lvjAJTWDcSmUoeaG1hlZsUnF60ovs50GsfrtBYKnAgAc01Zl95tqNFwaDWMz1lekLJ
         WFnbfWQPFdAKnt6drZUk7HW3C7CA33jk68llpYEThe8cW4Zbe2coZuKdQDzek2LhCOQw
         j22uD3y1v2i7lL3jQQEuOuiBEEBeOx3v8XtXI4itgjUgp1D/gakpvxtQlyMhw2BVP1ts
         wP2O/xmYrQLHfk/d96ULxlhlPmw391efY8+kXH97V+z5VjsVWixk2jMGkV/uCYYQp+uY
         /pSa0Kkh+/FR5qAmCPPXvP8nLN47NNx1BPyPhGI9ztMKGbsgo+2cIEU22ylowqnBb2QA
         knUw==
X-Gm-Message-State: AOJu0Yx0ayJD+a7WhApD6fggQ0Mxz2Ncx79dgVUQrCc5oiY6pCb4Rbsm
	Sq5+hegBtmPCAnV8qD+vjf4VqKvbKVRCqoydr9OphRp7unIrGfdHqk7pOI2EG8kmZd4Yu5P2tt3
	WmAH65U6KslQVjrUzqTDfWsvn5GYL94az6R/hRIZtGoFFHVXi6cArWg==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730154e87.50.1725631294279;
        Fri, 06 Sep 2024 07:01:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESh5ryxYIDRtv0PMqngwp2r/5lvvEI+2l0OS3wHQLQGUs23BzE3eAyNjglC8gFpKq8yS+EfQ==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr1730009e87.50.1725631291471;
        Fri, 06 Sep 2024 07:01:31 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ccc27sm21647655e9.13.2024.09.06.07.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:01:30 -0700 (PDT)
Date: Fri, 6 Sep 2024 16:01:28 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 06/12] ipv4: ip_tunnel: Unmask upper DSCP bits
 in ip_md_tunnel_xmit()
Message-ID: <ZtsLOBY/jZi7rrvT@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-7-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-7-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:34PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when initializing an IPv4 flow key via
> ip_tunnel_init_flow() before passing it to ip_route_output_key() so that
> in the future we could perform the FIB lookup according to the full DSCP
> value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


