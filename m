Return-Path: <netdev+bounces-105912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEA79138C9
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911AD1C20A4D
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01995339B1;
	Sun, 23 Jun 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDWhIzLQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631BE20317
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719128242; cv=none; b=Ukofla+YySYyrrTAZy27xsogxLK55+ZW+xbT9PIh2234zZaszyqNVTU2cq7Z/bL0/O8PsYBE9VYWcFh+vpLD9MOpG+qsXa8GJ6sFUkSKm4sZGYF8zJd1Kcm7vRCBulxwkNJpOKC/bYFddrvkwfTPnOrwoZyLo5X+DceKFcWJJ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719128242; c=relaxed/simple;
	bh=LKmj3S7VrU8WOui+L72d/J0+AlgTS3ouT4t0Yu1VyCk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cBQ78ZV2LUpXEWxCH615GDlHMV7ATjnowJzW95LIjVzb3SKHzqfpJigws8zHeMQkCTnRzXmWHxALby1O0o8Y6o4ncfO0egDFEZ8IehfezDfhW6mxqxbLfB+6OFgG4OIo/PAXUTigh0Sc/Nh/yhP8BSd/GLM89gQQR9998ldPO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDWhIzLQ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b4ff803ef2so15763226d6.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 00:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719128240; x=1719733040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1ZuKu48uZHhUKm5DA/1vcFEqKS5a2b6qn9mmaWmy7c=;
        b=gDWhIzLQ006pRTQ9gTuPPjDqz40szRmzT/hrkCDz28XQqo1KNpqxB762rBdPO6tPSR
         TL8lLIiCvKcEJKzpq+9RcAiiOk3d57SD56ZAT1GIh9fGZlh646Y1E1AFcZENNEHRTwVh
         j+60oryt1cWKb25cF2R9iX8JW2eSRMTbxKBi8fGz/SrtyB+w1U/3zNs4VTID3uEyISYA
         Ib3d5huuGSOvZrriwsLslG+7SE0evwD2rnjBsVMXr2/VuGO5snmepLZbbJd9WbuQ4Vhw
         YxfeDDY3/3h/JUY6eCgMCMnu+9BynvcrYox5cy7upjwifAu4Dt6VBqE4ctnR2n2YNUpC
         nv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719128240; x=1719733040;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g1ZuKu48uZHhUKm5DA/1vcFEqKS5a2b6qn9mmaWmy7c=;
        b=naieb85A8C5YuQOe1aZHIgl/PfjihPiSTDGVSE1nsk+bzpam3ccEcCtBqBw8hh/UPG
         SPjowp7iVcrgAfC3B18UTY43Diq/b2TKGzcD/pjXl6Y3tPvxfXqDO+7VgUVqFW/HMuSP
         r4Of33x1zdS075CHOYVb3Z1BGpn8NY+JNUNeOImWBJ9tMUOoL3ParjOEXpMde9Zl5dav
         6I/QchIRpwPqIoY0+/1b8IeTkWA6Js13wNoFv9hv0v3ZuPkW6NO9NpHmU8XQ6Xj5hRhs
         njB1UbgJsgPd/kr/GBSrJ1aiCmj7/9Ife9OoPdWoLOcrlMSRk9WxXg0rDpAnz8tUlXdS
         AJrA==
X-Gm-Message-State: AOJu0Yzpkq+CS28kzRtvKF0AyEhO4Up/PRtvJlDSYTSXzArMPxtffrCd
	V28sSdSvWhuQ/rQvjXkQJqXMw/6rjUjNkUlBbIcS5GfOqRkWCoHb
X-Google-Smtp-Source: AGHT+IEmA/8EV70xgnU2Xo2iBQlUMOGD9hnJp0Pvb35YWhhF8iV8xuRy9nCb+c0HMxCLKViRaV66rg==
X-Received: by 2002:a05:6214:d2:b0:6b0:6965:511 with SMTP id 6a1803df08f44-6b5409a53d2mr17795316d6.7.1719128239872;
        Sun, 23 Jun 2024 00:37:19 -0700 (PDT)
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ef5fbd6sm23469806d6.124.2024.06.23.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 00:37:19 -0700 (PDT)
Date: Sun, 23 Jun 2024 03:37:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 willemdebruijn.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6677d0af33d39_33363c294f8@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240620232902.1343834-3-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
 <20240620232902.1343834-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/4] selftests: drv-net: add helper to wait for
 HW stats to sync
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> Some devices DMA stats to the host periodically. Add a helper
> which can wait for that to happen, based on frequency reported
> by the driver in ethtool.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  .../selftests/drivers/net/lib/py/env.py       | 21 ++++++++++++++++++-
>  tools/testing/selftests/net/lib/py/utils.py   |  4 ++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index edcedd7bffab..34f62002b741 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -1,9 +1,10 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  import os
> +import time
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
> -from lib.py import cmd, ip
> +from lib.py import cmd, ethtool, ip
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
>  
> @@ -82,6 +83,8 @@ from .remote import Remote
>  
>          self.env = _load_env_file(src_path)
>  
> +        self._stats_settle_time = None
> +
>          # Things we try to destroy
>          self.remote = None
>          # These are for local testing state
> @@ -222,3 +225,19 @@ from .remote import Remote
>          if remote:
>              if not self._require_cmd(comm, "remote"):
>                  raise KsftSkipEx("Test requires (remote) command: " + comm)
> +
> +    def wait_hw_stats_settle(self):
> +        """
> +        Wait for HW stats to become consistent, some devices DMA HW stats
> +        periodically so events won't be reflected until next sync.
> +        Good drivers will tell us via ethtool what their sync period is.
> +        """
> +        if self._stats_settle_time is None:
> +            data = ethtool("-c " + self.ifname, json=True)[0]
> +            if 'stats-block-usecs' in data:
> +                self._stats_settle_time = data['stats-block-usecs'] / 1000 / 1000
> +            else:
> +                # Assume sync not required, we may use a small (50ms?) sleep
> +                # regardless if we see flakiness
> +                self._stats_settle_time = 0

Intended to set _stats_settle_time to 0.05 here? Else I don't follow
the comment

> +        time.sleep(self._stats_settle_time)
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 9fa9ec720c89..bf8b5e4d9bac 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -78,6 +78,10 @@ import time
>      return tool('ip', args, json=json, host=host)
>  
>  
> +def ethtool(args, json=None, ns=None, host=None):
> +    return tool('ethtool', args,  json=json, ns=ns, host=host)
> +
> +
>  def rand_port():
>      """
>      Get unprivileged port, for now just random, one day we may decide to check if used.
> -- 
> 2.45.2
> 



