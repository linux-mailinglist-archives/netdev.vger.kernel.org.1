Return-Path: <netdev+bounces-94434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6316E8BF77F
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0186C1F213A2
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7F32E852;
	Wed,  8 May 2024 07:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VNfUc2mD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691572BB09
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715154243; cv=none; b=BmHQsO3+6O6h3+07EB41Tz5p1KSvmT28uFRb2GSrAiNUrzn/1yxlCFoBK79dzhvcPp/2kPFgD8GZJt1x3OoUk/57Prxv9KLCPbPso9ahLGvXg3f1DflQnOOf0W2AGqkzeeCZWCyEFgQsR16mMON2w0li3CjXBt7q929W7EOLH9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715154243; c=relaxed/simple;
	bh=aroAKGfbT/S9HJvxnanc2k9LUOaJMxnCzC7Fvgc4BI8=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZBRb2jNCPkpohDftzoetbxNWgTeWzcrEE+lEgeaSrr/sNYzLPfBTkrNDUwF2Fb56g8BhNuzhMx6XWaVaEvdTYdXOk2pXb7EGzMiBMzO1MB32Yn63SLrc7QRarABSe0Qc50FfMVOilQI5ynxxq2RcAkZzCDUu7PejFZ013/y5EmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VNfUc2mD; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5acf5723325so1041999eaf.0
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715154241; x=1715759041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7CxMouQzaROWJ/PtIXTCtUayc+4cz5SGh9UM4LtWya0=;
        b=VNfUc2mDvcCzLqyHyQX5WmV0uM6mm2G57eVMPNWyGz0us4QxvqbHOvsAco7yH+CVnE
         ADKmtZADzEUfv3+JItPBvGLuYcaFwL3mHq7c5FySCYKp1KutFSlRd6Oem1GI8tELV09p
         BE8vfEO3BcpolPcYBYCe72hpgVYzOkIZn/UMa4oyki/SjNvCquyX3VXg34KORrtzw5dS
         +Rv7eQrZo6uGWRcdTpj1ubHvFyRdkoYXObnh+t0i/hkArzsRumArA1pbjAn7Mdndgq5N
         SjLpmBQYBhuPSg+LtGDef7j/58DKdyYfpKOjsBBNp9S9pQAKYnNeBosxT4LlBqELK4GH
         QIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715154241; x=1715759041;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7CxMouQzaROWJ/PtIXTCtUayc+4cz5SGh9UM4LtWya0=;
        b=PSJFgH2Kno9FCbEZWSugzdxnIIfOtvVEpocp+2t8h+wKqIlPe0j5h3wQPloQprPmII
         ElZFc6E9F1LqnrgfPCNFqDIoYsXgwwcpHrhnKLZNDdYW714snqybeto+zVdVBz0uj+0H
         Sl1LS8YDu0dY5/P4nz/cfXXpQja87xop7f5ze+oPOumeMOw8vvXs52vJ7muqh5MNV+zl
         jpKWU4aD9z2evN9om9paJQnXsZw9Oj/x6+VJwesFK70O49MbrDYvVb/82ytvM6CV6PlG
         k1+lgOHr3nsWs4/B49V9308yYo8sOi8rQ7Xj9vCdWfvTZBR+x0+GjL5WPFjuG1o1Uih+
         X4gA==
X-Forwarded-Encrypted: i=1; AJvYcCVLaMqwmLyAX2oIvbd7oDy4gfCyX7V5t3G56bk7t+hIjxTGexBRb0XEhbN6PpGEXbPLbwqvXJqPO7beLlS1UvJx1NNRMkp8
X-Gm-Message-State: AOJu0YwW/U3FcCSaE9jSw3tI0CrhKSrxONaL9Yvx+YToEg9f3AiPrFj7
	lbzfQh9Sm+3myzGDeuckwUHrxoonq9osrOhSyMNvh3kzebC9Q01g
X-Google-Smtp-Source: AGHT+IESmg0VOmleIreUH9OwFvIeDr/prdY/UAgsaJII3RSILEm4ugPoi0jmZGuOaqO35/vms5zRPQ==
X-Received: by 2002:a05:6358:5289:b0:192:89b7:b4b5 with SMTP id e5c5f4694b2df-192d397385bmr205892855d.3.1715154241212;
        Wed, 08 May 2024 00:44:01 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id c192-20020a6335c9000000b0061c416c93e4sm9523369pga.61.2024.05.08.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:44:00 -0700 (PDT)
Date: Wed, 08 May 2024 16:43:56 +0900 (JST)
Message-Id: <20240508.164356.95077580739186400.fujita.tomonori@gmail.com>
To: kuba@kernel.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 jiri@resnulli.us, horms@kernel.org
Subject: Re: [PATCH net-next v4 4/6] net: tn40xx: add basic Rx handling
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240506185837.0f1db786@kernel.org>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-5-fujita.tomonori@gmail.com>
	<20240506185837.0f1db786@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 6 May 2024 18:58:37 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  2 May 2024 08:05:50 +0900 FUJITA Tomonori wrote:
>> @@ -745,6 +1248,21 @@ static irqreturn_t tn40_isr_napi(int irq, void *dev)
>>  	return IRQ_HANDLED;
>>  }
>>  
>> +static int tn40_poll(struct napi_struct *napi, int budget)
>> +{
>> +	struct tn40_priv *priv = container_of(napi, struct tn40_priv, napi);
>> +	int work_done;
>> +
>> +	tn40_tx_cleanup(priv);
>> +
>> +	work_done = tn40_rx_receive(priv, &priv->rxd_fifo0, budget);
>> +	if (work_done < budget) {
>> +		napi_complete(napi);
> 
> napi_complete_done() works better with busy polling and such 

Understood, fixed.

I also fixed the function to handle the cases where budget is zero.


>> +		tn40_enable_interrupts(priv);
>> +	}
>> +	return work_done;
>> +}
>> +
> 
>> +	netif_napi_del(&priv->napi);
>> +	napi_disable(&priv->napi);
> 
> These two lines are likely in the wrong order

Ah, fixed.


Thanks a lot!

