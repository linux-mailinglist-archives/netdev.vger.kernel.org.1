Return-Path: <netdev+bounces-247484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAE5CFB2E9
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 22:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A2AC3003B2F
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 21:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C731622A1D5;
	Tue,  6 Jan 2026 21:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKELlnpT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4346C7E0FF
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 21:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767736674; cv=none; b=s6VunEWoI95G7yrOLjGDFMoESjezaQktpL5V1OgWA63eD3F3bvsxm+SidoxWsbHq+T0AsKjIrmLOV7u14pPCMcSeVrzsYVseFC5EgNOSnE5/Vubmpsa5HVcpDFvuu8ULBuanBrwBzV6syydf4K4RX6ytZhISSzRwgBa+rz25Ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767736674; c=relaxed/simple;
	bh=QtRHl+TqH3BbF69bW6YLvD5oYvh2YU33RkOyJZ3vQWU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=DGr8arbsLLgo6uYwEhrQBvpBmg0H3trCwMBy0fo/KMnQx5hxTiHJ4KCy9Gb9f8APY73vt1K+RRNm/2kB0LQnCLBzrbbDWtmK1AjhTXqsYSZrHGRRzmZ9QSZeuQkMLM8e0r9Er1FgWvTcICeM9ayzR7A7BAXAGVj8auxiMPqXkpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKELlnpT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78fc520433aso16648547b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 13:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767736672; x=1768341472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtRHl+TqH3BbF69bW6YLvD5oYvh2YU33RkOyJZ3vQWU=;
        b=mKELlnpTzclrOAvVpcnUG73KXmOrNn3i9PgXo3Chg87SI81z7uZ94Fgk1iLXyIbo5/
         nsCL/jOA2mzsmYDMVGvN7xODoA5AGifi08rfYUolbCk7Gk6oms3vXc2dXPxE6x1nBZNP
         S49otC9np8IiXRpFm4tc89ynijkkDcH9+7OZWY7iqEIX7ZqXNAm+KlJjHMgrxD6GXYDO
         CbKEQUyGL+4ps2GwatnrIIDaOoYK2LnlsGZWzVH3FZyEeJExfQLwTMbyd9knr2+gft/I
         D/DhTZ8l0i4wGsokTuybo0kqmQBDWNPy/V6fykKKhHTluaAtsap8kahNzhd/8ue1FIrH
         h7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767736672; x=1768341472;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtRHl+TqH3BbF69bW6YLvD5oYvh2YU33RkOyJZ3vQWU=;
        b=tRrXkl8zOlLnAfTBaM/4BnxDXvYNfFTz7ap5T6KUtaySrexo5RTTKS2P3s1iLooD4+
         46uZFGqGQd9wzaRvPhn1mI0lR8zkUwHhQa41JZj+FEiEHdgfx27YOE/25zIYEykxcMLt
         OPjYK2+rYFPyG7pcJqt2fpn8qScX77UfSUIfBC/x3+aP8zq/lCaJOFslbWg+iQOpAwBF
         HWuzpHPQdAtkpD3eY9ueg1WI3Tns4b4ZR73vfc5JkQ1qv+qysLHZE/AR2qXiLKtkjZT4
         +sLqRa8LXAor3vd7fBm9ZHR91MFbNsecsuoHqI7UdMWihWzg3IrK3DovyGhs7r7GKxOd
         e3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCViJfks8ks5Y3z9Q1JrD7db6d+xFnjpcSjx11azGks0hozFu3e2+BtndwJPNMGjzsjRmzIMITg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1wTbjJVUrG1ty6exS6k6Gvwa2qDS0+APa0hc51rsdAKKTwsAO
	um6HsKQb7gMrutSAKvI/t68QV2hMXI8mT3nme7aHpcth+XNlxrSgUqbg
X-Gm-Gg: AY/fxX5AyaH0tr4txCOIEzY5xLQTINkEykGRdlGpHh4UsC5qPb3G3mxlhEJL/bvWm9H
	5HQq1nFoXjGxbFfLbueOhpqC5yjXlokDQq+bRcev98i1TKmxcFqE/wCe7SEVhIpeUhBIDYUCOCF
	TKB2e3Vx9eVSBKemhEHUtxnCeXTZhfPzSzB0GB1nLFBm+D++vDCU2/rJw7pB2o/WBqxlZ3rpYr8
	1Q5sRIv2vDKs2TXQIxE7D1V8fO+xDk2F/7P98gfDzTeL0N17ugMyseRy8/tlaB1gDmBHgGAl/6T
	xHoId1LnAnSelmPPDyih8dKTW4PRWOhZLT+vhDKvxPtNss1sL7H1lshqLrW3doUYEe/ZRlM9E9q
	od0ijstDcw0V3igLxJm+wkR4ZqqIhADKZymF50NiRouyiwevBx+Ro5zJRWqqlhHyOMiw1Ptmer/
	4E2WPWSSI+sO8ijIr54krUIGJ/HiTQ1XRTLOjHrhE31KCq7bk8v/vZVt4yxco=
X-Google-Smtp-Source: AGHT+IGPP2ZfufrjMJIu8il8HMvh1qihAAj6JIufMI4ZoaJ2vQsmnb+U/uUqvs7snMDlvqD7mn/EPA==
X-Received: by 2002:a05:690c:6e11:b0:787:c9a1:13db with SMTP id 00721157ae682-790b5848126mr6167527b3.65.1767736672244;
        Tue, 06 Jan 2026 13:57:52 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-790b14df5e7sm6320257b3.7.2026.01.06.13.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 13:57:51 -0800 (PST)
Date: Tue, 06 Jan 2026 16:57:51 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: =?UTF-8?B?Sm9uYXMgS8O2cHBlbGVy?= <j.koeppeler@tu-berlin.de>, 
 cake@lists.bufferbloat.net, 
 netdev@vger.kernel.org, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Message-ID: <willemdebruijn.kernel.1df05a34fdc0f@gmail.com>
In-Reply-To: <20260106-mq-cake-sub-qdisc-v6-3-ee2e06b1eb1a@redhat.com>
References: <20260106-mq-cake-sub-qdisc-v6-0-ee2e06b1eb1a@redhat.com>
 <20260106-mq-cake-sub-qdisc-v6-3-ee2e06b1eb1a@redhat.com>
Subject: Re: [PATCH net-next v6 3/6] net/sched: sch_cake: Add cake_mq qdisc
 for using cake on mq devices
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Add a cake_mq qdisc which installs cake instances on each hardware
> queue on a multi-queue device.
> =

> This is just a copy of sch_mq that installs cake instead of the default=

> qdisc on each queue. Subsequent commits will add sharing of the config
> between cake instances, as well as a multi-queue aware shaper algorithm=
.
> =

> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

(I'm less familiar with the remaining patches in the series, will skip th=
ose)=

