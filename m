Return-Path: <netdev+bounces-215768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B148AB30354
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 22:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0AB27B4726
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 20:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2402E8B6C;
	Thu, 21 Aug 2025 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0wEDh5W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAFC5680;
	Thu, 21 Aug 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755806729; cv=none; b=MB7b41k5mMGHqlOCjpNRUD4i3LqTfXijiACKCAxzgErWKYbCTbue/SnL2Z6o9lvZqc78mEWzBewHOpOG4wW33GwP7OlwN7nG3jKDiFLl7UaQJarQzF31YyzVyJPh/xUXkqShfiwI1Ag6FZqaGqygf+rZDXJVCzQ6mHypdGiD7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755806729; c=relaxed/simple;
	bh=HkM+ZlwQkXEfHv26NSiueZMKWBNsD/qFrP9LiagTa1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rhkv1W6Ek9YQxfiXVJ+4rwKZM1OzY1gA42HPbVNSIM3UlV5fChNtEjvnE1QUkpCGbij2aQ6D01KgNQ85HQ2CaNSzy34MQByiuzuuHEzbmhwT0QXP2hngdm4KKx8tOyrGuwpWUSvSLNsLpBM20tVvJma379XaAv/HmZgk91dX8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0wEDh5W; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3c51f015a1cso543555f8f.1;
        Thu, 21 Aug 2025 13:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755806726; x=1756411526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HkM+ZlwQkXEfHv26NSiueZMKWBNsD/qFrP9LiagTa1A=;
        b=D0wEDh5WocrVJ+GZw9A2pTqj0cTCJ8FyCg1xuXsx14DF3yo8uJ5rhRmZRn4I4JMOqm
         lJhjIXQDjMMZ5aIW9M8JKUYxqGdKr8qNH+0pByYERMjQYzFoFmT78+iaoyq+kuzOtqfy
         u9p/PtWsW1KIfv26JszRHuHdUroIebpPFVEJmi3aplQxq3pY8F1jWTkVzDaFvFxL/oZe
         piroBqwkPLjesdmMXqsEiXc9daRF30ySv/XWcJV8dVYZsY4cJ+eMJncIUmTn+JB2Esrp
         75Edbgo6zDFXsLdtt9th21uACNkasu0lojx4DItY10QJB0fxIccxYzRf/B/kvsfpk6fW
         yTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755806726; x=1756411526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HkM+ZlwQkXEfHv26NSiueZMKWBNsD/qFrP9LiagTa1A=;
        b=FQXjlws/GZEDHTPwqHhX/tNv5Gi0zKwujO0dsRJU02lG6cpfqjirXMY01+2Zan5jsK
         v9NQ7xx4dR15aeErpzDivBCIue1uJG0yDP1DgCPch+ZhsT7thi1o+dIKsoT46j6gZpbR
         I5xcN2BgIDTgWQJWfxHKGRuKas+mhjGC81+TbpkwyNOCCIbXqHUUU4oE3Ms0e3fhOjIu
         LdoD6le6wxLi8g0ReqF3ptQCPFi8hF519wOjz4CgqQZ81jD9yVKsHc3QMWEQPzypS3Mv
         Ym60PTXzSJ+jjYqp/DVNb5jmSZ4Lx91bRmD9tZQ0uSDkscpgM6bXK7zYNQ0t5LIysqCU
         OcVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDIQ0f1iWtZOg/0PWJfIrSbvClT5yjNdY8qlBMyGiYlTdbfpDxAvRoWjod0f8mepJNOQxxKCb8WbC1nSA=@vger.kernel.org, AJvYcCXwfpMLwfbgdfJf1W0bcgq5RQKNMXBzMxrN5cxZuyJjZU7AJ7l52+LHm9LmCmhFY3UKHRsT+qlk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy80DVGlrL3KXfenOv9pRhfBTKbvqDnjeI5m77tf36PVLcMEDuN
	4d/XMXCzGPHSoJS/8BDW/KdT65Yt0TqmnA0cRGsiU+bi0GZE8a+paP+t
X-Gm-Gg: ASbGncsgBz+i+ZEVypYdEyqpk5aNKhfVqPtvfwx11+hDAOUT29A07zaMX0BR+SNEwAG
	5UJtVLtIedrYnxRvcd31KU5p4LVPmdkTMoE6H5iCHaY1Sua478LLT9HUHiPGS4aLhOsjZx9+cVT
	ozYCHmcHYgk9YWrmtpEsWVTnq7BKVlWiq/8K/XY4cNbsSJvuA8WKOvQcKFy+6SVEjhWOyE3K/e1
	fNrrSMQQLv75bNtZR/52S+cM8A21MYWFcnKViBExrQSk8Lo7f3W9BjzMQqpUJF2xgD24yChb9L/
	a86/5u+Vy3InBnBEsy9JPPtRWpaTJsbWZ5Tvsc+RQyJNKqJuhou9J5sr/Ch6NW4JLQlmlsrL71o
	JUgspYU16Sa0q1sU/NrbEqHDI5xoFO3cmV/jk4HHjrlWi22G1GyfLa0N1DnA06nQiq+daDQ==
X-Google-Smtp-Source: AGHT+IF16NtzWMBaQPif79kqfiEzc0ZXeCAv3mxEzPlVQ0WKL7zlM4oQyM6O3N61imKCWBMY9EjrDw==
X-Received: by 2002:a05:6000:288e:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3c5da83c60dmr199834f8f.11.1755806725321;
        Thu, 21 Aug 2025 13:05:25 -0700 (PDT)
Received: from hoboy.vegasvil.org (91-133-84-221.stat.cablelink.at. [91.133.84.221])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c19fbsm12901416f8f.41.2025.08.21.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:05:24 -0700 (PDT)
Date: Thu, 21 Aug 2025 13:05:22 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wen Gu <guwen@linux.alibaba.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH net-next v4] ptp: add Alibaba CIPU PTP clock driver
Message-ID: <aKd8AtiXq0o09pba@hoboy.vegasvil.org>
References: <20250812115321.9179-1-guwen@linux.alibaba.com>
 <20250815113814.5e135318@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815113814.5e135318@kernel.org>

On Fri, Aug 15, 2025 at 11:38:14AM -0700, Jakub Kicinski wrote:

> Maybe it's just me, but in general I really wish someone stepped up
> and created a separate subsystem for all these cloud / vm clocks.
> They have nothing to do with PTP. In my mind PTP clocks are simple HW
> tickers on which we build all the time related stuff. While this driver
> reports the base year for the epoch and leap second status via sysfs.

Yeah, that is my feeling as well.

Thanks,
Richard

