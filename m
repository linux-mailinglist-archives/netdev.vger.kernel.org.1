Return-Path: <netdev+bounces-184953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314DA97C8B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005EC189D833
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5CA2638BA;
	Wed, 23 Apr 2025 01:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="llUF6W06"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CB91A5BA4
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745373166; cv=none; b=XSem2lSRWPBv+jLMou849xdelIS9X2321n0a41qjZwW93L4DUJkVs9ykilu3aubhVd6AQMxHQKzaxPtf4MSdbm9R8Ioga6s2OrcCoDhCarJfyGNzDeTqG1c5kIrsXuP2OA/gsgjDP6gGkJLucpV20AWhzcrA5UX/Nj2zLffqg24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745373166; c=relaxed/simple;
	bh=4wLhV3IbHlgGXoJekz7dNit5CqhCaxM+G6qgYArGhWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyhCG8uI78NKp3SLMTRS9tk0RBZecpw2bXRkO15izhK4SI8FdFh0QUwYUBlTEbvsvxfwD5jPYbBMqzScFkAm+vLXhKNf/F8/sOG4+GcCs+60/3geC64SEzR6tcZXFi9cAGAKQbrdqEBdhYYM1ByhNqOSmEWg5NlW5vNEPAPIGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=llUF6W06; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7390d21bb1cso5466781b3a.2
        for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745373163; x=1745977963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3aNxDyiOPHAlWqSU66cOhuYSikR8PHGxfrsyOzZYqs=;
        b=llUF6W06WsNn9CDlbW64n7oxfp5mLCLf/cioUKFyhjbVa1inCrlScn3cgClVHviUIn
         tzTkh5VYdZWpJ2OlJqTJPQtkmB5cvjvC2t3jxceYsFemS36Js1JAlD+ySPaovwgWVLke
         XVlu0Q9IN8RUuIiBel7fL801qK8DN7qpPvSWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745373163; x=1745977963;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3aNxDyiOPHAlWqSU66cOhuYSikR8PHGxfrsyOzZYqs=;
        b=gvDKbWrnH3iEaMC4tsYxuCrsS1d0zBrwgw1778pZ4bCUs1RGGQ4hAdmQb9NT3Gphz5
         s/n/YpqPsLXyOtn70U6XVX5AwicZ8+dCOC7U6OzG1PlL4yjA9Oa6+uLVxmnaTGuHiu0f
         /B4OrLBB6F4EGl7+ekx4gNiVs97QVEqodSRAtEaVcMucAl7fEDDrv1d5KraeTpYXXzGr
         TqcZnGS3bcLhZof/YuEyu5cHkjTyqCVxCmJ/YChUpR/yJPbA5XyIKhx5Wb7/7ewunm4b
         /pSpkg9KYPQ+RpZDsMiaOvT7yMBAFTklmMYKw/JkeT2psi1M83ztPDnugEisEq7QuPWZ
         2bOg==
X-Gm-Message-State: AOJu0Yz+y3reDcEMaxXuCii9x9ictWObXO+D49RX2ABQ+lUiBqsM4X8e
	jsVvBcmAS831vavNVxj6K98JT35zZc/W5nwskNQKD4bbDBXooAzfxb6ar8a2DsI=
X-Gm-Gg: ASbGncsIdS7JT7Cla7d4zpYmGm+nLDEQ9oDwH/SrGSTLY/bEQWb5NLPOF5GW29pghOt
	qWHTK6dWGVlyqaIJ+8ONIyFgbIfRRiW2XKMVBvyeAoiTUbKQ5WtpYJfMrh87420ZjZuWEVmyHq8
	LFhSl2+me657aXVXALvn3utvUvKhlQnbs4xS3mr3PV56f2VUojH835nK6xUfrGGyC/aKXH1CCDQ
	WbzmC2PPa53O8va/BlsJVKsWdETxTinS/QLx9Y4kAgIPXbq0t8YcIa4SjKuWhBbr40P2rul41pU
	AIfih5wGytc9xH/4mbbQuENxNg7Bkr8GnB/E73uvR8ihn31MZjbhPhARzDjgow18OfhLdWReEIc
	zw5VraKY=
X-Google-Smtp-Source: AGHT+IFNcDRLC8JrDRyeuZbCW/ZJZarqcruDNdE2GGwIN74QiRY5cyf1Dg86vye1n8OlLjdTw9Gqsg==
X-Received: by 2002:a05:6a21:9981:b0:1ee:e2ac:5159 with SMTP id adf61e73a8af0-203cbc74809mr23837012637.19.1745373162682;
        Tue, 22 Apr 2025 18:52:42 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa5836bsm9371009b3a.119.2025.04.22.18.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 18:52:42 -0700 (PDT)
Date: Tue, 22 Apr 2025 18:52:39 -0700
From: Joe Damato <jdamato@fastly.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
Message-ID: <aAhH5_kFB0Jrf4xj@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jeroendb@google.com,
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com,
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com,
	shailend@google.com, linux@treblig.org, thostet@google.com,
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
References: <20250418221254.112433-1-hramamurthy@google.com>
 <20250418221254.112433-6-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418221254.112433-6-hramamurthy@google.com>

On Fri, Apr 18, 2025 at 10:12:53PM +0000, Harshitha Ramamurthy wrote:
> From: John Fraker <jfraker@google.com>
> 
> Add support for the SIOCSHWTSTAMP and SIOCGHWTSTAMP IOCTL methods using
> gve_get_ts_config and gve_set_ts_config. Included with this support is
> the small change necessary to read the rx timestamp out of the rx
> descriptor, now that timestamps start being enabled. The gve clock is
> only used for hardware timestamps, so started when timestamps are
> requested and stopped when not needed.
> 
> This version only supports RX hardware timestamping with the rx filter
> HWTSTAMP_FILTER_ALL. If the user attempts to configure a more
> restrictive filter, the filter will be set to HWTSTAMP_FILTER_ALL in the
> returned structure.
> 
> Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
> Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: John Fraker <jfraker@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>

Reviewed-by: Joe Damato <jdamato@fastly.com>

