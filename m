Return-Path: <netdev+bounces-143191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325EE9C15C1
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A754EB238CD
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ECF1CBEA7;
	Fri,  8 Nov 2024 04:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pgIRNKS4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97D213D278
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041825; cv=none; b=ldnEPFVehc8Ly3OKoo3kWlQaUvjZr6p50sA0GtLQGlJC9CEh4UF+rl6G4lLr919LiwbKe8NAZGrO3UxCDmq6c8PN8uyQkPF5EpV+yr6A9uuhjdW1fIlxOjndR0nMo6YcSy5b3c8VF+ifoWnjDdulGDYcTtGqgUzwHcw+hLtM/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041825; c=relaxed/simple;
	bh=Ab3HMO3eKLgARO53MMIiVeWUY/vd9IniSh9diIM+Mdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Busq8buG2YmkXOcGxnoviThdpXk9seEUBLfxgmt2ff9RPoAxAWQnPrh5CaSVN9fWtOwXI1rWLLLu6Y0TnBLdr43J1I+G3AjJi0LEm2onxgPvwKDMulHD9YdW7PS7yrUAuTXWpbHl6y2OfPXhRIcsc59ustmoEeiHP6scoP9616s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pgIRNKS4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cdbe608b3so18285825ad.1
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 20:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041823; x=1731646623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYxs/iAi9D4dvnBjz30eD6LEjanF6nsQbGyEsY5CVZU=;
        b=pgIRNKS4DWeyFj+2b90+hmhe6s1K8XXOkNl4xkjcN2F+Fz1tIrelvarYFnCClu9mP1
         o2S6W4g9eHMIsPK0PssaFXiDEnBx298qMwc4c6asvZx2MMCebD8UAH3LpNAD4qJsdy0E
         9MReD98VogMc7x5kzL6mQfGGWjfch2mk41gD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041823; x=1731646623;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BYxs/iAi9D4dvnBjz30eD6LEjanF6nsQbGyEsY5CVZU=;
        b=rP1q+MLb13uW+rqlU+jd4/WYYTjjrAjbvxUTNj+okMBRdwxpOZnQEHzKo/DqA35tN3
         FA9i/10TfpwbyjK61sDORsBbUnMgRb2I4BkxfZjkRfJ9685QtZ/S24D8Gu/wHp9Mzodx
         F2QhwH522MmBAWT9yc4lcyqcF6vgxrsDeIa5unrZKJfbL29YV2pMTvgjvdDPdmApJNoE
         uWBVuuf52nqIxUbed+wuigyJmk/Oj+IT9ZthmIykGxHh4f5eFBvaHQkBKkv0BFGJ6UBN
         G76zSz3a7wXDpC2p4WTUlen3lPFmRxoocc9A83o9oIIzuQ3sLnFpGlmSf+F7XoXOIXZo
         yuMQ==
X-Gm-Message-State: AOJu0YwhXEpmeDDREaR1JR4t99v1FmWOnniToLNenb09MQEXBXhVzslQ
	5qHxyXCljKZPFgu5PfYXXGrDEBlWxA88QpjFoCvp49DjiQIfBGM15heSbIKexDE=
X-Google-Smtp-Source: AGHT+IHSJD2nYvmtst0NABiKe+u1fp77FUf9fw5OcmO5zZDo1U9OgoqPCXRncmfsc4fru4WgRiaSKA==
X-Received: by 2002:a17:902:e890:b0:20c:b0c7:92c9 with SMTP id d9443c01a7336-21183589b2dmr19384295ad.34.1731041823027;
        Thu, 07 Nov 2024 20:57:03 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dde2f7sm21743925ad.77.2024.11.07.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:57:02 -0800 (PST)
Date: Thu, 7 Nov 2024 20:56:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, corbet@lwn.net, hdanton@sina.com,
	bagasdotme@gmail.com, pabeni@redhat.com, namangulati@google.com,
	edumazet@google.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me, peter@typeblog.net,
	m2shafiei@uwaterloo.ca, bjorn@rivosinc.com, hch@infradead.org,
	willy@infradead.org, willemdebruijn.kernel@gmail.com,
	skhawaja@google.com, Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 2/6] net: Add control functions for irq
 suspension
Message-ID: <Zy2aG_ObPOIGKU0g@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	corbet@lwn.net, hdanton@sina.com, bagasdotme@gmail.com,
	pabeni@redhat.com, namangulati@google.com, edumazet@google.com,
	amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
	sdf@fomichev.me, peter@typeblog.net, m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com, hch@infradead.org, willy@infradead.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241108023912.98416-1-jdamato@fastly.com>
 <20241108023912.98416-3-jdamato@fastly.com>
 <20241107202119.525a3b76@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107202119.525a3b76@kernel.org>

On Thu, Nov 07, 2024 at 08:21:19PM -0800, Jakub Kicinski wrote:
> On Fri,  8 Nov 2024 02:38:58 +0000 Joe Damato wrote:
> > +EXPORT_SYMBOL(napi_suspend_irqs);
> 
> One more nit after all.. please drop the exports, epoll code can't
> be a module. Feel free to repost without the 24h wait.

Done. Thanks for catching that and letting me re-send so quickly.

