Return-Path: <netdev+bounces-81305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBB886FE8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 16:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E8284909
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 15:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76235101A;
	Fri, 22 Mar 2024 15:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DIdm02ks"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA265B5A6
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122110; cv=none; b=mpeXVKI7bDDFG0NcQ97Jpd0TtILY5Qa6uR6gwfYPh5gn9Lk0uby91AigLF9F8s4KYZ8WD45pedcyhIe6XQ7qJXRpstFaWRBk/fzUUkFUngoL7dnsFHN6MNwn81xaeiLFpXg9NFtOsA2ZPaBNxMAmRXW0mRddnBffPe7rFe8yjfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122110; c=relaxed/simple;
	bh=B+/xFuqJmP6elqhGJxvQk8WSM6hnGTFg7P7zXygPy7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Osd8em/t6KTfIEwjdwogei13c7yV4x5J1iR/bLb2K43081oGYRPuBSl7C+XRmS8Z2vNAjSsIwRmtlhS6lO7g2DUpzm0t5/3GZGivYYz5/w6py62gB/reKGkU4iDb8spparLKwHSe3+usQEwkWN4xEjKTTEc6JIhHzKLsdI18Hjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DIdm02ks; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def59b537cso14503815ad.2
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1711122107; x=1711726907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJh29uvbzp8qLyreE66ADZk3coO9VHHThpMV9LfpmGI=;
        b=DIdm02ksDdgTuLdIvvKYHbFxSR8/rYOHKa+EPL6f4lYx2opCIGs5XdNN4OQsiKXyGn
         xo9+/53J4DyIEpkVSU6YxEAybfRCiqZvk5BhvKPqR68NSgx67B4O04CGrZVUNt97XeKv
         Ug7Lyjpswww+Zf5dWCRd2vXBdI+iISzomEVdWw0d4IqaMvj+ZD/hnFyUhbdSGOV3ImrL
         pTF3DteuJSLnJAcDOs0bI+0+3pH0J+ugu5vAqHgDBqFHhXhEv9EduiM9kycZ3UwxIycg
         D8ZsCu4mlbqG0YsJamDiTB8EuP/2D9RRWADODgOVeiuFYpr4lmJSxju/nJ/hbS6fgpov
         bA0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711122107; x=1711726907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJh29uvbzp8qLyreE66ADZk3coO9VHHThpMV9LfpmGI=;
        b=I+ze3GIxTYC6DMfKW3vKr5bkWY5CPiSwZ0pNoecUYzt04xZuwUY7rMxUG3twwx4Lfj
         cUf8dHkWABTkD3GvWOrULm988/WIJRQmOoroiYMTibLRScM8UQZ1Vb2k1eLsnTNrakks
         HCi3wErHIzzNTN1mvAbhPutEXLjAGEzkrbHWREJE9XSxGmPVubC0cd489TPMFETcRzUs
         umxAu2zZBqR49se5AS62XFANhD6+7qfpqOM0hv7c0+KzZ9ue6BvpA0dQz6utibqsySQt
         g9+e2xWBoDRLZSocdq7IpYmTlfa2XiXAZBk71DYMP55LatHrV3SkTLAIFRxdwEviMQmN
         isoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX89+7l5rnEoaVaOuavo9rp1HMrNAjPuPcr5HEVtZ5gOCXFsw9kLNV/PtS+btwDC9JMEz30udfnT0pP0WjnKQ1E3mBTLOAz
X-Gm-Message-State: AOJu0YxQNX1mw1PsVMZBLbyPp5eC6TTT3/c42KHYvJBbkgpNTLrTEJO0
	daUWR3JOJTpG55c3By5wChMFImkWS/YqqnO0//hb2fXZ7ITTD0wY031lfTdUtkY=
X-Google-Smtp-Source: AGHT+IGYi1VQSz+fvk1a/BPp0AjYfkPeTAMoiRUqwMq0c6i+v20HMcjlyCMfPn2Jh6oGAPrzWCN/MQ==
X-Received: by 2002:a17:902:ef44:b0:1dd:b45f:4cc9 with SMTP id e4-20020a170902ef4400b001ddb45f4cc9mr122024plx.23.1711122107584;
        Fri, 22 Mar 2024 08:41:47 -0700 (PDT)
Received: from hermes.local (204-195-123-203.wavecable.com. [204.195.123.203])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001dc91b4081dsm2056441pld.271.2024.03.22.08.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 08:41:47 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:41:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, jiri@resnulli.us,
 netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Subject: Re: [PATCH iproute2-next v2 2/2] bridge: vlan: fix compressvlans
 usage
Message-ID: <20240322084145.3e081475@hermes.local>
In-Reply-To: <MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
References: <20240322123923.16346-1-tjjh89017@hotmail.com>
	<MAZP287MB0503BB0A5D2584B43A734CB6E4312@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 20:39:23 +0800
Date Huang <tjjh89017@hotmail.com> wrote:

> diff --git a/man/man8/bridge.8 b/man/man8/bridge.8
> index eeea4073..bb02bd27 100644
> --- a/man/man8/bridge.8
> +++ b/man/man8/bridge.8
> @@ -22,6 +22,7 @@ bridge \- show / manipulate bridge addresses and devices
>  \fB\-s\fR[\fItatistics\fR] |
>  \fB\-n\fR[\fIetns\fR] name |
>  \fB\-b\fR[\fIatch\fR] filename |
> +\fB\-com\fR[\fIpressvlans\fR] |
>  \fB\-c\fR[\fIolor\fR] |
>  \fB\-p\fR[\fIretty\fR] |
>  \fB\-j\fR[\fIson\fR] |
> @@ -345,6 +346,11 @@ Don't terminate bridge command on errors in batch mode.
>  If there were any errors during execution of the commands, the application
>  return code will be non zero.
>  
> +.TP
> +.BR "\-com", " \-compressvlans"
> +Show compressed VLAN list. It will show continuous VLANs with the range instead
> +of separated VLANs. Default is off.
> +

Overlapping option strings can cause problems, maybe a better word?

