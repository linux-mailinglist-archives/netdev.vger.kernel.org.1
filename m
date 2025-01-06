Return-Path: <netdev+bounces-155475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3E7A026CB
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 369DD1883500
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A291B1DE4DA;
	Mon,  6 Jan 2025 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6Pz1uwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43D91DC9AA
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170733; cv=none; b=VplVKYD/Ab3Pf0kf6WPhBd9JqtL8TIqVmO6aA952tvezA39EwPseFSq38VPZzpquBiifwDl/cxK2l8f+4FnY6qdwmvtp8D4xDeNMdFgGksAjKYgNCBp9uAxPEEIuJE8P4HIhmv5q8vJAYZ/aOwEfm4WRZt7R/tOdJyz0FsqJOqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170733; c=relaxed/simple;
	bh=BUnepBwMRnEewiioeDZ7t1A22AkqWV1jcVMPkfbwqB4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=M5+J4lTdc1wUICH/WV+LGaFTWmkqxQI/8jatMjqeRwcbMYDVCUm7oywtmKhqsUaCRszHfC4xLMQHvyQ8SVHT9nESj0TVp025OjgAgbEzaswbawGc6llsWpOVk9dHgLhCkHSsBkX/Ad2HAfuooEfszkCU50gDmHpMUmgjAz+xZk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6Pz1uwv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4361c705434so103901865e9.3
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 05:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736170730; x=1736775530; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJzeDskGS1zxkXNOaWYyNUG66NBPdze7gKnt2qioicg=;
        b=P6Pz1uwvKqu8cDys6WfD0GZDbzdhouB/NiMGqClrOlMVlqz/mTTsqxyXb9Agpb+Bqv
         VOrhyXtQQhKnWQyyR6YbG2BL5PfWMCVlFoPOZnJKnbuVRaQDsMW+NNgOb7170oPvnA4J
         6s73YLtqPVeRSU1dYTLgFsDXrVxji0U+GD5rJrbsDl6pgrIlb2jy8jTyNxIss0iHLAq0
         F3AoOIrSGsR9iZnghYgw0X724USEhnV4LKyp24hOOmkpShbHpefyDVN0G5SyUfCTfSYW
         D3mY4zDGm2dkPo3SmCjV8IMyKAGwl4bq/mTLklG5X1KctCZ5sNRleGrvcInuQUCvZDqU
         jVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170730; x=1736775530;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJzeDskGS1zxkXNOaWYyNUG66NBPdze7gKnt2qioicg=;
        b=UtKshoIJu4lMJhZYUW2Ty/puDyuISk/XDTBJqb1Zc3l3Lxsf8//EeF9XcH8kC9ZYpA
         31Z6EFAtJj4/ZwDO1HDO/NmkB2pEAXyxcZ09vgE0tPUkHj1dwl2fec4rMLj8PUAErpjP
         eAG1weddQpr/2aVjKEKXnCMyAxOMjd+WrTyKiy+wWsYwXxbier+IDmaQmx3LBWhYxwLU
         gdyKsKwdesiCwKQU1XRioGgbzlg6zdsHWV4Tg2jXDYW5V0R18qdC2XUSYmcXYr+ntkNO
         VHi0vjsWFRQzAT0ZbhVVx6qnXYxKoe3yT4uzUKECKsjfNsl1TjM3+PRJXPUtjMgqrjbG
         XaxA==
X-Forwarded-Encrypted: i=1; AJvYcCVvJdlFoNbZRSggOgl74wV2dniCnmqp4cUw5WfUet1tK17/h0OGLOPjSs8Wkyv95ugD67Gn8bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeuL0UCbiWZDMzdqOamij2c5rAMhStWuopRhul922QxvAzk0+4
	qidLC5aPE5azLcAuvFe6iR3hRkAvIKrwIHkqQncZ/+3EtK6ZO+Fs
X-Gm-Gg: ASbGncsmyXXKv5eiy0P3/48qUh8+JbcdFiaL2SsQzUcBRUCwZ4gwOZ9yaEo7s2sJav1
	oAW3GYgxoYshSx/CW6Twv4yIskV1UPoAxkxBTcxI5AJxyBRPXeO2rZgCGSCMY+xZZzC7Fa9bT5z
	6Q4SySoFcOSY/J6xY1eFOY4ol4qOeyx1kfY6Pcgb9vh0ew/gSEFeWZsASDandXoLGCOiUhwgDkq
	mbxuSOfpOpTQczvMFMSyvlq+D4DpaxUTaTkCeHcqcyY97W5zV4hbYRydeCXv1RrOuh/Yw==
X-Google-Smtp-Source: AGHT+IEgXWR+Gbfux0wSViYOwKloYkDRr0pKcRJi/M9OGXSaxlw5PInp8oeDF/MHWvDih8aVLnDCaA==
X-Received: by 2002:a05:600c:470a:b0:434:f767:68ea with SMTP id 5b1f17b1804b1-43668548337mr483029845e9.5.1736170729858;
        Mon, 06 Jan 2025 05:38:49 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:d10f:360f:84a5:c524])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2432e587sm44102556f8f.95.2025.01.06.05.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 05:38:49 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next 2/3] tools: ynl: print some information about
 attribute we can't parse
In-Reply-To: <20250105012523.1722231-3-kuba@kernel.org> (Jakub Kicinski's
	message of "Sat, 4 Jan 2025 17:25:22 -0800")
Date: Mon, 06 Jan 2025 13:30:42 +0000
Message-ID: <m25xmsnk71.fsf@gmail.com>
References: <20250105012523.1722231-1-kuba@kernel.org>
	<20250105012523.1722231-3-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> When parsing throws an exception one often has to figure out which
> attribute couldn't be parsed from first principles. For families
> with large message parsing trees like rtnetlink guessing the
> attribute can be hard.
>
> Print a bit of information as the exception travels out, e.g.:
>
>   # when dumping rt links
>   Error decoding 'flags' from 'linkinfo-ip6tnl-attrs'
>   Error decoding 'data' from 'linkinfo-attrs'
>   Error decoding 'linkinfo' from 'link-attrs'
>   Traceback (most recent call last):
>     File "/home/kicinski/linux/./tools/net/ynl/cli.py", line 119, in <module>
>       main()
>     File "/home/kicinski/linux/./tools/net/ynl/cli.py", line 100, in main
>       reply = ynl.dump(args.dump, attrs)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1064, in dump
>       return self._op(method, vals, dump=True)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1058, in _op
>       return self._ops(ops)[0]
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 1045, in _ops
>       rsp_msg = self._decode(decoded.raw_attrs, op.attr_set.name)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 738, in _decode
>       subdict = self._decode(NlAttrs(attr.raw), attr_spec['nested-attributes'], search_attrs)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 763, in _decode
>       decoded = self._decode_sub_msg(attr, attr_spec, search_attrs)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 714, in _decode_sub_msg
>       subdict = self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 749, in _decode
>       decoded = attr.as_scalar(attr_spec['type'], attr_spec.byte_order)
>     File "/home/kicinski/linux/tools/net/ynl/lib/ynl.py", line 147, in as_scalar
>       return format.unpack(self.raw)[0]
>   struct.error: unpack requires a buffer of 2 bytes
>
> The Traceback is what we would previously see, the "Error..."
> messages are new. We print a message per level (in the stack
> order). Printing single combined message gets tricky quickly
> given sub-messages etc.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

