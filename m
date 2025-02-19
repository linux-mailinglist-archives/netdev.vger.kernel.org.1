Return-Path: <netdev+bounces-167840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC03A3C7CA
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 19:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C18F18925BC
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 18:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AEA214203;
	Wed, 19 Feb 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="UcjqLm9M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756DC1B6CF5
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739990450; cv=none; b=am/Ca3fH69fB+44eX9rWntFQQerS4+qkRCNByXev8qwiGZQfXPIpRiZLwz9Ox/dGXPGAK0l2GeEftOT2r+adUYbEswx12dDQBLTHPyk0dLMFAyjg/AHb7/ZMqQ+y1oK3UcfknxIZEgqZW7aGjvb6O/TXVvy0HOJ7TNgV8JCYTkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739990450; c=relaxed/simple;
	bh=e1Bmllmdhp3fiwelLpfsJMvc+XiGJfNz/Hl/5N4BYYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlxO/8wuOK2EZE0sOy9Nf8C8ECo38IQmmRjnqHarOYLjTmamfU/Ezv09DVcmPHxbZfNivsJ8hiwdeYzZeN/1iupSZq38HGylxdBLtGSPHb9H3qX8b5/6KKdc2klt7+5gF7doOxbWaV1jC64LhQiobh3NEk3wRm2ZMz/sa9iWCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=UcjqLm9M; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0a5aa0f84so14573385a.1
        for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 10:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1739990448; x=1740595248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWjN6SjCLsPI+Cyw6VXCikrA2BKo6zuHXQJO1x4tFWg=;
        b=UcjqLm9M55GXnSLA1mxw3VRjUUMkTEXBtd8csKz1tctePX7vFOh9hDMEWqEGDHfQy4
         YPTnDOUpewVFl2afVP0sy0PSQaRq0ckS75AcMu1lVRgFP7XGM6A0dQNZ4JfdLpImLAw+
         AXl/E/SvCyeCSidEB5j2sPjxMOk0SlRCfT8Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739990448; x=1740595248;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWjN6SjCLsPI+Cyw6VXCikrA2BKo6zuHXQJO1x4tFWg=;
        b=u26v+j7YtmNNc5BM0X0CqoL4ty4+NeoFiAPZmXLXMzIzGSFavrfNy8UP4uoZk249P6
         Wj7hoJ4bvHTNNTSpffy/642WR4oTvitqcngAXtvL3f1wkXrMTLz2aIW6XrCdfrfkSqIT
         J4wL2nMDRKGaxY8Lk7U9WpILvnXSIZuPT3F7yPAPc1f85HecctrxzmNRSkSYLy1GdlI8
         SEi13U/hfyiREimmck4BSNNV8iO4qrX3rgMRTQnw6XEL24HZQNdHKlbUSrojQUNCQpZN
         zGN9JEX/c2gKaydx7DF13ZfZxU8H7Tdvi6tPl5525+iVZ9m4/1DDyyVFeMCCF2izHbk8
         yIsg==
X-Forwarded-Encrypted: i=1; AJvYcCV20Dt4hit2hwv1ad2tqGRfgR27S8JrbNSqpJNQG3dTQ1UnLJVNCIKVPhTKTLQiWS3M1YclTL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywach47mPbLYv61+jKc1XUjFzPyIhjaUbnckdE4X4p8/0+XSFz/
	yq917ZlzD05BsnYjz8/vAaUP6L4kEFSfHVKuJoBi3qpHswk15fTXjMIQ+Uxx4T8=
X-Gm-Gg: ASbGncu4YOw4omhDrx2DXG3jZtE1l9VSzEvxPiOmE7/xRTYudZRd3ZGUlnBeYdWWhCl
	hqKQAs1fHiT0NJq566a+yyITTz4GO729hOtuZuH+QGLbd/QF9Fv1Jjv8s95boN0NgmmrpYlJTTW
	TuD4Jk5JZn9Jveb1j8gta3ltWr6Tv4cKeg+wm/Os/hn+Q/blZNLmkueBmHxebSkSPttw2JPa+hu
	YaVbkLBzx91N4vmUh1eW6fCBrB/AcqORCz6y52r2p0/4SgSi78nbL1D+8emkHXLIuELIUDAwAhu
	UBJPzHQgDUlO6rwsRUvtdVA+0Tl2el2GETHSG49hpPfMOQfVcfOJWw==
X-Google-Smtp-Source: AGHT+IFwj3wn7tiRtj9kYnuZcLly+evnL4sHNXc2AQzgrKvRr95g7RqN+OERcFU5C68Ol7Iqw2cMBQ==
X-Received: by 2002:a05:620a:1918:b0:7b6:cf60:396d with SMTP id af79cd13be357-7c0c21a0ad0mr40230385a.1.1739990448351;
        Wed, 19 Feb 2025 10:40:48 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b3cb359esm151920485a.6.2025.02.19.10.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:40:48 -0800 (PST)
Date: Wed, 19 Feb 2025 13:40:46 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, hawk@kernel.org, petrm@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add a way to wait for a
 local process
Message-ID: <Z7YlroJR_hEbOK1-@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	hawk@kernel.org, petrm@nvidia.com, willemdebruijn.kernel@gmail.com
References: <20250218195048.74692-1-kuba@kernel.org>
 <20250218195048.74692-3-kuba@kernel.org>
 <Z7UBJ_CIrvsSdmnt@LQ3V64L9R2>
 <20250218150512.282c94eb@kernel.org>
 <20250218173739.0eac493b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218173739.0eac493b@kernel.org>

On Tue, Feb 18, 2025 at 05:37:39PM -0800, Jakub Kicinski wrote:
> On Tue, 18 Feb 2025 15:05:12 -0800 Jakub Kicinski wrote:
> > We shall find out if NIPA agrees with my local system at 4p.
> 
> NIPA agrees with you, I'll take another look tomorrow.

I think I debugged why it happens on my system, hopefully you see
that message before you go through your own debug cycle :)

