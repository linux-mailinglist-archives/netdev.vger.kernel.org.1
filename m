Return-Path: <netdev+bounces-147550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A89DA1C4
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 06:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4109F16770D
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 05:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3F281AD7;
	Wed, 27 Nov 2024 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="gmhUJ7kU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C188A28E8
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 05:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732685889; cv=none; b=L0H6A3glhvTnju+wJpSiGq/tg8sNgzATq+yK3M9mlxs12S1Fm4q2LznmxTNgtVkuVnAvUfZVfLVNzz3TM5zGKHhnSPFzziPehN02EaTIgs8dWGIkWsTZCMvc06oQ1CN4sPX2o3TKZlj8kkb3aW3KwCxPEAbHEHSOmtvSpjHAhYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732685889; c=relaxed/simple;
	bh=8aeyqr5ycB/6tEtgn4hUvtFVbp5yZaFHKI5YGbw8UiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4dyacBasARzg7bz1YiaVCedqHiGxFRvX85y9WrRSbRv6HTIMVViqYxTSfGUeY8Zz6fJPnAc/xOxjf6o2SqNSvV+fq4UqhHR1eynBVvDIxnk7il2t5c2KwOV7HSeBf9lIZc3gk2N+kMBE7Q3HEvn1eSdaE4iGE6Q/maFoCqg+oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=gmhUJ7kU; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-724f1004c79so2988763b3a.2
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1732685887; x=1733290687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fo8urVq+K5pUhAivNz74bKU6iVbtTmbZUHBipiRB2SQ=;
        b=gmhUJ7kUpCVQtMSzxGVVVia1cPK1hR/JTi3EAmsp6vhO7tvQHCvQFhWISaaeWw1eTA
         mNiKEsgnfSz1tWDKkrKUxee70jSuOdiwVLdShi+maxOVSrcoQ7B1GzdJJbKwsLPnXNCt
         yCpRGQsuJAAqDgCaEpFFRA2cc65AHluyWqSngpKs1O7d9jHiXa0v039SLVg/DR0as98F
         nupUn9PpycT4/NRfETMnGoEfZtU0JLQe45UAXMfuMymN6t4wmIvL2yypqA7rBrXzSOG/
         eCFADv4Se8vc/M8ujALEpdtfGDRP27vhyXjCkoKsOjwfaSIYLdfaasUNSH+TTl6CDzT5
         xLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732685887; x=1733290687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fo8urVq+K5pUhAivNz74bKU6iVbtTmbZUHBipiRB2SQ=;
        b=o/GOXzDuKjkUnu9GjCkwr8Rz1BBXVcawRQOnHux6RIK14N8nAiJ43BRrQG3Ctk2iD9
         DZwJYrG2iomSxxhBIR8PkenzGfJ8yMt1D+sk5brgBApOKaRcn/hmXVg6bbn+WW/2lbUj
         hcXhjrRJFF4nBo9C6SHm1BQNrDOg+2Lo8yv7/bLecvIvRnG/RUoAHuAhG+5uKwJynGzZ
         56rOMJj6n0p/As/FbcDF2QsnnY0OlYLdwk0DCkCM7VdajDFhJNcfmGJHvL5Ju2A+0DJ/
         T3rL25rtcWAbFbrk0cCuidsPokP0nBihoEoFn7TiuJSSle5UYS7AMh+g3Lcf+P0E60c7
         LeMA==
X-Gm-Message-State: AOJu0YzE0oDeTcaVcKD28IfTBpbx5gFQ5TmrFYmLX+8qNG8UtDCfVCRu
	BcV5v7b/RL4SQnpxgeoFkOY2Cv4Yt940rR4PGg6bVcpKm/7nkwXoUWc4NTgpwXs=
X-Gm-Gg: ASbGncsSCA+pwCaBUxIk14hjZer/8UMX24gc0d3/9z/ZVwram8vZR+O0OGnPPdSHjZu
	zHleykuwlxtuVocKCPnoXZ34oc5W9Fd+yT59Enc40YCgFHOKYZtU+xDtXevzyYdPdTSFRRvfB0D
	x8obsexJLZvoC5MYO+hSxRCdA3tG6irDIIjXysgA2VfapHbbqg4ZvyfWSjaDIMhWPddnGEvG+tr
	wBiiZcoAI2svY17VydqBr0lDQi90KOTtPD7cmY5SoxAJ5c1erEl8WWl
X-Google-Smtp-Source: AGHT+IE1f+MKOHnDmFgRkUTxLrJ7GUTOkA1AhEgoF4PLFIZMN3BSevG3zt138M1Oli4LQlPmhip1Wg==
X-Received: by 2002:a05:6a21:1798:b0:1e0:c7cf:bc1f with SMTP id adf61e73a8af0-1e0e0aa8a7bmr3164497637.9.1732685887104;
        Tue, 26 Nov 2024 21:38:07 -0800 (PST)
Received: from [192.168.1.11] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e479ad69sm8954827b3a.173.2024.11.26.21.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 21:38:06 -0800 (PST)
Message-ID: <7741c66f-ee1f-4783-baad-9335df6e3c20@davidwei.uk>
Date: Tue, 26 Nov 2024 21:38:05 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 3/3] bnxt_en: handle tpa_info in queue API
 implementation
Content-Language: en-GB
To: Somnath Kotur <somnath.kotur@broadcom.com>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20241125042412.2865764-1-dw@davidwei.uk>
 <20241125042412.2865764-4-dw@davidwei.uk>
 <CAOBf=muDXtrsMMszA+Y8raaT7cGYrotU88s2YMN9B2r80gcm_Q@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAOBf=muDXtrsMMszA+Y8raaT7cGYrotU88s2YMN9B2r80gcm_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-25 22:33, Somnath Kotur wrote:
> On Mon, Nov 25, 2024 at 9:54 AM David Wei <dw@davidwei.uk> wrote:
>>
>> Commit 7ed816be35ab ("eth: bnxt: use page pool for head frags") added a
>> page pool for header frags, which may be distinct from the existing pool
>> for the aggregation ring. Add support for this head_pool in the queue
>> API.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>>
...
>> @@ -15545,7 +15562,6 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>>         bnxt_hwrm_rx_ring_free(bp, rxr, false);
>>         bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>>         rxr->rx_next_cons = 0;
>> -       page_pool_disable_direct_recycling(rxr->page_pool);
> Intended? Not sure I understood this one, while I got the rest of the patch

Oops, not intended, thanks for catching this stray line. Will remove.

