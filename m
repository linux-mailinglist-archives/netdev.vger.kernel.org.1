Return-Path: <netdev+bounces-303307-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1DaqDTb6Q2qumgoAu9opvQ
	(envelope-from <netdev+bounces-303307-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:17:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116F6E6D46
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:17:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rMoPlz4p;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303307-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303307-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26BC5316E6F2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C793DB30A;
	Tue, 30 Jun 2026 17:11:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019EE3D75C2
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 17:11:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839479; cv=none; b=UAs4LVU7E81qW71nNXn8gChp38DnlNH5i+p/6/6IA6LOmr4IpCZwsvE+gfbS76Y6d4gDXABtI6ZEGowgZpEDrtY+63RzJfNI+gSOy7s7MyKSmWoSDWgm3YEyLTOzU5ssjFYTtSdJ8v4Rg0+VwChZI/GSHzQQ4OBDlyL7NxYGPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839479; c=relaxed/simple;
	bh=BxM8tCRL/LY3p016q2G8x8d9hhF+S3sM1Ssibu3JnEE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DZlZtbbTvmH9hAy3UpJgUlPF/572/Qrw6OOwUywy5mqhvX6ltHWF2cNxhseOzh2kctctuZqCM9Ur3MMUTDDg2HSmqhASxYdLrLTRa8lxCRZIABBPNUyHblcHSfHv/k7bWcKDxx13MJrDt17z2x0/0DbIFcIhF3/qO3NCgWCcrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMoPlz4p; arc=none smtp.client-ip=74.125.224.53
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664d4478a64so2486285d50.3
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782839477; x=1783444277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPJiBM1HvdVkRkqn01nRJ7T3toL0q0YlzVSn5/uUYBE=;
        b=rMoPlz4pAyQWbl0n7yhI0B5GyLcDUDnr3dck10vphqCX7Xn669qXR3THCo9euZHSUl
         MT9ZJZdx31+ODp1lsixkclpG8aell+0YG5p05XcL5JEtGCXssMjOhH938x0q/fM3WcsQ
         cF+PIzWkbNOMDzOJA9/cyg7QNrkPWDRXhMWBUim3NiDjHX9GWUHhdp4qfAHHU/yNt2JK
         24bFDUtnum0TbESHQVPhXPsHXNFCS6C++eMpW7IE9bbH9O5xicmtF7Mq8OEP4U5aXYtP
         1rmtrMn+jU3ydBRS2EmRI1QX/5WRepvFMwEyQd7mEq0rq/3NmHP4PPjxP9rvbKkWNKtZ
         7tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782839477; x=1783444277;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPJiBM1HvdVkRkqn01nRJ7T3toL0q0YlzVSn5/uUYBE=;
        b=OZBePrqjmvNbp3z3bNxj9II7P2ZJMkDo0i87ndddUy2sb1sgvf3I/hpu8L6j64xz1b
         7YDqGFtDSHbO+eP0fYcKTXq2iHbdPb7A5Q2zzc/LIW1VtCcEcbTF2sGwCuheaQjOcUSj
         BXgCNRTsnqUTRXcXIxKhzrmbe9qjkOuWmcgSDCZhIUcGZIXLUe15tertiQZ8KdV4FMdj
         +EP2mLMKgiFG+jkltoAUlLIGKjvv4nDUFCl5v5mW0NjR1m8tGT9+EWoZtA00ubLpqQdq
         Y+UMeF2BjHk6WuJIDbJiQlUPqVPtXhVgVDpnsXGDvPEawk8OnGDUHjjGsPcnFzLwQB4W
         Gopw==
X-Gm-Message-State: AOJu0YxMEgFPD2whDG2L87rDE48OQl2KsW7TUo4Y5GnxNMV+FOB0BQBj
	r1p5AQOAxib2bhDnB2I8pxeHkO8kuSMMLuQBPpH1oy1ht5FqjAsD8rm/
X-Gm-Gg: AfdE7cnXRtZTOLcBzrrLGjvlEy8cIlPe769n0cyYYBNbTBfMM+W2gXc5z5+WDfPyKNl
	8TBO+mX1Td7vilS1iM+ax1vcbfb89mNwl9bulvmlEyLlqPlk5APJ9JN5i+idHuikTCGeyzrc7ee
	oInYvBlsBt2YumEBJZTjeLnjqpB/rVgt1Ew5Tc1cn53vaV2dMU9j4Slr17P9HBvJdx8EF1taVRB
	aSvcVkwhvfsjHyPdOZIO8kktagUyEGBLSfWYN4D1sA4SbWJhkOc8tF0GBkC+haD5QWLEGBli6zo
	FcJQ3x8djE+0VhNPRMy+Wn0QpswYZlhIezXyWbSmYDZQfyQepfXAYQf14Oxn4j2mfN/S7jO0q5u
	XokCtH17IBghG1JYYTZzelYaQgMotkIWYT+4FYsEkb4qXlAA1dxRB/ENXprNwoDs00IajGooI0Q
	gikQGERjXdJKNsnCjVkFSF65G0DiuJWwXoCKbMur6cwepPtVzBBjJa8cAkZX6fhWiuhzCC
X-Received: by 2002:a05:690e:43da:b0:664:77d8:ffc0 with SMTP id 956f58d0204a3-66510b067d5mr829578d50.39.1782839476992;
        Tue, 30 Jun 2026 10:11:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6650168a556sm1140056d50.18.2026.06.30.10.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:11:16 -0700 (PDT)
Date: Tue, 30 Jun 2026 13:11:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, 
 shuah@kernel.org, 
 willemb@google.com, 
 noren@nvidia.com, 
 gal@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <willemdebruijn.kernel.23684913d1fd4@gmail.com>
In-Reply-To: <20260629234354.2154541-1-kuba@kernel.org>
References: <20260629234354.2154541-1-kuba@kernel.org>
Subject: Re: [PATCH net-next] selftests: drv-net: toeplitz: cap the Rx queue
 count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303307-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shuah@kernel.org,m:willemb@google.com,m:noren@nvidia.com,m:gal@nvidia.com,m:linux-kselftest@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lib.py:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8116F6E6D46

Jakub Kicinski wrote:
> The RPS test needs a free CPU within the first RPS_MAX_CPUS (16)
> cores. This is easily violated if the NIC or env allocates the
> IRQs to cores linearly.
> 
> Cap the Rx queues at 8, we don't need more. This makes the test
> pass on CX7 in NIPA.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: noren@nvidia.com
> CC: gal@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  .../selftests/drivers/net/hw/toeplitz.py      | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/toeplitz.py b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> index cd7e080e6f84..571732198b93 100755
> --- a/tools/testing/selftests/drivers/net/hw/toeplitz.py
> +++ b/tools/testing/selftests/drivers/net/hw/toeplitz.py
> @@ -21,6 +21,8 @@ from lib.py import ksft_variants, KsftNamedVariant, KsftSkipEx, KsftFailEx
>  ETH_RSS_HASH_TOP = 1
>  # Must match RPS_MAX_CPUS in toeplitz.c
>  RPS_MAX_CPUS = 16
> +# Cap Rx queues so IRQ pinning leaves free CPUs in the RPS_MAX_CPUS range
> +QUEUE_CAP = 8
>  
>  
>  def _check_rps_and_rfs_not_configured(cfg):
> @@ -48,6 +50,25 @@ RPS_MAX_CPUS = 16
>          return int(data)
>  
>  
> +def _cap_queue_count(cfg):
> +    ehdr = {"header": {"dev-index": cfg.ifindex}}
> +    chans = cfg.ethnl.channels_get(ehdr)
> +
> +    config = {}
> +    restore = {}
> +    for key in ("combined-count", "rx-count"):

This assumes that combined and rx are not set at the same time.
SGTM, not expected in real devices. But technically they could be.

> +        cur = chans.get(key, 0)
> +        if cur > QUEUE_CAP:
> +            config[key] = QUEUE_CAP
> +            restore[key] = cur
> +
> +    if not config:
> +        return
> +
> +    cfg.ethnl.channels_set(ehdr | config)
> +    defer(cfg.ethnl.channels_set, ehdr | restore)
> +
> +
>  def _get_irq_cpus(cfg):
>      """
>      Read the list of IRQs for the device Rx queues.
> @@ -177,6 +198,7 @@ RPS_MAX_CPUS = 16
>      ]
>  
>      if grp:
> +        _cap_queue_count(cfg)
>          _check_rps_and_rfs_not_configured(cfg)
>      if grp == "rss":
>          irq_cpus = ",".join([str(x) for x in _get_irq_cpus(cfg)])
> -- 
> 2.54.0
> 



