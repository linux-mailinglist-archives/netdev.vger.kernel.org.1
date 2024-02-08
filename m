Return-Path: <netdev+bounces-70328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAF284E64B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F16B11F29416
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF1F82D71;
	Thu,  8 Feb 2024 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="DdccwIVA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3F8002D
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411925; cv=none; b=FjvsKI26s6VNCH8ZJa99P1GMqszmrwuxfOZTCcDcsuBBUd+Juhzstb9mI15jrp2tg+yIhZEdQLOjn2PJVwbyT1ZhX9i0DQwmT9dy5qF2NFU2Ymh4tHs+yjEa5Cnf09RwO1y6O/QOdPfZVbb1iccdhxG9LYAheyGUNEWxgiuU4lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411925; c=relaxed/simple;
	bh=lmM/K9B6ZNKlQ9NoasEB0uEcczRe2IGI8es1F2pw+7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWxdkSBR5BdrmOHq1EwgGhsoMkgalYY/6W32FLxPkhCL0+hVj+vXT2ehYpPa1HEwKrzyDhyR9eqdx0AmPWcEPEMrNVIwTU/55YDi6jCB7lkMpe8ShUvyyv8t9NCqYmW93uGofc4H52V+tUYDpij5kWC/lNa2H9vCphFPSPpO/lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=DdccwIVA; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d74045c463so19232795ad.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 09:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707411924; x=1708016724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSvTo2xxbnlU2sc9bgh1acovEtiD+B2P+hR51dN+C48=;
        b=DdccwIVAUOgL8KKOmwx+/oJYP3DSYcNSxt+MasK2o3wgbuu6JZgAAK6j36RqcDOnDc
         v4Q+QS79pVod4zscYGTzNpSJGMIklcw0IrdwZjFmstw9yK5YP1OD3R2aV4jwJxSyZnE1
         ZxZVX2H4tyACN1lCMNW8dp5unZgZlbmzCP7V3SUBkbagJgNzjmj1+56yAQfgCk8QL3KR
         wJ4aelhMa5BD5PLqC1hLPVvoG3t+8F9Evl9y2I+rNo1fHTYoYBxhXHOFivjZHak58Kke
         fGrY1pMVQY2v8Ekwqq+wcGqc3sL6YZxv4sxs40/N6XMqjZdL0Uylt1u1zm/mKqmqRX4g
         FS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707411924; x=1708016724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSvTo2xxbnlU2sc9bgh1acovEtiD+B2P+hR51dN+C48=;
        b=Rqult/tvHTxRvfC89yEbJzKcK6wFncpukcbN4C1a44Q4IbCRqo3mQehvkcM2iBIgso
         +OZ+QqRmGDpH+pPfm2q8F6ptjB58snFyYBDg97E7jasTMunxeAQWX7HLXXoVvzhBjiYj
         D2+nHEAb+6ysxJlm+u8xkf37fGSJO2gZ4i5KesBsDSx8ojCadWP82Qm7Hwvm+ViWKUAO
         l1zeWDa8fBL1vRey8NtqpPs5unJ1ab7i1PJTxltajUdue1gNLI/rH4Q2NxXnq6BDvT8b
         1m2VnC0NH1VJZd+MrEI5dIgn7jRcp0Q+QUWp7Y6IVce+vEvdQMrJTzv9ZHlcLqVU8wJw
         5QaA==
X-Gm-Message-State: AOJu0Yym+zLr3020offWHHGHe1HAMrHpvhuJ/WrYm05ixN2I0mFg2smo
	zdPhD/OEtmKtLq+fzktRtiGyRATKoHuz6rPZ9z1pWje/5lfwrFnNZ8KMX98rCeM=
X-Google-Smtp-Source: AGHT+IHYkntkBQ+FnyM5NC1vhNWhvYAFqIsFiOMDK0HgxGpxvZj8vO4JIDj408KBtcIAui6MBKbP8g==
X-Received: by 2002:a17:902:f54d:b0:1d9:bf92:f51e with SMTP id h13-20020a170902f54d00b001d9bf92f51emr8479654plf.49.1707411923699;
        Thu, 08 Feb 2024 09:05:23 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id g8-20020a170902f74800b001d60a70809bsm20138plw.168.2024.02.08.09.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:05:23 -0800 (PST)
Date: Thu, 8 Feb 2024 09:05:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iplink: Fix descriptor leak in get_link_kind()
Message-ID: <20240208090521.14c5e230@hermes.local>
In-Reply-To: <20240207210450.14652-1-maks.mishinFZ@gmail.com>
References: <20240207210450.14652-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 00:04:50 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Found by RASU JSC
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/iplink.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/ip/iplink.c b/ip/iplink.c
> index 95314af5..7e31b95c 100644
> --- a/ip/iplink.c
> +++ b/ip/iplink.c
> @@ -168,6 +168,9 @@ struct link_util *get_link_kind(const char *id)
>  
>  	snprintf(buf, sizeof(buf), "%s_link_util", id);
>  	l = dlsym(dlh, buf);
> +	if (dlh != NULL)
> +		dlclose(dlh);
> +
>  	if (l == NULL)
>  		return NULL;
>  

NAK this will break the caching of BODY.

