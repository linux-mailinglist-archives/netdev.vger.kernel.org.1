Return-Path: <netdev+bounces-238933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C763C612A3
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 11:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5BFB4E15C5
	for <lists+netdev@lfdr.de>; Sun, 16 Nov 2025 10:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6B428726D;
	Sun, 16 Nov 2025 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clc8Vcb4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD92287247
	for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 10:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763289550; cv=none; b=a3m4YHnFuvzAcknAru41dAB8UitU/B9cXTHLhAM+OTpERoSNvd56eySuZKOADXDM2bnVA4vxaOqMWm3NBslTnPktYzd1Na/HNYMPj/n+fT4U61E7rytHABXGIDmYjK5d/bG6O/WYopqDYOOpgRYTBStaE4O/nAWXQM2HhJyYF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763289550; c=relaxed/simple;
	bh=GLu8tixulGCYUr++wwcxFS4TacKRbYjw3z/oYWIN8Cs=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gos9U66RCBTHticelWUN964YMb98v82jfh0fQfVnYYW0R4hpohWvZjQv2iL4EyYO66QnuJQrBu22B+1K1TjPkKqH4pHw4yEHwMf8j6sjoV2NO0GhK3EeARz2I9644IBMXvPbIDMvyTjvY+lw12oTCXZobRVLrj8URtF/dJbB1YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clc8Vcb4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47796a837c7so6086845e9.0
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 02:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763289546; x=1763894346; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJwzh5Y/g6bZI+8Nk5SBQwiUW6NYc5a2lPhVAk2d2RY=;
        b=clc8Vcb4CWU/Z4W8xIhbhyjdf2liJrylWg74h3ozRPll7lR/WuNpVh6Cf66db7hARs
         Ja2Nm5GhSeXUm57CQW3mAlbbJEKlEnAVqRDIue/UMesUkee9LYk81GCC2uAJJheWyIZU
         6qb0ebFvvsP7acbrQ4IHfy4R0ujDkHSHg/Arh8ZLIfGUlhtVLDkuucz/Pn0vVKAogT3T
         MAF+FgI1HYoOLip20WIsWv+q8n6M5ltXIcL8vRrRzSwF6HczKt0ZCVas/6VoYSKRc5kO
         xZHJ+vY9uiBZ2xb1iFjX1J5yQSVhrWGiY+Q0GKCVZ3L+yCdH/PtitfuTfkW22LxPTuCb
         /OGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763289546; x=1763894346;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJwzh5Y/g6bZI+8Nk5SBQwiUW6NYc5a2lPhVAk2d2RY=;
        b=Em/uFpZ2pjL6FqZoAqsuYLpU1F+bRFkXLkn4LWGPhp2YY+M32x/8Q0tW52BH8uDj9l
         V4LNdCd46Vnq3sgMVZtTK0eDi1PRdakRzEbf285TTxe/ZMhj/Ys+a9l6yxbCR+CeXR3E
         JhkmpqSKgAsTMSUr7lvyeIjIOHUsKCqiwRtsR/y3Zgrg2OMkIROti8Bhhjohr1gAJ/jc
         VGtKKxhnoCez/t7+pXThR4jb4hDUaDelvVpcSvSGGn1ghCkZurJjY3OO3BVhsDBwhM13
         HTDH9IlsnFAf56HtaiEMCeXVmAAtzWbxILaE//DmUm2q8hUX7ku7Q+T6gFDXXejnfiO7
         0Qww==
X-Forwarded-Encrypted: i=1; AJvYcCUzXqkmjkApHbroFRIBp54JpCNZKBwMUcCkSdfvnFrwRsgks2EV64OTTwW0rMTTCTEVQ5BCUhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd4FUIZIwxP5J0X1TEK1HrqoUrHSwzfFmG2zWBEEfXP4LbrpZy
	CnQe16IrDZjj8Fyu0WzRDG/wf9byukAbR15quzggt1n3HZ4kPmPaPZhP
X-Gm-Gg: ASbGncuTR5384kadJ27+bJVNym5+H6pM+zd/27sxWDZzYu9Wsj4zz7aHQi5j3eeVDqC
	jEFa5iqrqEMGn3S4Tm1IzEqEuYW07mCK6CBQRDlbcwvtdNXKnNghkJLUVZxAHCRZ027/RerfGHQ
	eRotGsq2Iouyd2M5ZJJN5bLFDbIPmRPc8Xok/PXk3DylVqTOqO8wXPcqF+NfmaomKn61Uo/9Jp+
	0UooOGkWdLIMv4CcZnTM63WfjMqWSmDZGw0r3WywTTYwiwsg/8Cl/RsECZmseQikz/KIhWpUH24
	0q7YfWjCy36JQCh3BP8w4/Prn8APouT6vDc4MtRrt+f/Ztjo910bR7jbSFwNlq2POA6Y4Q6oK5B
	4HOMFsy2mApjAsRxrzYZEMROeKwnRDQ0pelBDF/yo91w8k7RasWZLuNHLTBIjOOX3hcgndzcsv5
	cvqwLxL1l3XrUuuv7hOi3oyjU=
X-Google-Smtp-Source: AGHT+IFtm3BRM5XUFHjGSH1Q30u2ymYB7lb6vXX/UKKqXFNXoSITZUZCUbd7N1CpD7RE42rndkZvSA==
X-Received: by 2002:a05:600c:4695:b0:477:63b4:ef7a with SMTP id 5b1f17b1804b1-4778feaa8a1mr68666595e9.20.1763289546238;
        Sun, 16 Nov 2025 02:39:06 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:adf2:6bca:3da5:f30d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb454a6sm89259555e9.2.2025.11.16.02.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 02:39:05 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>,  netdev@vger.kernel.org,  Jakub
 Kicinski <kuba@kernel.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Jan Stancek <jstancek@redhat.com>,
  =?utf-8?Q?Asbj=C3=B8rn?= Sloth =?utf-8?Q?T=C3=B8nnesen?=
 <ast@fiberby.net>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Ido Schimmel <idosch@nvidia.com>,  Guillaume Nault
 <gnault@redhat.com>,  Sabrina Dubroca <sd@queasysnail.net>,  Petr Machata
 <petrm@nvidia.com>
Subject: Re: [PATCHv4 net-next 3/3] tools: ynl: add YNL test framework
In-Reply-To: <3f3ecb14-88ce-4de3-91b7-d1b84867c182@kernel.org>
Date: Sun, 16 Nov 2025 10:38:30 +0000
Message-ID: <m2cy5inty1.fsf@gmail.com>
References: <20251114034651.22741-1-liuhangbin@gmail.com>
	<20251114034651.22741-4-liuhangbin@gmail.com>
	<m2pl9komz5.fsf@gmail.com>
	<3f3ecb14-88ce-4de3-91b7-d1b84867c182@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Matthieu Baerts <matttbe@kernel.org> writes:

> Hi Donald,
>
> On 14/11/2025 12:46, Donald Hunter wrote:
>> Hangbin Liu <liuhangbin@gmail.com> writes:
>>>
>>> +cleanup() {
>>> +	if [[ -n "$testns" ]]; then
>>> +		ip netns exec "$testns" bash -c "echo $NSIM_ID > /sys/bus/netdevsim/del_device" 2>/dev/null || true
>>> +		ip netns del "$testns" 2>/dev/null || true
>>> +	fi
>>> +}
>>> +
>>> +# Check if ynl command is available
>>> +if ! command -v $ynl &>/dev/null && [[ ! -x $ynl ]]; then
>>> +	ktap_skip_all "ynl command not found: $ynl"
>>> +	exit "$KSFT_SKIP"
>>> +fi
>>> +
>>> +trap cleanup EXIT
>>> +
>>> +ktap_print_header
>>> +ktap_set_plan 9>> +setup
>>> +
>>> +# Run all tests
>>> +cli_list_families
>>> +cli_netdev_ops
>>> +cli_ethtool_ops
>>> +cli_rt_route_ops
>>> +cli_rt_addr_ops
>>> +cli_rt_link_ops
>>> +cli_rt_neigh_ops
>>> +cli_rt_rule_ops
>>> +cli_nlctrl_ops
>>> +
>>> +ktap_finished
>> 
>> minor nit: ktap_finished should probably be in the 'cleanup' trap handler
>
> @Donald: I don't think 'ktap_finished' should be called there: in case
> of errors with an early exit during the setup phase, the two scripts
> will call 'ktap_skip_all', then 'exit "$KSFT_SKIP"'. If 'ktap_finished'
> is called in the 'cleanup' trap, it will print a total with everything
> set to 0 and call 'exit' again with other values (and no effects). So I
> think it is not supposed to be called from the exit trap.

Okay, fair. I thought the goal was to always output totals. Looking at
ktap_helpers.sh I see that it can't output a meaningful skip count for
the skip_call case.

>
> Cheers,
> Matt

