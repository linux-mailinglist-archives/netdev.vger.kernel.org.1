Return-Path: <netdev+bounces-116127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C8A9492EF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16831F25106
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4988D18D658;
	Tue,  6 Aug 2024 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0hReFMT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316518D654
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954452; cv=none; b=nqYn5vOw3Kws82zV4tg62wgjVGJPCLCp2jy1xWM2K07UjmYaoqpG1IFMpO0ClPFFl9rC1F9lCBkPPUJItnLiJ93VuBr4c4ATnHJ2yl+UC2O5wCcHjMOIlCqY9TujLfA+jSSv38Yk41IHLiUlWZR/cuVD2ZzRH1hEsN24e3SgJ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954452; c=relaxed/simple;
	bh=6A6Z6wtMJ4IifNFiO+3mFcWsHN6xrDEMe8MJrzw4aoI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ORg/VArcsny7ZxDJNxw6Z9FjVR3z30VMYjFVCmQQX1wXjI1mytTkK02J6q/rSftsVp3AJtelhg6eI1FzAUpgXgGrwjySoq21Lxnu+GfGlGQKSZXhX0YcOqqg9VSPeWjonj6XswJjqQmdpHuQhzCX5ZYnpqFRADv5ftLe8mdh31U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0hReFMT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42812945633so5663955e9.0
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 07:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722954449; x=1723559249; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IV696Km50Lb/1AAgh+E6HJX6VAcmjcEF5Xm0L1QJ3aI=;
        b=m0hReFMT6ts55bByanC0W0B2lx8uriFNIjUsG+Z9mhHDT3W2/mdWDAbOVBcoGSlhoX
         EM1eBqTCdkYkOE4YHo7nx7Bp1lwI0GPQuWTDSAsLiaJH3EPDQVBmbksWg7DYIfawx0MV
         B0/MEVX5czSmANzuBgcVgmvIRN1evH0Orxiuvs77eN38OV8AZaOdPHnJJybVJRGk8iA8
         DrFNe+41JjkEaGQ5AAQvG1cImi0L8aAghMPaxHwNXmt3d26LAvLUnviq/HPTUZ8tRtLq
         VF3rq5uhqUsE/1b4sj42Uu4J1TDmsEor+BGxjglIB3fyeYJk96fjJ+4+BCChybTUZN7j
         we1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722954449; x=1723559249;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IV696Km50Lb/1AAgh+E6HJX6VAcmjcEF5Xm0L1QJ3aI=;
        b=j4SzaB98Uns9JQbNj4XHive1aUYfxiZ0G/nzEAN6KV357Gu/ItX51GgRhuWmefDFDs
         cUAVZTMDLzboMSjkvfNhOs0ElhwrBdsurKUhBUt8rOgPNni0t6wh5XSWO5T6QUa2QGqM
         wUtWbO+8LXWbAyon2/xTNj5o//2HJzJxE2GFbjDRnFJig7o2RWVCDQvIH7XhhwV8cNRz
         ZeqH2A1bfbUmoRG+q5ei3DmyRTVBSroxcpJxHXJtQNOr0j/meknFERLkXrqKMb7yxTUi
         7i2HhvSkginHK9jEC0Ls7WtMY5mIxD3mYY11dHdt4lJ66rQqWrZI6otwvyVBM5BI2Zlp
         6IVA==
X-Gm-Message-State: AOJu0Yw9XcwBYxhVj49EyXEffQ4s3Yqrbhg3odAu0vn0Kqt5WLyF7upf
	l+zW5qFWsEx+NiU7/gSpW7z6115GxrjFOFD0yvAUubsMDIp3UAw3
X-Google-Smtp-Source: AGHT+IGYEs6UpJ8fCqIpfjMyKILTXZ/XGiobyaLWf91c+RRrKTSwWaJ7qIa8akU7vqMuqPP5CM7bSQ==
X-Received: by 2002:a05:600c:1d04:b0:426:6353:4b7c with SMTP id 5b1f17b1804b1-428e6ae0069mr119204775e9.8.1722954448721;
        Tue, 06 Aug 2024 07:27:28 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428fecfa51bsm17848425e9.1.2024.08.06.07.27.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 07:27:28 -0700 (PDT)
Subject: Re: [PATCH net-next v2 10/12] ethtool: rss: support skipping contexts
 during dump
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-11-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <10ebe2d1-ed38-99ae-4dcc-eee7282b7522@gmail.com>
Date: Tue, 6 Aug 2024 15:27:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-11-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> Applications may want to deal with dynamic RSS contexts only.
> So dumping context 0 will be counter-productive for them.
> Support starting the dump from a given context ID.
> 
> Alternative would be to implement a dump flag to skip just
> context 0, not sure which is better...
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

Start ID feels more elegant than skip-0 flag to me.

