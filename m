Return-Path: <netdev+bounces-149655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C22D29E6A99
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48981886DAE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADD31E130F;
	Fri,  6 Dec 2024 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="O/hjHQKF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838FA3D6B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478034; cv=none; b=kvpwk7rh+NpkKMCMFEVtz+sPKGD0FYuaOhHTk4AJL8ZQcwK5rDH3sBXlHdnkG9QlhB2UtcMKIuIdy8uzCSrzbHfp4R/EaNYeEWq+jM/aYhSefLgREkY4fTOR0n6Zb1spfvKJwqeqIypKX46aAyc59izXV/rFPkCVEeoEfodMOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478034; c=relaxed/simple;
	bh=WUuU5GKrPthnmIR5/r3pxArh7hO3q2K/SttKUFGF268=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WS3iyyR0Hfz4XvH6/i397mNXRu1/a7Jr9Rch/bnBrgxsAxGPkqTUflDaNATpjMzw0FjpTFFm0AjbU2MskuNgAbqkXN/K0tIazfhiLpC2KvRphd5rrPrCJsqzV4lD66nH5o/TEjht7Et/qiO85lsONnZfgbWiJaXyPqPcxtEDIZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=O/hjHQKF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa62f5cbcffso219069366b.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478031; x=1734082831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yY3lq1WJXc5i8x9SIw8VZfqKYyAJ9hAB3wjlTiP0wgo=;
        b=O/hjHQKFcym0P/kEzq4J7g0w2VhtnCPTOK/wAVwEO2CXQ3dXveTvymPw+24ZwxWT9F
         EsLsq0cLuKoJ8kuKDzTvXB5ep49z3SALb2zf5MmdRfH/fMyD3jcrMMgEtdvRdu5Al+SC
         6X7bpABQrcBDQ70mIHvc0EbbmBeHmpNot6YXwasZYoqiihYfJDvgqwwqyreG0yGsiicM
         LLTn19OqSb/xlY2LvwC2zChpqQb1uuWERx2MTgrrIYjWT4O5XhKIyD1gDkR2qezQ11SK
         sRlg+creyx5hFskZR1abvjvi9J+y1I8sSqIx1Ht/emdmY6rNlttA2YSJfyziv/MoyXxN
         K6ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478031; x=1734082831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yY3lq1WJXc5i8x9SIw8VZfqKYyAJ9hAB3wjlTiP0wgo=;
        b=XSSu7VjVw2fEM0LQUM6tuZErVCtMit26iOocSiEUcGshD4MiCOQR/zpMSUJS8HuAHN
         XcTEZePn0ek9OjBhiu2XIhb7hBy+qKk1ek6YNDz+ZJHzdMYtrMy/bPnAZV6bE6uO0NIT
         I8jfA6k8DTw3XW4B1TnZ1L8s+zjw12EK3aAvLkGz+H4dvdszqNBwKetOl1t6FaDaU4XD
         lASsPN4xLQ/j9zOi5wEq9g0r7+d84WWzh+gMoo+PrV8qC1/2Ffqu9vDikUW7UPxY0WU9
         mhfVtqIsD1AjXwst+vB1xRR/tSSx7mf+cgbayrs3It8fQ9R7FfRsSq2j8UfsZMvcO0SX
         JmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwQFv0au3JMe2Lo3Ik+4a8ewWCVjHieXP0zVtnF9+zkczz3XwEauzFwdriB2pg1GFu9wSnPD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQaJj5Tg4vaNZZFS/5FG1umC8aFB33bJnaFf+aI2e8gcY7V7+t
	d3dwWO6jQ8Y4ycDBImvMMRyXkGhxq36ug2Mt+egaCcohInjQsxsI/ELe7qh09L4=
X-Gm-Gg: ASbGncu3FlMX85l8RSKpujj5y2kLbC6PrfXNml0acYy6BUtaGYV3MxTZjhG3qqR8Sbg
	6gmE/ihpevCXHfMA6RsJPNTw8M5pobYWqmjjqS9cs+R7I3CzyoKElP8/XR0Jq9swtkEt47ukZVo
	bNbh45BWxDCRXt3CRiPcZ5879WOCinhqEDtHPK++8X6Bk49tKGneWrbaSKgPtBdgq6JpQB7uJDX
	Qf2wy7n3NA+U5evEWAoyDRn0oJ68tR1ymzixMaSlZ0r9clvizfg
X-Google-Smtp-Source: AGHT+IHT7SukKInm0CjIZrGdwDJUVA/UVTgp77SwW+1Bpky2EBQwTL2VmWzQOrpVS8DlXd5duluDNw==
X-Received: by 2002:a17:906:3ca9:b0:a9a:616c:459e with SMTP id a640c23a62f3a-aa637621b57mr215759166b.27.1733478030846;
        Fri, 06 Dec 2024 01:40:30 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e3931sm215947566b.181.2024.12.06.01.40.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:40:30 -0800 (PST)
Message-ID: <c0127a1e-88b6-4a13-b504-cbeec844eef6@blackwall.org>
Date: Fri, 6 Dec 2024 11:40:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 04/11] vxlan: vxlan_rcv(): Extract
 vxlan_hdr(skb) to a named variable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
 Menglong Dong <menglong8.dong@gmail.com>, Guillaume Nault
 <gnault@redhat.com>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <2a0a940e883c435a0fdbcdc1d03c4858957ad00e.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2a0a940e883c435a0fdbcdc1d03c4858957ad00e.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> Having a named reference to the VXLAN header is more handy than having to
> conjure it anew through vxlan_hdr() on every use. Add a new variable and
> convert several open-coded sites.
> 
> Additionally, convert one "unparsed" use to the new variable as well. Thus
> the only "unparsed" uses that remain are the flag-clearing and the header
> validity check at the end.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


