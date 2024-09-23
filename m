Return-Path: <netdev+bounces-129395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59527983986
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 00:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2C31F21962
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 22:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B659F84A36;
	Mon, 23 Sep 2024 22:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gd/ifUGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE183CA3;
	Mon, 23 Sep 2024 22:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130170; cv=none; b=loP2K9jyt2D25szE00WMIYb9HTf+7lwVvJbs63EisXBBll0jitKlZrCspbKKo1o4kZWkWWOemY2+4zJzFjsARaZXY490b6n8KKnMuxFDHdXPiNZ3xWoO/mlDzJlXqIHqA1JvcAM7sbAJZzKhy5fu37BmnNfbSTqM7llG0tpYd/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130170; c=relaxed/simple;
	bh=HKK0VxHYGyBIQhIaFtf0goqKBtH5DTLVK+rSuvJGvic=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ahh/JUczt+chqgU//pUAulFKkTcwxHp38pBb0wbTaoTL6LhOatIIB4CvxTS2P837ofChDSihuBqqHiB+B1R2SkjFkaPySel7UXBJ8UDgaj/W+3bcXLjV8o4CYfh0PMeapKhtR3R5qeS07FlNDYq2XlrM84jRXnFzb4scOKGXHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gd/ifUGr; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7c3e1081804so2022982a12.3;
        Mon, 23 Sep 2024 15:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727130168; x=1727734968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tYe0Euele3YD3oaKdrt1RnhBLaJrTf4yrjUPP1puDB0=;
        b=gd/ifUGrl4C/ooncNVIywhRiJJWBJ/2XbaKcnHswileVT3l3u8DPVhCLcwCV9IGCE3
         HaW3IukGyU7rVuDEjAnZlWNDuUR2G+jCApgvWHZExw3qybe0KWQGowVjZBJHjm4NaBfQ
         A58NKG2TBZpDEogEV3txc2lWO9ecXqB4qfSLRwU3HWacm007/3VHdJRPYb92QzrqmFb8
         oVvfgKV/k7gvSjnpcet+8dNKdU/zg5GM0/jm43dNyLu0Ge2b18flr0B4/Ap2lA/VlOjd
         w20oaSEG42kqrru0oc45XtTm0V3LcatH3Xz1xZY51OQ/ZDJS/AngEaSeySxqUMeHrgL0
         lBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727130168; x=1727734968;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYe0Euele3YD3oaKdrt1RnhBLaJrTf4yrjUPP1puDB0=;
        b=DRQCQZhgVlT4t9+jDdIPwu/7oe50Ng2zBow3NivrKr4hZnVqeAJhSk30zWa1I8RuWq
         B144d2UvlQLLk0LUMcxtL45FdZE9Kpvf6bEIJnWJP30nHuDFAwe4bg/HWpI3uhDcr4zM
         QVxwuxQK5LbXgGmRYKPq6vqBfBGynzLbSRLH3TN5H8RB1UlWqQV8HC6cMq07y4Hga9Rg
         +wjNSpM1ljFsc2T4J0qnUd8cqD8AOcRpkqauF7Ibfoge0WzbP48QMLSHLvWMNWN9cUAg
         tuJc07vS4giTA76rspomDW4nLBX/9lOARnzyYzewRHBwQ7dcY6NQ8CyiXbYwybePqne7
         DjQA==
X-Forwarded-Encrypted: i=1; AJvYcCUEprDA40YGXopykZjjFJHQ5eoNCnbSuYOv3sGMF3IyDUHOqVIj9n48FXTwEmdGwMbrlcXvy0Pn96WeTsw=@vger.kernel.org, AJvYcCV4hQWrwZ3V6HTPmrwGCdg/ls4tEAl6ZY9mafxWT4BYIYfiP/1GXbdEyYbjL6o5bA49soTV0hP/@vger.kernel.org
X-Gm-Message-State: AOJu0YwgbFiWAh3oXjAey2pP1fQ4B7+vwSDYFmxjp9vVvVo2GHFuckTO
	CRdKYcAKKkfA5u/V2WsLETweJnTQ1PSaIW8DYDwRqLpthF3XUNiJ
X-Google-Smtp-Source: AGHT+IEuFjqnPPBtqzxCYI0K9D9Hh4O31DgIE8XMJh3dIs1vfveJa0kS8jU6/Pqur+WLD8NyGSPv/g==
X-Received: by 2002:a05:6a21:e96:b0:1d3:9cd:e737 with SMTP id adf61e73a8af0-1d30a9a5470mr19493863637.28.1727130168354;
        Mon, 23 Sep 2024 15:22:48 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71afc8343adsm103006b3a.6.2024.09.23.15.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 15:22:47 -0700 (PDT)
Message-ID: <12e5cb65-28a5-4f43-bf54-437e6141811a@gmail.com>
Date: Mon, 23 Sep 2024 15:22:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/1] net: ethernet: lantiq_etop: fix memory
 disclosure
To: Aleksander Jan Bajkowski <olek2@wp.pl>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jacob.e.keller@intel.com, john@phrozen.org, ralf@linux-mips.org,
 ralph.hempel@lantiq.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240923214949.231511-1-olek2@wp.pl>
 <20240923214949.231511-2-olek2@wp.pl>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240923214949.231511-2-olek2@wp.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/24 14:49, Aleksander Jan Bajkowski wrote:
> When applying padding, the buffer is not zeroed, which results in memory
> disclosure. The mentioned data is observed on the wire. This patch uses
> skb_put_padto() to pad Ethernet frames properly. The mentioned function
> zeroes the expanded buffer.
> 
> In case the packet cannot be padded it is silently dropped. Statistics
> are also not incremented. This driver does not support statistics in the
> old 32-bit format or the new 64-bit format. These will be added in the
> future. In its current form, the patch should be easily backported to
> stable versions.
> 
> Ethernet MACs on Amazon-SE and Danube cannot do padding of the packets
> in hardware, so software padding must be applied.
> 
> Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for taking in the suggsetion!
-- 
Florian

