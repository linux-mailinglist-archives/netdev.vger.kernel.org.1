Return-Path: <netdev+bounces-123304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC789647B7
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 16:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AC0FB2AEB1
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4F1AED4A;
	Thu, 29 Aug 2024 14:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQHhsf97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841D1AED4B;
	Thu, 29 Aug 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724940322; cv=none; b=cY39FCF7zNHM68u4vwJSxHWhVLlf65pPkjWqV4CnHRyCqVj6KQ/PJH8QYg6srssf+Z40cO1FcKXSyOdKqWic5r+wKSjz3SInuZOcbeAkTAaTBrSaZoWBNYoi4Amk2RHA6/U5+T307KBxRC15kCV+6VDCHSGRERh7OyMJ6qrKuig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724940322; c=relaxed/simple;
	bh=+/nuKKGWH31VBxbkHsa0ZLL2lsknIYutCh8lbJono1k=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ENNzFfkOjR+CGTSPfYFY4u4CPCa3XurtuwwG1FU0JCRs1/NLxfmnFQYxk90dD7JQZ2OQBe/v6RunauOzDCubU4OfHcOBmVg3cw0J2u5qHFyAwGsMe513mqgk22B6BhUWCImQytFnfNxxcjVfN29tMdCEUWkZ9fYd9Wi0njZ1SGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQHhsf97; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a868b739cd9so82454966b.2;
        Thu, 29 Aug 2024 07:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724940319; x=1725545119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1f3vlyYRWem4jKM0S+DdQyVAsPBA19xwQyVU9FqicQ=;
        b=BQHhsf97afmb4R+YIVp6OMFZQzdhOISMk2A+diNg6r3uti8KRo82Oi/q9co+VvGENP
         j9C5bk3Oqye3S1lY4duEOzwzrmcmGysyN5NiBA4YdZjMghlKuiY6xxmJGS9FvYMUjz8W
         GTJol8nWFf+LEYiI5QhA02ii5Bl0al3Vxvp0by2HgI3IWv5t3j5VdCZXpaIkvw5jzsBA
         eEo6dsxTk4pSg6jb2dtr1qGqMsfSMFRZjHNG36osG+raB7z2EGvFjHyWdKiBJ86hsYqj
         e9v3p85IoQ7srAPjNm51+G8Z1dbRNSZWElylLQN3PbQIA+ABe3oBcyfhl8fDkOLcVCi4
         OP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724940319; x=1725545119;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1f3vlyYRWem4jKM0S+DdQyVAsPBA19xwQyVU9FqicQ=;
        b=u4AkCYO8ARQQzl5rPWFGzuYkw+QEOESW4v41UQDf7cgH64vIptiKxehKNLEJa1ADju
         VgBzmrA14VwsLj6BP70486LFZ8QDy2mUFXkmnRX/PVDW42p5rxESBSFPATzdglOTshTJ
         u5sNx+dBXf522Wl7tJ9oOeRqIJZulnjHd5nhU4//YDChs+ibiyNrN+2TVruVQQKGPARR
         g8gED8crP9H9ddf2BGweVJResQ8GTkxb89+Wp7H3vLyCcfek/00VyrMtNFjOZpLOpC+c
         STvvEEGBudutG6aNSesx1Kvk6tkJ4hWMWw5t+UW0TEmU0K9skAGELyMc7qaHdexGCUI0
         EJpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4l8GwaptfxihlFkfzRoDwXRhbIdgioq/Vzf12/Ezde9gcFTLIuE22uBpxD3CxT2HouY2JeKPKS2ZbCHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoSCmXYI2dlEZkfuALAbehfhB2v5kIPbGT9AQkH0c7QQoby0bX
	A33Jx/J/C+Q4d4otjWOWMFrY5cfDNBnd58Ldr2HKk5JgXXC5WKjd
X-Google-Smtp-Source: AGHT+IH3fWfGs0d04ZNwiSCQ+7SnWddrnDR3fbdR5s34gl69uOnZ0LuNw6+d1d+enAh0kS62h4eQ6w==
X-Received: by 2002:a17:906:dc92:b0:a86:80b7:471d with SMTP id a640c23a62f3a-a897f930cc2mr271785266b.37.1724940318167;
        Thu, 29 Aug 2024 07:05:18 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989092143sm83848866b.96.2024.08.29.07.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Aug 2024 07:05:17 -0700 (PDT)
Subject: Re: [PATCH v2] sfc: Convert to use ERR_CAST()
To: Shen Lichuan <shenlichuan@vivo.com>, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240829021253.3066-1-shenlichuan@vivo.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <bfc3e843-6e22-6709-2f72-db3e7ef7de57@gmail.com>
Date: Thu, 29 Aug 2024 15:05:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240829021253.3066-1-shenlichuan@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 29/08/2024 03:12, Shen Lichuan wrote:
> As opposed to open-code, using the ERR_CAST macro clearly indicates that
> this is a pointer to an error value and a type conversion was performed.
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---

Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>

