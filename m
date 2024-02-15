Return-Path: <netdev+bounces-72014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CAE8562D6
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF02E1C208E8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B54412C7F5;
	Thu, 15 Feb 2024 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Ys/Qfe7m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887012BF05
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999232; cv=none; b=gVcLraev8mVPDmQ4XDEQeMWbp59LHUCu8dOPbrnnMDF25gBrN0q5GxgEkDRJZDMb3K4uwfGGJPHUbVC2m18I16b3xNTOJAUK49KEHlcKK7QLmMa/byksR25BV3v+Iis4cHWE3biFGna2iMPqmwjwB0ZZnUMd0DblWmeE1oxSy6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999232; c=relaxed/simple;
	bh=75aSx4mlppEK+0D5pEBXAG1XJMjf5iYhpFM4vSd5YC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVZQbjXPWwwgHicK5sIMa7JAsFVQOnn51E8sdROJU0zpA1q1NTZBSP1XxsYA2V+WJkc04UhNS0pmC6GZTb2H4su6GPCuo/3J8Q17NNS/M1+WBB8tAYEezNqAJ+bWTeTFdcbQNAapGTaZVbIDq/H2Vh+RvVakEjFyE3Ewci1xDLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Ys/Qfe7m; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d10936af1so155074f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1707999228; x=1708604028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pCOeUKQKqQx9f8JhpbG3MRAvrOwnBIZGYQFdNoVumQw=;
        b=Ys/Qfe7mRPZ9BeUJmqRcIKB5QKUj9a9qmIdoEBGe7x223TbwVxLy55H1rvN1VX/Dng
         qCqcY0ITt8ocoqPHStHPQrLVNpSDzdk3CICRx5dm2l+jyOJzerL8hRR3YX+QR1kgpr/P
         w84JaJMNTCwAhfi8kGEHqwNPaf/7Csa2EBrBnh/yWTzlLCKCrY80bwWtEapkjArLml7K
         9vpyZwJH8QJ5D9VINYcOUpxOlOHE+xBrZC7ZZXZwHMNosvG4fsK2GLjtZDnCibjilA/3
         UU7X2FzmIfLGPyzDAdbp8k5bl4h89encFyqgMrtG+Krx2u3F1rtbdiafJsgm6h632Zue
         JVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707999228; x=1708604028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCOeUKQKqQx9f8JhpbG3MRAvrOwnBIZGYQFdNoVumQw=;
        b=TeLeaS92aoEdKfvqRejufqw3Gd9VY3B1wLyio3081dhy78CYVa85Xw75sTF3HkoAql
         KV9KvdYCllA30Q7U8gUH5Sgj6XCxFzcJVqfwcUkBuG9Ce10b1asJ4rnQVH4tZvBNp1j3
         KEtwWGghgwxHG58249RyDX/0xvFqd78Q7H7YQQZ1HvDebWGoJXVnlLDMvtTa88i8Xz/f
         lV+6iMwrPZzjis7XIENLDL9lXfSGaT5M+ipnZ6e4nZ3jWXw9sWfmOpcWescAHwjL11Y8
         jCDQJ1sqUdSVA88gNxm0z4ZLVY5iMZGehzipyHVczp6rQcHRmmMC5debPy+kA79YVtJq
         6tXw==
X-Gm-Message-State: AOJu0YznHrHvsXnnkVWPDDb22Dv0tXaxJE63sU/W4EgBoPKIYUv69J07
	DsGyB7GeViRdNzw2Yo8d7JnT9Ej6XnAsH0kv00Q8VN/+v6GRgjPrUEvkxbn823c=
X-Google-Smtp-Source: AGHT+IGUjtsJF/mxh0wEjqtCUStJCqOJ3M0vOhGt7y84LkqzucYUjWF82wybsdP68ht+qxLP6JbnLA==
X-Received: by 2002:a05:6000:1085:b0:33c:e07d:17a5 with SMTP id y5-20020a056000108500b0033ce07d17a5mr1151430wrw.35.1707999228462;
        Thu, 15 Feb 2024 04:13:48 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id cl2-20020a5d5f02000000b0033afe816977sm1658712wrb.66.2024.02.15.04.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:13:48 -0800 (PST)
Date: Thu, 15 Feb 2024 13:13:45 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next] tools: ynl: fix attr_space variable to exist
 even if processing unknown attribute
Message-ID: <Zc3_-YMMiCd6fc-9@nanopsycho>
References: <20240213070443.442910-1-jiri@resnulli.us>
 <8bcd540b747ae30edc10c5208d7876b901e702b8.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bcd540b747ae30edc10c5208d7876b901e702b8.camel@redhat.com>

Thu, Feb 15, 2024 at 11:59:08AM CET, pabeni@redhat.com wrote:
>On Tue, 2024-02-13 at 08:04 +0100, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> If message contains unknown attribute and user passes
>> "--process-unknown" command line option, _decode() gets called with space
>> arg set to None. In that case, attr_space variable is not initialized
>> used which leads to following trace:
>> 
>> Traceback (most recent call last):
>>   File "./tools/net/ynl/cli.py", line 77, in <module>
>>     main()
>>   File "./tools/net/ynl/cli.py", line 68, in main
>>     reply = ynl.dump(args.dump, attrs)
>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "tools/net/ynl/lib/ynl.py", line 909, in dump
>>     return self._op(method, vals, [], dump=True)
>>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "tools/net/ynl/lib/ynl.py", line 894, in _op
>>     rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "tools/net/ynl/lib/ynl.py", line 639, in _decode
>>     self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
>>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "tools/net/ynl/lib/ynl.py", line 569, in _decode_unknown
>>     return self._decode(NlAttrs(attr.raw), None)
>>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   File "tools/net/ynl/lib/ynl.py", line 630, in _decode
>>     search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>>                               ^^^^^^^^^^
>> UnboundLocalError: cannot access local variable 'attr_space' where it is not associated with a value
>> 
>> Fix this by setting attr_space to None in case space is arg None.
>> 
>> Fixes: bf8b832374fb ("tools/net/ynl: Support sub-messages in nested attribute spaces")
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  tools/net/ynl/lib/ynl.py | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>> index 03c7ca6aaae9..b16d24b7e288 100644
>> --- a/tools/net/ynl/lib/ynl.py
>> +++ b/tools/net/ynl/lib/ynl.py
>> @@ -588,10 +588,12 @@ class YnlFamily(SpecFamily):
>>          revalue = search_attrs.lookup(selector)turn decoded
>>  
>>      def _decode(self, attrs, space, outer_attrs = None):
>> +        rsp = dict()
>>          if space:
>>              attr_space = self.attr_sets[space]
>> -        rsp = dict()
>> -        search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>> +            search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>> +        else:
>> +            search_attrs = None
>
>It looks like that later-on the code could call self._decode_sub_msg()
>-> self._resolve_selector() with search_attrs == None, and the latter
>will unconditionally do:
>
>	value = search_attrs.lookup(selector)

How exactly you can reach this? You won't get past:
            try:
                attr_spec = attr_space.attrs_by_val[attr.type]
            except (KeyError, UnboundLocalError):
                if not self.process_unknown:
                    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
                attr_name = f"UnknownAttr({attr.type})"
                self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
                continue



>
>I think we need to explicitly handle the None value there.
>
>Thanks,
>
>Paolo
>

