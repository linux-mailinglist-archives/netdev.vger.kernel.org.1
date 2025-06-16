Return-Path: <netdev+bounces-198100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218FEADB3E0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8000B171CF1
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8B31F91E3;
	Mon, 16 Jun 2025 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w4+qi0TK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B71C2324
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084290; cv=none; b=GMw0sKklT2bIPV0/GZQWOmSzr062w0jUf6FLFHOE9Zmvi3qTzznPtwEzKSjb+0+c4CH8/G5K/3nre6vkxefdcnwZ9auh0UM1zz3oGUfv/kaJwMCwa8J/jxR7trdkWZ3LJn1FG7/PZSQAww+QgvCAKChA1dTBBrT0lkap8q19bL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084290; c=relaxed/simple;
	bh=hG4zWYaPLLNSSEJiY2zLAt2zRRS0DqTQ5jzGwi6QQVQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfn60Q4VQzeTSWoesoTtMJRKXyuxOQZBFipdBNIphlIERyyoHtjKjVJpxttA7EmHc1+wcMHTcianAoURU9q2FIcOLDYgYkrUMJDL5+flrTt0n6EPejVR+3fEqzhyvE1oB5b7G2HsH2pa+uLvcTd7m6ftKBgcfacG4taXjHLd1vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w4+qi0TK; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4a442a3a2bfso85849161cf.1
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750084288; x=1750689088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hG4zWYaPLLNSSEJiY2zLAt2zRRS0DqTQ5jzGwi6QQVQ=;
        b=w4+qi0TKXxF4k8FS/kty37NZeUk2D3yTFuNSbpGwIPimgEy/PxbBDWtmzflvUmYR9Z
         TaGQ9teoA6oL4vvX3Hl4qg6V1+jG53+2C0SBxZKGKsCZj/dQP36d4y+YmBKjjEKP1Icv
         wLf4UwSxr4GGiYF4jgzSzYdsSGONuHieRG96ibLoi2DleuaKS9V9vBbCN6HOreA8aTIt
         aeYO2UwNdTY+o0XeBWijqjCgx43YQvkZS1nGozV2aGWct7+sGl2+ON77u03K5CzEzGB1
         QUcJtqqwx5/HQjvi31F/wcSYtnrUvnTYvwsceX2V4v8qTfLNxwT5ptrh33Xct0AnDqRH
         bflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750084288; x=1750689088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hG4zWYaPLLNSSEJiY2zLAt2zRRS0DqTQ5jzGwi6QQVQ=;
        b=jQucKSsVdU3nWapOXi5UZlGEEQ9rRH0xgstuEohS8bOYcNNQD3L13Mfb5Nb0IgMT0Z
         gmb3+HOmhC8oBkKPpzDiQadT+aX1VdhmH2/ExPmRpna+dro/FyFx2a8PvkGJxpdmMiNS
         OCaJPqKTM5EM00sMvhkdyW+3a4jK0ATqL8/tlUHBHUlXgBgSHqEQl3fhQNOXPfupMLTX
         4YzqmI5Q19bk9+i9yCrPYU8nbCNeFBTeDSrefDQvCoN+04bsdmSVgfAGCMZMdUkZsAH+
         kJYQiThcg6KlKgmD718sQvQe4W6XNtkrKD1RnJ341A5DIm0FkFcwngTPCWhojiNTGJWn
         HFtg==
X-Forwarded-Encrypted: i=1; AJvYcCUQqZB6l+PxYAEYGU4NWUJHAUgTZOtCQkKiLssVYVewZSCCh5rAGQUkt17zbahtYBCqn+0a1RE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHk20tDtaRDx/QfuuJYuIHkopNVZNva6zEFZpq5p441KVombvf
	MgWhkAXMduJyaiRCfnZTSmV1aF54yixT6LEaGTaZWoTFqoZUeLN+dBA0D4GSDnCX0wIkfK+HRJC
	RpP2EL3gYYDS7xIZ6ihny55bJ3e/Vx8QLgF2vc1jq
X-Gm-Gg: ASbGncuNgt5jszm3LsVpxf1Vx5ZE0Q2laN8Dd0/Hs6TeDmDhVeDIo1RjvUdGW/CSl3S
	POME6/6QvqCp0ZtYwZ6kQ9wDEMPg6bafs3fuzGW0nr5fdfDgjdDz1PvVHQAki7tAtxEN+dnNKLQ
	5Igacy1XNJ5lyWAMqjzj0Gdjhl4809hNHozPGy3LlhQLCJvQtDowNenSbN5Ls5ACj0SvZ4F8F3d
	15A
X-Google-Smtp-Source: AGHT+IHCXay6zp4uxhdFgzMHeaKDxRu9Jx6wAWBDQvLHFz8z4Ll1wUGUZa4nhEZmhB+gEWzZWChI7OTSBOMkenkPzFs=
X-Received: by 2002:a05:622a:c8:b0:477:4df:9a58 with SMTP id
 d75a77b69052e-4a73c5936bamr154928561cf.18.1750084287744; Mon, 16 Jun 2025
 07:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616072134.1649136-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20250616072134.1649136-1-alok.a.tiwari@oracle.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Jun 2025 07:31:16 -0700
X-Gm-Features: AX0GCFuESG55Eq6siZMh55BPaOCSjihuUmr0dKV5S8eb_NYAkSei40pkyINoRSI
Message-ID: <CANn89iLQdB5Qmd2U=mk6SsG0=GZqVYYP1YdoXqKxit4uRdPC=w@mail.gmail.com>
Subject: Re: [QUERY] tcp: remove dubious FIN exception from tcp_cwnd_test()
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: ncardwell@google.com, kuniyu@amazon.com, davem@davemloft.net, 
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, darren.kenny@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 12:21=E2=80=AFAM Alok Tiwari <alok.a.tiwari@oracle.=
com> wrote:
>
> Hi Eric,
>
> Thanks for the cleanup and RFC conformance improvements.
>
> However, we've observed a performance regression in our testing with
> Apachebench at higher concurrency levels. Specifically, throughput
> and HTTP tail latency in workloads.
> It seems the previous exception for FIN packets allowed graceful
> tear-down even when CWND was full, which is now delayed or stalled.
>
> We understand the motivation for the cleanup, but the change introduces
> practical impact for real-world workloads relying on timely
> FIN transmission.
>
> Would you be open to discussing potential mitigations?( not sure like
> selective FIN override, other approaches.)

Anything relying on being able to send more than the allowed budget
will break when rules are enforced.

You could try to add an opt-in feature inflating CWND at
shutdown(SHUT_WR) time, anything not in the fast path might be
considered.

