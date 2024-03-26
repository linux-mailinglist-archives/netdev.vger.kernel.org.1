Return-Path: <netdev+bounces-81976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E00388BFE9
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B962E33A8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF556FDC;
	Tue, 26 Mar 2024 10:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C43MZsZz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F023B1
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450253; cv=none; b=XXJih05fdz8ymOl50RzFY7Ev7CFGGJJZOFFb4sRhCnnynlvTjEPiYqUAV0okMvmMMSqmYtHtb1NhQvE+HogqNdKtBF6zasPZ7dAkcIrxfFY1zLBuzj9VIeut+xzsFNIamd388OO+oilhFK6pq2lA+7ePuwdM57RkUSXKIGza5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450253; c=relaxed/simple;
	bh=XuNE0urkJZH2EHRTNS6T3FBqUdV3UDDrFFrOZGjTYRw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tGt8Y3XG3bcjDsNCvkjiHsVRWBG6UtW4SPJoAdjFByMoNXH5FjFD8+jCVucYyvqSH4G/OR6bJJ+j62HFAG5AYMosxwOit7ahsf5GraDDPRzfADFxPBdZKq788E28D9MUCh5FdHpRrlBpp/NqqM+Z6pqckl7TRqhfbN/OJU2EcL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C43MZsZz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a47385a4379so609851166b.0
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711450250; x=1712055050; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JclH2nB2M0JO+1/XDYqHzXNFgdlE/tI0cUIFJlaG6Jk=;
        b=C43MZsZz03l7Hmpg9J5NJsWvylC09tPD3aPua5uhcGmBiTP1QqJaXJ5R6KqyWY+gZJ
         icp4iMGsFFo/4veSw7lvYWencFinaccjX/NcuqElKtJ3zz4YWa0Rbn/aNJx29svnShGO
         BnSbTfTziw98Fp932IttS9utCQ5J4fbcI1TxLXM2KJgDeL2+6YiCZFbMmECxhlTfEWzV
         xwQcYH53gxud9+pZqaDo13JhVu/6fUF0fUi2M5lVPKpj+7mlhVcH+00c1N1qdrimDk3F
         F8T4HBLqNBXyF+4wN2FfM0EgQfFr4uxndnzVmEYtZyY4kaEpl4+nZMNzzSS62ISmxbpH
         2Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711450250; x=1712055050;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JclH2nB2M0JO+1/XDYqHzXNFgdlE/tI0cUIFJlaG6Jk=;
        b=FW5HT1AtOCtBPf2dsKpGLOZaHqgpAfifSxMGK4VS3hdBHoZHDSLrVJT7FFfUfGzGlN
         YJiY8sc49sgVurnAcVIb50iZItUO+kIpELaaCVNb6AGmOAtCECDnipKzK5yhjMbDB8o/
         cyVxaHPJis8ClEGWveHX/7EzX01v3I6msaSPjBAiZS3p+H2RHNjew5kUCKY73O7HWYLa
         1CzdQk9vpR9fDUrJyuU0ZJE/uju+SCT+h1vRN3jSAcfgEb5HJBx6IRgFb1+dmH8RGO3J
         uppfVLiwcQLaBTnMXXpAv+NkGtgQah+KtECPMkvs8BmhrCluJyvIff3pKa9TFoHySDID
         GyPA==
X-Gm-Message-State: AOJu0Ywo4En5jcU/0oZpIhI4tM0DkirVGp4jSCbq6At30JN+6EGuFUBb
	PMK0FrzRcvIzVWf9eAaSwWUxIeynqyiIYgeY6odc1cf/Dqz3uRSEQ6+Ki5QU
X-Google-Smtp-Source: AGHT+IGMyaWXIDGxHGWSnHfzul1aJ0sO8vjrO1ZMUWZ3KuOs29KGr/5KkcPLSjUT1hvHOgF9l9pRPQ==
X-Received: by 2002:a17:906:dacb:b0:a4d:f2db:3f2c with SMTP id xi11-20020a170906dacb00b00a4df2db3f2cmr1129569ejb.12.1711450249821;
        Tue, 26 Mar 2024 03:50:49 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id i20-20020a17090671d400b00a46e92e583bsm4132974ejk.149.2024.03.26.03.50.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 03:50:49 -0700 (PDT)
Subject: Re: [PATCH net-next 10/12] bnxt_en: Support RSS contexts in ethtool
 .{get|set}_rxfh()
To: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
References: <20240325222902.220712-1-michael.chan@broadcom.com>
 <20240325222902.220712-11-michael.chan@broadcom.com>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <6f302b24-6ca4-4c16-9808-9cf89cda0ffe@gmail.com>
Date: Tue, 26 Mar 2024 10:50:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325222902.220712-11-michael.chan@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 25/03/2024 22:29, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> Support up to 32 RSS contexts per device if supported by the device.

Is this maximum of 32 driven by hardware limitations, or was a fixed
 limit chosen to simplify state management on the driver side?
I ask because at some point in the future I hope to get back to my
 rewrite of the kernel API (see [1]) and this info may help me to
 port your driver correctly.

-ed

[1]: https://lore.kernel.org/netdev/4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com/T/

