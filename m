Return-Path: <netdev+bounces-149653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDC39E6A86
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8A1428C13E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993131D9A48;
	Fri,  6 Dec 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="TJUyafeQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CF3D6B
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733477928; cv=none; b=SQLZWGeKv4xbHEssniXCWDk8uLztzzhWg9yfDcALlbfIGqQmisRIwKR73xxvdE8RkkzyfNmNbo5PugOiOX35uBdrwde5QdoJID7u9DSjNYQmZdggouF7jnLv9aXstJWiP+oQbEmBGkT25QZmwyIBtDghhryLiDmLtmY9tkcI3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733477928; c=relaxed/simple;
	bh=eaw/XoBkKemIlj4DEHPtkNfTl93wfGaAley7riMKNdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0JeB8aJSaJO1Z2OmaA2MAWhHq5lVXsmQjbIBISNvQUd3ZsTVzOuxjBURG8HGSqtfjFD2VW+tmK4tDMXgwoWLXXbNlG4r5x7ECTyssbvAAPEhP6c2+N4sVJy6FzqDvW404H+9M+y5Rtc+ULduMAA++xTgB9z7On/VvscSuXrVtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=TJUyafeQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5d0ac27b412so2228804a12.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733477925; x=1734082725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xcacPwT/wlb7WIzVs3Vy09quQqoAlg89t8vQUpvtvr4=;
        b=TJUyafeQ8l21yzkkzMOsTjgVn3Um/ohAm7G6wj39CAQsvGptHpagexmFw8IBEzEm/J
         joQE3evKp5ElEp903/qmGXGyhosMrqc+8q8Ug4kWu331uTCVR2Al54r3xJzUSXOiiO2X
         eRsGwTCw5Dy3WetPHOWxgkBQsyGPLNWF8qhnBGxtIPuke/ewRvNtoKYmoQ59DH04iddI
         5nWJo2aZZcaK4hLXpqZlVxTjwnKMlZIABGIyPDius9ZiLp4/tS6HQr424G/kFYILqkmY
         miYZ+f7g7QyFgUDde1/96ppd1B7ky89Yi9FJXngo3JIwi78WWizuMSG+/3jpa/ZxG4Qp
         7BOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733477925; x=1734082725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xcacPwT/wlb7WIzVs3Vy09quQqoAlg89t8vQUpvtvr4=;
        b=wAbQ/aHRtlpyKsHQB/l4o+QTxuWnanzv8dDGcVhWYy9FoXJVq+PuOZyE8UyRt48Iz4
         NK0U0nnngKT6/zbkr6hLntQ3nGysJnyfDBEhx9ZqYhgKc+M4Hjac583MMVLud0EXLO7T
         YV/0Uvz0xOGpOwlnFw+JtvS//eIE79VQxyAddQ/REcRtAvuGOWhhYmC+nrbOdOcSXasE
         UlZOdF1UROBicEQIXkvhM3oOpepB2ynPlx45sRgwbD2wkL2Jxir6YLgNemEx+R8gcYHR
         Ndlb8GUNXbAnFiyn34mPpLYUEV64ecio2J2EDX9wMqlXlk+Y+ZIx84USLDHOtnGcMGvp
         9H5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWLngcuoPm+vg93x+oCUOE9/zHtknFEeh0PytXk66EeRKsyuej0IwZ3lXsBgzGfZ1EbdoPnVRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycmNf2hdSuqlfL0zcgtMIRSX1eYELLURTq/nC0KIyuF4Oe6QKU
	U1IE64gtbp7fSA7m2XDC6QhJe8sty3mHKPCVKHKEThg6biZV9jt3xShz3LCjiZk=
X-Gm-Gg: ASbGncvlJOmoRMrYN5g+FJAIhP2DpVFNk3DmFAOFcxZ5gwtrHc0Gu11PdQxeLSSw3hJ
	XIPvQoKSLcj7s1lDwkrbj4a5OjSIzUQwQESLRXylpFejn24/DX/LXC5/4KOEQQSGblMNlexIoIW
	cs16tzju93LZcVOzUCx/vxwnTgvd5s4AtcPLDpyyVq7QVwOyDMWZsMcj09pRsHfUVS3+/vmRTU5
	DcIAVMpz6MDpP/cg7YDY5qVRFyrOEe5TxBWl7PlQZrzYm9NZqzD
X-Google-Smtp-Source: AGHT+IHx6a69Ju4avEJR4ChEVuWRFuLKEBBuI9pbabyCdxxTG8jVCKb2Rj/Zb8hZ2JBUf1z7175M0A==
X-Received: by 2002:a05:6402:3582:b0:5d2:7396:b0ca with SMTP id 4fb4d7f45d1cf-5d3be69a96dmr2449741a12.12.1733477925108;
        Fri, 06 Dec 2024 01:38:45 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3bc829433sm929472a12.38.2024.12.06.01.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:38:44 -0800 (PST)
Message-ID: <f95ed30b-a55f-4e00-ba64-32d20256af3b@blackwall.org>
Date: Fri, 6 Dec 2024 11:38:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 02/11] vxlan: vxlan_rcv() callees: Move
 clearing of unparsed flags out
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <2857871d929375c881b9defe378473c8200ead9b.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <2857871d929375c881b9defe378473c8200ead9b.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> In order to migrate away from the use of unparsed to detect invalid flags,
> move all the code that actually clears the flags from callees directly to
> vxlan_rcv().
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>




