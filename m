Return-Path: <netdev+bounces-109044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0612926A8B
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A82E1F22F72
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 21:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38DB194083;
	Wed,  3 Jul 2024 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KucnQUjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6C6191F91
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720042971; cv=none; b=a/HZDAzA05pYJd08hBJBO7O3jGdLivPf3dVuavidCPTGZPBu8F57imI/MTu3LjoF0GnAcAWkPNFnOaFXplXeXDrfgOXd/vfCtm3iSSOcRwEXBRqShGuPLhy+y4yIv6dtU9mQFOvhnQSkfoDGzO4rwS2q/xiSQUDfyHeuT6kV1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720042971; c=relaxed/simple;
	bh=iXzzgWwkyDyHIh13u4RNbNBL2fqXALY/XMcCu0blRFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JliQyIshtdkIopMAC4ixj+ht5lHYja2SC7FiNm4XkJRgcDMEqQ+LQtiQzPVRviEyB0bjJEV60d2CDqWeEQwanhByKA2cjBsWeUGSJ4F7yZaAUUl6xPr89NKgvlguHGQxvsUa0fvSmH4cdDR72jCx/kaVa4rS+a9Nkq8ezXcVFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KucnQUjz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-362bc731810so7131f8f.1
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 14:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1720042968; x=1720647768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sV7Pu5VTw2c+MSToNZekrnQnftzWdao0dFMW4X4SCSo=;
        b=KucnQUjzu9eCLNnLRkrZDu8ZpxCYeIagAWwYDao/iIf2FIXYnrl1MU7uDaWesjHpMK
         6n7BFWy+QrZyB4e8XLknBmPEWMNqPgcs1tHn4n8ndBmgJgm753Hd05il69smBBh2WWAK
         Sjf1Fg4Vt8+AMuBwNo89GqrIFtfz3mcLInyg8FGrDlk0tHqxUZ/MaIzdjVyLxhYX0KT1
         dbhc3AVClfhvfS0ZS6HEB8f+wHHEIm1OTTO4QimVPoA92hxuc7rDHeAtAWk5grziVceC
         QV59NAcX8tTX2u9WT5QIlIduRd3minBQ1J+Cp2kLYEVrAcEIUa8/fqegUA2ov+IGepFe
         zTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720042968; x=1720647768;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV7Pu5VTw2c+MSToNZekrnQnftzWdao0dFMW4X4SCSo=;
        b=L9Rtk7C/JX/FLU5kApnyoYkrvfV2MwizBqjXF/TJr/VfIOFZ+ovsUzi42g7m27CX+X
         L5Ltb/8/6z3yd2fxUs395pttiImFXSaQTZw4MN53kZhe08FE/Ndri/r+JDQKXFBXCy1b
         7iGCIkg/6CjfFFDWyYT0Qo+K2APztxT9FMfgx4c/W+cgIR2bWLDf47X1xxEF7mYEt8eH
         mij49Rw/g6p3+dflBZ25sGpQrPQytKW0OFCrjmfmrXOAEhNBBiKgpSFYDVUfBqW4mjTV
         Z0T5jt48OJq74glTo1GQpu2TcX7qLdgSY+85cdZJmkfGcBsxrnRYTkEwVk1wYy/PiJQr
         hmJQ==
X-Gm-Message-State: AOJu0YyOYvL04BcdhZa27mTdsjAlkufrWlf3iuZ7pvepgb25D0/KwIfX
	73yqYge4XQFDkDjGRpwB9KFaWxlv+kB7pwg2pI8qEs1TYCU1lovXdqjATofc06E=
X-Google-Smtp-Source: AGHT+IGIhhE5X0Xag8E/q4POafNlqds4xnq9uvezbxHiGb4C6jhOe+TJgQVarUi0BeH3BA37pCO9Ug==
X-Received: by 2002:a5d:64a4:0:b0:366:f04d:676f with SMTP id ffacd0b85a97d-367756995cdmr12375546f8f.12.1720042967795;
        Wed, 03 Jul 2024 14:42:47 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:733d:9048:62cb:ccf? ([2001:67c:2fbc:0:733d:9048:62cb:ccf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679927d7aesm712272f8f.30.2024.07.03.14.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 14:42:47 -0700 (PDT)
Message-ID: <9822899c-b8ac-45e0-8cbf-d105320ee0e4@openvpn.net>
Date: Wed, 3 Jul 2024 23:44:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 06/25] ovpn: implement interface
 creation/destruction via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-7-antonio@openvpn.net> <ZoXCKPlwfhB2iPBC@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZoXCKPlwfhB2iPBC@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/07/2024 23:27, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:24 +0200, Antonio Quartulli wrote:
>>   int ovpn_nl_new_iface_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> [...]
>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	hdr = genlmsg_iput(msg, info);
>> +	if (!hdr) {
>> +		nlmsg_free(msg);
>> +		return -ENOBUFS;
>> +	}
>> +
>> +	if (nla_put_string(msg, OVPN_A_IFNAME, dev->name)) {
>> +		genlmsg_cancel(msg, hdr);
>> +		nlmsg_free(msg);
>> +		return -EMSGSIZE;
>> +	}
> 
> Maybe the ifindex as well? The notifications in later patches use that
> rather than the name, but I don't know how the client handles this reply.

Userspace will just throw the name in if_nametoindex().

However passing both doesn't hurt anybody, and actually spares the 
conversion in userspace.

will add ifindex too.

Thanks!

> 
>> +	genlmsg_end(msg, hdr);
>> +
>> +	return genlmsg_reply(msg, info);
>>   }
> 

-- 
Antonio Quartulli
OpenVPN Inc.

