Return-Path: <netdev+bounces-168272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71969A3E528
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 20:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB9A19C483A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4909B26563A;
	Thu, 20 Feb 2025 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Of8y4vrU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B81213E80
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080122; cv=none; b=QkHJYRCDuYURc5A3ARRQbp97Jpup4Qwl9bSDWFMRMKz9VH/312tu3Y6CyECr5y5kePuYuZ/iHT46PgF/c/q8V5CAubVfvBIk/yNUMrmOqAOM4CHjkAwti3SBCUk35jM82AvhM4pJ/eJNtaR58HMf7GZioNroivdXyRd7+tzlvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080122; c=relaxed/simple;
	bh=Xlw6ZLbBNxd05wvbuaiphpxA2TltHws4B5kWG1MCRNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otWyR74MwmtWLgeKmQN/+dTAW2CocN9JRTnBh6SUbF+DWDiYeX8UXmS1vh2YyixZ1q1EmvyPdkwRDOgSo8DMhcFXIQMaRos53CetahiU4Gy5G4suRuJ3vSniOFvnPx4zMk0leTBwX/VOAF7ftVpWi7Mq34mkzqW7Bd047Wzly00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Of8y4vrU; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0155af484so197687385a.0
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1740080118; x=1740684918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9I8NJqPk5xe4i2G4yWDrh+CmokfE7FfncyzoLEVvnM=;
        b=Of8y4vrUARoN1Wt3rMEOuVtspWgUUeutzY21dXJxGDUB/7X2R8xu+F80ez7LIZ8WRe
         qpbYfn889kbF/QpxmesbzDPPMf+L07A9z/7N2F41ZKtylhUwydC6YFmkFxavWlv1KGss
         gSjQ3/Fnv5kkSUpJpEX1N/W5iC8aRQxHTT/GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080118; x=1740684918;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k9I8NJqPk5xe4i2G4yWDrh+CmokfE7FfncyzoLEVvnM=;
        b=vtLgXE8rezSZb+wwlfQl+QYw0HrNPhwvklaYzvz0mgYPJ4NC+YnWrSrDJ+5+Ly/Njo
         GnBsBLmb1FNNOc3AJDsl8gp37rpRi5Ww3DprnPCVvqy0YnyKs2ZUN3490hYeQyIPaCdV
         Qw2D5J3VbhJiLqyDV/1gisBKxQ1RVpsfHkqGmBd4s7GAIGrpzPHfs5I2Y+aTMnQK5Pv6
         2fB4nNfsSv1SWH20roVoP+jQQH7MupX9OAFCeQwCiLK4qN5xF2qijN45oQWkqB9iwxOy
         LBB0DPOf85X7TUiHpdhmdEl1Pt3FWL9bmHebXmw044bOc8ComFnkqts2FDbaZtZXG/lw
         sgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsAGxmajPemLBJ3jFJXuDcK6BjeaUS4CQlXlaS27AyZnOo6JgjCPPkWBQwVeXECY+lVzsmeW4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8n9/wQ9nSlAYFsncMl7FoW2Lde7UzR5+6Y3B/FQN6UMzUsgT/
	zYyeMwIa0N1HXJ+32fIOqu5fBb/fZkazAwbVbpyMixyGASJw5OdLViuaDGiAAtA=
X-Gm-Gg: ASbGnctxZsPoY2zuSHWovDJQ4v8uXSFwKlWG7baLDqqKS6U0DDvWxFg4Q9PXcE8hpCL
	wtzatO7DEizlz/EpGJuLi/12MBi5L8tXxZi3RH19NWtqeCQbPhMyytG/xUP7QxxcCOqvpuJZtAR
	8pzfTitOXCvE30kswK6pa7bfsTaLUr2+vK3LxYyZbzQAljJsK6I1NPIVv9UGnvzAocApaqgfRpr
	k8v4jytPzX17nsBNDjj1Bj5QtPeZs5Pch0wODqBJpUjmYU+MswF/Btx721sX+Ns9XhHyyuN3Cpu
	Y7eD40LvZ+tqL5hDN/lo6kd6h5bGcc8jE15oRvR/T8fXlUx1CXBgvQ==
X-Google-Smtp-Source: AGHT+IEfpH/1FCYyoN8iFt32/CPSUyCBCQ79gdfwWu0rB1MwbULHmhvcdWqIWUoJz6IyTLjk4v3hdw==
X-Received: by 2002:a05:620a:2620:b0:7c0:c195:fae4 with SMTP id af79cd13be357-7c0cef723c0mr75684585a.51.1740080118247;
        Thu, 20 Feb 2025 11:35:18 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0ae3fa256sm347558585a.0.2025.02.20.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 11:35:17 -0800 (PST)
Date: Thu, 20 Feb 2025 14:35:15 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	stfomichev@gmail.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v2 0/7] selftests: drv-net: improve the queue
 test for XSK
Message-ID: <Z7eD866CFu_KeWOw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, stfomichev@gmail.com,
	petrm@nvidia.com
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>

On Wed, Feb 19, 2025 at 03:49:49PM -0800, Jakub Kicinski wrote:
> We see some flakes in the the XSK test:
> 
>    Exception| Traceback (most recent call last):
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/net/lib/py/ksft.py", line 218, in ksft_run
>    Exception|     case(*args)
>    Exception|   File "/home/virtme/testing-18/tools/testing/selftests/drivers/net/./queues.py", line 53, in check_xdp
>    Exception|     ksft_eq(q['xsk'], {})
>    Exception| KeyError: 'xsk'
> 
> I think it's because the method or running the helper in the background
> is racy. Add more solid infra for waiting for a background helper to be
> initialized.
> 
> v2:
>  - add patch 1, 3 and 4
>  - redo patch 5
> v1: https://lore.kernel.org/20250218195048.74692-1-kuba@kernel.org

Thanks for doing this work.

I tested this on my system in four cases:
  - XDP disabled:
    - NETIF=mlx5
    - NETIF unset
  - XDP enabled
    - NETIF=mlx5
    - NETIF unset

The warning in patch 1 does not print on my system, but the code
changes introduced in patch 5/7 fix the hang.

I've already given my Reviewed-by / Acked-by on all patches, so not
sure if it matters but since I did test this as described above:

Tested-by: Joe Damato <jdamato@fastly.com>

