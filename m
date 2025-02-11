Return-Path: <netdev+bounces-165274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68398A315EA
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 20:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 633AE7A180C
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454091E5B6D;
	Tue, 11 Feb 2025 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="db1f3CP4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECAC260A28
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303359; cv=none; b=oRMjwifQZO+WVGLqi8OLMYrHENYs0bukA7sRwLhPNPhwBNBgoOxFnPrrt1RgUB/0NAVZ0u1BXUzoOX+HEl67E2BWiJFef59oh3CvX4C//zlbetU34oh7674VCNDfgpqPw3qycS1sV4MoHU6pPcggSBZkg0ee0MVY9tmq9zgXXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303359; c=relaxed/simple;
	bh=s7NVXSVJC7penh2CLto1//eL+1PRqkwMLEsQSDpt8+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbwaDLEsAgMyLqFW6h7qZhiWK+nLEepw0F6IgV/xqM/0ZbP6sysYUASAjj34YnbcSOAS13iUOpIebP5BYrqotVKn9cci2C8zavjDFv9A8gFJ1W4f2VePNTLKTbzrCnKbz8OtYZao2woqjwZkNbW0YC7z9wKVAjb2jltbtaxzgpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=db1f3CP4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21f5660c2fdso85760675ad.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 11:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739303357; x=1739908157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwkLROQpNJJVBhe+NGJ4m/fDtdeo/U2RKsuOJgTzB5U=;
        b=db1f3CP414adIXONZQO9Cla5GHi38PvndXu4Rjh5XZ3M692lWpkgCOHEyoVSaia+wD
         Zd1MeEG6LRU3JTj73RIlgTiZjzycRIyWASu0+xT5IzoFaZZiZMFchJ0xWpDG0IArGkmJ
         E71v8D9mlKtWAYMq4K1ZhEjTT8nmDf8mktwHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739303357; x=1739908157;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pwkLROQpNJJVBhe+NGJ4m/fDtdeo/U2RKsuOJgTzB5U=;
        b=hUByjqnUa/2vmBuwlYdPIT6IdUu2AwDOTGqTCPRd2JvefYMussXamCzyJm9C4nKOnv
         QNsj1K45CtDMWDaGOwutWzwajCRnUwIp4Zg1PG5xghy2HrBcV/01fbSfIyUo8FxNVRoK
         3x7GRH4w3Gr4rAXaP4MwXsluIMwMchwQ6XHt+d13TGKwRDza6qkhYPI/OHIsptoQHygD
         IFBBRkE6ZneeYHmbzTr3+rrlwSB2IKGZfpYw7c781Njsc+2kTb2qboPInkUXSFTk9TvM
         FkYNTuxdtMi84heHHJ40fS9dlm8wA0xgSRzjYklKxQrJn9yM0g0CqIN/641h8NRtbZpw
         lIMw==
X-Forwarded-Encrypted: i=1; AJvYcCXXEasYd7SiEe5HtZmSsHYN5d0GBo6wO3NnGjBJCCfPD+1HfXTdm5PNeCAmXmnpAXZn5RMmFq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEqJnyfEcD0R6i3zN68DmzkT7ncsKVCSr4/gytoehkHGCqZJts
	0Wua2Zeu5tlJS15x+JOYRIwMkpXQtOXuJvIq8lr7pVqONQfIwmJdRXJsMGdyajo=
X-Gm-Gg: ASbGnct0KOVndoczT25GRMiZucVBcNf9ardwfm3/IGKzN12kmmIZfIUILVKJlRjI5sT
	EiBjGb5m/O5WAxichJZ/5PZxiessA++arur3qYABWqQ71YB8ntSrDke5BsLwpZyScAIbFxHwBr9
	2ckrH7mWC5Q1rTHxRZdp4WLBOOVbgUq6yMv0EajqYNN+xfS60ZTTq+RQu6dl9lxkAkAPgZN7Wp+
	aNPwntuJRV8axDisbDh2OSyqPtBJvOpI600BqMgSXc/4kJY/fJLJQuXVY8HhQUcBfeHzZNF1zmL
	df3/CH836bOWplQqIIHMXV8wL1+2uVmAQ9/vb08mlHyhbIaC+22gtQH2eA==
X-Google-Smtp-Source: AGHT+IFAZm1SodjyhE3yXt20E728QpsRv6/CwCnhQp76zKhTJB4HXoWp0W/4n/66mnQu1qhtikUfzQ==
X-Received: by 2002:a17:903:32cb:b0:21c:17b2:d345 with SMTP id d9443c01a7336-220bbb11376mr7568995ad.3.1739303356857;
        Tue, 11 Feb 2025 11:49:16 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368aac7fsm101133015ad.221.2025.02.11.11.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 11:49:16 -0800 (PST)
Date: Tue, 11 Feb 2025 11:49:13 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	horms@kernel.org
Subject: Re: [PATCH net-next 3/5] eth: fbnic: report software Rx queue stats
Message-ID: <Z6upuZVox2MbeX9X@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	alexanderduyck@fb.com, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
References: <20250211181356.580800-1-kuba@kernel.org>
 <20250211181356.580800-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211181356.580800-4-kuba@kernel.org>

On Tue, Feb 11, 2025 at 10:13:54AM -0800, Jakub Kicinski wrote:
> Gather and report software Rx queue stats - checksum stats
> and allocation failures.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  5 +++
>  .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 12 +++++-
>  drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 43 +++++++++++++++----
>  3 files changed, 51 insertions(+), 9 deletions(-)

Acked-by: Joe Damato <jdamato@fastly.com>

