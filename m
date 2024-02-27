Return-Path: <netdev+bounces-75313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5845486918A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 14:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59471F29B3C
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B60F13AA51;
	Tue, 27 Feb 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="CRuqj2YQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07AE13AA4C
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 13:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039810; cv=none; b=TH/s8Yqc5IaVrm3vuCfRJag+yVNymO2Eb01Ya1KXn3RUTJ308pgdb/SXTkv8Q56Y8FW0ze2nukmN7yM3vUsYXbLxEljLSnBdqGrL0lkim4o8ny9yeqoAEHaxCu6Sy9yoiYHc16IFla5j4Ov0BBSzJG2JJw8F+XbAmjMeaVS16Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039810; c=relaxed/simple;
	bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4G+V6rlM+OGunz0y5iyGP1xvTSbX6ERloMg491vLkTJ/QBXwpT9RcCqf3vLzbNplmVuPppwIjpVSrh0//cPgW00J6HTNOl1hX16Ly5WGSSEKQ5rXRx2bl7GcrcBHgniickVHXx+Uo5rcFYXDVuoVIl7zzLLDjB5KQVKo/7f5Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=CRuqj2YQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-412af1c91f3so2953525e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 05:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709039806; x=1709644606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
        b=CRuqj2YQDJXhNKaN4/TBDm5z7TYHG/2LyhKD1p22DXDkSfOJxXWQOM5Pc4aQ3t9UM5
         lCFbISJ3E+O0iYfsCn2YAfI2N5Rep9/eYirtzByeSMSgzNqv/WKHJAV685ojF0WEPHrc
         svF5zpLS6fNI9JWof77SRPUYqT7JNwV8Air5/tEE1jr+mzvuP53r6diTR0qTIM1IQcrN
         y9L9B+o8eAn4PemduqvE+Rmq0y1cW6ZTFokutmfsVlkKK52oTb5aZkVu3ein4svywoTn
         MiCbTDSARZuRAOYz0u4jca7TST0dL0rppjgbsARWHDmPvnUOysHBW4fshSll7Q9AJDbF
         r7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039806; x=1709644606;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLSnm5sDDAgj4iXUanzlaO3dk9veURq4FvyOwrFUb90=;
        b=OfO0JehjJae4k1vszh+kL/S/gCQNX8qj1efihIB58fmjgxnD1y5dbKspaoHki4QuYZ
         6tDu4xAifj9qzS3glSr9AGLcxzTY26YJHtSqDmCU3jjuwd/N9d8HeQ3BEeK76k6xd2+8
         EJn1frefcMcIJtA4pEulqb9KxbZIbWXXP/bljsPuNQPjMFpIfC4exsMG6NBuvN8eIDtP
         6oxkuOW69QlzIxrRD3IXL78RS+qzwSSTkp2nOTK0rDw2RNrAzdSMoaupWsMKkZaFxNR5
         ar3kEiUWue9F6+J39y9TassZgQ7NQIwEuN0ZQSUVt/0QEbIBqWySnclcjxHKsfYr8hOS
         A9nw==
X-Gm-Message-State: AOJu0YwXVKHQAL4kVx8HUIeansyNdQ4K7qAOPBap3ZhrZw6AatEYRyUd
	R16s6nvCp7+E+Bm44dJZQNrWkWNnY01ZaSMfeymjGOZ95TXlPiSaCLEkN81Kr2w=
X-Google-Smtp-Source: AGHT+IHVwzejnC0mU8vDYAfBnv4dzKsSVW/MjvgOtEqga8tB19xw0rosYNSCyp9knEStmh94Em0BaA==
X-Received: by 2002:a05:6000:52:b0:33d:815a:47c with SMTP id k18-20020a056000005200b0033d815a047cmr6493085wrx.24.1709039805964;
        Tue, 27 Feb 2024 05:16:45 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id g16-20020adffc90000000b0033d3b8820f8sm11308242wrr.109.2024.02.27.05.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:16:45 -0800 (PST)
Date: Tue, 27 Feb 2024 14:16:42 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/6] virtio_net: introduce device stats
 feature and structures
Message-ID: <Zd3gutgi_22F79jR@nanopsycho>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-2-xuanzhuo@linux.alibaba.com>

Tue, Feb 27, 2024 at 09:02:58AM CET, xuanzhuo@linux.alibaba.com wrote:
>The virtio-net device stats spec:
>
>https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
>
>This commit introduces the relative feature and structures.

Don't talk about "this commit" in the patch description. Tell the
codebase what to do:
https://www.kernel.org/doc/html/v6.6/process/submitting-patches.html#describe-your-changes


