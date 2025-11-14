Return-Path: <netdev+bounces-238675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1552C5D602
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 29F1A355ACB
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 13:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001D9319847;
	Fri, 14 Nov 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="SUg1ZlZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C77419AD5C
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763127029; cv=none; b=kFwG/sRoZCPEIsfevDoPaVPwcKLhRll2g9XNXTU6njilLymlF/dm24NPKvnnsjel0HIShxTunUytTeNobBCCPK5vfXt9RbVN4JZKe5W7/sboKZDN/mtvbpC/StF8odrvpq7ZSFgXlLmO3eq77BH4ObPUewDxFKPEuF0Fd8IRM+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763127029; c=relaxed/simple;
	bh=1EzaPAftehgtLFCzSV1huJyEkeeJ1/sMON7rVbPBqNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTN5+XmLX89rT0QAL9hQTZVzqMqduG3u8rJ0Qt1tqeVck7EGRxR+p6Pi61iq96dNWt0Py1tsPm1MV6y960ubzDzhIFCXDyCA0p5veeSIg600Cx50JppwuED5U4atsprpnKZBPmRUQZmAHWC+NAPb8BywYcZHxFZdKjimOXuiv1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=SUg1ZlZL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b32a5494dso1160263f8f.2
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 05:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763127026; x=1763731826; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xriks/MF/jFOVo+hjXzvY5qzPFxGXVr6cW+9t6Nh8g=;
        b=SUg1ZlZLC1Lr7ZxBcPmig0Ft9qv5vTxLf6S61HoFmSNCKFZSu+p3U1I/u8p/Wyw3N2
         QQ4ff8PbUo96tIAt++nLEx4LQB2TYLD907b9mmH+MzXScSByUDvjPab8fAb+7aD5NDEW
         hDW8eTiahGaoLf4Ixb47Lmho1hSSTNsggF8sVmscrpIwmMoq7oiOHhoAVTz3T4ToxnWu
         N6MBNOpSI5/tirI6f/YwR6SuaDYnkQL8OHCrME1A/o82LHGG4SFWQbX3AOan6O3sGFfS
         lkretv+vyfbbpzRQ62V9FmoHS4zr5X7X0+6iDCUL925/Rn5tEx9Hfr42zxP7knxZbJ7L
         b8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763127026; x=1763731826;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xriks/MF/jFOVo+hjXzvY5qzPFxGXVr6cW+9t6Nh8g=;
        b=bxvcU0QtTrKcDOfxQ1MF6NC2DZ2/zikF58Ho1YRjq9KBg8jTwxDw0BDOO5kZciOqka
         G/zPRbDW6OaRdtrZXBgdYO3yOQsMZLdElaF6JDcDrp6sfHQYgeOlRIvtD7XhLfeL8eiL
         TIAaqxPgkr1lqm8WmvM6VtLMO9XLnL0p2p70ypi5DCBq2nP4j38bWoBPndU99/89pWeB
         dYVGU2bXLZah3G+DfOBcADqijufqxt3yp/m2n1gxtIGYewPfTVm0+F8VSeC3igOsMoQd
         DOjynb8ezK6Z8u3ZTYDSZsWM8h7Dv4Sjb6QnQhsdwI6i+SxCjTvVD8sbK8E8jztBvG6D
         ug4A==
X-Gm-Message-State: AOJu0YyRxiYZgdMlaNfLJjmhVewRxz77deyZU1EJ54+KMXHgsmj1ZC6N
	SJD9+QK1lCcBMxVJ19VIULOFY3mDjl2d4HhIISKqATmdUyR6SLrAGmoShR4ykTN6Db1VgZyUTMS
	6qXS1j1QBpmjfLpmoQ7BBzJwnOn9gqyJpngBu0Lyn6GUzos6hWE0=
X-Gm-Gg: ASbGnctFHFmcMj+Ugsv9OuKS7m4kE2j1V+oJKTwNyF1rJgsVUA3YUqh/ZmwPmCuDbRZ
	IJVAq4tJfc/3CWnf1p6Rr5VmNRui5+bWbYFsqe+yZzgQf8HMi8CIs23/Jz/D/WEEmvRolXnncss
	YmdX+jp2S9f9quQEomf5LRTp07jgCmShY4hmELTCqHIRRL9TO1I5o875XmMrgOI22HGqJG/r80e
	eZVv7Tr+WM7Be4so6VMs+VEpk1kNp1LUPM/CDKpPpHBOf5UiGc4BrVh1OfETRvJ5dx2k6KOrBT2
	9Nq4qkqQFaMvnEWkaSgjG4zsa5D7LDc3sDPdMnlGWQDbC48tRgnMLzOyp8HnqMgByXquXSqaTwr
	I7ypSzK+Co/gkqgpyXaXW4kyXa1OyX7kzM89xk0Q5lbZZQFof738guIuCkWlcpt+LB9RZuhlGkQ
	zakC23D/c2DC3D0hoVeC1cS55dFLdJBgMj/vxCf92vH/0lhg39Kw==
X-Google-Smtp-Source: AGHT+IE4qjleav2Y//aAnRUp74KZxvJi01CScv2QX74p1vquAycZE/aTCWGTCiSalbZwqUtNwI/GHQ==
X-Received: by 2002:a05:6000:1867:b0:427:854:770 with SMTP id ffacd0b85a97d-42b59374ac9mr2811522f8f.43.1763127025727;
        Fri, 14 Nov 2025 05:30:25 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9bf3:1403:420e:e90c? ([2001:67c:2fbc:1:9bf3:1403:420e:e90c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b57asm10220648f8f.27.2025.11.14.05.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 05:30:25 -0800 (PST)
Message-ID: <125e5d7e-51a8-41c1-ad2e-a85216d31ae6@openvpn.net>
Date: Fri, 14 Nov 2025 14:30:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] ovpn: use correct array size to parse nested
 attributes in ovpn_nl_key_swap_doit
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-2-antonio@openvpn.net>
 <20251113182625.4be5d5a7@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251113182625.4be5d5a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/11/2025 03:26, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 22:47:34 +0100 Antonio Quartulli wrote:
>> Fixes: 203e2bf55990 ("ovpn: implement key add/get/del/swap via netlink")
> 
> Since (IIUC) you'll respin - please drop the Fixes tag here.
> You can say something like
> 
> The bad line was added in commit 203e2bf55990 ("ovpn: implement key
> add/get/del/swap via netlink")
> 
> But real Fixes tags are for fixes

Will drop the tag.

Thanks,


-- 
Antonio Quartulli
OpenVPN Inc.


