Return-Path: <netdev+bounces-118547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206D5951F8B
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3D71F2382F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D461B86D1;
	Wed, 14 Aug 2024 16:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CaFiPq/X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3234C1B4C34
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 16:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651929; cv=none; b=k1eeRdQIh7Jjs0Y+brVt+m2X3mObX+vkARqdgXQ1z3k3ktTFc/iiTPBlIknBQ6YD4bk93pXxe+qPkx8GmsXeJNo/rSddbrV03TRqL/ssaH8rx4zfXNw7Dv5saMjbJU40OfxeMF/HbKWge0U4GOlcYPZSSy6SO+5/5qgSfqqH48w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651929; c=relaxed/simple;
	bh=Oan3ObJkqiEnc6/yvnqRiFJa9vLTUkW1mmauzKlVyVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtTeoCT1alFo4XgNuFwkIwH4Dq5fKRiDtMQI2mGUzKpv0/u9rjjlAIxqLhl1X2RACs9HCyjroahZ65UjawJOHtbc7TODza7444Y7QXjJ0DWNUHyZiLj2ti506CDwD2WbDCMjKmMHP44sLALSFZDhnzlwU30+rFE8xFZEqLYzTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CaFiPq/X; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-39b0826298cso25472425ab.2
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723651927; x=1724256727; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UdHjVYm4ToS/5ScLduRvwVIkIowphxs+DKVOBBRh/F4=;
        b=CaFiPq/XnxbcenHVFxASGzxHK6ojgTJdYPRDxKHAjIJ4U3J44jOyiSNpMe3IqpGW2M
         XsYxUfSIToMRjLPe32YskNoPI1glSTCTQbz2/1XZZh9vAyIklsazfGMw4ywKEz66mSrD
         pCRMxSHchoHSn/bP7tnWphrRnpA+MdjaRFEZVDTRruQbwHt6avyyHo1NGV2VV2smqsjR
         ppyplGiqoHkVlZT/JcilSm4EzJGdor0gIrsCHJrMCwoMsnssfi3cto0EU2mwuJUheyu9
         HIIZzylsYnxChgtutnqsgzinGmD+Ft9TDZM30EfBxbjfg+ao8xsbRc3m8/ObzqxSrtCf
         Nrkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723651927; x=1724256727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdHjVYm4ToS/5ScLduRvwVIkIowphxs+DKVOBBRh/F4=;
        b=PYI6NrJ5QhXMzn8u7Y5XBBNSu6zZYr4Rdl1VJ4TngpbzHWBC4jirqwlZBHmSMOAXAD
         WEhQO7B3o52cv/uQDZtB+CoSFnXAvOuj2Fj0xZVyCzV8MsUjCRSXVXCyDuAgUqnhL5gt
         JrtpZebwMPNyenslNv+8uwGB4zHLcxB/jG5kNNlxPV2XE4iFFZAnHVPvBBHeNBtmk5/n
         SJ87u7QptbWIqQkYeB/E64U2uV9454kElICw636HDWStsmiFrmWgVraIgSVxeCHrNAjC
         UGGagZxZZTEwDv/IvIuNwy5GEeYq9ilK/8pO/u1M+d/21IikHKZg6rhqQ5fFD3WYPWyW
         bOPg==
X-Gm-Message-State: AOJu0Yy7ZTECABHsENX/JK2Nkszz8ieRj/6wGLnlH3RPRLKULUaOYaW2
	8CxeV3fqnKWGJx6fSdm51zKyNoLtvBak+BQO8QCR2ZHXD+CXRplD+OAm6A==
X-Google-Smtp-Source: AGHT+IFMha0dkrbNQUzzIIO6Cb4u9F+Iqd09VClctikEatMZzs3SY+rc/AZ4vqSMqGrk1pW6/6FQjQ==
X-Received: by 2002:a92:cda9:0:b0:395:ee4b:33b with SMTP id e9e14a558f8ab-39d124cd826mr44968315ab.23.1723651926914;
        Wed, 14 Aug 2024 09:12:06 -0700 (PDT)
Received: from [172.16.99.167] (c-75-71-227-135.hsd1.co.comcast.net. [75.71.227.135])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-39c30a9587bsm35054735ab.37.2024.08.14.09.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:12:06 -0700 (PDT)
Message-ID: <8c364f52-7173-433a-aa4a-dc2f9908dd5e@gmail.com>
Date: Wed, 14 Aug 2024 10:12:04 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Add `auto` VRF table ID option in iproute2
To: Ido Schimmel <idosch@idosch.org>, Mike Waterman <mwaterman@vultr.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org,
 =?UTF-8?Q?Daniel_Gr=C3=B6ber?= <dxld@darkboxed.org>
References: <CABmay2CxFPpsgzSx6wCxyDzjw2cqwAAKs6YjiArR1A2UPLpgJA@mail.gmail.com>
 <ZrzVNV7Ap230Lx4h@shredder.mtl.com>
Content-Language: en-US
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <ZrzVNV7Ap230Lx4h@shredder.mtl.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 10:03 AM, Ido Schimmel wrote:
> AFAICT in ifupdown2 they have a table that keeps track of allocate IDs
> and they simply pick the next available one. Unlike ifupdown2, iproute2
> does not have state and it will need to query this information from the
> kernel which you can do yourself in a script before calling this
> command.
> 
> Overall I don't really see the benefit in something like that in
> iproute2 and I don't recall other iproute2 commands that work like that.
> 
> Also note that ifupdown2 reorders the FIB rules so that the l3mdev rule
> is before the local rule. This is something that iproute2 does not (and
> should not) do.
> 
> Adding David who might have a different opinion.

I agree with the summary. Table id management is for interface managers,
not tools like iproute2.


