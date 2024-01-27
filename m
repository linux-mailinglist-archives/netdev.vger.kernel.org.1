Return-Path: <netdev+bounces-66434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6122483EF92
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 19:51:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE741C21221
	for <lists+netdev@lfdr.de>; Sat, 27 Jan 2024 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B6F2D05B;
	Sat, 27 Jan 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLeeNu4v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626DE28699;
	Sat, 27 Jan 2024 18:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706381495; cv=none; b=YMZQgRw5VJZ75E7QBwU+b5myCAy8F+2GDrj/08VWq18sBjGsuzynyKI44l5A0p7WKgbnY9RCQtZiL37Uty2nFjnyccWCykyKoUPZJnJIUv5cgeN57610PsK5iaIwXxyC1yE1WPoSPYPtzBy9fYmGFJgNd2V2QLr2WuLBkCY/t44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706381495; c=relaxed/simple;
	bh=3IzUgfgIvf/pq6M8C0PMcE1lUhqWfgECUFsKfvIBavQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQP+vEmIHh9zaiitlDU3ENeCapy8M7O7yik0aYmdK6t1wW083okjbeVtnjH+hSaB4IFgTONmR5y2oGAI2kDvc19PxrNmH2OvXC6706X4dVJtDoB5GKHmtyho375HEUQeXmw5NvcFGzDT+maB/z0jc5hDSRZqUmBl/ttlLPnn4Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hLeeNu4v; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a350a021120so141743166b.1;
        Sat, 27 Jan 2024 10:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706381491; x=1706986291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hy8KhttmqxVvGNDMP3oJ+83x46tasxIHLpphRe5VYo4=;
        b=hLeeNu4vZHjW/Sp6VqzDvqQ9H8fbIJBXDBOEOfl2/sYpp2vbOknIwGa/2Uq/qctFfi
         v5iCKqLVBD5FoSDyO4ALFRWxBYZL/aTD1Q75sx6J7yqNIP+4lhZ93Uy1Ps/z/OfKT/pK
         lmDUliKbnv1gZ+7QqUSSkQKdZhZxd0/TjlL5w6g9DChKe5N5RtbolQhwOMh5diFmWUAV
         U3CIkQ5w85W7dSAMVFwU5WXgXFLjhVMH5YnBkqT2bUUMSX3Qm46mj8+xg9LxtrwHPViC
         czdWLEkzh0OWgQIUkKdO4VNL/cbeKdo0cMifvvRna5CyT3CbPgK7kqf1DohoOv1GTCN1
         tbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706381491; x=1706986291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hy8KhttmqxVvGNDMP3oJ+83x46tasxIHLpphRe5VYo4=;
        b=fHcnK4Kbl+oTH7ZJH7FXktcYJVigb7wemgJVB2wNmCM5lpr9//77tLDP0Z7rtpFMuE
         CCMnHc/9ivlHZb7ELaw++lAXz8iXMUNXvkLjHuiBnz88Sb0LS3JGjlYvpUc6HCTPn4Z1
         Xu1Rfh3Gjn1/KWK4uPejmOJVLWo0KGbF/Gcv+G0bTARpb6n5FJUe4owLr37rhrnUiOnn
         +W+gNlKGHvGLkri9paomZITPbbvXVVXHm8se31T+bbjfAY3y9dApQpDLs4a+JuAOGHVz
         UbihH27aYKFYMuunYI4YAJN3/f+wf0jo6ptG92w1PxnAdXI9xBcx/8WdP2Fy9Emwt/1v
         hAZA==
X-Gm-Message-State: AOJu0YyX/NDYF6nRVpsWt8gB0r+P0C7gyj3WMN3aA3Q0zMRkNeeYqyhN
	IpejgCgImO2pxgwvmB9kX93VwllqyGc0QkLmDJO1/m+jaOpciV+M
X-Google-Smtp-Source: AGHT+IFHAWgGZbshiiR5jOUU1BKfHM42cM2HOuxjD2inVbkoc6ReEzRNm5Ht0W6PDBOCfTEV9YSHDQ==
X-Received: by 2002:a17:906:f146:b0:a35:64ff:4817 with SMTP id gw6-20020a170906f14600b00a3564ff4817mr485460ejb.0.1706381491182;
        Sat, 27 Jan 2024 10:51:31 -0800 (PST)
Received: from [192.168.159.171] (93-40-83-91.ip37.fastwebnet.it. [93.40.83.91])
        by smtp.gmail.com with ESMTPSA id rg9-20020a1709076b8900b00a354e4d3449sm694600ejc.120.2024.01.27.10.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jan 2024 10:51:30 -0800 (PST)
Message-ID: <fcf9630e-26fd-4474-a791-68c548a425b6@gmail.com>
Date: Sat, 27 Jan 2024 19:52:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages in
 nested attribute spaces
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 Jacob Keller <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>,
 Jiri Pirko <jiri@resnulli.us>, donald.hunter@redhat.com
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-3-donald.hunter@gmail.com>
 <20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
 <20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
 <20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
Content-Language: en-US
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <m2jznuwv7g.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 1/27/24 18:18, Donald Hunter wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>> Is it possible to check at which "level" of the chainmap the key was
>> found? If so we can also construct a 'chainmap of attr sets' and make
>> sure that the key level == attr set level. I.e. that we got a hit at
>> the first level which declares a key of that name.
>>
>> More crude option - we could construct a list of dicts (the levels
>> within the chainmap) and keys they can't contain. Once we got a hit
>> for a sub-message key at level A, all dicts currently on top of A
>> are not allowed to add that key. Once we're done with the message we
>> scan thru the list and make sure the keys haven't appeared?
>>
>> Another random thought, should we mark the keys which can "descend"
>> somehow? IDK, put a ~ in front?
>>
>> 	selector: ~kind
>>
>> or some other char?
> Okay, so I think the behaviour we need is to either search current scope
> or search the outermost scope. My suggestion would be to replace the
> ChainMap approach with just choosing between current and outermost
> scope. The unusual case is needing to search the outermost scope so
> using a prefix e.g. '/' for that would work.
>
> We can have 'selector: kind' continue to refer to current scope and then
> have 'selector: /kind' refer to the outermost scope.
>
> If we run into a case that requires something other than current or
> outermost then we could add e.g. '../kind' so that the scope to search
> is always explicitly identified.

Wouldn't add different chars in front of the selctor value be confusing?

IMHO the solution of using a ChainMap with levels could be an easier solution. We could just modify the __getitem__() method to output both the value and the level, and the get() method to add the chance to specify a level (in our case the level found in the spec) and error out if the specified level doesn't match with the found one. Something like this:

from collections import ChainMap

class LevelChainMap(ChainMap):
    def __getitem__(self, key):
        for mapping in self.maps:
            try:
                return mapping[key], self.maps[::-1].index(mapping)
            except KeyError:
                pass
        return self.__missing__(key)

    def get(self, key, default=None, level=None):
        val, lvl = self[key] if key in self else (default, None)
        if level:
            if lvl != level:
                raise Exception("Level mismatch")
        return val, lvl

# example usage
c = LevelChainMap({'a':1}, {'inner':{'a':1}}, {'outer': {'inner':{'a':1}}})
print(c.get('a', level=2))
print(c.get('a', level=1)) #raise err

This will leave the spec as it is and will require small changes.

What do you think?


