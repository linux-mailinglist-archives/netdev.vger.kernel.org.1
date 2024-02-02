Return-Path: <netdev+bounces-68555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B90847297
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 16:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790011C275EB
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 15:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDA1145B38;
	Fri,  2 Feb 2024 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBA2Joeg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DC1145B30
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886350; cv=none; b=dXfEUE1Y1Arw0yvh89yeYTUqFoasHtX+jSf4ABWHhrydb1HAWekmpTnw3cXlyihBkkhe+VPkKhgHm5kA+oF6KoFM509kdJU0m0ZPH7x3NdfJXkx/tJW28zO4HWN0nO0IBlelOSiMEOU4luoizrIDPKK93W/SlxYTDsLdpIoPCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886350; c=relaxed/simple;
	bh=HoxqTQPoii/p0mEYXSNoDuZvdO0BckVfeT1fqhmr6Rc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=fx/vcRIkxVkDRh1hTtvFLoLvZICI6wPsALkkzGzhgoob6QHq954U6zDkNIn75RZ4C/OiIe8w+wIWijrJaFVFzRTqCINJJzgkMSY++39lnSeUwHnHY5NsaoUCr42pphXYE6j4gYecYWXIo9eop3d9DpQG9060Ada8EijAdgm0oes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KBA2Joeg; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fc6343bd2so6703535e9.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 07:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886347; x=1707491147; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kBzqN7gaz9UUwfWRhoHsM9AfS5F2Goy8HVYGquO/nao=;
        b=KBA2JoegqK30iQbhH/jxsdusgrLpXqMlbLoHPe/DcPfa6nfqhf85rwK+F7hI0bd3u9
         iCBA2lht7laSUZ6kwYwKQx1UzT4JBDZju4GD2g+DJpHmBd2jr2bRE0awHOCFVa4/ZW/s
         VcMyBzvt3VmcEkbOTSjcW9hLCipCKQVz+wPM71A/BbaOQFLCZAveTjye/0s2+jhm00Ik
         nYUVT/czQm1HCDeY9L3hkpnzoP3x/GGezBaLiRYZ8OlDYGaJJCne3o2G4uUcrEaiQFjh
         5kCpGPVpTlaaO6vSpWazt0JxHT6KeiuoSwDUeMlUT8ROj3EN3HwGRAXNjYWH7TsPkx/I
         BbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886347; x=1707491147;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBzqN7gaz9UUwfWRhoHsM9AfS5F2Goy8HVYGquO/nao=;
        b=nvVMsETET+W4Hg+HXARLCghl81+Pos3PMrBVGnKSeT71FGM30sEPbJgQNRWvWDr9dc
         HrNtyQpcB6JACL9mSIb7GXKknCaQwxnhG33PlyD4YX48r2LXDOxLufLrF08wsIDNWvV8
         9c9eWQgBNTHvXjrtV70fYP+kwDZEbwtIq9+Bodta4wyZtWgyWlPjtwmLMM0yeK9c40OC
         3hNrGrYEwl9fWNy72JPW3IU9qaEu9FVk2Nf6/s7k7zEPu5bNg56ac8wfPYOatiCfMLv/
         dE9H6zpkr7iCXTkUn6262SgZGvptCPeLmxxMSFbOCAH/V3I8poZmmLZJflym+eKV8SpN
         QASQ==
X-Gm-Message-State: AOJu0YxU+JOxGIDkft6Z5ss6X/kipmuecpxt7EwI2PhHxg9Iw6CGAk3g
	UAoiSl2bHHMlB8s9TIMLOs5j1cJnoEHl3fVtBTAKOxtOQ7/USP1s4JRFHnI2Jy8=
X-Google-Smtp-Source: AGHT+IF+yG0hMO9xRpDEaq9e/VuFA6xCSUIhcfceUPZ9OcOiRzKcmDjk0MX9/ECQejSJf2T4pKOt5g==
X-Received: by 2002:a05:600c:4e44:b0:40e:491d:ac80 with SMTP id e4-20020a05600c4e4400b0040e491dac80mr6343175wmq.15.1706886346813;
        Fri, 02 Feb 2024 07:05:46 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXLs1K8QNE74b8BhmahtFW1j/eY2lfLwVI+F/r0b3v6Tp8GHCsH0LmPb5gBS6jcWg6nN3ioRpqS9xkhFMPi+L2AnIuJ2zwRI/2dwe+tVzgc107rGrJZ+cE0iue4RDpgI1RA+i3GDkms3TEu/lNYSsy3IzVlrp404bKM8k8M4ZXu5n6h2WpeSw2NlKcSdSri9FAynvPvypZVn4ux4RCNRcq+DytGJPjQRA/Gamo9ua8zOsy9Uj5mDfC/hxbAFo70vtZiLMbCni+gXJlfURw7vF7a574/vLt5p6g1AzqZKnzLhLmq4K+DIVs=
Received: from imac ([2a02:8010:60a0:0:699e:106b:b80c:c3f0])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b0040efcec0a6asm136709wmq.42.2024.02.02.07.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:05:45 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  sdf@google.com,  chuck.lever@oracle.com,
  lorenzo@kernel.org,  jacob.e.keller@intel.com,  jiri@resnulli.us,
  netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 0/3] Add support for encoding multi-attr to ynl
In-Reply-To: <cover.1706882196.git.alessandromarcolini99@gmail.com>
	(Alessandro Marcolini's message of "Fri, 2 Feb 2024 15:00:02 +0100")
Date: Fri, 02 Feb 2024 15:05:34 +0000
Message-ID: <m2ttmqucsh.fsf@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alessandro Marcolini <alessandromarcolini99@gmail.com> writes:

> This patchset add the support for encoding multi-attr attributes, making
> it possible to use ynl with qdisc which have this kind of attributes
> (e.g: taprio, ets).

I liked the fact that your original cover letter included an example
ynl.py command. With this patchset plus the merged struct encoding
patch, you can add a taprio qdisc like this:

# ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/tc.yaml \
  --do newqdisc --create --json '{
  "family":1, "ifindex":111, "handle":65536, "parent":4294967295, "info":0,
   "kind":"taprio",
   "stab":{
       "base": {
         "cell-log": 0,
         "size-log": 0,
         "cell-align": 0,
         "overhead": 31,
         "linklayer": 0,
         "mpu": 0,
         "mtu": 0,
         "tsize": 0
       }
   },
   "options":{
       "priomap": {
           "num-tc": 3,
           "prio-tc-map": "01010101010101010101010101010101",
           "hw": 0,
           "count": "0100010002000000000000000000000000000000000000000000000000000000",
           "offset": "0100020003000000000000000000000000000000000000000000000000000000"
       },
       "sched-clockid":11,
       "sched-entry-list": {"entry": [
           {"index":0, "cmd":0, "gate-mask":1, "interval":300000},
           {"index":1, "cmd":0, "gate-mask":2, "interval":300000},
           {"index":2, "cmd":0, "gate-mask":4, "interval":400000} ]
       },
       "sched-base-time":1528743495910289987, "flags": 1
   }
  }'

> Patch 1 corrects two docstrings in nlspec.py
> Patch 2 adds the multi-attr attribute to taprio entry
> Patch 3 adds the support for encoding multi-attr
>
> v1 --> v2:
> - Use SearchAttrs instead of ChainMap
>
> v2 --> v3:
> - Handle multi-attr at every level, not only in nested attributes
>
> Alessandro Marcolini (3):
>   tools: ynl: correct typo and docstring
>   doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
>   tools: ynl: add support for encoding multi-attr
>
>  Documentation/netlink/specs/tc.yaml | 1 +
>  tools/net/ynl/lib/nlspec.py         | 7 +++----
>  tools/net/ynl/lib/ynl.py            | 5 +++++
>  3 files changed, 9 insertions(+), 4 deletions(-)

