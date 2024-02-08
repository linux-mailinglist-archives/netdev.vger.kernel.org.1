Return-Path: <netdev+bounces-70327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761684E626
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307B61C25C53
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD181272CD;
	Thu,  8 Feb 2024 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZEW/zlaC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE2584FBD
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411880; cv=none; b=hDdY7VWMCRo3iRSbuoNIeasOZtujLeU1E2GCl9IhNBLz9zA1jaxZtwmWGaMpmfTGv2nbRefsSB1LxSP3RfVHyxTRtoUgqn5uwZQ48V6oHbmfEJAQA9vx2/41rXioFH7TjnLjmGB7/V4hIfrX3ijpasgOY0fBQzdogW4vkbwr6q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411880; c=relaxed/simple;
	bh=6D5HUp3hDtSXR1dvr6VUcFgFkDvieNiPpWfJPdKas2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5ahbUlStSso0/laeXtd/+iA+fWdCSz/okefxFlNqibG8X3tnx5enuyZCUZkE7R8jttqaLMP09d6W08UFawjuljs9kTvIjfnPaLZGAXVVS6AVbPuwo8HNyFio0rJaU4DTuF1W0pp8n3TuayTuWwt0fLlR6x2VwvEniFdkBJEjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=ZEW/zlaC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e065098635so20901b3a.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707411877; x=1708016677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3V9OilUSjBKCIIO4jKVEdwahBQAr/SxCERv1Bx3YTs=;
        b=ZEW/zlaCNOfsTecnEOb+aNsmjOAoQahXjCr595Oy3f0pX49CadPVxwdSFWiz/prlDa
         42Hozq8NuBDfKLNSAhVj/NOQfxaG2mocP8pXmS6eazMVByHQhUIhHC8QgcAGT3mSaCIF
         Hbkg9IEmCF0Nwl2Oq0o2mUSNrhjr29oiLAxaCaN4/D9gtZ53Uapjx6HIRTY6kTjfYBGd
         0E4XgcNGRIbZkWB2ExAqxsHUyNLWk58mpEOyTqTQ37zroRPcti9rwbfNin9+IDyMQUhv
         iagOfbHwgFmS4ehgHAEx+G53JG7bjgdR1gc6X4MY1zn424cVfOddiZX+9tmvnpSsVQnx
         XXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411877; x=1708016677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3V9OilUSjBKCIIO4jKVEdwahBQAr/SxCERv1Bx3YTs=;
        b=rJrQ6LaCBY31L+CJ7d48ISpHRRdxRjb73rPKpaq9HD+E3XFaEDWSt43JEtjSbivoop
         JJBz7bl/j0xtlJK4S4X5L0uMRl7rwJLDio7SvqewvQ59nUy2/AEs3dfoP++8YkAafqSW
         TEB4tC6uxQAMKS3sz8kCxDxt/zz7GGSiMz77lol4QpjRrmSlRxf1FSfLJju0ysC8Ei6/
         IAfIxg1clDQ2xodY53ugL75OARpd+9dWny1evYaGR20x+H4aVIKS/rVc5J9dVAnKgND6
         qVqELLgEOCUbqDLKLmP4RM+9P7ojQ7WmafCPqOHn8oWn0tJHCEJ9Q/fk7soTuoiksP5W
         38xQ==
X-Gm-Message-State: AOJu0Yx5AdCd6m17XP3sG9BZaaoV9zpBHEAnsOf2o70wLuL2zODqynaz
	sfmxGPK94gYmGeOL/WqBy9F6uRC/Q+620ZDeKUm9XDP0HeGzwdBn9YKQS9Tys8k=
X-Google-Smtp-Source: AGHT+IE5HY6C+4JU8xr/gIBhKl1VAZoZsdIUBvwdn89a38uyg/EdPu5V6Jj+RGVtmIzZGd+qxbD2Aw==
X-Received: by 2002:a05:6a21:801b:b0:19c:9418:c396 with SMTP id ou27-20020a056a21801b00b0019c9418c396mr137376pzb.31.1707411876712;
        Thu, 08 Feb 2024 09:04:36 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g4-20020a056a0023c400b006e07d6e2da5sm936472pfc.124.2024.02.08.09.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:04:36 -0800 (PST)
Date: Thu, 8 Feb 2024 09:04:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] tc: Fix descriptor leak in get_qdisc_kind()
Message-ID: <20240208090434.2291c0af@hermes.local>
In-Reply-To: <20240207210006.13706-1-maks.mishinFZ@gmail.com>
References: <20240207210006.13706-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 00:00:06 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Add closure of fd `dlh` and fix incorrect comparison of `dlh` with NULL.
> 
> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tc/tc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tc/tc.c b/tc/tc.c
> index 575157a8..162700b2 100644
> --- a/tc/tc.c
> +++ b/tc/tc.c
> @@ -112,7 +112,7 @@ struct qdisc_util *get_qdisc_kind(const char *str)
>  
>  	snprintf(buf, sizeof(buf), "%s/q_%s.so", get_tc_lib(), str);
>  	dlh = dlopen(buf, RTLD_LAZY);
> -	if (!dlh) {
> +	if (dlh != NULL) {
>  		/* look in current binary, only open once */
>  		dlh = BODY;
>  		if (dlh == NULL) {
> @@ -124,6 +124,9 @@ struct qdisc_util *get_qdisc_kind(const char *str)
>  
>  	snprintf(buf, sizeof(buf), "%s_qdisc_util", str);
>  	q = dlsym(dlh, buf);
> +	if (dlh != NULL)
> +		dlclose(dlh);
> +
>  	if (q == NULL)
>  		goto noexist;
>  

This does make sense, but the patch method is messy.
Please don't modify code outside scope of the fix being addressed.
And since the check for dlh being NULL is already done above,
the conditional there is irrelevant.

Also, this change will break the code. If you read carefully
in the comments, there is a hint.  The idea is that if the
qdisc is not in the external file, then it does an internal
dlopen() and it wants to keep it open in the variable BODY.

Your change would close dlh which since it same as BODY would
close the internal handle.  That would cause next call to get_qdisc_kind()
to look at an invalid handle (BODY).

I appreciate your efforts, but you need to read deeper.
This is 30 year old code and the leak may not be important
or be intentional.

