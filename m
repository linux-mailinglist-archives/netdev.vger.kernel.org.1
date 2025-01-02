Return-Path: <netdev+bounces-154841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFDFA000A8
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FC41883C40
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 21:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043F91BBBCC;
	Thu,  2 Jan 2025 21:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fO9gX4MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475011BAEFD
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 21:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735853425; cv=none; b=a6lYSJuAuK/wPFyzdGRVeGk2g0rC6jvjqQQHlzl7LZq1o1aL50Z6l27X4E7nuBRHeqQGOqy9fXjmAuJPO/yRH3BssSi8w+mK6AaasIbvOKrJPt30dq6sZqo/ASFGLGYdWYj8TjwPq+zl/pjBy0oj3OjH6X5hTK8lfkdnkvozrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735853425; c=relaxed/simple;
	bh=t/wgynbdonBC7UykvAxzCAUjGHKmcGxPLZrx8J/Zl/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ksrg6ss4XZk1AQsshSSTqMWC1cQh7+obJigMEPD7s8ArYRkrnXHXZk7hTzar8htlyZIT2jA59NuY3EVMN+kEyTJvwK2jaBF+3WDhtOlx4jorV8TGXs8VWXIX37v+rcWzWmY/4O4RQXTJDhUipkpuMRY2CYXKHmHl/3E/Vr9HhRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fO9gX4MA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21634338cfdso231723915ad.2
        for <netdev@vger.kernel.org>; Thu, 02 Jan 2025 13:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735853422; x=1736458222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h7f0/KPKImTPD1G/iJOzNoVm29n327ncegcXJvE3JJ0=;
        b=fO9gX4MAIsVqi+QS4xRqNgtIormADI0qxqeeLw7AoGrTOBTbZ9DsFvKH/QssrbCqkS
         1QQwrmBsN8gQzQkIURAV0d7hmSIZRUsOp1xBN6YXG8ZvDUyXO7Ahh7fB6901M2G8aXpD
         67YhuVYmFnzk6sn4n1BFGY+ws6zahco7eDRseqiD61Di16VoJqlmXkGvvfV7PtHXAD/8
         qr7MUXmuod9NDX5EqDZjE+D52C+gxboTHxSLbHVBGJKDWozbpv1D0lVhI3l3o/MYTpKG
         VgkalZ0zSZZkM04limD+Mkrv+l7eM3b7a9XsnKsw7XoAmitv+e50yttrwp8A3iIEDoCm
         S5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735853422; x=1736458222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7f0/KPKImTPD1G/iJOzNoVm29n327ncegcXJvE3JJ0=;
        b=YGEVVzulW+F9i+uFmsTE/0V/MyH20taYmWqxXCuLAqyLIKasn7RV6EGWu2aceNuKrQ
         f6QuwKb0U81Z4no0zP8sWtKegB3v/AbevKTYngMph619FYyAEV2j7rgQ2BboSiXBAuvv
         EADJX0+snrw3VQW6G8F+UxNJ17D/HSjQJ7dtQQbgJJmZLWH5nquLirUFG8sZfzjoaNu0
         cDhH8eySG9wd3rCjUAGdlkf3JK8z8SE10CZAuWhX3lYQnUNJ55D1L9DJFo7MEVDii/1O
         o5bD1xIzE+3t763MiqdbHsHbCdOEUfcHi678SrMZ9nAn5GLuQibf5Pne/mXTvfwOIbYy
         wPtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW13bm5LIPaqgLXUc3wsiofVqSnyKRn6uigWJMiLG2JuiyIdAXsDEYsI8C+ZsrAjp3AspHUzhg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn3S3jqDIpD4/88BoCLO2ddXeyd7hLMDxCp0i+8slZ8cDav1L9
	ZXq8J455kzRwi3x3r8dOq+b5FVrVDJzDLz/F5v39d4hPZFMmA8s=
X-Gm-Gg: ASbGncvW24X9NwntU8G8JGPfIwS6Q8d/bj3v0vECKOWLJkcTHq5oOLi3Pd4HGMLOiJ7
	m0Brl274RKMfHCAqj77ZdT4eSP4pA7HXqazjQeY7cRnqpDRtnjUSs/nDkaTVU19hq0eWzqNCoZF
	V5scPT5Plu2fCQ3xnsgYb3AmTzxU2RyZmUJs1gz2QR6Ur2uOZjXW4Zcpchzboqpi+y8m4pZjFmv
	rOYnW9d/yu2HfcffmaP58DU52kKblbpgwdBVhr+2WDwlTxqJ1M4fOxX
X-Google-Smtp-Source: AGHT+IGXBzNsfhzwixQ4g/C6ot9GfT5eOvyX7BHsBfZHXVhoGH4fIuimhW1MigOgU46lVSohyZWUKQ==
X-Received: by 2002:a17:902:ce01:b0:215:97c5:52b4 with SMTP id d9443c01a7336-219e6f2601emr731939385ad.39.1735853422096;
        Thu, 02 Jan 2025 13:30:22 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96312asm232128575ad.21.2025.01.02.13.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 13:30:21 -0800 (PST)
Date: Thu, 2 Jan 2025 13:30:21 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller " <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, jdamato@fastly.com
Subject: Re: [PATCH net-next 0/3] Add support to do threaded napi busy poll
Message-ID: <Z3cFbdjD4OtSwB44@mini-arch>
References: <20250102191227.2084046-1-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250102191227.2084046-1-skhawaja@google.com>

On 01/02, Samiullah Khawaja wrote:
> Extend the already existing support of threaded napi poll to do continuous
> busypolling.
> 
> This is used for doing continuous polling of napi to fetch descriptors from
> backing RX/TX queues for low latency applications. Allow enabling of threaded
> busypoll using netlink so this can be enabled on a set of dedicated napis for
> low latency applications.
> 
> Currently threaded napi is only enabled at device level using sysfs. Add
> support to enable/disable threaded mode for a napi individually. This can be
> done using the netlink interface. Add `set_threaded` op in netlink spec that
> allows setting the `threaded` attribute of a napi.
> 
> Extend the threaded attribute in napi struct to add an option to enable
> continuous busy polling. Extend the netlink and sysfs interface to allow
> enabled/disabling threaded busypolling at device or individual napi level.
> 
> Once threaded busypoll on a napi is enabled, depending on the application
> requirements the polling thread can be moved to dedicated cores. We used this
> for AF_XDP usecases to fetch packets from RX queues to reduce latency.

Joe recently added tools/testing/selftests/net/busy_poller.c, should we
extend it to cover your new threaded/non-thread busy/non-busy napi modes?

