Return-Path: <netdev+bounces-141714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6559BC18F
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3751F22B99
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 23:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B7E1FE0E5;
	Mon,  4 Nov 2024 23:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vMo30yro"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65C81D5CC2
	for <netdev@vger.kernel.org>; Mon,  4 Nov 2024 23:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763845; cv=none; b=HgkfzdfYo5Qn3EsDGyDhO2n0QijLbBOv8fB/TPJsNIDDwvGhnUjMeifEIb19v3TYYDtb2yMalPfYIAtS5F7SX04f3eUy0JQqFvf4UV9bPvsKs1ZrZ6cZJBJEibijXtSjKsu7C5Vt25Bon5y3iHpJIhA0MO2KhPnZ4wB+hxm6vIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763845; c=relaxed/simple;
	bh=SWw/bUm3U36lZL9LqPNs1Smne8M+vxXN8DRpjmhsjWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mv1/5IwkwvvdDIxHn4pV56BYQNufQNz8bl652KaIHOAdFvVLe/+hLTV+ngODw3LbuHTKh0TTkrpXrSAuHg+0w9F/Cf7LMnEcHXWHwYV0/RJxlqK9eP2+HrCb6Dcvq7h5PAEp820IrgFSQ9UNuhRejb8BUbs2hdAgRGdy7Z6Gk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vMo30yro; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7206304f93aso4594821b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 15:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730763843; x=1731368643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cLcYMUnBRWzZFj/LVt8ipuQ3xIo4NMpvPvL21fi6cgU=;
        b=vMo30yror5SALiYRLyWeP5DupiJyqGVdGZnOqKAApa5NkbQzHbbjMdiCXOKa2QNZTh
         QDpH9KYCSGuk0whbALSR6O3o+jZw9KM7IGVW08jEq26coeKLdC2kwM8L4trV4bhuqzIa
         fcASmAjoHoUtNAQLoWGbC8tHUBd8Qc9x80O7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730763843; x=1731368643;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLcYMUnBRWzZFj/LVt8ipuQ3xIo4NMpvPvL21fi6cgU=;
        b=hQdE+V7Zxnurip1hl6f3wydgMvlEkK6uFW8pNLV1lylgc1PmGi7FnCOmFk/6ZO5tVP
         w8DkQa458tQVG/QsGmnXS2btF0OyybcJrO/mytciXIbs30fIDqlqoko02QmvTIXdsNeu
         KRyWBaLuhXjsf/XAZjm2ZH9pfWSwys/PuxFtnPoMTTqiFOduReQh+TcANc5Csln3jL/N
         A//WWNT2P9/zinm/ONT7cMLk4nuePuFPKxSWaTdaM3dJHqXVh5stZi7ExwAae5UuoT04
         yyx3oPfr4J8KgJbDL1ambzWQwMKiJYXl17+j4jdlCx5necPd/qNrf9CGOSRzqm/Z2ZT/
         XuGw==
X-Gm-Message-State: AOJu0Yzma03JpAkzNN3FHK53fKNrYubuhrIQgFrPmc8zRTXzn/AgZ9mg
	tUrxv3PpPLjX3iWT6pAcY5b+qQXWdosR6djbuKy9/xgObDpbIQGiWeIptiRHSpk=
X-Google-Smtp-Source: AGHT+IEGtFKolQhFGH05In7ielsZJ18Moa0FaaFb1UggosOAGgKMTRSbOdnL36KtC0el2mXqC0AN+g==
X-Received: by 2002:a05:6a00:22c5:b0:71e:4655:59ce with SMTP id d2e1a72fcca58-720c967e609mr22973839b3a.0.1730763842620;
        Mon, 04 Nov 2024 15:44:02 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc313502sm8231067b3a.182.2024.11.04.15.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 15:44:02 -0800 (PST)
Date: Mon, 4 Nov 2024 15:43:59 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 02/12] selftests: ncdevmem: Separate out
 dmabuf provider
Message-ID: <ZylcPyrfG8ATZYBo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-3-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-3-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:20AM -0800, Stanislav Fomichev wrote:
> So we can plug the other ones in the future if needed.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  tools/testing/selftests/net/ncdevmem.c | 203 +++++++++++++++----------
>  1 file changed, 119 insertions(+), 84 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

