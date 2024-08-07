Return-Path: <netdev+bounces-116452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C8894A715
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 13:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 439A9B23C4A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828E31E4852;
	Wed,  7 Aug 2024 11:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOIKXaSj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB8B1E2129
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 11:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723030766; cv=none; b=byrX68ZuWS2VWuOBtLGkHCWMPoBSmr9CI2ju6nhBYlGSQaBBL5FR6HaapcaiYl6jaaeuKyg8juQKxgawfkfcDany8Iwu0ra1h7djxb7Rbm+ILUr8i1gO5izsFIYKiis6B4OI+O5WMtx3kePzpFuzGlflFT97VrtsyxH8HRQEcGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723030766; c=relaxed/simple;
	bh=Dhr3h+oklaBA8hjgno/SaZcjPJ8+9JMssBSDUQ2p878=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biitQVwChv6IBeTjaKNKg4WpM2fsZYo8KlcjTPw3LgV+CBoNQBX8iR+aIwySMGu4aX5++RgqVuh71upggG726IUSS9HuDrpZksm7LdsLKNZz2HKgf8KU3XN+HHyjwaShtvH3Y5S+spaefes4ErNQTHUFOeBVWe2AVKK8wL3kBxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aOIKXaSj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723030763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5S7xIbSbjmLQrN3ZIyMbc2A3F+RtNTgafiZdzQ8yuo8=;
	b=aOIKXaSjlcziW5PRoTka/N8yONg2zP6YmJXlaXCcrBlchdcZTA4rff+/Wvg2uB4ULYl7m6
	u8B6Vj2VeA0gLjfDI2Rvv6Mi9KR5grEExF/icTWzEALFFBDnco2oDl9MtobWtp2Eb8OAzE
	+aP3CtetprqjLmGwaTMXn+n4ihGCYpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-BmCy-AVcOym2geCtPLZ18A-1; Wed, 07 Aug 2024 07:39:17 -0400
X-MC-Unique: BmCy-AVcOym2geCtPLZ18A-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a39ecebso4001205e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 04:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723030756; x=1723635556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5S7xIbSbjmLQrN3ZIyMbc2A3F+RtNTgafiZdzQ8yuo8=;
        b=wkcLmNsMKnBUEPGq41MAcx5zbqIu/aML639OIGkNy8+hEAk8KHifi76g/gLuUCkk1d
         FsuOssYDOk+xjNRJtC9zd3q6SOMA2yQd5aws2Lqniv5FlOEa87GYjT6MD/DUvmsh5wDe
         20DCWD9xqRBrkArp/obLXeLLRA55WGVueDhp6rr/QK3TPQMF6JF+ENEUGTwGktqzFQ2n
         2cip6KnWTqhWHydsBJ/cYEXTcmu75zvCYYokokSI/TCcFHff1me1FZ8qSx5BO5eQwjs3
         WiIj+sOJl0xaemE9vesT7Cgu5ngffyS0fdWq+fdbAF5efM3u9XNuy+ddCYJ3ednFptqB
         SWQA==
X-Forwarded-Encrypted: i=1; AJvYcCWucTNjI6hy81tHzMVTqkElrZvgr6qMyB9XMJtzLcftOumS7R+bvFuoBaiBxCsSNN6b8nItieZRS3sgk17hojOeyCUG89Z3
X-Gm-Message-State: AOJu0Yy44mmz1jxNS6QoUlDi014Tm6VK5bcv1aDlgWGIcg2GMJjTHuWZ
	6GG8Ed8wKzQFcRjJBZOZjlDO/vXrG2/UgjBZEvN2nIXJ0DFRDG6kXf69jRORbiynVdOOHU5avd6
	BFzNJ7aGjPL30gMI3dW4QYRsGlSUV4LxU6eNbu0s1gn8qlYFaBjzsmA==
X-Received: by 2002:a05:600c:3b0a:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-429050c89d6mr14574525e9.7.1723030756438;
        Wed, 07 Aug 2024 04:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFklACx+3IMygHGRA0VycboRHfK6J5n7H+H6JoVNd5OcTlO8tJgAb5+09LYCAuJsMNV8sTyJg==
X-Received: by 2002:a05:600c:3b0a:b0:428:e820:37dc with SMTP id 5b1f17b1804b1-429050c89d6mr14574125e9.7.1723030755505;
        Wed, 07 Aug 2024 04:39:15 -0700 (PDT)
Received: from debian ([92.62.32.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cbfaesm23154735e9.42.2024.08.07.04.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 04:39:15 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:39:12 +0200
From: Guillaume Nault <gnault@redhat.com>
To: hhorace <hhoracehsu@gmail.com>
Cc: johannes@sipsolutions.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvalo@kernel.org, horms@kernel.org, idosch@nvidia.com
Subject: Re: [PATCH wireless-next v2] wifi: cfg80211: fix bug of mapping AF3x
 to incorrect User Priority
Message-ID: <ZrNc4FHH8I3VD0io@debian>
References: <20240805071743.2112-1-hhoracehsu@gmail.com>
 <20240807082205.1369-1-hhoracehsu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807082205.1369-1-hhoracehsu@gmail.com>

On Wed, Aug 07, 2024 at 04:22:05PM +0800, hhorace wrote:
> According to RFC8325 4.3, Multimedia Streaming: AF31(011010, 26),
> AF32(011100, 28), AF33(011110, 30) maps to User Priority = 4
> and AC_VI (Video).
> 
> However, the original code remain the default three Most Significant
> Bits (MSBs) of the DSCP, which makes AF3x map to User Priority = 3
> and AC_BE (Best Effort).
> 

Reviewed-by: Guillaume Nault <gnault@redhat.com>


