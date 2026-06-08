Return-Path: <netdev+bounces-296712-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQNWFusmJ2q3sgIAu9opvQ
	(envelope-from <netdev+bounces-296712-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:32:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC74165A75C
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:32:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=hmh6GgEc;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296712-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296712-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295E53013A50
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CBE3B19CD;
	Mon,  8 Jun 2026 20:25:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B13B14B0
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:25:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950306; cv=none; b=hb6RniKfTUlepoTbkj3FYwTtRH9Ckc5JpbPMTWn14p76PlJWTJzvmsW3nqRIjS7pAECFSSlKdRzVUCM/n4DtOf1FLXdpfJuk8bMI0FWk93OFovrt+nfIf97+3o3HXl+I509G9gqfdsXnNloCHUlYuM8kzbURXiRj4tDu0ZsNRB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950306; c=relaxed/simple;
	bh=CcXHn9S8u1cOPsToW7mASeAPsynC5+Mdc21kpMoNal8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ctAAerBHbZfiC2TwrqDWl+p6c4KLb/JzNXz+gH5ZlX8Kbw0Pad31DwXK3AAqDAjxMKPgHi8B6bJmV8be4wUmq6AVEWHyeJEqNdiaXme9j6Mb3orwunQcAl9aWE/RWur7s58xFnNAZC41JwKNwsM8PXrBY4KKqp3BdpbKUhdca7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmh6GgEc; arc=none smtp.client-ip=209.85.128.175
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7dc2b658544so43248557b3.2
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950302; x=1781555102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpFVOPiFzhLsPysXxjpYGvfhd5BQhGBhO9lG7IWGmcs=;
        b=hmh6GgEc7bcGsxHB83OQIKYcTiEe/S7Q8SZZBrhVi9at0ZzBjldoUMttWQdmhS5aQd
         SMlFXx2jmjIel8V8OAG2vsbrBlAxlsFQYdzpo/4L8YQzip6zXleEPH4jdpuL7xQ+9HkP
         hrHeEFt8mDpDI+I+UNMljaaEXvlw8VwpAjkuBxQCePFFfVOHrUpwV+tNWKR0ccFhISl6
         xcNHP/W3U2u1GoTmusdsEwoi+Tkqemq6mMWtHEvtk2jA9AqvG1z41nOMKQtUDrIS440u
         T3anDQN2duMfAr4748QhUbMsgUoU/5efL+xmRZpa4RoRCZXQyDWf6UdQLPUTSgdllC+0
         IkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950302; x=1781555102;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kpFVOPiFzhLsPysXxjpYGvfhd5BQhGBhO9lG7IWGmcs=;
        b=Tse9IamWnTh1+9KZRLwMLSrznOnFNF5XTM2fL6JXbfBmku5SsC0KD+yD0UZKRHMm8o
         ncUlnGSXHiog++C19YVYcqqwKrrHb4gQvDgA3cKHkf6LfJ7/OIh39rOyQX1hJeqwM8gH
         +iqAsOAzefbHqqU/xo3SZ99qpo6TIFPMRs7jxYTat7nMg3HpzxtaJhdHYQ5wt5w1rkRX
         ghafkRPrKq+uCZvD0Pefx3vCLvyWjt8QrCEniLQtd5/8VG82Y2dAiTt97r+H8TLfdpoZ
         b6Q/AZiqRMWQRCgG2YgNsvaHbkKInKJBU6ytVH/DBRhh2fi5OaUKgOy0K3V0/Yc32hGq
         qYtg==
X-Gm-Message-State: AOJu0YzhAvRVmdu9/xoKAkQ4prKXeFH3l9dRqO2TxiHUD7qrEBtrSijf
	y+d+6g9AgZlAoU1rm4Fg7Rcr3Jybh49maH2wAIzA/HR2k9oNRbeL5Iu6
X-Gm-Gg: Acq92OFDA+uiOhTiaL3GddDY5Aik49gW6PgygWLsDu+xB1Wz0Pw8Yp5W/zwqBEDzOf4
	yh4ZupSuejaXreAvNNGOW9p59Y0bOCEW5BChiA6e77+d0aBzhZgw8U0KkP9ixBaHxQunt+mSP29
	ZC+9GCgBlYLrd+lg/z8ghTzwyD4FuuYWEBZwIKlLKhjghedHE3Oc4btWitvmLkLZk5qElOPtFOb
	4hl6YnjIdMNjt2YYOm3sR7qYg6cy+GTatbbb977VGxIgkgRTC4V1Yt9UBnoM/B4ZTb9S/JAG6QE
	L5lBunUM4OgPCDOQ2y2PV1lGCXYMAPvbUc4LWkMd8XAbFEbJ0GjyBTvT9YYma9Rj68woymq/rm5
	JgdfShYUqE99OOlD30wIkqoz1/bq/vWvmyo8kmYkYmWNykaRUdOj9jMmqmr2dQUZXyn7WI5LzRY
	sCbwOaspkMnjdm7SnPo4MBnpGsqexnihwuTqRJQCCJWJytNZX7sSgr/k7PSjsRTK6IwAJx7XBGK
	wDOyy4LZ5o3X4VTdg==
X-Received: by 2002:a05:690c:c14:b0:7d4:3090:f39 with SMTP id 00721157ae682-7ed11d43754mr165792837b3.42.1780950302145;
        Mon, 08 Jun 2026 13:25:02 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20fa250dsm87973267b3.5.2026.06.08.13.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:25:01 -0700 (PDT)
Date: Mon, 08 Jun 2026 16:25:01 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.cc30d5c2f9ee@gmail.com>
In-Reply-To: <20260608173305.372987-3-kuba@kernel.org>
References: <20260608173305.372987-1-kuba@kernel.org>
 <20260608173305.372987-3-kuba@kernel.org>
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: so_txtime: check IP
 versions
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-296712-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:andrew@lunn.ch,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,lib.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AC74165A75C

Jakub Kicinski wrote:
> This test needs more work, and it fails in non-obvious way
> when IPv4 connectivity is not available:
> 
>   # Exception| CMD[remote]: /tmp/vjquwblf/gukinuzqso_txtime -4 -c mono -t 1780939014114542914 -S None -D None a,0 -r
>   # Exception|   EXIT: -15
> 
> Explicitly check for IPv4 support to make the future triage
> less painful.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

but two comments FYI:

> ---
>  tools/testing/selftests/drivers/net/so_txtime.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/so_txtime.py b/tools/testing/selftests/drivers/net/so_txtime.py
> index ddcd2c0e06a8..8fe061f52055 100755
> --- a/tools/testing/selftests/drivers/net/so_txtime.py
> +++ b/tools/testing/selftests/drivers/net/so_txtime.py
> @@ -64,6 +64,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
>  @ksft_variants(_test_variants_mono())
>  def test_so_txtime_mono(cfg, ipver, args_tx, args_rx):
>      """Run all variants of monotonic (fq) tests."""
> +    cfg.require_ipver(ipver)

This may cause aconflict with my outstanding SO_TXTIME series.
And more importantly miss having it in the new test_so_txtime_fq_tai
variant.

Could this test be moved to test_so_txtime that all of them call?

(there is WIP to add another mono_hw variant too)

>      _qdisc_setup(cfg.ifname, "fq")
>      test_so_txtime(cfg, "mono", ipver, args_tx, args_rx, True)
> 
> @@ -86,6 +87,7 @@ from lib.py import NetDrvEpEnv, bkg, cmd, defer, tc
>  @ksft_variants(_test_variants_etf())
>  def test_so_txtime_etf(cfg, ipver, args_tx, args_rx, expect_fail):
>      """Run all variants of etf tests."""
> +    cfg.require_ipver(ipver)
>      try:
>          _qdisc_setup(cfg.ifname, "etf", "clockid CLOCK_TAI delta 400000")
>      except Exception as e:
> -- 
> 2.54.0
> 



