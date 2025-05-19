Return-Path: <netdev+bounces-191511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A42ABBAF0
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 12:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CAF87A8887
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2958274FFE;
	Mon, 19 May 2025 10:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FW9NavSS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE354274FE6
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747649979; cv=none; b=TAFWB5ukRBxbB7yzseY+tcUrLRJbFhVLHNFjUnJz7SxZL3JDjCyHK1a6Y6njBZvEy+PIALQhIyTz9REsOUtlCGsz4Oa5sY8EIg/4rQ1A+W/CWhQWl1oY+9EMEVjyTUuB56rAKxMKEqkl+ZEj3Co48y5+cXFLhUTRPgCrayakoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747649979; c=relaxed/simple;
	bh=kO8G3sy6c+3MCSlYI9JrwQb+k7zTplAkBbpVGJQRU74=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=XsU0gp4whcxJ7Xzzr1vqXIqkv6rBSlm8dqFggMeB0xXbKinWAX77bGfRzsi6ZS+4kpx21wAo3Ax9LL5rf6sw8dxD5TT5UTwYTik87uDST+CBSDNycsqE8Hcql5bD4j2FjVywpFpqARCkmmr6XSmN/FdnuQqTiwU0+3xK1Vsd+ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FW9NavSS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so46911395e9.3
        for <netdev@vger.kernel.org>; Mon, 19 May 2025 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747649976; x=1748254776; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kO8G3sy6c+3MCSlYI9JrwQb+k7zTplAkBbpVGJQRU74=;
        b=FW9NavSSVbsKQa7yF1hwB6PyjuJ5mUZTTwwhjdXoCW1eYHKD7/qANDxhSTpAw2PfrV
         TDx3jPliYmHB0kW6itoG1iuu8wiHsD0u4xXf28wPznvVBdxFXxFcHAQXhhQhIbm3GczB
         oDk+Dkgp4Ma1e69E6G50T/hw1nXlO9FnCOjRDqMyxhQ3qu1PCpX4IUvEBwNYS3uUTybz
         qAu2pxaF6Nw/TA58fqDI7q7ARl24lhH+VpAfYI1h380VeqL2iuPEDdsxPzd+FvuyGjAR
         TRdnOnUL4IWppGdhal1tuOIXaUccyRK43FLMkpueTJjbbHxzyF/z1QndbG7ZBP5yeTMg
         Jp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747649976; x=1748254776;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kO8G3sy6c+3MCSlYI9JrwQb+k7zTplAkBbpVGJQRU74=;
        b=e7wc90gV22TIOf01HVZ88vnv9zRPOHC3hk1VMDUl2NZSdrIbvgEySo7YHJ4CQ4iXwi
         LblkQcHgeQ/wu2oRVdANOszeqpG3NNS3Z2HrVgILM2nI9vG7tdVAhnLJL8uzRhtVdHxP
         yzy628NW16McvA4+oSycu1syHDZzhEz03LkWD/vL+ADRCi+8pbapAqh1M1XHjNHQukU1
         E9XFMhYB4dbNWJOyeA0oHI2ttPLj4InVGw6hXJAxXo6B5neEeLuWxN0zR1zZpaNK0ZBt
         EftKOT/k7KDcv4Dxm5uFc1Qb+JgORcoKe1cIcQSfdlM065W+MHgggeGLITRXOL83mSKG
         lFaw==
X-Forwarded-Encrypted: i=1; AJvYcCX3e+EyFAjGN0KFvOtd8OzPDIBK14L38ew38d66e86t8W1S6v+kSLQ0xNmhRtkCmEQirtLMN70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs7KkVaANNw2rxCpzKGQMvuSQPOD7QPZkJBadHKE1+djDBXS5O
	6SbQNJQgrUPJ33XvzxjX6X3e5HT5SxFfjuo4a4cRL6V+E5j3dlsILO6v
X-Gm-Gg: ASbGncvSPzgry5+VlPcjgBpPRLZiYTvAfmo7z2De1fICcxllNB5/g20d3Pm+Ws7igo3
	6SMjjlenAGc6ozv8CmEG3B7ZRKV09XlBp03ncHNs8ubcZa6O4gcGGi7nSUdkv7+3GqityZiquca
	f7dngrxyqWjAU2wI9E0knvxIpe4ZVbgg1IWfl2MEcsdrtMowDiMEND0Cbwmd2Z3RNxuG9NwJapl
	OXlsXKOS6XLbpRDCqwKQJdyoKpetZ7dm9vLBE0UBo/ktohfJ2cj1WjYL5UlZ3yRG2CJY6jKkEj2
	YOenXP331+06Y1RKmzmYP1c58XNF2mH0xSANy3YognbUZIy6T26pvq+pMTwzEMO6VUf/7oRrQ0Y
	=
X-Google-Smtp-Source: AGHT+IG7SqVCqnPWKiD+U2bMAjcTts8ji/txGFOJrFZME2cYq1mwP7KfNaLtYoxWCBhTQh6BjxcWMQ==
X-Received: by 2002:a05:600c:1c87:b0:43d:4686:5cfb with SMTP id 5b1f17b1804b1-442feebf434mr85377775e9.27.1747649976062;
        Mon, 19 May 2025 03:19:36 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d5e9:e348:9b63:abf5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f8ab839esm165108005e9.17.2025.05.19.03.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 03:19:35 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  jacob.e.keller@intel.com,  sdf@fomichev.me,  jstancek@redhat.com
Subject: Re: [PATCH net-next 10/11] netlink: specs: tc: add qdisc dump to TC
 spec
In-Reply-To: <20250517001318.285800-11-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 16 May 2025 17:13:17 -0700")
Date: Mon, 19 May 2025 10:27:07 +0100
Message-ID: <m27c2dj6hg.fsf@gmail.com>
References: <20250517001318.285800-1-kuba@kernel.org>
	<20250517001318.285800-11-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Hook TC qdisc dump in the TC qdisc get, it only supported doit
> until now and dumping will be used by the sample code.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

