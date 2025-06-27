Return-Path: <netdev+bounces-201977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9991AEBC04
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 17:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1107A1C60D6B
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58932E9720;
	Fri, 27 Jun 2025 15:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kopjYKn2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D22E92C8;
	Fri, 27 Jun 2025 15:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751038460; cv=none; b=DD917EnbfYxFlyPEIPjsOFI61i5mQJMQI/c+HqmmJXcnhbam7Qem33c817QBD8xvg6GMQ8XGwE7Lgzh2xjUjbaMnIe73BsHobDrwSOUINCXUWCBzoVEH6gKDf6FFFIvnmlj8c9A40kDVBczRU1cnt7fpCe6WWE9u/XrWK0UpPOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751038460; c=relaxed/simple;
	bh=TSrj8lUJHsCMJnJ0zuJ959GnZXlehfxxa8dxlgRCb6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQF8hiOXJiA86saxFZb6tYFxC1L8aygxOABQDEJZ3r11gNMNIP33lFQrW45K/EVSQu3F1rzxEFoEU1dC5IdAagYOazkVXbXv541nTL1CZ9vXPvZGzM0xhp6Q1P73a1zztSImKyjnQBiYtiofw2vbMndl9+eitqP3hq+/24cMM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kopjYKn2; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a54700a46eso1239883f8f.1;
        Fri, 27 Jun 2025 08:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751038456; x=1751643256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VrBYuujR4fIVA3KgM/a2Coa5U/0N6ngCG44B1fghGXc=;
        b=kopjYKn22Rgdqa0cMRu9fen1RP+7Y3WqydTX3wrkgxy5ugmQsEmUPLgeBQH6p4xFfC
         /JQwerw95/uX6xQJgFq7qEjmspLJpkTUrgAbAGVkWK7KQ6vW3InYh5s/85JStzVNZoVo
         QBZHBjHApLC67422Pkt+DIZzT9fr8mGhAnSmd/7Bic7ASxR0sYdpAjp55YgbCX67H1I9
         T+VmJVbfYynQPY2NM2fB0DqK2/6HW6S0AP97J8MpopfwZOsbPt3H+g5OfSdkzONM+YlV
         EqhoOVm9HS2wScpTBrvZA7Bafwt1pfHLXhOD1mVQ7uXzpGa2tZU9vHhizmf1yNUyvrif
         40YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751038456; x=1751643256;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VrBYuujR4fIVA3KgM/a2Coa5U/0N6ngCG44B1fghGXc=;
        b=rSMwJvq9mty7OOwm5ICFVNlig+lNqDvzrfZyK3DD8NRkqcE0qg+VIwdFMwiRhk0zUK
         DRMPwIj2OVU1dJy9GJAEKDqmS59RquAN47L2tCiyS9S4o2QTcYJHCd31q9Rt0BKNW2BU
         btD5uUmwnB9Y2NuJHShFayVz/DM+5wG5FFHISKBUfpusK1usXk1GdU/nu4gEFITjkk0/
         IwIleKlFd5q4VROXEnLLikxr0OAGBdFOn41jWv4BWpYY49wdcR5HOxCjOdpOzxL3xDV9
         YL5N5WmdPFkjniyjjtS/EEKxjjAcsifqRRYe1nLOxyNuO/6X1R39W97Vh9B7PXLWelrC
         u4eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwJ9aC+JW7I73/mqS45FEQuULnPv0ovy+7CRjyWFYfoNVxjzmD2dv2UM1PzqnpOASy3NaFO2SSidWQAOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXnkncYmedIgzCPvJtJuz2v7MwBSV1VHn6jiZhyBeOTMUq8MzO
	CNrJ0i9OvmIYe3jTn7wsrYUuBonbn1BX/0AaPpIirf7FjxE8PYTsgRET
X-Gm-Gg: ASbGncuxyr4+8LCgRvjL/0Fu4yPXDp7avI4BEtGmyz4/xNm1mlo6s4pqL31URrBBnLg
	G7HlPRONsCiE8lu2hS1i0jmH8xrXqOn1TyF5Q8M6b3DbGTrZPu90r8VVCwZhs/HdLET0uTOpFpx
	RcBNNydjQzmR+ThRsjR2qlif0U/BZtY9Rn82zPGO19/NqlNjE9etg+Isk+weNQqIpDf8dBP3QXv
	Cao5q/zuuGJjIWg74Fy/+/JI81sR15VNOAW4ScyARM7vvuzfjkvgGRW6CtAxDKOrovDDBlk9JYI
	vMt9dvzV8pSx1TRQRo6jEBdBwRkys25wdNBJrbVlbRbi6ZashSJWp10cHAZcsudvuN4eGTttPLs
	3AklVj5XcS9pbccSU7///kvgWexD3lBSxv9z+XrD3otjIh21f5g==
X-Google-Smtp-Source: AGHT+IGl6TlrpYJqpko3bDCWTzqwhq9i4ZOiMp1p5Jz2GrOjRXq9ytwleBI5nmR2zjB+VFKCcaexfg==
X-Received: by 2002:a05:6000:2a09:b0:3a0:b308:8427 with SMTP id ffacd0b85a97d-3a8ffbd4d31mr2286304f8f.37.1751038456101;
        Fri, 27 Jun 2025 08:34:16 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a40766csm54430465e9.32.2025.06.27.08.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 08:34:15 -0700 (PDT)
Message-ID: <3a9be6e3-7533-4216-aecc-7261b4adf8af@gmail.com>
Date: Fri, 27 Jun 2025 16:34:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] sfc: siena: eliminate xdp_rxq_info_valid using
 XDP base API
To: Fushuai Wang <wangfushuai@baidu.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com,
 linux-kernel@vger.kernel.org
References: <20250626155959.88051-1-wangfushuai@baidu.com>
Content-Language: en-GB
From: Edward Cree <ecree.xilinx@gmail.com>
In-Reply-To: <20250626155959.88051-1-wangfushuai@baidu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/06/2025 16:59, Fushuai Wang wrote:
> Commit eb9a36be7f3e ("sfc: perform XDP processing on received packets")
> and commit d48523cb88e0 ("sfc: Copy shared files needed for Siena
> (part 2)") use xdp_rxq_info_valid to track failures of xdp_rxq_info_reg().
> However, this driver-maintained state becomes redundant since the XDP
> framework already provides xdp_rxq_info_is_reg() for checking registration
> status.
> 
> Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>

Looks alright except that subject prefix is misleading as it sounds like
 it's just patching siena rather than both siena and ef10.
I'd suggest splitting this into two patches, one just touching the siena
 version with this title, the other with subject prefix just "sfc: ".

