Return-Path: <netdev+bounces-90678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B98AF7C4
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C42E28C4EE
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 20:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA41422DF;
	Tue, 23 Apr 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="oDmNhOQu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36013D522
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713902663; cv=none; b=IxucxNuVpfnXLQ+8ahPe71IaxjmfjDuw++kScnt4lULUIMtTTb2+8Do1kZg+wfpNocKdAjZ6YmxHTfG09ybI8Q6a07lIpda/PZvFXFrOZXfToNGGYyQa/1mAcpnwhqfAy+SN3fTdl61AIj+miZowhnNCytXs+ixTe3v9yVZNjx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713902663; c=relaxed/simple;
	bh=+JolNU2YTee8jjksoeFgy8MgLuarS4MGW9ZvQFQLFrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhov02nI+F3l4r9mDWTSt8q2awBK9jZaFrGu++XcG/PpufXCnQ+P0lvzHL9tSCOIJd+Ap41qV+at5obODd8cdNhgeKJQMcS0bsem9rmNNVffyml2iGFZjedyF4VmuJ4WVb5VRZmsir/WsIW11t76x9fHHd9zKvNFeUUhJlf1WSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=oDmNhOQu; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e36b7e7dd2so54138605ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1713902662; x=1714507462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsTJrC/TYb7FK0Q2lIiKRgdIYme7w6OgmiHGtnaunaU=;
        b=oDmNhOQukzy/lDahq28UIQU3Png+Rm7FT11SrBQqNZHZGok0RE+4BrTsile7A07CjG
         8KQ5KozB/UvSp1BxBWD+uIHzXNjWPF/DDsTnSUpsB8nthr4SZK020eaUMPRrm/RnX/Yk
         TeqILjVO09x3oVw7eU7MfHDCGMslx9oSv7pJoi3lFECTEXOaYoOt7pfqD/qMR++kGMbv
         pNdqAwVitdoNxVrXB6x8cwWuCcD9+H77S/iuIzlc0s4pGIxbZQyHLcyZOTP64x2bV10L
         KeDDAbXan3q6dp+mNVL45SMcqdGznNitKdmGXimSBZFVdmuZRFEv4hacsp2z2GXMmtdP
         ylsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713902662; x=1714507462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsTJrC/TYb7FK0Q2lIiKRgdIYme7w6OgmiHGtnaunaU=;
        b=IYJ+2nZ0IVp/bZ4sexUPkXC8VYS24kYZI5Uy+iXMKR+r3G6sS/kyhEEo4BChXoY7zY
         mrkbc6I5OaPaKeTNGczFvx2Pk0e5qUXnxFuX8DNO6A6HmKc5G20SWvWY8cCFJyQA1ae2
         dZuSbS5XNZcUQKsTeFL2Mj/mAxnPt35Flp/+aUaaIZpgVpvc2ogbxOGGpC1pl/PyHKyJ
         zuPeVtuvyvnsShKCVRxQH93oJFgKm5uY0hBniTjEJKHnJ37meGgRRUGi+YuaT8r9OLP2
         K0hgImKPlAmeEPhhI0cGORFxdJTDdYVAY8V0bBGvj24WnAziYKC8xHsZBJ++1aP47dr7
         BsSA==
X-Forwarded-Encrypted: i=1; AJvYcCVi6EcWi6/3zSrNBo5gG0n6puvZECkStK4UQUIkL73IFuWRTfoHnp3Ibh2p1bUsu1jigXtYREi1OifjTBZ7BcMHkRLfXN5N
X-Gm-Message-State: AOJu0YzdwC71YNJb1M0oZhGEF8sHqMDD8QqUE4r/MzNoZ5s/0s7spYtQ
	1BeJe+LXAoHqyWn9ZmW2E2BJz2ZPVB87Rtu6xtf62ha+k4E5xLTx5YQtNyGZP9w=
X-Google-Smtp-Source: AGHT+IGzPeEKROaW1uTtKzgd2zZxcbStSQXrb0rXRLSHxSmFyHmaGtrrOBx+IjPs7kgbIr0zjopCYQ==
X-Received: by 2002:a17:902:e809:b0:1e2:194a:3d22 with SMTP id u9-20020a170902e80900b001e2194a3d22mr626266plg.32.1713902661709;
        Tue, 23 Apr 2024 13:04:21 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::6:5c90])
        by smtp.gmail.com with ESMTPSA id y2-20020a1709027c8200b001e22e8a859asm10443526pll.108.2024.04.23.13.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 13:04:21 -0700 (PDT)
Message-ID: <5d1acb78-afd9-4a41-8306-347cb5bbeae7@davidwei.uk>
Date: Tue, 23 Apr 2024 13:04:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] net: selftest: add test for netdev
 netlink queue-get API
Content-Language: en-GB
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>
References: <20240419220857.2065615-1-dw@davidwei.uk>
 <20240419220857.2065615-3-dw@davidwei.uk>
 <66252926969a4_1dff99294ad@willemb.c.googlers.com.notmuch>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <66252926969a4_1dff99294ad@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-21 7:56 am, Willem de Bruijn wrote:
> David Wei wrote:
>> Add a selftest for netdev generic netlink. For now there is only a
>> single test that exercises the `queue-get` API.
>>
>> The test works with netdevsim by default or with a real device by
>> setting NETIF.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>>  tools/testing/selftests/drivers/net/Makefile  |  1 +
>>  .../selftests/drivers/net/lib/py/env.py       |  6 +-
>>  tools/testing/selftests/drivers/net/queues.py | 59 +++++++++++++++++++
>>  tools/testing/selftests/net/lib/py/nsim.py    |  4 +-
>>  4 files changed, 66 insertions(+), 4 deletions(-)
>>  create mode 100755 tools/testing/selftests/drivers/net/queues.py
>>
>> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
>> index 379cdb1960a7..118a73650dbc 100644
>> --- a/tools/testing/selftests/drivers/net/Makefile
>> +++ b/tools/testing/selftests/drivers/net/Makefile
>> @@ -3,5 +3,6 @@
>>  TEST_INCLUDES := $(wildcard lib/py/*.py)
>>  
>>  TEST_PROGS := stats.py
>> +TEST_PROGS += queues.py
>>  
>>  include ../../lib.mk
>> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
>> index e1abe9491daf..0ac4e9e6cd84 100644
>> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
>> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
>> @@ -7,7 +7,7 @@ from lib.py import ip
>>  from lib.py import NetdevSimDev
>>  
>>  class NetDrvEnv:
>> -    def __init__(self, src_path):
>> +    def __init__(self, src_path, **kwargs):
>>          self._ns = None
>>  
>>          self.env = os.environ.copy()
>> @@ -16,11 +16,13 @@ class NetDrvEnv:
>>          if 'NETIF' in self.env:
>>              self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
>>          else:
>> -            self._ns = NetdevSimDev()
>> +            self._ns = NetdevSimDev(**kwargs)
>>              self.dev = self._ns.nsims[0].dev
>>          self.ifindex = self.dev['ifindex']
>>  
>>      def __enter__(self):
>> +        ip(f"link set dev {self.dev['ifname']} up")
>> +
>>          return self
>>  
>>      def __exit__(self, ex_type, ex_value, ex_tb):
>> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
>> new file mode 100755
>> index 000000000000..c23cd5a932cb
>> --- /dev/null
>> +++ b/tools/testing/selftests/drivers/net/queues.py
>> @@ -0,0 +1,59 @@
>> +#!/usr/bin/env python3
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +from lib.py import ksft_run, ksft_eq, KsftSkipEx
>> +from lib.py import NetdevFamily
>> +from lib.py import NetDrvEnv
>> +from lib.py import cmd
>> +import glob
>> +
>> +
>> +def sys_get_queues(ifname) -> int:
>> +    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
>> +    return len(folders)
>> +
>> +
>> +def nl_get_queues(cfg, nl):
>> +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
>> +    if queues:
>> +        return len([q for q in queues if q['type'] == 'rx'])
>> +    return None
>> +
>> +
>> +def get_queues(cfg, nl) -> None:
>> +    queues = nl_get_queues(cfg, nl)
>> +    if not queues:
>> +        raise KsftSkipEx("queue-get not supported by device")
>> +
>> +    expected = sys_get_queues(cfg.dev['ifname'])
>> +    ksft_eq(queues, expected)
>> +
>> +
>> +def addremove_queues(cfg, nl) -> None:
>> +    queues = nl_get_queues(cfg, nl)
>> +    if not queues:
>> +        raise KsftSkipEx("queue-get not supported by device")
>> +
>> +    expected = sys_get_queues(cfg.dev['ifname'])
>> +    ksft_eq(queues, expected)
>> +
> 
> This is a copy of get_queues() above

I'll remove this part of the test case.

> 
>> +    # reduce queue count by 1
>> +    expected = expected - 1
> 
> Verify first that queue count > 1. Which it isn't in the test setup.

Thanks, I'll make sure changing the queues for a real device doesn't go
out of bounds.

> 
>> +    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
>> +    queues = nl_get_queues(cfg, nl)
>> +    ksft_eq(queues, expected)
>> +
>> +    # increase queue count by 1
>> +    expected = expected + 1
>> +    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
>> +    queues = nl_get_queues(cfg, nl)
>> +    ksft_eq(queues, expected)
>> +
>> +
>> +def main() -> None:
>> +    with NetDrvEnv(__file__, queue_count=3) as cfg:
>> +        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
>> +
>> +
> 
> 

