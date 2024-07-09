Return-Path: <netdev+bounces-110329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4793892BEB3
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 978DDB21E98
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22ED618EFD7;
	Tue,  9 Jul 2024 15:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDZRXTPB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A801DFCF
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720539990; cv=none; b=Xqfwxx1R7wSZjR2mldhuMZYqUVX+HrDQB6sezit1cu6dmQMOkRwFCD8VkGXHPFMX9FA1aH1q1xMOdZOXBoVbLxuTE3j9sMz+E1rapM43C5ytKmqIjWtjHliBtDSAsgGc/r2PhjSGCdjx26OgrQz/wXoLG0KYq9AHAaD/BxJSOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720539990; c=relaxed/simple;
	bh=rTtH0DotHTjA15UtOOf0j20VfzA4feDViWZa1Sv5aws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FKTJiSTcSdd/hBo6d9cOnf27xkiLAUOh/q800VKcKW9ZsBgx/bkKKNuzOIBDdNzkOvDcwaZ6kok4a5n6JeHyC+sHRcIHpekoScDxz6azUq241zWgEvpSQTW+tLkWG3d4eYu1XcByzWc0HUj+9P39s+NDja3DZs35ZKYHNZns7QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDZRXTPB; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7fa51e8608aso109056839f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 08:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720539988; x=1721144788; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lYLmpKynUKXVgOfiDFiyAhAlFpYtz9cJ43ywKd6XTCA=;
        b=LDZRXTPBkE9QZuZU97rHXeVUBMZnG7l0VhbOIYRbUBLRQEMn9HXbgDl/TjQOLdfKub
         OxbmJYiYIYI1kwuqSPtUsGpMvx6Yaf21wl1n+bffySEatnwZ++mlbIL0bmN2O8dTACAk
         tYw72feBctIZhTLaHRrE+FexIFeHvF12VEI8fxDoHfQlR+nUHIKNZxp1t7hHiKn8XdOk
         HMa8463yAHm8sosnsB5Iy0BDXSoEB4PdVEKQCbmkm8RLen05395Jh1MxiteTY/KZMyS1
         ARdJe1xwz1ux4o07LP8c9EfW/beIi8v/IXx8PSLmWm3AWdyQsLLEvcxpHAgPqq1GbkoG
         pQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720539988; x=1721144788;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYLmpKynUKXVgOfiDFiyAhAlFpYtz9cJ43ywKd6XTCA=;
        b=FjD7cfofhGzlTvOQCSh2eM48j2K/fSvt9Z/bzmi+0+g6XodacB3uRzLC6yc9LkJMVZ
         +RpTA8+IKIcV6S+BUHuFi1eIcFPK5Hu+X/cF6IPWfLLuqVQeBxpUZDMBeV5xqKLHjE/S
         pUaZ67ctdBIThFizgTpV5clXhX8MZDeojWmtZOfIzR1EUc2uUulUGRDstNVzevMTdBzQ
         bm4c6WwP46VB5KO0lL7jErnicz0sTU3UXJonQXumhLpEwM3RRVKxaJlmOpvTUmWDmayx
         7IDoxFtNGw0RijWmVkEKssykEgssp080C5JSjzohVP+4RvpBQBROkC8EHVgxP0tVfigv
         Ld1g==
X-Forwarded-Encrypted: i=1; AJvYcCUnxwOrIwEXv+G4u/tCISRIBeOMzr3NelZmxZ8QA/Swb3BBXT+TCI72BB/RYwLNCrgI2H8U9trlfRnsbQj3Qx9Kz7oU3SDx
X-Gm-Message-State: AOJu0YzG3GmM7ZI8+79jkUCaazM4Lqn0/dqG90jhZlf4D+I0pNaEB20c
	YrGJDilJKVadQBPkm+JOcPFWFJpmQfi8QVdDPjT0BYJasM8+nJ8UB60gqZob
X-Google-Smtp-Source: AGHT+IH8HTtOo3mvLuemDtg3d7uWWMe0TvbcIf7HYvUuJ+2RdS1jStIat4otJMJCrHcWp2JtmBpDew==
X-Received: by 2002:a05:6602:6d1a:b0:7f9:c953:c754 with SMTP id ca18e2360f4ac-7fffe62c3d3mr449109839f.3.1720539987729;
        Tue, 09 Jul 2024 08:46:27 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:8da3:78f8:d573:7ac? ([2601:282:1e02:1040:8da3:78f8:d573:7ac])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7ffe8e3861dsm58960339f.4.2024.07.09.08.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 08:46:27 -0700 (PDT)
Message-ID: <5655f8ba-7b4f-44a8-ac4a-a028b50e01c8@gmail.com>
Date: Tue, 9 Jul 2024 09:46:26 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net/ipv6: Fix soft lockups in fib6_select_path under
 high next hop churn
Content-Language: en-US
To: Omid Ehtemam-Haghighi <omid.ehtemamhaghighi@menlosecurity.com>,
 netdev@vger.kernel.org
Cc: adrian.oliver@menlosecurity.com,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>
References: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20240709153728.4139640-1-omid.ehtemamhaghighi@menlosecurity.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ cc Nicolas - author of legacy IPv6 multipath code ]

On 7/9/24 9:37 AM, Omid Ehtemam-Haghighi wrote:
> Soft lockups have been observed on a cluster of Linux-based edge routers
> located in a highly dynamic environment. Using the `bird` service, these
> routers continuously update BGP-advertised routes due to frequently
> changing nexthop destinations, while also managing significant IPv6
> traffic. The lockups occur during the traversal of the multipath
> circular linked-list in the `fib6_select_path` function, particularly
> while iterating through the siblings in the list. The issue typically
> arises when the nodes of the linked list are unexpectedly deleted
> concurrently on a different core—indicated by their 'next' and
> 'previous' elements pointing back to the node itself and their reference
> count dropping to zero. This results in an infinite loop, leading to a
> soft lockup that triggers a system panic via the watchdog timer.
> 

I will review the patch when I get some time (traveling this week), but
bird really should be converted to the new separate nexthop API. It
makes route updates much faster, is already rcu based for updates and
should avoid problems like this on high rates of change.

