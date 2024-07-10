Return-Path: <netdev+bounces-110696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B4C92DC6B
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 931F71F23F07
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 23:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848D614B95A;
	Wed, 10 Jul 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="wOsnuped"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B484D12
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720653103; cv=none; b=BQCXJHnrePpkv99UbEd71cAmgj0uvrfilA+/csyfcu9HyrE3ajotkW99xjAcJhbP5ot5qCp40v2RiIZiFHLsI0COraTn3ZVI+8lOgnSsJP6V8Ilv5SLYUGTSLTH84syeSpOqfBXbTr8DA7LVCeiI4vYlL5ymflRW9XfOvAEIDeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720653103; c=relaxed/simple;
	bh=qs45M/3+XXU+AAjfRPGzt0CFvZYZ73DiDWgnyrBHn0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q7Sasui/FUuPNHoqibVuLV0/7lxRYeXJ5p8y9tpQlx5xrQFj44TuZw/7WKNQAdDVOrQuRXLO35lu+6RxdpwZPdt3gj+JYbTtVHUhweFOjU0GyOXdq1XGkPHuy8lI4zevz9h4mr0Ru89qX73gWPzNuQK/MqQeIZGLeEKiCkDvLHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=wOsnuped; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-77d3f00778cso168192a12.3
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720653101; x=1721257901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEhCvn/GX7ZGrfff/9by/aKOGF9XNJ6WAIBe9Hc6X/o=;
        b=wOsnuped355FbpfCJPOODmeoQbUsn36HSGf20S5t3RHU4b7DxOz7rdxo0Ads+6MSFf
         Sm4B+/GHbOb06NVj/bUQSYYLBVEj+MLa4GXdKAiFZgB4jsF5e/hsMYSiz48ec55tletX
         dNJG/dAd9quM6OLNZEBxy2Vxo935b14/ajHCg+x3ZK93puA1iPdGvrzVOWr33bijrMJv
         kIYUjSNC4PfxcA1+cQxUpw840eskaXd2XyTdh0wHGIkJOR4Qu++6S/j6epD9jFzdVFsS
         7mvc+u0MgM/Q7+cBxVE1p0t/tZz/xvxBs5ZSuPktnFJ65PXbE1ycjwGMkRp0nv3Zfzyp
         +itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720653101; x=1721257901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEhCvn/GX7ZGrfff/9by/aKOGF9XNJ6WAIBe9Hc6X/o=;
        b=ryUGkhmRO+VNImGBlp/9WqO/XbXF5oMtl9kyma/E6h92EqnmW6uTkuIxRrkwPDnHzx
         rxXopaL15MnKFIMTtenQoDE6JZwg5+5dglVwVX9psB4d5mVOo+QzFHz2dVmxLwDEeny0
         LNOfITaXxVr7vmtDOV0oHTkuTW0uNUQRtteuoHFcAgokCManVHzO6td+00g8bm09K9K5
         6RYfmKPxsH0XovET9f20w0Ai0hzM8f6GBDz2jgu6RLesRNlHm0k2kNIOYHLc+IHCJqRV
         vbVD7TOCuyFVzsN76Kc0UBZN2m9cq17Acz1olAuIlFmHHHOEtIE9QuZThCzzG8Vp5WEN
         jGYQ==
X-Gm-Message-State: AOJu0YwJhf8rMYF+tIUTJ01rsSitEuY1zpvZO82alWLU8/vFNm30NyIN
	Py7pao87JjI3HA1mON6nGdMVzpDzRWSuLrrCzTP0Kc+DXeJgDH1OaLBhE+j4bWk=
X-Google-Smtp-Source: AGHT+IExmycMLvnDFaXZEThvlqZBHKo7LE+i/q6ctG2s0tW1dLWywzdcAgXNz50GUiKm/bmhQw3BxQ==
X-Received: by 2002:a05:6a21:9997:b0:1c0:f288:4903 with SMTP id adf61e73a8af0-1c2982232b7mr8554735637.17.1720653101016;
        Wed, 10 Jul 2024 16:11:41 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b4397c50csm4458126b3a.147.2024.07.10.16.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 16:11:40 -0700 (PDT)
Date: Wed, 10 Jul 2024 16:11:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>, Guillaume Nault
 <gnault@redhat.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] f_flower: Remove always zero checks
Message-ID: <20240710161139.578d20dc@hermes.local>
In-Reply-To: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
References: <20240707172741.30618-1-maks.mishinFZ@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  7 Jul 2024 20:27:41 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> Expression 'ttl & ~(255 >> 0)' is always zero, because right operand
> has 8 trailing zero bits, which is greater or equal than the size
> of the left operand == 8 bits.
> 
> Found by RASU JSC.
> 
> Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
> ---
>  tc/f_flower.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tc/f_flower.c b/tc/f_flower.c
> index 08c1001a..244f0f7e 100644
> --- a/tc/f_flower.c
> +++ b/tc/f_flower.c
> @@ -1523,7 +1523,7 @@ static int flower_parse_mpls_lse(int *argc_p, char ***argv_p,
>  
>  			NEXT_ARG();
>  			ret = get_u8(&ttl, *argv, 10);
> -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> +			if (ret < 0) {
>  				fprintf(stderr, "Illegal \"ttl\"\n");
>  				return -1;
>  			}
> @@ -1936,7 +1936,7 @@ static int flower_parse_opt(const struct filter_util *qu, char *handle,
>  			}
>  			mpls_format_old = true;
>  			ret = get_u8(&ttl, *argv, 10);
> -			if (ret < 0 || ttl & ~(MPLS_LS_TTL_MASK >> MPLS_LS_TTL_SHIFT)) {
> +			if (ret < 0) {
>  				fprintf(stderr, "Illegal \"mpls_ttl\"\n");
>  				return -1;
>  			}

That is correct mathematically, but perhaps the original author had different idea.
Could we have review from someone familiar with MPLS support please.

