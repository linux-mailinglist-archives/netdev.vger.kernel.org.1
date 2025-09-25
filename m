Return-Path: <netdev+bounces-226252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6614DB9E85D
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 11:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940321BC1339
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63D2E9EA8;
	Thu, 25 Sep 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JUPc1AGF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36776286D73
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758794197; cv=none; b=nlyqUnvw27sU8898hSowBliDr68EKIRs0JxncKmvvp4ygSKMBsML977z7AnblSlmrKI8t5Q5An+F9oUbTmRr87K21BZLHC8I9iWvcVqO5B6PFskrBwpRDQXwZSygDNUXHjmoNyR9z7yvw4GkQ+S8abGcChJ/7NqAxQKh2BcWcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758794197; c=relaxed/simple;
	bh=GrzEpmFKJ08dCvz23e91yU1k/k8cQAq/gU1NwyJoAlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gNDEoxyrJMgmLmTMDKTnKbA0Mwol+R/AAnkGa2YY3SMfaI0EghiINiTZoyeQisWrXc6oAyQT8jiW09Z2TjpuVRD1Xda1ykgN6fOXix08k7k47UNncDJXaEG3W4knXdXEkTVghBdsqGGvXnWo3VxnN5Y4Rt/roGIxIeTJN2gsTiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JUPc1AGF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b35f6f43351so68408266b.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 02:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758794193; x=1759398993; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GrzEpmFKJ08dCvz23e91yU1k/k8cQAq/gU1NwyJoAlE=;
        b=JUPc1AGFfk3bjU6Ufb4JhAfMZKUcOfnL3Hyw2J55Hdl+IopjX5xQXs6bGKpOo3Wj19
         5wH17qzQO3PyOqz9/gHl9SCQrZoDwYRoD8BCpGzidGZnYKHM6l46avJM1ib3jHeN8xPx
         JkFc4xHda/XzmLmF4rkDUky8YDm49FcYjsgB5ucLyCpE+PEkBPkptNHoz9G60HzI8ogc
         +d31ZbA9MyRPdFjQ2dOe5K1BppfQo+s1v8nT8F1FQ7CtxrZnImqew/vnelt+zLn5qbir
         H1NMs7ZcKcFpwkDOE0Rz1m8TXnVJxz3JIXb7BVxHS5/5/19tQv0Sm8vmLaM0CzR1IXG0
         nTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758794193; x=1759398993;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GrzEpmFKJ08dCvz23e91yU1k/k8cQAq/gU1NwyJoAlE=;
        b=I42TQhdWk9VfGfOpOsN+Q4hOQAm697wXc0PiipEVdVAPq4UtY90z4rAjvLJYXou0XB
         Ry7Dt484b1yEExVBX7cClsBvphSiDEQZIUU4no0v2UfVkhLv8h1r4ERfgaBqU7d3rGBV
         TXolp7N1HxjVLD0d1mpXRhL2zgFM/hQkhwyNW9XFOoj2xWEDZLb6UZhB6gtV21LWBa/u
         NWL1JWUu6klojrT3NoYb/s9jCWNEF848YWBkWD43qLGZGFg7PC/Y6wDcyqBHK3uw2YEE
         /yvhBuvZ3b/Exu23UtSJLvPTyohDDZBbn+YjQydyRqdMtj280gU0ozgSQu1W0ST+/YUk
         7nNg==
X-Forwarded-Encrypted: i=1; AJvYcCVCrV+HCYig5pWJ6kytDBZmplxG0QSuI4Gih/4CmOOPxkW6f3Uc78VLTBr30bkEOL+KaeWB/t0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMSnODFmNeaUiqjtzCo/DiFhJUenmNr8JV1MrRSrkJkEi3BkeV
	Cc69EEsdTL8QOClzVKpQN3aBHFK42/Es0D4X12qshSWaQrkY0uxWsCkpDNwMF//fRpk=
X-Gm-Gg: ASbGnctjZUyDoqNf1ya05AsKEVKcUyUS3D3A8V4vjIZMl1cl/4zmguefBzInD0vGlDI
	b+NqzKcDxaSThRxDg9bUCZxMjdp72h1t/ZLxmU21lHPLp/NYR9EfWwu8J2m3FYieWgEKqtADX+p
	qb1Hm+4gfpLY+Wd552bhmURus3Ue1omgLlOFHz/M9TCsgK25qQthOgTPWwlXoEsG2wgDXVYXM4Z
	d/tUomNHxlOv+MJ7Mjp0Pp45hry7yLDGd8t3KfwRQyA6lWRFNKDflcTOg4aGk9CHsI3Dkaq9WDD
	D+RqJ8qSfJ+V4j9f7OOy3xu75c2YkwEh9/gatB7v5LkCtulUAxcRWGQliXHkr6MDjP7IA2vOpl9
	cEXGm/hwOf8MdKtg=
X-Google-Smtp-Source: AGHT+IGKjMEcIpRr3EEKuOD0rD2TCapZ8lHREep6jZzrzi+iYypOPWa4NYN3C7vTMs0QmrtjLXw5IA==
X-Received: by 2002:a17:907:9719:b0:b04:6973:1ee9 with SMTP id a640c23a62f3a-b34b7105a20mr277447566b.16.1758794193333;
        Thu, 25 Sep 2025 02:56:33 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:295f::41f:5e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fd0a54sm135005666b.86.2025.09.25.02.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 02:56:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,  maciej.fijalkowski@intel.com,
  aleksander.lobakin@intel.com,  jacob.e.keller@intel.com,
  larysa.zaremba@intel.com,  netdev@vger.kernel.org,
  przemyslaw.kitszel@intel.com,  pmenzel@molgen.mpg.de,
  anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v3 0/3] ice: convert Rx path to Page Pool
In-Reply-To: <20250925092253.1306476-1-michal.kubiak@intel.com> (Michal
	Kubiak's message of "Thu, 25 Sep 2025 11:22:50 +0200")
References: <20250925092253.1306476-1-michal.kubiak@intel.com>
Date: Thu, 25 Sep 2025 11:56:31 +0200
Message-ID: <877bxm4zzk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 25, 2025 at 11:22 AM +02, Michal Kubiak wrote:
> This series modernizes the Rx path in the ice driver by removing legacy
> code and switching to the Page Pool API. The changes follow the same
> direction as previously done for the iavf driver, and aim to simplify
> buffer management, improve maintainability, and prepare for future
> infrastructure reuse.
>
> An important motivation for this work was addressing reports of poor
> performance in XDP_TX mode when IOMMU is enabled. The legacy Rx model
> incurred significant overhead due to per-frame DMA mapping, which
> limited throughput in virtualized environments. This series eliminates
> those bottlenecks by adopting Page Pool and bi-directional DMA mapping.
>
> The first patch removes the legacy Rx path, which relied on manual skb
> allocation and header copying. This path has become obsolete due to the
> availability of build_skb() and the increasing complexity of supporting
> features like XDP and multi-buffer.
>
> The second patch drops the page splitting and recycling logic. While
> once used to optimize memory usage, this logic introduced significant
> complexity and hotpath overhead. Removing it simplifies the Rx flow and
> sets the stage for Page Pool adoption.
>
> The final patch switches the driver to use the Page Pool and libeth
> APIs. It also updates the XDP implementation to use libeth_xdp helpers
> and optimizes XDP_TX by avoiding per-frame DMA mapping. This results in
> a significant performance improvement in virtualized environments with
> IOMMU enabled (over 5x gain in XDP_TX throughput). In other scenarios,
> performance remains on par with the previous implementation.
>
> This conversion also aligns with the broader effort to modularize and
> unify XDP support across Intel Ethernet drivers.
>
> Tested on various workloads including netperf and XDP modes (PASS, DROP,
> TX) with and without IOMMU. No regressions observed.

Will we be able to have 256 B of XDP headroom after this conversion?

Thanks,
-jkbs

