Return-Path: <netdev+bounces-86409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF5A89EAD6
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 08:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D3AB21E4C
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74BD2837A;
	Wed, 10 Apr 2024 06:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BgCYLRFj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39212837B
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 06:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730474; cv=none; b=hCSUIQGWeNbvOjZZlU3xKOc3Z8N4FRU+6cUtCvDI4cDb2xv4Lv2STDb1kLrXJP2WDm/9l3W2+XZNhPDPYWbNux1zhhD0rHMrT7X5Vmkv8H4N78Q2wgHuDIJmJPdgHMEVA7vfjRhcuZnj5qU4MO8U7zq2U05n327jsoROl4NkJ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730474; c=relaxed/simple;
	bh=hAXJxZM1x3WiYIOu9xsVhDqLuyCnxGQALe3CZ+U1CQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbtFO/+GcGssQ2sYBN+d2DgKyAu29BB9fPVn+NX4JY3vjeJEL6/KksHluKbKOkQQFw/0Qy1JsLsY0MpMLrTZs0wKLD5k9D7eLZFtTZdjtInlpE2+n+WCfVrNRW/54OoAdWzoXdwgCdzYJreb9paRzFFWcC0ucWSF85JinMA8JUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BgCYLRFj; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-344047ac7e4so2309588f8f.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 23:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1712730471; x=1713335271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hAXJxZM1x3WiYIOu9xsVhDqLuyCnxGQALe3CZ+U1CQE=;
        b=BgCYLRFj7TtYQ/EXzIN3t3ck1FlNMOV3YdFJe21TgxvtN23crGAKm7fL4vrNzh+x+7
         I3AtfKxonwDLtqaashiUbhle5fpqMtG243JSeop7lC+b+5LwFAGtdaOnCOcAhH2eMg4n
         3eVaaSG+wqpBXshsiObfvzE7n7mOL4V4MHh5jqR7O63c1HOjsYB2loN7/S0TDl7bom1H
         mXkPcLJFcdnNArltgZWHS6EdgNmVOOeYeug/YFGP3wnQGMFRwISL8yhTIvVIQS6lomPq
         izg388uxXFOYysJeV2IuYb0fBrJ8d+lz1CsTRB7mv9WXeEqwhLnJXe7QILbw1g+v8tA1
         tyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712730471; x=1713335271;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hAXJxZM1x3WiYIOu9xsVhDqLuyCnxGQALe3CZ+U1CQE=;
        b=cHHS2n5CPTY7Zu7vxUjiS1B99rnZEVEGyKlG75x80ZScdRa1AMHpklDsmtj5l/t94m
         x68sw+uWcTk62xHjSqUdGUc0zo9VqgUDKsCOABKWi3nZmLmI3235yH/xhfSgpd1krNMN
         hTEp7C71z9YuUfJ++TXhLx/iXXVlqlEDYg6v9Fl0spKpr7NLPIVGGxoSweCp+6qVha68
         6gL1WIrOYy1QnkYUQsQEjsMx/kysKi20RB5jD+65c7TisRykPniZITTcIPf3daSdIDOg
         AypJSG9TpY6AJHQ3iWKkn6jUiAazlwLWbhmBgea06rr4VndYDZW9oLMZvmj9p91F0xvZ
         HhpA==
X-Forwarded-Encrypted: i=1; AJvYcCVwK80QIEMX36pcBdLW30zIkA7BQLgzZUsI4bUgpgixLjkM9NaSe/ERLdFWCr0uKxcWhuE/t947jwAu+eIHiNRVeIRCwGUz
X-Gm-Message-State: AOJu0YyU/Pp7N3dUEnN1FEwGG0a82NgsHzygYFQljHTC5Gf1mjcysKcN
	y/whu1rxRF0TOP6Q0vctdQfg4yZ3kwPS2ZbVQnvhKbRF4083vNYzkgcw0xy1Kzc=
X-Google-Smtp-Source: AGHT+IG9W+d/dWFhQG5S2b0O1VzeyrXiNNmwa8NkMFx7uUxPOdLU1rs/XCb/m4I22F/7jda40eis/A==
X-Received: by 2002:adf:a4c6:0:b0:346:81e3:5887 with SMTP id h6-20020adfa4c6000000b0034681e35887mr199284wrb.24.1712730471335;
        Tue, 09 Apr 2024 23:27:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:ea6e:5384:4ff9:abac? ([2a01:e0a:b41:c160:ea6e:5384:4ff9:abac])
        by smtp.gmail.com with ESMTPSA id i11-20020adfe48b000000b0034330c9eccasm13152723wrm.79.2024.04.09.23.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 23:27:50 -0700 (PDT)
Message-ID: <658b4081-bc8a-4958-ae62-7d805fcacdcd@6wind.com>
Date: Wed, 10 Apr 2024 08:27:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [devel-ipsec] [PATCH ipsec-next v6] xfrm: Add Direction to the SA
 in or out
To: Sabrina Dubroca <sd@queasysnail.net>, Antony Antony <antony@phenome.org>
Cc: Antony Antony <antony.antony@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 devel@linux-ipsec.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <a53333717022906933e9113980304fa4717118e9.1712320696.git.antony.antony@secunet.com>
 <ZhBzcMrpBCNXXVBV@hog> <ZhJX-Rn50RxteJam@Antony2201.local>
 <ZhPq542VY18zl6z3@hog>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <ZhPq542VY18zl6z3@hog>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 08/04/2024 à 15:02, Sabrina Dubroca a écrit :
[snip]
> Nicolas, since you were objecting to the informational nature of the
> attribute in v5: would you still object to the new attribute (and not
> just limited to offload cases) if it properly restricted attributes
> that don't match the direction?
It's a good step, sure. Does this prevent an 'input' SA to be used in the output
path? This is the case I'm objecting.

