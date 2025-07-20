Return-Path: <netdev+bounces-208434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 699B8B0B696
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 17:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246241899F37
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76181FC109;
	Sun, 20 Jul 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="CDQuDsza"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF672601
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 15:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753024333; cv=none; b=k78opBTCR+IQzHlqreUTXtwMkqS6YTXmSLkHbv9Zxz6iDL57/F6b6xmKvxswyU5hriHjwxaECRTsvT4Aj444ijq8ZLYg+f9aVqs/wiRlpkBe7SQd4nRxu3mn0Ldgs0f0wZ/ygdW9/lgRtOoGnYk2QFQuASnIVKXCGhG1wDWaUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753024333; c=relaxed/simple;
	bh=+wWPzXn7j6cBU8Xfx33emHIYPjeekVUH0cQyrDuGPas=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXRZ7oGmua8fPT3LM56yAQwGWNmMclfpBszCTuCvUHiaAgra8G0MBY+5C5fgyJoHiw1WRdk10zBhOgAy4pohBuzlJmQhmnIckJA7NzmC6YcDxHjNRVdr5DJby2FrA856EopVNQzLJyMzygGt5o8hsTJ9XVH+nT3KIQoF55x9S/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=CDQuDsza; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e33d36491dso524872885a.3
        for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753024330; x=1753629130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qln17kcGpojq11as3mDgpXVTqzf6eU+vwBTJIqScZzo=;
        b=CDQuDszawMZl61fyoFgcUvOgn+bgPHw6iU7+JaOgMloR8k3ga46IX8xC3+ox8yZxSK
         Y7LtzlcGb4KlMCGtIbpWK+O/OscJ02CGuslq16isoFMaoa51Zmy2b8G6T5L3z6uO0Ajv
         eMp/mdEGOj6hI/mL1T1FMyMbn/IPce4gGdQprrZxIvnLLZZ9zG+QtKvegwv097VOMBXZ
         kaH7ovVRXYl9kQjbwoS4iIUX26rQiDHDwP8xATqYWpAp5GoUKQBTw6YTLKJiLCvbn+4N
         feHlLyaYZZnOngsucODBpcG1HoDBK0Dg70YORZ/HmIyM+ppi+Fvj7x4Ri1waB0n2GMEq
         noew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753024330; x=1753629130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qln17kcGpojq11as3mDgpXVTqzf6eU+vwBTJIqScZzo=;
        b=rkGy2rEzQvekwotzeb8XDWLNIxnyFq1AIKtlbpm9Gc4UQZH1lgJZRu/zZ6Ck61qdYm
         dc7fGLUFpSBC2uLRaZWQeCDQr74sC0YPsc5ORr5pnnePwHtDSSSY5oGdcajJDn6zY0YL
         oS58lOyzjJiiztDMnWqLLeMHEot0sSbDyCLPoe1CrpIm6b1Fgtw+fKQQzblLwxFPKKZS
         m7u7lHwAAoHztcw0f/Sv7z8/89hkrNWtVYNH9cXpEYDcm/u90FcfhylIdSdlW/q39vhs
         xv2cueAFXR86Q4NOmyVspYYWD3GRWdmyJdpR0rqjM7dHN0G0OLvLWbAd1q+ruhx3f5ke
         ytyg==
X-Gm-Message-State: AOJu0Yz1hYEIMokB98UMhKgCW1o/i5x9MI439dTM2hdtBKGiNUuXbSv3
	dyDFHAofy3cc9gnv6IxhLMkmkCVc9Gq2Q/2QHERiWJBJzU1zL91t3t8qei/Wftw9gss=
X-Gm-Gg: ASbGncsNYqyXc3EuEOr+mjJHgCn54z9zlZfm2fMppfr8F5Fk/qbW9yZZvxHlIaZIo9N
	DLh/dUZOA7SCQRVyvGO4tbM6IzZl7lv9y/WrIwXTaIk30ynS+6A49P9D/wv6XJO0sWPjW9aFcEs
	o7KLs/JKoLI//YmhVf94DjsSZjj4ovOk4tjAvrFxcog93Abio5oKyiTdsbyo8orPiarCHhSHEUW
	mf9yNAJ55KQxjtDjCXtKfzGXZ5Z9BPFWxJLsAtdDoPbIIPhbeIyKeS+6VCve/M7+TD2trwpRhMb
	kcdN1B4usFmv2eofXCovFri50pH+Cbf+D4vd0ktS5E1eqx1g1YgrlUCQZnEnTfYF6vbPpjuAzZL
	eSILr3osp9vcBmQyJT24lHGNqMnria+w72pnyzJmjk62X+zNKC+WFnyaYEn1g6Z4xAiMSmms2ux
	A=
X-Google-Smtp-Source: AGHT+IEpLdtAsZoC8pgTnTpdVs4Q8hAyAxiUut6AuVjHNUmDwghvtD0IK8NIlPWCiLGZhdL5pbdtFA==
X-Received: by 2002:a05:620a:2699:b0:7d4:28d9:efbe with SMTP id af79cd13be357-7e356ae17fcmr1272373085a.32.1753024330270;
        Sun, 20 Jul 2025 08:12:10 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c4840dsm304026885a.67.2025.07.20.08.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:12:10 -0700 (PDT)
Date: Sun, 20 Jul 2025 08:12:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2-next] misc: fix memory leak in ifstat.c
Message-ID: <20250720081207.6d3d91d6@hermes.local>
In-Reply-To: <20250719101852.31514-1-ant.v.moryakov@gmail.com>
References: <20250719101852.31514-1-ant.v.moryakov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 13:18:52 +0300
Anton Moryakov <ant.v.moryakov@gmail.com> wrote:

> A memory leak was detected by the static analyzer SVACE in the function
> get_nlmsg_extended(). The issue occurred when parsing extended interface
> statistics failed due to a missing nested attribute. In this case,
> memory allocated for 'n->name' via strdup() was not freed before returning,
> resulting in a leak.
> 
> The fix adds an explicit 'free(n->name)' call before freeing the containing
> structure in the error path.
> 
> Reported-by: SVACE static analyzer
> Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
> ---
>  misc/ifstat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/misc/ifstat.c b/misc/ifstat.c
> index 4ce5ca8a..5b59fd8f 100644
> --- a/misc/ifstat.c
> +++ b/misc/ifstat.c
> @@ -139,6 +139,7 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
>  		attr = parse_rtattr_one_nested(sub_type, tb[filter_type]);
>  		if (attr == NULL) {
>  			free(n);
> +			free(n->name);

No. A use after free is worse than a leak.

