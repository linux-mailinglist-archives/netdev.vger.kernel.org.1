Return-Path: <netdev+bounces-115739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E0947A67
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C961C212E5
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8BE154BE7;
	Mon,  5 Aug 2024 11:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1Q8eHBH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21D214B965
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857655; cv=none; b=DBK8aAFKyYG2tulvxC/nQXxJRDFPMaakiBoL7Og4q6JXwFhynhDlSy/71+pDtWAWgsorKh/Kn1ekLFCJ6nAbJL8ShdzZPScWaT2oQUSZ+/nU7IQWvY0N9JeMN81jVHkA8wEzW19DrYD5ZTYhaFmsYnWy50+VtPQ8PsXM4tfautY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857655; c=relaxed/simple;
	bh=0Fdkzj1eRBxGEXFao2+FJnyrUpwsC4wyfItApZBEtrg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=syL19+C6GApcO6/lRUnFLQouWspA5YDN2P8eg501mztCoK5bXfrKZ6bORJujYifJ7fCgmUA+13BIePzyIfnBPaCb/Ynv8XMHNtbWkrnRSucX14Ixu/D8fdFvZRaWXxIPFwrWK7DrDhQ/1oLjCFn/nwboU0mkKlR2sdCujfmWRGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1Q8eHBH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368440b073bso3345950f8f.0
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722857650; x=1723462450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SzZwdKgR5jkcYiiJiwurbO/crcH6Zg5/Z4YiYnv+/Q=;
        b=E1Q8eHBHWcIwmYHFZqU+23buY/eGtRh7h1sS0Cs/tuatSDx8OdPpN5ZsfMGsWb0S2K
         Uq9q8yPtwxyqkGD6jXaN7El3Y3d0HniyZDB/4w/wt/IHIYeVJMgKmJxGGA/qz65yYC6u
         0l8TODpQlyLU8nWiwuWOfsKyFVy8LGVqfd2tH6hRJX0tWWIXba3ze4H7rM9VjMRCrdE0
         oCrEmRkI3wS0qSqgdkNU6BeOAYSTD38cnaXDKNKrz5aTyFwsvwT8YhFlvIjSUmCVXEI+
         Zmk1gMPva6Ux5/oODkOuU7VMCecYbafb/dotn6rvlL361fit07I3WbJiDvzwY3yWGWd+
         o9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857650; x=1723462450;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/SzZwdKgR5jkcYiiJiwurbO/crcH6Zg5/Z4YiYnv+/Q=;
        b=e6+GYaw4udeUvNQ7F+NcLCmTXVuD92crowEFT/t/jfgMH4uO1/JfMfMbNWu0sFdLNl
         CqIWQRWQO4N6bgdodGppi59YIavBQZnwvehxr0GqpkrHgiPF+jLaRS3067ZBMne0sbBP
         1Q+SJGUcKLOVy6t6BN3tOlAFBlqev6i0Qd3FYyK2uRdhQo/TYu32mBBOr+F9FevZB4ZF
         pPAm9S/8s5iQetmlWu3rjUb1NwsqLBkHRYzAGIW8UyaHq0+GXUe6N42449UYe5mmSwHf
         WmvgcpZ5SiloyBW0s/mVO+Q2Ze7Q7H5cCa0ODS8ehOJnIXT+TIRbth3qXaRsU7ii3x2a
         zIxA==
X-Gm-Message-State: AOJu0YwemQygh0/zXFSOn+T8rHKkxJMmORSfgZ6Jv9hBpSoeG+a5uRzP
	1AyNpwUnSrpxs3V7++AdOpzgXC8weTfIzMQs4hesi/LcyIVkrDhL
X-Google-Smtp-Source: AGHT+IGSHV7iYQDhNmB49Eo2C60HbxZXl95XQVmcY/cmJ1GCq9tmZqZ7MsEQ9H5481hPm2LxxesinQ==
X-Received: by 2002:adf:e352:0:b0:368:4467:c23e with SMTP id ffacd0b85a97d-36bb35ef1camr7691517f8f.30.1722857649915;
        Mon, 05 Aug 2024 04:34:09 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bc5a6fa1csm8678996f8f.78.2024.08.05.04.34.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:34:09 -0700 (PDT)
Subject: Re: [PATCH net-next v2 04/12] ethtool: make
 ethtool_ops::cap_rss_ctx_supported optional
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-5-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <5a0c22b5-a2e2-d21d-adab-a97f790471a6@gmail.com>
Date: Mon, 5 Aug 2024 12:34:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> cap_rss_ctx_supported was created because the API for creating
> and configuring additional contexts is mux'ed with the normal
> RSS API. Presence of ops does not imply driver can actually
> support rss_context != 0 (in fact drivers mostly ignore that
> field). cap_rss_ctx_supported lets core check that the driver
> is context-aware before calling it.
> 
> Now that we have .create_rxfh_context, there is no such
> ambiguity. We can depend on presence of the op.
> Make setting the bit optional.
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

