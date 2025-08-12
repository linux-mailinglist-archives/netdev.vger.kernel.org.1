Return-Path: <netdev+bounces-212672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D78B219B5
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 02:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E6A427B3F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 00:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED55028CF49;
	Tue, 12 Aug 2025 00:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="HhbqM+yh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCFD287276
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 00:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957763; cv=none; b=pUzPsqE/k9Sko307qrn890BdYeoPUCB3fHnAQY9v37wj6TZf7tVfTwPcrplVO2+PdS0ol8hCQmj7ptSpbuOGHZEqFRlXMUXTU/aWPnExYJmwMKpbH4J2e4aMj3e7n6aBDqu6mnJC4fU6BRMkK0qbq18mi3AQ9jmaizUG4gX8P0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957763; c=relaxed/simple;
	bh=lObKFFpWe1nUswWAHXSFoQmqA4gcLgheGbmRodNzuXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDyLehBxxUjhvQyodrYUP/yIAZYGJAcyWUkPZq8s1LH929hiaQBRNnwCrb8lVPUgIzLpOkUkx0bWtGOY0II5GhJqT3mJKOJpNxX+A0EU2LSZA4VHBk+l0rbaMl0kB9NmAwuCnn7KvnETXm9VvMJlZ+mG3UWm8Iy9ZKDChyybXso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=HhbqM+yh; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76bd2b11f80so4451918b3a.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 17:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1754957762; x=1755562562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0POCdQlHDdBEpMWZLVYNWiTFkyq9Hm0ip3OGGCpoX8s=;
        b=HhbqM+yhIllsQbh1uMrSUeUwNkZQAwS84nHefkZOZHHXS+VMvBF8QxzdBn3oAATHWL
         v9feAO9cOOqiAwakdJ/3IP7+Lv8uiX7s0fQ+fa6FKg4aIgwUlLpV113BGBWW1Y9ge8OX
         Tk7lbnMiZ2vXmDROLyEeZmNtkLCqEcXaTZ7VkPgrSinRzRPm/StDD/QNIErR2T51lJSw
         9I7NCt4MzYnjmKTK51yprIIcW/Cr8FMjvMRqT1Zd/BgL3SN5iSGpjfkOeFmst6L6HDz4
         LbW/nWuJKbbqtrgptD5ng/QDX2HolHkt4y/IbdJ4uXbSTXjLtuH32gdptYoYQwMe5BbZ
         3qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957762; x=1755562562;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0POCdQlHDdBEpMWZLVYNWiTFkyq9Hm0ip3OGGCpoX8s=;
        b=M+siGmDm8NUQ3nnUQHRrqYxqk5i24Qt+5KjaV2biX/gqujyETrcwWXKfRwaVJ8IM5A
         8JMUvon7GwmuLkdYki6PbMNjy/L/yw4FP8HLaH54Pgj1F+XZi2dJmVJR/Jd0ucLPtFlA
         PDmGyC+kvlqNzLM9/Q/xElBxCSErLFXm7Geao9xhNg07X0pIecvb1HBhRciJupvqcjMX
         qLZn/a/FSHZ8uBwmMG+D6p5b5bpNXV/npFC6ITG5MBkdYvRHsMEfMlIHZ7bwUwhzJG5B
         5UcDwKJoZpoBewc61rCw6yUoNmKlyh4pjS/W6fLDT/U0Fqw2WKU5OWKM9pwFPLIaGr//
         ENBA==
X-Forwarded-Encrypted: i=1; AJvYcCX8ONR9aNZnBg9k/gisAXisYlAMPZp4Rl8XaX/ke1fQxI4tziEFKNeH9hyxYsofsy4qAALf/T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJPFv680gTbK1CZwHsDW6ayt7TE2PuAwoeTQGZyt/PYujU+3K+
	RolqhAcpOskpfUIXh2Gh+QdwJiuvd4dYOqEMtvTEySHnmurxiwJAQcAzySkhLCEWeFmREvQFF4X
	GNX3jDt4=
X-Gm-Gg: ASbGncvR4ghaycplUnxQh/e8lsRQ56z5CJ5k1G7frwvYUrnJMmIAz3QstmpBP+qjgz5
	QaYpKj0LcH2yxoQj4AmrY4DpFsBMoaniVJUmIlIiDadqd30U5QraUMKCPyfgvHEX7vo6UKuFZ3P
	lCf2xFVtAuxqKh9HIPlZvQlBd0lYISlNvwGWda8ahVyOzdkt6UZsxVTxs4tqyLgXjmAMOTqFvFS
	L/YOCGo14uL8Qnq7bzC53TfPX9BA9HmNQX96jDk2IqPmuai1oRUvIUFpTj3g3pdK2bQILW8Ynqo
	I5ieOTWXl2r+OZIZEXZPCNGI3i86ItUutabRH0rC5ccE4DZVx+XuGlncjw0SrwMPgXiWYf/zWTh
	8gtxE+hCsbWJzQTE4crGSScUq/t3hvSssQnBKeuATCiC4MmwSO4lXKBJfgtHsChC1NrM=
X-Google-Smtp-Source: AGHT+IEb/RCypsYKRtKPrdAz57Bt/xhCKJfsciQI+T+k7MCGB9l0n4g3gmzopXU70O5IsD9Vx0fe0w==
X-Received: by 2002:a05:6a20:7349:b0:23d:d13d:8a6 with SMTP id adf61e73a8af0-2409a986831mr2184887637.24.1754957761704;
        Mon, 11 Aug 2025 17:16:01 -0700 (PDT)
Received: from MacBook-Air.local (c-73-222-201-58.hsd1.ca.comcast.net. [73.222.201.58])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76c6f0c862fsm5509865b3a.115.2025.08.11.17.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 17:16:01 -0700 (PDT)
Date: Mon, 11 Aug 2025 17:15:58 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, sdf@fomichev.me, almasrymina@google.com,
	noren@nvidia.com, linux-kselftest@vger.kernel.org,
	ap420073@gmail.com
Subject: Re: [PATCH net-next 5/5] selftests: drv-net: devmem: flip the
 direction of Tx tests
Message-ID: <aJqHvt0EsV6ALgiE@MacBook-Air.local>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	sdf@fomichev.me, almasrymina@google.com, noren@nvidia.com,
	linux-kselftest@vger.kernel.org, ap420073@gmail.com
References: <20250811231334.561137-1-kuba@kernel.org>
 <20250811231334.561137-6-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811231334.561137-6-kuba@kernel.org>

On Mon, Aug 11, 2025 at 04:13:34PM -0700, Jakub Kicinski wrote:
> The Device Under Test should always be the local system.
> While the Rx test gets this right the Tx test is sending
> from remote to local. So Tx of DMABUF memory happens on remote.
> 
> These tests never run in NIPA since we don't have a compatible
> device so we haven't caught this.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/devmem.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/devmem.py b/tools/testing/selftests/drivers/net/hw/devmem.py
> index 0a2533a3d6d6..45c2d49d55b6 100755
> --- a/tools/testing/selftests/drivers/net/hw/devmem.py
> +++ b/tools/testing/selftests/drivers/net/hw/devmem.py
> @@ -42,9 +42,9 @@ from lib.py import ksft_disruptive
>      port = rand_port()
>      listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
>  
> -    with bkg(listen_cmd) as socat:
> -        wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port}", host=cfg.remote, shell=True)
> +    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
> +        wait_port_listen(port, host=cfg.remote)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port}", shell=True)
>  
>      ksft_eq(socat.stdout.strip(), "hello\nworld")
>  
> @@ -56,9 +56,9 @@ from lib.py import ksft_disruptive
>      port = rand_port()
>      listen_cmd = f"socat -U - TCP{cfg.addr_ipver}-LISTEN:{port}"
>  
> -    with bkg(listen_cmd, exit_wait=True) as socat:
> -        wait_port_listen(port)
> -        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_remote} -f {cfg.ifname} -s {cfg.addr} -p {port} -z 3", host=cfg.remote, shell=True)
> +    with bkg(listen_cmd, host=cfg.remote, exit_wait=True) as socat:
> +        wait_port_listen(port, host=cfg.remote)
> +        cmd(f"echo -e \"hello\\nworld\"| {cfg.bin_local} -f {cfg.ifname} -s {cfg.remote_addr} -p {port} -z 3", shell=True)
>  
>      ksft_eq(socat.stdout.strip(), "hello\nworld")

FWIW: I don't have one of these devices to test this on, but the change seems
reasonable to me, so:

Reviewed-by: Joe Damato <joe@dama.to>

