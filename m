Return-Path: <netdev+bounces-65726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 199EB83B733
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 03:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3051C21012
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 02:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED90E1842;
	Thu, 25 Jan 2024 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ5zLZjZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F61FBF
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 02:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706150272; cv=none; b=Cjw8UFzSh2Vhyv6WYpA/iKFvr6q4Lq6wiOg8+A4Y5bIXef2fEaD/0JJIy35smraOHDzfyUwHObhGu9BIJEkmHIpG0nWdEAVv3B32PB4WBL0aqqJrDIj7Gl1F82NdEQ/5F6H8knGGyOI0bR5cNAgOjQpA4xZ64SmmcOr97lhOVlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706150272; c=relaxed/simple;
	bh=ThHwJrrJGOywQCJxWVVEI3tyJqmm4a8VFWayKkfidv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIRUuDfFcl/+xLSNlstAAePrA8GLZfYyPGCvKx+tAL/Dw5TonxqBeIy9w39pjExHEhT7S+1N91+DFDIvASVRJS6PjHgzNMtc4ZwDrqK/NExylsrf/q+OZGcyzXa9r4IhOm5wVt/ja2XGSC3HD3Ty1daiGC1yN0eMaOR8q2nsXno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZ5zLZjZ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d746ce7d13so33819135ad.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706150271; x=1706755071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Df/yBV6MsKEmsAUSrOaMUU9QvaJZ9iCndfW5Ygywty8=;
        b=YZ5zLZjZhsRNlcpgq50PtklxprQS/O4roN0Fq9DLb59V6Z5vTzai7ctQWEYBoO3Rj8
         2ZwppOxEMsFXntpT95f5p2uD/1kL1KmfKvsRuoJLkQSK2j6YbekLB+tZzRJSuiiTNBHR
         1o6KKQKtPbhkGh/DFs3yquWEanOWgNMTTJSjosUr7Xjzn44yHWMR0N/Dra4TUwKSoeuQ
         W0XAXqw6oZmyhNh3ySHsZ2B9u3kK69fx2u4aZW+Y1y+N/jD3cHLwJods1m0JS07wX4dA
         a/VNrb6b+QAOBtEQmyt1NJs2SeBbH0ErU3zpvH1oVNHY15Wn8LiXHl1DNC2PLCVLRvAW
         WsMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706150271; x=1706755071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df/yBV6MsKEmsAUSrOaMUU9QvaJZ9iCndfW5Ygywty8=;
        b=EZtex+500ViG9h6+17lE/0wFdBllS1FDOjNFNdvXj+3vejCaMG+vPIp/em0Ae7g7yV
         W3b396vXxYRNdNie4fajhwZjKcuMOmJ4MY2YmKm0lNOy6RICLuXmuwV3tYDziJhShbUl
         l9Te40WLIvMn+zfjYFKc92Dv+diXFRekrrl0Aw9FQidLPqIaXntS/m+EG8oPdxBkGHmt
         h47IPFXCPyhujzSyJEyM3cexdUaEMeC6b5deYinzQW+yjB676Ng7cuPG9kUSqhwluvn2
         Wjo60K4Yjyvk4K/bOqq+8roWlXF0Z3Kahz1+FIRz8rOm1mjyaEu74Hwl+dtdg+MAQ1tH
         65mQ==
X-Gm-Message-State: AOJu0Yxri9mre11DYJfn3VGaSqIdQV2YAZSF9saA7uorm0tCWbRLBYoT
	j2lViNSyKvc5KVu7xoUA/4im/avFg8cEjomO+O1EQX5/rwTPSfSw
X-Google-Smtp-Source: AGHT+IE7zTfvKdW+IhjVJLcuymC/IeU1vx3Eiet9qakTrVcgp+UKqhlgeSKrLrJ+W4QLd9n2jFh2FA==
X-Received: by 2002:a17:902:d507:b0:1d5:8bf4:c79b with SMTP id b7-20020a170902d50700b001d58bf4c79bmr522166plg.39.1706150270892;
        Wed, 24 Jan 2024 18:37:50 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902e99200b001d749d3c474sm6037218plb.5.2024.01.24.18.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 18:37:50 -0800 (PST)
Date: Thu, 25 Jan 2024 10:37:46 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: stephen@networkplumber.org, dsahern@kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel@mojatatu.com
Subject: Re: [PATCH iproute2-next 0/2] tc: add NLM_F_ECHO support for actions
 and filters
Message-ID: <ZbHJendeEKzhw5ly@Laptop-X1>
References: <20240124153456.117048-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124153456.117048-1-victor@mojatatu.com>

On Wed, Jan 24, 2024 at 12:34:54PM -0300, Victor Nogueira wrote:
> Continuing on what Hangbin Liu started [1], this patch set adds support for
> the NLM_F_ECHO flag for tc actions and filters. For qdiscs it will require
> some kernel surgery, and we'll send it soon after this surgery is merged.
> 
> When user space configures the kernel with netlink messages, it can set
> NLM_F_ECHO flag to request the kernel to send the applied configuration
> back to the caller. This allows user space to receive back configuration
> information that is populated by the kernel. Often because there are
> parameters that can only be set by the kernel which become visible with the
> echo, or because user space lets the kernel choose a default value.
> 
> To illustrate a use case where the kernel will give us a default value,
> the example below shows the user not specifying the action index:
> 
>     tc -echo actions add action mirred egress mirror dev lo
>   
>     total acts 0
>     Added action
>           action order 1: mirred (Egress Mirror to device lo) pipe
>           index 1 ref 1 bind 0
>           not_in_hw
> 
> Note that the echoed response indicates that the kernel gave us a value
> of index 1
> 

Looks good to me.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

