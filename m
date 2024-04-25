Return-Path: <netdev+bounces-91206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFBB8B1AF8
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 08:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CF1C21667
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 06:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD7640877;
	Thu, 25 Apr 2024 06:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gibzYghG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4304084C
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 06:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026345; cv=none; b=VHrmWijdkj9+TqzDLbqsmHNSCzCi3ZqLQlELWMQwFU97xjVxk6bFj+lhxClOXJf9hTC426zWDWWRAA+y4STsq1TcUr8C8rpAmZ9G/EKUlo3a5AdOeV2IHSvpZ5033exZ5RfMMMCuu5HESZXLQ+eYBZc3bdmsRug+3VhsXewfeZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026345; c=relaxed/simple;
	bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcmgoonRtBitJ7VBk4rGXZtv/aeDrRZgw6+oRlXhA+ZSTJQWgxbc9jUWhTZOdnuyPPsYUwsXhnzmPRHMw/PpIxf4ZQL0AsXLdeTVvBuWW/0Bg/2fmjp91jqZv/lS2cg9DxoKChMURbRwEuq9MZ+7YoStoW8OqaR90nTPlPH/6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gibzYghG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418820e6effso47925e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 23:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714026343; x=1714631143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
        b=gibzYghGRZT6jvsBG5q+6lpIOFw3HkYK/haGv4EJzkI8U+qd5vRCpQnXiOZTYsKjlH
         BA1OYDKMfYJmpCznUKkK3zaa1ZLCcE/aKdmIZQW4pg411rjvtZuoIoyn/pcMECS2eVHR
         /1HY5AMqKsEC+ORcKyyZl9cpEkwCHltjFj8VIDAhOLNiD/zglPF7LDVLBDkqeLkRxN1N
         +JcKBCyO4rAc5BNRs8iX9h9sNihXx7KeBWoGzzP8DIbV+AGt1YNy/nLL5IGJBPw4W3XI
         pOYMuP2YKsS5r+jX4xQnJxIn9CiOMUgOgaJfPoRTFXmjbDzHSgVs/KOHI+Mdb8SLcSGQ
         D0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714026343; x=1714631143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fERmv0h0RJAlvrw4KpCPifAyBafwLvv6KElMBv4MBUI=;
        b=RyE88Ctjykxtthvx8A4usl/6IsAPQZLAXwH6hxsZGBzfL1tpgCBQsqnaOy8L2HqF1i
         FXIy5uvQqUaosD0URZ/X31THn+q7cWYNFQ8hPRUpqT6NcVIyn3lVzU0wbaqb56R+8tIP
         26xhRu9qo2YkFQ+94xl+bUXCLUmyyxZQWfG6L4Oap8StrlnvcwhVSxzOW8ST8c9eE5mt
         YktXc0Qvxo+c4W0tRsSgChDSUDEeU5x65Yr2ivKq3HwYf0bzXekdG0ozo2p1TUiKbvOs
         hxJGkxqUT6MU1RhRt99GUvWkVX4KwVzUTA6NRNGig5bpNdPBZA+Zi0hayDBCIshL0tfB
         sSkw==
X-Gm-Message-State: AOJu0YxUcIbwGXit49UK5QGlmhfPyIj4tRqc1+P1t9/7oVHxzsf4333F
	ZxlPM7JRQfgyMTWhDF1AdwmK/J/NhMpWkaRXu22VJPyNmwemgnMlrMoA8qxfsTZFmKn6J/oQxSs
	SurOfxwNEpfDpyaULeCGb63iqOSdFyiL0yk3aTqGXhShA+3ss0g==
X-Google-Smtp-Source: AGHT+IF1G3uXYrQJS8plmR3swSNBwsdSuwXomI5kcLCqeYJhHkrTotLf1d0aNtMmNpM6GMfu+gp85O2SKoW2VCGr2HI=
X-Received: by 2002:a05:600c:1ca3:b0:418:cef2:7575 with SMTP id
 k35-20020a05600c1ca300b00418cef27575mr127025wms.0.1714026342462; Wed, 24 Apr
 2024 23:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240421042009.28046-1-lulie@linux.alibaba.com> <20240421042009.28046-3-lulie@linux.alibaba.com>
In-Reply-To: <20240421042009.28046-3-lulie@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Apr 2024 08:25:31 +0200
Message-ID: <CANn89iJb2XkPwYfjJnhfU5pvf_jjD-xw5WuzDom8GP+t5nzyMw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: update sacked after tracepoint in __tcp_retransmit_skb
To: Philo Lu <lulie@linux.alibaba.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, 
	xuanzhuo@linux.alibaba.com, fred.cc@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 6:20=E2=80=AFAM Philo Lu <lulie@linux.alibaba.com> =
wrote:
>
> Marking TCP_SKB_CB(skb)->sacked with TCPCB_EVER_RETRANS after the
> traceopint (trace_tcp_retransmit_skb), then we can get the
> retransmission efficiency by counting skbs w/ and w/o TCPCB_EVER_RETRANS
> mark in this tracepoint.
>
> We have discussed to achieve this with BPF_SOCK_OPS in [0], and using
> tracepoint is thought to be a better solution.
>
> [0]
> https://lore.kernel.org/all/20240417124622.35333-1-lulie@linux.alibaba.co=
m/
>
> Signed-off-by: Philo Lu <lulie@linux.alibaba.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

