Return-Path: <netdev+bounces-248249-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF11D05B55
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 20:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79F63301CA00
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 19:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2792B314A6C;
	Thu,  8 Jan 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnV4XboG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CFE2882B7
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898940; cv=none; b=V4j79sKcF7Tzfp0QndVkYXpCyGXifWzUsBm7UuqUSijBl+SJ+SVDuXWkLhtVc1heaWQyS61KSbN68/cDGxPuhrA5sL+hkHKHiaWEz/xHz28nTvh3SkJFX5m9JucO1ZgFvfNuj1I76AjuttuhgAEutvabDw4VEOmCoBgoqRJgKRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898940; c=relaxed/simple;
	bh=K2LW6sotoVOT7QIZVrqOf906H98OP4kg4/+B/vAo/IM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nTnhtogGwxoDaX1rfdKkYW3Ad5vCvLUSFuF9g0aNfEW1+ExmJzVg2aytyF+iD4lqlK0ePocLLobsBOqjPQhTo+D6XafsSoeyabJj05MVlVl0qmcbnPzFZXFGxPffdyLi56kxm6mkrbrDdOAeTkLh+tmw85y5OG9TlZA76yDxteQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnV4XboG; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc7892214so41716517b3.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 11:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767898937; x=1768503737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmyELOaSZADXI222ZY+oX6FK9Sc9qHdBAIkmig6ymHE=;
        b=hnV4XboG/4j2lFt5VZkbucBezm4cUKFcj+punkbFiHpzG5GKKHzybREq5of2FSLDTm
         1IN2IS3wVW7B9vQ48Uq81iHZMrfjpJxLCxcnkdamW1Rpsz9FnLtDa3WJlUFYAmb6RmqW
         lRGRGPaCA5o07ji2qEZM8uhJdFbp8FxAJoHMlfJ+cuRjvLqGZ1uMQM5sNOCUMCWnsLYP
         wjM+Jl0c9Q1Q0c75s0iq1QWQJtePn4tfFFn2vFQBwyy1EryCilpKZngx92arvLhy+3Kt
         05RUaQdo7q0DiembdTDY74BUX0KQweo4OXW3GJb8B1grp2zA73JuQNlyoPKwuWlxLqcB
         D/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767898937; x=1768503737;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nmyELOaSZADXI222ZY+oX6FK9Sc9qHdBAIkmig6ymHE=;
        b=Dqu9285uGa37iLtQaXrBGbE6Pz/venWLufv4golIYT2iK/Hf3NiO8nOLogpo3N3roM
         yvJlI4mXSlXVCY7B5KnyC7sEIjGxK/nSQ5NX4tkLgdHF4dpYUIA2B135am3zeeU84tx8
         v9VEn0te1pq55AyMOoTLSDKrh8k0n/15RQgT+UvgJDPu2z3pDriv+Pwq8N6UGiqDkdFd
         PbYAZJMqgLRfzC8uhigeRDRQ0Ui7tlHe/3O0bJu/4NKlVDlIuhthBHpkzsDmwZu/B3IV
         40D3roxpAG/2WmOCNta1bcnR0cARYU9w+AR7bgm8b7ip8OPw/vobN0VuudohR0pByGaZ
         Jx7A==
X-Forwarded-Encrypted: i=1; AJvYcCVwC+xkVU3gvaCN3lgUsDa2Fy3odZMh1QRTaxSKPVzXwFudpU2n2eoJWKwQ5KrVoiUjVR4HZfo=@vger.kernel.org
X-Gm-Message-State: AOJu0YysmNAGKZZdhvVpK1x0g965eQkt/uV67Z7FuIV53TRum0sw8q8G
	m+f8yGYDa+bQdIlGDj9HSrrAG/NBzmkwnv2hMhygjiHPljQL01SGsAdl
X-Gm-Gg: AY/fxX5TRmIZlu+R3fEpPV+o2nfUpiTpC1ecTdV4eHE9htOMuqWxxg0Cqfmjo8aJUhh
	WW9EjrqILHSO68FHRLEPPkMDeMNVwvMoWrdQQBCTyGBgiOuy9GNFjGmYm3pmOR+cGsgusG0JVSG
	UbFQ0WCffQKHT2Uxsdu+nro9R7+3vsjgsSqtV60RNv/4Cp7r4SXQwCI/Ta0ifX82EiIdPebo7D9
	k0zPapVWjIX4OoYw/iZz4NujlJo6ZmiK5Rln01W/9JMjIyv4KhExkv2XADs0aXgJORTdGI4/lco
	BDQx7LUoCrD9CZJ7eE1iwIUX2yGTG7B6FfPhgaQhdffurh4+7qa313pHLljtC1JeZqI38AZgUOU
	vzyAi5X1Pw6c1ZOKqfF1ovG88uKB9i/zOd8+9VhA5CVrIk9UK4YhEIHYIoHA8Rjrr5sJXbhJXAS
	KsHeyMODqdz4/vt2XakrtKf1au61zbiDgbIVwgQ6g/wBAcFYO19qvkrqbd90o=
X-Google-Smtp-Source: AGHT+IH5TaDYP6X1kkJaAPJeZNhAuOn1s7Vher4mhni2y+Zy4W9mvbfIbaAIpbkb8246LikCcU/sVg==
X-Received: by 2002:a05:690e:1289:b0:641:f5bc:69a0 with SMTP id 956f58d0204a3-64716c9392amr6445805d50.78.1767898936103;
        Thu, 08 Jan 2026 11:02:16 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d80d2c2sm3673670d50.8.2026.01.08.11.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 11:02:15 -0800 (PST)
Date: Thu, 08 Jan 2026 14:02:15 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.58a32e438c@gmail.com>
In-Reply-To: <20260108080646.14fb7d95@kernel.org>
References: <20260107110521.1aab55e9@kernel.org>
 <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
 <20260107192511.23d8e404@kernel.org>
 <20260108080646.14fb7d95@kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
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
> On Wed, 7 Jan 2026 19:25:11 -0800 Jakub Kicinski wrote:
> > On Wed, 07 Jan 2026 19:19:53 -0500 Willem de Bruijn wrote:
> > > 17 out of 20 happen in the first SND-USR calculation.
> > > One representative example:
> > > 
> > >     # 7.11 [+0.00] test SND
> > >     # 7.11 [+0.00]     USR: 1767443466 s 155019 us (seq=0, len=0)
> > >     # 7.19 [+0.08] ERROR: 18600 us expected between 10000 and 18000
> > >     # 7.19 [+0.00]     SND: 1767443466 s 173619 us (seq=0, len=10)  (USR +18599 us)
> > >     # 7.20 [+0.00]     USR: 1767443466 s 243683 us (seq=0, len=0)
> > >     # 7.27 [+0.07]     SND: 1767443466 s 253690 us (seq=1, len=10)  (USR +10006 us)
> > >     # 7.27 [+0.00]     USR: 1767443466 s 323746 us (seq=0, len=0)
> > >     # 7.35 [+0.08]     SND: 1767443466 s 333752 us (seq=2, len=10)  (USR +10006 us)
> > >     # 7.35 [+0.00]     USR: 1767443466 s 403811 us (seq=0, len=0)
> > >     # 7.43 [+0.08]     SND: 1767443466 s 413817 us (seq=3, len=10)  (USR +10006 us)
> > >     # 7.43 [+0.00]     USR-SND: count=4, avg=12154 us, min=10006 us, max=18599 us  
> > 
> > Hm, that's the first kernel timestamp vs the timestamp in user space?
> > I wonder if we could catch this by re-taking the user stamp after
> > sendmsg() returns, if >1msec elapsed something is probably wrong 
> > (we got scheduled out before having a chance to complete the send?)
> 
> How about:
> 
> diff --git a/tools/testing/selftests/net/txtimestamp.c b/tools/testing/selftests/net/txtimestamp.c
> index 4b4bbc2ce5c9..abcec47ec2e6 100644
> --- a/tools/testing/selftests/net/txtimestamp.c
> +++ b/tools/testing/selftests/net/txtimestamp.c
> @@ -215,6 +215,24 @@ static void print_timestamp_usr(void)
>  	__print_timestamp("  USR", &ts_usr, 0, 0);
>  }
>  
> +static void check_timestamp_usr(void)
> +{
> +	long long unsigned ts_delta_usec;
> +	struct timespec now;
> +
> +	if (clock_gettime(CLOCK_REALTIME, &now))
> +		error(1, errno, "clock_gettime");
> +
> +	ts_delta_usec = timespec_to_ns64(&now) - timespec_to_ns64(&ts_usr);
> +	ts_delta_usec /= 1000;
> +	if (ts_delta_usec > cfg_delay_tolerance_usec / 2) {
> +		cfg_delay_tolerance_usec =
> +			ts_delta_usec + cfg_delay_tolerance_usec / 2;
> +		fprintf(stderr, "WARN: sendmsg() took %llu us, increasing delay tolerance to %d us\n",
> +			ts_delta_usec, cfg_delay_tolerance_usec);
> +	}
> +}
> +
>  static void print_timestamp(struct scm_timestamping *tss, int tstype,
>  			    int tskey, int payload_len)
>  {
> @@ -678,6 +696,8 @@ static void do_test(int family, unsigned int report_opt)
>  		if (val != total_len)
>  			error(1, errno, "send");
>  
> +		check_timestamp_usr();
> +
>  		/* wait for all errors to be queued, else ACKs arrive OOO */
>  		if (cfg_sleep_usec)
>  			usleep(cfg_sleep_usec);
> -- 
> 2.52.0

Increasing tolerance should work.

The current values are pragmatic choices to be so low as to minimize
total test runtime, but high enough to avoid flakes. Well..

If increasing tolerance, we also need to increase the time the test
waits for all notifications to arrive, cfg_sleep_usec.

Since the majority of errors happen on the first measurement, I was
thinking of a different approach of just taking that as a warm up
measurement.

But I'd also like to poke some more to understand what makes that
run stand out.



