Return-Path: <netdev+bounces-212400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01910B1FE65
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 06:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0401884A67
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 04:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EA1223DEF;
	Mon, 11 Aug 2025 04:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="n8y9zil4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EBD25FA2D
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 04:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754887494; cv=none; b=CwJ/ssSUae+oh9iRiafVgnbK/RGLrQyNMQgEubVdNHUZACBVYD0EI0dn/1TfCmpZoToLowAo+myBSaOJaOJnTml4p0As2n+2PBqo/IIUNdp0cENgGyKqdBdZ0ZvmsyrPdYTC7CxJI2tnRoAo5W6Nr8gTb5NWzgK64ILBlGY31js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754887494; c=relaxed/simple;
	bh=T9UkihnDy+98RDfV4wMDE1QweH3DYDCzusIHpTj2lEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7cyOGSyKhh4HuJtlhpHkw28xj33EuPYNa4Sf0RXnl7Y1czcZ+9A2vsa65duCS2T///0SSj36q77pl9S9ltVqBiVlLUgKLfLBiIimgi0zjtFD9MKHR5eAIp+PPI43LDRpvsr21IaTYYRlZF06RniI1UB9DJLh5H1WnXqT7AayLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=n8y9zil4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-31eb75f4ce1so3454878a91.3
        for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 21:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1754887488; x=1755492288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbEbB38y0pXQUjxPGtKCqiGMLULZwBxDGSM7ItlfEVg=;
        b=n8y9zil4r9TeF1OZLUbY5mS6vzFywn89nsa9g+nT6Dya45J6UFTzoQMlttZ/g248ci
         wOVp3ZMqwMNf0HgXLIX1BorStoExIRTg4tko+S2XEU2RizSh/s5s6nIk7wEaT9BFTPaX
         Pt0nnVy8FsRKG8kBPn1os4EQpHR0mJpd8TtgAPQRgpDcUVK/aQSCbgpajnfIQ3uhKnGc
         FkfVTsAhbq4IDkc5tDy3Y5X0oJH58QW9IOdUz3yb0a2q7IMVSH4IGsXtIyeS3LtFHa51
         3YgOhBczcUKd19STHCWmSRMIEOGAGrTCGYjhw4RjfTt67Do5+GEUnHaPyR6XKfA2a0Im
         WKtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754887488; x=1755492288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cbEbB38y0pXQUjxPGtKCqiGMLULZwBxDGSM7ItlfEVg=;
        b=w+9ufTEFp0FicIrno4Im5yHEZKOYiI6oHUCgufB7BWf8HA74nNspatVU4hwUOkZCUZ
         Ocj9d9By1I1j0Ac06QkwVsKu5cVKKgEzW9FDqrKlZ1e8ACrT1/GUB/29QZcFjA0YL4SR
         jw+32pay7wFVZMHpISUYjGHmwyJiDwOSfJSNx2YlHSQram4YxFcOGHt8LwuTDTG+yoHF
         ptOI0S2M5G5hgADK40d23K6nF6FRAzxej/X7CtAX9vazpM5D2hvtjMSmAFjt9y9o8bG4
         tZ7tIZHW7ymbb1sXhn6cQdPm7ESIDURUvJ0gDvHdpqFqwERJepnfZyPt/mIlW9JsMH4X
         Wm/A==
X-Gm-Message-State: AOJu0YzrWXri8oEOGq9EsT17pq0UiCdcOPq+H1L1BrjCiHHQnX1RuQjZ
	tpmOYP8/audgzMdW6kE437Ps32lUYxxDCMkYlY27NgvChdEtpkdqXzPF+Y1ItvYphUWnWdqtKkF
	smVy2A25u6nr4Ac5FnLr+WJqR/lcDh7qqXusB6+FZ
X-Gm-Gg: ASbGnctk2ny1ApVmWlth6Rap2FxHlC1XkVAC71oiOyXVEFw4AjH1OvA3ILvT3XUJ9Ej
	fZwnqN4tR4SaPe3z44SluoX+UBz+DYjEHCvfkmZBzb4d+NohEFniktNfEUQshgGrgxokZ0sV10Q
	zG+xn3KAy0ufjg8yQnP5VWraRP8bRWv+IsB5tF60jdbZ+8fQOCl6sTzLLyDFJ/IJecPlBqnUtQP
	UW+d0XUK+pbuhDipQ==
X-Google-Smtp-Source: AGHT+IHg2VZsTQuKCubcmXajekqzYuIPW+Hjjpqe7q2U/EAMGXzs4w+dzqW6OtFXnn/TXdujCmQXWmQ19SNYcS5K8yo=
X-Received: by 2002:a17:90b:558e:b0:311:ed2:b758 with SMTP id
 98e67ed59e1d1-321839d9dfbmr16616770a91.3.1754887487802; Sun, 10 Aug 2025
 21:44:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab86a457-aab0-1ea3-3161-2630491585d7@moenia.de>
In-Reply-To: <ab86a457-aab0-1ea3-3161-2630491585d7@moenia.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 11 Aug 2025 00:44:36 -0400
X-Gm-Features: Ac12FXz8dI2gjq7jfoF1ARE9GOywRDa34FkjQPc9kTRT4qxalGFwbP4C_pOq1pg
Message-ID: <CAM0EoM=6353sFS5dc81Gh6-86YK3rWQq5OUUV3Sumw1-BXKwnw@mail.gmail.com>
Subject: Re: problems with hfsc since 5.10.238-patches in sched_hfsc.c
To: lkml-xx-15438@sh.werbittewas.de
Cc: netdev@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 9, 2025 at 4:13=E2=80=AFPM <lkml-xx-15438@sh.werbittewas.de> wr=
ote:
>
> hi.
>
> hopefully the right list for this problem, else please tell me the right
> one.
>
> Problem:
> after updating to 5.10.238 (manually compiled) hfsc is malfunctioning her=
e.
> after a long time with noch changes and no problems, most packages are
> dropped without notice.
>
> after some tries we've identified the patches
>
> - https://lore.kernel.org/all/20250425220710.3964791-3-victor@mojatatu.co=
m/
>
> and
>
> -
> https://lore.kernel.org/all/20250522181448.1439717-2-pctammela@mojatatu.c=
om/
>
> which seems to lead to misbehaviour.
>
>
> by changing the line in hfsc_enqueue()
>
> "if (first && !cl_in_el_or_vttree(cl)) {"
>
> back to
>
> "if (first) {"
>
> all went well again.
>
>
> if it matters: we're using a simple net-ns-container for
> forwarding/scheduling the local dsl-line
>
>
> maybe we're using a config of hfsc, which is not ok (but we're doing
> this over several years)
>
> our hfsc-init is like:
>
>
> /sbin/tc qdisc add dev eth0 root handle 1: hfsc default 14
>
> /sbin/tc class add dev eth0 parent 1: classid 1:10 hfsc ls m2 36000kbit
> ul m2 36000kbit
>
> /sbin/tc class add dev eth0 parent 1:10 classid 1:14 hfsc ls m1
> 36000kbit d 10000ms m2 30000kbit ul m1 30000kbit d 10000ms m2 25000kbit
>
> (normally there are further lines, but above calls are sufficant to
> either forward the packets before .238 or let them drop with .238 or
> later. we're using an old tc (iproute2-5.11.0) on this system.
>
>
> so, it would be nice, if someone can tell us, why the above
> hfsc-init-calls are bad, or if they're ok and the changes in 5.10.238
> have side-effects, which lead to this behaviour.
>
>

Please retry with the latest 5.10.xx since it seems some patches were
left out in the backport. And if that still exhibits this problem try
the latest  6.17 net tree because it will help isolate if the issue is
only with 5.10.x.
If the problem persists please share your script/netns setup. And in
the future please Cc the stakeholders. It makes it easier to help.
For the record, trying what you just described with kernel 5.10.238
and iproute2 5.11.0 didnt recreate the issue. Basically:
Creating a netns, running your commands, pings from the netns and
netcat.. It all worked fine, no drops.

cheers,
jamal




> thanks a lot.
>
> regards
>
> x.
>

