Return-Path: <netdev+bounces-109702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C7D9299CE
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 23:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D4E8B20DDF
	for <lists+netdev@lfdr.de>; Sun,  7 Jul 2024 21:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7F13E479;
	Sun,  7 Jul 2024 21:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="15dZzIGh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6C1D52B
	for <netdev@vger.kernel.org>; Sun,  7 Jul 2024 21:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720387369; cv=none; b=BTY0gBPzF0Uam+1OyJjTFJ4EmWQLOuI/HPiojhpdoBK3y7K8YEweiAz1D/2Sg2wqH192VZnlrGOeLsm3Yyqx7x+m7a42zrFM2fLFvmw7sq5OYZmSSWzlDaUUkXa7UfwBLWdyfDi+7NJ372eC4vWe+m6B8jstFY/2RBnVJO9Z/qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720387369; c=relaxed/simple;
	bh=VMHJSzrh1JaUr6e10gNSf3t7fsjI6nlcOxiskIATKFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOQn7RAm44LRglOMQb7pZ8JEnt6kOGGXraMyPb7Gp2o3FnzyhipxBAGMDYSEqTMGrfDlpkmTvTC3RTTyy9v3SG2xGEW7U0rQJWweIXBTmCtgVtpPhv4ZRlR1IjPese5djBLiybYr3V9MyGqlchIg4E5R03mK7wr3/XxcHCW8g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=15dZzIGh; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3d9272287easo775485b6e.2
        for <netdev@vger.kernel.org>; Sun, 07 Jul 2024 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720387366; x=1720992166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYi/bb1equ07sJWBtIBZkoBJgXrNXCZE7GZy4fxFclc=;
        b=15dZzIGhhE9qNHfFxJkDyEuNUrtJGN6I9NVj9zUjjTVkINMIcfjappeaPribj+3Emm
         FPSzQ81DRlIMj7sSSWcPvdf6RXLbCDzFzq1pA8o1UQJZA50p99l9i5peN0IIgIh6AhgN
         ix1FbrmxOwd1Gg1GWnAu+WzUdgTWhXiBfoAVKqZO6vfMMXQhllvFN59S/pT2UypMLRqh
         6K45SdJxsrhwDrzA7Sow8F3FD9Vj+2DFx3m/IjK3S9h2IR+izc8d5by816TqQMbuA3kd
         We/0t5tgfgFT2z+TeS730L270PVZGVdsrwVA+sivY5ldLnCzJCaaLgrrCroHb7SSXuAi
         CoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720387366; x=1720992166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYi/bb1equ07sJWBtIBZkoBJgXrNXCZE7GZy4fxFclc=;
        b=N1tjryU0wSeB1n//rWw6Qqq2mLn/ruixo3a1ZTzdaXrUFpSCEP+5gD7DMa4h8IAUXd
         AHKD7YGzq3EFdogI6LYowQstOwpr/YPh1KAbbkx5LRIS3nEZw8O4PZlAWdzuG54YfAF5
         R8g3mC3m1LIvVJlMz9PYhuSyReA/2yWk8Zwn0CD2XrREAXJ3f7xGb/M/ntgeYW9D9JIG
         SjMyH0uLfZpgdTqsXLi4Je2rTbMDunfh0r0VMnl3Umdw5QSnl1mD+YWR9hNpWnZ0TnJF
         sRDi/a8lTO9sOFe3GkqMrjcaL7MxVBXhybDDRzjj8gn0SWt+F6FKXmRD9HaO8Wr2Uuvv
         1ofg==
X-Gm-Message-State: AOJu0YxPPdbi5IHISusXPjUXZ8eSimU5DqpwH/fTBOBk8Nb1sU44kSVa
	VBgR9VoL7VMsuJzE/2MxzhJHgcKnQIhURdJhjEeyYg4w1bk8uwQ7QA8ivMdbuYg=
X-Google-Smtp-Source: AGHT+IGGukgLZ5mIJXtSaJ6bWWic0iGXtiMe7+nqAkVzKc+lez67hNMbxsrd46JkwgenlQSQbdRKpQ==
X-Received: by 2002:a05:6808:179f:b0:3d9:2d43:7144 with SMTP id 5614622812f47-3d92d437348mr3146409b6e.24.1720387366434;
        Sun, 07 Jul 2024 14:22:46 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb13059efasm85483685ad.41.2024.07.07.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jul 2024 14:22:46 -0700 (PDT)
Date: Sun, 7 Jul 2024 14:22:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] iproute_lwtunnel: Add check for result of get_u32
 function
Message-ID: <20240707142244.32c86b93@hermes.local>
In-Reply-To: <20240707154928.20090-1-maks.mishinFZ@gmail.com>
References: <20240707154928.20090-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jul 2024 18:49:28 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  ip/iproute_lwtunnel.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
> index b4df4348..2946fa4d 100644
> --- a/ip/iproute_lwtunnel.c
> +++ b/ip/iproute_lwtunnel.c
> @@ -1484,7 +1484,8 @@ static int parse_encap_seg6local(struct rtattr *rta, size_t len, int *argcp,
>  				NEXT_ARG();
>  				if (hmac_ok++)
>  					duparg2("hmac", *argv);
> -				get_u32(&hmac, *argv, 0);
> +				if (get_u32(&hmac, *argv, 0) || hmac == 0)
> +					invarg("\"hmac\" value is invalid\n", *argv);
>  			} else {
>  				continue;
>  			}

Fixes: 8db158b9caac ("iproute: add support for SRv6 local segment processing")

The message is not that great. Becomes:
	Error: argument "XXX" is wrong: "hmac" value is invalid.

But the rest of the tunnel parsing is equally as cryptic on error messages.

