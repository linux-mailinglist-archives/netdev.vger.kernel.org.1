Return-Path: <netdev+bounces-89868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6918ABFAA
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 16:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E714281785
	for <lists+netdev@lfdr.de>; Sun, 21 Apr 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3717BC2;
	Sun, 21 Apr 2024 14:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcZDHD6I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EF579FD
	for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713711401; cv=none; b=mAheLaPbZ5IxB5pQR659RUqjWjSn0S4s1BkthM8/lBH024hsqepplGf4eKU9xE0zX+rSzOHC5YWpCC7NGAhenl8hCN52ikb64u+dI/K3QH8zxVZOz2Qskt6gECZAyFSlB2wWToZNvUXfRG5rym0wXgCLjfdqbcDlqIz4dZfVIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713711401; c=relaxed/simple;
	bh=zDFuShOSngy1GeZdq1+9HosHrBuBFK/oZR9AOaCCiXY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ncgsKcHu/Dplqg/U2X90Gv+6P7BNOcMv6OQ2lk0xye/uCkP6+nsH4Jka4Gki0sRl5WzhTsHW3F2Pbxr+ye/kaMGQ9XluyIgDiD/rHkeNmxyz1i+0z4gx4eRJCGoFrrQ8Kow0UEj+UZ2PeWTQqHP8y5IV3GZoQzh8trKA9Tpl/io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcZDHD6I; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78f103d9f64so190149985a.0
        for <netdev@vger.kernel.org>; Sun, 21 Apr 2024 07:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713711399; x=1714316199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zCd3fsqVE4N6Sdu2ENxrr1ZLb/GJGC3hpFj8FRoQBg=;
        b=CcZDHD6IdPh3lPKHOU1/jZFKrzc64LZQwz7S/1Va5EkWvb/8OSLG3HD3cRS+iYXKnj
         6Lk86FDNTjHbYaP+0oCzBmVP2oTELPYn7s62buUIhxAzjcFGUQ0iAMrDhCxodGy/98tI
         sPyuW5TOKYXju23TlirUZCyhttFbxOpZidQyp2peWTro8VP4TRmWTSyHksL8/nCMkule
         5ZGECuJo8FjESoLiacSOFCO/OXGwxSH7Xhr0evRpNFSBay8YFWTMl84OnVYxIJuXpwzl
         m2zNdpCwWMM0dQQt08YgHZOJgHV403Q6NXOTcK0tBRmfjWXFlIY14z77stRbwbFXWchm
         sqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713711399; x=1714316199;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2zCd3fsqVE4N6Sdu2ENxrr1ZLb/GJGC3hpFj8FRoQBg=;
        b=ad1VqcddajolR4m9KcK5ira5ubHvBqJUGuLeQGl0IWlgOZ1BYDzTaWTJUbeENnrCIA
         GY8TmJu/sS+QdjWYhNqZxkNFXhitnqy3q0SqfGiYeyOI66dw7wSoEDavA3b+OhzD6hkE
         Q+ePTpyqBr6/vx9QVetkF1PBwXZqxsLE2CPN3TTok5cvgQQyqTiAoXf5JgstYwtHTGof
         PUkxLa6Tejr0dhweR3TQbHeYjeonbwTIlBY0LlrTDZ+mv5x6ca20UgZMBlM+OhoWKsLn
         tk7gtvLWPYnnU8WJYiNl3tLsQ9B9AVCId0NGsN/g/MC1sQllvnf844qqML2Hm0Fox8H7
         Ge1g==
X-Forwarded-Encrypted: i=1; AJvYcCWbGvb86vsdLxIQLn4VO81k3WuSM9eeoMvcwIoL33FqE1afT/woGau2W+tiUjH61fJpAFrlctriphrCHIAB2H1ZAxdGx7mw
X-Gm-Message-State: AOJu0Yzaa2a+xz9wZVLA1Bspuva7keAvt3cHzg5+XyUkvHYYIrTfpa6j
	sd2NS/Lo+HF+R30rjiwz/qt65LzctdAngudmDZHBhaiAJj/E/m3O
X-Google-Smtp-Source: AGHT+IFYbPNQ+ejzmxULh+ZwAfyg3d5eKVm+wYn7aSlT+j2gq0rRV1QKLsWHHn1Y+ef4IHgkDABV2Q==
X-Received: by 2002:a05:620a:1a25:b0:790:6f58:c737 with SMTP id bk37-20020a05620a1a2500b007906f58c737mr2807126qkb.29.1713711399146;
        Sun, 21 Apr 2024 07:56:39 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id w16-20020a05620a149000b0078f1a57ac0csm2402714qkj.83.2024.04.21.07.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 07:56:38 -0700 (PDT)
Date: Sun, 21 Apr 2024 10:56:38 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Wei <dw@davidwei.uk>, 
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Message-ID: <66252926969a4_1dff99294ad@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240419220857.2065615-3-dw@davidwei.uk>
References: <20240419220857.2065615-1-dw@davidwei.uk>
 <20240419220857.2065615-3-dw@davidwei.uk>
Subject: Re: [PATCH net-next v2 2/2] net: selftest: add test for netdev
 netlink queue-get API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

David Wei wrote:
> Add a selftest for netdev generic netlink. For now there is only a
> single test that exercises the `queue-get` API.
> 
> The test works with netdevsim by default or with a real device by
> setting NETIF.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> ---
>  tools/testing/selftests/drivers/net/Makefile  |  1 +
>  .../selftests/drivers/net/lib/py/env.py       |  6 +-
>  tools/testing/selftests/drivers/net/queues.py | 59 +++++++++++++++++++
>  tools/testing/selftests/net/lib/py/nsim.py    |  4 +-
>  4 files changed, 66 insertions(+), 4 deletions(-)
>  create mode 100755 tools/testing/selftests/drivers/net/queues.py
> 
> diff --git a/tools/testing/selftests/drivers/net/Makefile b/tools/testing/selftests/drivers/net/Makefile
> index 379cdb1960a7..118a73650dbc 100644
> --- a/tools/testing/selftests/drivers/net/Makefile
> +++ b/tools/testing/selftests/drivers/net/Makefile
> @@ -3,5 +3,6 @@
>  TEST_INCLUDES := $(wildcard lib/py/*.py)
>  
>  TEST_PROGS := stats.py
> +TEST_PROGS += queues.py
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index e1abe9491daf..0ac4e9e6cd84 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -7,7 +7,7 @@ from lib.py import ip
>  from lib.py import NetdevSimDev
>  
>  class NetDrvEnv:
> -    def __init__(self, src_path):
> +    def __init__(self, src_path, **kwargs):
>          self._ns = None
>  
>          self.env = os.environ.copy()
> @@ -16,11 +16,13 @@ class NetDrvEnv:
>          if 'NETIF' in self.env:
>              self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
>          else:
> -            self._ns = NetdevSimDev()
> +            self._ns = NetdevSimDev(**kwargs)
>              self.dev = self._ns.nsims[0].dev
>          self.ifindex = self.dev['ifindex']
>  
>      def __enter__(self):
> +        ip(f"link set dev {self.dev['ifname']} up")
> +
>          return self
>  
>      def __exit__(self, ex_type, ex_value, ex_tb):
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> new file mode 100755
> index 000000000000..c23cd5a932cb
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -0,0 +1,59 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_eq, KsftSkipEx
> +from lib.py import NetdevFamily
> +from lib.py import NetDrvEnv
> +from lib.py import cmd
> +import glob
> +
> +
> +def sys_get_queues(ifname) -> int:
> +    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
> +    return len(folders)
> +
> +
> +def nl_get_queues(cfg, nl):
> +    queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
> +    if queues:
> +        return len([q for q in queues if q['type'] == 'rx'])
> +    return None
> +
> +
> +def get_queues(cfg, nl) -> None:
> +    queues = nl_get_queues(cfg, nl)
> +    if not queues:
> +        raise KsftSkipEx("queue-get not supported by device")
> +
> +    expected = sys_get_queues(cfg.dev['ifname'])
> +    ksft_eq(queues, expected)
> +
> +
> +def addremove_queues(cfg, nl) -> None:
> +    queues = nl_get_queues(cfg, nl)
> +    if not queues:
> +        raise KsftSkipEx("queue-get not supported by device")
> +
> +    expected = sys_get_queues(cfg.dev['ifname'])
> +    ksft_eq(queues, expected)
> +

This is a copy of get_queues() above

> +    # reduce queue count by 1
> +    expected = expected - 1

Verify first that queue count > 1. Which it isn't in the test setup.

> +    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
> +    queues = nl_get_queues(cfg, nl)
> +    ksft_eq(queues, expected)
> +
> +    # increase queue count by 1
> +    expected = expected + 1
> +    cmd(f"ethtool -L {cfg.dev['ifname']} combined {expected}")
> +    queues = nl_get_queues(cfg, nl)
> +    ksft_eq(queues, expected)
> +
> +
> +def main() -> None:
> +    with NetDrvEnv(__file__, queue_count=3) as cfg:
> +        ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
> +
> +



