Return-Path: <netdev+bounces-64167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C439E831880
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 12:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9655128A64F
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 11:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C868A24201;
	Thu, 18 Jan 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="T4Ou9e5X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F55A241E9
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 11:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705577560; cv=none; b=KoES0biqL1o/wZX/GWn04qn3I26qLPRXs1vZsECQhGb53aDP0ftKNh1AkaST/ZdKVYgFBPYImtbroOlPqSdzzu/2DEn9IazVADHzhpTLlMhTNTM4Z3FRf7dTmMVpwpvTEqBer+u7eo4CdEreB4kxUnhN5TEcclIuN5WuUNY32JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705577560; c=relaxed/simple;
	bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sX+eXA7DKyBVlwFe9L7NMuGBgGBK32WTgrc6qH+VctZBw8IUUZK29yDGUvWIjcWqQzecs70aKs6vULkBrTrfYcMPCXfKSSYxRsdqzqZigSdgRoHJPrWZNNGdpFuVbc2Y9LQLEC7+mgfZFf1UvBx88h12ReBqZsDW2P3bUv5tlgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=T4Ou9e5X; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso120030966b.0
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 03:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705577555; x=1706182355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
        b=T4Ou9e5XcaUDtT+hA1UhKdNYI6UMu53OFVYkKRz2RUWrVUCmigH8AR3Pf4rNMHJmmV
         FEarapDyo1D6OJPBxjL9nJSfPhTrPP8o+uyclYjm84fRxgUKFs5BPV43Hm8G+cYRZTgq
         oFAZ1UPjpbJytrEIE87qUmVXJ5bocXaP9RsBNNNM1nS4HRAQPHs2rILGIzbq3Egq393z
         1a7cMDDRKwVQXKW8sYxeTYaT7NaK4thght6TZXE7aPIWmpKZdK2TfmLoqHWBQ1ndbG9U
         AGL1mcU++vpD3qLT43jEkDz4jFgaK/dNuGm2I4re0kiyUiO+QSu0mCdMhbq4TkGDBVVZ
         NTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705577555; x=1706182355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7X+XE/Gzv4Nomb0fLlmWLJhVAVM3P5M7gZDV8sKCsGg=;
        b=ggaHs8/9HX+kNHVsB+HUB5/xaWlJHVU8+gR8FBYYwzNpgZsrc77BzMM8jdG3toPEqU
         QACQfB9rOEBpRmcBnosuODPPtzASRJDkQoJ6DsMG0pCs6G9uM9I93xpFolKUPkTPu0BS
         uoKeINlHw54D0ifR66NNjXzhS1hjttv1mDOdd3OXZLc9BzUCtYDoUIlH+Hq2ic/fNnJy
         luijWSWnMY9acDrMSNzGEvBUjEuk2hNjjxsg2fSluutKeeSfyLDIimNs9tNuuk/c0Oya
         V3SN2LcG1qn3NPPGiPrHIep+KVPyrMUeb8653jo9VbghvlU2aMo5yuEFEQbp+KHft9lS
         iWmg==
X-Gm-Message-State: AOJu0YxB5dSToo46EzuhptQtIsjo29IWR3PLoq6S6NaRYB8KOmwBAyIi
	89qI5mda6Ba4dD3EUo22zp0vZl4MlVyE6fBbQQs3qSjBRvi8xI/EQmnVtZkL6pI=
X-Google-Smtp-Source: AGHT+IHG5LK0M7+mQFfqN9srL30ZgOLmu9WSR0nvuerMb9IulZ2RiBgrBqFZMLSnhs02D8eEwF4Xnw==
X-Received: by 2002:a17:906:d931:b0:a2a:212:cfe5 with SMTP id rn17-20020a170906d93100b00a2a0212cfe5mr732923ejb.12.1705577555430;
        Thu, 18 Jan 2024 03:32:35 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00a2b1a20e662sm8934043ejz.34.2024.01.18.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 03:32:34 -0800 (PST)
Date: Thu, 18 Jan 2024 12:32:33 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	milena.olech@intel.com, linux-kernel@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, mschmidt@redhat.com
Subject: Re: [PATCH net v5 1/4] dpll: fix broken error path in
 dpll_pin_alloc(..)
Message-ID: <ZakMUbC9xLzjkZwF@nanopsycho>
References: <20240118110719.567117-1-arkadiusz.kubalewski@intel.com>
 <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118110719.567117-2-arkadiusz.kubalewski@intel.com>

Thu, Jan 18, 2024 at 12:07:16PM CET, arkadiusz.kubalewski@intel.com wrote:
>If pin type is not expected, or dpll_pin_prop_dup(..) failed to
>allocate memory, the unwind error path shall not destroy pin's xarrays,
>which were not yet initialized.
>Add new goto label and use it to fix broken error path.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

