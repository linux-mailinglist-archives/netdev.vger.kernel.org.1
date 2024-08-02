Return-Path: <netdev+bounces-115276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B8945B48
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 795A2B2221B
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D551DAC78;
	Fri,  2 Aug 2024 09:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SaWzwsV7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF091DB420
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591691; cv=none; b=Vv06Qo2xRtTuTqtQ86SE/MFZqHVFZfr1EEnVhYprOE7xCsx4ba6nxojKC8GMV/E1AVjtzSa3//EIXavg7F/cvICPjMbGRXToEwEx6PtwOmx0RHkz6yYtuJ9SiOv+9plfHPUGVaF67fDPqKIy0ql34J7ipvQOwHvWE3mXnDU17UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591691; c=relaxed/simple;
	bh=oR/L0UV8FQhtiCbsH2MOuYdKovD31eyYrNvDxVOHa7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ve/xwNqujUshCg/j4WGc7Dt7QalJPxAWe58xRZfzFwb1Dh50obojQFjUrlzJSMkCuzCIIRlj8OFVflI6+MKtdWeFmwuhcH81zBTZZ0j2eSVS8c95EA7rEwLgSaNhYYmLGCNTroC8Xf9HvOLd7WuY9RNyjCgH+HjKDJj+2YE5Npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SaWzwsV7; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so48466a12.1
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722591689; x=1723196489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oR/L0UV8FQhtiCbsH2MOuYdKovD31eyYrNvDxVOHa7k=;
        b=SaWzwsV7hRCe0Xnl15m7bTtPcc7EFmoeZgCKL+kH5s3o6uJX2Hel5TC2ITM/QR/aUq
         c33EIFBp7EuMuhaH0uP1Cc8psIH+6S4n692ru+26J2rZqzqzpSc3Lhii5uGg3Ro8238L
         ZtT7Dg1RsWVJpVwDARIG/HGqmxfqfFN5bsoFHZ075Am4ck4dyCdPcmkpBZ07K/6bwB0Y
         l6NFc0elJkzN+eF4q2aEpIP8CWK04uYMmnTCMIKd33PpYcpWOzvcfsQSWMkLGXwizd4/
         bPloNbmhkDtxWEWpkz5/vBJg0qi/vwsCVh6fAUgStnkpPYj+TZ+DvhZjlqZBcfFnnN0E
         jP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591689; x=1723196489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oR/L0UV8FQhtiCbsH2MOuYdKovD31eyYrNvDxVOHa7k=;
        b=awzb0f8WFUFZ8B/poP/iwYocs1vBp2zydBOlE8309yvXdLEVJkxKq4Iv5rIjFGQu1U
         Zt3phkmpLXxck34nWkiraavwmAEe4EGdFgB9uam9MZyzFluROQFJVv2UGzIZZQ9A/kPC
         lq3XkZ833QRo1/i5jayxXtYSPQrqKCd/gKrtEw++O3/t8qxQASPNfQx+Q6k4uu9PuItd
         fBkbk5wwBVdWNTl7lwv0HyxBTG1zgJ6Im6jh+319R1EVW8Nn4oh4MS8NJod/IVmfWj8r
         VDGnkdXXLlsJuD7vs7m/q3L0cn+5oPkrJ8csX6Sdnf5hNdP5nvYJkyfjHwl0bXB+UER7
         FCEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm36Q1PTHDQiI3PcANqNAffClV0LSjUqn1LBju0PRe3GBl4FN3ExirOYEFjjzI7A9Y5jgDLD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJSpEDJXk31PvQi+d+07UkWbpLQeiLZwmWDS0kbmt4n9z4vg1
	AVrBbW75+OneQOBYp+DxAMUn8Xh4O4z7yrihILvsJuRAAphPHDuQ3pHebHll199vK1abjUpM0nn
	sRzp9xQbXV0qGxj9+B/WHYnBlV7Bi6fJXHhgC
X-Google-Smtp-Source: AGHT+IG38Vi0Hx0NW2Pby+uo98utMX4zY7ZBCrRZdxzrHu1siZ68pEvX6Ms4PM76Z0vPO6DcKnJ35IE+SL8tBl652As=
X-Received: by 2002:a05:6402:5109:b0:58b:15e4:d786 with SMTP id
 4fb4d7f45d1cf-5b870f709f6mr99460a12.5.1722591688212; Fri, 02 Aug 2024
 02:41:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com> <20240801145444.22988-5-kerneljasonxing@gmail.com>
In-Reply-To: <20240801145444.22988-5-kerneljasonxing@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 2 Aug 2024 11:41:16 +0200
Message-ID: <CANn89iLjYcVa0MZHBrWvz2qYF2y5aV23uBkt3fnpNTQEo=nvEA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/7] tcp: rstreason: introduce
 SK_RST_REASON_TCP_STATE for active reset
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.co=
m> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Introducing a new type TCP_STATE to handle some reset conditions
> appearing in RFC 793 due to its socket state. Actually, we can look
> into RFC 9293 which has no discrepancy about this part.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>

I really think this SK_RST_REASON_TCP_STATE is weak.

'Please see RFC 9293' does not help, this RFC has more than 5000 lines in i=
t :/

Reviewed-by: Eric Dumazet <edumazet@google.com>

