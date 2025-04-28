Return-Path: <netdev+bounces-186382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01035A9EDC8
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E950E3B5E8B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72225F79E;
	Mon, 28 Apr 2025 10:23:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C3E1AC44D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745835825; cv=none; b=PXKfD5jNNe9omaExV4eh9c3GzWCcLjU0/9qhjY0mUbgOeiXcbLVQBVjT6rjoBCDqHgdudLQSPMCkAXWY9mgAyXZXw5/JNC435k+XTLzZ5QYOsQf3xkmdiK1C3v7SbwkTVxOH9tn7e7KPtUjHvU2YPvzvoN9XsFTPBa4d4Ht7aVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745835825; c=relaxed/simple;
	bh=17pvybsa8MjfcQEVNUC4rBbc0vTyJvBdLu6k5GZ+w+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NIK6kw0crHSXxWdm8YGXz3xG8N4IIfCsBupeuVURaCpU/Pdk5cnvicVjzhsJQsMxcXmuX4FO2+kQId8IY42w0Ju+06s+YRQ6No6cNObslvdLwz9iY0o77jVHYvoxQQEt37OKgPtmfyIBPn35c+5YoF1c14dhB4PH1WSCTT0r330=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fejes.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso2792910f8f.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745835822; x=1746440622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=17pvybsa8MjfcQEVNUC4rBbc0vTyJvBdLu6k5GZ+w+g=;
        b=A0KoeeY83krjm1PO9HpbtrRUXY9GpcPLFNOcLRJQUfnw39LxzDS3s8dgtgn0UHx599
         B3DxQMQPs1C0RVZJxY/+YuPxRnT+oLqZ2o3WkdfJgxulKVUhTYAzW6/v+3qNCHZzSyap
         3ktrC0Cd8zvbamB4C5LUUFxIXI6XxciMLxXAic9se4HAyaJNsS3PxVeEqtcMq2QLIWxO
         FiEEKwEAUWn/mP56ksG8UDlrFW6l5v0EPM6/HSIhrWOFLLhx1qK/5CFlv+jYTvLfB8rI
         rKYn2Vg2Nh4GgdiCUajqZQhk48ryiHXyiHwnfF9NNVg1LYf96UyP5vjV5pY46z/RRoTE
         OE4w==
X-Gm-Message-State: AOJu0YxeROEA9yZuiWWVCW2yT+yqtOwIWxQ7RrCAe2Vm7NVPojJTfwua
	Sv86sVxHUWMgAdyf5gpmqpnUDDqtkqzugC7Npe4+gvbG5SeKRZoH
X-Gm-Gg: ASbGncvunOTE7GghhB92ucA3vo5O/l4Ld6FAVRib01zNmy0ZTYOiUyrY+O5FywfTeZ6
	vr7Pv4PCzmLkNeaPKAMDflBpr3CNZiMuOqlfaDmuakKyq1ZGfDT26wrN93IDk+OsDmVMzpbqWt2
	knZQkO7EZJwtaRTtbXMgjPFX1b3zFMnqRNZFal3wbzfMu9oZ7owLoVuEKvPiwWb6JPFYEil++Wu
	GbpW+jWyVTxurKXha0RhQOBZXj8/A8qgfCa0Ua9A3oo3JLP3FGWO8fZb6Hb4fsE1TG2ZSxtSj6e
	4M/xSGdOlKF3FDNitYCSl8Yj1MRQ8OpEsE2w6w==
X-Google-Smtp-Source: AGHT+IEJPlvTjTVx2s8RZz2x3BdkB6aFFlCJtdbcivm7Rv3DHl0LyR5j3onL9rJi0wAnNETnwXCqtA==
X-Received: by 2002:a5d:64a3:0:b0:39f:bfa:7c90 with SMTP id ffacd0b85a97d-3a06d66cfb5mr12167006f8f.13.1745835821844;
        Mon, 28 Apr 2025 03:23:41 -0700 (PDT)
Received: from [10.148.85.1] ([195.228.69.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5d264sm10954767f8f.95.2025.04.28.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:23:40 -0700 (PDT)
Message-ID: <d59000131aeacbe69708dc2c7581dc21758db852.camel@fejes.dev>
Subject: Re: [question] robust netns association with fib4 lookup
From: Ferenc Fejes <ferenc@fejes.dev>
To: David Ahern <dsahern@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev <netdev@vger.kernel.org>, kuniyu@amazon.com
Date: Mon, 28 Apr 2025 12:23:40 +0200
In-Reply-To: <c1266298-8833-4bef-9ac5-6c61ba4dd0c6@gmail.com>
References: <c28ded3224734ca62187ed9a41f7ab39ceecb610.camel@fejes.dev>
	 <aAvRxOGcyaEx0_V2@shredder>
	 <c1266298-8833-4bef-9ac5-6c61ba4dd0c6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-04-25 at 11:21 -0700, David Ahern wrote:
> On 4/25/25 11:17 AM, Ido Schimmel wrote:
> > > Is there any other way to get the netns info for fib4 lookups? If not=
,
> > > would it
> > > be worth an RFC to pass the struct net argument to fib_table_lookup a=
s
> > > well, as
> > > is currently done in fib6_table_lookup?
> >=20
> > I think it makes sense to make both tracepoints similar and pass the ne=
t
> > argument to trace_fib_table_lookup()
> >=20
> > > Unfortunately this includes some callers to fib_table_lookup. The
> > > netns id would also be presented in the existing tracepoints ([1] and
> > > [2]). Thanks in advance for any suggestion.
> >=20
> > By "netns id" you mean the netns cookie? It seems that some TCP trace
> > events already expose it (see include/trace/events/tcp.h). It would be
> > nice to finally have "perf" filter these FIB events based on netns.
> >=20
> > David, any objections?
>=20
> none from me. I was looking at the code last night and going to suggest
> either plumbing net all the way down or add net to the fib table struct.
>=20

Great, thanks for the check. I'll experiment with these to find out which l=
ooks
better or less intrusive. Will CC both of you in RFC/v1.

