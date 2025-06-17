Return-Path: <netdev+bounces-198493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A151ADC661
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 11:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 769011894D26
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 09:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329AA293B5F;
	Tue, 17 Jun 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+5tFAvy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957091FC0F0
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152552; cv=none; b=EhtUunKD/hegY9hjHlnzEEXs+UUSak/LHQNv/cxjLnGKTIzLD3lGJxlJ/C75w7vzXiOd6HkmnT9FFiK9gvz3rtdVsZF77RGQ7zw5hV6pUFVdHWCbsQ/cgxjfhh5wLaBdd6p7wENwACNG5VnWoqeuZ/jJO/9kbCQG/RUIbWNMOm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152552; c=relaxed/simple;
	bh=xS3jVw6qEGOm9fEVS4wYUe7OUr26J59bD5MOijllWh0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCSmQ9vZL//tSheP0IkRHeBUd40JP9h1GfZLhEkDX3LPlRJT138XmC6JZz4JDOChbG7vPP0iVFeDWcoYPoT5SABBwiahKFXFir/ktaxM/N3qQ2Tg2p880UDgKnWHj0WvuvWdnpE3hnLD7AiTcFFI4Z3gP5HfnqJcFmmiRqmISws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+5tFAvy; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a43972dcd7so70850501cf.3
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 02:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750152549; x=1750757349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXFONE5m/cDlxeLTkQQOcBdHgbxAon5tAvZFDvmhlv8=;
        b=D+5tFAvyhSYcKMu3NYTqyeaYCMH+Uu/cFqMwT0mNj9elFa1wg8D3SKjmQE97H70uCc
         Mq9Yjgcs/VpeWSvWnSj/xeN1m5WrBfplzKSbJvrMPIqIaQ1Vtioy/NHae1vORz2SNJ0r
         oLrLlyCaGcEdOGxt0b2I4qYIOKwa7ybebOlQQlp45/aJpifkyhjRpZKAT83qgrN9I9ys
         FaTU56eUYBAaSAOynY/nUgrVmmnFpeLSCd7AA9RLSoOIJ4XRPK0JjP9KmRaVF1UCUBYE
         8YO5EnLPh0w9moFSJmzx2Lhfzxhz6ZK1urGPN7On+wGDGx7EO2yd23zvOpsce/hgXqc2
         pSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750152549; x=1750757349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXFONE5m/cDlxeLTkQQOcBdHgbxAon5tAvZFDvmhlv8=;
        b=UiwixTni+B2F2GZdEdPC6RrkvMeoophAUjXQPSsuNoNVFHMfYaxYy5afIaq032fkbt
         JBNmRx4nYO/WD/DNj/B1DZDildQUs9CInnzsAvNEvY+Z1CmDEiCZfcttI66iHMybam7/
         e//rs/++ocEh3crvZjfIw4zKfeNevw97aCTVg+5dNwm9p7tEcmUAuDgc3zT/yEc/AeFF
         XU0Oi88eKVp8VO506SD+ZfK+5cxo6+yX1Vn4+oDd0Ji9duRk07aRs1lgc32RdMZwt4eg
         8+9eMOFnuU00PptKfVfxXGAg7T+1PyTbFPAJb7utPWcXp/rvTW57INU3Jq+Xl2/WZ+wb
         nOWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2xIc37KKG6TgWhrdeSTUrurKPDrx7E+tHuxCjQi1SoVCMQ/1Tz+j+Bl3SfrcGIs/twsbEVwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGE9frTidhn1G9CxHdPhnw6JdbRuFU6mF4dZnTG/uXhEXag/qF
	9UknUvH76fkSdx6HrsjymjFMV4wghciTMw7bAAeZ/7NZxKzws3WMBcZmJcgL/xuNkvdjy3B36ky
	c9fIoIlC+pgukDNXIKGyp8kEP+/Uz/S5ND3HajkR4
X-Gm-Gg: ASbGncscexfLlINMRUnWdmCrZx5mRE4VYvM2CRVhbFvKxauqQYahuqkAVLCp8KL9YK9
	Ssq7sUfAlqTEhcGrhAZgvS0ilUl3zy7i8qpFYgYCrx2FBUstSFXRt/j+neBAl4DJ6QyAhIAor/2
	po4df2ermfXbyZmvkZeoA7R3meA7/DdVPSFjVHSIRI01k=
X-Google-Smtp-Source: AGHT+IGBY1kGp0szCbTcVsp+fsEEhWT3xYCq9FDgGzZIQWdtzvR8Byq5YH2XZWHjfGez1GjqzUKwTuwy1tWoFqvmCvQ=
X-Received: by 2002:ac8:5851:0:b0:4a6:f9b0:2093 with SMTP id
 d75a77b69052e-4a73c6565d0mr202097101cf.46.1750152549162; Tue, 17 Jun 2025
 02:29:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e725afd8-610b-457a-b30e-963cbf8930af@davidwei.uk>
 <20250616230612.1139387-1-kuni1840@gmail.com> <72fdc777-eb43-4d15-a6d2-6f652e019cb3@davidwei.uk>
In-Reply-To: <72fdc777-eb43-4d15-a6d2-6f652e019cb3@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Jun 2025 02:28:58 -0700
X-Gm-Features: AX0GCFsCMXdNmy4ovdAh9XCEFZjThRm1i9jikADXc_scwGr33yoDy4rd4F_DXUk
Message-ID: <CANn89iKT86OOm=PbT+vS+iWJh9K6f_YFEG+G5YuwCXgjMyUwwQ@mail.gmail.com>
Subject: Re: [PATCH net v1 4/4] tcp: fix passive TFO socket having invalid
 NAPI ID
To: David Wei <dw@davidwei.uk>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	dsahern@kernel.org, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	ncardwell@google.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:04=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2025-06-16 16:05, Kuniyuki Iwashima wrote:
> > From: David Wei <dw@davidwei.uk>
> > Date: Mon, 16 Jun 2025 15:37:40 -0700
> >> On 2025-06-16 12:44, Kuniyuki Iwashima wrote:
> >>> From: David Wei <dw@davidwei.uk>
> >>> Date: Mon, 16 Jun 2025 11:54:56 -0700
> >>>> There is a bug with passive TFO sockets returning an invalid NAPI ID=
 0
> >>>> from SO_INCOMING_NAPI_ID. Normally this is not an issue, but zero co=
py
> >>>> receive relies on a correct NAPI ID to process sockets on the right
> >>>> queue.
> >>>>
> >>>> Fix by adding a skb_mark_napi_id().
> >>>>
> >>>
> >>> Please add Fixes: tag.
> >>
> >> Not sure which commit to tag as Fixes. 5b7ed089 originally created
> >> tcp_fastopen_create_child() in tcp_fastopen.c by copying from
> >> tcp_v4_conn_req_fastopen(). The bug has been around since either when
> >> TFO was added in 168a8f58 or when SO_INCOMING_NAPI_ID was added in
> >> 6d433902. What's your preference?
> >
> > 6d4339028b35 makes sense to me as SO_INCOMING_NAPI_ID (2017) was
> > not available as of the TFO commits (2012, 2014).
>
> Makes sense, I'll use 6d433902. Thanks.

Another good candidate would be

commit e5907459ce7e    tcp: Record Rx hash and NAPI ID in tcp_child_process

