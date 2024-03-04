Return-Path: <netdev+bounces-77069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0D387008C
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 12:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66BF61F26A34
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 11:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B06A3BB32;
	Mon,  4 Mar 2024 11:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdKvmjun"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502453B2AD
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552489; cv=none; b=C/OeS2s0xra7Jbvvl67WWeiXWWmm1JcHMDxlciTVca91zEpJBYNha74wrxMv75vY2l6inoVp6e2hUB1JPGsBqYBzC1ZJPWiT1jwmwikYTHrca9wVEg05p7a7PWGRtZTH3jKUw3IvBCRnx1z2J2VmAkt+fdEKg2nx06JGcQ1Cu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552489; c=relaxed/simple;
	bh=tPMEjKOtbpfGFAy/hwcWoITcY8B0F2U5NNw7bI/rPKM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Vd/yjrNiVcnQJ0J9XUTEpc40a/rWQ1uHlO/ErziNSMa8sjTewioWB0oN0yZhneCnWHsBqgtiOia3W/1Hu1kexUbFV5k6ASSY1MMjrqa22tbqOjkiof1k31f1VxmFyAp3QIbFmhBPggiVwM+mNSAX4x8s4doZjRfPKoCj9sLX3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdKvmjun; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e84e87e6so1473625e9.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709552485; x=1710157285; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOR0m5bW63l3St++QXysSRLBUhnzhEBL2eIQeZXBJtQ=;
        b=CdKvmjunDThrMWm1tJ4sKo5pUoonHfnB7qobyZzDY91VxAYkP7vYp6Br5b6cgF4JB5
         CzidOksf8GmBYyyGB9Lb0i3vM7jvxek31U0vMCAUWhfNon3slZGrxzqNdhWSidSsDDBg
         TcapS2YCj5dvrKZHYtLW23bUOBAxv2wuAVwAqSH51Sv+owo6fAgr2X1Q6dEIw85MCFAb
         S2MSYKn9h0kiSdtQjY0yul9AzXC2FOd+ZR3ey5oYcJqBYSfdmPr1XZlevhaiupny+KiO
         z+H/dwEK1ZEMjfR+hLLNUxXQ1Z+yAs3YvKcJRN6y6uxF9t7Au3ylI3PRtE6DW+2CQZrx
         U3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709552485; x=1710157285;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOR0m5bW63l3St++QXysSRLBUhnzhEBL2eIQeZXBJtQ=;
        b=SD8Rc2T5Bo8Bo5YT7HHFKiqVCswshiYy3PllEAXdxnDK8AM1psVTuQQFDyG1yNeS9C
         qiQCt/Hke7d192ndygZwNto6CDHvGtzytH7xMmlymhXpCxSwQDeP5Ub8lVE5DSCTRoRX
         +PJ8nBIo8+pvAeebwKQ6EOkV40r6wrZvmTED9yFcQ6gOtug7U0hjCBtof0TsP5NjSW5w
         HYNaS4T3gS7a3lM/4r2epXQYrSNbwAjD615TI/MUS90HoRMGhGyejLy7F3C2DXJW4TTA
         DMTIBAy7UL4J6xc8tC+F+Lcobh8LoWVcr2yxThXMyZy/h2kxM+vN40t+XrhW53jOanJH
         EYbg==
X-Forwarded-Encrypted: i=1; AJvYcCWp+mR1AcU/x8jbU0vuefTZ+kFYUop+Tgz0qtn8Qk6U34z2sGar8Xm5vza7ypzeVFH88AFg02zW4zRXKtdJHO1CLYkj/7uZ
X-Gm-Message-State: AOJu0Yx99999RoCePNcj9o8f8Axb5yRHGp+qPbBtW9g1kPsWG4QTX/bE
	Y62YWPDO2Gmc7Q1GWjghi9nakBkaUemvo5jrli31473YNsPUX0gtVqVG3VOT
X-Google-Smtp-Source: AGHT+IFPx30VLYZ6V8MVQyWMuHgIHm0CYOXCQVODngvl41vfcPLYFM8zzOCOmgpSdFHztpSKuoyoPg==
X-Received: by 2002:adf:c98c:0:b0:33c:f9d6:fb20 with SMTP id f12-20020adfc98c000000b0033cf9d6fb20mr6337647wrh.45.1709552485412;
        Mon, 04 Mar 2024 03:41:25 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:29eb:67db:e43b:26b1])
        by smtp.gmail.com with ESMTPSA id ba16-20020a0560001c1000b0033e2355484fsm8238331wrb.37.2024.03.04.03.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:41:24 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 4/4] tools: ynl: add --dbg-small-recv for
 easier kernel testing
In-Reply-To: <20240301230542.116823-5-kuba@kernel.org> (Jakub Kicinski's
	message of "Fri, 1 Mar 2024 15:05:42 -0800")
Date: Mon, 04 Mar 2024 11:26:52 +0000
Message-ID: <m2wmqijkzn.fsf@gmail.com>
References: <20240301230542.116823-1-kuba@kernel.org>
	<20240301230542.116823-5-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Most "production" netlink clients use large buffers to
> make dump efficient, which means that handling of dump
> continuation in the kernel is not very well tested.
>
> Add an option for debugging / testing handling of dumps.
> It enables printing of extra netlink-level debug and
> lowers the recv() buffer size in one go. When used
> without any argument (--dbg-small-recv) it picks
> a very small default (4000), explicit size can be set,
> too (--dbg-small-recv 5000).
>
> Example:
>
> $ ./cli.py [...] --dbg-small-recv
> Recv: read 3712 bytes, 29 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
> Recv: read 3968 bytes, 31 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
> Recv: read 532 bytes, 5 messages
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>  [...]
>    nl_len = 128 (112) nl_flags = 0x0 nl_type = 19
>    nl_len = 20 (4) nl_flags = 0x2 nl_type = 3
>
> (the [...] are edits to shorten the commit message).
>
> Note that the first message of the dump is sized conservatively
> by the kernel.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/net/ynl/cli.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
> index 0f8239979670..e8a65fbc3698 100755
> --- a/tools/net/ynl/cli.py
> +++ b/tools/net/ynl/cli.py
> @@ -38,6 +38,8 @@ from lib import YnlFamily, Netlink
>                          const=Netlink.NLM_F_APPEND)
>      parser.add_argument('--process-unknown', action=argparse.BooleanOptionalAction)
>      parser.add_argument('--output-json', action='store_true')
> +    parser.add_argument('--dbg-small-recv', default=0, const=4000,
> +                        action='store', nargs='?', type=int)

This breaks ynl if you don't use '--dbg-small-recv', it passes 0 which
fails the _recv_size check.

>      args = parser.parse_args()
>  
>      def output(msg):
> @@ -53,7 +55,10 @@ from lib import YnlFamily, Netlink
>      if args.json_text:
>          attrs = json.loads(args.json_text)
>  
> -    ynl = YnlFamily(args.spec, args.schema, args.process_unknown)
> +    ynl = YnlFamily(args.spec, args.schema, args.process_unknown,
> +                    recv_size=args.dbg_small_recv)
> +    if args.dbg_small_recv:
> +        ynl.set_recv_dbg(True)
>  
>      if args.ntf:
>          ynl.ntf_subscribe(args.ntf)

