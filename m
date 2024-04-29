Return-Path: <netdev+bounces-92091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B430F8B55A1
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 12:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE1C4B20DA7
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C3738DFC;
	Mon, 29 Apr 2024 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b="0Aem8ms2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804662C197
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387454; cv=none; b=BzThjnXv7iRMWT/wVv3xFtEZOMXtqHyH9LGcOWcTcJYE35upGrELUhwiyoEbv+cAj3Nkmrba3y8gnesIby5CK+MrzW3zYX+VqtOTmx5LB5F5UewbAN25Dq4oxvD+NNdK1JPzXgiARZuczhXZlJTTRzKVq2PC+MDQwuhue85en00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387454; c=relaxed/simple;
	bh=WWW4jJmUkz6eq6NFyY9eAqM+cNlKyVxk2DhrPRZOzzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDSoNjxOLkXzjF9XgRTbswXr9tRq8JUQU2MKb8zUO+8i0x8TzQrsvPyuXs+YShJGoveI75vbSn9pXBlnqaaluGlHO8aEMK92+3sZ8CU7gYqzTfWZaHW2A2svODzJjms4j6gTtkpOgDZBrh8jzlaqyHigh7Nh1oNW8Z32Bw4at/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se; spf=pass smtp.mailfrom=ferroamp.se; dkim=pass (2048-bit key) header.d=ferroamp-se.20230601.gappssmtp.com header.i=@ferroamp-se.20230601.gappssmtp.com header.b=0Aem8ms2; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ferroamp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ferroamp.se
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-51ae2e37a87so5092519e87.2
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 03:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20230601.gappssmtp.com; s=20230601; t=1714387452; x=1714992252; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AxGXdLaG49wsUok5SI/Q6WlA5Yvf7CgNuvZBiRIiXng=;
        b=0Aem8ms2rvXVH6W5zaZLzSPOHrWEFHwaf+GDfW6++PHUPRk6Tl8ed/m6gkhqzOu8tA
         Cn27IK+qsQd+JV6SIblkUwd13DSazAFvB3Vm4EvjapD2MSrRitONF+gbt5R5cjUvqIxO
         8C75EAY051trMl5TM/0MumCG5Mcy0Gtj1EVzPDSq11qvRskqECQ5e7yeDwZGlr9Oh2MF
         Rd4d5rxGjvD2TZ0gYZVcd27oR9YJr0RyV62oRBTh6Grpjvf/neJBcOXyXAieoaZCwBdw
         4X27MiyH8nouv0D2XsqrgNchVEwEknv7y65Q84dTqsW1eb858gbYpW7QIvRCI7f2dcka
         Yvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714387452; x=1714992252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxGXdLaG49wsUok5SI/Q6WlA5Yvf7CgNuvZBiRIiXng=;
        b=ZB6WKbWroTOuCtYloRsMvVwbdnwTM4vs3Rb6u9zIVwlQXxOj4Bs3rMNM396StIwxEZ
         KA5+t3GRQXguo7lP5H/U6ftU+TYdZt/a6mqvkFHjr1s3mRa8y8ng6nsfeRvLB+KVICtE
         Fp8dcsEhVwQaCgZRRqF+IZPiH82UWivef1qQ7TOkp2+PFSyjtlZcvqjuDCD432FjS0c8
         GRtqDf9xG1yBQcVBCXdlR7Yu+2ZS3UzCibwSchgt4pAX9Eu4Wwf7nfSZd+OnsBl6Bzd0
         iroLCQxPen83HPkfdAyQ/WfjAQBynGvjZvgChjaptym7q8ul3jIIzGTVDmvrWNJOB4b9
         p6HA==
X-Forwarded-Encrypted: i=1; AJvYcCV1F8kWRWQzuMgemvfpizfbRlnEkkI7ii4lpbVmXAa/OxQzXs47VAnKFZxWdkbcV81XTgyQ1DD23AYMfSrU2Lkz5BDWq85R
X-Gm-Message-State: AOJu0Yxm5PJwzD1amwhk0+TDR7yc1WT8GHqPi2BPVxmFZaCWxTs3ZVtN
	eAV4nSnm9xaAn/+4qd5xpCbXwEdpT5Y1nCS7zfZAJCkzft/VPw1exL3laCKf1ww=
X-Google-Smtp-Source: AGHT+IFnvQgWvDA1Nx1bBbed604+4L0djD9dIBj1njLeiUy/YXqUO3fqKmRtQQcwkIcu7qM7cY2kIw==
X-Received: by 2002:a05:6512:55b:b0:51d:6741:8d78 with SMTP id h27-20020a056512055b00b0051d67418d78mr2630203lfl.35.1714387451574;
        Mon, 29 Apr 2024 03:44:11 -0700 (PDT)
Received: from builder (c188-149-135-220.bredband.tele2.se. [188.149.135.220])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b00518ac6f0b37sm4021837lfo.244.2024.04.29.03.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:44:11 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:44:09 +0200
From: =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrew@lunn.ch, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v4 13/12] net: lan865x: optional hardware reset
Message-ID: <Zi95-Yzrk-CslFdF@builder>
References: <20240418125648.372526-1-Parthiban.Veerasooran@microchip.com>
 <Zi68sDje4wfgftyZ@builder>
 <d5b4b3fc-8fbf-48ec-87d1-758a2d877f11@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5b4b3fc-8fbf-48ec-87d1-758a2d877f11@linaro.org>

> Please run scripts/checkpatch.pl and fix reported warnings. Then please
> run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
> Some warnings can be ignored, especially from --strict run, but the code
> here looks like it needs a fix. Feel free to get in touch if the warning
> is not clear.
> 

Very much appreciated! I'll hold off on any further submissions for this
patch until it's clear that it's desriable to include.

R

