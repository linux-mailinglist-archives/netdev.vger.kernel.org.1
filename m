Return-Path: <netdev+bounces-70245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A528C84E237
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2609B213F6
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C235D768E9;
	Thu,  8 Feb 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvb4Vf4F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F73D76C61
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399963; cv=none; b=BHfqXuKlSSJ/KvTharkNw5Fmo0fK+RXVh6GLU7sRcBNqDVAq3OJNCeltAFOg6XUIcxmDqOTXsnJwmCINvVJcnxYneaP6FEB0TdXi2HIrS530F9WqB0zkyc6KQO6DFb+bUIaA0H/nl/r0mSzxyBHM1tjh8EMNo5cK7UvteaBuWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399963; c=relaxed/simple;
	bh=xWOkqz+c0yT4jYMl0xR6KNFnigkCUTJ1avctbFp3WWI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=IlXGls/W7PpF1ORzYjJOdQ9QI+PCm0FpwYXjdeLc3XOpZL69vYAzAlE+C4uk6MODePQXK2y1CbvQ/tBRo3Evrf7U1d/GNexUNWp3gmsWUqheA1Eb5Xz8r5kpphwkO90eGsXq4C2dO+anORD+rr67Vq7iQTdbgitbGD8lkQtfTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mvb4Vf4F; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4104dee26bfso1458725e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707399960; x=1708004760; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kJr8vo/sOlCra3Heug38tTz/QVXaWrB0/gG0UZEA2pY=;
        b=mvb4Vf4FKCk1TZ/Y7sjo+QYsfEO1C2S4bamMVgYLga4tIknYeLE0580H86ktu72cfA
         73clu/oUgPhLx5BuWolgsYq08OWZT2Hb3uUuvkhvr3QN5fggApI/Vw9S116qoUYrMjek
         AAdE/Qe8nhICIFOmWp94zcWqBZ6kOHv9I1pQV7LUQb87xBTND02zwb3Bu6h0ht4pxYqq
         fE7SAwETRtbv98dvtw0YWc+O3DI9dZRB6KuMiNvxaGu7UHqprWIivBde1a/XWc/HUC5Y
         VNyK9Up5lP2cqi8O+J0igAJCgAh4/+LbojAT/T4BNaWsXY4t8yVNJO5MuhOMq1S8kCE9
         t00w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707399960; x=1708004760;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJr8vo/sOlCra3Heug38tTz/QVXaWrB0/gG0UZEA2pY=;
        b=v+MvVNJGqcCzeuY8CX5DT2SHD92KMKsh2lUpFVGugbJBSgyW/hOo9CCtd9gZnssBRc
         0OlF3O+Jf58927HyR/sJTN+3I9TjzO59XvYUWbBjUdgF1qa4d60ySIy1BcrYGrgRBxdP
         h7RcEHBVjTlAzWngVz5UAFEZ+uwZ4WNaiTNZ067RfhT8uFIDhDxqDf+molZ4Q3OAzjkX
         pLmpNSkPs3cBvlKMuWta/GAtsv91CKxT9bQAmEbiNA3KGNOGt19QJusJVkYMlbn6Rc1L
         X96Ts0lCpgzlMFdw7G1KOf0dHxNYhA2z6Jwrf5ZhE8N9meTW6K1liE+8DMPepL/Rc5GD
         KiNw==
X-Gm-Message-State: AOJu0YwIl94QAl9FDU+jTtwtZUDlIaSbFqCkZKxYplOCFiMQ0U3iRDM5
	oPCJOG3hDqMeQDXJkySwImJe/OwEx46zLUVe4Z25LkU51CKa4j11doIu/lS/S08=
X-Google-Smtp-Source: AGHT+IHLejWGbk9EXdhW1b1VVYxLvWwrCA2Q5b6K1riY8czoPLEKEOGnhViv11BARcqMJ8562qH9zw==
X-Received: by 2002:adf:fe08:0:b0:33b:5979:b92b with SMTP id n8-20020adffe08000000b0033b5979b92bmr1117155wrr.1.1707399959912;
        Thu, 08 Feb 2024 05:45:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU/vpFt6GAC7xz3Qqc/sPfMsVm7yJLE/XUD8N0Ao+xB5YMEgKapvtLhF5babInkS4KpLG7dFXO7UIGB1Gke7MP5gFizvOWw
Received: from imac ([2a02:8010:60a0:0:4c4b:7e8e:f012:825c])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b0033b3ca3a255sm3653167wrv.19.2024.02.08.05.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 05:45:59 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH] tc: Fix descriptor leak in get_qdisc_kind()
In-Reply-To: <20240207210006.13706-1-maks.mishinFZ@gmail.com> (Maks Mishin's
	message of "Thu, 8 Feb 2024 00:00:06 +0300")
Date: Thu, 08 Feb 2024 13:45:08 +0000
Message-ID: <m2v86zrrx7.fsf@gmail.com>
References: <20240207210006.13706-1-maks.mishinFZ@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maks Mishin <maks.mishinfz@gmail.com> writes:

> Add closure of fd `dlh` and fix incorrect comparison of `dlh` with NULL.
>
> Found by RASU JSC

What is this tool? It seems to be giving you bad advice.

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

if (!dlh) seems to be the preferred style in the iproute2 codebase, with
2000+ occurrences.

>  		/* look in current binary, only open once */
>  		dlh = BODY;
>  		if (dlh == NULL) {
> @@ -124,6 +124,9 @@ struct qdisc_util *get_qdisc_kind(const char *str)
>  
>  	snprintf(buf, sizeof(buf), "%s_qdisc_util", str);
>  	q = dlsym(dlh, buf);
> +	if (dlh != NULL)
> +		dlclose(dlh);

Incorrect placement of dlclose() before sym q gets dereferenced.

> +
>  	if (q == NULL)
>  		goto noexist;

