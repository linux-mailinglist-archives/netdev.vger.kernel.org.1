Return-Path: <netdev+bounces-199763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDC5AE1C11
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680A41C20CBB
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B629551E;
	Fri, 20 Jun 2025 13:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BSYHcxwf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501ED292900
	for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 13:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750425877; cv=none; b=YCPu2a98Dw5lRWHvfGEsLMohxMe168ffC2TlX31lYx088dY7cjLgiNK34+aPCwW3yw+pqwpG+9vZCvmqb3Yw11l3i0Jd6UGfoF9JztT9opwtQsWl+ZvtV88O5avX3URAt1jeJSfc2jGRSNS+3vR+xDCMuN7/wDhtgTM1qFV3dpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750425877; c=relaxed/simple;
	bh=d9ZfafjmIee1iG+4AYS+vqOpLxzW4Rp/rsErzbqVdU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AhGAAjPw0xljQ/TrPPZyVDbyyMrxcPEB4yqWh/+qVoHuMvC/ZzNuU3QDDUu7L6QIg7qMCY4vAa5WT/BbaLGVg2BSx19W2B5aeKMc6G1IpjdzNWuAatUCTWcU3NnpJocdk+BAS4Yv+0EaW+38017EJThnqhXH7/k372+ZaoaZPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BSYHcxwf; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a44b3526e6so22994701cf.0
        for <netdev@vger.kernel.org>; Fri, 20 Jun 2025 06:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750425875; x=1751030675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d9ZfafjmIee1iG+4AYS+vqOpLxzW4Rp/rsErzbqVdU8=;
        b=BSYHcxwfP/jZz2aqO3yNcaCca98GR/68QtS+UsKdu3eqcbjNvAsSTTaSPobyiAKMI+
         yCSMkZcjAPBx06I8EG+vC/nAR/4GdK9P8USncIn/bMfHIJhh/O4V+fx5UslvWsU6Agph
         yR2+ZK+l9p3fcpEAjEl9DmI2a6pyAfgZ5+0cOzjoWZ69NAXVNCmJkRRkKJ264DCtLdVu
         6bItaJnx+7h3giTb+TBpuq3pcrPMoDeED9vCkdwTUODp+bxnRitfX4NJLxXTefRVe6OU
         Cnh3hxXdN1et172yZC/kxo3Zac9BekSoCboGYMsbE4cEktOOP9bWznXgSZ2UlqZsR7Lb
         07tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750425875; x=1751030675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d9ZfafjmIee1iG+4AYS+vqOpLxzW4Rp/rsErzbqVdU8=;
        b=edlZVleZgAh7bRo+v+RYAAOvMDMQ1BJQyRtr81I84QF74iNWvp4HV51IQj89c6UTpC
         I+p9G6iLRhLnUx3LhvwyAhcvjMeCmRuAenqA1wc49Yj8afgZ59f6yBdyzrGO0M5ukn/Q
         ETjP/xKOOl+34HFciLQAQBHYtXHFUTR2cQVX41cFhTAbDzu5cQZFw2ZVkVd10gOqtaGg
         iGY47K6KiZfGBwKMlGydItYsR9EieAy+GXLY6B6gY5z9hpjdQzqU2FTd4I7WruBA7Sx1
         loySTAkZqvYQUOfB3r+dC2RHVam1y/AlbzQ2V53hIIXxs1qPqCdffuwracplIzrHy0ZP
         LnwA==
X-Forwarded-Encrypted: i=1; AJvYcCV18Aqi8H7japgvLB3ea/EWXj+J9Q7f9bZA59VXeaU2bO00h/ZAh8XfXeDdvoJLOg7qHP8Rcwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVXyCmdSfZIVDuZOjhz525LMdkUBe5W8bBb8E+6d9jmx28s5K
	5/5gsAigv3E0x8Ww/6ee/aRfoQKbWsi4ON6LHlhrWIjSrt9wBXoBvW+Cjx/ubTS2m66wOlV6IhN
	Tli5Bx+3CAmMcdkj4nS8Vhx3qaRk7o/VU9ol5qnbv
X-Gm-Gg: ASbGncvQ1+jf8iib49ic+g+CDFHjaYIiOvkL/7AnqwYPbNw7a94FAeK2Cp2E9Ulim3s
	O0HFXl5UuG74Ha5XCrbu56tTZ6i+WFoEX6TXcmedzYNr5VMs+ro0TDukeZzfr/KIC9DhcxYiCeL
	cAOrAYgeHA1e4wEQGS3jhXvKRrp6mI8A21KA9TjXPPTg==
X-Google-Smtp-Source: AGHT+IG4eaVt0MWfu/UDw8t8Al7b4heihOxTJYPuijSj65Z6bXsPF7O0hfoC2og12Kgf2KdA706bwmNyEIknhSNOCDU=
X-Received: by 2002:a05:622a:489:b0:4a4:31c5:fc8a with SMTP id
 d75a77b69052e-4a77a29d8a5mr47363631cf.47.1750425874849; Fri, 20 Jun 2025
 06:24:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250620125644.1045603-1-ptesarik@suse.com>
In-Reply-To: <20250620125644.1045603-1-ptesarik@suse.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 20 Jun 2025 06:24:23 -0700
X-Gm-Features: AX0GCFs8knA8ecPrWGUgxdl0yH3mTUWy-n9f71rdkERcznqHz0_ZUn3B44h7Urk
Message-ID: <CANn89iLrJiqu1SdjKfkOPcSktvmAUWR2rJWkiPdvzQn+MMAOPg@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp_metrics: fix hanlding of route options
To: Petr Tesarik <ptesarik@suse.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"open list:NETWORKING [TCP]" <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 5:57=E2=80=AFAM Petr Tesarik <ptesarik@suse.com> wr=
ote:
>
> I ran into a couple of issues while trying to tweak TCP congestion
> avoidance to analyze a potential performance regression. It turns out
> that overriding the parameters with ip-route(8) does not work as
> expected and appears to be buggy.

Hi Petr

Could you add packetdrill tests as well ?

Given this could accidentally break user setups, maybe net-next would be sa=
fer.

Some of us disable tcp_metrics, because metrics used one minute (or
few seconds) in the past are not very helpful, and source of
confusion.

(/proc/sys/net/ipv4/tcp_no_metrics_save set to 1)

