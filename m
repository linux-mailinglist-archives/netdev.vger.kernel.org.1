Return-Path: <netdev+bounces-70242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D8E84E234
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8B81F21FCB
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4236763F4;
	Thu,  8 Feb 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuh5R55B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8A0768E1
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399959; cv=none; b=A7Gm5jKbOp7lzu739NwhZ+PeydGzjHzf47mgOMPGeUFPwOLYiKADkMtpJcnEinm++P2TGwoMqtvARH+s6MGd4ipqr5XLEH1SyLMeegNrSPr7N7VurdHP9uamBxsDnGfwpN2WrsEnxYTvvLhYC2DOl7LzrDDPGdkoVOOGEVLu8wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399959; c=relaxed/simple;
	bh=8Koq/nUQ13EqdH89kyFAlk/9UFW6Z2DLQwkfiqfwN4k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=eRsobD3RYV/x2DsWy31U04SaxYAehuyxB/38eIFoKYOfA/dT8EVlWZySh3dshMEVHvDRHa57mM8e18Y2IGDdRjkymivlaEfkFEU75iFO5oq19MjNn6jmKi7HA5uf8iBZG3lf/5N6c3d+TEOr4XSx71fjQI+OKDAjt0peI1c0rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nuh5R55B; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33b29b5ea96so512106f8f.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707399956; x=1708004756; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=28QF3iBVnDKFaQi+wzNVCDNnMh9JVHvxTN1x2MuVCZU=;
        b=Nuh5R55Bzl1AcTxC76Ufv0P7TXXCsXjRbJRPUD140Xn0xm+2qZczu4mXpX5lsaSgCT
         RTl7KfsajOcugVLUkjYNwB6JG2zZWLqaDenre4a1HtBuXwX4TbKNV/nAI4U8Uoge4vJs
         I4PSscMvVun8+X9iamKqCJ8mgNMb4tGzuiA4wFofdz0hWch0vtvnZWGyP0e/R9CMPL1/
         g1mCUg3XfzF+RV5ssCC4XNhOffirpOkJmdrcqAnyhgHmdGQ2bQV3NWa0UoLrjni6PZDR
         ElH+gfH1I589+XLaVbJpTjbAP/FuY1w6CeURDijhvdp6FwyYPZfe1Wr9pzdlRuDh2AqT
         lP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399956; x=1708004756;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28QF3iBVnDKFaQi+wzNVCDNnMh9JVHvxTN1x2MuVCZU=;
        b=Vjle8a8jAVFBK/ICXM/Xd8d5Fp+zAJfnf7BgTD2XKJtLSMQgUC/XuzG7Lv7KzAWcdA
         2FJ9o8IjvVXN+j0CvDsKDCSpT08nMdVkhz6CJdjrbtFMXiJy7xTKvS4PY/686hsd7hKE
         e+xi5881jkfBZH78xVD+wCZncpNdzeMAC22wu1BA+kasngJncOlJBTpkyONGixrRmkBl
         maRBab4OC76+A7xVHqGrmURKJjr9DBUM6V2trQrmcyPhDClrE4jpxR2iDWAAI/yT+PHi
         mqANCZavwGutyIQ5zmMcrDZl8JItT8lf5rEICwAKFHCyexLJoOPKfbBIzLF/2ec0SseD
         T6lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYusyzHabkaA/xmfK8WTIh9i7/feh6ihZbyoifpeEc0K9sTeBHY+WSWFtZ7qa5/hHIAu8OYyAZwjQXQBL2n+B29g8G3AGa
X-Gm-Message-State: AOJu0YxI7OpEAZTgOkwddhV1EBNBgDYD+kEWAwIqGzwd4OGbKgsYblGx
	SfTuMjNzetIEnXmAX6ZO44GDdsElIeEyPsqXjWFarwCPon4sw9jxmhHgEvwprA4=
X-Google-Smtp-Source: AGHT+IHsXAGONelSRtQ/DITfF5bOaTHjNgxQzUbSJD9p5lLNiwOv4GFX1/5NG4IUgC93WgpTcip3FQ==
X-Received: by 2002:a5d:6407:0:b0:33b:4709:ebf with SMTP id z7-20020a5d6407000000b0033b47090ebfmr1897114wru.21.1707399955769;
        Thu, 08 Feb 2024 05:45:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV50/6hEH2oBM+iqhOHCBDYEPy0QZQMcC70huGD0sffG+xN8VTSw897VHodAGJNRVrGQBmCK/U/RY3PWlN1STLjhGQuXFE3
Received: from imac ([2a02:8010:60a0:0:4c4b:7e8e:f012:825c])
        by smtp.gmail.com with ESMTPSA id e18-20020adffd12000000b0033b4acb999dsm3617430wrr.98.2024.02.08.05.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:45:55 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] genl: Fix descriptor leak in get_genl_kind()
In-Reply-To: <20240207200823.7229-1-maks.mishinFZ@gmail.com> (Maks Mishin's
	message of "Wed, 7 Feb 2024 23:08:23 +0300")
Date: Thu, 08 Feb 2024 13:22:27 +0000
Message-ID: <m28r3vt7jg.fsf@gmail.com>
References: <20240207200823.7229-1-maks.mishinFZ@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maks Mishin <maks.mishinfz@gmail.com> writes:

> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>

The subject should say [PATCH iproute2] or [PATCH iproute2-next] since
it targets that project.

> ---
>  genl/genl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/genl/genl.c b/genl/genl.c
> index 85cc73bb..74100dad 100644
> --- a/genl/genl.c
> +++ b/genl/genl.c
> @@ -71,6 +71,9 @@ static struct genl_util *get_genl_kind(const char *str)
>  	snprintf(buf, sizeof(buf), "%s_genl_util", str);
>  
>  	f = dlsym(dlh, buf);
> +	if (dlh != NULL)
> +		dlclose(dlh);

This is broken. If the earlier dlopen() actually loaded a .so then this
dlclose() will close it again, before f gets used. When f gets
dereferenced later, the program will crash. If this works at all, it is
because dlopen(NULL, ...) returns a handle to the main program, so
dlclose() doesn't unload it.

My assumption is that the author is leaving resources to be released at
program exit. It is a short-lived command line utility after all.

> +
>  	if (f == NULL)
>  		goto noexist;
>  reg:

