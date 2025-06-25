Return-Path: <netdev+bounces-201031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEE8AE7E7E
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 678F53A50AE
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470929AAE3;
	Wed, 25 Jun 2025 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fu0Ghtvl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3186F1F4612
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 10:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750845966; cv=none; b=a2t/GcK3+TX4Qrykcpq4yWzVCfcIFQEeHoa4aKW5ppokWzp2QxbDoe+hKe7J2heGDpknQACCtUmICY0RkWI5mgSeoD5woeEA9FDkMTaiA0MqbrB5XvcX9cq3rwQ8UrYrkLQ2/QPy0EqY114KpbPAS4D3mmS35VuXID0YINNvlOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750845966; c=relaxed/simple;
	bh=iDLur0l7k5yaPj7iqbQwBhLQClKvAjBRWimnIm/dkAY=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=CiJPm2wpCbm8VLEzk1n2v693k4nctnrYqkEO7hEdLw7bRfGxJRnuEEip/BIq/1yuFfavBlm7qEcpbX3pYVVrH5RsXFmfqfi669VNlNCRy/WGCKLpzPI1j8Id8KOBCqTC/sByXnqwCAysaa2zAeDw46DudKkJlgwI1fAjq634Gr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fu0Ghtvl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45348bff79fso68397875e9.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750845963; x=1751450763; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UnD1m1XbeYSVHq5jPbKwTiVIh55378zsOvnXyodIUcg=;
        b=Fu0GhtvlrdWwI1ERNrt6bXQtLX51LnA6NSRB4zFywDt8wumhpiATtOd7XljQSqCSGn
         X596u3iWyPkwJu6r+RTyu8ZQwNHjoCqg76tyPavOiOa93QoRBPZFid+aybQoMV/31WOt
         FSTdG3TdLaNt+PgHw4Pj1t9CUkzSfSgYMebNFlPoP4z32QtyM1Z/kCvSKAWtTx/kWz1n
         Uyo6QZCc7Lmu9F4cieqBupxJig4lBk+8P0vk680bdfCCkc9mPEewhTSUDxkwfsLniaFK
         9qPml3sf/RVeFaMJq7A9jE3rXGigK+Rp7EmCN60lxG6br8iufESdk8mjHwe8sdrLPNDc
         At/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750845963; x=1751450763;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnD1m1XbeYSVHq5jPbKwTiVIh55378zsOvnXyodIUcg=;
        b=JjKCCMWeaQVe+zuctOAJEL49ZfaiQjZd8PIt7pjjSOjCZJZ8KfNu6ftuUNYvoK4gME
         Qr/qnqIbPYYoAfSqorQosappjAecPGJOl43TLXRyKlax3qk+SoEHl5Cs1REQIKylqo98
         zBvuM45CN/TrXYz5JEGvTU8414QlsgKlo493GjBqJPtciIG0Cr1hsmW32jG5wZ0t99cW
         97vjniXS9InwnnlPm6xxfg4/6IdJ5g7w8pOH89sre3dXKNi6DuBbcsYbCq32xEIJENDZ
         b4jL/bd9AnsPjdjyGvmkDCpzvzNK4uDHqhRrMLOJOMe36vOhSjRWDTPWKQbJ/QXcKOYd
         hdcA==
X-Forwarded-Encrypted: i=1; AJvYcCWo7AZr5QymzO5GK1pcCATdP5YBxRci2mH71akQMAq2PuQeHb0F0U2k1mfXIzK0yK5MgngGB5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8Sxi85fszDKMOhhKr5BxYUFa9y7Wk6ETvJrhobU4Ixg3fwmGt
	8U5HMUpXLF7i1sJu3eHa6uysx8C+zCkmPDMls37e/kVJZoFQVzLfzi1Z
X-Gm-Gg: ASbGnctRB2zqDpPBRLnyB7qEYLf3u15x3TxXeYo2sQmJGIWX4McrMwrIXSTR1WSx3ML
	r0Dhp9izWWH0XfFvguslc4JlVY8Cu0PvunikLYnMsqYaPoW5hhpiYvWI51vUPo7ZvHRtewBNNfP
	bNjigOUTPOyQkxm4xFQZdAtWrYdfY7oVPO6tiEmzyZLXpKuku4gTxTsZWIpWbras5d7PeBDJF5V
	LEnnErb+/EoWl5VZbZeTS3Khytkqi8Lo5TBa0BfLk0XSGntveTfEjKoEKPrQphpmLpI1xCZSspw
	A98XprWd6MRzpdWOrL+rK5GwTMSJvrLpNlp5amy5uN/voFa3s2eTzd/NCPylw+9GTRRgUXgZpKY
	=
X-Google-Smtp-Source: AGHT+IFk5H9rf7B0JX/6RJ4fpn9jSCZ0Vv5hLIx/A+Md+QVkV1WWLj/gT/rheQ00BWIHeMegr+LrUw==
X-Received: by 2002:a05:600c:37ca:b0:450:cf42:7565 with SMTP id 5b1f17b1804b1-45381ae5157mr20080085e9.23.1750845962996;
        Wed, 25 Jun 2025 03:06:02 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:5882:5c8b:68ce:cd54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233bd14sm15240915e9.2.2025.06.25.03.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 03:06:02 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  maxime.chevallier@bootlin.com,  sdf@fomichev.me,  jdamato@fastly.com,
  ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2 8/8] selftests: drv-net: test RSS Netlink
 notifications
In-Reply-To: <20250623231720.3124717-9-kuba@kernel.org>
Date: Wed, 25 Jun 2025 10:46:53 +0100
Message-ID: <m2sejocfw2.fsf@gmail.com>
References: <20250623231720.3124717-1-kuba@kernel.org>
	<20250623231720.3124717-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Test that changing the RSS config generates Netlink notifications.
>
>   # ./tools/testing/selftests/drivers/net/hw/rss_api.py
>   TAP version 13
>   1..2
>   ok 1 rss_api.test_rxfh_indir_ntf
>   ok 2 rss_api.test_rxfh_indir_ctx_ntf
>   # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/hw/rss_api.py       | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/hw/rss_api.py
>
> diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
> new file mode 100755
> index 000000000000..db0f723a674b
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
> @@ -0,0 +1,89 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +"""
> +API level tests for RSS (mostly Netlink vs IOCTL).
> +"""
> +
> +import glob
> +from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_is, ksft_ne
> +from lib.py import KsftSkipEx, KsftFailEx
> +from lib.py import defer, ethtool
> +from lib.py import EthtoolFamily
> +from lib.py import NetDrvEnv
> +
> +
> +def _ethtool_create(cfg, act, opts):
> +    output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
> +    # Output will be something like: "New RSS context is 1" or
> +    # "Added rule with ID 7", we want the integer from the end
> +    return int(output.split()[-1])

I think .split() is not required because you can access strings as
arrays.

Will this only ever need to handle single digit values?

> +def test_rxfh_indir_ntf(cfg):
> +    """
> +    Check that Netlink notifications are generated when RSS indirection
> +    table was modified.
> +    """
> +
> +    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
> +    if qcnt < 2:
> +        raise KsftSkipEx(f"Local has only {qcnt} queues")
> +
> +    ethnl = EthtoolFamily()
> +    ethnl.ntf_subscribe("monitor")
> +
> +    ethtool(f"--disable-netlink -X {cfg.ifname} weight 0 1")
> +    reset = defer(ethtool, f"-X {cfg.ifname} default")
> +
> +    ntf = next(ethnl.poll_ntf(duration=0.2), None)
> +    if ntf is None:
> +        raise KsftFailEx("No notification received")
> +    ksft_eq(ntf["name"], "rss-ntf")
> +    ksft_eq(set(ntf["msg"]["indir"]), {1})
> +
> +    reset.exec()
> +    ntf = next(ethnl.poll_ntf(duration=0.2), None)
> +    if ntf is None:
> +        raise KsftFailEx("No notification received after reset")
> +    ksft_eq(ntf["name"], "rss-ntf")
> +    ksft_is(ntf["msg"].get("context"), None)
> +    ksft_ne(set(ntf["msg"]["indir"]), {1})
> +
> +
> +def test_rxfh_indir_ctx_ntf(cfg):
> +    """
> +    Check that Netlink notifications are generated when RSS indirection
> +    table was modified on an additional RSS context.
> +    """
> +
> +    qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
> +    if qcnt < 2:
> +        raise KsftSkipEx(f"Local has only {qcnt} queues")
> +
> +    ctx_id = _ethtool_create(cfg, "-X", "context new")
> +    defer(ethtool, f"-X {cfg.ifname} context {ctx_id} delete")
> +
> +    ethnl = EthtoolFamily()
> +    ethnl.ntf_subscribe("monitor")
> +
> +    ethtool(f"--disable-netlink -X {cfg.ifname} context {ctx_id} weight 0 1")
> +
> +    ntf = next(ethnl.poll_ntf(duration=0.2), None)
> +    if ntf is None:
> +        raise KsftFailEx("No notification received")
> +    ksft_eq(ntf["name"], "rss-ntf")
> +    ksft_eq(ntf["msg"].get("context"), ctx_id)
> +    ksft_eq(set(ntf["msg"]["indir"]), {1})
> +
> +
> +def main() -> None:
> +    """ Ksft boiler plate main """
> +
> +    with NetDrvEnv(__file__, nsim_test=False) as cfg:
> +        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
> +    ksft_exit()
> +
> +
> +if __name__ == "__main__":
> +    main()

