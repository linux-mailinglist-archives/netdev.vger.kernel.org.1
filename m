Return-Path: <netdev+bounces-196915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D0AD6DF7
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C503A1212
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014E9230996;
	Thu, 12 Jun 2025 10:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="uUnxH0qt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467A0223DD0
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724544; cv=none; b=E+6toe7Ih20Djvt4geJVndFA5onDdkCVSt2Pq56sp2jfBRMr1RNiYGoovzK/4cat0Q6yv+IXwnhlhcv8/I6eJFVx+6fJbGn7hJJY8zDnkQc5LKZ525SLOTts2a2TfrcltBDoIGv7DVGNjOGLJNGFNWnY813umOkTJADYw7Oj2z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724544; c=relaxed/simple;
	bh=M2NYCHRyDv7s6VGvhKUntggUYcsDBktpMO1yd0hgijU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lf5WvvQVeY8Ew3OFfjdrbwjvQ9SdEa8zr3qThzFFsHDcr5u9h/5a7zTOzHzLlluzad7b4fnbU7yZLMfuapDo5WeQlJAtcGecQE4ufi2pmzEcIZQYa0lKcz2OVcBi0SC5Hn8/uC+SqhGF3Rv0loV2c6rBoymkmo+7ZUTqQWuruP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=uUnxH0qt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5532f9ac219so729544e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724541; x=1750329341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMMQ/MXuLOy0uCltBBeE5DPJT1EK+2CynIP/xWmojvA=;
        b=uUnxH0qt9fwtq0423RyMtP7uo53+Yezyci1eoWcD6rBwiDiEgpH7TgUwXi8JlUGMdp
         Xz8m/ZeU9ysH6wViAwY+2gdpF8+BS8yDufduAQjIMU4uQWDWVW3pvy6i1SRVbJ/Wxqe0
         MOMOx4iDxK5zwOGyYZ21xxMo23xN/8YUUwKvd7odR7IP3JHrUOuptO2LaE7eRVaRXISy
         GXfULirVikeRVFOYcID5HRWHbmQtUAFhR13oP4t46IhE6XNJVp7YQZz0hrDHib3/j79g
         gX1FrQKPYZ45BQXLG+NpaEavGfWut75wt6VH4YCaKbwPzkcq+EZjqXqMY87sqM1wa5Da
         NTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724541; x=1750329341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMMQ/MXuLOy0uCltBBeE5DPJT1EK+2CynIP/xWmojvA=;
        b=PECu0HwvQz9Zj+74PSDi0moOAxqepPaJCF9Ii8qjw+Y5lZwXVeTeLLdbpxqILHrxOv
         Mns4GaZQC2zPonPl0Tbg6v+taghUfo22xHXXR6WS/P0V1TVtMp0ECsucJ5V1ulOZ9sZG
         G+xPjJiQJPiao3ja/BbWfcJMjEN0HN1MjQnjll7y4KBDIt06SRLgWM4MnTrziPzfiZQA
         QWdUW47bUODw1Zjds4KqyyNJsXf0Vzho0G5uLDvlmBXe6ukM4cFR7EF6yrCXebYrnIQ8
         sfPGwRHzzvEPkA0fk0t0a8NDRTg+hJVDnINR210GzxGXBT5nrDpb8oWrMEi3qbAGnoLm
         3WLw==
X-Forwarded-Encrypted: i=1; AJvYcCWXc6R4jFPv79As8UqnHZCibAGZ3E1aqsva69BGTAb1yljkvVjjuG+ITXFVx3VQldq95JWJJmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR0B8E0VXrJlGNOcyVJ9jMP4fQP3QVIO5VazPeReGd26kq81xS
	1YPAKafEoZnkFmMc8e1c/9ADAO0TNHRI3iDqTxLnwl/lZkFWIvwjHlkbRpl7DMRwGZ0=
X-Gm-Gg: ASbGncsSwsWA33JbH1G1R/BmF/odKJ6p9KZG6kuYEAZFUzaiixRtr9KBLQBaLCDpVG4
	0FR2OvArt1OIRtPMs3/bIdYlngTNBHExfWFLe9Up8u2YLpD01vDQqyQXBfey1lltx9aK2nlA6wY
	ZRChnPABb4q8nj0y4ZW9YV7BiNRs0yZaL0+qNKDQg6p+LGnBw/wrjqvaw7wy2OOuCFlg/dOqJvL
	57HExot64Hf0AMOn73N/OfZPiTbsrf4WHB9nl22oYuNpNPMp4KKt2mW2TxU8rTCO6hbzfDGmYAa
	OXgD6cjIEfdfiyByk3TTrFqN+pmDAoRFz9Fr48WiXhrrxkY50FbxIUxVailkGJrc0j2hU9s3f9n
	dZSx2lZma06PCnEAIRAlfjVnbitxXFsY=
X-Google-Smtp-Source: AGHT+IG79wOCjoGZHpoqjNpRhIVlm4NarV3O4QjUmC0Tcm02z/jXwpoqNzORmjOPnJFxOs1GM6ab9w==
X-Received: by 2002:a05:6512:1289:b0:553:2240:4be with SMTP id 2adb3069b0e04-5539c14a35cmr2180635e87.35.1749724541273;
        Thu, 12 Jun 2025 03:35:41 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac11655bsm69627e87.47.2025.06.12.03.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:35:40 -0700 (PDT)
Message-ID: <b730469d-4f2c-4418-b642-8c3523d49cc2@blackwall.org>
Date: Thu, 12 Jun 2025 13:35:39 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/14] net: ipv6: Add ip6_mr_output()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <682328fffd7c73427f4011ab9488a5e90f63b4e1.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <682328fffd7c73427f4011ab9488a5e90f63b4e1.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> Multicast routing is today handled in the input path. Locally generated MC
> packets don't hit the IPMR code today. Thus if a VXLAN remote address is
> multicast, the driver needs to set an OIF during route lookup. Thus MC
> routing configuration needs to be kept in sync with the VXLAN FDB and MDB.
> Ideally, the VXLAN packets would be routed by the MC routing code instead.
> 
> To that end, this patch adds support to route locally generated multicast
> packets. The newly-added routines do largely what ip6_mr_input() and
> ip6_mr_forward() do: make an MR cache lookup to find where to send the
> packets, and use ip6_output() to send each of them. When no cache entry is
> found, the packet is punted to the daemon for resolution.
> 
> Similarly to the IPv4 case in a previous patch, the new logic is contingent
> on a newly-added IP6CB flag being set.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
>   include/linux/ipv6.h    |   1 +
>   include/linux/mroute6.h |   7 +++
>   net/ipv6/ip6mr.c        | 114 ++++++++++++++++++++++++++++++++++++++++
>   net/ipv6/route.c        |   1 +
>   4 files changed, 123 insertions(+)
> 

Looks good to me,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


