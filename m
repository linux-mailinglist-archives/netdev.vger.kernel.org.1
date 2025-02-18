Return-Path: <netdev+bounces-167527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF18A3AAD1
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 22:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32BC3A5FB6
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 21:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E01C7001;
	Tue, 18 Feb 2025 21:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pkz2TP2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185961C3BE7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 21:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913928; cv=none; b=tmndfmdwnYMnG8pQ3IceUyTEtwKEZdVTtJB1b+fRxfcWxDY41CLMGjRUb919buHfTLjBgWcNVUSA0XG3sRjQe997zblLn4wJhobFSa0lFRcfIm+HARpFb65Krdv3fmiujR4i+OFuR8f10OonF3L2cZfXN20oRdorgi5g94Np2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913928; c=relaxed/simple;
	bh=jSt9WNk4rtGV8CktviYl0/VLAqk7GcQr+B576kTE+pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ltms+lCmVcpy40Z8AlHxNpjn5pkk1DK5/7o20HRkkyDiakYJzXDJfsFlH/UHvPEI5vUjFKdAMpchZ6YjLIXZGQgtsBVbA2B1CYpWElMKqElgwBM79JqWQC+bsljCdRq8uHeEES6NGdEmETxuTnPgdlFXJi4989MWGPQUnwfL+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pkz2TP2w; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471b5372730so76392191cf.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 13:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739913926; x=1740518726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y+9t7rVgCbD9nSI/KEETzPkt/9TwQ5fwOiYnpEErqNs=;
        b=pkz2TP2wJu6I4D9pgRfqUG4IZ9wldqERSaMJhaL+SY19QIPHiMZzxoIfH4aJNcFNeb
         30oV9CRme/IvaIAb1/6VvAn6QmYpNTiRsYPKia8J0y4bPJolkED0NVbwwEh5k771OUSn
         TrulUBrXLfMatCh5q5XjLqMQKYqO0f0Nx4Yy4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739913926; x=1740518726;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y+9t7rVgCbD9nSI/KEETzPkt/9TwQ5fwOiYnpEErqNs=;
        b=TteSL/5nM0HmZRkzXfSYdavjPcFiqgLETfNU7bKCdFrcVTZCkAdopOwmMjyTLU161W
         o1/3m57z1ipWzazhslSC7UfQoR637FUJTik2Ur0CMSPqzmS5zM7athfyr/VgvZIoaVTo
         EsMDKCkUf/Qt/904M89dKzn1kfPafkYHp60EMN/I/vFGWOIqGgIV+Ca8xM37N6qwm6I4
         GikX1bdMTaW38Jh3Jr8XLOE4v1r4EHEwIkrOy65b/AuBf0jGKxKSik5JqpFFydHzfHjz
         R1dsHcL6awrENypH239Qbt/CPAXsPJeumumAEuUzqEgZGRJpMWLBg+gzFcV5TdyDAPWG
         tk4w==
X-Forwarded-Encrypted: i=1; AJvYcCVTDfIvsWPb0NdmL/vDXb4sV01U+bvgU9uYZYa+CdfXVtRcRj1GRYeQBfDYlm5t07DUSQJCrwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9eLe1vaqzw/qCd9ioTh2nYRTcpfQiCi/+1mraOA0KHsLWGqKg
	A86E5NcEMZRTtRrVEtxhoEkpMyLsbvVyi8H8QhSUn3ukrKlKUJ9EALT14dX4UvI=
X-Gm-Gg: ASbGnctw3BhTQ4s2fm+hSMtjW7iejrAh30KthTQon8Ht4c1EbHXxQEvif3WUnXuqQ9c
	+mxKrGWlhVokJmLzqVbqebgizkKLHeGWlsLFOPH2q/AdrYYMsK3kHQe2syxLrBvCjUGv7vBhHDW
	ZNvGxW9+mKEQEXt/9oecLhCynvaaNZaZS8WxyaxhpKyUqWNox54r/+EEGgtoqW9R3CQzWb9QXh4
	v5+2+K0FYDaAbbeAOuoQ+s8yuwqlJ0GGvcR0Fy1QbLaFzqWFvydEp4EpO0awb2hL8eZdM/OwFxZ
	3luBvl10NWvhn8npKpsncRZLHDVGpTwGyo3uOXrnhowSqa5kkZVnrQ==
X-Google-Smtp-Source: AGHT+IFZsZHRHegvREvuU36ot/Obqke2rAXx/n/WvwuDVNexdP3bGDR5Wvt13iEorQpNuCjH+51dyA==
X-Received: by 2002:ac8:5a82:0:b0:467:70ce:75f5 with SMTP id d75a77b69052e-471dbe7b209mr225638291cf.37.1739913925908;
        Tue, 18 Feb 2025 13:25:25 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47209a1b133sm1135101cf.70.2025.02.18.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 13:25:25 -0800 (PST)
Date: Tue, 18 Feb 2025 16:25:23 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 3/4] selftests: drv-net: improve the use of ksft
 helpers in XSK queue test
Message-ID: <Z7T6w9aP5J3yOv2a@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218195048.74692-4-kuba@kernel.org>

On Tue, Feb 18, 2025 at 11:50:47AM -0800, Jakub Kicinski wrote:
> Avoid exceptions when xsk attr is not present, and add a proper ksft
> helper for "not in" condition.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/queues.py | 9 +++++----
>  tools/testing/selftests/net/lib/py/ksft.py    | 5 +++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

