Return-Path: <netdev+bounces-66872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8013A841464
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 21:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A161A1C2412D
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B0157E75;
	Mon, 29 Jan 2024 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgbOed/C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC74157E60;
	Mon, 29 Jan 2024 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560475; cv=none; b=QOcbUdV7EjMNjRnmqKtzIZIZsibalHVsE44r4CR4/0PyL/t8Yp9//vdAlsoIdGlIzbZ/Ejq/AzBcyXoOSQAncRP/03FjZGZgiuffyrjHImNbFx18OFsDnChtBhs1hFCjMDGutYV+2ZHo2Uu/Qt2A6HuuXBaBc7CfMDcoUqOkXpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560475; c=relaxed/simple;
	bh=uwYfI8ZH97ABK24JBgyk9nqr5KgeMLw0uZfqpsw0t6Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HM83x7jLbmiXa0JVoT+2V8N89/ins7ylUQ7Cwzq8VGIkACHFfKpfpc6leOMLYANo7wDvTA+iNA6KHkuNRPfio1ngJscUIUR1SW3UeltM+6DFngVrTwdorGrI44rame6J/A+M8vvmOueSEmTPtyd2cAkwuOwjBkHb6JoJih8918c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgbOed/C; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so372933866b.2;
        Mon, 29 Jan 2024 12:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706560472; x=1707165272; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uwYfI8ZH97ABK24JBgyk9nqr5KgeMLw0uZfqpsw0t6Y=;
        b=hgbOed/CE9GbglDfxIIP/O8qMOdjQWm5IProcQxy/ewGd7+QcoIgI5kN4ZJirSOjlH
         0dCo0FulqQdmxd3rPO88a61JOcVyOUF2NHpUfTn06zSvEH/ncAwKDvYK2YWIhiZz05Qi
         kxOvk1dJFHuelA6hgvrdLbFsPygXQLSO7FVTgQJjcr1p61lSUhwuxtUJ3THMphCrEcbN
         7jOzNfFFuSpyPJUI/AM4qys6v8Z8EVHpxwg4vK4ekO6VEKf1xugIPUdIYFnYBlRhgUt3
         KzbsH+nClZGJaUCNq42Yw5FP8j4S7pAbpvVo2XJ0r8uO9ejN3UBrFsFRn6Zftiz7GEbj
         ar4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706560472; x=1707165272;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwYfI8ZH97ABK24JBgyk9nqr5KgeMLw0uZfqpsw0t6Y=;
        b=isSepDeWI6HPL9o5MLRfAiCytPnCVf26zhFz9LkPHCgX3u0EdrQfKRLuE5u2dubpAq
         6DYH9PyYZ9QCj4Iul9XiUjxiXOmnif+C9eFamnx1OTpg4fVLPL0g4zn2+rgIuwfpeJCk
         uu8vzvNCsS8JK89aKaSKvejXQRChcWAdu1+D/VBW8pf2EspOxkx2VWMh5Q9v4/JxRnFe
         uANB4eTTphRcAxOTVMiWgokgN5fxZNRCsD6+7PR8vkds1oEaTjZcC6jgzcQIpMMhlpUj
         TMUqrYVb0TXri0wvowxUa6IeIydJ8PUUeMU05A3uiTBd5GjeQ3KN1/pXKGEl2v8XhBjP
         /bMQ==
X-Gm-Message-State: AOJu0Yy1Z5AJDGJMwA7PcriOMoVeL+EJHE25xItatFC4oILIYm9Up6/8
	xeIWMqRhrP8ozkBJAe8d6nNeT5ZZLjhsloFmpJv4Hq8Q4ovseLBh
X-Google-Smtp-Source: AGHT+IFdchIyeTypdnZusIcAz5gU+jL424v7Ird40iUWOoqxl0BheS818rBAarjGRpNnHUh6kBEkkA==
X-Received: by 2002:a17:906:140a:b0:a34:a8e2:6296 with SMTP id p10-20020a170906140a00b00a34a8e26296mr4985988ejc.69.1706560471544;
        Mon, 29 Jan 2024 12:34:31 -0800 (PST)
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id vu2-20020a170907a64200b00a35a9745910sm1741672ejc.137.2024.01.29.12.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:34:31 -0800 (PST)
Message-ID: <fbdf0e62-e52b-461d-88c1-70b4270780e0@gmail.com>
Date: Mon, 29 Jan 2024 21:35:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: Re: [PATCH net-next v1 02/12] tools/net/ynl: Support sub-messages in
 nested attribute spaces
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Jacob Keller <jacob.e.keller@intel.com>,
 Breno Leitao <leitao@debian.org>, Jiri Pirko <jiri@resnulli.us>,
 donald.hunter@redhat.com
References: <20240123160538.172-1-donald.hunter@gmail.com>
 <20240123160538.172-3-donald.hunter@gmail.com>
 <20240123161804.3573953d@kernel.org> <m2ede7xeas.fsf@gmail.com>
 <20240124073228.0e939e5c@kernel.org> <m2ttn0w9fa.fsf@gmail.com>
 <20240126105055.2200dc36@kernel.org> <m2jznuwv7g.fsf@gmail.com>
 <fcf9630e-26fd-4474-a791-68c548a425b6@gmail.com> <m2bk95w8qq.fsf@gmail.com>
Content-Language: en-US
In-Reply-To: <m2bk95w8qq.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/28/24 20:36, Donald Hunter wrote:
> Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:
>
>> On 1/27/24 18:18, Donald Hunter wrote:
>>> Okay, so I think the behaviour we need is to either search current scope
>>> or search the outermost scope. My suggestion would be to replace the
>>> ChainMap approach with just choosing between current and outermost
>>> scope. The unusual case is needing to search the outermost scope so
>>> using a prefix e.g. '/' for that would work.
>>>
>>> We can have 'selector: kind' continue to refer to current scope and then
>>> have 'selector: /kind' refer to the outermost scope.
>>>
>>> If we run into a case that requires something other than current or
>>> outermost then we could add e.g. '../kind' so that the scope to search
>>> is always explicitly identified.
>> Wouldn't add different chars in front of the selctor value be confusing?
>>
>> IMHO the solution of using a ChainMap with levels could be an easier solution. We could just
>> modify the __getitem__() method to output both the value and the level, and the get() method to
>> add the chance to specify a level (in our case the level found in the spec) and error out if the
>> specified level doesn't match with the found one. Something like this:
> If we take the approach of resolving the level from the spec then I
> wouldn't use ChainMap. Per the Python docs [1]: "A ChainMap class is
> provided for quickly linking a number of mappings so they can be treated
> as a single unit."
>
> I think we could instead pass a list of mappings from current to
> outermost and then just reference the correct level that was resolved
> from the spec.

Yes, you're right. There is no need to use a ChainMap at all. The implementation I proposed is in fact a list of mappings with unnecessary complications.

>> from collections import ChainMap
>>
>> class LevelChainMap(ChainMap):
>>     def __getitem__(self, key):
>>         for mapping in self.maps:
>>             try:
>>                 return mapping[key], self.maps[::-1].index(mapping)
>>             except KeyError:
>>                 pass
>>         return self.__missing__(key)
>>
>>     def get(self, key, default=None, level=None):
>>         val, lvl = self[key] if key in self else (default, None)
>>         if level:
>>             if lvl != level:
>>                 raise Exception("Level mismatch")
>>         return val, lvl
>>
>> # example usage
>> c = LevelChainMap({'a':1}, {'inner':{'a':1}}, {'outer': {'inner':{'a':1}}})
>> print(c.get('a', level=2))
>> print(c.get('a', level=1)) #raise err
>>
>> This will leave the spec as it is and will require small changes.
>>
>> What do you think?
> The more I think about it, the more I agree that using path-like syntax
> in the selector is overkill. It makes sense to resolve the selector
> level from the spec and then directly access the mappings from the
> correct scope level.
>
> [1] https://docs.python.org/3/library/collections.html#collections.ChainMap
Agreed.

