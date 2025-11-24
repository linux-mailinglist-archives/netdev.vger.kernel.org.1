Return-Path: <netdev+bounces-241299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF4DC8286D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C5DF4E110E
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E132E15E;
	Mon, 24 Nov 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KmSAlocZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C0F2F363B
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019409; cv=none; b=sXcvgifE3fvoM64dOU8XXLuLtNs/yAduBZ98l1zLiq4JX7zbuGe0BxbsatdWqBVNAeREQBHu4hoX1jhubxBJadGSHIQDRuRZaD7j2sArpfRtWdq0IH+AbUnp3XpSLBRPCW7IoKkHoNRAZWU5Xl7oyzSGa6UbtboYhKE+ClK+Lzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019409; c=relaxed/simple;
	bh=NrEvzC8nAllmRrnlb+ElGF95E78Q/2Mq2l3vtMmnHUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JaaiqbYqhQu+jkb9E+zUek67ZpdqJJ2JMbSLnKpbPFiP0JkxuVpIgoKdkjD6ZcT2f7m1yU7+E5qP6GNp2AjQx0hTVaOUZzM/KMPq4JIeZsXno94lVL7aC74NnpjyofipjkWAz5hOYkVPE/7MCcCFnIWu3LJISJQ6xxB03/F/4L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KmSAlocZ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so5529643b3a.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764019408; x=1764624208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NrEvzC8nAllmRrnlb+ElGF95E78Q/2Mq2l3vtMmnHUM=;
        b=KmSAlocZ/bifjmAWS2Hg7NzW0R237yNQle6XRSV7QSgiqgWjmu+ggsQhFu+EZElZdX
         TPoLHrptMJRxHqYuss2vEGViszDYTEAhYFztDR8RX7Jf9v6Ig95NaSKonSNJf5gXZRjb
         h34RZrRwNZvzlZsx7hiCRN6pZyUdvBK2RGOuBAMJ6/G2dEj/g0n/KRoa5zNY56kPZrQE
         0N3lYnNEAQOhdYxA6ZYpt/3KMA4nkqpCH5ffOSo6PjVpUxpKxKr8nYgay1PxGACD3l2m
         fvSMYq11VPWjQvuujDfpLmKg+sK3TDoj0en5NVH2z6p2I8wSmg/zPJaGBr87K2Cv689p
         DCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019408; x=1764624208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NrEvzC8nAllmRrnlb+ElGF95E78Q/2Mq2l3vtMmnHUM=;
        b=YoMy2u+Pc4CE0lEjwIaRgcq+Yj2cgAaZp4YIjeShBqVREbQ+mW7yUKz4bNx4T1RgmV
         DpZr6MMlEKM9O8yOi8rpu30elLB/VhitJ+brVVy3CG21aiyAL4ZrmveQMKgTDAcJtaVq
         prSoNJL0bRtGJ/spFSiSnRh0KFLuUrjS8slgbbPDCEjIIo9SD4cwNIlkhhHMJuprPjX5
         7o2yE4puB8JcpjzBjzapFGkKWLwbNc/Q8T63Proh76iqNNpz8nFUi6C/qIn5hdIf6/gi
         C5neVgZGI604bRpfe7xC+w+8fnPr9BvedEZQu1Y38lSBfhvdjs5TzELfqwbJuInP+QkK
         Jp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjK4QvNi3SpDmbb19euWQ8+/nSM1ndkKMEQWgEPvNmtResqlO4PQJ44TEGs9EosOC6p6qgGdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy7QlIRL0bZ8V5e8FADD+RWArepHH00tcLB9HBs4P+9gib56gL
	Jq6oPdURZztcW6fYG7+DKl5kZwqlUprdikzWoOCSDQb48gdin+a0L+XRHRZcQE7KMYSw1ieJ/Ux
	V5fuEEPFUhqiRMdEojvablYCZk50Bnmu7cQB3evpZ
X-Gm-Gg: ASbGncvW0iFkjqBYGo92HyILyP7zgWQHYzPR13HVXHZDtDj4FLWy3YkmF7a/RMrqwPO
	KAToLoOZVyDWNRQ3eGizSVOv6GQvvMGv4pF+U+kthpK8WdrL5N4em5Hzp1iZsxEgnvM1SGBWf09
	82dOvwDLPJdtmknqtrJ6rgYvutL/7WQDAgSgO+ieiY6nXeACtdThV2qKEQE9gV8bJo8LFTJK3Uv
	E0VZd5n+hal+yH/zymA5JumbOeffxTJLAaiwsQWa02HDayZsW9JlsSduBL36AW29ollyrZnvKTO
	62aJn2RUoEwAx5TnM/8McehOCaep
X-Google-Smtp-Source: AGHT+IE9mNP1lqecI80WW/isgDZDxFBb7pWsYrkWQzM+nweu9HOz1XwP7q9Rcxu1KY+Xzd68fGSI62e15+kG20cPMsQ=
X-Received: by 2002:a05:7022:e80e:b0:119:e569:f624 with SMTP id
 a92af1059eb24-11c9d84bf9fmr6260329c88.29.1764019407203; Mon, 24 Nov 2025
 13:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124194424.86160-1-kuniyu@google.com> <20251124194424.86160-2-kuniyu@google.com>
 <20251124115145.0e6bb004@kernel.org> <CAAVpQUATnxEVBE8uNt01eih=CnonmnLwYSrEZEhDk_EEk7Pemg@mail.gmail.com>
 <20251124131228.1b26bb57@kernel.org>
In-Reply-To: <20251124131228.1b26bb57@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 24 Nov 2025 13:23:15 -0800
X-Gm-Features: AWmQ_bmbBZMgx41ViSzZ2smMusgRanv1yRmhwsv_L28K0Iulr9r8BZe6RCnDv5A
Message-ID: <CAAVpQUDeFTSQURH0TnkkcVjzTw3vMQv2JyJp1N9YZrkVQVTK8w@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 1/2] selftest: af_unix: Create its own .gitignore.
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 1:12=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 24 Nov 2025 12:07:28 -0800 Kuniyuki Iwashima wrote:
> > > nit: missing new line
> >
> > Will add in v2.
>
> Feel free to skip the 24h wait. I'd like to get the netdev foundation CI
> to a clean state so I can shut off the AWS one completely.

Thanks, I'll respin shortly.

