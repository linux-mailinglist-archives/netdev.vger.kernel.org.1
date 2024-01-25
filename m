Return-Path: <netdev+bounces-65795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F08383BC5A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E7B1F2A806
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 08:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ED71B95E;
	Thu, 25 Jan 2024 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HVOLBNAH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E2A1BC23
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706172747; cv=none; b=CmHv9w6OFjPSm+W1QMpTkzOj0MReKjj9qhS6isZKKtx8Z6GJG+wcK/D8yXvKTaM9J+wehe5nu7+3+FfqSroJZNPxk1jyggURGIQFxFbOOns8Aih6a+mACuzpYb0c4PqWLq2STj9jWugjZPKZdjFWYFibg6LYsKkAXtWa/ZzeW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706172747; c=relaxed/simple;
	bh=k2p6vgQQ/RAXPDiRE/JTyB/ah5UQEk6s51M/bFsBvoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1uwTbEDwARIWpr8LFf6kVaj+HMkiW0n/WBmkq1YiWv8tXEjspOVwPmUFZjQZIzP6YPwZWRsis3IpXnPv/AoFW2lHsuuC5esAGnuWRDFyQPznFJMu4FwexmuC7N9Jx1Q6bc0Xd8hgIf0AbpaildvIFi/3APGsVPoQFq72x5/dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HVOLBNAH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706172743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RIvhVbbUBp0xDkqN9EFINDsqzRK2vtIqnaFyFbvxcz4=;
	b=HVOLBNAHyoXoJzDGW8jypv8cQloWNRhsST1igPxSCRwSgVaXKIKTk9eu7j1CoCkXTD/1Rg
	1U7UFXq9WxUJ3TnEnoZ2pKLzxzrtuC//tNmfF8Ti9O+Pv4PQ+uKNFjphsnorK7EtmsAwBl
	X/abS+B9gUCjc1aof+jlAH2KmV1MjRE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-ovp_RUR7PhmRZfnpYej54w-1; Thu, 25 Jan 2024 03:52:21 -0500
X-MC-Unique: ovp_RUR7PhmRZfnpYej54w-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-683699fede9so85715946d6.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706172741; x=1706777541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RIvhVbbUBp0xDkqN9EFINDsqzRK2vtIqnaFyFbvxcz4=;
        b=F5SGlsl/WnQAr48LqoSmEkEVS0ol05pz+zoaOfT/Gq4s40Oh8jmfzi/On/8CIpWZzZ
         mZb140rfwtJ2Eqd0w+/cXstT2uhoFlKdZn5crXLwfOVjrs/N+G5ObFwjHWiKEoXZZzW9
         a9MezfCGl0WPHiMqT6z/tUoi8tXXW9aKeoYkpuTQ7Fo74no3tfFIU7FDUjAWr0pS8spY
         UNGuB44YujpkxlmeNIUpNwlcfLdt8Wj9qxGTlX0SoYTD3K8vw8TlWMC8dQ2qRfiH9Csv
         cCA9e9Ffjnt/5ind1NVwBRuINDJ1LCNXjvqnHlCjsq1hl4IOnA/2uLf5E9S/z0BAL8RZ
         kolw==
X-Gm-Message-State: AOJu0YzliVyLDKKGr3v085p7orH2dU8n7FnXoiITAheFPDus4k/A5POy
	lB+hAWYG7l57roq++TaadGCEvQb5O4Udzl5d9NjktrqNxucPSJmoB/IxonQsfn3qEQDWVE9r4d6
	6q9lBhydGRl6bUHxjOexU+d1dFml6FbNJCUBsdJ4DDsh6urfSUvXIfg==
X-Received: by 2002:a05:6214:2b09:b0:685:3444:4ee with SMTP id jx9-20020a0562142b0900b00685344404eemr686909qvb.89.1706172741538;
        Thu, 25 Jan 2024 00:52:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHg3Tn6pQa0lndCQs5ycOlaqdnrfYc2D/GxlqryQE6ZGT5VDCr7Pq3ggUwd1eeQFdOE1BBzgg==
X-Received: by 2002:a05:6214:2b09:b0:685:3444:4ee with SMTP id jx9-20020a0562142b0900b00685344404eemr686900qvb.89.1706172741246;
        Thu, 25 Jan 2024 00:52:21 -0800 (PST)
Received: from localhost ([81.56.90.2])
        by smtp.gmail.com with ESMTPSA id i3-20020ad44ba3000000b0068198012890sm5243372qvw.66.2024.01.25.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 00:52:20 -0800 (PST)
Date: Thu, 25 Jan 2024 09:52:18 +0100
From: Davide Caratti <dcaratti@redhat.com>
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, shuah@kernel.org, kuba@kernel.org,
	vladimir.oltean@nxp.com, edumazet@google.com, pabeni@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/5] selftests: tc-testing: misc changes for
 tdc
Message-ID: <ZbIhQiUmk5FbyCc9@dcaratti.users.ipa.redhat.com>
References: <20240124181933.75724-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124181933.75724-1-pctammela@mojatatu.com>

On Wed, Jan 24, 2024 at 03:19:28PM -0300, Pedro Tammela wrote:
> Patches 1 and 3 are fixes for tdc that were discovered when running it
> using defconfig + tc-testing config and against the latest iproute2.
> 
> Patch 2 improves the taprio tests.
> 
> Patch 4 enables all tdc tests.
> 
> Patch 5 fixes the return code of tdc for when a test fails
> setup/teardown.
> 
> v1->v2: Suggestions by Davide
>

for the series,

Reviewed-by: Davide Caratti <dcaratti@redhat.com> 

thanks!
-- 
davide


