Return-Path: <netdev+bounces-121822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DA95ED3F
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 11:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDB5A281AE8
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 09:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018E146019;
	Mon, 26 Aug 2024 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="3AZBDtI0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E17613D297
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724664690; cv=none; b=osYiJN40HuGW/dKcsjqQfL7fUnZbnNgqAE2ttMHYPwW+WghwkC6MwQwa8rmVU1Tae/jRkmyTTi5JdxE5g9p0gbZnohib3UDVnnvoV6egYIombG2Xivg/SfWD3SIfmQc1/5Aq8d6Vhka1vlYUwdRmM1HggDbosB7qOytA35hfbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724664690; c=relaxed/simple;
	bh=8R8A7D+8jWmGEOdpPm8RGzl8S/henhOhKGKZ0paQ5w4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY00Jb6qLlNz/fLWplh2or5GvyAiD/LR04w0mNRIxizG2cQZhZVQt5vMeKLJRhGjCWeEv4B0vtURngBdxjRPkBV366d8H01/gDruCAmrZ8/MQ4mom7sjvtcelqWLVyyK6GvOp2fkKid7RNorDizTQ2ITcFKL076GWVb1WIUezd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=3AZBDtI0; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a86cc0d10aaso107525766b.2
        for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 02:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724664686; x=1725269486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nVCsxlno+YktAicKgTJtnrnnbALEmyZyk9gDmn8un9c=;
        b=3AZBDtI0jGeXW2si+fwsdIQnFZJnR4C7K82NFO84JQ+7MIhB9MgH7/gdrLjtDBGzS9
         ItruwUorUcj/7L5T3xaYtv1l4zegNC/I6U6op9NDeh+5opQT3wOl27sN2NPpHw8hcllf
         Pa2IKWG7B6jjSln0c3uqYYHC8IMjoFVFI+qUZOYy0bBlnjD6qWwXsymjYD2dfnc9VM+V
         04yfc8YFso/cVIJInTzCtLyshAdNP1MpZeJE7DOKiQ8Pk1THJikg8LAR6G+6Xb1IyVU0
         KcIHfoACnWXDxnf4tAyXG7sT+v+lb0Xoydkuc2FA2qWqr5qQ0fYvwNSSgGWkwNWNU8eU
         gjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724664686; x=1725269486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVCsxlno+YktAicKgTJtnrnnbALEmyZyk9gDmn8un9c=;
        b=e14l+m8sGtkpOGaUUDOuCCPBa79IuSjU0jNfhxLMo4WgFwf19HyDGek/Vaj1S6duz2
         AgMdqfZ9g9qeTa/O2rWkemsE6GtznnmuEfbJk9vP7Q839Zt/Y2c5mqagE+vW9VsyMhte
         7rat4Kkxy2v0hahdEPr7WboDCuamWmAbgobXhm9n4J5yNvSTJVrzQ+rlJRM0NCLTpOex
         XacJsu0NYHqFWVQ5Sc2tOp/9Kp3ywWJaUmnDRutocR3OErD8RdMr/c2pjwrC2/N4r1ZC
         rSgMgEyrznIIYnTIBZAm762f4a43y7fd/3/AXJruoae44M4kEekwrpAV8VXaWYtAfSpm
         bQ9w==
X-Forwarded-Encrypted: i=1; AJvYcCV95y1zAY6P81qEthj2ItXzIataNz1m5pGi5v3OoeUYBBRSIh66nQ7s9fGVETdv1snT5OHzLvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztDwXGMSTo+XDiQUBuZ/MM7ch5Gvj2TwcJzjgUcROT5pPQeDW9
	P1przwJDbKhciTpQSsHMjBDwvhj2q510BAmze1mASt4HX1vDEoUWYiZ8//jbPKM=
X-Google-Smtp-Source: AGHT+IFC0FggWceB0e+b0mfMsaVrc9aANMqizPSn+FRLaaBIGtpjtNSJHD8ZDBvGO9fR13y0C/GRVA==
X-Received: by 2002:a17:907:c0f:b0:a86:c111:cc35 with SMTP id a640c23a62f3a-a86c111cfb5mr335672066b.50.1724664685912;
        Mon, 26 Aug 2024 02:31:25 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f220dbesm633232066b.27.2024.08.26.02.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 02:31:25 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:31:23 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <ZsxLa0Ut7bWc0OmQ@nanopsycho.orion>
References: <ZsMyI0UOn4o7OfBj@nanopsycho.orion>
 <47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
 <Zsco7hs_XWTb3htS@nanopsycho.orion>
 <20240822074112.709f769e@kernel.org>
 <cc41bdf9-f7b6-4b5c-81ad-53230206aa57@redhat.com>
 <20240822155608.3034af6c@kernel.org>
 <Zsh3ecwUICabLyHV@nanopsycho.orion>
 <c7e0547b-a1e4-4e47-b7ec-010aa92fbc3a@redhat.com>
 <ZsiQSfTNr5G0MA58@nanopsycho.orion>
 <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a15acdf5-a551-4fb2-9118-770c37b47be6@redhat.com>

Fri, Aug 23, 2024 at 04:23:30PM CEST, pabeni@redhat.com wrote:
>On 8/23/24 15:36, Jiri Pirko wrote:
>> Fri, Aug 23, 2024 at 02:58:27PM CEST, pabeni@redhat.com wrote:
>> > I personally think it would be much cleaner to have 2 separate set of
>> > operations, with exactly the same semantic and argument list, except for the
>> > first argument (struct net_device or struct devlink).
>> 
>> I think it is totally subjective. You like something, I like something
>> else. Both works. The amount of duplicity and need to change same
>> things on multiple places in case of bugfixes and extensions is what I
>> dislike on the 2 separate sets.
>
>My guestimate is that the amount of deltas caused by bugfixes and extensions
>will be much different in practice with the two approaches.
>
>I guess that even with the net_shaper_ops between devlink and net_device,
>there will be different callbacks implementation for devlink and net_device,
>right?
>
>If so, the differentiated operation list between devlink and net_device will
>trade a:
>
>{
>	struct {net_device, netlink} =
>net_shaper_binding_{netdevice_netlink}(binding);
>
>preamble in every callback of every driver for a single additional operations
>set definition.

So?

>
>It will at least scale better with the number of driver implementing the
>interface.
>
>> Plus, there might be another binding in
>> the future, will you copy the ops struct again then?
>
>Yes. Same reasons of the above.

What's stopping anyone from diverging these 2-n sets? I mean, the whole
purpose it unification and finding common ground. Once you have ops
duplicated, sooner then later someone does change in A but ignore B.
Having the  "preamble" in every callback seems like very good tradeoff
to prevent this scenario.



>
>> > The driver implementation could still de-duplicate a lot of code, as far as
>> > the shaper-related arguments are the same.
>> > 
>> > Side note, if the intention is to allow the user to touch/modify the
>> > queue-level and queue-group-level shapers via the devlink object? if that is
>> > the intention, we will need to drop the shaper cache and (re-)introduce a
>> > get() callback, as the same shaper could be reached via multiple
>> > binding/handle pairs and the core will not know all of such pairs for a given
>> > shaper.
>> 
>> That is a good question, I don't know. But gut feeling is "no".
>
>Well, at least that is not in the direction of unlimited amount of additional
>time and pain ;)
>
>Thanks,
>
>Paolo
>

