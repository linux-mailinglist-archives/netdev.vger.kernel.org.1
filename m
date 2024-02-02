Return-Path: <netdev+bounces-68568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D7684732C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C752289E44
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA91145B3B;
	Fri,  2 Feb 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqXtJ1Fs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF391420D2
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706887837; cv=none; b=oz4+LFxjk+1TD8RBNZGzlyfLsJhGxXNukbi3oG+NZ5MVtWe6b2c5CDMQabIvazIVKjHidRIl1dp+TYTd9zQC++3wvrrDrpkB+welz2Cd/tszN138Qeni6PKx8c6acov/CDHN/tIiyyMHfIuVndJuzzLp0OVnAv4l4N+umLdgwLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706887837; c=relaxed/simple;
	bh=oVuo2fTXKD7a6czo+w2lGSSLKF/4I1H2pyKZff/0Etw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zce9eZHAPEs9Ga1bf6uJAQdNGg+QvCrAt5+44Z8WGdn5fvXNKs/H9E6ka3LPe6DaiFU6XNu2Um9Xkpp+ONRgWHY3mB9HDfOy1kYItIxRcdIbOoZ7HKCytupJULKZHRpVgf9V242+6fQHSYlVMrrzKxNHLkFSP3nShTVrhM+FuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqXtJ1Fs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e80046246so5410305e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706887834; x=1707492634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbFt/IgYm8ONpXjlmVcqsypReafVb9KU4EBL3ZUUYns=;
        b=gqXtJ1FskeDueYrBNNYJeqhLbzs8WzE1uaMJJ6KHzeXxztuA6/Po86KhVz28U1Kx0a
         UYUme+CKC3qwnekmhxh4B3zZU/Rj3Ex+WZVP+b2fFwgCPaMkM9xl81EjF2hNMVgzNS3Z
         1mXZ69nB/LhvCP3TZdLJCg15qHzBo8j115xo9sL/s5gC8E7V8QRRYxMZ5nZEEF2g1v2C
         SGv05rtadBqJj/ssnLkji0MfD0Wb9qojmguR+irCUQ07z+sRwAfvHosvKNiA6y/jW5dK
         AaRhwFKUvXMQDn50Oj6HWJhetrYZ0QHD8S3yT/y+DxJEZaq5/e6zepBIdBiw8gPTt1MM
         felQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706887834; x=1707492634;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbFt/IgYm8ONpXjlmVcqsypReafVb9KU4EBL3ZUUYns=;
        b=lfGafTJcQR9mo03zAR5xUPKW2COZqfuJ5ZC0MzLDwEanOZw/rFPNLIHEwsj05kCsRW
         AijJ4HahP+DUxEoOQMOQ+BvUKby+HE5gZRgx9kXlzUEjdNbwLx5aEORWa7jKWXvRo42n
         6/nlLVxZey2/2WW2JMQQ8VtW3/0OiJ+MI+nMAE9l2u5WCmegBJ9lajO/ZCeGuoxSmXhK
         sFDC8eQjR6SziEFr5nZLLK32uy02Co5nH4d6W0V4naSoziODUN+NUhwE3LuUN7VxKxRy
         kfkTnP7HMV/SFXv4T+ouHW6h/1voLea5ZBvWzwJmAb6uCFFHPXV3493YKJ7jjLdr6gFw
         KFLw==
X-Gm-Message-State: AOJu0YxvaYfhOkOvqfrIwanlqfNmTexu4tq3X0EEtdp53cjWB75EM3ky
	tJnSXRZQpviXoqMrehd2YGr8X0qSKNQASfjnSRSAePgvD/9s6c2U
X-Google-Smtp-Source: AGHT+IHOC0YUepM+Fdwi3TrnnzHIraQMHm+C1N54uyUnPh7OvkX1iAOBrRlffpGWepMSo60gPdPdYQ==
X-Received: by 2002:a05:600c:3503:b0:40f:c778:8248 with SMTP id h3-20020a05600c350300b0040fc7788248mr1820454wmq.0.1706887833429;
        Fri, 02 Feb 2024 07:30:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUGG1WL1OrlpH242LIG/iXIGWHKqdyGc6p9f5XO9qFZ4djP/9uMbR5nmLNQ2x6ov5L4MERxMdtH5I+Rc2IiO8DviQ05cXFr8oF5XC+QlYRWBirdj4C85WXoBp4eWSBbO83ZTI9ORQHUc+SFixV3XC7ppcN8e0QKXgeNmW7IhegL4hNlcfvC50imqTcZ8AFEe1KliX8PiS0/AkN/Z4qfWma0JEYJ6a9WP9qxcbpQa5AsLivojhJ1OjhNUzEPvRBRIVjxhPsmS/Ne7lOrcF7GDgSBp/xENXl8FJF5/VJi+xn2y4ZVsE+mPEU=
Received: from ?IPV6:2001:b07:646f:4a4d:e17a:bd08:d035:d8c2? ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id i4-20020a5d5224000000b0033afcc069c3sm2153235wra.84.2024.02.02.07.30.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 07:30:32 -0800 (PST)
Message-ID: <cdf0bcdc-3b11-44ed-921d-97e589237071@gmail.com>
Date: Fri, 2 Feb 2024 16:31:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 0/3] Add support for encoding multi-attr to
 ynl
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, sdf@google.com, chuck.lever@oracle.com,
 lorenzo@kernel.org, jacob.e.keller@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
 <m2ttmqucsh.fsf@gmail.com>
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
In-Reply-To: <m2ttmqucsh.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/2/24 16:05, Donald Hunter wrote:
> I liked the fact that your original cover letter included an example
> ynl.py command. With this patchset plus the merged struct encoding
> patch, you can add a taprio qdisc like this:
>
> # ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml \
>   --do newqdisc --create --json '{
>   "family":1, "ifindex":111, "handle":65536, "parent":4294967295, "info":0,
>    "kind":"taprio",
>    "stab":{
>        "base": {
>          "cell-log": 0,
>          "size-log": 0,
>          "cell-align": 0,
>          "overhead": 31,
>          "linklayer": 0,
>          "mpu": 0,
>          "mtu": 0,
>          "tsize": 0
>        }
>    },
>    "options":{
>        "priomap": {
>            "num-tc": 3,
>            "prio-tc-map": "01010101010101010101010101010101",
>            "hw": 0,
>            "count": "0100010002000000000000000000000000000000000000000000000000000000",
>            "offset": "0100020003000000000000000000000000000000000000000000000000000000"
>        },
>        "sched-clockid":11,
>        "sched-entry-list": {"entry": [
>            {"index":0, "cmd":0, "gate-mask":1, "interval":300000},
>            {"index":1, "cmd":0, "gate-mask":2, "interval":300000},
>            {"index":2, "cmd":0, "gate-mask":4, "interval":400000} ]
>        },
>        "sched-base-time":1528743495910289987, "flags": 1
>    }
>   }'
>
Yes, exactly! I didn't repost the updated command to avoid being too verbose.
FWIW, I've also tested it with an ets qdisc. The command is:

# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml --do newqdisc --create \
--json '{
"family":1, "ifindex":4, "handle":65536, "parent":4294967295, "kind":"ets",
"options":{
    "nbands":6,
    "nstrict":3,
    "quanta":{
        "quanta-band": [3500, 3000, 2500]
    },
    "priomap":{
        "priomap-band":[0, 1, 1, 1, 2, 3, 4, 5]
    }
}
}'


