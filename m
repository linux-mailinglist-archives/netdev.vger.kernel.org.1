Return-Path: <netdev+bounces-172528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B54A5529E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 18:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF21416BA82
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0E72566F3;
	Thu,  6 Mar 2025 17:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="skxYhq4n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9402144BF
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 17:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281171; cv=none; b=AR3l3T+lmNECpwt9RNjl7uwc7WZN/DWCe4Xp7/9+J6TN21yp1DcoYAToXDD2iG1kCiBGu26AXWnrBYncbxUcRR7Jk9ci+8r9V9AJCkq/Xto1uZ5hA+3m2mqsO7MU/LyUa0uuwYMpIfm2hErjn+Y0JwOP1qcUt1qcrPGzWxIKAlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281171; c=relaxed/simple;
	bh=ihuLY57CsNNTTCf9O2Qd6qMr3LUOYAbzvsUNIbqpUGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDHP/MOInVff0GAu0VMlWj2jJFYvdA0K+v/DMhMVGoKUL8r1THRPj1fMec193iUGR3vNozjz34W6bsRp+tO+JGtr5x3XVyvT+tOku3indNgkPfYPngrBIV2dVcg+Ul/mJaMrRUxVl2IdCxCexs0XOhJOpCov3c7g0vPDHRP0vQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=skxYhq4n; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2234e5347e2so18001615ad.1
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 09:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741281168; x=1741885968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3EBUy7egQmEWW9gOHCb2/+qv5vNa+31AOSWKZW9tBcA=;
        b=skxYhq4nQ0TMmYV19MeZBt+ufhXPtcLFdehUpX3SbO9i6eZdWz6nUPcRbjmUpENbHC
         hilnE7Ca4eE2XkeyyWpkGDLPMDy5dYKi/Dbtz3lnketJDs5/HpErawL1jFaVAErYGdcy
         TRR1t02+jyfbAA7enRkKtJtQbA0BJM3UPDWJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281168; x=1741885968;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EBUy7egQmEWW9gOHCb2/+qv5vNa+31AOSWKZW9tBcA=;
        b=TZVdwkzMTHnMtmIb6mgfOo5LE9H0vW7emcjYU2nhKGBFrogRVbARHDuGjqOW4XeC9H
         I9UGbvkk8piV/a1fW6+mjmnu0UjG5xASO2IL5FDWyD6t74P/MAJBtSDS/+2RS5Is2xfF
         ogNH1SrxtaEDDtBEiFG+0rDe+8marMT11RAnOWobFB9oO1YlD9XCl07yNaDTk19kVSmb
         l+9j1ASNzR+/rnHZRYjC2MtirufNP/yAv9wzEYZOmbER+hHCnoY5pozMZNqrgt9OdxeR
         DYpRjnOVTZhz+VnLrNhzfLUXdkgtp9Lpz57v+BsPKcwhnOf2KYvzURCHQvZMd3wY0dfv
         ZM8A==
X-Forwarded-Encrypted: i=1; AJvYcCVk7Zu4xRai6Sj+URlyTdPpG6iUz3gUAk0eWTkZScA8G3FK4+xiImTWJ9ghwvMNvc87WKeByJA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRg6nGv7FF7tq15u4D1MaIcqIuuvgBtKaSqN2IwM9aUZyjldxU
	hADieQJjQdrXU0ZUgzzebnZHxdJJk/R03/xTpyPl0cbxgoHCutRcQO3/aU3R7Mo=
X-Gm-Gg: ASbGncu1p2cDERAmQmrP4O/XqI+lpjLSH+G0N315IccyTOsFQKUFRMiJ60w0F1BHxtC
	ddKCaSfMY3PyKm/qIOCy0mL1nlZEh/SxclPYqHzUjXuqiL93AFUx+YYCX2XR6m3tLWrrNzO4qNc
	myePXdE9mnsg/2Edk9SY4d49O2wY7td8SGNIs74h7TiuSsT+QsRT9VaSNT+WQOc5Cvh9An6gmXB
	5B26u4RiO+4gCrWCrGRPVpmDPTAO6INor2yWrfvncNGHABJl0xOmkxldxzUR+LBYlZ7VAbX8UD8
	7b+EuHh/G86icjzCWJsOqtK6IEaZrogXXn3dD/r92PwiZ/REi+2XYxfc43tVynXhP/5B+31PXAq
	CDpBS2AJPGsw=
X-Google-Smtp-Source: AGHT+IGZ0zLdFTGbuuabdwXm0dgzcP3mCy5SBlvQmFh0yDjUl0UoWFo64Dbo/9sIl+NKPOgErYqZyg==
X-Received: by 2002:a17:902:db10:b0:215:acb3:3786 with SMTP id d9443c01a7336-2242888dec9mr477095ad.19.1741281168548;
        Thu, 06 Mar 2025 09:12:48 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af281096d59sm1491843a12.31.2025.03.06.09.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 09:12:48 -0800 (PST)
Date: Thu, 6 Mar 2025 09:12:45 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	alexanderduyck@fb.com
Subject: Re: [PATCH net-next 1/3] eth: fbnic: link NAPIs to page pools
Message-ID: <Z8nXjejWjiNlDVFh@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, alexanderduyck@fb.com
References: <20250306145150.1757263-1-kuba@kernel.org>
 <20250306145150.1757263-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306145150.1757263-2-kuba@kernel.org>

On Thu, Mar 06, 2025 at 06:51:48AM -0800, Jakub Kicinski wrote:
> The lifetime of page pools is tied to NAPI instances,
> and they are destroyed before NAPI is deleted.
> It's safe to link them up.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Acked-by: Joe Damato <jdamato@fastly.com>

