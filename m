Return-Path: <netdev+bounces-88391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7648A6FAE
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C51283515
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE220130AE6;
	Tue, 16 Apr 2024 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PK+gwsCx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D41130ACF
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280983; cv=none; b=Xq24xIHCOBg2lKIorpNjyevH1wD7CmtaUkaZCOYF6EkMBZNOHAoM+kpywccaZsAEP11yySSLBIQj2j9MzVM+Vj/iZTPDtIomb1z0VpbFDuqnyDtd/DtxtebNtE8bso3TFh7ZBmeZomTaZ+XVYvMi63wU5U24K5Jhc2Md7VyiKNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280983; c=relaxed/simple;
	bh=VgjJ1sQnYJM7vPGFLgOyl5MiheSdj8kCxc/E8B7aS+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T1iLOyqwdNt5pwa7o7dkyxkr/50lciCZEpw+MqvEshP3ezBwQAJU7s1UmA6Rxyt5R5qPq2o5Q470rlZe8mbB1jyo+lMXKMr4CMkQrllkmOPMDW/88vJRtpo1iR3qT96DlLb58/7C0eg9+jqwFU+airiZbnK1I+A/uNl3oakaDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PK+gwsCx; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1e5e5fa31dbso31800255ad.0
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713280982; x=1713885782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zno1kdsfWaJ1DeTq0hPq9ZAZ6Z0lEil6bV0PacUdpzY=;
        b=PK+gwsCxbzcZ7SjqnIbKPtxi2Gy4YpxFYZ0jffwDBF9DuhqpY/QieWu2AlgHnPE0iu
         ko1RUCAFixMAs+Bdsc+/28tauPNfxaOCvMPdAAosYGjHBfeC83KzWEljkyrwmLgtC5Yg
         wOY41jq5I+dKb3tSroPOZIJVaunsAmfVQ2eIF/B86lv4ac2Bw1f41JiCrU0b9aR37WTU
         z7Eq9nbt3wqy66rvvXMbhQazynTxWanLQvADnEhJuFVD0NGd4dFtk5MwfJshRVaG6HJc
         8ooyPDmxDd+QSyfMVohuGUDjgnwooWmk/iS78Km1ZuKGRbwXQIf1XB723fqkA8LOb0WT
         djmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713280982; x=1713885782;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zno1kdsfWaJ1DeTq0hPq9ZAZ6Z0lEil6bV0PacUdpzY=;
        b=NTadvGhFomjE2AZDpN/bSe27to1Rl3cZk3bupnZrEwKucnvqFPau8TAnsqfvPnerML
         Yjo88YD6E78jUcgPbLZNKb16C+O5tU1B561m6TNw79LoP9m8yTnYBQmKhMnKrtCugdoe
         I1J/7XCSzKgOI1ml8Pm1IGaEHDc7rI5f8KLoUuoOyzFEw9W2efhu9KDfKV5XU7/OTGmp
         4kiQg5E6Pp/LL8YtiFqeGW7ONcYga9Sxa2BVlnurxCOEBwanBgt48My6dvL2fyTNG09C
         ugTh5F58wFeLvRRo063ZtteBB3K7YEvT3cF4bpzx7I2PgNTGWd/EVLc5B+d+IxWxn+Vo
         zTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPNMpEtIv0B6B56HbvvK9LDQzMv6Tu3jDy82E0OjN4U1DatYBvo/jrmSzhuDvh874Yxg56aiCmJk/GmjpgyjGhWjcjWfyf
X-Gm-Message-State: AOJu0YwUKrk9wS5ubtC6g1lAKh8F8ZQrXa25rTnKksS6pFG921Hp2axv
	nMBhD7+r0y7fnP40qAFaSD7VOlDr8DEjMOlPSWKAtVHMW2gZCw0BX4PKtTOASC6SUeLN0Vz6q9F
	Plg==
X-Google-Smtp-Source: AGHT+IHT1pC5s1cugeqIXTNqxkxUA1cuAiRf5voHQMAwSwbg8G3jOgahsrnw3GT8HRend6+dNGkM2RXcehg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1d2:b0:1e4:5896:55fe with SMTP id
 e18-20020a17090301d200b001e4589655femr374739plh.4.1713280981894; Tue, 16 Apr
 2024 08:23:01 -0700 (PDT)
Date: Tue, 16 Apr 2024 08:23:00 -0700
In-Reply-To: <20240416151048.1682352-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416151048.1682352-1-kuba@kernel.org>
Message-ID: <Zh6X1NkQJd6ETTo7@google.com>
Subject: Re: [PATCH net] selftests: kselftest_harness: fix Clang warning about
 zero-length format
From: Sean Christopherson <seanjc@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, shuah@kernel.org, keescook@chromium.org, 
	usama.anjum@collabora.com, linux-kselftest@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 16, 2024, Jakub Kicinski wrote:
> Apparently it's more legal to pass the format as NULL, than
> it is to use an empty string. Clang complains about empty
> formats:
> 
> ./../kselftest_harness.h:1207:30: warning: format string is empty
> [-Wformat-zero-length]
>  1207 |            diagnostic ? "%s" : "", diagnostic);
>       |                                 ^~
> 1 warning generated.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/20240409224256.1581292-1-seanjc@google.com
> Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub!

Tested-by: Sean Christopherson <seanjc@google.com>

