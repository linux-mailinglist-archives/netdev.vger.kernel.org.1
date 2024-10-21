Return-Path: <netdev+bounces-137668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4E89A93E9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 085031F22BEC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB141FF054;
	Mon, 21 Oct 2024 23:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="bpKHdH/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E2178370
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552094; cv=none; b=rPtoomHOk5jeqYCZ62avS3FSqPM+XdsQipmJOi2u8qz7RVNx/ekUXlM3kraTOlnGzwk+RxcZVgTvKuyY4+COj62IXFY7ZhV8xRG8BmQK50Vacm+tXZCW+Ai4ydoifoFOkmVplbViER8c4Pmls8GtygjhQ9pcAiKLp8/MA0OxF4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552094; c=relaxed/simple;
	bh=7VsCiaagwdVQ2exeamGIggO0xeGFcnO/c/OzThOKTy8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+tvwkuZI8YLf1J7ujAGQYIoC3hBbItnCltgTozI2CM1fK/Tm49U2PhV5gzho6y/UG2YQJDxwc1mzO1B9P1A0NHdxB9DmmxtgMGf4ew8VOpYdnVMbNGsAPO3aSg2VAvDaVxG2wDCjVuKbPY4Nypemm3wLRcamDi431Q1pIOrA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=bpKHdH/V; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so3652751a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1729552091; x=1730156891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mb2CPXxViA84j3LTqIu425gVydhLGifyxw4O8/sIWas=;
        b=bpKHdH/VYSqhsgGj+3qB9wh2+TdnuTQPklRmXCrlehntE2WiBuADacIqyQK4JvE1Je
         Y//CJXNoUzIrPatQ4EmKq87KWsaSo8bg+StdOWATpJKUXTAlODgbTpm4Frp3l6ykosc6
         TmFmYp6xY1LHaEaUGYEyeupxYM2Le0KIN/nSOu5uoBj3+lnlw7+izSizNk4+sVSvR9Th
         Kou9KlGFKLRVclOTCICQBNkAgfnT1R3Zxo9AvVZjTb41UdD1PuLMWnXLuwos+oEKykh3
         Y6N4am9+5WHIqieQmaIz0kVmfu/oPPL+akJTvMBrRF3qDz69mK75AB1/A9Js1l1hUgXZ
         fI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552091; x=1730156891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mb2CPXxViA84j3LTqIu425gVydhLGifyxw4O8/sIWas=;
        b=vC3KJlSfnIG0mV3BG9Qq03PBT3+ddvD0o9ud++EkM94tjOoSZYg/zE4AbqxXySTEPU
         JSwWCWgqjYf8x03PQ6SbX6d5LM8Uk8CwrPhSjsFFDKR+IuGNBux7ajJOetqCRtrtZX5O
         gzNksxe9f0Z8ebEa733ygo6tkPIDnPQlAu0/fqGDNRPuMt36IR5z4xi0y2ScTC7JRpbh
         AtGDrH2m1X8LIM3o3mGpFjXbcJ6N+ob6uw+AY6jRe1+8d5wQNp8iDUs0PKNSwQOEg5ji
         TkhMYHrHSO1Ex9TkluHvkU5v+DK8y08leTFhjJQKH1S8e+4xR3m7QA1CmBxS3WWVtHyq
         HmBA==
X-Gm-Message-State: AOJu0YxuYENCzjKwBHc/Ic1JgMLAGdT7IXUyle9WrsIkLoB1VZqPfp0N
	3+g85ZxrKNY7zSAtPXQAQJsJErBNsqL9Xji61sLB4mLryZK8+HteGxwfeE9w98A=
X-Google-Smtp-Source: AGHT+IH7fgs4eKdLkjGC55WhWWXev45hln4sciP2GvdWJOzN+fLt7DqlJUlAL4mhEhPlmr/bFxLXoQ==
X-Received: by 2002:a17:90a:f2c5:b0:2e0:f81c:731f with SMTP id 98e67ed59e1d1-2e5da699662mr1786222a91.24.1729552091541;
        Mon, 21 Oct 2024 16:08:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad388ef3sm4530460a91.32.2024.10.21.16.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 16:08:11 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:08:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: chia-yu.chang@nokia-bell-labs.com
Cc: netdev@vger.kernel.org, dsahern@gmail.com, davem@davemloft.net,
 jhs@mojatatu.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com, Olga Albisser <olga@albisser.org>, Oliver Tilmans
 <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: Re: [PATCH iproute2-next 1/1] tc: add dualpi2 scheduler module
Message-ID: <20241021160809.089261a9@hermes.local>
In-Reply-To: <20241021221559.60411-2-chia-yu.chang@nokia-bell-labs.com>
References: <20241021221559.60411-1-chia-yu.chang@nokia-bell-labs.com>
	<20241021221559.60411-2-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 00:15:59 +0200
chia-yu.chang@nokia-bell-labs.com wrote:

> +static int get_float(float *val, const char *arg, float min, float max)
> +{
> +	float res;
> +	char *ptr;
> +
> +	if (!arg || !*arg)
> +		return -1;
> +	res = strtof(arg, &ptr);
> +	if (!ptr || ptr == arg || *ptr)
> +		return -1;
> +	if (res < min || res > max)
> +		return -1;
> +	*val = res;
> +	return 0;
> +}
> +

Please put this in lib/utils.c and make it common.
Will need to replace the version in iplink_can.c

