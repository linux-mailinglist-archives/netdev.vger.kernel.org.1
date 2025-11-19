Return-Path: <netdev+bounces-239866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E3CC6D4C6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 09:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 11B333A2B44
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E30533291F;
	Wed, 19 Nov 2025 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcKA2ACW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6Uz85P8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206623321D2
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538826; cv=none; b=jK1NLMhP5JUUBj7qn/q9FPh1gMjkG6hKvHf6SBuYlLNdUN1ss4jcFszKn2SITYhfa+18hwZ3oLfW/QjiQkhDC6QDevpUlFKH/jqrgfsaNIvxQOj5uHEVtidFF9YZXxgWXlRRcGqloneDaUPqYuO+qsjaAzbycnKlFtxdDnlU3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538826; c=relaxed/simple;
	bh=FjYWz+kqKXceeDdZL6A5QBOjG9PhOHQiTLvMhRcd9fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhrRVRX8Z33PrN879DikRzq4ojifzUK0zGSwraqvqOeoE+5S3MT8JsqQ2caDbj1kt+8FAWMb3U8ZgHmNXFH0kojz2KN+qNfx92hyt4NYK63wjv9w7Dcs8EzuId+mtxUOYqVKfQ6jhubcdxRhAV6ECs+sqaUk/S6aXzn7TjCcKMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcKA2ACW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6Uz85P8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763538823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vucbh5rS/iiazlez28RYwrKcwogXle3E0ZGtqJKXZmQ=;
	b=gcKA2ACW8C0seUkkSTB+vIbfMCblFkkTq4eQSYlU40nGlNcfbIIQDKHY7/QLXYPTyAkTaw
	o8PPQ7XgR06vmnVtoX9HQwA13lJu4iOAu+2Ec442SKZXsgZPrK3VVG/M5ZsYwbFYVWljsA
	7O5mHMZ0IfhG2hcNkwYZ07BbubzUv94=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-ylZVxUbdPwCq0UrP1oAQSw-1; Wed, 19 Nov 2025 02:53:41 -0500
X-MC-Unique: ylZVxUbdPwCq0UrP1oAQSw-1
X-Mimecast-MFC-AGG-ID: ylZVxUbdPwCq0UrP1oAQSw_1763538821
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477632ef599so2470325e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 23:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763538820; x=1764143620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vucbh5rS/iiazlez28RYwrKcwogXle3E0ZGtqJKXZmQ=;
        b=X6Uz85P88A4jlXxaR8nmE4rB/eNcUChW1EjpVTd5q4pamdOVI9n8WJdZxge0RY/iyE
         G2PCajkVD4+pW2H1+SZgXX7QZIqK/FcOUbknKmz4sPTVBrYK1Y62oGWlS0GqBzpwGX9u
         3A6fT0lyhtLDmG8YFllLXL2RM3PaQZ7xzhHq+PFYtp2QNNj3ncbyg97Kp7ykm3NdENbe
         HsSYVUa5P8O2le+tljdD1BGRvU0gzxw/53kCu7JebTf/xeoPRdFaCYPVSJSFoHXhrls6
         zBDC/7KRLcLN/cwk2lMQ8GYnVN5RyDQCWHvoChH08nSe+5PNJFMUY5fzpFNOjRa+wC/7
         ww0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538820; x=1764143620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vucbh5rS/iiazlez28RYwrKcwogXle3E0ZGtqJKXZmQ=;
        b=Bwrmg52ARa5YJZPmqk1Pg2DIq0MabjmJKNCdPF4GRawzgGEsA89Qk/NG8aWR41i4Tn
         lKOjyKwLY6lQ8J+igy0A/Ph9AI+t9cmbc+mO6uNxoAu4I4OULV9NtiV45qMeBKJVyrZo
         k6jQPN+N32ma38J5K8Vyf494G7K30ZCgns3gQoMgnsDHVQA5p77kZ1LK/f/NVROJVzQ5
         pchXfMuEo99JheczWq/DmLElFfbjXWHwG9CNGAPxYR6rmxFQkLIp/SakDzR4fAxmeSjp
         bxKh8WX11HRQTObZq7/4ajzIEJWUaITrpzsPJKB2XEQwuu2UPlvsoGpCIourmgeslx5/
         9UJg==
X-Gm-Message-State: AOJu0Yxznde4KUFtVLaNCCiXybOhPwtM/mf/DXv+jySZCXctANNXpyDE
	rVTXJG2JgmHHhhbWj5aTJjEbPa9eH29XAEvYcfrZ5rPLcRY+WeMEZJ18M2LhK67d8b4j2NBqr7S
	3qXywVrUmJ+Zc7qzFwrer3CnCCSTkaqsZeeI0jhJYUneIMeki0jhiA3TKBw==
X-Gm-Gg: ASbGncvSt/GLoFQypWX0CEnOowrKxAYCY2WAFuU/u13EtoVr4M/XZXAIwd/y+FfE6Bp
	n29BVXfTlNKcLwMZjpsqAiFGugs6G+87dYPJz8+hwJ14XQzalocdvDJSM18LVrlI+w9ot6OBS7c
	oK0B/bI5YvpuEvZJW3y90lrEJpyt84lOMgx9ey21nPy63vBeuquMowpTdAMxSq6s9mPATJbmPmm
	S1IF/wiiH98Orq/U7wOJN9hRL88P3hFsCCREzEPPMep9hnScD9z/cG1Y+ZsThApSvUN8Ogb2cqT
	WklRza2W4jXNf0UuVG7kxy7I74Bv+C7W4foXsiGDEhhQdyNOiZpuY/zo0L2ZzYKAC5fm1p2PdHo
	VoF4n7LsBClZHgKVJmslwpxuOaLx4vw==
X-Received: by 2002:a05:600c:840f:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477b18b3858mr13385025e9.3.1763538820478;
        Tue, 18 Nov 2025 23:53:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6WJ8GNo5TuaYkMGmc4zQd9ybPu8J8JY7frBr6ZZhJdaxc0puxXCryzwZ9nWzJqD3dgyJT/Q==
X-Received: by 2002:a05:600c:840f:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-477b18b3858mr13384625e9.3.1763538819988;
        Tue, 18 Nov 2025 23:53:39 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1037d32sm31884905e9.12.2025.11.18.23.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:53:39 -0800 (PST)
Date: Wed, 19 Nov 2025 02:53:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v11 05/12] virtio_net: Query and set flow filter
 caps
Message-ID: <20251119024647-mutt-send-email-mst@kernel.org>
References: <20251118143903.958844-1-danielj@nvidia.com>
 <20251118143903.958844-6-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118143903.958844-6-danielj@nvidia.com>

On Tue, Nov 18, 2025 at 08:38:55AM -0600, Daniel Jurgens wrote:
> +/**
> + * struct virtio_net_ff_cap_data - Flow filter resource capability limits
> + * @groups_limit: maximum number of flow filter groups supported by the device
> + * @classifiers_limit: maximum number of classifiers supported by the device
> + * @rules_limit: maximum number of rules supported device-wide across all groups
> + * @rules_per_group_limit: maximum number of rules allowed in a single group
> + * @last_rule_priority: priority value associated with the lowest-priority rule
> + * @selectors_per_classifier_limit: maximum selectors allowed in one classifier
> + *
> + * The limits are reported by the device and describe resource capacities for
> + * flow filters.

This sentence adds nothing of substance.
Pls don't add fluff like this in comments.

> Multi-byte fields are little-endian.


You do not really need to say "Multi-byte fields are little-endian."
do you? It says __le explicitly. Same applies to all structures.

> + */
> +struct virtio_net_ff_cap_data {
> +	__le32 groups_limit;
> +	__le32 classifiers_limit;
> +	__le32 rules_limit;
> +	__le32 rules_per_group_limit;
> +	__u8 last_rule_priority;
> +	__u8 selectors_per_classifier_limit;
> +};

so the compiler adds 2 bytes of padding here. The bug is
in the spec.

I think this happens to work for people because controllers
either also added 2 bytes of padding here at the end,
or they report a shorter structure and
the spec says commands can be truncated.
So I think we can just add 2 bytes of padding at the end
and it will be harmless.

It is a spec extension, but a minor one.


-- 
MST


