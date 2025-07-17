Return-Path: <netdev+bounces-207802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8D9B0899A
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 11:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DD7B8F83
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 09:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3FD28B7CC;
	Thu, 17 Jul 2025 09:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R0f0nLkq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA40C28A703
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752745471; cv=none; b=uFbOBQq9Vw9K1g0Biu148DAchGCsTzm1N9HcHVMyO9hDzBPpKkaiSUvMIzRdhFO7xqfU+Su+DaW1lRS8y7c825lnL8BqCN6AmUOUw64BmkvnqRcO/yzE7ggwdWZwR26LgjNuX6Cl2iw7gTDYP/xJC7YzcKugbTx80XPPjrSzK+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752745471; c=relaxed/simple;
	bh=kO2t2G6It6gWkluWGJcCbbsfm+OCdkgZPGkyaijqCas=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tbZZRkZxxnJUsPnEQyxCuEbLe/5HBzmXRSLxzvLcJD6GX6wxeLMhaodmZx0cYn3Bk5vs2isOWuHeCYwcQD1XEliGBo4eBgqIYnydLi8W5H+Y6lK0u3U0RdNlf59gbR9wR9iZHJ8vesvFAkpMQ0r9OA/V5G7JMRInz0mut/RGrCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=R0f0nLkq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so1503100a12.1
        for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1752745468; x=1753350268; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fuDZjXlB703o1bPTQNKcgalEMHnXbsXoZy1JPTe162U=;
        b=R0f0nLkqzdAyvORSDjgiHAZ8M7PYdn+AQvaSLIJObRr0GcKhB2ygRmfuLy+GoRe9dI
         P7jstvZCaK/WuOKBFd47+by1u3gmpkc4KdBKTQHAWtu77wjqtqaAE4nshkJdosiyeJA8
         +mDPjLam+odV7ru0/7OYFxUOpdUyhKkOHGiHRFSALctuVHQuv+8AxpvyDWinEnBRiCke
         xW59nRIQ/lMPKoEKjcTeVH7wrlXwgGbw1SfMh/aOLFKByDT2MVJQ+pXWyhirdRFJDYEJ
         VZ359vwTdjIx69z1wA3xZv56zPhQBenyJ8WF6A7pNHBHFmz773v3v+syiboJIa+WoEc0
         O8pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752745468; x=1753350268;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuDZjXlB703o1bPTQNKcgalEMHnXbsXoZy1JPTe162U=;
        b=uyqfmpmXiqNpkrSpLFRtx9fVrE+oBziUR9z8vA3CGsJMFrrhpTIHiPpPQMqbLZd4bK
         JYMFiXjGlepX4yHt4U24itAKik7G1Yw7hCNbXeQBakKZbPqmlgvewuj+iACcNHjyeuOY
         PNUxlSeMENnoYcvEq7YgSUEIKcRyoh24jltGLGGJ9kmGXJCSSBGiOREZbrho41R/A9IY
         /AJisft1dPMlwv28OCMbROf0h8himL5MIzcX9fZPx7m9vtPNGLMtzG4BmXztmVA7fI5b
         mLCXH2cFP6IA0zCSdDrcA7m3HIFSgKz2LbDV+Xmt6ozI4qw7BLFZXSqteBPbOfqeWkLk
         eIpg==
X-Forwarded-Encrypted: i=1; AJvYcCX1F1WxXnq6v7Oy3n+qP5o5XrXbNTRq1m8cDQatF7e4MW/vQR/7H2S1FIASAydgF7IwuxkUFIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdrbrm3um/WWfxh0M2hCY4Zxs/FY/8xHzkmBxTeyfNqV5sQOO
	HkWPf3xrDSsy9yBRqrJJPH/5C/ManCB+FRSy0N16Jm3hvQSjVBVtEUzHED0U81Uk5eM=
X-Gm-Gg: ASbGncsLq6vEwKSjFy3fk8z0b5yJJz0fiay+r/brAwGG97cIuHxC9g4XY22P3MgUnzS
	5UrarGniRlR/U1HFq7vpWmz4P/zgiA676QkEw1TT9Q8+orUtcK77qQFPMd8f/GDWnnqAHr1eXpN
	E+KOYwPYpoV7sgNfML5UVDvPwD/6mXt1rGQiprntXqUtMJiv2vo7pdLiXLd5MDiiwz6Db58Tm6T
	ZQE5weK9J55nVfbxCVkaijOylk09Lx2NGGmORxkQMdwWcSSlbhp6Y3gKB8M+JEkmmUXjB+uI2GG
	Ak7tn5QlVuCzUyAUHMkqLYttjqPDN1Wav8xfSrSlbxjAy2FJl/PDt5kgOwWr/Zqz5pf+42tVsl0
	zp7PdmTgAg8JKy48=
X-Google-Smtp-Source: AGHT+IG9UBaMGnDmodbS9Ci4yZnS7YMDOXoud5A4IbVe9OeBuFW9FS3DSYBLgOEFeulDNAoorZeLfg==
X-Received: by 2002:a17:907:f1ce:b0:ae3:5887:4219 with SMTP id a640c23a62f3a-ae9c9b406a9mr609787066b.45.1752745468213;
        Thu, 17 Jul 2025 02:44:28 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:e5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee569asm1319180466b.44.2025.07.17.02.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 02:44:26 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Neal Cardwell
 <ncardwell@google.com>,  Kuniyuki Iwashima <kuniyu@google.com>,
  netdev@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 3/3] selftests/net: Cover port sharing
 scenarios with IP_LOCAL_PORT_RANGE
In-Reply-To: <4688d857-0cdf-4f39-99de-c3bfc7abd3d6@redhat.com> (Paolo Abeni's
	message of "Thu, 17 Jul 2025 11:27:41 +0200")
References: <20250714-connect-port-search-harder-v3-0-b1a41f249865@cloudflare.com>
	<20250714-connect-port-search-harder-v3-3-b1a41f249865@cloudflare.com>
	<4688d857-0cdf-4f39-99de-c3bfc7abd3d6@redhat.com>
Date: Thu, 17 Jul 2025 11:44:25 +0200
Message-ID: <87ms93dudi.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 17, 2025 at 11:27 AM +02, Paolo Abeni wrote:
> On 7/14/25 6:03 PM, Jakub Sitnicki wrote:
>> diff --git a/tools/testing/selftests/net/ip_local_port_range.sh b/tools/testing/selftests/net/ip_local_port_range.sh
>> index 4ff746db1256..3fc151545b2d 100755
>> --- a/tools/testing/selftests/net/ip_local_port_range.sh
>> +++ b/tools/testing/selftests/net/ip_local_port_range.sh
>> @@ -1,7 +1,11 @@
>> -#!/bin/sh
>> +#!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>> -./in_netns.sh \
>> -  sh -c 'sysctl -q -w net.mptcp.enabled=1 && \
>> -         sysctl -q -w net.ipv4.ip_local_port_range="40000 49999" && \
>> -         ./ip_local_port_range'
>> +./in_netns.sh sh <(cat <<-EOF
>> +        sysctl -q -w net.mptcp.enabled=1
>> +        sysctl -q -w net.ipv4.ip_local_port_range="40000 49999"
>> +        ip -6 addr add dev lo 2001:db8::1/32 nodad
>> +        ip -6 addr add dev lo 2001:db8::2/32 nodad
>> +        exec ./ip_local_port_range
>
> Minor nit: it looks like you could simply add the additional statements
> to the '-c' argument without changing the used shell.

I might have gone overboard here. Will revert.

