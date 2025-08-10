Return-Path: <netdev+bounces-212343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 401D3B1F804
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 04:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54773189C14E
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 02:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1761459FA;
	Sun, 10 Aug 2025 02:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="kaEncN1U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A51DDC3
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754791558; cv=none; b=oxT9Oradq3OJx0g81IVbjNDUDoPnMWNKxq05FaPR/2wbS7LpXND5fhUVMfTzu9141StSCRoA6hmmAyps6s6ApvH4LMJqg+nc4gbEqrLzmaXruIGNVOOWPJcL/2EsY5UA0gt8r1tayD7KAaHte6igeQlkvgqLIVhpslbtbI2f2ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754791558; c=relaxed/simple;
	bh=s7wQGYp05L9HfcQFejriC4r9sjnCHXs7CU+Ln53RY9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/qunkpTSDUSu3wGn7jjSiyz9uoLZts3mLmSwatntarlMjvrRFQ+B+XxfrAJdkz/sAxTjugfeAiXI9Ev1uCrmoq4jI4bPEw3Fz9tlwYBhJSwCB8conavQMRb1gj3NM5/hgggbVI9VciRcty8XfqTt7UmBtg7nXjFC6sa/zIOqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=kaEncN1U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2405c0c431cso31317905ad.1
        for <netdev@vger.kernel.org>; Sat, 09 Aug 2025 19:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754791557; x=1755396357; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pb6zcooEg3RRvTiv3EjpCkXeNvci0on4KfGHqARNl58=;
        b=kaEncN1U4woODhAoO9OHwrdDVTotjq7yqj5UKCirULLEcoIQIsFFtWMdkQQA4HAIO3
         mH7UEGxEg12Il45cd6PMSvneShzpNER5Rjp3d8IibeFWJASj1FQAbgxdydN/6NVjEbAd
         /ikEH02XTvU1KF/ret9og1m2auLjxNUy2seUV0SKsbxLsx23l+qtfnFOP/lBjl3OwDfm
         uN4uIeffcAznwtYpLxo9cIOJXH2mcTPNVsVEbjCHNbiEsw4ZTj2OI6ViuD3llBBedg/J
         RCEJTf0E4t4ex+csA9uYaWjruDkxpJAwgNTI+0PbRlLv9zCDiM6m8hBlCo1xvx+mNfho
         ZdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754791557; x=1755396357;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb6zcooEg3RRvTiv3EjpCkXeNvci0on4KfGHqARNl58=;
        b=oBtCfAcEOFTT+Ya7l3dHtnkcP5yK5FktlhEzeiFJOVHrn/fxeiBG9AcOX39DMSBY/K
         k8kdHnQt4GDM+nSTfCBfY1XlNCmo//AUd9DtfHsiEn3jcijvof97c30Z95m1Ki+xEw3k
         UUTHqQgeEOxIQYfEZh1Iy9bJY0I4kyiq2jpwc5Y2RzQEwY3p+VZ8V+1bTTXVz+wXqycG
         iQluq8BAA1XbFQrM1ljj6OSPtcSSNckPNLQsrYR5+OEN4pZvFpcV+kAUnWNmN10seDaD
         Vpm4M90AdeBiO+MHDzdpRD1wjUymdBAYnYot3+bwZ5tlC/zgbCT5Qg1kbo/bDYXNVeMi
         NmWA==
X-Forwarded-Encrypted: i=1; AJvYcCUdBPtwIYjBBPeMj6zCC1NF7OKUFUqAhWPlmg5zOJapR+GJEivxqXaxy4D6tPmK58UJXw+FjWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccuHem/weo6lVph/MzEP9qDrNrrSYYLODlGLGGqMd8QiA9a62
	GrrQOQJY7ZxK45Rzvws+NwJkGM3BlkekvEGX9YVtNcU/OoKHkaTq2ze0C+sTaqRpGiU=
X-Gm-Gg: ASbGncudLEhB+syhTtlhxBjrbsM7OMnGQ45RZ7+DjAKF3s/cCiBad7mUwJXgwhk3zmm
	qB45tOjqt0NwU3CKO8q19Y63RDJhST30bVwRYse15lcN5jUl5Qn3GlKnxXj8epDENm4QgdlfwjR
	1Pm4XbREm5hkvaeEG6wAheHF+dMUZeJmysuYyrI/tiPtxjUQeYT2pt97P6c99CAAevDUmqUfZXv
	efjPv7fAYNsiJSrWiG6HfSitPrRsCfT3iRCh0GdVNzLGl3BtD7wK8VekEHvhYlo9oK2bMkErdOo
	6RS7IjB6yQ/mjYpW5utj48gWLO6uXyuVu/tG6ab4V4Cq+b9w7q9uniPS/XOHVyd/LWtE7vWBNJu
	U8Fs3U5vAcg7at9S9m2NiGDH0UFPsNg2GaAL3TUgHA12RVBQY9oWthftwTL3++grXp+JOFe6k
X-Google-Smtp-Source: AGHT+IF1TFqQOJkKBEjGMqAqbfj9fuF7MJ8nc7ELVFSJtdFjC/wviyjT7cTygqCqjzheWp7D/l2Vow==
X-Received: by 2002:a17:902:f611:b0:240:468c:83e7 with SMTP id d9443c01a7336-242c20030bamr111421885ad.3.1754791556680;
        Sat, 09 Aug 2025 19:05:56 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3acfsm239911345ad.146.2025.08.09.19.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 19:05:55 -0700 (PDT)
Date: Sat, 9 Aug 2025 19:05:52 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] net: prevent deadlocks when enabling NAPIs
 with mixed kthread config
Message-ID: <aJf-gL4n6xF5V-rk@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, skhawaja@google.com,
	sdf@fomichev.me, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250809001205.1147153-1-kuba@kernel.org>
 <20250809001205.1147153-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809001205.1147153-4-kuba@kernel.org>

On Fri, Aug 08, 2025 at 05:12:05PM -0700, Jakub Kicinski wrote:
> The following order of calls currently deadlocks if:
>  - device has threaded=1; and
>  - NAPI has persistent config with threaded=0.
> 
>   netif_napi_add_weight_config()
>     dev->threaded == 1
>       napi_kthread_create()
> 
>   napi_enable()
>     napi_restore_config()
>       napi_set_threaded(0)
>         napi_stop_kthread()
> 	  while (NAPIF_STATE_SCHED)
> 	    msleep(20)
> 
> We deadlock because disabled NAPI has STATE_SCHED set.
> Creating a thread in netif_napi_add() just to destroy it in
> napi_disable() is fairly ugly in the first place. Let's read
> both the device config and the NAPI config in netif_napi_add().
> 
> Fixes: e6d76268813d ("net: Update threaded state in napi config in netif_set_threaded")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/dev.h | 8 ++++++++
>  net/core/dev.c | 5 +++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Joe Damato <joe@dama.to>

