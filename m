Return-Path: <netdev+bounces-175320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3B0A65149
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA217A166D
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AFA239586;
	Mon, 17 Mar 2025 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="PZesGYZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C306732C8B
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742218585; cv=none; b=N+M5PwpDxDyokDQCTcUhrLPAbQOSCiFqy5XRH4n8YO6fNmPhwnRksqKMaIcRp5b6AZJMcVNcEM5zdv6YHHoNAossgHCPakh0wgNbzB0BjlVH8OGYKc9FCgrY/E5wXkcQfserc6TBIvm49l0iFexWXq4oLucWAbg4Mm4F/JVqpX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742218585; c=relaxed/simple;
	bh=Trb02ucwdNT7njn5fU7IQgeC1x6g8J7T0PM9NITVyU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBz6qIb447WglyZHczwx4Ib1er4PjO97EJcyVgXEWvg8rzOEeyFkDdAijIKOVqDGzv7pfmysXLM1kJEPAX9dyXjQ4WOG70aka0XvUSkagIYNbKcL5Za9jAaebFBxYf97qrtJ+PL9V8Osdfm1N5t21iw+P+61hqy+N28pljjGvFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=PZesGYZL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22409077c06so108206265ad.1
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 06:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1742218583; x=1742823383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+bM9J0DqT2fl7geMphRuEwoWQW8kW6asNpCDgXyvg7U=;
        b=PZesGYZLWG6r3VpIBTT5XAiDbrq8yJUY+xEk3amSGxF+/SQZVpJOWSD9M47AWQ+OiP
         hc+fjsKX//dy2eTAeRdw8RjAJFn8e7sPhGnyvks3YV+9Q3hSZSDUPiTboj1CP8aPiOy2
         Uwn5vpD9/GlqNTvzs1xxSVTcNa/N/L7QWzR3GgnwDpSgfdtBD49SIijh0BBH6BYtk0d7
         3ver5PaGwFjm5YZjtJe80ptV/J0QDwU6h5jlnCHVDytSqpIMSGZyqge8duarZbOa9DZK
         muewJyx3AYQ56F/9ACT24yDHWEnTgJSHSwKsyf7MHztgMWpJDWphPti1Zo2hdFF0gkgp
         hJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742218583; x=1742823383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+bM9J0DqT2fl7geMphRuEwoWQW8kW6asNpCDgXyvg7U=;
        b=bsnTdhd+SvIsZBMVsQZNq2dbN6C0FcISFAxThx6XPr7UvuTyr/QQiSs2lC/0ACXO7K
         BaWK797CBbMNhiNWqrfjZVcFtad7qVL7W2wHAdmfSp4z+3j0I1AZo9XUI6/EaJaQPpD2
         1rRIvC8NkQsohZuS6Dtpdp15lcsCYzoj4fPdi+DYyZ7WKVzT6x0kLN7Q8MoSitpQf+Jy
         l043CFqP2su56R/XEAzrdO850ib3VQzR971K1l9NI+ZMC8iUTrNWzAQoZ3ydxJfdQTwt
         H7mOkUclvIqjdlxqxwZH7GZYSP47oRb9NShp+oovkxi5RgbL+NIZepZYBrFEv4yZk5ww
         xu5Q==
X-Gm-Message-State: AOJu0Yxr8kT0dNvi06ndtdRjQNVCuWW/9hTw3AmD2R87OBbUgTJDWSIB
	ShnIxCF6AnuNbEXnK91/tLBrpoxMkx3DCa4cVWT2fpTGqG+OyI5RkqrG0rJ/Bzs=
X-Gm-Gg: ASbGncsbMFvDiguoQyaOhWvpfs4te9up8C06mU3q2GlMWQH3lGV2krV7Zz6mCSNYQk0
	bxpa4hfU57FE6pS+fscCJlF+AF7mXvmLX58surZ7hWa0pfQwC+2X+shgSTPn8L3PhWUkD0kS7id
	mGUryRUz2yZVw/y0XojInp0QtdUURFx7DmnqMBXo5IelcsMocd4NLRGXW9tATX0aJpwsO7pqfMf
	dhs3d4fitsocpnwPeVDiu66FhjrHidmvuH3aW/v/S3oPrF7cQx6Kivhugkq9bYqzdu8TX2UhPfq
	cLsWJD90c0z09UAS1sNdO/BmayA8iK27uM4eXDkwKFwAjP7F/pqic4TyZMQW8rNCXnseHNDFS83
	sMUoR04uY+o6Yhmbkl/yjFC3gKyUCOvl+
X-Google-Smtp-Source: AGHT+IEl6kJWDflT3Rn8WDp+ZhQkPU3xUJHHdwZaiwpfDRF2sCE9f35xMBvQNtn+dAgTXcRv+AElKw==
X-Received: by 2002:a17:902:e74f:b0:223:26da:4b6f with SMTP id d9443c01a7336-225e0a369b5mr135088635ad.14.1742218583022;
        Mon, 17 Mar 2025 06:36:23 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a403fsm74737375ad.61.2025.03.17.06.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 06:36:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 06:36:20 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
 jhs@mojatatu.com, kuba@kernel.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, andrew+netdev@lunn.ch, donald.hunter@gmail.com,
 ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20250317063620.30d24269@hermes.local>
In-Reply-To: <20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Mar 2025 16:39:17 +0100
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int dualpi2_print_xstats(struct qdisc_util *qu, FILE *f,
> +			    struct rtattr *xstats)
> +{
> +	struct tc_dualpi2_xstats *st;
> +
> +	if (xstats == NULL)
> +		return 0;
> +
> +	if (RTA_PAYLOAD(xstats) < sizeof(*st))
> +		return -1;
> +
> +	st = RTA_DATA(xstats);
> +	fprintf(f, "prob %f delay_c %uus delay_l %uus\n",
> +		(double)st->prob / (double)MAX_PROB, st->delay_c, st->delay_l);
> +	fprintf(f, "pkts_in_c %u pkts_in_l %u maxq %u\n",
> +		st->packets_in_c, st->packets_in_l, st->maxq);
> +	fprintf(f, "ecn_mark %u step_marks %u\n", st->ecn_mark, st->step_marks);
> +	fprintf(f, "credit %d (%c)\n", st->credit, st->credit > 0 ? 'C' : 'L');
> +	fprintf(f, "memory used %u (max %u) of memory limit %u\n",
> +		st->memory_used, st->max_memory_used, st->memory_limit);
> +	return 0;
> +

You should support JSON for the stats as well.

