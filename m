Return-Path: <netdev+bounces-72016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83C76856319
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDB14B233A1
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 12:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A9712BF15;
	Thu, 15 Feb 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="F1z6EIQf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2188060F
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 12:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000036; cv=none; b=NUjh+eNcvNf3itrhKHdGNdSmUQ3TTNdWDGz5QZ6KCxTDXN02CyJSBcYdQ/PvIGBSKc8Y2iLA7+TQhtEeEvEb/1ZFQ8K0lQ96lPnlhGvTNJm4CHMIjnGyd7R3D+daeSoZ0pKYtbgmB6BgHqqcdWlCJELjv0kmNN1mJFhq+ixKU4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000036; c=relaxed/simple;
	bh=2PYNZk46BOunizPMgshPib6QTArFdEKcG8sfojYZZ9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhogw1mrXiwUS4yuEpAj+ETy1ecnEFCC25NEJO5nWIc8z7q6zUyMyMhh9sU6TcNRnDc8Zsqwu5838Yt713uzGU+OlMHB0ZZrpR/4RZFd3+UG25wsaUiUTq9E7hQHxTNBnqRxG4I6ChR1Y0sRhxDVcuRbFYXSfhWp+Qt6sTHvhpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=F1z6EIQf; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-410e820a4feso10655705e9.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 04:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708000033; x=1708604833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lCrdLReYd6/KEbCAykqePGRLzDsfC2Y55HqsoUcSZdc=;
        b=F1z6EIQf/rs6crLkXFfQ91rV2AKm8IISGNADZiiLsEof5A5Qni42970rbUlq9l/o1I
         teqa8TvMxHtBctvn9Xi6AjpkW6ftIWS0aCGjO+3K186DlUbCmIVOoOA9MtdJe/ebc1CV
         d/JWek01robEsYESeYccIqPFy69w2fqMVRN9QzZpYJg1LG7Hfk/TWOC3mxkXdMbmlFNI
         sZarjArjYMziZMBR4QrvWxMlHALWNOrG5uFaBSTvlMTGyl3+zEFSq/n+sPwRyZwBwGvt
         RGX010SkivwqmR7Ayxw6rj63npRJIGmrpXRzuhhUqHrUxAFd7yFNYRxUVAIxAosDyu9v
         FPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000033; x=1708604833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCrdLReYd6/KEbCAykqePGRLzDsfC2Y55HqsoUcSZdc=;
        b=TvJy5ItD7RBUjkJOp7WcvMRyzy9keYxFfChQ/8kX2hq3bndtFXUQti/F9Bb88wZpWf
         2VVd4sFpsCxiY0F77wBJh171LyvzdzkdbAwtLV0hnIgF+XydtilCwvP7NSraBUq/0msG
         DlFFCHHtleywrrTYcW7TtGkUdnhfS5KFtWazXp2pifhcoiZM+a9oDaXxtOC++WDbPfAV
         +LnTA9nENSK2WgJPoUDlNNdDhjEtJc3agYifkun4GJMPUsLGLg1Q7JCA5yNVmAcTzRbX
         gfRWYmWuUumWa35Y0nrOz5wmk2GKsJ/4YH+w6j1fx2vfjT5uRZ26uPNW2QxgFv6zQpGK
         diVg==
X-Gm-Message-State: AOJu0YzDweFqcux/fqJWx78V6RAQ8/dG6OAZk6FumpQykGXWPRxOx3W4
	5ANlqprh5fMvRZY/+Qd/L89tztR+rCIdFjVAzFciblbdAYKejvbWnFdy5lqU67o=
X-Google-Smtp-Source: AGHT+IEYLxMX4MMxDWKLK4RxNC0C2jnRxr/rldxpHIe1KHt9VucwnIbNpjK+5MCmNAUILToNOfUF2A==
X-Received: by 2002:a05:600c:6004:b0:410:e97c:a405 with SMTP id az4-20020a05600c600400b00410e97ca405mr1465653wmb.15.1708000033001;
        Thu, 15 Feb 2024 04:27:13 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id q17-20020a05600c46d100b00411e3cc0e0asm1819114wmo.44.2024.02.15.04.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:27:12 -0800 (PST)
Date: Thu, 15 Feb 2024 13:27:09 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next] tools: ynl: fix attr_space variable to exist
 even if processing unknown attribute
Message-ID: <Zc4DHW05LcGy9Ryw@nanopsycho>
References: <20240213070443.442910-1-jiri@resnulli.us>
 <8bcd540b747ae30edc10c5208d7876b901e702b8.camel@redhat.com>
 <Zc3_-YMMiCd6fc-9@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc3_-YMMiCd6fc-9@nanopsycho>

Thu, Feb 15, 2024 at 01:13:45PM CET, jiri@resnulli.us wrote:
>Thu, Feb 15, 2024 at 11:59:08AM CET, pabeni@redhat.com wrote:
>>On Tue, 2024-02-13 at 08:04 +0100, Jiri Pirko wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>> 
>>> If message contains unknown attribute and user passes
>>> "--process-unknown" command line option, _decode() gets called with space
>>> arg set to None. In that case, attr_space variable is not initialized
>>> used which leads to following trace:
>>> 
>>> Traceback (most recent call last):
>>>   File "./tools/net/ynl/cli.py", line 77, in <module>
>>>     main()
>>>   File "./tools/net/ynl/cli.py", line 68, in main
>>>     reply = ynl.dump(args.dump, attrs)
>>>             ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "tools/net/ynl/lib/ynl.py", line 909, in dump
>>>     return self._op(method, vals, [], dump=True)
>>>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "tools/net/ynl/lib/ynl.py", line 894, in _op
>>>     rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
>>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "tools/net/ynl/lib/ynl.py", line 639, in _decode
>>>     self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
>>>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "tools/net/ynl/lib/ynl.py", line 569, in _decode_unknown
>>>     return self._decode(NlAttrs(attr.raw), None)
>>>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   File "tools/net/ynl/lib/ynl.py", line 630, in _decode
>>>     search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>>>                               ^^^^^^^^^^
>>> UnboundLocalError: cannot access local variable 'attr_space' where it is not associated with a value
>>> 
>>> Fix this by setting attr_space to None in case space is arg None.
>>> 
>>> Fixes: bf8b832374fb ("tools/net/ynl: Support sub-messages in nested attribute spaces")
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>  tools/net/ynl/lib/ynl.py | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
>>> index 03c7ca6aaae9..b16d24b7e288 100644
>>> --- a/tools/net/ynl/lib/ynl.py
>>> +++ b/tools/net/ynl/lib/ynl.py
>>> @@ -588,10 +588,12 @@ class YnlFamily(SpecFamily):
>>>          revalue = search_attrs.lookup(selector)turn decoded
>>>  
>>>      def _decode(self, attrs, space, outer_attrs = None):
>>> +        rsp = dict()
>>>          if space:
>>>              attr_space = self.attr_sets[space]
>>> -        rsp = dict()
>>> -        search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>>> +            search_attrs = SpaceAttrs(attr_space, rsp, outer_attrs)
>>> +        else:
>>> +            search_attrs = None
>>
>>It looks like that later-on the code could call self._decode_sub_msg()
>>-> self._resolve_selector() with search_attrs == None, and the latter
>>will unconditionally do:
>>
>>	value = search_attrs.lookup(selector)
>
>How exactly you can reach this? You won't get past:
>            try:
>                attr_spec = attr_space.attrs_by_val[attr.type]
>            except (KeyError, UnboundLocalError):
>                if not self.process_unknown:
>                    raise Exception(f"Space '{space}' has no attribute with value '{attr.type}'")
>                attr_name = f"UnknownAttr({attr.type})"
>                self._rsp_add(rsp, attr_name, None, self._decode_unknown(attr))
>                continue

Okay, I can just avoid setting search_attrs = None, as it it not used
anyway to avoid the confusion. Sending v2.

>
>
>
>>
>>I think we need to explicitly handle the None value there.
>>
>>Thanks,
>>
>>Paolo
>>

