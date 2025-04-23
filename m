Return-Path: <netdev+bounces-184949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D8FA97C7B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66EF87ADD42
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E62F26388C;
	Wed, 23 Apr 2025 01:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="FUNpT0BZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B992566DF
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745372947; cv=none; b=oTM1KPxBSGaBy75ypwsBz/mqa3n25y4lfjt13f8oqw8Usk4CtcjwUwIXAoqyCUv2DhBxJ65/OvGj156BaO4TPaHYxFR0eurzqUUJdwG4axpFqRFX9E9m2kXChFCoAonGc4gGQCvZakLLGHUiQbH5sCgAlm9ZN5wrulA7Uqumi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745372947; c=relaxed/simple;
	bh=ckkWUT/xderljp85srBq8CewP/4u2qXDhejWjPahdMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPr+jWOlksrKojBu8qFkbLOTU7m6lvzuTLRFZk8HwmakeWGck7qcqjtw92fRXB8WECKP9BC84Jto+TVeHvX7ONeqE1hNGe0e5FZTvvehEdDcJucZWTlLPyWyIiOdzeT8JzN+QiwByG+2lFdkSjYhJ3Hfm1as2MXvuFdOy7JyFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=FUNpT0BZ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7370a2d1981so4790627b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745372945; x=1745977745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aratRX3GRbQd0qysev0iEy+ZcM4r/zDaLLFPtb+pO10=;
        b=FUNpT0BZ0z2QT9NPVQGHbyOqrtJtjgHdcCbg7jWHMsq20tWyFGEiCmCgSGIyPZfYpo
         IDIEbzii6Oby4XjOWq67mEqg/2BfzwgEzpqWg0F/1kAQgSmR3DttBiqEJbqNepLsbgwY
         7OMBMrAfY2uYvrQukxZ0RTzg8Yb/pXnS+BSsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745372945; x=1745977745;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aratRX3GRbQd0qysev0iEy+ZcM4r/zDaLLFPtb+pO10=;
        b=Ey6kwPT9ZOtVE519y9iOBBavD1nYiXukNMpRh6md0hK+UiF6AxEp07aE7YmIR6xoMX
         ajJmevIvtuxmZfZCnuNZVwZeRKEdtBCks6X5msafGDJjkYC/4sQwiXsgSB1JP794tlFs
         V8mTgdeuBX21A1FSr75Aux/BbGbZlIIqXuNHb4lcVzi15usWVUHlcdr7lY8+AhbQb9PR
         7pZzy8Qnd6HPtsq8vmKBKgryiJRKeQ+b1/QpSnUbD0E7inIxjCspAjjTLUYmiwU51vbD
         Z3qLhMwnWsXMxXc0GBU1Y2LbkbBruMlJQrz1plUKSZrBSb13Aua9457aw0DxzYsEMaS7
         6lFA==
X-Gm-Message-State: AOJu0Yw9IDEiosWmGk20GeLfXg/UKlLtcswZsJsswPJUQACXPrQrGRa8
	KAGnWULDe72sMRMaAK2829ODAkXw6FYUO1GXHmXAGtKcwKL9ANxqkIgJLKSS5us=
X-Gm-Gg: ASbGncvAkb1YKrHR8/YCubD+qb6Q8XftYbVthoORVWP0dg13GAaGar0hXvUVVDVItMa
	HvTRv3Ao+03qwTb+9+lSpqCkMu8AVq1U1quL4Ud0Lb5KtCAlhCxBd6YxjvoepBEMjjWiEncc1DF
	n4LRFztG3640axNeXcll3/UtMdADJkFfb7A+493NhlH/H7yeAloZPw8Q00aUZlkvTyHU3Ch9A+E
	SulSYoCL9UraScwVHbvEGstf2dJHVVhKgMvPoZuo+FUgQl06JCkiOOZMmNQ98243Q6Ihv3gEfK6
	oRHX+rxG6CKmy+uBJnxZmwbZ2l2ui4eR6GISfJSCfjt0JGzez0nzu1MTiIcs7fcLDH3BVMomQrO
	U0a2aaBI=
X-Google-Smtp-Source: AGHT+IG1V6w8PoW8HpIHJlOW/cURA2YNsA3KkFsPZNzMXgLxdjhLsNpC/+YYH9kU0qfn3ptgft9YrQ==
X-Received: by 2002:a05:6a20:9f9b:b0:1f5:59e5:8adb with SMTP id adf61e73a8af0-203cba9836emr25980226637.0.1745372944856;
        Tue, 22 Apr 2025 18:49:04 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8e3631sm9749625b3a.51.2025.04.22.18.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:49:04 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:49:01 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/6] gve: Add initial gve_clock
Message-ID: <aAhHDTWQ9k6_Eid5@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-4-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-4-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:51PM +0000, Harshitha Ramamurthy wrote:
> From: Kevin Yang <yyd@google.com>
> 
> This initial version of the gve clock only performs one major function,
> managing querying the nic clock and storing the results.
> 
> The timestamp delivered in descriptors has a wraparound time of ~4
> seconds so 250ms is chosen as the sync cadence to provide a balance
> between performance, and drift potential when we do start associating
> host time and nic time.
> 
> A dedicated ordered workqueue has been setup to ensure a consistent
> cadence for querying the nic clock.
> 
> Co-developed-by: John Fraker <jfraker@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Co-developed-by: Tim Hostetler <thostet@google.com>
> Signed-off-by: Tim Hostetler <thostet@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kevin Yang <yyd@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Joe Damato <jdamato@fastly.com>

