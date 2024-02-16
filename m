Return-Path: <netdev+bounces-72320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2278578A7
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1B6B2140D
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FF1B946;
	Fri, 16 Feb 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="UvSBJpR3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AC1BDC9
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075031; cv=none; b=TYZF9nbfnDqcDstpnjCgTjbQ/0YVXVpMd0ON76ZCyk+DXgL7MkQ/PIL1xZRKXe+rYc7p5VVxiBdvHJGa7cKFsqrQAGdM0G3sb9atGmyWCBELVKDhaB6CV/zE7mSOllqDxbCwe34aRc5/Afi3KqWg5GSTT/TzqSMJ5V8fW805vTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075031; c=relaxed/simple;
	bh=NTj0WJGZSKGAILO9IvUWwmYwobpJQrjNVKxioxqI+P8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TfOTp+IRlnvN0wBPabbMvFxzwALSsg4UEey6Zhe6Te6JatePS+fqGiTSSs+uZ0sejOxe55rglDwxKo2B+sF6LARtNIiUp96HFDNSNkcKcOmUzG3DTeIPs9o/w08tlrWwUxOVUN1ATlPtNgGGDIY7cJeLrdS385mqSVFXyQZ4Qzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=UvSBJpR3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4125295ff94so701145e9.3
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1708075028; x=1708679828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y9GsxQXzT89WJ7EVi2cxK7uX5QlZRpbISkH5MWI70AE=;
        b=UvSBJpR3J3bZWSUogEgzooi2JzEh5OTHqbCcFFROlyEYKmQp+DWadIzU874sKKBiMw
         PV7oLHq15RfQU0pbFRra824SubmMYJUXYmaRfpK3tqJT3YjmKcZEx7FSNN5lG2C65nzg
         qyXunHMpRJjWp0zpaTEKgkMnZBOFPn/YQPXpVB+WQN6Avfa0oyZZ+Fm2jdXSXPJ+tS20
         VeoghV2cxhnxlhpDrb9qQphUKCIch3djWH73lN9OEcdVQ94tAfvYk10wCDxKwFV3NaUz
         9R/cGHyKWL6FVb6IIbF1pSippRWrwSShyWRRr5xekyekW8QzSMK/n3cp5obq6XX7UJ2F
         RIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708075028; x=1708679828;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9GsxQXzT89WJ7EVi2cxK7uX5QlZRpbISkH5MWI70AE=;
        b=tyi9imzBveYe3gZVkPu48fJ/qTn8rHNUwAM98rPmKsxNE+CB7YMP20tv8sBRHiyy6m
         GTLlxYC3OFcJR5+WRKT0kRZUI+ax/sbwBZz9o5Ic82mUXAhwPzUAtNfSsYAZcUV+kQV5
         lU9dCM96rOgUHO14oNE6yehaySN4Yi0bfEVyLA2ukPDFgc+L3vyuNjmvgn1pfSuFOiXy
         MOuC68UuynfuUS5t2hfp+pCqqQTXytGxxsYR3npR7iCVBi7EeF+FFH5/uBwAFfw2QAK6
         CujWfL83WFzANrm+fcxuhXPQX7+Jna5ocNZtOOuNtPGj4wnHZMzRhHKOQo6/JwV4VemH
         DBQA==
X-Forwarded-Encrypted: i=1; AJvYcCV83C5PboETMMefPJQLcHC04NbPlWlACVdRc39vtTU0edXR02atOGfWk+kx/CLFOAKEQbvHq8xdX3280fBn24f46lXhlxyL
X-Gm-Message-State: AOJu0Yxhszt5xly/MpM3xUQc00Uh6CRW/2Ydnr1tDwiLV66+JqGMNqGZ
	XlBjsiSO2v5hhyEiP1Bcp4ZVsyZvpnxRDBXa8u6EeWPxi7fTyAnny7W8+qHu1Ik=
X-Google-Smtp-Source: AGHT+IEhTVG3qunWPrUBXVvIYh+dHxrf+hX7twInludxQ0X7sy0L7WTKh4jmu26+qLjdCYeFZb5EKA==
X-Received: by 2002:a7b:cb8b:0:b0:412:db0:4477 with SMTP id m11-20020a7bcb8b000000b004120db04477mr2954417wmi.35.1708075027965;
        Fri, 16 Feb 2024 01:17:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:b41:c160:8347:1f2a:aa47:cf48? ([2a01:e0a:b41:c160:8347:1f2a:aa47:cf48])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b00412393ddac2sm1752883wms.6.2024.02.16.01.17.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 01:17:07 -0800 (PST)
Message-ID: <c59b80a8-cf9a-4e16-a298-6bb9b4b367a0@6wind.com>
Date: Fri, 16 Feb 2024 10:17:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net 2/2] ipv6: properly combine dev_base_seq and
 ipv6.dev_addr_genid
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
References: <20240215172107.3461054-1-edumazet@google.com>
 <20240215172107.3461054-3-edumazet@google.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20240215172107.3461054-3-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 15/02/2024 à 18:21, Eric Dumazet a écrit :
> net->dev_base_seq and ipv6.dev_addr_genid are monotonically increasing.
> 
> If we XOR their values, we could miss to detect if both values
> were changed with the same amount.
> 
> Fixes: 63998ac24f83 ("ipv6: provide addr and netconf dump consistency info")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

The trailers are mangled, your sob is put twice.

Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

