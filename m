Return-Path: <netdev+bounces-131722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50A298F58A
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 19:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89A21C22414
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 17:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D876A1AB51A;
	Thu,  3 Oct 2024 17:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grq4eTeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5821AAE38
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977678; cv=none; b=ul4s7xweZgXnAaTziYjDbXD+MSiTh1C08ZYi/dDDBH5n87tFoRwWbWUaUI8ryS9P1jZC2LIXB5KsUqfICvZR5nPDV7IST+S32XAqD+KOduYc/RQmeTFUfUA9SqCAgJsLc/jGYVWDmiWh1Vk9P/sD/tZI4FfblcG7lPNU6GAORAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977678; c=relaxed/simple;
	bh=+3pikV7kaVDyoY+HBVSSh7p3gOEaKlDDt2nucdRUg+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mdv+ZJRSsMQ2IQl9pqfS8hOP1BNKDDn+h6ZMv0ccaxPsrjbIpDyAM2D3JxwlxvbU12UI073gZ9afYS5HqJ0GAuDIzymeWaw4OreP78FnVAAXt3o1358+kDPGy367a4z08ZzKiBBD2WgQaHzEwsO6EEd0uCQ2a+4594oL22tV1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grq4eTeT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20ba8d92af9so9521145ad.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 10:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727977676; x=1728582476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TBeMbE1kW6T/3/3DXuZsfzLFqECbYlvzq9rx8UPnf3g=;
        b=Grq4eTeTKgEXSExdEuY1dAuxllgYDZRci/DB5RU82gaGOuSOsx0jNQ97FvCiZqDFiI
         p1ZlXk9+6SFsvZuK7/VXA5iULwt+Y+RUB+DevWYrwG71MGLGuSYqpPhcLWulOx0lgLo6
         8zix4ag8/fXSkIXFayZgUKW4pcKiSBhHjKiMuWQ5MthAcTAmGxE/ITyNxdmk1dayDz6s
         X8XLcFDe0gvm6SUBfdjJu23ccpOFXLmiv1nuKc6iRrmHHBECM8Y11loN37lJcLPwFAEr
         OHsdE0H2j7mbmUehSu0jB6mlUHpbYV6P7MChVHu0nA2VZgatsv3bmx8cquKTCXhpkp9d
         gq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727977676; x=1728582476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBeMbE1kW6T/3/3DXuZsfzLFqECbYlvzq9rx8UPnf3g=;
        b=jJGkO63pTxEm1p3BKwJZY2sGWONvMf0fplyDZuiKC5emqz6UlPYBXREf5PTRykzVaA
         JNHiwMmaobcWeQrZR1/mdQxrE37KIE9IzQEd9RPk6Fm3vYnppao84IGdPHHPApkWjKoX
         mw0SCXNiPsl65xoJ4wv0GNSIEXx894Kdxf7qK9s6NcsTZu2i2ijfplYDe78wV8YtINr2
         3MVRHzouQ8brqDMBC4kBsQOG+SEZLCsZnixavvT6MxJwjbm/2LwlgfIpwnNYK9PmiNEu
         eYbIFYTiH7JPTYyvo3hVPxXz34vzB8OxFo1ji6abCewqc54wnz9HZZyz530iRrgP5O+8
         OcIg==
X-Forwarded-Encrypted: i=1; AJvYcCVFzzAhNJ8cIC6c/emkiEaak02alGVvoi8qwKNdIHG3IcEWXV0oDgDY52ubfL7W4RRzgdY4tFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOF9h/s3XpqZ/LAjmpepIPHAp4F+26tckOWe2PqsqfIdPyc95z
	BmeSS5K4IFRKDSiZfo7Z0loFfHe/THQ0ZHytTUktmYPHBUqPRZw=
X-Google-Smtp-Source: AGHT+IH9M+COzpEH9JtqER8HpdlKYAIMU1q1JcrOmpIJszrqXnxHg99yYmO0kQFZEKtQXvqRVQmrEg==
X-Received: by 2002:a17:902:e885:b0:205:2a59:a28c with SMTP id d9443c01a7336-20bfde555b8mr193305ad.1.1727977675848;
        Thu, 03 Oct 2024 10:47:55 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beead1e91sm11586535ad.28.2024.10.03.10.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 10:47:55 -0700 (PDT)
Date: Thu, 3 Oct 2024 10:47:54 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 12/12] selftests: ncdevmem: Add automated test
Message-ID: <Zv7Yyh8OHqZ8lAPw@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-13-sdf@fomichev.me>
 <CAHS8izMNHUkufZS_nMD7uTmzSfAqWYqfAiZiuH1OOVDw7WGhQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMNHUkufZS_nMD7uTmzSfAqWYqfAiZiuH1OOVDw7WGhQA@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > Only RX side for now and small message to test the setup.
> > In the future, we can extend it to TX side and to testing
> > both sides with a couple of megs of data.
> >
> 
> This is really awesome. Thank you.
> 
> >   make \
> >         -C tools/testing/selftests \
> >         TARGETS="drivers/hw/net" \
> >         install INSTALL_PATH=~/tmp/ksft
> >
> >   scp ~/tmp/ksft ${HOST}:
> >   scp ~/tmp/ksft ${PEER}:
> >
> >   cfg+="NETIF=${DEV}\n"
> >   cfg+="LOCAL_V6=${HOST_IP}\n"
> >   cfg+="REMOTE_V6=${PEER_IP}\n"
> 
> Not a review comment but noob question: does NIPA not support ipv4? Or
> is ipv6 preferred here?

Yes, absolutely, you can pass it LOCAL/REMOTE_V4 but you'll have to make
some changes to the selftest itself to use the v4 addresses. Things like
'-s {cfg.v6}' will have to be changed to '-s ::ffff:{cfg.v4}'.

I wonder whether it might be a good idea to have some new config method that
falls back to v4-mapped-v6 (::ffff:{cfg.v4}) to support both v4 and v6
transparently for the selftests that don't care about particular transport?

I'll leave it for you to explore...

> >   cfg+="REMOTE_TYPE=ssh\n"
> >   cfg+="REMOTE_ARGS=root@${PEER}\n"
> >
> >   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
> >   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  .../testing/selftests/drivers/net/hw/Makefile |  1 +
> >  .../selftests/drivers/net/hw/devmem.py        | 46 +++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >  create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
> >
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index 7bce46817953..a582b1bb3ae1 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -3,6 +3,7 @@
> >  TEST_PROGS = \
> >         csum.py \
> >         devlink_port_split.py \
> > +       devmem.py \
> >         ethtool.sh \
> >         ethtool_extended_state.sh \
> >         ethtool_mm.sh \
> > diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> > new file mode 100755
> > index 000000000000..29085591616b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> > @@ -0,0 +1,46 @@
> > +#!/usr/bin/env python3
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +import errno
> > +from lib.py import ksft_run, ksft_exit
> > +from lib.py import ksft_eq, KsftSkipEx
> > +from lib.py import NetDrvEpEnv
> > +from lib.py import bkg, cmd, rand_port, wait_port_listen
> > +from lib.py import ksft_disruptive
> > +
> > +
> > +def require_devmem(cfg):
> > +    if not hasattr(cfg, "_devmem_probed"):
> > +        port = rand_port()
> > +        probe_command = f"./ncdevmem -f {cfg.ifname}"
> > +        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
> > +        cfg._devmem_probed = True
> > +
> > +    if not cfg._devmem_supported:
> > +        raise KsftSkipEx("Test requires devmem support")
> > +
> > +
> > +@ksft_disruptive
> > +def check_rx(cfg) -> None:
> > +    cfg.require_v6()
> > +    require_devmem(cfg)
> > +
> > +    port = rand_port()
> > +    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> 
> So AFAICT adding validation to this test is simple. What you would do
> is change the above line to:
> 
> listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port} -v 7"
> 
> then, below...
> 
> > +
> > +    with bkg(listen_cmd) as nc:
> > +        wait_port_listen(port)
> > +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)
> > +
> 
> ...change this to the equivalent of 'yes $(echo -e
> \\x01\\x02\\x03\\x04\\x05\\x06) | tr \\n \\0 | head -c 1G"
> 
> > +    ksft_eq(nc.stdout.strip(), "hello\nworld")
> > +
> 
> ...then remove this ksft_eq().
> 
> But this is just a suggestion, I think you were leaving this to future
> work for me, which is fine.
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>

Let me try. Worst case I leave it as is and you'll follow up with
the conversion once you get the TX side going..

