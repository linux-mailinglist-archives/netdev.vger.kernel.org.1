Return-Path: <netdev+bounces-65818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8140783BDCF
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 10:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1F51F32D29
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EE91C2BD;
	Thu, 25 Jan 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6iCK0cz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082641CF83
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 09:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706176015; cv=none; b=Yj3uOAlmROsBvxG4eCjUItwU9h/V9tPeUybu/hHTAJ7AEWOeqb/+rF8dB6T3HtRDFG/ndDdZJEgxkAaGWgCVbBfeAITNKXyVqku5Ur1Xu78/xuheVwTj8+OkE43xuBsV4G+iNgmVm6qie7SBTC6Tm9+9Qsr8TOPqujI8sA1jj1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706176015; c=relaxed/simple;
	bh=hkEykdYpLKytx7M0B7g+Mh0aAttAPO6NJFKKwuHsyQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfSlTbhioMlM90shBptJnFHpQG2Fp4m2/IqwfFDDZcKht9eDueHv4thiF/mPJ2yrJbqywAKzVnIyoNthdZhExWMpw0DLkyg8HWg5mUF13m8GXDNnAEA4S92RatXXFiJhhehuMe9iQA0Lbwd8lYsfecprFcggy3Dl/01IgULEORQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6iCK0cz; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so5135104f8f.3
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 01:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706176012; x=1706780812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkEykdYpLKytx7M0B7g+Mh0aAttAPO6NJFKKwuHsyQk=;
        b=X6iCK0czsOJ/qHtJ5J2YICX/FrHNoxRlJIAfOkb6RRmkXKe4iWqdu/eJIj/WmFot9X
         WHThJy6VF6WMhZlo5pVZ23Cj94ZTALLMUAowIhj7TZIk3OtdJT0QkeLgWHmp0OeN9UVE
         xAMxJSqcGiZyHZ3Lg7C5m7TV4Ot39ywj0t1zFbofDD6dZaQmWSrFXcoG8Uxg61GJRJ/p
         96NcR0usDNW7AP+eEq6lDkW7y/iJFcI1ZUSpGk+7hp5BVmGMs2lXNk+uxGqyQ8N/bBs6
         H7gH1jrRjSxP+zc65KVb5jDX3rn/QlxHVq0Ox3oeUFKQr7OZ+z9v5mG8CFHtc3VAuix/
         mlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706176012; x=1706780812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hkEykdYpLKytx7M0B7g+Mh0aAttAPO6NJFKKwuHsyQk=;
        b=rE4Vwq49J6x//QzA0J7ZsiCQWGJ/hYsbu/OWwoMnk+TLDVb5JxVkuzjoxAC4J9twik
         yuoXFPhhwpwHwxzlHlmmhjdeur3hJ+1KmJwO2KEW/+khG08F3KAO8M25TpAjnFysvHYB
         gveMKMiaMz+cNqFPAgPg5+e8zrYTiPHCVPAoUm2J8F0us/K12pj3uHRlxAkCmahfcPVl
         gxxot67YM26iuwILRBQaHstY67WnsLZPPdNgScH/ULdNaVoqS9eEFJ/kLa1IufPf0Qga
         k1eqCucHGERFTndxG3Gur5cpkT5bvD6sQ5gYrWcjEaPjvnda4UBo1+u6a9qCuLuPnxgN
         ivMg==
X-Gm-Message-State: AOJu0Yy4F/7iqJFjB0nCi5jiWERZ9fTa30spMHKNdENX7tDG1Y1NIPy+
	5+3FEEsXX9ziZfq7oZWime4s5Noe0cyXwqirctGKWDnEGJV7vVoG
X-Google-Smtp-Source: AGHT+IH3AYbtNz0URUwZKaxjRy0ECI3wAA/U98qDQb7L7Jfn6cBPzMRcUGRd+zc8sb/jH1Y6NZURCQ==
X-Received: by 2002:adf:f107:0:b0:337:3ed6:8697 with SMTP id r7-20020adff107000000b003373ed68697mr391580wro.90.1706176011959;
        Thu, 25 Jan 2024 01:46:51 -0800 (PST)
Received: from localhost ([217.212.240.67])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033940bc04fesm6270766wru.16.2024.01.25.01.46.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:46:51 -0800 (PST)
Message-ID: <d6587a2c-0a1c-4a1e-a1fa-e94c6b3b7a98@gmail.com>
Date: Thu, 25 Jan 2024 10:46:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] ipmr: fix kernel panic when forwarding mcast packets
Content-Language: en-US
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org
References: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
From: Leone Fernando <leone4fernando@gmail.com>
In-Reply-To: <20240124121538.3188769-1-nicolas.dichtel@6wind.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I missed this path, thanks for fixing it.
Eric's suggestion looks good to me.

