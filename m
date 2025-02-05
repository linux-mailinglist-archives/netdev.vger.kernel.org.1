Return-Path: <netdev+bounces-162973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B6A28AAE
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46581163AF1
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 12:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED374195;
	Wed,  5 Feb 2025 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="ThMTKZrl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266D17E
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 12:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759724; cv=none; b=RsFNFliYLlbHbQgCE9wHuF1/uidUJRFLX/4ijZSRJ4EGNOqZFcGPaGo5D5Esc36wmdENV0TaE9JYSW1dH03RCTJ4QLdSvwpmfrXR/E8dq78fCP2FciX/8NHMGlKr7yXm7A7WblTiA9lKzVHkxtq7cdVBkezbB4W5d61L1iKFWuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759724; c=relaxed/simple;
	bh=xgwz5ySDnjqz7zMFBl/JwA9S9l/TWH8KcZ+sIJ1Cf48=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RIjObGGTbEdmY3jMfXNuqV7DXhEOFjXeuUIMfd8+jN9y6/P28iUoDxmldFTvJR1oURCJSj0FaHOZMH599iUJ2WrCMf2zySfMfAP5R+b0++SnRJ8JskFlklhFXQmF47KTPIWlQa5J3W0jrr8mf/xYG995zyw9zh+hLZ2PS9nfSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=ThMTKZrl; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ab7483b9bf7so362839866b.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 04:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1738759718; x=1739364518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j2rHnh+yAkmQSzzxK5RyiLTSgASQBQ742SO4R1jYfIU=;
        b=ThMTKZrlGets83sU5dg4nTHWQrWus3+dVZBD1QXI1k7dFYmgEIQusgJEnV9db78Zdo
         kN6Mvz4rWVTL6iMb4q5Xr+haAg0jwRmktSxoXax0YjmR9Phct1mriZcbr6KdwUMDBwKv
         MLBzaqFb3l5ySWxFsi1/fwqnt4mrqHkILGNkS9aibV3di788u3GKykDB4erlXur2usmg
         9/5GpN7oO453NIdFk8mcU1jFzlS2tKN+rTDvZ3odFYjETQPHDcZ4qT5eLd1x5YDWGEMA
         3FgvTYbgmpBXRJsk3Wu0kIFvg1J+Gy4uQVDfgMM1GUhyxJDGeysD9Tk6J4gvE0E1s5ew
         eXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738759718; x=1739364518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2rHnh+yAkmQSzzxK5RyiLTSgASQBQ742SO4R1jYfIU=;
        b=a5tiJWbzwV0on7IeQyHDQMvGA7tHOnO7MdtbyU8wxteElqEr+jjfD0Yalj/0fSTDbg
         TqyPiQ0IWZHI6pFz4999wkE0pZSb/3JOOKkCxV0RRX5XV9Q/9/5vpCrXpmmG7j42sXx9
         4APLaH98pUBoeV6SO0noAge3H19eAHqUHCICpylK2PlJ6iK1dJ1X61SHChy6KZVVrT53
         O2vuRSRuW8JIR5xN/owk7f7MDjBQ+gbVA6pMcpRcZ+oJcu2joeUJ3ZfmlXlJSzTai7kp
         DUVcsKdhfm6cYH3aIZSwhU+vDmtGEZiMfWmixTI3XVeuzwymxmIeTFy4HwDpgfoY9lPe
         nBfA==
X-Forwarded-Encrypted: i=1; AJvYcCW/Eo8p4WW7c/OZ0BhfS20LyRafb8kh4efOkmxgjP652iTujW1XaIsBUDCeOAkPkYLfZl5iWmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNvS6M3wHnjZTTPQFhWDXfWQ8Y0YVluP2SDBfp7z9v5SudW6YB
	jIDymtoRMofpoUOmH3K9rNDv/mM7kZ+zdfAsKuNaSg+Uard+nEY044DzCSgLwUk=
X-Gm-Gg: ASbGncvC4RlWI9ZN0qPIkakJ1uiwQ/sALC7BTieTixEoV7Ak/KJtdPed7gdb6W2QYy4
	p68taKWkXS1aAmoxWNQKmP2HX7HBD4qlkNb9UpbEJWL/gBH4Vc9VHeOjSInjJxk9Jyh3UeHiVGn
	A+6TSrCHDR/IcU+8fKhJ2BoIxNU2WMlRZW9Ux23Gr5BIOoR5+LU6YXWUcvT5mCWnAVDIg5AgLUm
	rK4aVqZ/+NH5HV1w14Yz53WepvYzs1lgXY9flKawGNAvhZif7GEnBokGYHeStZr/yGx8OemQWmf
	0E60O19dPKN2ZarFinhmuIB3GGpzzC8oI+Fw1UwdiUn3ii8=
X-Google-Smtp-Source: AGHT+IGswvqC0DJo4N9WDGG7KlPK8WPMfL4WNKB01Aq8+lNuY1QIwDotwftexOq+uQkBbb3p/fXCJg==
X-Received: by 2002:a17:907:2d28:b0:ab3:76fb:96ab with SMTP id a640c23a62f3a-ab75e3403dfmr244747366b.57.1738759717452;
        Wed, 05 Feb 2025 04:48:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf88esm1086462766b.46.2025.02.05.04.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 04:48:36 -0800 (PST)
Message-ID: <e5373a02-959b-4609-8a3f-7e25c69d97b8@blackwall.org>
Date: Wed, 5 Feb 2025 14:48:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] vxlan: vxlan_rcv(): Update comment to inlucde
 ipv6
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 Ido Schimmel <idosch@idosch.org>
References: <20250205114448.113966-1-znscnchen@gmail.com>
 <7fcca70c-9bfe-4fd7-b82d-e21f765b8b87@blackwall.org>
 <Z6NcWfVbqDJJ4c11@t-dallas>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <Z6NcWfVbqDJJ4c11@t-dallas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 14:40, Ted Chen wrote:
> On Wed, Feb 05, 2025 at 02:12:50PM +0200, Nikolay Aleksandrov wrote:
>> On 2/5/25 13:44, Ted Chen wrote:
>>> Update the comment to indicate that both net/ipv4/udp.c and net/ipv6/udp.c
>>> invoke vxlan_rcv() to process packets.
>>>
>>> The comment aligns with that for vxlan_err_lookup().
>>>
>>> Cc: Ido Schimmel <idosch@idosch.org>
>>> Signed-off-by: Ted Chen <znscnchen@gmail.com>
>>> ---
>>>  drivers/net/vxlan/vxlan_core.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>>> index 5ef40ac816cc..8bdf91d1fdfe 100644
>>> --- a/drivers/net/vxlan/vxlan_core.c
>>> +++ b/drivers/net/vxlan/vxlan_core.c
>>> @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>>>  	return err <= 1;
>>>  }
>>>  
>>> -/* Callback from net/ipv4/udp.c to receive packets */
>>> +/* Callback from net/ipv{4,6}/udp.c to receive packets */
>>>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>>>  {
>>>  	struct vxlan_vni_node *vninode = NULL;
>>
>> Your subject has a typo
>> s/inlucde/include
> Oops. Sorry for that.
>  
>> IMO these comments are unnecessary, encap_rcv callers are trivial to find.
> I'm fine with either way. No comment is better than a wrong comment.
> Please let me know if I need to send a new version to correct the subject or
> remove the comments for both vxlan_rcv() and vxlan_err_lookup().
> 

Up to you, I don't have a strong preference. You have to wait 24 hours
before posting another version anyway, so you have time to decide. :)


