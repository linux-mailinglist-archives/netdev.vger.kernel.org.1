Return-Path: <netdev+bounces-153964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33F99FA508
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 10:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD09A1888936
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 09:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1C6188580;
	Sun, 22 Dec 2024 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="BRy1T4Q5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9125C1862BD
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860799; cv=none; b=lREcb/57uPGYgi/e2POoGXLlcroW4oLC83CXvOYLlquGYF/csM+JOKERIzyupcyGdu8xLgfRM81pBA+F+7Z7apo8eNsqDYQACai7Jp6TfmoVWIXaGL20ZlIdAxMtVIcAY1JY/TppnvYkBrIH+Vgw0e4oSN6SIIcB19t2nOv1RcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860799; c=relaxed/simple;
	bh=QWAl/PSCX1/7bs2eWj1O5Ous7TH+5LjUcrtPjfqJolE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5iQ+8WQEytAio/WkqXy8Uz7CU+haZr2C1jwcY2gF/CJe8P3OK8gu8gdbdcXsnIr5JBPrB8QDSVZmgZ1ltmXMZO+MOaHHsq2s4u8oJeq+8MHNnFLiqSK78dQQ5LAaEiur0h5vjJK9LkG0NpTctMkRduSvKHTPztzUvQSu8c7ctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=BRy1T4Q5; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385eed29d17so1637056f8f.0
        for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734860796; x=1735465596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r01Rf7AD6Pn5yErJlGrv2YF9sGspDReRgMmzJT8V6OU=;
        b=BRy1T4Q5zSdfdQrZljMUjD6gcjEZRHFDVUucAhCQGQGTStn3Nf4hJs7B0b2o/IX8UF
         B0R5Ewc7PwmODdoK0g+RhCBCm0A508HMaXBM9DGhKdjuJuyGIMXtkqAbH/DjddWBKgko
         MJ0ID5cnQHo0wpmYbsQPfC2yfnUj9IhOKHqDjE2jq2tCrt0V/rPp0E7bA+L+b6wBGW1z
         kIqKjEIQzjRRX3NloGvKvBxzaMVJzLml8OPG25AniQ/BCu9I7Y8F8OkR+DJh4Xj8sD7v
         YkRMPzahIZDUUIo/xzPTvH5jAg11ODu+gVggpFane5HRATzNigddgDPbMxBxjvk7WCgW
         pivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860796; x=1735465596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r01Rf7AD6Pn5yErJlGrv2YF9sGspDReRgMmzJT8V6OU=;
        b=hNoUY8F8WjbvltiaITpC7zmQcLN64NYlJzUdKH/hQSeiASQlABlg/uKxvo55XNb8mD
         d0DYNkUvRpJuBMluZ+yQiXlgXj+AiFi2RG+FFW6rCL7ylWsCYdMs9IJ7G2ntNl8MyTm5
         Nt9JUfKVfly8mPJdra2Jy+GTqsuHSM5+w7qbAJpKpWM/dLxYyUojHthfEUVZ0UcRtCa8
         MLpqbv1idCstF4apQjDOhw/Q2s6YZOOS9nGmGwVxYg9tAfat+HNcm8txMtFUA5R2Q4XQ
         2WumIoRaJ+PTByfYaefwJUnuP/9abgUKvO0QYfzAOC2GIzp1gO5l3E4jwCkCcIxoukMC
         G/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUReHL4AOwewR/w0RBqBnncoiXSlK36/xkxwr3Q1ii/9AjAN0WAcnrYtlW8xb/93NR1LxgwaZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWNCfcsVC0E0meEmsNJnWznflJy36sJ3S70vriZF7szY4WPizF
	wPwBmTtmORb4356L7tuwIlzlSD294i3y6QRR8Wi8HxEjAhfFuMHKo6XbZ5GdR7o=
X-Gm-Gg: ASbGncurNV9+jQUFYpKi2oUp85w6Nde8YKRIt1e1GQPqWN6obYJFUQ/42TFjB8FYeT0
	eoeQJbTDLY2PM4U6QbOplZcrkTywkX6jFNFEYPbUXXV+gb9HhW9kVAqdP54B+HsXtxiJxD5S5H5
	PSpgaUlgbCvIxLxbJF8vnrx3Ot4mnAdZG58Z1UR+aiqMcW6RYeND+3o7ogTsgiQwqMIRwbx7NK1
	sFRj+3/QYtReHqVdLeY+COpxzIfuaMMVY72yFpQROWJPdMWPL5y7DawedheRA==
X-Google-Smtp-Source: AGHT+IGmgUPUPDdF82PD4GL38Dn/wmNBTo6smgxNBXy3wwBvd7zwwc/UKBn2jlcLMMIzLiNArbxJxg==
X-Received: by 2002:a5d:5e09:0:b0:385:faec:d94d with SMTP id ffacd0b85a97d-38a223fd75amr8805141f8f.51.1734860795847;
        Sun, 22 Dec 2024 01:46:35 -0800 (PST)
Received: from [192.168.0.105] ([109.160.72.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm100043945e9.7.2024.12.22.01.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:46:35 -0800 (PST)
Message-ID: <f42d495f-abd3-4f8a-b647-ddebe2e6249d@blackwall.org>
Date: Sun, 22 Dec 2024 11:46:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: bridge: add skb drop reasons to the
 most common drop points
To: Radu Rendec <rrendec@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-3-rrendec@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219163606.717758-3-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 18:36, Radu Rendec wrote:
> The bridge input code may drop frames for various reasons and at various
> points in the ingress handling logic. Currently kfree_skb() is used
> everywhere, and therefore no drop reason is specified. Add drop reasons
> to the most common drop points.
> 
> Drop reasons are not added exhaustively to the entire bridge code. The
> intention is to incrementally add drop reasons to the rest of the bridge
> code in follow up patches.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  include/net/dropreason-core.h | 12 ++++++++++++
>  net/bridge/br_forward.c       | 16 ++++++++++++----
>  net/bridge/br_input.c         | 20 +++++++++++++++-----
>  3 files changed, 39 insertions(+), 9 deletions(-)
> 


Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

