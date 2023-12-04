Return-Path: <netdev+bounces-53409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBF8802E50
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898E4280E52
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2759AFC03;
	Mon,  4 Dec 2023 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="OnCcHApf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A187F2
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 01:16:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c09f5a7cfso10468995e9.0
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 01:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1701681378; x=1702286178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DQF/X+/sUxxQgk8E/VLR1iWn7P1sIgBlifbY6L+Xykc=;
        b=OnCcHApfLneX1+Sl6DGzjMf1BIExFQnu7VlkDSUAvAM4QeDW/1Y5AUA9c7fLiePgTd
         nechH65P1iGqTuxrZoDFPLcCaP2Wuz514ofQnRV6NvES/LHplFMGVU41yHeIpZ7rYflD
         BwAWvWJ3CvbpzGl7K7Bi6LJgK4oYdF4+iraYLLmh0klJ3GHJ2LzJjkloPF1m0U+WR4wX
         9GALrSdgj4FRPD6JpZAKNj429L/IOLpcfdj7wm6RSGpNXYVCZ8TzCUOhIuqG9IffVsJk
         WZvGc+/Y7Qy7eN3A2gu0qFh6ihPRzDwuuq4Lj6DwjuQLfnWGy54P6J7vTtFMKaL9D8aj
         qE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701681378; x=1702286178;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DQF/X+/sUxxQgk8E/VLR1iWn7P1sIgBlifbY6L+Xykc=;
        b=BfhN4HcagIB8q1VhmKKu9RgvkCQuX3KaiWxofTFLtTk4irpHILXyYWiyPrfqv9g4st
         Lrlw+yXvokKhZ4sA/JmOemtBRgalTsnwmpF+qkfesqYgtBqdLLOY21gFvCS5cbr0jTzZ
         CrR9ghb81nOTQnj8sirdD2pSS4r7o8ISIpP7f+IGEy1MWMxrNKFsmNAqJjVvlP7zr70i
         MpKddwdO66JDs9ae3ItlAQ3xI5u4DHi77TNpkXQt8eTmyy2e7Z0mqu2kk/931StQ6Xte
         O1RMl5MuWZ1ONToF5k+C53TnM5ZsONcQ4I7acK6c1NPlUhA6U+R9y0NsH9VGJ6maYjKK
         72mA==
X-Gm-Message-State: AOJu0YxUAlu2Q7qQ/V9XS8ddMUUmXXT2owqbr5w9fmc2Ze4Y+nbZi5jg
	9W245NxoPQ1s9hIBi9os7XTJAg==
X-Google-Smtp-Source: AGHT+IGdXr+9BSVUhBA0c+Xte/NVABeHiNKTf2iFHV0efcQl4Rg+DxNuBbFqGV9MoFSAGvY5zJVFFg==
X-Received: by 2002:a7b:cbcf:0:b0:40b:5e21:ec25 with SMTP id n15-20020a7bcbcf000000b0040b5e21ec25mr2066965wmi.87.1701681377083;
        Mon, 04 Dec 2023 01:16:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:6cba:8826:daed:6772? ([2a01:e0a:b41:c160:6cba:8826:daed:6772])
        by smtp.gmail.com with ESMTPSA id bh6-20020a05600c3d0600b0040b54335d57sm9574988wmb.17.2023.12.04.01.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 01:16:16 -0800 (PST)
Message-ID: <d39fbeab-8eb7-48da-9db7-b3c0917ce62c@6wind.com>
Date: Mon, 4 Dec 2023 10:16:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] tools: ynl: use strerror() if no extack of note
 provided
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 jacob.e.keller@intel.com, jiri@resnulli.us
References: <20231202211310.342716-1-kuba@kernel.org>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20231202211310.342716-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 02/12/2023 à 22:13, Jakub Kicinski a écrit :
> If kernel didn't give use any meaningful error - print
> a strerror() to the ynl error message.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

