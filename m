Return-Path: <netdev+bounces-125893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 492DF96F287
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061F2285070
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 11:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F282C1CB157;
	Fri,  6 Sep 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="COUiHW8E"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5F1C9DD3
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725621309; cv=none; b=B3uKNLOtm/bBq6zdzAQPxd3nQNxVH21OdIUu7CM5cPkUcleV/fdFaQoduRdipTXAE4FPpRx2I0GiVKyD7T6lkgbcXeagKHPGDc+/pSJJOqAxuAKaDHkEqmaxm578B178XJjvJ2gOHOrX8JsFHO9T3MptVz4KIVjUYPoLQDpPCNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725621309; c=relaxed/simple;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sz5GcV5LhGR2IUYmoVxde3Wx4ORf+5V5KZDnbzku8sZPQMZJp8tlKEeudIWytrwXVWZ5Z9IhsryuQK0DjRJWmEqD/4+uSkQ2b+z4CZxiZBw+o5LT5oC2gjMWQ/c7T01LUMSa1Dq14hCyU+uTb8XlxmA1P7pm0gFSsvKp4qeefLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=COUiHW8E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725621307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
	b=COUiHW8EvBM6PoV4HjoARUgXVCG8XhghMBYGkt0r0nkt/WuKC5Q3CTlQyr+RCtHgcbjBgY
	ZtfR4o1fq1mzsM8cOEusxr2Hnb07KxNSGoM/kMZ5zzcNRa8JSwMVvYdMWJKfNyAC/fDtDm
	i0MaVoPHx7tkih33Xod+z8+RYIglaDc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-NBdcr3u0N9ebMFGeCAmxdg-1; Fri, 06 Sep 2024 07:15:06 -0400
X-MC-Unique: NBdcr3u0N9ebMFGeCAmxdg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42bb5950d1aso19288065e9.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 04:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725621305; x=1726226105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NGiB9JCDYS9eHATqhHJptO0ZudgwqWhSFOBgZQcJOI=;
        b=Clgq7AcVMhnaVyx5/xGAP3F/QWuROWLg0nqd6Tisle8yW+gKbRJbqpiEub2Zd3t79M
         HwOgwjxK+FXm32Lf6T6T3OXRiYb/XpEsu1PGTFEMBXzcV2png/ULJWfzuN28qQFI386q
         gFanVGhP97yojRG4tqIfQXRhl2LBceLmER9Rwd97N2jnWFnagXNJ1wYnrfBDcmDVm6AO
         NkfUxXQw2hB82OJ5R48AvYxwgiEldsN8ewciFG9st0kuCzK6WlKgG46SdS6MrdYOn6tx
         P+2vhQssqm2gL6L9QWH+0D5sBEny6ck24aV2hxqA8lJ5r9S2BlvBI0HYgG1aigqjYly9
         iPcA==
X-Gm-Message-State: AOJu0YwHoKPZV2HNKqvt3bM09KUNrK6IuKB2GGBo1UkGf2Av0lpp/J/+
	j9I/jUDc0WJgOPN2uZtsnzziRKt7R5b6jMCJedMhLIsWD65I+64BVcpv+E3t+dZuTVaHU24bGCY
	U2N8KRp9CuLlr8Q7O22O+rkzdthnPsOSnFOvftf2NaxGluqAZeS6/zg==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075945e9.18.1725621304837;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7vCxT8H4VqHEs2N44xCaNM+DluDvFbOAReI6BECcPwvJ8SnS7DtqOd/aYseydN9zLNtq3KA==
X-Received: by 2002:a05:600c:310a:b0:42a:a6aa:4118 with SMTP id 5b1f17b1804b1-42c9f98b4aamr16075695e9.18.1725621304232;
        Fri, 06 Sep 2024 04:15:04 -0700 (PDT)
Received: from debian (2a01cb058d23d6009996916de7ed7c62.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9996:916d:e7ed:7c62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca8cebd35sm660405e9.0.2024.09.06.04.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 04:15:03 -0700 (PDT)
Date: Fri, 6 Sep 2024 13:15:01 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	razor@blackwall.org, pablo@netfilter.org, kadlec@netfilter.org,
	marcelo.leitner@gmail.com, lucien.xin@gmail.com,
	bridge@lists.linux.dev, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-sctp@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next 01/12] netfilter: br_netfilter: Unmask upper
 DSCP bits in br_nf_pre_routing_finish()
Message-ID: <ZtrkNbZcjQrUmdcC@debian>
References: <20240905165140.3105140-1-idosch@nvidia.com>
 <20240905165140.3105140-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905165140.3105140-2-idosch@nvidia.com>

On Thu, Sep 05, 2024 at 07:51:29PM +0300, Ido Schimmel wrote:
> Unmask upper DSCP bits when calling ip_route_output() so that in the
> future it could perform the FIB lookup according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


