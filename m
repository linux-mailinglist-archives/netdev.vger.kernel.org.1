Return-Path: <netdev+bounces-141728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8D9BC1E6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 01:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9D561F21FD8
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 00:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD71CA4E;
	Tue,  5 Nov 2024 00:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Xq+xhs5S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8E61FC3
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 00:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730765717; cv=none; b=C7IgZa3FdBIwy4gBqjlg/s7BEVOQYobFokyU2UE+7g/2GnIY1Nnh9H56d31Erwn40IPH3MOVVoE5bCVQ7/8jvSR1T4aPS0x58E8Y/My8m3i6j9eTBgFQMw0P201nr86B+9r8b2vI5Sgs1Y2YSFWjF2cQymj0i5CrpHxPJVHLwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730765717; c=relaxed/simple;
	bh=yvIGJzhFb84eC4ca0rZJpsDxkqFSOTyuaKPg1OZWAM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us4TxAtHiDpeOQkvpiPNjJWhCRcq/ePNb8UNKG/zcitXsFVqVW3c9xI2eZ6oF9DDNEAx76pWAMJ6vTJ0oJ5BolmeE3eqg9gECoxcOfUioxNPkLL6CqZZk9MT0wyQ2pAN/B/51bAyxc9VchLvnK7CDIw3cPOOAU68hljsqxiKboA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Xq+xhs5S; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21145812538so15391925ad.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 16:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730765714; x=1731370514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ynHKKKY2R9KZFSpLdWdmwFds5n9xS87KoEUfc7LlVbQ=;
        b=Xq+xhs5SItiZ9oZVE6vWTAVI0KRaGy3CugbQhmkdGgvgGLhbJjzAtOtJ+0FehLLVqt
         AABt3fhzOMDSyxncMVfx05UMCIx/x9GcJvreRwqNdy9jpGwa3UJG9LAvr8X0rNgg3hGJ
         5gWX8/5hS9uOKbOPMa0MVd+Ou2KIwrx/HA6Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730765714; x=1731370514;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ynHKKKY2R9KZFSpLdWdmwFds5n9xS87KoEUfc7LlVbQ=;
        b=p6d34jlCwE//X7wbWD/g3Td2q+CRroPbWmQnth5yTBjseO/Soe0zi+uvVuEbROli2W
         Os5FI27LP0MFE1NVeR5oxmKM/+zWnx1gAdBEyig1GAwy3EjLUXDCxcuYupaY/S46Opm2
         6nY59P7jlir43T1qNwfA6XyHjtJD3oYe5tv8iKCwZWj2p1VOkQoc08wlKEGYWDGVskrX
         xFbW/r8dazAfkXddZ+3EnYHxV4Z+CFA1f/bMlsxkLJkgbZSP4aDECZ+7eL/Xl4KPl+GV
         XzbeOfpjKlveF6ehz3uC6+40nGdClU3YlrQM6pzGX/H5QT9xhJVxZA+nBDjTF9XDVw1X
         baMw==
X-Gm-Message-State: AOJu0Yx8RrOT3ZvQHkm8WozZXTGS9H7QeAja88mLneSYJN1PGG8EAQFl
	6lX6lhPcejiHPqRzsUwO3zXygLQQwZMVr3zA0kjp5JvtQGIRdjQ/5MP5Z2Z3B5s=
X-Google-Smtp-Source: AGHT+IHEkL8m8bR72apa+vXxyf5vfLzUePunRZZG0kg4JqaPAYNUdMM0D6/JJ1YWfRQjD5W/iT0dUw==
X-Received: by 2002:a17:902:db0f:b0:20c:9c09:8280 with SMTP id d9443c01a7336-210c6cc207amr432628295ad.54.1730765714033;
        Mon, 04 Nov 2024 16:15:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2110570835fsm67043375ad.77.2024.11.04.16.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 16:15:13 -0800 (PST)
Date: Mon, 4 Nov 2024 16:15:10 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
Subject: Re: [PATCH net-next v7 12/12] selftests: ncdevmem: Add automated test
Message-ID: <ZyljjgxP94IBWnI6@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, andrew+netdev@lunn.ch,
	shuah@kernel.org, horms@kernel.org, almasrymina@google.com,
	willemb@google.com, petrm@nvidia.com
References: <20241104181430.228682-1-sdf@fomichev.me>
 <20241104181430.228682-13-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241104181430.228682-13-sdf@fomichev.me>

On Mon, Nov 04, 2024 at 10:14:30AM -0800, Stanislav Fomichev wrote:
> Only RX side for now and small message to test the setup.
> In the future, we can extend it to TX side and to testing
> both sides with a couple of megs of data.
> 
>   make \
>   	-C tools/testing/selftests \
>   	TARGETS="drivers/hw/net" \
>   	install INSTALL_PATH=~/tmp/ksft
> 
>   scp ~/tmp/ksft ${HOST}:
>   scp ~/tmp/ksft ${PEER}:
> 
>   cfg+="NETIF=${DEV}\n"
>   cfg+="LOCAL_V6=${HOST_IP}\n"
>   cfg+="REMOTE_V6=${PEER_IP}\n"
>   cfg+="REMOTE_TYPE=ssh\n"
>   cfg+="REMOTE_ARGS=root@${PEER}\n"
> 
>   echo -e "$cfg" | ssh root@${HOST} "cat > ksft/drivers/net/net.config"
>   ssh root@${HOST} "cd ksft && ./run_kselftest.sh -t drivers/net:devmem.py"
> 
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> ---
>  .../testing/selftests/drivers/net/hw/Makefile |  1 +
>  .../selftests/drivers/net/hw/devmem.py        | 45 +++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/devmem.py
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> index 182348f4bd40..1c6a77480923 100644
> --- a/tools/testing/selftests/drivers/net/hw/Makefile
> +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> @@ -3,6 +3,7 @@
>  TEST_PROGS = \
>  	csum.py \
>  	devlink_port_split.py \
> +	devmem.py \
>  	ethtool.sh \
>  	ethtool_extended_state.sh \
>  	ethtool_mm.sh \
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> new file mode 100755
> index 000000000000..1416c31ff81e
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -0,0 +1,45 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_exit
> +from lib.py import ksft_eq, KsftSkipEx
> +from lib.py import NetDrvEpEnv
> +from lib.py import bkg, cmd, rand_port, wait_port_listen
> +from lib.py import ksft_disruptive
> +
> +
> +def require_devmem(cfg):
> +    if not hasattr(cfg, "_devmem_probed"):
> +        port = rand_port()
> +        probe_command = f"./ncdevmem -f {cfg.ifname}"
> +        cfg._devmem_supported = cmd(probe_command, fail=False, shell=True).ret == 0
> +        cfg._devmem_probed = True
> +
> +    if not cfg._devmem_supported:
> +        raise KsftSkipEx("Test requires devmem support")
> +
> +
> +@ksft_disruptive
> +def check_rx(cfg) -> None:
> +    cfg.require_v6()
> +    require_devmem(cfg)
> +
> +    port = rand_port()
> +    listen_cmd = f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p {port}"
> +
> +    with bkg(listen_cmd) as nc:
> +        wait_port_listen(port)
> +        cmd(f"echo -e \"hello\\nworld\"| nc {cfg.v6} {port}", host=cfg.remote, shell=True)

FWIW, in the v3 of the series I submit, Jakub asked me to replace nc
with socat due to issues with nc [1].

Your usage of nc seems pretty basic though, so maybe it's fine?

[1]: https://lore.kernel.org/netdev/20241101063426.2e1423a8@kernel.org/

