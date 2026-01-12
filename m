Return-Path: <netdev+bounces-248879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61259D107F4
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 04:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC6B302BD03
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D372303C93;
	Mon, 12 Jan 2026 03:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1csbDOn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C4E2D46D6
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 03:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768189403; cv=none; b=Fz6X2AoRn7e46Vu13/SiEoDLEwol7BTQFJsnuEzqIu/kHNzZD4hLIZrz8TR1nl38NCzV7CLWl2tk+qAobcMuVSxF8vM6hHg5FYt9k4b7taHesLfyVb8dOgPlUwcWlwDr576KLf/i91D0PJNTQKu3A1vDGCzFtgVGsCIZkjcX2H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768189403; c=relaxed/simple;
	bh=aRoenwJ0gao7dPtlCSV/80B5lUMua0AbN7AvuLnw44o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Kn/9PDkmzBbbBvNECjwLhfhTx6Hn6hdHZwfF+EFdxe6tAbiwOCOk2C5RaCuUZxqKN4cf3C9zfSei5/d5h9wP0+QVGr4DUGVanQP38r0M6Tud2QaIZMZiQk8RB8PMVg7G61nMJunS4KGztMkwvCtqdmhGIyEPwGNbsI3HsXVK9xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1csbDOn; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-640e065991dso5317035d50.3
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 19:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768189401; x=1768794201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekfb/wJ+g8F9vSzHIhdC36YPR9Gw9VBJHquzEP71TvY=;
        b=b1csbDOnmtaUx7nSumUH/QT6I75xTT0AaJbYTKEEVWy8trVh42JZTNK/AGSFaSA1I8
         i5hacx7f9qGBbK2BYkNjs+LyE1sCJe0/lCckYwdywSycLvreMFLTABjKwwHLl8Z3GLk5
         xiC42gs/1Z2C5A5WZzTEoDzCRgPi+qExoQeibXFtL+0lr1Q5ilS2Jqouxxmf6N12pVm5
         fvJ0JdIidlMBbCwgTtAQ0qxJnJWtMAgfPFyhebkw5Uz+ezqvq50rVulq54ys76tijpbw
         m1H6WuwISB6UkJ+yM2b/VdCfj4UZED4BGD2GUjx5sbD04T2E3yLGYxvmWV67hOYnqS2z
         n+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768189401; x=1768794201;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ekfb/wJ+g8F9vSzHIhdC36YPR9Gw9VBJHquzEP71TvY=;
        b=umBwKudPuyemdFT4udU8FRwittwzA2vwEYT8Iji0ia59VRIr6smTHxOY6ndXieS+5V
         g1/g4gGixPWhGpcpd/VA0UzkAVeWIl0uQH4HFVER3YJLyp0e3jJrFzF2dJo+CMLo+Inw
         PYLifv6YkpzkyY4wSUkcPm102Vhi+qhUW1rFZmS1buutphUJvReVJFdnUV/tcvPK16bT
         uzXICMucYW+Gob5RqwHGUtymBlmluvYE5SEOWgnGHxeMD371j/PBu0Q86g6AQbNgHa4B
         OYC0h001XC+vTyEPFGQf8bqRKVw0dJZu6IN1t8Q+eKgaVoYz7xFsc7ueSahmKtsGMD/3
         UC9A==
X-Forwarded-Encrypted: i=1; AJvYcCXoxMnIUq/z4r8zcR/E16OGlaSQFgaxUmIVJZlePBTQ1BXDbl4d8SNTgXS01b8FAkdwGN0/Z7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45kklVqkTcBStD43Cn+ZiWAj4As5p1c0UgLwC1rsdwnBplW/2
	ukBFV0XOwXMcbqXUO96qRgCpNa71H/NmS52wawnMM3jH5kzecUcdYunx
X-Gm-Gg: AY/fxX651CZGzdirHa11K61F+hFomzYdZ9Z6i0ZEF35zAO7EoPfJTzN6YgDPs4YFQc1
	InDTlIAKhoF0BymDODMh/6EvO+7m6n4gOAcjWG9Ay1yszUT66zb8iaEr4mJpXFxrK+ki3BAetdw
	6Wq10v8Uyh3TcE9gsRiSVmNWFCaORWTUP1NdLSIiMMMRr5i2uQMBDsEU8cOyIQbw9i96nDlpVMn
	6xqKFiq/ZMM95k5w+dK0k18T7eCbFezRDH2Gc3vSdbSEpG7ZywomSt1/sDe8NCHnPcif/M01BXQ
	prXjfUQW+/Rx7qLRVqaI0/b3XMlrakIg7sALR4XfVD0lk/Kw++O5DKOX0hwsrT/2AIxS2M6NLQB
	QLewSLVmCvMOJNc09upCU6Ph719G9+Xsv3uUhjzjqIRNE7hGrvv07p8ZZ7amelpjWF9whK0o2TO
	rkLA/WEzDttTUtO61AoON7HsvOGq66jlO26yE4V8g8g6T7E3bedPlpK1kBmNY=
X-Google-Smtp-Source: AGHT+IEnEFu2j0k5cVNlPes4yIjGEiiDdRgjqnACw2xu0oJYD6eB9G55SWS+S0XVTzNsdlVDOJe2sQ==
X-Received: by 2002:a05:690e:4008:b0:63f:ad90:ad6e with SMTP id 956f58d0204a3-64716c04d5dmr13382554d50.64.1768189401054;
        Sun, 11 Jan 2026 19:43:21 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790aa6f09besm65668507b3.56.2026.01.11.19.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 19:43:20 -0800 (PST)
Date: Sun, 11 Jan 2026 22:43:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Gal Pressman <gal@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 netdev@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Petr Machata <petrm@nvidia.com>, 
 Coco Li <lixiaoyan@google.com>, 
 linux-kselftest@vger.kernel.org, 
 Gal Pressman <gal@nvidia.com>, 
 Nimrod Oren <noren@nvidia.com>
Message-ID: <willemdebruijn.kernel.f136c851c9ee@gmail.com>
In-Reply-To: <20260111171658.179286-2-gal@nvidia.com>
References: <20260111171658.179286-1-gal@nvidia.com>
 <20260111171658.179286-2-gal@nvidia.com>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: fix RPS mask handling in
 toeplitz test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Gal Pressman wrote:
> The toeplitz.py test passed the hex mask without "0x" prefix (e.g.,
> "300" for CPUs 8,9). The toeplitz.c strtoul() call wrongly parsed this
> as decimal 300 (0x12c) instead of hex 0x300.
> 
> Use separate format strings for sysfs (plain hex via format()) and
> command line (prefixed hex via hex()).
> 
> Fixes: 9cf9aa77a1f6 ("selftests: drv-net: hw: convert the Toeplitz test to Python")
> Reviewed-by: Nimrod Oren <noren@nvidia.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  tools/testing/selftests/drivers/net/hw/toeplitz.py | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> index d2db5ee9e358..7a9af4af1838 100755
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> @@ -94,14 +94,17 @@ def _configure_rps(cfg, rps_cpus):
>      mask = 0
>      for cpu in rps_cpus:
>          mask |= (1 << cpu)
> -    mask = hex(mask)[2:]
> +
> +    # sysfs expect hex without '0x' prefix, toeplitz.c needs the prefix
> +    mask_sysfs = format(mask, 'x')

A particular reason not to use the existing slicing?

> +    mask_cmdline = hex(mask)
>  
>      # Set RPS bitmap for all rx queues
>      for rps_file in glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*/rps_cpus"):
>          with open(rps_file, "w", encoding="utf-8") as fp:
> -            fp.write(mask)
> +            fp.write(mask_sysfs)

Alternatively 

-    mask = hex(mask)[2:]
+    mask = hex(mask)

- fp.write(mask)
+ fp.write(mask[2:])

The comment that sysfs and toeplitz.c expect different input is
definitely helpful.

>  
> -    return mask
> +    return mask_cmdline
>  
>  
>  def _send_traffic(cfg, proto_flag, ipver, port):
> -- 
> 2.40.1
> 



