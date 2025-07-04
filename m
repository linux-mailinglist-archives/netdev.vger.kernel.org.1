Return-Path: <netdev+bounces-203972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F37AF86DB
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F9611BC0D1E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C834EEB2;
	Fri,  4 Jul 2025 04:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndYbBfaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259E2F2E
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751604347; cv=none; b=hUw6afJ4sXNks7IANxgkibs3RUsJxWHhHz3NOcEvphpiryShFvCme3LRtbHIm9Vpg85efknRqfafXb+A5GOd2cn+KUuuRmXvrPvzlsIbdwZjtKOcqtCsNsHhCuNEKlp898cHlEe5hhCqcqO+VANkXwei1wtXk93XGBxHDiZoqco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751604347; c=relaxed/simple;
	bh=FfoVN7FCNaEO/gPtHkF9uQuY8Zl30okDPm4yAuAogkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTyWnc0YDxo8rnMWbCYpWi6J8qqHi+nwNNlJbAbPCvyUmE5sP6a9c9AqkYCGJFROgiQUcTZkvNNIDSHfqkhCmOlMesxWfx6IPpZCuCXC9qhbJwFhbNef2UuA2xJ5L2x2NjloqL8qpSy7iIvTVe65C3suTdVOGN95IHiTFIooZG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndYbBfaS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23633a6ac50so8530925ad.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 21:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751604345; x=1752209145; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHJjuPFNQ4TVRvzE8ulEEf+SrMTlIlSSZLuR+wTQWjQ=;
        b=ndYbBfaS1PxV2T9YjZd/tB87BjbthTX+5QJTanMADscXcJuX4pRuOlQC4PLgfAimNQ
         f3o1cBg6lpO8x29n0ugDeqHonTNfZsAKEc7Pt39aLSPOltjP15Ts7sluu7UJirQt66vC
         652cL1z2MoW7qAO6iF84Mp+Q9Jzq9labLGfs2/bG746/80GNjGltca5FGSRNK4j2dD0v
         9rNv6Vjn3kRNd1Qa8AQwxPOI617NUN/xkmXW22dKaXWbYSzQDk42YUpIkK7nE5oWSWcB
         cAauuxjdOeVFWW231nPCYcWafDj3u7bpgcsukMH2xgkIJZ0JuXA6zvYt8/VUapfcDqiC
         5Mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751604345; x=1752209145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHJjuPFNQ4TVRvzE8ulEEf+SrMTlIlSSZLuR+wTQWjQ=;
        b=S/HUVT/B+6npkmI3PXrwjdVDl6fOFez0etwtJbSX+FFd3u4vkN1YClW8nzD6rEyjA5
         ulYphpj6Wy4a9kekVJmh0BqUIhAYdxU2EKPsOSNuvM0AQT0uM8U4SBKnDmIYQsy1sJTG
         xahnqSJX5fzlJAJnPoSFWvAc5E8nbeimHJxtFLygbXIxvgK2rwxJD1eH8iWvlUnQOl9B
         wjUn4KywClmMaXG8k+DuZIKyopsYNHQdeDx8chCpL1TMz+shxylm4KQhre5bbDwBMbFq
         7q8+LCbWqXrWPXiAmo9BPjlHnDjO4UTPie673RulWE0pqYU9E3KXPB0aRKl0Hbbj76Is
         jHkA==
X-Forwarded-Encrypted: i=1; AJvYcCXqBAOnwqe7q+ewQVKVDEOialISef55lmv72af2KLTJJx+YWbkyxUzaSQvwiTILd4Bcq1/2Ryg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJaZCwZG1kXiM6mw5Nczw/SGpbeDyWdkv+cIuHnswUUHZa7LKx
	bDXK5KI7/4bqAPVHdosRlSURGZVzCEtkrYtlnMkfVNbwOJLngw+u/gVZ
X-Gm-Gg: ASbGncupM7aYIpWuJKmurtx+zlXu0FgYjKqIdcPRio1K7ulbOwlUqJVsXGXEm8jN7pi
	K1abReNhuwgZ4DXvHLAuZqR5smWZTyikVzBIDJ0e8kENaVeC2n8twrw6P8js3afEsGLcCOOhK8d
	Lx3F6sUCJEyxksX6JdvsHJvQBpxecO3CudI3Ae8Njeu9Sbh7rKjILz3PgJ38trM23TSBVHyDJy/
	s1h1+P1UM+Y/Us/bfowrdaaz1nsp6LcyACUEr8NkafAxD2ytVRuPpckCHaVjjvoMEBbVMZ3jTIs
	zyK2k2+XvZ8BpyYBAMetLq1xhEVdPBXWRvle/eIyivIm+RYArsbcvM4WmNm5I4u6Eejq
X-Google-Smtp-Source: AGHT+IESOxYWJi7ym5tUTuEgVl5kLzdqwcXBciyDF2yrOKfDBGYpBy78ryoh/AJdIAIhLbOIBvsVeA==
X-Received: by 2002:a17:902:d547:b0:235:5a9:976f with SMTP id d9443c01a7336-23c860d536bmr21059325ad.24.1751604345347;
        Thu, 03 Jul 2025 21:45:45 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:1aeb:7d0c:33d1:51f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c84351a5esm10434065ad.55.2025.07.03.21.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 21:45:44 -0700 (PDT)
Date: Thu, 3 Jul 2025 21:45:44 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v2] net/sched: sch_qfq: Fix null-deref in agg_dequeue
Message-ID: <aGdceCwEZ/cwzKq9@pop-os.localdomain>
References: <2025070255-overdress-relight-21bf@gregkh>
 <20250702083001.10803-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702083001.10803-1-xmei5@asu.edu>

On Wed, Jul 02, 2025 at 01:30:01AM -0700, Xiang Mei wrote:
>  include/net/sch_generic.h | 24 ++++++++++++++++++++++++
>  net/sched/sch_api.c       | 10 ----------
>  net/sched/sch_hfsc.c      | 16 ----------------
>  net/sched/sch_qfq.c       |  2 +-
>  4 files changed, 25 insertions(+), 27 deletions(-)

Looks like you missed the declaration of qdisc_warn_nonwc()?

$ git grep qdisc_warn_nonwc -- include/
include/net/pkt_sched.h:void qdisc_warn_nonwc(const char *txt, struct Qdisc *qdisc);

I suggest moving both inlined functions to include/net/pkt_sched.h.
Sorry for not noticing this earlier.

Thanks!

