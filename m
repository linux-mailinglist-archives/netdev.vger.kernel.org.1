Return-Path: <netdev+bounces-68650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F34847733
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 19:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7461C22789
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176BA14D44C;
	Fri,  2 Feb 2024 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMXFTwpi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44914D43C
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706897753; cv=none; b=oNb833fPKyzzTPt++7QPLS+/fM5bKFzjdMorrp8vrEr2rN9e9iIG00vnFwvj2iZlAD3UsD0+vCDhot9WbaQorZrVbZHew5XaG/xjz1lxBk6IISR9gQ8cOftMGDWjLYg4irXwElixSTTm3cRRIx3WNQF41lqh+VNgZrYxxs+xPsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706897753; c=relaxed/simple;
	bh=DasRXTIQ0LLPsovHP8wdNBQ5VdDQmoBI6wY8nKq8mck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0VR3bkFh0PkZgH83vI8eod7pqJgjTrQhZE8mPK1NDovTv+YwqZuzVsD5ThBZTp1buO68cUR6eTdYsrYBtKnP7/oepwpeI5GB6lnU7H0KdQ1D6eEvadxe/NsFKkG2EuwHxE1rlSVqhkj3nQMpQDeh8+KlkgF/bDZyOuTpv7ZAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMXFTwpi; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c887ef17eso3593836d6.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 10:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706897750; x=1707502550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3dX0UPb1hlx0pQ17vHKfS4yqCWpAh4i4+SS0RVd7kM=;
        b=OMXFTwpiaxlhtQcpR/I9wZ3e6972EsmP0k2gSI4vA+UXnd9lYMowx27tFuGcFLPY/i
         MkKXDuUfUiS02Seji4x0JXDFoOIG/j0n444nbmbBGLEvs5j8/7SnyCoHTVGj7xImhXTB
         aPyUlc7JFC3pbtu/CsfwECH9vnclg6sDnt3ozL735Zb8UH/jSE7qk3vRDEt6SpZNVEeu
         CVh54p0RmmmClxBINtA2oKvMjPP3kzxy7bJ5tsoyqwhGqESzK1KfoPGCxrT1gGxB8l8M
         65QCZ0ggmU9ipAiDnpssXPH6/+DguZ03u+YUF1WFLdsve42HToChI5qsy0vqV/9Amlj5
         lG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706897750; x=1707502550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3dX0UPb1hlx0pQ17vHKfS4yqCWpAh4i4+SS0RVd7kM=;
        b=u8ZSoI7mpquAZMvgS/tC1xfPspvkHKZbKDNZWukGgGvxlz/R3ccABTYRG+q0ZdwNqV
         NEcgVk1ha6u8C/K/te4/Vp+AvcJKcIVpi+bR1zFqZ4R57WyaqsLfPXipwUZFEXCXQnkX
         zMCyQOECPPjjs6NQiVDghfVNPFFU1ur+JB83cAml9VacNr/eu6k1ek+KW3PI5k7aqHCj
         iVy+AYn9BWTY/bIp9gZOJqI7eVJml22k8bXYaUIr4PYGaXOEKiGw80a6T6Wj+BFmUq0S
         EvC+fXnVuaX3AydXzADaHdCzMSiBPBPSFrAHS36P2HgSZeWB+aqJcwvAhOJNRpgSk+Yb
         rCMw==
X-Gm-Message-State: AOJu0YyDqWf4MNqdtqYjCOeCjN+9/nRid9szipDUa6L8IgVNQUbpVMey
	EbFni2dOvHhappLDN1+kM2v54LoFZiM09VOdUrnHP1+J+LPKi361
X-Google-Smtp-Source: AGHT+IF/jUtMSxohSPo+OBG28fBFBpR7i6ZfsGe75lhIzXk+ihi65yddYUiPzQttd4BFcbW50X3ybw==
X-Received: by 2002:a05:6214:f63:b0:686:97da:8fd0 with SMTP id iy3-20020a0562140f6300b0068697da8fd0mr3771778qvb.21.1706897750224;
        Fri, 02 Feb 2024 10:15:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWQJeEYha8iekqtNLWYaaACOJ9qFsEoRMtso19ExCL58xzoDyRaIgHTBYZjturu7z0zPmIzpTwCqQYlkb7CO2hketBPZmQ4xf/Pap3Ko6qAf4CeAjn6lp2zV0AnWhmRpECgjv4gD+cx4lxuFdAyLNgBC1WX84sWpjOXIUPJDtUEEBUMjXnDF9oX4mU3kdD8YA==
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mk17-20020a056214581100b0068c7c91b04bsm1004591qvb.104.2024.02.02.10.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 10:15:49 -0800 (PST)
Message-ID: <7de9a94a-2ed0-4da3-b7d7-8c7faaa8e22b@gmail.com>
Date: Fri, 2 Feb 2024 10:15:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: reindent arguments of
 dsa_user_vlan_for_each()
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>
References: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240202162041.2313212-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/2/24 08:20, Vladimir Oltean wrote:
> These got misaligned after commit 6ca80638b90c ("net: dsa: Use conduit
> and user terms").

Doh!

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


