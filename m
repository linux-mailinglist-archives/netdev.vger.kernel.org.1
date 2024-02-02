Return-Path: <netdev+bounces-68470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DE7846FA3
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821F71C241C9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6813E227;
	Fri,  2 Feb 2024 11:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqJS++op"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A65560270
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 11:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875142; cv=none; b=rt9BRQzMVixxUsJuIoMBuxfp4RUE/d7AB2krCcJED8Gv1t924jclgh269H0uISmgJw9OMnPbd4UlvU9TlBufHuMScV0NXiqnqeRNKb7Mr4RtN9sn1+zXzpmjibBWcO0MLklgls1jEVCsqH55QrrZUcPMTCCBgpWq3eb9BFlTm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875142; c=relaxed/simple;
	bh=HEw5YXNs6swjrqXKBFxcSSJTfH6N59kJGWXFlH/ldmA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=qtWm7GeCg3AzF4waBNCjX05PXYQWwWQAbezFswqGUjut1V5ymcXv4bUzLH9FNu1HNcBmgNEAtYtVIucK3CDW+eqVI6fjJVA1yIq/8J6mNSl4gnPZWdQdueY6YSbjzVV5VggdlIQCeJc2FDEroHNsRR/SNfNlCzdjuXL9hB1k2ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqJS++op; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33934567777so1197878f8f.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 03:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706875138; x=1707479938; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JWIQysttmFpZT4YsBDhZvshKjxF03XQWkuWblHEehd4=;
        b=nqJS++opgXrlut5xb/d1RaGbTMUxhuX/ycc4BlBSDJ5Bl37V3m1HkpZuAV5s0CWeqm
         DuW674lXHA0362w986u9TvalG4bbTJeYxCCBb2mJ/yOQxoL5n426KEa8xMgR8lw3km6Z
         TyFsYHNxqBdm1ktcQTbJN8QSKzDPdvpcuum8IotmnnGZn7FufJIhHljrE28RqGlYiIBz
         X1dfaY1bw4tgr6Bmf2biJwE4a4ngUItlMKou5oCcpI5AmHNEXJ+6dw0AOMRbJl/fIcoE
         Ly/hR8gazwZrcp41CKg2UIZDH4m7swElA+C4YDreVyOb4LAgppb37j8hTZKhvht2JN6G
         L3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875138; x=1707479938;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWIQysttmFpZT4YsBDhZvshKjxF03XQWkuWblHEehd4=;
        b=HNxpV1wMNzsH3IwH2ZEcYedq/JAYIBIp5gD7MRn64sjpJVZdnnIj4BRTIRUPqym+07
         UtoNh22RiajiC7/EoQppMDoTbi4FLL/P4vo6796ZK/sJDlDiCgP8m77y/eUcICpl+AzL
         bPZOU2qud8pZUsUgHjwDCzsjjzQpo7NumUjaL9vUlteUXs/5ZgL2gOErTRd4KN6H6WAE
         SMiWfxuq8OfVgl2Z4kTqDGVibU8r0V6kJ+gpKWX7r0b/+thnynYyz47NQpr+neFHeGAU
         /B4Um+1SWx8Phh0Dt/bfONHNg0XsvKKu3W64219o4Z6fqwAqTVbNgnztcpF/L0mckDZp
         Il2g==
X-Gm-Message-State: AOJu0YyQi4pzzMkiEIuQlZI8WBmHmtVqfJ7jY0qJ1EAa3e3O1vzK3nVv
	iqsVqlvYlVB7Rrjx59w9i0fHIh0/M/8DqyBFcGpl9+0PfpxIMHggaHZygGcpK1c=
X-Google-Smtp-Source: AGHT+IEnCBKTuFkFO1cP/IjjkbU/lE+eAfb9jAfrKW7yEe5D1g/R3812r78FlQX5TymlaK/uGHL0Bg==
X-Received: by 2002:a05:6000:1ca:b0:33b:1fb3:ad60 with SMTP id t10-20020a05600001ca00b0033b1fb3ad60mr973415wrx.1.1706875138023;
        Fri, 02 Feb 2024 03:58:58 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVr+37rT+snNZhfuXrwGpLijdHe4633YdKOSCO2iUdC0HeDfd43mCa3Rz7htR8EHUc3Q9I25ybIJQzL8ecjrK71e/eKfHNFk3IRa8hPrCER0X5D+sDBeaOoBERKuift5ruJqg==
Received: from imac ([2a02:8010:60a0:0:699e:106b:b80c:c3f0])
        by smtp.gmail.com with ESMTPSA id cp15-20020a056000400f00b0033ae6530969sm1790492wrb.85.2024.02.02.03.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:58:57 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>,  Stephen Hemminger
 <stephen@networkplumber.org>,  netdev@vger.kernel.org
Subject: Re: [PATCH 1/3] net/sched: netem: use extack
In-Reply-To: <20240201090046.1b93bcbd@kernel.org> (Jakub Kicinski's message of
	"Thu, 1 Feb 2024 09:00:46 -0800")
Date: Fri, 02 Feb 2024 11:53:04 +0000
Message-ID: <m2bk8zulpb.fsf@gmail.com>
References: <20240201034653.450138-1-stephen@networkplumber.org>
	<20240201034653.450138-2-stephen@networkplumber.org>
	<Zbtks__SZIgoDTaj@nanopsycho> <20240201090046.1b93bcbd@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> On Thu, 1 Feb 2024 10:30:27 +0100 Jiri Pirko wrote:
>> Thu, Feb 01, 2024 at 04:45:58AM CET, stephen@networkplumber.org wrote:
>> >-	if (!opt)
>> >+	if (!opt) {
>> >+		NL_SET_ERR_MSG_MOD(extack, "Netem missing required parameters");  
>> 
>> Drop "Netem " here.
>> 
>> Otherwise, this looks fine.
>
> Looks like most sch's require opt. Would it be a bad idea to pull 
> the check out to the caller? Minor simplification, plus the caller
> has the outer message so they can use NL_SET_ERR_ATTR_MISS() and
> friends.

There's also these which maybe complicates things:

$ git grep -A1 'if (opt == NULL)' -- net/sched/
net/sched/cls_flow.c:   if (opt == NULL)
net/sched/cls_flow.c-           return -EINVAL;
--
net/sched/sch_choke.c:  if (opt == NULL)
net/sched/sch_choke.c-          return -EINVAL;
--
net/sched/sch_fifo.c:   if (opt == NULL) {
net/sched/sch_fifo.c-           u32 limit = qdisc_dev(sch)->tx_queue_len;
--
net/sched/sch_hfsc.c:   if (opt == NULL)
net/sched/sch_hfsc.c-           return -EINVAL;
--
net/sched/sch_plug.c:   if (opt == NULL) {
net/sched/sch_plug.c-           q->limit = qdisc_dev(sch)->tx_queue_len

I'm in favour of qdisc specific extack messages.

> $ git grep -A1 'if (!opt)' -- net/sched/
> net/sched/cls_fw.c:     if (!opt)
> net/sched/cls_fw.c-             return handle ? -EINVAL : 0; /* Succeed if it is old method. */
> --
> net/sched/cls_u32.c:    if (!opt) {
> net/sched/cls_u32.c-            if (handle) {
> --
> net/sched/sch_cbs.c:    if (!opt) {
> net/sched/sch_cbs.c-            NL_SET_ERR_MSG(extack, "Missing CBS qdisc options  which are mandatory");
> --
> net/sched/sch_drr.c:    if (!opt) {
> net/sched/sch_drr.c-            NL_SET_ERR_MSG(extack, "DRR options are required for this operation");
> --
> net/sched/sch_etf.c:    if (!opt) {
> net/sched/sch_etf.c-            NL_SET_ERR_MSG(extack,
> --
> net/sched/sch_ets.c:    if (!opt) {
> net/sched/sch_ets.c-            NL_SET_ERR_MSG(extack, "ETS options are required for this operation");
> --
> net/sched/sch_ets.c:    if (!opt)
> net/sched/sch_ets.c-            return -EINVAL;
> --
> net/sched/sch_gred.c:   if (!opt)
> net/sched/sch_gred.c-           return -EINVAL;
> --
> net/sched/sch_htb.c:    if (!opt)
> net/sched/sch_htb.c-            return -EINVAL;
> --
> net/sched/sch_htb.c:    if (!opt)
> net/sched/sch_htb.c-            goto failure;
> --
> net/sched/sch_multiq.c: if (!opt)
> net/sched/sch_multiq.c-         return -EINVAL;
> --
> net/sched/sch_netem.c:  if (!opt)
> net/sched/sch_netem.c-          return -EINVAL;
> --
> net/sched/sch_prio.c:   if (!opt)
> net/sched/sch_prio.c-           return -EINVAL;
> --
> net/sched/sch_red.c:    if (!opt)
> net/sched/sch_red.c-            return -EINVAL;
> --
> net/sched/sch_skbprio.c:        if (!opt)
> net/sched/sch_skbprio.c-                return 0;
> --
> net/sched/sch_taprio.c: if (!opt)
> net/sched/sch_taprio.c-         return -EINVAL;
> --
> net/sched/sch_tbf.c:    if (!opt)
> net/sched/sch_tbf.c-            return -EINVAL;

