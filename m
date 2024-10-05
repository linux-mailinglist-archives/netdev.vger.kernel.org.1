Return-Path: <netdev+bounces-132328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06BB991419
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 05:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A674284031
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 03:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE21C28E;
	Sat,  5 Oct 2024 03:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT9NEKFo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2141BF24;
	Sat,  5 Oct 2024 03:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728099487; cv=none; b=NB6dEQEaG8iuJOjY6iL8VpUhg1hDyZehh1bJUgONPIHnRUB3dcAq2GfWQDwCCKbpJcrDJWPD7rXsPLzMdEqmnEfPuEnqAgBOUlvZZbn3dqmnK9Y19CKkVZ6yYw+lYgtCMhN9RtnD7xgceyRhQFbh0pakeIMeVC0bRef/9jlk8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728099487; c=relaxed/simple;
	bh=dY82aLvdM0jERSvuZtssnWC+B0o57gibWBgnrkeX40o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFIjZZTA8fRvkj7069kwLd3FhXuSd0eRFs+xajXS3VwT7Z/ME9V6D+mDVmTuooQrM7OtRE/TQlTgFkmV02RQevIVfjxpRJjW8DXUUG/VH75sxVgKYDaYYq9qSWJV10sKh9AqcGthzY/fUMQnJ8AxWrApyLetDJ7ideIQhiLqHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT9NEKFo; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71df4620966so171333b3a.0;
        Fri, 04 Oct 2024 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728099485; x=1728704285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WGENPhpaAI3BKTNIryNaQ12AO4VJdVOncvlsk3tM3EY=;
        b=eT9NEKFoJu9CPlYOD7tAbmKtFTHdHghyoF2CZCOiuMxcJjozQc5YwIQ+SguFa8WSOI
         YDAnSqnBF3zqAwMtJgoDlXWz+rEQP3STYLgnWD6u9uMz46XwTgakwbqAVE38hRECTDDy
         RJDVyCMV374tVuVUBb1WK1PVE6kg2Gabn5wARBBYkcjpe7PsFa0rIgjEg57r+sJy/LVV
         EVEq2Ka1GiQOaq2MWFN+oWh/LbMoX0toUjNb2x0ZCvIiX7HRQk9Jym1ZK5dvkKLmhyCf
         mVWnqDuksoAmiKR00uFxaDwi9cH14v05eqhNjoY8qQGEQIWtvhtPKA8pdyExCN4N8Vft
         YOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728099485; x=1728704285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGENPhpaAI3BKTNIryNaQ12AO4VJdVOncvlsk3tM3EY=;
        b=rAyZ+SVkv1iF39TtshJ+DSqe137JqvnxKali1A3Yo70ao/ZbAaiNJ/zXmGXgOAcstx
         Xg4wMKZVpCZQKmsOEJx4TYdR9+AdPdEZwQUpCBl6d4SZtXZeRbTXxOuh3uRyx/Oe3IEA
         5XI+Qky2Vu/z8ezgiIbrFclIEyT0LRY1w65mW6OlDMCoYoo8eDMKNmZlh0hsHON7v0xx
         p5Fr6f8bfB5HJVPa68HmfJYnfqmcluwu5L3+osVwjpmzMJ5y3gPyye3mgnOkCDRSDiGQ
         DGV+p6NOmvewSEUcleQf1ZyR50D/s5LTlF/q0N9TeKhfeZQ1DFCiHpNGd1h4zeeMmBHr
         prqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUc22tXeIVmRQBleX7EuYTnMziUZwBHOaQtByQEh/DkQuzSiNpHAOIGION+stuX6snZZUUL4cEVEeCyYCo=@vger.kernel.org, AJvYcCX2Esi5mWttoKaOm+5hWs3Z4nNvOFevpASCj0mFusetSc4rZd0Vl7Oox8WAQpWKPq1pOD7uchsb@vger.kernel.org
X-Gm-Message-State: AOJu0YzEIuje4///Pk216szGF6yjSJSrdCjKlVWndJabZCA+pEaFGAy7
	K/guh+gOWFxdtt6cQ82oeeik2KTHDHwZMGVQzD8WwPEfMmc7BqAI
X-Google-Smtp-Source: AGHT+IHfErkzPbkakmCZAx7rQthiS4xhMvCq2iu0olgPuvKFrUipudMee6ftaWytYJHN+FvtZFdpIw==
X-Received: by 2002:a05:6a21:1190:b0:1cf:506a:cdcc with SMTP id adf61e73a8af0-1d6dfae3173mr6672922637.43.1728099484842;
        Fri, 04 Oct 2024 20:38:04 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd156sm636497b3a.57.2024.10.04.20.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Oct 2024 20:38:04 -0700 (PDT)
Message-ID: <eb2ab419-733d-404f-b419-3aae6944d860@gmail.com>
Date: Fri, 4 Oct 2024 20:38:02 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] net: dsa: b53: fix jumbo frame mtu check
To: Jonas Gorski <jonas.gorski@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Murali Krishna Policharla <murali.policharla@broadcom.com>,
 Russell King <linux@armlinux.org.uk>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241004-b53_jumbo_fixes-v1-0-ce1e54aa7b3c@gmail.com>
 <20241004-b53_jumbo_fixes-v1-1-ce1e54aa7b3c@gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20241004-b53_jumbo_fixes-v1-1-ce1e54aa7b3c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/4/2024 1:47 AM, Jonas Gorski wrote:
> JMS_MIN_SIZE is the full ethernet frame length, while mtu is just the
> data payload size. Comparing these two meant that mtus between 1500 and
> 1518 did not trigger enabling jumbo frames.
> 
> So instead compare the set mtu ETH_DATA_LEN, which is equal to
> JMS_MIN_SIZE - ETH_HLEN - ETH_FCS_LEN;
> 
> Also do a check that the requested mtu is actually greater than the
> minimum length, else we do not need to enable jumbo frames.
> 
> In practice this only introduced a very small range of mtus that did not
> work properly. Newer chips allow 2000 byte large frames by default, and
> older chips allow 1536 bytes long, which is equivalent to an mtu of
> 1514. So effectivly only mtus of 1515~1517 were broken.
> 
> Fixes: 6ae5834b983a ("net: dsa: b53: add MTU configuration support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


