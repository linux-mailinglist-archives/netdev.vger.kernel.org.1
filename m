Return-Path: <netdev+bounces-213055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F613B230D3
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD781896B31
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C02D5C76;
	Tue, 12 Aug 2025 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="HGDXmrfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3952F8BE7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021328; cv=none; b=O4Xtai3uDeVlsPyozRW5TG3kk2G71eDX8MxFaxsLjn213jDw2cRj4VAdUWPtrWbPxtQ9eLDqGB00IB1J7u5U+WRL+JOQJlwvAbO0QdgC6SB452i1X4cU2hq/1z77clqCGFAvvedH2lALnyvIZWRPDJD4Ot/+Hqkh1n3b7RgZYds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021328; c=relaxed/simple;
	bh=kWTi2SgUd0nsUJ+xu5akZ/Qy88KshZVAxEcizguu4O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VX+0+xQF67hI/DKSgiYFE2wPuPHdbnExMUlWdDATW02dk2R2fpqLJHoyU9JZLtH7m+PH6Pst06urhOqnT3eL2AyoChqdm0vhkF9IJWtqquakpj9zVh3q2c3S/AO1U5iTB9JySZ+gGmxzcTBS9zr71AqhUlr91SjrXTk9M5/MS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=HGDXmrfS; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-242d8dff9deso32432935ad.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1755021326; x=1755626126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFniR6OHeJpzq5CzpOsoDrSOVnI61AYAux8BFNCWE1k=;
        b=HGDXmrfS2amW9k1mX0QArY9VENrBecOCehI6DpW/A2Zcbi+tPFWfw+qLExTQoOng7E
         2zAVRnZn62JlE85yJOTnb73JGmdog61lE5orsIDAFGcqYzL8xeIpZ4RxGe3i6SsHweza
         Z5RW/A7+AFXz2EmvcXi/DQsJlnVfA+X2r/OXgm0sM2nPfVvsMKD1PP2WUaPzukKcbLvz
         /RFjqd0/OQld2tBfFRLCuxoyyGKChl2xkg818Ui1B9yqB9ihZ7Mguqznuz7RiqelsZCK
         oGz3xQs9dDr4c+QZB6B4JG+m5cDCvYdp+T3T75WvLy0YJYas59VTARKroBebBwa02lmr
         YjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021326; x=1755626126;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sFniR6OHeJpzq5CzpOsoDrSOVnI61AYAux8BFNCWE1k=;
        b=MX99esTMP77FcnQS8W12Xfj5VqsftAEZ1xvGFVkCFoser19F7voSf3xB9sS687PbpV
         YeQzsWF1AwHCDF1WhBLIYbhGSglNarmO0sOsgLsCXXvHgtotb4CvyYalo0a9RnwG3xIY
         kDS4vso0nNYV8pQwh72DWWgSzM+IY/XRB001o6mRZA3LYciZ8lYUNkWQSVD6M73wJO4b
         QiRmQV5aRCtmVEG08eYoGKb61CbPPhBKvx2wIAwMjd5ql8yqElP1AbM1RT77o8xyaCjk
         vRnK53K1B8DfFeqf/L+vAr6dMha18f2m9Sr6WIjIhViKnYesvClzw5qu2mOzP3MfYCxy
         nJ5g==
X-Forwarded-Encrypted: i=1; AJvYcCVlJ69u7rr1JGQc1yl5EBQyZcSDekEzP0qD9xZnzAwP0iyg/JpwwhblGXmwtsuGIBF0cNn78M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsidQ9woyt8qkKUDo5xO3t2hwtUAbak0puXFP+SEUvMjYiQvr/
	5oS4VsGBhQl96IEsBrh0z8lZEV+b8R+KF4MgVOwezqw0PH0C2KclIifFj72qDtlkGfk=
X-Gm-Gg: ASbGncuXvMIRLMUIU2d3sxxDxOB+gWCfXHX3yV+dsZkJhe0+hF+Y4KkRvWLVfRyUZaI
	WLeTqGfN8YeE6X6/XNo5zX3KmdZgNe4GBKCyrycjD33aHS3gChyVuHJxmh2xRR+zdFPqrizcXsX
	i8Mxm6fQmaQ4oKXlbOjVSAjubT4RrlbwPPUVPPMy7Ou3U3ipYdYAQuZVXXax6GJLBdd96zojH7s
	BuXekk2iGivxF339c3ODRRTaj8RKpiTBcwfiLXNjZ8JkldadVWA/4+JH7DLJrvJ7/Taq23/T/a4
	kYo/zVVRKgQFCZp/wupTCSh6zLiVw3ZR+vrCHAj9hC/l3A5TEXaVpgNt2speJFRw2EO2l6PNaX0
	0/Zgj2j5M6eLfFoWokoeT0x35ZxvKIU5fng89IXNFDrGDjY7+veI/l4i8py9yY41GZUPFL3cz
X-Google-Smtp-Source: AGHT+IGrcruxL8w5AP1FRZ8Qi0WJHmfwtLu4/b8EI7R/ZKX+1vBpTxr9Y6qv46OQyMfLzdTGsMzToA==
X-Received: by 2002:a17:902:d50b:b0:235:ed01:18cd with SMTP id d9443c01a7336-2430d21d8cdmr1308655ad.44.1755021326024;
        Tue, 12 Aug 2025 10:55:26 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8976a1csm308425625ad.78.2025.08.12.10.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:55:25 -0700 (PDT)
Date: Tue, 12 Aug 2025 10:55:23 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v2] selftests: drv-net: wait for carrier
Message-ID: <aJuACzIZcknUq6C8@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	willemb@google.com, petrm@nvidia.com,
	linux-kselftest@vger.kernel.org
References: <20250812142054.750282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812142054.750282-1-kuba@kernel.org>

On Tue, Aug 12, 2025 at 07:20:54AM -0700, Jakub Kicinski wrote:
> On fast machines the tests run in quick succession so even
> when tests clean up after themselves the carrier may need
> some time to come back.
> 
> Specifically in NIPA when ping.py runs right after netpoll_basic.py
> the first ping command fails.
> 
> Since the context manager callbacks are now common NetDrvEpEnv
> gets an ip link up call as well.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add an empty __del__
> v1: https://lore.kernel.org/20250808225741.1095702-1-kuba@kernel.org
> 
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +-
>  .../selftests/drivers/net/lib/py/env.py       | 41 +++++++++----------
>  tools/testing/selftests/net/lib/py/utils.py   | 18 ++++++++
>  3 files changed, 39 insertions(+), 22 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>

