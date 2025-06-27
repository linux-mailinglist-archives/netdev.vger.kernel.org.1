Return-Path: <netdev+bounces-202049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EF1AEC1BA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 23:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E87A7AFCEC
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B12EE5FB;
	Fri, 27 Jun 2025 21:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cWtNBf/t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A338A2EE267
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751058440; cv=none; b=tpDjf/iPDwcPX6d6MbIqGdBvBZ9FBLrYB/Za8s2w8j7JevIe2VC2T2KNjCktvdI57CSjh3wTKpWZnezjLUh6PQNx3Ztb1itLB7o/6cMwfoMPiVuNjNffhHpCL7tlFUbWC65g2yU2+X+LejY0VWfFkN7Z9owlD9E6pFy8+6qNlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751058440; c=relaxed/simple;
	bh=6+9mamEW7RX8rTIuA7WK+C8A+HBttED6ktxsXBUmYcQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/RHKACNa0ByJUBWzot3GEWsZEhWoYA1rF7xYZF30GkTPAQenGQgQPCu1fSbJv+wiOpxq0VFximsIHzWNd/+XCB7bwustg4HtkK46AUMDW5xJUi/iADBCq5AFlMuvC1vx4+UVlxmmBjuRTOTf/U7jcAvBwPgTLQyN1QtjaVNmdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cWtNBf/t; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so430176a12.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751058438; x=1751663238; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+9mamEW7RX8rTIuA7WK+C8A+HBttED6ktxsXBUmYcQ=;
        b=cWtNBf/tu9oRlW5yNmqw4oOcmqUPKgSQFkcZXfytTA0GhP65heqqdA2F13+o/Nq1d5
         HI1IFnh5cJAXRn9ybHtrOhEhpImDZt7aoTpPjLoq6jOda2qpmfocZg6IlMmlemCa6Boo
         8uAlIbXX0ol0Pf+6tvwTBN6zdIOcVgdvsUsR5RBJ+UcBKgNJRdQVGz4wcfmEUA4MNwTT
         53zbmE42ddASfcEcryg3c24BWS2596DPlHmMpK3AObDaT8n7IqbtVSmEsw696kJVwPQu
         fAUQBzLdBRGxOHuedNo8pQbR92ZmBGD4G6EhM/yEXdDyrHY5hEtDq+8ngwcTbHVtX6ME
         uPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751058438; x=1751663238;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+9mamEW7RX8rTIuA7WK+C8A+HBttED6ktxsXBUmYcQ=;
        b=iFhAP7hj+Pu5UsPCDPmREcz9zwwu+x6EW2ogtm7H0EdKis8gxnDxYReNREIfsu9qbI
         eW8sQKEItw86UbVMWdi0ARK1nPV7BFpmTBu0UrkXFWHSYXX+mG586geatY/bklQhNG9t
         UycTPcGfRHa0UjyBcXmnASuisu30Y1wUJ17uRC+n8Gs8DqjJHqCI9dp7x8vIAptWZ0ke
         gLODIlFDG2B7rRo9qDC3KmNHq2MPyHUxuSKfruMLSuutodXWonp/DZgV4GDhDoz/o7G3
         Wbm4JUNLLlnBVGQUU54SAzO+cl2je8pVtbPxn6vr5qkyVAAYBAabPfmT0SxCVU/wlCDa
         ftrg==
X-Forwarded-Encrypted: i=1; AJvYcCWymcxda8n+ZRGtr3FS7EG79d+73ao0CMkZtenEvGf+3/L/fuii+DZ9/uUYkDcOyR2h6rQJdls=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl3t5ZH0vuWPbsZf3c8dDoMzs3Kf3Z9YPU7U2dv79NjTuJb/h7
	IHf8nOId5YNZnwvUdo2IdZXLwzpOb4vgqnbn9I6kfZX6ovQIqSZIGoLMM+6AO6gRpysQn2ZRNMW
	TUG0u2rD4Th7dInAOlnDExkBOnlYZMw45ni9fKS8W
X-Gm-Gg: ASbGnctPAu5vY03al2KoO9H8ByZROdJVkXshBHY5c+YRmVpPgZdvzrQyCAO6w6AYieG
	wwGT2N3uHuagpedhZ32CK4dbM7j4jSQjuKFrDHraARK86DlRckc7EwX4o8mJNr/4TRUi477uixf
	9qi4xIPkqBgOdxMCNyOjtFpN4KhXf8OMh6UtIDlfUKmKkcBH0wxvwabN3mSrrYP94SuHYImIMCH
	tgSoBnVojCzF8s=
X-Google-Smtp-Source: AGHT+IEC/PCy49Cw77cp71ZLsWReRtm7h4XYZSMHT0xcuDEeEpgI6KrjX3wElhrzUK9/B8dg/b54Ixvu6wgmQR8RwvI=
X-Received: by 2002:a17:90b:5211:b0:311:b413:f5e1 with SMTP id
 98e67ed59e1d1-318c93145acmr5678589a91.32.1751058437857; Fri, 27 Jun 2025
 14:07:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com> <20250627112526.3615031-10-edumazet@google.com>
In-Reply-To: <20250627112526.3615031-10-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 27 Jun 2025 14:07:05 -0700
X-Gm-Features: Ac12FXyRMEtXRNz721rZ4tx3iJSP3DduE-7eOS2yCnkkfr2lUYlf6KPivyxKnDY
Message-ID: <CAAVpQUDxLSuRo-yiyybmbWgoRFtPisvm+eptEU7DzwY5kLDCvg@mail.gmail.com>
Subject: Re: [PATCH net-next 09/10] ipv6: adopt skb_dst_dev() and
 skb_dst_dev_net[_rcu]() helpers
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 4:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Use the new helpers as a step to deal with potential dst->dev races.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

