Return-Path: <netdev+bounces-191512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10AABBAF2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC9267AE105
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344E62750F8;
	Mon, 19 May 2025 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFL+mKx8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6EC274FFD
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649981; cv=none; b=L7/MfITxaawB88E02JY7aiXfQXSsCymxb+Q2Dyp0SJN2Y/XYMr7t/SVDWTcMH8scKjvZVJI+eaB5JWCF1Tj6NtIBSG7mPBFmrs8+GF81z4lu4nJJIXfwrqaDaCZZJSu3nCRd8ZuVSe0kgKlT88nqj7jenWEE84cvlQEQEJJfa4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649981; c=relaxed/simple;
	bh=GQPdAJgH68IIc9mT+fvqXofapRWMcyOKv3t6CE8UCos=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=pn0hRI5U69626vW3cbk0kBE5fiXfyorNoGNCd05w848oM6+ISQM+bQ32i3vMLQsNnNDlFfa8fEETwLM3Ds77we4TK2eDag9LlR8s0IqMf4Upt2A4eBIY4OA2FioW947Q81/8O13TwEXjdRHAxdM++ohm+KIRmgNX4Hca05Mge6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFL+mKx8; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a37535646aso272671f8f.0
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649978; x=1748254778; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHn/bhUwowMVfB1kTXdgaXuPPUnewAJnniffTVcH5a0=;
        b=jFL+mKx8YIjrzVlyT8BPs51rZiX9tw/ZmTsXSMLy925G33ym4VTScE3UOLxvax3aST
         h2ULasWEaBAuqAW+xGpLF+q9haAmzU2CIMjYNBW5hhcyxaKpk+mU/bXOE+034xo85Pf3
         RGgmdm6m+BWJs04SpTwPHh1/FsHDEvfd79WaDjsTlHUwFextZ5NFQ+K/TRl/6CREfLUR
         RfDEj3daOaMx586H/8TyCkG3T4QhPZ2zKnS4/h6TamGITOc0x9vje7sDIur1wqqzkP1d
         eVwcQmyG9x3svhfSsnrTnVljG1YPeD5TZdB3sHilU7fm45V2sQ4qQlfBkyVwc6YB3atw
         rscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649978; x=1748254778;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHn/bhUwowMVfB1kTXdgaXuPPUnewAJnniffTVcH5a0=;
        b=ZzqCm6frU9ueKFKQE7pO3YkXnJWpQt9hTTAjS+pXh5le3RyhlLJRG8OEPLM21byrU3
         9AF9LCi9lhUW5L6PlzEXf4AgRm2nZIU7XCZjDFL634alJOHWbj12hNE1Ai89q6/HB56A
         qiykMP6td1l2/JL/AYnsNRa+gOyT6GYm2zUI6qVkumeZS/0t7gQUaoQe1yCgh70KBnQM
         WaxAl3y2xNaOJ3QsnFQ5TVYHO+QUH1GPAA+V062/ctVmoKcbvJdWyKsgm6pYZoRLpBsC
         /Jk6JcgSZ3VkP8wVOGKCoaEndnalYcT/nOsY/bmAva+3PQdJrzYq/mel3UCSuDyIlWkK
         3piA==
X-Forwarded-Encrypted: i=1; AJvYcCUqMZjXLrn5CaEv6LHgl1KWz/DA5xMF11kmOrzELReWI3pW0XEd8eEbWeF/kZjUJeoh0yQYAKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADjerYSY14dwLR2PwDZt9P2kvraer4w+SHqW0r2nen35LU43B
	Tj0y9HHV9fFKBEIkPU1t+9YH6WC/F9eZtgYSUDE0LPxwOceg90eHualK
X-Gm-Gg: ASbGncv8aJTxWp/ygA8kEET4XGmfFnZShk+aVLskHpMHe7f8grwmVsLjKBGN9m/65VJ
	Rol4uTbaouZVpPGsojNZJHCovAADacPnMJrzYbfrXA81HlEKzKJr9hsc2Ko9k4hmW8RghD16EHx
	qgHYZrabDxwvqjLcy52ZE50gP8FmBrXXIa3WRFPrQqJ5U8eTevxkKf1hAPc6dfhzSmurLAHivSc
	hChW8iXAdPteIQHjCZBkyIbWVIYhTD0gmRjbsyE5RyN0sZTSbt/onLLtE7B98dr9yDP5YXpCCjA
	Yv9e2MPDANPYm6GRxh8iy12SFmJjVqpfLabOLa2ot+eFIWtWl10hC4QbFTOEh/CT
X-Google-Smtp-Source: AGHT+IGzkc6KLgya7drpt6lajzxZS8eyKDZMhWy+rGXy5ojlUz8ZPAk224coFS70C4CRWxTewPHK+Q==
X-Received: by 2002:a5d:4b8a:0:b0:3a3:62e1:a7ba with SMTP id ffacd0b85a97d-3a362e1a8fdmr7612110f8f.9.1747649977642;
        Mon, 19 May 2025 03:19:37 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a3631c728esm10824579f8f.60.2025.05.19.03.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:37 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 11/11] tools: ynl: add a sample for TC
In-Reply-To: <20250517001318.285800-12-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:18 -0700")
Date: Mon, 19 May 2025 11:19:13 +0100
Message-ID: <m234d0kin2.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-12-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Add a very simple TC dump sample with decoding of fq_codel attrs:
>
>   # ./tools/net/ynl/samples/tc
>         dummy0: fq_codel  limit: 10240p target: 5ms new_flow_cnt: 0
>
> proving that selector passing (for stats) works.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

