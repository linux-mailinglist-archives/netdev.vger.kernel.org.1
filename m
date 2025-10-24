Return-Path: <netdev+bounces-232527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B614DC06433
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 14:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7902719A1107
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 12:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69121319600;
	Fri, 24 Oct 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AmPLI8+Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C316431328C
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 12:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309067; cv=none; b=Je1OTgurdDDUqYvqu9ddoOHMngJFRlKLHZb1jMYHM5ClS589X+Jptj1nxfOddQXAHo+LZ/ZCk1oxcpduy4TcDf30CoZxntmsrcASxaA5AYXhfzjYJpceVF8J72uZ+YKjsuUV3XAU0fy2k3N0bRQOZ5oSHoLmTruHwq9XU1LVbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309067; c=relaxed/simple;
	bh=5zj5Rdi+SQB7Jfnh5XMEcpntsfjMb+t67OYK/lXN2vk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOQTXmXz5kk8t3gCQbEqEHnHZY1eoeW3s/vw7m+t3YMxPQG5Ex0FFltv4v3Vsdhco2Dan5ydJDqm61WVv+610+/K61LQkr1b8aZKoK9qivi8b80i731OOuoWsuxxRRQCpLyNlHwtvYn92AIIxjeVbIVNC7oZzujPqUa3bYRLCJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AmPLI8+Z; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-785bf425f96so38062937b3.1
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 05:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761309063; x=1761913863; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zj5Rdi+SQB7Jfnh5XMEcpntsfjMb+t67OYK/lXN2vk=;
        b=AmPLI8+ZLUycaV3Zc6DD9Va9QcnPBzWGqBh3UNDUb2L/35/oPBwCJn2i0nmeEG0/yk
         yMtIqC8PQbC0U9o74qMM9onYhX/Yk9fTD8DhqQMLuczSEpiwlU9GZuKADzKX+XjH9ic5
         7L/dC3+6cPkFdKAca4LFKU+6ZzHSjkT7xvzKHXiH9dgOs9yy7Aj1bkrGOwUnvzoZU9zb
         zJv/HT/Tf8UTB9NGB8VSSsN7WO7ElhVPguhx6Aie4qV5iioCl5PZ3THKweBz+K4H9ef5
         xatMqY4Rt63odYh00YsNkKB6y9N1ftGf4NDoIxd0p0XYok5/1yjNne1tWbGU7TLAmE3q
         vXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761309063; x=1761913863;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zj5Rdi+SQB7Jfnh5XMEcpntsfjMb+t67OYK/lXN2vk=;
        b=i0nj1JmdGQNbTsB6ps+kmRFz5ZII8aXxedoOW3/9scOFjWIV3IMuxanHN5Qn87A2X3
         6auNwjEDPtvAr2eGgmN8ucMvfUKGDiEdrhLJFu4+K4y1gbAVfb7deGI98g/HCqm7zzB6
         DfZj9mB9AoCIf5DY+r/Ue9zV+2s5v5REzOMp+q9FYIdFAqKsDeRguqTjzcP57s/SbhHI
         q6k5gF21KjiuPh6ZIEIKFg8I79h2KUbjEPNArJFhh0vXneRY5OcUTkCqzwel7kbfeW5j
         Wpt8Xs6J9TIGdJ4PAZLMt9feoDZRsJNP2AXXTQZp7a5kRoBusZthwdXnWuA7VZ5y8hRI
         Yvkg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ6176LeZYgBc7+/IaXLVXEAISCJ19Qfsz07mfswM2Q3DQ2Z/GCLNRuITO9qgH1KfgQPXGa+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwHdTn9nWtZLNE6facZxFbBurb1bB2/YNPvGNB71gATzTepwO
	gbN0QvB34Tk7whwEb9AbksrE5Hqvxc6lB6ji+PtggaM4YM0qlqy713ywzeT+QPhIsQ8HcD4intY
	Cse0hS6fYQwihdRd8r7COzCqkEwdeg8aTsGLyTKe1
X-Gm-Gg: ASbGncvEOxnck3tevca2bTVpK7HhnsoCNTim+JDH7ysCRBQvfYcezaqVFnVpvWYdw/l
	h9NDR5uL70dA/L/c4XcUpZznGYljaf+AxUZsSW/ddGqZBZoyy/t9unp+UHIViLRyvxBmFDAQRoT
	zg6U8Z6PWwoodb3It+jb1zK7g6IeDQ78nZwP38udwzIZu9wJSBMMWCt/L32i/nhIDDV76w+ij8w
	2EBUH+4Gz+bok5/y4IS0p3zq9qkBue6TbuPxFRd8c61M6en8c4z7aKAXLM=
X-Google-Smtp-Source: AGHT+IFmXl+anT4rrPPk0HvuFlP7s6U/lF6ojxyRe0IXz7AImZgAN7HQnxvViWifh+g5Pvpmk+iAz90u1r/yCpvj0RE=
X-Received: by 2002:a05:690e:190e:b0:63e:2059:cb7e with SMTP id
 956f58d0204a3-63f42b7cb08mr1911791d50.18.1761309062389; Fri, 24 Oct 2025
 05:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022054004.2514876-1-kuniyu@google.com> <20251022054004.2514876-6-kuniyu@google.com>
In-Reply-To: <20251022054004.2514876-6-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 24 Oct 2025 05:30:51 -0700
X-Gm-Features: AS18NWD8bE7574GAUW_XizbWT1g6U6L8MzwdIxhaKTqeHw0mg-F7vLF-2zYBAmc
Message-ID: <CANn89i+Wv_tzq7LR64bN=x76=HBBmtR+GG5nDEi4fX8zokj71A@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 5/5] neighbour: Convert rwlock of struct
 neigh_table to spinlock.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 10:40=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Only neigh_for_each() and neigh_seq_start/stop() are on the
> reader side of neigh_table.lock.
>
> Let's convert rwlock to the plain spinlock.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>

Do we still need _bh prefix ?

