Return-Path: <netdev+bounces-164134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E224AA2CBA0
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 19:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0DD1881549
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F32A1ABEC1;
	Fri,  7 Feb 2025 18:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="IXSXmcek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD911B0435
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738953676; cv=none; b=gTlPFKJ2vQGF+I45NjduHZoUVxgWCgyt+nZrcKdGc/YDh32j/b6hrODr1X5EDC+8/IAPWawolczqdFLCPOtKL2c1+nJWFffGgoedSFm8j4cNHpHH2ktxvaPHql0JQLbwYk+XkaT81lFE+wQbxcG9QzFLcDFLE6KlSli04Jafmh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738953676; c=relaxed/simple;
	bh=oco0Lqf/fb+pkzZei0VqH/EhA1GrCF6qBt/94yWHles=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+rMbYbnihTa/5DDpqokAFlsHWpXSQX6IdSeKUMRYNBaEv2/fnyTLDSOThdMRmj1LZqEqig9lj0BplZhSgdbOj8XHkWVpqXdbWKQI345ipQUcDoUsZ2WgjpZZSZbccVBCRy+k/oE/5cXL8qtZifagwMVnmHOr4v6j8DyYKq1LoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=IXSXmcek; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2166360285dso44076615ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Feb 2025 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738953674; x=1739558474; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pX6bgDb7LMFYhcZSyq50FIVZrkoehDFKY62VUhrMl80=;
        b=IXSXmcekg4S4dCIjTAIHWjK5tmEsQi998IJ9+5Mzl0510nZO8PZ/IrWcxOx7uJkcZh
         g9mAyrxnzAyynH/vpp+9wXq1FM6AQdZMKm04IYahf4x/5NGc9POTuGK+uDijGbZOWZix
         CfS0felIAcy03J5PJEpxgs89WCWuEkT+0lV/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738953674; x=1739558474;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pX6bgDb7LMFYhcZSyq50FIVZrkoehDFKY62VUhrMl80=;
        b=L5UbhRfPm5/MPoqjKDBolpad3bGbP2WUGphZmgPYMvWhbx6yiAoHc5h4nFRHhjgMHd
         IiVhruAFivHCmARavUu3WsnGEpttk6LjiOkkNCAaMFa0cfXVu0B09JZpeKTxXCxvckWG
         8QzRtudG00VXMumVSxEP55/IKnXGm0zrTQAJPLI7K4s/Y38ZmzO4L66NpqqVbWvW9+2+
         9/4/hMkNxlC1w0zq+3yOz7cOOsvrD0Oph2mybWACxUPUOcA2JMkVeQ75+hWm3oTo1Cnm
         lJBHPH69JQn8jjFV22drAkzHhEWys13cpxgN4HJoo8eeIYc1oKJ98TJpnf4OOs3vvG/j
         Cj5g==
X-Forwarded-Encrypted: i=1; AJvYcCXup3C2sp7TomnOgGVXCiBUi2inyCIxaYlwR6qqInpFnudNlxclm6l5VY9acfKrCzUIMK+eDf8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3S85F506FahDMyBDUnirr/TgyNEo5uwo8W24NA8Sd4QoaFDik
	57eQUjsIOH4r9tLvwJjeEiTv4t3nUdCHyBoZD2BrI9w1O4uJrNlXA/GRIBSOjps=
X-Gm-Gg: ASbGncuForasIhVf/4ehqNt5XoXoPqxgdI1jYAXwoUWTPvJJJxTLX+NQDYJY/lXCguX
	VXHG0qfCnK5yZA6h8cSV0LcLnznFEtR7i8bh77i5md2OuS60q+JBFwpK6xzUgLh3PSXGfjYJEBf
	6f5rutkj96T2OrMO3+EbvZDAFk43oCCeQ4LIv3vDFEg89arPCgkuk99FkRPnlu5HM54HNqP58P3
	o9iNrEZAvun2gEZgjxWIn1/K9+3/dxmYpjzZqxG7idFcdYQSCRd0L3zLKBFpfkNsmA3lGzg4n2L
	+BEGXXVCJOC2ttxO9q8uOYYWwY6yHPB/BfgoIYHmTH6fQ92BGoYlb8y7zg==
X-Google-Smtp-Source: AGHT+IGxLV+iaxkN+MqLINKOhTitdwb1FvV0w5srDzBYBBMluFope5BhU1ALTENRSG9snyb4tqVknA==
X-Received: by 2002:a05:6a00:1d25:b0:727:64c8:2c44 with SMTP id d2e1a72fcca58-7305d4ec73emr6979465b3a.19.1738953674036;
        Fri, 07 Feb 2025 10:41:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad51aecd813sm2948474a12.26.2025.02.07.10.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 10:41:13 -0800 (PST)
Date: Fri, 7 Feb 2025 10:41:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, almasrymina@google.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: drv-net: remove an unnecessary
 libmnl include
Message-ID: <Z6ZTxyDzzK4OQmyZ@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	almasrymina@google.com, sdf@fomichev.me,
	linux-kselftest@vger.kernel.org
References: <20250207183119.1721424-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207183119.1721424-1-kuba@kernel.org>

On Fri, Feb 07, 2025 at 10:31:19AM -0800, Jakub Kicinski wrote:
> ncdevmem doesn't need libmnl, remove the unnecessary include.
> 
> Since YNL doesn't depend on libmnl either, any more, it's actually
> possible to build selftests without having libmnl installed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: almasrymina@google.com
> CC: sdf@fomichev.me
> CC: jdamato@fastly.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/hw/ncdevmem.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

