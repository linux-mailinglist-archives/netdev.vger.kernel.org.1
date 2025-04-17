Return-Path: <netdev+bounces-183889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE85A92BAF
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4510E3B29FC
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C661FF60E;
	Thu, 17 Apr 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaRKCR6t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC7A926
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744917796; cv=none; b=Xil1CM68dijHa6UuS6jHrsDXWEWM/fYIKunfzui+uG3kfeEgZ31/rXy6g62ac+OH4rriaYEchZeqQ4OQEukzZV3ph6M9Rkbce1tFrwV5a5gkTmRT6lcwwNW0c3HI6zPOCJnxnuT8s1lH426ivjFhSX2VlV3uN5nZ809RUXM/d+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744917796; c=relaxed/simple;
	bh=MQjs5bZT88zYUv+wcBqPnXjfq+/cVtA2skW01dT5HQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k02UGz0Qx/FfPZKtGxgrr3pY5H8jV4iH8cIINrfF/ccHpzssOKvJrCbO+odYSyGsrNiL7K8KvSTdSPZCae9BxK6SgmtsCV6mWgmX+sK/XM1Gp4bp5ZuprzpHgaxGC9unj/skvx970Osu8QsAXVgNHYBEAPhcuPjvlXC8dUONZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaRKCR6t; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223fd89d036so15816715ad.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 12:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744917792; x=1745522592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HS4woUAQCYhef9KEALqtHQI9LV6pq4hqus/RCUz0zkI=;
        b=GaRKCR6ttR8NLOcIzV+5hqsChqyvAYfGAEFBS2YdAfrD/A3uG8AkAy96R9C0mj8zjt
         9/aGmexu9Ix9ZebVEbiLPGKLXy4npCvls3b3d+LNtLh4jbN8hljcd4uaYOoTsFoZarTn
         FU6Yoje1Yy0NNSlYTsLXOTEEHRZyjfJbYl5JvOk7bmPtUcWcnZ32VEByiNqPse1fMsCw
         1bjRTa4uImZjnhbLsV7aUY0uq92shd6ObeYygXOvnXSZ1LP5UriXmhp/u5Ow6z/GQXZp
         V+qd2LTbpryKBp3jpuuJVH8eO5adVAbgqDbd2vR0gAo4PD/lXiAVjt6CNd2VC7Iw8SzR
         0YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744917792; x=1745522592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HS4woUAQCYhef9KEALqtHQI9LV6pq4hqus/RCUz0zkI=;
        b=Hc9oV+pvOCBPvqxfVxgBVDkHN3ePDIW0E6ytFHmuD1xOXS8MjvbCdSiO1phZH7mdws
         w7wbA51vnWsLxSaNLdh1ZmBjwULxxeIK69eNYg7kjA3VRfu85OGkkXEfJ7JBsuxQDLdl
         4VLO03eGzrvZirX48c7ylW84NqhPChDK9bfHncCvP7GCPNZ7JrzK6dNuzG0+7PDvYtLW
         ogAgQLGMJ8MqvrmUF1r+h/P9aVZ3V7q7WP0vQeh3O/12LtiRTJBIgQ77z0th5IgwLmaj
         NfqgVEOLvqQJb485NpdLl3dUcuiBV45NGV1Ek0WhIb4Fipoa1kwGC3UpN1JZj8Z16500
         B43g==
X-Gm-Message-State: AOJu0YzNHCPDm4ujA5Vcq3l+OTYB7FLngY7Urgi3AMbTq1Vatj8FioOf
	lRHXVfDA56NqOHK98YK/r7MBsAj9wMuwGJF5EqHCPX/BK75IKsC8
X-Gm-Gg: ASbGncuBGIfZ2MA9zBiZ847ThDC5iWgzEpsy1AyWlo9QUbtcxQVZRwjBsl9JfShvg7m
	s+ZGNCrfab7aHNaawAncVwLeLcoTmpijsaospAp8n29/mccx3z6bXY3IcXfZdLubd+xhUVxwgQM
	s6hXeO7vsmii2CU1hzLvLAnhDJexr/jFB1E66V3tzTAUSe/MVrwCR2xGA853DASzFlnDodJPg/D
	+Dwd+HxvoxSITkWw4Kp44Gfid0YNvjhK9qqpmDuflpAtneWqbc5Hvuo1buuvOh3KhqwaSwCDHeJ
	t3URmJxpvV+MxxUPRByx4UPKvFNBjNSbvG7DxIJ4CyAx
X-Google-Smtp-Source: AGHT+IFnZQ5oecbna7fus2zKpu3PWfFkwo+eTbl9GEdpNci7MIcJBrxW53hfE8r3d6oY6HOJmmTwcA==
X-Received: by 2002:a17:903:22d1:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22c5360739emr1806015ad.42.1744917791818;
        Thu, 17 Apr 2025 12:23:11 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eb4478sm3636055ad.115.2025.04.17.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 12:23:11 -0700 (PDT)
Date: Thu, 17 Apr 2025 12:23:10 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, toke@redhat.com, gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: Re: [PATCH net v2 0/5] net_sched: Adapt qdiscs for reentrant enqueue
 cases
Message-ID: <aAFVHqypw/snAOwu@pop-os.localdomain>
References: <20250416102427.3219655-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>

On Wed, Apr 16, 2025 at 07:24:22AM -0300, Victor Nogueira wrote:
> As described in Gerrard's report [1], there are cases where netem can
> make the qdisc enqueue callback reentrant. Some qdiscs (drr, hfsc, ets,
> qfq) break whenever the enqueue callback has reentrant behaviour.
> This series addresses these issues by adding extra checks that cater for
> these reentrant corner cases. This series has passed all relevant test
> cases in the TDC suite.
> 
> [1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/
> 

I am wondering why we need to enqueue the duplicate skb before enqueuing
the original skb in netem? IOW, why not just swap them?

Thanks

