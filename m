Return-Path: <netdev+bounces-83902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D914C894BE1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 08:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78234B210E5
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 06:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DE2C18D;
	Tue,  2 Apr 2024 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="OimO5uzb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC842C689
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 06:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712040839; cv=none; b=B36uCifxjsr4z79DosIG+166+LlIaGz6M2CQMad7FGXk+68MY0c02Lmbc2r354v0X26v4XNY6GcHK4/qfnIEgWwrMuuTB3ELvjNk/sdZuqko3BdewLotYuO6Yur8BRYledZUdQadeNSkOCXMmQDPG72BwywTTpTUQTaCKPfIawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712040839; c=relaxed/simple;
	bh=I6xkTTHDQobcfuQ7jSo+03xbCMBsOZWR3ABxB+JP87k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DAe7NQPllQfIf84v0wbzgovsFt5jv5LNQJ7b5E1+nqhxiGvN0PXBJk6p562d3u+tEgP+9yH55+rVRFrwUWmNq17SDuHDZhusakiHt2Q2bZwx4yAXpmsVB0+vr1kxSfm3c2IZkieRXX85hxs2ZYoHyGfXnw4WthVRQUmyw4JL2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=OimO5uzb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41564adfd5dso10196525e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Apr 2024 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712040836; x=1712645636; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/mlo4k5ykNOdwOWWAIw74MKJh++DOS5Cjw1XaL53BFs=;
        b=OimO5uzbFrjRjPsAsIDFgjvsujVQPoDkz/F4cGzOCf2uM9f0DkVxdZOoJZZI0Z1+DM
         Qsess/J9PtZrKrDgHKVFkZ4FxKoJog9teRTkNbrSQ4L6zh/qCLXeK5opuLvk1er2aYDh
         r0aoxCIqwB+u6Y+Ggks5doqnTlkzhRqrtiwazskmFi3JChDA3g7WoyKwHZ4PZR0oOCG8
         wa72jtimqy9SSuNABVJReI2BG3zGJ8ZaCU7jKpTY+g6bk9Jj9Vzov7HhhAee7MzxLVXM
         kuj3ctLlm0E07HlBmRO51ftvcvITPHMllIV+lqSvUUa5hd3anM5QFCvaem4LGPvXMX5Z
         WH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712040836; x=1712645636;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mlo4k5ykNOdwOWWAIw74MKJh++DOS5Cjw1XaL53BFs=;
        b=D6I0dJOQV98kFlUWS3ML1F5hFEsckLJg0lI7DZTTweSOH8HjMe6JZU/byM7Q7HlFnk
         G7yb5Pkl/5MS4MjdTjteSZ+yrXQEWmpmGuE3lp93AuqUESzecCWvb96kbDzBgzrqijHw
         RSGNXaxBvWB2FmOTqmihjEp3rFM3X2HfkPoWeCF/vyL0cg3Nctd8HT8IKRRyL3Ka2qon
         sNSUVqtDuBKvQrsVObAl8Ph94sMwwkYQgQoiFN+r+zIUmlOZ03HQ7NO/Uqm2qHwplKBS
         4kj7GOI9F4CN12WWpZ7DfWmUkb35bVgABIxrxD0owi/T0IPB/InYmqkx0s5E27lyaX9R
         ewfQ==
X-Gm-Message-State: AOJu0Yyf9ri4WQ1GF1xFabEk9K/RVyUuAaLcYON4pNZ5Fdij0IyuPiTR
	efaSqctAvXogiwhWrgGLMGrQ/APGMHrKSgGzWDrEyCDUZgH0MLE4Mk/Wrd7gbwI=
X-Google-Smtp-Source: AGHT+IGdi8gVIOnB+pOObvx+i7VDoG9HrUnHHAHu40TwteeYgn7Kpl/RFmUGcRpKP0RjWYg1xTQDig==
X-Received: by 2002:a05:600c:154b:b0:414:cd1:e46d with SMTP id f11-20020a05600c154b00b004140cd1e46dmr8184396wmg.23.1712040836000;
        Mon, 01 Apr 2024 23:53:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:8e1e:60a:a44e:113e? ([2a01:e0a:b41:c160:8e1e:60a:a44e:113e])
        by smtp.gmail.com with ESMTPSA id fm12-20020a05600c0c0c00b004156a55592fsm4015958wmb.6.2024.04.01.23.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Apr 2024 23:53:55 -0700 (PDT)
Message-ID: <241c5948-5912-4a6f-b76e-48ed87a2ea81@6wind.com>
Date: Tue, 2 Apr 2024 08:53:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: add ynl_dump_empty() helper
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 sdf@google.com
References: <20240329181651.319326-1-kuba@kernel.org>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20240329181651.319326-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 29/03/2024 à 19:16, Jakub Kicinski a écrit :
> Checking if dump is empty requires a couple of casts.
> Add a convenient wrapper.
> 
> Add an example use in the netdev sample, loopback is always
> present so an empty dump is an error.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

