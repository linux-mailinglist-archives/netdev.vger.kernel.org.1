Return-Path: <netdev+bounces-229463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6BBDCA0A
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96BE4222D0
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 05:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB913009D5;
	Wed, 15 Oct 2025 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NctK4eKm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2130274C
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506977; cv=none; b=mtv5ucUQK7DWEJiKkyYpkWzWw01UZDJmrpwCXN8GtQkyru2vbIFK1bSCtyIYhh85v04I8qsABLnAX/WAL16rzNFj7q1v+Ibcxw2qhdy95ZWBsIIBwWFalX2Yr7MCzULjoPXCr734ThHmK2GQCWyJmDxRoSvesX/ixCW+4W5KlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506977; c=relaxed/simple;
	bh=g/3QVjTmFWslyoKPD4AMrW1L/XFHZ58q2SOmkUByhJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OgnxWbl22RRwNwSx0gGP81b6+Y4tqmvL5TOwECcnO366jkTLcKHsn781LqQ5jMICTO91Q3wHE+tp6skBayrAI97dlmN2IQROUO294e9QlqG9+LCS2/sPm/VnfSwCLh+ZKalAWpd1HvqzBqvY0DaqQKlW9g+tIyRbfmz/iaT9atI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NctK4eKm; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-26a0a694ea8so45012995ad.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760506975; x=1761111775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/3QVjTmFWslyoKPD4AMrW1L/XFHZ58q2SOmkUByhJE=;
        b=NctK4eKmCM7RMywG9/OBW9uuEPKcI/LZBn2oWHlJ5JLGegJimeLYy+Sw46vEyXXDkE
         smfbepBk+5KJK6kCj9A1T5uwYodZmlcbAjbw5xKf2Wd8TzpfCF/yg0waSRttcipYrhz0
         ZEpFBe2W6OXcAClH+rjtHpDHXrDEX+Z1yzkPyeSwMrW1RCSjdlXbbZViIaK/jO6eNr2m
         dqTk1rURtkgk82qurODsBodWc4SRhG1aApI//CDyEGdjmrglvE82Pf4PVVhL8gHiy4XH
         vQIbcilsY9Fd82u1B0rrYKRqxGAd4ihvX1HhPh/FtjzMV+KKI7uYDvWjU/zZGqZF83a6
         POKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506975; x=1761111775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/3QVjTmFWslyoKPD4AMrW1L/XFHZ58q2SOmkUByhJE=;
        b=hnrV3TrJRQ4ciHp0NUkad2bwv++zvZBsGpM1VSp0RSl/ZtGLcG6dAIa9vmvs437ilo
         +sa/I9kaoXupYmtHfd8GkvGR3+aCJtehDqUUhls4atoM1GqhbbSHLbs62ttrqTB7ec8n
         xo0K8gHwIou7/eZCpuqvSObm0m6K/N6wvWETIo63/PJwN1zjtmm3Q+RRbW9zp/AARaqf
         7uyJqZSgKGNOMI4oMstN9AlzpFcgaJ/8gTn/W9mbF00+T/k+9xmrlk33og+5ghXBho3M
         RDwDTi5p48JDm2l2C1M96WeHvT1cgwQLybCNntwMHeOTNjJGmRaeltGzELMcwhI+4P/N
         bHGg==
X-Forwarded-Encrypted: i=1; AJvYcCVhLK3bD4I1sDnGIsqLKp2Prc7Qm1FpY3M/h+huyMGN/yUwwNDye+KzgU901rO7PhOMyulYUqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/lv0UaUl6EYuyU1Y6WSiYZwVzVSL63tDgG9wGUfz0TUgvwER
	7GUTZSY0zNNT5zwhQOWcjrPzXCLXkVB44MdotVe7PKEePmo2o1qhuHj+A4NhtfnUQQn5S+Big68
	a2vY4pFvUpcXBy9Qh4ltD46IW13Pz5xH5k6c4q8RC
X-Gm-Gg: ASbGncuzy9cnW9Jr1R0D6Wa27gAZyA1ADWy3DGyNjV7/RmQtM424il4J9RsZ/l71oR6
	KrMOSVExQNtOpbn9shf+RzuGMDXpNWikAzL9gMltSuntVLHgbpjP/o7Ojv9DZe8uqxpPw0dtJsW
	Ltw5OFdCm3otC7/beXnZnPy09XArfo18i2qjvqQcRP13JQlRd6I0gJiWw7XH6Bs1bp/dqYh4eb7
	Sva9LvAObc4WSIfHHjSmMsuY6XGdDB7QP2WpCPYAnaeW8qW2X+wSM03qtY3cEpH
X-Google-Smtp-Source: AGHT+IEKwS3rCVVQlOgC8x8ydQRKPn4FxXCYIeFSORgmyK22x6pI7Q8kDENpsIkeAv1H4DPGdToyYHC4/hRaONQ0oaI=
X-Received: by 2002:a17:902:f691:b0:259:5284:f87b with SMTP id
 d9443c01a7336-290272b2b34mr386384985ad.16.1760506974908; Tue, 14 Oct 2025
 22:42:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-6-edumazet@google.com>
In-Reply-To: <20251014171907.3554413-6-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Oct 2025 22:42:43 -0700
X-Gm-Features: AS18NWDxnXPzwp-gX513kvUCxipBzoLaJNziprDKjYn8tJ0dnSeyE3ioEKs1Hxg
Message-ID: <CAAVpQUA2TrWingw=so+MyuAe8XypUrXCiHNiWWf7G7=eY461KQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 5/6] net: sched: claim one cache line in Qdisc
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 10:19=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Replace state2 field with a boolean.
>
> Move it to a hole between qstats and state so that
> we shrink Qdisc by a full cache line.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

