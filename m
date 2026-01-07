Return-Path: <netdev+bounces-247905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C84FD00671
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 00:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 677A030010E5
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 23:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEF42E62B7;
	Wed,  7 Jan 2026 23:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEs1gcYg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD3E27510B
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767828897; cv=none; b=n5HWJaJlJSMaH3oJnKvSFIf3nJUP8Oz/AP4fCcymU7bLBjc36dZgxKCXln+A4EQvshyEI8sktl2g4I3qhLx/31LBR5FM1LHlB8ae/Pr9jzKiK/tD33uW3JU8s+FZ4xx2xfo5kSISE6oHSbb39udrhkmvi8EoO2nYdEDSkFewRaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767828897; c=relaxed/simple;
	bh=k1JkNfqCjqgS2Fn8Wt+NpeAyAgoKoh52zawLfS7KSjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGdjSU4aI3M29BeLVqq2aF2xcp663+P9QDq4j01N6ykgcc0uDqovnxyvWg3xJ05EIX8BD12vJV8rcgUG5ssi3725R/01O+mc9eyfWlcTZF46qFCyq+oFkF1dPTviqxA8bW1m21AKv3cNC7frPuRFefVH9B+LzqYF2leLVEtoFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEs1gcYg; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2ae2eb49b4bso3602612eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 15:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767828895; x=1768433695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SNGAQ5az2meuAaZ6eZnSG35VJ+0tQCyfAb8wlRB7Mo=;
        b=JEs1gcYg7NWTkdLvuqrN2nAmqVnQdSLzrr6zICg7wNQBUZjWwv16LhRBs1uUEjmHMj
         No+J8T2hy9KVX0lYqxfxBiuP9Oybicin+YcKd2cYNZnjO+j8kZG+0kEO1eyWEmsRunk3
         EnkC2UVYTEQyIIX8VDv/dyUU7OAFf/TGfWXogwEubQ0JliTxX7gS3pUmnrkt7nXeVCoQ
         r6qlpl6yE+tK+yNCCe9HwJbcQd5sr7bU/SwNSqIkeTU0rRhSbN9sgzQI0mZHuNXyiqMS
         3fZ+CqghjF2Pj/BoqEPIrgX+jU6dHGnrzGLAsNS9xnNd0c070hzk/JgSK0JvRRh/OMXh
         NDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767828895; x=1768433695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7SNGAQ5az2meuAaZ6eZnSG35VJ+0tQCyfAb8wlRB7Mo=;
        b=MuK77n6S4LuNY6qwsRjjoMGyZ07CNn5gVe72aIcAjWE/RoIQ2bO92NABflPAmHr3aa
         6nMMa3zP6gsma2vTb4+foN73TjEECtsgCLMaLxAqO2jNa25v5AgSA8S+xpAxRagE3+5w
         hVRc7qx5WQAlJrv0VBTpqf8mPCePzktB956T0V8aDya07MWdu40a7poNrBeZ19F2tAUL
         zV+ln3pQGg0J0zBGoAe5R0F2RdoohZDd/LideRNpNNO0lQaRHdfoj1eZCzww64ZLcI9/
         FwDhJ32Abek6jQjGdJttL0LevlQ2e5fxggOji6qhHStGIyf7P0q45NmVphnzbpxiV2V3
         sZWA==
X-Gm-Message-State: AOJu0Yz5C9AxrKfF89/E/7ejn1Snbp67B5o++OJ2Y2/FBjjxOy7ruIex
	Ld9/u6HBnRdXPXD0v5VAz7oItMcbiNrDjz0F38W5NKNZP6jilLgx6Ln8
X-Gm-Gg: AY/fxX6GqWbeFgPYfYFmh47nReFJ1hEtGFNNRZm9rYKCxFwPjC92zs6vrGWCjhNkpYL
	UURQW2iTrhV6/clHw9mZN1Tnj3dSkG6t9rLp9yEBcdcIdyl8PHrHxsJ7f81u0qSgopEux0fwp7G
	B+KbqWvqcjff+N4+XTMfTzDXUD7NAnkDdFY6eYieRFsmXovX4vUmEz08wMzPXP+DACifXYIbcXh
	ej+JjUwRh2eVGNvepCEHb6gJEBS8mgF5hOri/O/8VhHDE7c5jcoSvKf6ALpPACxonL9Fd+U+Jhs
	qXPupnBsVz3cyh/Cx42nHEGYnYzFrVU6mMuMH6Zrl4zkXUAYvgizm0M8GVex/zUQACU8SIFhGW0
	LXDqeafi+tNt/mgqgJkzBln/I/yqcjJjJzRzm12N92R3SiblHi8/Uid6mB65BN9n0mdr15He9pK
	CshHmOjCTWyRVMc5BxBg==
X-Google-Smtp-Source: AGHT+IGOwUj/ix8wxHbIE5Cjwl7joCnx2c1xyNjX0U2anaWdQL94eqRLKbyLxi5JJsQhYqk1tWOSQg==
X-Received: by 2002:a05:693c:40db:b0:2af:cd0a:ef8c with SMTP id 5a478bee46e88-2b17d2c0ed4mr3786836eec.36.1767828894982;
        Wed, 07 Jan 2026 15:34:54 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:36c8:e8eb:df03:2fdc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53fbsm7723432eec.12.2026.01.07.15.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 15:34:54 -0800 (PST)
Date: Wed, 7 Jan 2026 15:34:53 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [Patch net v6 6/8] selftests/tc-testing: Add a test case for
 piro with netem duplicate
Message-ID: <aV7tnSRylK3MMB6X@pop-os.localdomain>
References: <20251227194135.1111972-1-xiyou.wangcong@gmail.com>
 <20251227194135.1111972-7-xiyou.wangcong@gmail.com>
 <20260104111539.61f97ad0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104111539.61f97ad0@kernel.org>

On Sun, Jan 04, 2026 at 11:15:39AM -0800, Jakub Kicinski wrote:
> On Sat, 27 Dec 2025 11:41:33 -0800 Cong Wang wrote:
> > Subject: [Patch net v6 6/8] selftests/tc-testing: Add a test case for piro with netem duplicate
> 
> nit: piro -> prio

Good catch, I typed too fast. I will correct it in the next version.

Regards,
Cong

