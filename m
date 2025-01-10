Return-Path: <netdev+bounces-157216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD77A09743
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2E1882AE8
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 16:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD0A213222;
	Fri, 10 Jan 2025 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FAMbtjfC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE2212D7C
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 16:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526271; cv=none; b=j6lCs+efH2tPomNNYk0jYKVKERz+8mSv63DeVcVYe3FxdInqexGIO2G+heweCOcRSbYh7HEMBce1621LzeISkHZS7WEdxzUmlkQIl1o70gxFqV8wFonnOnxnj/FJMB79vplps2sJBtgoLaEJd5ThofSk5cZXtRX20nMK/OitcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526271; c=relaxed/simple;
	bh=3b6neDEPzsLsN67DAfsV6R9TU5K+HbyGOXc15aFLzEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gA1/Xbzgq1GrjMRzMImyWTUj2hgoXPFwR8byULz/AOObW57pmP0CAS/+uhyaEN2oeAcCxLObKgEczrtfcQdZRAWdQTXu7xY5aPYkM0Q48DuuzIW18cG/6XYZB0MqBRhYg+3+wa1EhLWFIp1dKZmMHln7Dtaxpd4DcX2dxl0qixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FAMbtjfC; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so454163766b.3
        for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736526267; x=1737131067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgvMoDIN18uBOxcv7t4Bfn6DI89FufdUFpiEzLXRHZI=;
        b=FAMbtjfCI6zLI74fMVI/EMcsX4KwORGLUInXpEFXXYQZUPoHAOzvIP24NAXbQ3QZcI
         EnVo0+5/APTXmCfrFdqTRRYpE/1PcjdI6MqMOJh8GT5kIdyGf7H19Suu24UBXwA8IcWY
         LeAwthoUXFjrTZIEKnvzzDX8BzEWluyXl/ChiinbeM+ILndyUDDxErJGhMazsZqFHF27
         18XrCVUTeGuRSKmKjBUehFBNi0wPrlPf63Aqw89u1RTr28ZNl8XzOi3l9DVJb9URoUSn
         4kGYYdwKkM9CR7+aqzVvJrPSEW14sJ+6yjC9ZQqNTQGCeSLkXmDzF9P3gnvu8qt8KmW/
         5PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526268; x=1737131068;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgvMoDIN18uBOxcv7t4Bfn6DI89FufdUFpiEzLXRHZI=;
        b=bQcBBfq4dbImaAuezYQaGbdDxb3lYc1APbeABLYCnzitjGODf47TK8OjOcunsVuXwE
         rsFtNBWWN3kXV6RpMtR6J20QMGZX5yiGQS39DslCSlg47mt+ZAVWn9ahik6FPhcyA+NC
         NPXNo/oa7DJIlXdf7fXVmvrYAAcuVhcEMejYEO1njNHbxNAgsmPq0lTIEAGh7CuMZH98
         IrBQ1KvaKthLbtmRQ163efW6u3O9UNme1n1/CzstH4VmMxIuZw/XnkHDr2Upcxjs2ne+
         Ed1/GVZ10cDqQ4DBUpOvhnnrKtwTvQG5Pux+q89tAOx5K4yksxmmmZgosnhOZkT+nLZK
         D+Gg==
X-Gm-Message-State: AOJu0YyWyMYxuX19djwF/gy/15Uz7knhuDKXKraXS+L4kl/5uglTsg7q
	2UF1Qu8iAm2SVjBgaloDtmLdemPyjAx8ikWunNQ7f5Z/B3486GJvPe59bJyY2qKVRNrsOEXPK6K
	b5h5wLK1J1qLTvhiI2a2+ZWCbn0ni9fSLSN1wfGubtHw6usM5MQ==
X-Gm-Gg: ASbGncuyqMwNPpBsWvfc56rcPioQ7hwvM2F/JSoTZnek89vCsTG0UTg8ri4BbtCkfox
	LSIqo0Phg4blQIg0aUV2z7bMtJMv1REKPNR/rbg==
X-Google-Smtp-Source: AGHT+IGJr58LelVfn7xeQ82vHy1ziXpztdR8LRfsa86Qr56JPQMS4Gl7IPmeAALr/UaMCfAmLlH+XU0XLlEmBZ0OYRc=
X-Received: by 2002:a17:907:6d20:b0:aa6:800a:1291 with SMTP id
 a640c23a62f3a-ab2ab167fb7mr1009168266b.7.1736526267482; Fri, 10 Jan 2025
 08:24:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110153546.41344-1-jhs@mojatatu.com>
In-Reply-To: <20250110153546.41344-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Jan 2025 17:24:16 +0100
X-Gm-Features: AbW1kvb4pwBwpxniRUfqA151SwmXmEPVBn0LrUyt2tqrMgJE-mdFNSoi2WKBOH4
Message-ID: <CANn89i+-LreZWpQpiNfNBLWN_in58MEtegKz-qqDk64h2i45LQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net: sched: fix ets qdisc OOB Indexing
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, kuba@kernel.org, petrm@mellanox.com, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 4:35=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Haowei Yan <g1042620637@gmail.com> found that ets_class_from_arg() can
> index an Out-Of-Bound class in ets_class_from_arg() when passed clid of
> 0. The overflow may cause local privilege escalation.
>
>  [   18.852298] ------------[ cut here ]------------
>  [   18.853271] UBSAN: array-index-out-of-bounds in net/sched/sch_ets.c:9=
3:20
>  [   18.853743] index 18446744073709551615 is out of range for type 'ets_=
class [16]'
>  [   18.854254] CPU: 0 UID: 0 PID: 1275 Comm: poc Not tainted 6.12.6-dirt=
y #17
>  [   18.854821] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS 1.15.0-1 04/01/2014

> Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
> Reported-by: Haowei Yan <g1042620637@gmail.com>
> Suggested-by: Haowei Yan <g1042620637@gmail.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_ets.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Eric Dumazet <edumazet@google.com>

