Return-Path: <netdev+bounces-108508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E961924082
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8DD51F22D71
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211516B74B;
	Tue,  2 Jul 2024 14:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YmFU53M8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B6BE7F
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930122; cv=none; b=DqiNurq5Z1tO7asJqIjiOh99x3jdzqztq07AD/1FJ5gCrfefnH1+sGKPTnwDlszcBO+T7nxPlCKKnyNfvpufDIwPECaX2hvBnDGo1Vz0YfXO4gBeM+FU/HADP4CAuvur+vqx63OtlwZKXZlkJYRS9/Nm3HDwhR4dkh8Mwci18mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930122; c=relaxed/simple;
	bh=T+Fae+3X94waDimcwVSB4qnzYUiIOYtl5PdjimKgDFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LST2SPTe9t/TPoeKgCrAlDleZuTUBl+bv8YzO9cGNsNoUkIPwhg052bAV+Rk06BP0Kl2JVG4baQKSXt/9JZhV2M6h0FJ2nzL2vGdSw3XuyaU76Dt37LyBj+eBO1OD6Kvk0J8BugE0KN/UJxkxQ3cAqirkm7tMWaELiDPYY36W38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YmFU53M8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58bac81f419so952600a12.0
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 07:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719930119; x=1720534919; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh5Y1zlPh20F9HNcI//rLbS3bZ/uF1AQxw5RRlsXpLg=;
        b=YmFU53M85I+ptyUyx3nwzqlkCGK6sV4smuj+BUs663gnCJmD/cN6blBDjW9iIsAz/j
         aqewtxlInAcwbIbzQV8FyPgY0FZqNtb5vyR5U7n2MSLeFyBIfjmw7+JzkOkxqka0u3Jo
         f3UA5NJdfwurG03wbaiYDwKl/LLhRCLIXo/7540wQF8rJ/ZEZ5v2J6lWEuVYv4VgKFnd
         eCAAWMavEV9NhUg8F33LI3KXBEqxMucrT/n0duDXRXmiHakp84cqkUKlIpWfOoqmuATy
         kQRRssDGEuMHHxI2JuPq+oSvRceVBbn9j6itaKPIPF3A6BqtqaAqpXg2C/TdJH1Z68b4
         y2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930119; x=1720534919;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sh5Y1zlPh20F9HNcI//rLbS3bZ/uF1AQxw5RRlsXpLg=;
        b=U7uWNN/e9OwIYUSOz7tfc78gB/AiqL3hRl2gzlqG1nTNuk8v5VrLN9fEIOPz6w2Iey
         1WIbdiynhT99jO5xiL4JgaqIg1/bC2VC1bGsfzOUYowgKettX8lhvm637Yk+OIFa/31V
         QwGsM48LkB557egU4RapuzE4kLGuJRZjFaPDUXidHzc0+dV76ejBMPdvIGwkunYUSIYa
         FSSBd1l1rDacfAT3NQVqdWu7RfHfnBg4MIwgopfYX3iQnI8JonSMnXiuaRLSjd3XuV6h
         jmn9miT4cYXHAbzqaOoveI6u5eUWfezOoZLWkRZanJlaqTeiTltXNArYX5OjoSsfZ9fW
         dQTQ==
X-Gm-Message-State: AOJu0YwfMtFoTs5pmQw89R3vGtTpeRLxPtLOZdhkkz+y+IjEHEnRzj2V
	nWxrl856sD+CHldoyTDK6swCHVVwL7fv+G+cBq83EpIicx1iyjrq7UlQpYDbMfc=
X-Google-Smtp-Source: AGHT+IHXxSgIkS5wouN8GAL8HbfDjWiSaFMDE+52DBgN+3kHTC2UfuMH69aQvKmrac9tIMDMqFHUWg==
X-Received: by 2002:a05:6402:430b:b0:57c:74ea:8d24 with SMTP id 4fb4d7f45d1cf-5879f59c5b7mr5640005a12.18.1719930118201;
        Tue, 02 Jul 2024 07:21:58 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:1c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58613815dd7sm5763672a12.43.2024.07.02.07.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:21:57 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [FYI] Input route ref count underflow since probably 6.6.22
In-Reply-To: <20240701163826.76558147@kernel.org> (Jakub Kicinski's message of
	"Mon, 1 Jul 2024 16:38:26 -0700")
References: <87ikxtfhky.fsf@cloudflare.com>
	<20240701163826.76558147@kernel.org>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Tue, 02 Jul 2024 16:21:56 +0200
Message-ID: <87wmm3euwr.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 01, 2024 at 04:38 PM -07, Jakub Kicinski wrote:
> On Fri, 28 Jun 2024 13:10:53 +0200 Jakub Sitnicki wrote:
>> We've observed an unbalanced dst_release() on an input route in v6.6.y.
>> First noticed in 6.6.22. Or at least that is how far back our logs go.
>> 
>> We have just started looking into it and don't have much context yet,
>> except that:
>> 
>> 1. the issue is architecture agnostic, seen both on x86_64 and arm64;
>> 2. the backtrace, we realize, doesn't point to the source of problem,
>>    it's just where the ref count underflow manifests itself;
>> 3. while have out-of-tree modules, they are for the crypto subsystem.
>> 
>> We will follow up as we collect more info on this, but we would
>> appreciate any hints or pointers to potential suspects, if anything
>> comes to mind.
>
> Hi! Luck would have it the same crash landed on my desk.
> Did you manage to narrow it down?

Nothing yet. Will keep you posted.

