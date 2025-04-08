Return-Path: <netdev+bounces-180030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAE4A7F2AD
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B5B16F3D3
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07B2262A6;
	Tue,  8 Apr 2025 02:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SXCF9r1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9BDDD3
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079480; cv=none; b=AJhsF34EoLCS7dFI0FVCthQO2Z8Rbo7gRCxTgvyjpORBaLC2VSmaL9n/SSiMTgu2ILmU5+21C3WJUwFbSdQ8NB3qfzzrFCqlfoOp2du18ZrKihloA39v1tRRVc46fSbCF8wd0BbER2aYtYxUiI9hoobZdZoHO6QHtzEumhVUiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079480; c=relaxed/simple;
	bh=jsmJQwy0Z1C1LBAwO/FD1pvbESA9uRz+FYmlFLMqtXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1G8FrjgxJIjyxNFYi8cBvQG9+dIEJbjb9EZAyac2lMzcGPgwxpHtMAg3u/0KJ5+m5K8+0xVdVeCN0gQ98LLYAS7wM+tHItkO+unKyJb91mYnepAGrfi6jkqndCBM+oFtsoXJMhhRTuZ/RmkYhLdubhFNI2kfgXVynGcFvaAi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SXCF9r1m; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-af51e820336so4712899a12.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744079478; x=1744684278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qa1TnvGYMauUMWyZcz7/o2Egu7BWLDt3zJ0t+wJXCTM=;
        b=SXCF9r1m3R7ShEEjFArR27QZKjhrjlH5qB7MeRIkTEbq4luUW//cScxBVp883mCpUk
         h8HC4v2qOfdLf0+RGKu/+C4mnErU8rsdyeMO4UHpxj/MBzTDsU6kNbOGCS763gG0v+dV
         54BXEZ+9sJJEP+i1eBzfHXVvoNmuZnaOziTvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079478; x=1744684278;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qa1TnvGYMauUMWyZcz7/o2Egu7BWLDt3zJ0t+wJXCTM=;
        b=oKg2DMajm5+TCKPTLqpC/GyyhLQ+Q+qiHKRJMXVo/ck7Yj/s7mc6r+kFgDroHSO4ae
         5owMMlREU8j90NKnOSJgRDmlYoBI1MogO2sw550bgVPGX1LEMD7ZhRtlyt2E1rMb3qYN
         qShTlV8zjBQA5hbGw8aJwr2UidTyx6AhteRLVrrIbVxy9S9z0RNV0H6ckpxRzEtA/klb
         osWGoR+OLUMyW9qXJw5vY5/6VqBWHmV94JfL9wTwtuSovRAkKQ0PcLzGpQFeA6aiIIR2
         ZZ9H1KNBM4z99pOj9rW+lj2FmlLzcjUpyW0gc/7RBwAIP7dUPPYoaYZkzfW5VUSNk71S
         mwHw==
X-Forwarded-Encrypted: i=1; AJvYcCUVBb+gTOK/ZDlGtnUeAItTG8iFX6FU4GsUGDrRigfdKO2mmAC1sYOoJ7vjzU4dziQwv5RA2bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJKjc+UDLCIxrYpfODrc4KHjr5/ec+yRlZBrFvldy7HUJZExST
	MsFWcN6k6M0lqgnX6k8X59jAIvix+ml7iayDD7ZNAZm278G58R9/iW1ld/ValP4=
X-Gm-Gg: ASbGncug7I3zPwFFk9MD2KKUbpDD1PI2GFMg7eBZXAsZLeYhoAuSMeUWb1vOHy9gv2E
	oN1Us+4uAcxePvE7w40z4u2t4uMg4PbU5DZxdns27mBCuq2v7Vj3tCsEKaVVysk8M0vSZWL5XxY
	/ZrHLmoAL15mkhFGp1wSwi0VsED3gpcSciFF+d8PBViR2IZiYQrjEmgk6u4+LVkTA+KUO1YwMPc
	odSnK5CoaW1aWRTI5sV7aAzWprwesq1YDfTBbLCe77HJtEoj4zHDIk4An9jlWx+3Fy6Btdprld4
	T0SDwHVow6mtcl0MFVJOk55MbDlFLOleHtP5T7JhzutCdyfblCdt5S5qS4SYtJ57Ps0Z8HgEFe6
	w6+B8heaWBSI7WTP1c56p3w==
X-Google-Smtp-Source: AGHT+IEvpMlryK5DgzXlx0enILMXFGvA3Yfw0DlR5M2iKfMsTPXz70uGgd23bNNQ6iY/yyzyr+5baA==
X-Received: by 2002:a17:903:1aac:b0:224:10a2:cad5 with SMTP id d9443c01a7336-22a954f9e54mr180018785ad.10.1744079478598;
        Mon, 07 Apr 2025 19:31:18 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297865dfb4sm88235185ad.152.2025.04.07.19.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:31:18 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:31:15 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 6/8] netdev: depend on netdev->lock for xdp
 features
Message-ID: <Z_SKcxXnCzQc2riN@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-7-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-7-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:15PM -0700, Jakub Kicinski wrote:
> Writes to XDP features are now protected by netdev->lock.
> Other things we report are based on ops which don't change
> once device has been registered. It is safe to stop taking
> rtnl_lock, and depend on netdev->lock instead.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

