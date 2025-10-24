Return-Path: <netdev+bounces-232529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D477CC06451
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DF4D4F28C1
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874933148BE;
	Fri, 24 Oct 2025 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JSi1zaGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4752DD5EF
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309125; cv=none; b=Ro8m1MeaXx/IMinfBctfch3fIk5ImuoUfHg1NiGrMr+7h7AS39iMzvlKP9vHFlXUdudzkJYZi5YZj06xNrEwGp0m/xH0gCe/XBUYYUO3POADcZLHByuH8lgRsyrvnCPCClIdjhg+c/RZVcU7LCfW9rFyVWSQ6KIsbzqZI9jBxh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309125; c=relaxed/simple;
	bh=7gLYHRhoow2qKgNmazhQw5eqd82SKJYSy8cdKXaqBYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pqofCq1hbK5MkvBrsxQ+krC97FhlRIiQFey2RDzlOzNnWgVCw3nYSyRKTK9bYPd9xJtIjFTBpcc+mAq1ySc/qsPqRrVCSdrf/UjAgchqQfechCJs7liLe6nGs+mS1sUFidbYHL2Np80Ouud6Sev3q1MIX1+H1qPeV7H4hOnyV0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JSi1zaGo; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63e1a326253so2183872d50.2
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761309123; x=1761913923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gLYHRhoow2qKgNmazhQw5eqd82SKJYSy8cdKXaqBYQ=;
        b=JSi1zaGoJNgj0bVTQrj9ukdkIQ153vfOymcR02TjmIG6wxmXAhoeZ25LAUqrP92re0
         CQuCtzz4krW8EvqAQ1+HnpoSuqJfYn0n/cnIkN0L/6OTMIk3RfOQWWV2yh/UEmOiUY0F
         lDTse3M3PaHWEcoIAUnL1C6bIV9R3HbE353JdEZNsISnl1nZq2KlRTd44Y2e12MTAC2W
         viKw/w/MxywjkHgO4SGfz476eLAkV33/Y8jqqR0wSLElY94xxOBu/XDEVpW8HAqeD8UL
         AESU11uXzChgQzeiLD/0ttjMEe/AjlzVEScaQtIBWU16uEfVa1LHALLeoT/A7ctDaeuE
         ljIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309123; x=1761913923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gLYHRhoow2qKgNmazhQw5eqd82SKJYSy8cdKXaqBYQ=;
        b=TAXBXJoZqBdCY0aB8CDiHpD/HXBUD88dGGyNTkm+gpMHnnOoDFzzNO4rzqXSTfSwXe
         yQnQknQotdzaxTc2rUDrVaTgLRGN5kMLICXLRQAgzJSzpUUFV8CikbK8vWzi7WHeyiK+
         p0TuRB7EadBX+bPDXwommhWt1IWZnnKJlN16eQBpCQcov5adL0fK+5lQqwnZ1ICbBVjz
         ZdTLZ6ukUK1f26soi6b2IyXv/oD/ZyzmZmYIAbP91cs47tU1fOu+Cd7GOl+lRyBrhqsB
         X4i7bVnrYZvlH9iTwlzeNoDJWPcWwwJxticj7zGYN0LdLBoxzdDTYmna09+sgdPhUXxT
         IvJg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxBxEs9vt+opW8nigD0qCHZaUPCxQjO/ldzcZekJb93NdNw2++dfzxurGhBM+b8FXLjGBtxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlnRmV2ZTH0CMa8lkcISzBuQW6T1Jd1gNhkehEHakFtGbociyV
	+9J1/7kJrJB9Z8gQibslZbbBB+Qt81Ay/OrqDlmCnZc+w1OJQ0TaT8S7w7KqJcChFmw1KFjmeD0
	2FUT0Rn//HRYiSMoRfFJzrUu38JK8bDpTRbFjasRz
X-Gm-Gg: ASbGncud9gGn2BtxZtLlTDLPyJrZvg3fLINNf+BaoxXM3MirQPZ5htW8SUZprLwIMCB
	ZVRHzjRUJAVTM/AinPuvXgOSN9FOyC6Fx11TbtmYlwewAMS88kwr6gWmX8Dx7fP3HqnxfT2BP3X
	huQfcCgDHUmF5qQ0qHCjm8GW1XypHde8iu4iwYzDtrnRi6OHmOUcCpRbEnnyypze8lSn6NbyH0c
	ODQ97PhqQ2KDX5y6JwGDwwszRoTjGulXNFrNjkMBujRy6KY4DsopfDgcvhggRdCKOlLLg==
X-Google-Smtp-Source: AGHT+IFEu8FX/AbgejU8y1GVfudXWrqcu+Qd39D68oVKUszWLMLZaQeVfTuXqQriuZQnZpAIx802ReGhWXK3o/TssCY=
X-Received: by 2002:a05:690e:1403:b0:63e:2715:5acf with SMTP id
 956f58d0204a3-63e271560camr18363155d50.30.1761309122605; Fri, 24 Oct 2025
 05:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-2-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-2-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 05:31:49 -0700
X-Gm-Features: AS18NWAd1D-YboL27KXOQ9_FTHv3iyyJDg5eKDUMmawJP-cRVK72FeROOybylEM
Message-ID: <CANn89iKRwd3_2AcD3bR47VmgqQObc2y_7Z4OimDRMw05d4MLww@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/5] neighbour: Use RCU list helpers for
 neigh_parms.list writers.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> We will convert RTM_GETNEIGHTBL to RCU soon, where we traverse
> tbl->parms_list under RCU in neightbl_dump_info().
>
> Let's use RCU list helper for neigh_parms in neigh_parms_alloc()
> and neigh_parms_release().
>
> neigh_table_init() uses the plain list_add() for the default
> neigh_parm that is embedded in the table and not yet published.
>
> Note that neigh_parms_release() already uses call_rcu() to free
> neigh_parms.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

