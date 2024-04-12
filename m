Return-Path: <netdev+bounces-87425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 410568A3189
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 16:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7249E1C20EE0
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BAA1448E3;
	Fri, 12 Apr 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ABEjoOUi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C08615F
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933525; cv=none; b=MvvuF1fzF8/sNRQIHqPWg/zkX23oVauGNys2nyeoIbyg4qCEy8FjzmhbDOA9jI6HewGui9ZgZaWwyLUUKZYomDTfhLSfFyjSyIEwHyTmWCko++U2oif28waj3Gj9CAsER/jW5275OQf3rqgHrMKcoDTTnoKIKyWWBad4EucO3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933525; c=relaxed/simple;
	bh=tC4whiuUBgU0tgUJ07orp7mDp8lk79L9JcinxNXeTkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bPRNKksCjq/soiky2ogeVtv52O/hGBP96IiCJl/fEgaeMp+PmKccZXW2L+vvICT8UIoJf8LllpQxGc0GeGl70q7ukjXT1LHiO8WkFrlvn9GJ+Z4KV1oUrlMleaWhorgBJXg2zRHdtohPtx1noOMCjTnphHIuKdsDHTSqCm6oCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ABEjoOUi; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36a29832cbdso1444685ab.1
        for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 07:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712933522; x=1713538322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9qBhQRjLa3OV5PgQj8QLd5DVc7ylCIA4CAy8SLusss=;
        b=ABEjoOUiUIFFDmDL+A9G5GvI1+yER9Mp3Ne9M+902+JAR9hHZbxcVADxsVGEkx1cAx
         +UaxnBH1Pesr7AA1gTGoYmo1+K2jn7Ni2uhXJFnu2P9z/tdx5r7jcfYI9hSfNAEVyc83
         3sKoWNGyE6CPTHc5S+CcisQJcvGosrGKMHPlBg/FcOcYtrWZwNMyQvbT71gN9ZvQzphY
         NE7T4yu0L92TOcqE67sEEM33tWWl7Fhr+k9Sw+z5Q1J9OdFHUSjk+9CAJ1q7Y3IGf2/Z
         mofPIhFRCZGPE2BHAeeeBTWoCDnn5+mI2u/KUDR9x3x6RSsm+0qqPraFMsOOCOl0CDnE
         yjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712933522; x=1713538322;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9qBhQRjLa3OV5PgQj8QLd5DVc7ylCIA4CAy8SLusss=;
        b=LXychCyIvL2xQh9R50NQvws/Y8n4rsgGiq02KhNd/lGuR+M0g8ejyGC4S1k3Q8KRuq
         UXKzTPUIAbRdtKPOwHcCSDxwjToQOuHz139TPJQujGbzprEwYn5uLZ3xvtghKe4xuKRO
         9rq8gYMYqydKq9VCkxRqx/uO/DP/MgRouUSUSMzRRpx4rcEitae/c7enaSzrB/VZxJY/
         NBSATVCV2QiN4zTYiKbifqQwpEyFuKnQUMglApOEpBJSaUvc3P8m48xUnWVXttbAKevc
         dJHNNPHaRyhpiIFDQ85gecHo0Y3kM9zjE0ZLmoehJ2Aa9sjTxlgUBIDeNDAfojE7uFiA
         8GCg==
X-Forwarded-Encrypted: i=1; AJvYcCV5NcA9494+TY7YD2csKgcRcQthuWSWRNKwLpPWGYVQwPOQzYJBYZiYkeLWE8TMWE33seRFLef8s544F53KyFP5f9Ie52CZ
X-Gm-Message-State: AOJu0YxrWZmeYOFEzYNgE0kiDt0MZfIinSL2uwXwYW+yiQ40+ZCYFx5I
	Vjnlx+Z6COfeQse8MxTTCupjbhL4tsGGqMH7hcB4v03OI8GqvQaUUVltRJqBskc=
X-Google-Smtp-Source: AGHT+IHv7DmKcH3TmaX4OpLVohoHfoWGiH79kmDJuc8CsQfWLlOU2k3e6Ksflt+dUU4ChOMbmYIEZw==
X-Received: by 2002:a92:db46:0:b0:368:974b:f7c7 with SMTP id w6-20020a92db46000000b00368974bf7c7mr2927250ilq.0.1712933522433;
        Fri, 12 Apr 2024 07:52:02 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p11-20020a92d28b000000b0036a20dbcb17sm1029237ilp.16.2024.04.12.07.52.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 07:52:01 -0700 (PDT)
Message-ID: <9b172e19-1292-480f-a72f-6860c2084430@kernel.dk>
Date: Fri, 12 Apr 2024 08:52:01 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/6] implement io_uring notification (ubuf_info) stacking
Content-Language: en-US
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <cover.1712923998.git.asml.silence@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cover.1712923998.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed the patch set, and I think this is nice and clean and the right
fix. For the series:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

If the net people agree, we'll have to coordinate staging of the first
two patches.

-- 
Jens Axboe



