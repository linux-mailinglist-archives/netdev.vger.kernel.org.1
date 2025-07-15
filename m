Return-Path: <netdev+bounces-207192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0929B06268
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 17:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D708E3AD998
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 15:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E632236E3;
	Tue, 15 Jul 2025 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="blJfaVLT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242392248B5
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 15:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592119; cv=none; b=isr1qkVRBp7cCS0Q8iD2okMX2cfjUXW6AquMsKeoQQCY3ryZPo+BVe6oqcFh/W8cX1osd0zYpgXxQP+xZTGJ4zJUKOW8elOwe7HBOvGqqRK81JaynK6l6U6C18/pVdsvsH5RwPuvcxUxn5SGSRAL5x2h69D40IJOLK+08twk2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592119; c=relaxed/simple;
	bh=8/c9SvdpT5SMQUGdg14wqUd8RcXgLCD2B+3RBRCTuqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BCxyRAZ0L4eTxNMxdlKw/GQR+aKChb8/iA9EbuyReFpRsO1QSFv/2w9qRaLHb7HABgezLybYTeWEHvaKsrHTfEA7h3gUNfGVWOGU2FnFSCiwO+T6JbJ8lvyThYIhZ1Bv2ZQitQMUPqzUZK8bH32weDnm3yPgGX+e5HF8r00VLjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=blJfaVLT; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so11019460a12.3
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 08:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1752592115; x=1753196915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1vv3fscdY+W3/95CjBA+hFt++AnebPWL+6206manP8k=;
        b=blJfaVLT1RmuHDEzVcSZPZG++UmsNfHazW2hbbI4iSXMt8XOZEUJkKvG0Ce/uD2D7k
         s+/KNZKY8Vdf4Fk4SHu16HveNeQvJ/npTYqQmQhNRM/aIsy3bu+SZBMPU+8I49TP9Zkb
         n4HQ+w24YDTWmkAzZrA8WPmGJ+YCC1yZoYoJhPXHquKThmtlXhFxDxFxCrxyBwAMaIGY
         5THB/I4bbEry29/AuLJXgxXBRrN8ZCgMsbbF8pyCk6SqYSO3sViLYyCJ51v7c1B1Vm5t
         vzUcFOMuAnfVluK2OeQyMpm/8HGQvJhkmfElQlCqNjFtvoLvVSECfrtCJgzyJEZnMFV5
         +Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592115; x=1753196915;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vv3fscdY+W3/95CjBA+hFt++AnebPWL+6206manP8k=;
        b=K8gIzSu1ANCUEACXoydSRWgr+I8pO2zE412uGVglGBzgEyTn4ZAhEApku01W8y1m7z
         CeO6rYIzAaK+naHMlEf5lFYrhiiuIKMLSx2aNtBrhcR6oJW5znczqnJtbozySO5jutiN
         ioZnAPBaid5t1p31uPnsgt/BhOK1RUl9nVDoJsBLFG+olYsBix+LgAvkgQ2Mx2a6SkOc
         kV1Zx/msfJXnkl4K0rGPs9ZtBzpT/5vAUFPWcwKUb48gN0EZkpYuZa3kVMEtsGJg2Bev
         XKdo3o4dDqAK3R9i3e+/ecCYIz+w3auoCGGq4hwD9yAS3AjmtVqvlU82g1uz7D1KnZ/Z
         xmjg==
X-Forwarded-Encrypted: i=1; AJvYcCXrySM8T35yb/k2eYRFGQ0bp2kVpsbLMXjRoSYq55JBe2gQ4fiue1EOXEhqeJDr3N4wbA5I6EU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzusFA7xKnCg91qAoDwKX+L2jlPBeQi2nniqDnIrhVk10nr8pw1
	qNjUS8rvIvKnExU8aUs1OV7M3hkcA8gifvGSaHq80n4XyjZT1gp1yxgZClzqobioNWATZUOB7JQ
	lWPbIQQS5simGjHVcb7XojOUBEPZaafAMq1Yy7rbL1vkef9vZ+ZA=
X-Gm-Gg: ASbGncuFqyz052jh/BdAum5Yv8HW8CXwEiV67dbqvCbQi8DsopaeHI5F+u2FDreBwo/
	JH3mkZhKmMPSNp5HLIwPB9drhGCbKtVd6Yg53wlyU11Tvl792Lqk0pYmHLsL8qsTbUU1FwKpzR6
	sWg5fwr8Ckfg7oSaDyoDW/B1PpdspHdCAVIgYU4y4V73stzxDJDww9aYcWArN2Eqfe54CJrTR6W
	LpkTT6Fcd8oTwQ/AA2BIUGGE6Ux7yRvhROYm0l1PrQyAIFN6z5zxjhDj6MsQvY9HCQjANXm6gdc
	O2Q43SQG/4PtrSGRNRpYM8F6jWQEuZOS1YNgb/RI1y6dUazVn6ucgMtPfIRqZifpE2yGXyQbuMR
	drYvvYu1ckaoKJ40xgzjXWBaqHcdBNVdHBoJSAHaIEqCeTox/B8JjX2xX8w==
X-Google-Smtp-Source: AGHT+IHkcfMiprYsNEpOy+of5pgN0/tzwxDvMvb/BQlymKSKelUUz4u9uoKVQ0WwuyTVM0DU3UdP1Q==
X-Received: by 2002:a17:906:fe0c:b0:ae3:5212:c906 with SMTP id a640c23a62f3a-ae6fbe13960mr1942062466b.10.1752592115233;
        Tue, 15 Jul 2025 08:08:35 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c351:6ad1:c4bb:877? ([2001:67c:2fbc:1:c351:6ad1:c4bb:877])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7eead7csm1026913766b.62.2025.07.15.08.08.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 08:08:34 -0700 (PDT)
Message-ID: <6e676755-e104-49d0-8fee-5bf12d7f9ecd@openvpn.net>
Date: Tue, 15 Jul 2025 17:08:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] ovpn: explicitly reject netlink attr
 PEER_LOCAL_PORT in CMD_PEER_NEW/SET
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20250703114513.18071-1-antonio@openvpn.net>
 <20250703114513.18071-3-antonio@openvpn.net> <aGaApy-muPmgfGtR@krikkit>
 <20250707144828.75f33945@kernel.org> <aGzw2RqUP-yMaVFh@krikkit>
 <d063c580-9e52-4f2b-ada2-7ca097cb9b85@openvpn.net>
 <20250715080630.2704593e@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250715080630.2704593e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 17:06, Jakub Kicinski wrote:
> On Tue, 15 Jul 2025 16:36:40 +0200 Antonio Quartulli wrote:
>> As Jakub predicted, I am hitting a problem with PEER_GET: the
>> attribute-set is one for the entire op, therefore I can't specify two
>> different sets for request and reply.
>>
>> I presume I need to leave PEER_GET on the main 'ovpn' set and then
>> opencode the restriction of having only the ID in the request.
>>
>> Similarly goes for KEY_GET.
>>
>> Sabrina, Jakub, does it make sense to you?
> 
> Yes :( Sorry for the mixed solution but I think using the spec to its
> full capabilities is worthwhile, even if it doesn't cover all the needs.

I totally agree - at least we can limit the opencoding only to a few ops.

Thanks for confirming - I'll go with the mixed approach.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


