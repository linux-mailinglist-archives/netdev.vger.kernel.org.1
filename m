Return-Path: <netdev+bounces-66792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E15840AD6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B39286B1E
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DC61552E9;
	Mon, 29 Jan 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2tQ9QZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46992155A31
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544557; cv=none; b=gJU8CaXLW/L5LAS0oVDXYyJjMheb/LVWPOpES1e1dShLRGG7kNqxHgKmMh1nd3WCiOP/vEtXkjAv0eOCVM7OqAoHMsRjGlb9dbAajOtah9UQhmJ85miUs+eb+4fK4F6SCBEtU6Xwv77VVDG4prH0JUdGrMDyut+3+lze50atyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544557; c=relaxed/simple;
	bh=XYo5urh0s1tvuA740GxXQLnBXtDAMRYcwYJp2XYvqz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBSk+DFzbS8k4nk3nUDyBkR36X8IttG5GTIYth1Rddr+Y2oZV8nniyQMZH5gPzQmdiw4Hlmq+O1fFaZsJ2q4Qxy1MhXtRoPJnc/6Cs5JRtGse0VNZ72nD2OUGvo80lDU6Rjf7jCL/nJVN0zsoeQSHHxVNfZzNFOkEo8eJyDXCcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S2tQ9QZi; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6de287449f1so563244b3a.2
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544555; x=1707149355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eZI9G6h/T7CCUwJEOjoq18GTDGu+35ULUtX/OdT5s2I=;
        b=S2tQ9QZiQyO/Cy7KCUxegTMekpthQ3q1Hqe4F8MvP/SChsdj9LQtFcEARKLaBBnHlO
         cIPwJLaOGq6IrjeaFhTVnV6EO6/IC+JDIswNsddgeAdbOZqZP24E5qmdLwIp9G2TKG4q
         o4hgutpeVGgoJTMgYQtYVMQ8/T4yEKCnVdto5YcXlIUDUoLn1h61ux083avxfzk6DXAd
         7HgZ7SGiGQ28aZ5hKaxNdBUH5pN4J0B9Dj6TREmkmMmiBGkYGB93207YCfbhVOSCNoTT
         KSRrxKx5dz4vFCqXT6dznWW/F6SAJygYIIytOD3WiZX992dvbPTfKS/P4smeal9AxQBI
         Ngwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544555; x=1707149355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eZI9G6h/T7CCUwJEOjoq18GTDGu+35ULUtX/OdT5s2I=;
        b=o9oTTTe2bEBUBJFLlz7vqdjMQaUL3GzhTKrINwArWugansZTZhnnAqPb0/JngqlTgn
         qqT5dJVy7dnIhMu6MTiTjI4LI84gMgmz82B8qMh1mCzPNsEiz0MajAhAUMTzqN8ei7ca
         UbrwjSugHC6XltYuq2HLY/YcttqhXyA1E6VWB2d18Na7xBbpEMBDlMfbuIG/OYeQcv3G
         TX9yHG2+ZKZ7ADtFB5FQWuc2x3tAwjxf74DUbyPxbNybVXAiWaBvQkWD0SCevr4pl0KH
         CYzACvyYp1ZWQT54Q2hUku8D6VB9krMCEWimBDmdEImzM4APQnYLBFPpN3bqZ9RSnOag
         4jqQ==
X-Gm-Message-State: AOJu0YzJmVNekhnqoEYaXFOpx/iGO2c5kcTLrQRdXe2echQ3p3+XlwfB
	sQeyCBbnKN8jFZvqq20Rdj/vb87k4bHS6ATtVmG/BKOw+tHIyTp+
X-Google-Smtp-Source: AGHT+IHIylvr4ZnpsYM3zyjIUOl9EtbS2FlbyFRqQd9qY7/3n5YehGmDwEPFj4bcDhs6BWqhkm4ryQ==
X-Received: by 2002:a05:6a20:68a1:b0:19c:8d73:721e with SMTP id n33-20020a056a2068a100b0019c8d73721emr2169185pzj.36.1706544555467;
        Mon, 29 Jan 2024 08:09:15 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:ba1:8853:5abd:d9f3:2a01? ([2600:8802:b00:ba1:8853:5abd:d9f3:2a01])
        by smtp.gmail.com with ESMTPSA id kr12-20020a170903080c00b001d8f82c61cdsm850632plb.231.2024.01.29.08.09.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 08:09:14 -0800 (PST)
Message-ID: <d6c42a7a-3558-4d2b-92f8-d56776ce70d7@gmail.com>
Date: Mon, 29 Jan 2024 08:09:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 02/11] net: dsa: realtek: introduce
 REALTEK_DSA namespace
Content-Language: en-US
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, arinc.unal@arinc9.com,
 ansuelsmth@gmail.com
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-3-luizluca@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240123215606.26716-3-luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/2024 1:55 PM, Luiz Angelo Daros de Luca wrote:
> Create a namespace to group the exported symbols.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

