Return-Path: <netdev+bounces-262141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH2NHc//omkJ8wQAu9opvQ
	(envelope-from <netdev+bounces-262141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:46:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8AB51C3A38
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 15:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11C5E30E239F
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 14:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23393346BC;
	Sat, 28 Feb 2026 14:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+POZ1Rh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD4333737
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772289858; cv=pass; b=Qzkn2dlIGpkNFiET7TZ6rR+yKxNkXmhGJRajI/bia0uSf2M4o+znR2bRhrHYAY7B7KVSQe9aMJcZZuIs9KvTJ80vFr5ifmmP/g+ZasvFnSePmLvD8nBKOBeJSSyvBlA78SMI9eW/kcJf5xUdpYWIOeJz3mCF5p7eeHt+krz5wJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772289858; c=relaxed/simple;
	bh=FZGQzPieKJ0OmEUzH9MEqsMiXLZ0OEKh+iWDbKm8szU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUWyjR+ZgXeR5zupZ34+6Vk2pjawgSfvD8IDnSVnBDe+hWb6AiQ7xWhzGRgtNhG+7H7gpecYf6kpGIzrBe4MfqftkrAu0d//dZ4NJKJpb4zPXIfb6wFW16kxoETV00GMpiY0+ZFJ3SFUJAPVBNlFotszxTx7zGP49dW+QH/uyKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+POZ1Rh; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5069ad750b7so26463891cf.2
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 06:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772289856; cv=none;
        d=google.com; s=arc-20240605;
        b=bvmVgwq5IJQFH+B9mpNh0V+l5cfF4F3CYTv+M80OaZWiV3W+FbFQobgtoGoeL06zXi
         vr/aMyNjGnaACiIj4EtDu6eqttkjVcYq4PVLMYQM8FAJBkT5LrgGfeIW3+4xc3yOuCu1
         6UVYd4zXibJFPliFwS5IeedwML+rFWHxyeI9FzX6HzWGIDL12c3eimvo/yOB6kZ60pGM
         kTwrQSk62t4Sliz2ttAOa7jypXB03w1ae5P8ZXX9BtO0jREQpzE6WsQ6DSjvdMWJPdTP
         FFXmOdp2GxGNqbPBoatrpNZYfuXKnyQjCHr7g9plUkn31w9DSA9kEvRuCnlOplOL4NMT
         KdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FZGQzPieKJ0OmEUzH9MEqsMiXLZ0OEKh+iWDbKm8szU=;
        fh=UjRq2wbsfIWZq+6Ab8M7YHqrWO1/M+3UaiSmDXJGxf8=;
        b=SwWQfZeNWjdJxgKfD7kdLMqQ/4jAlKy87sQHii9kEnhQhGhYlbhmt+Ls0J8t4VHx8u
         18A6GIsD6u/wsn3pnYxCkzXYkDT7kMWEhSDxX5mA6mJZLCgz31n2NG0W+tvXfRv7PUKf
         jYQu51/PeBPcqUsiiH0GLBwIEsjlAIuJGqKGSN8rdO9KX5cu2TG5d+KPgvLxmxpi+MHH
         chVgQsRoLDolkBG+jE23cPydQQMUcNi+WtJ4tjQdvfUiXSCx8745TSB2obluiqwAIM6r
         38GuhSshywHKFXWNfAZpU8fu7znjtEBpIvA4zKdq3YfOQ05T1JHe5SFInQfGPR59i/dY
         vT1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772289856; x=1772894656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZGQzPieKJ0OmEUzH9MEqsMiXLZ0OEKh+iWDbKm8szU=;
        b=U+POZ1Rhb4iDb5uE3RSV7Ymb+vtPTFeWwpuFl8kZnP8yFz8A7vKmlshavVb2nfYoIl
         VMJuH6hMjVUOyhFf/0/FKAt8f88xb2vp716MBhUuZtJOplEveu+DqSa/RQBKnvGatspd
         ucsxvKU3XNjNtvmmCwxIQtjbKHPNqBZtWyHOmQSOoZ8qL3iS0t7TV+1qxXc02/KEuFDW
         zwSl42bbz57jtWlZUuGUag3/FypfDOjApG744w8Ge2KBf29auacoi161PxQzlfR7h3um
         tb2CxSDB2nu3aHcsdYyq2XezWGvCCRYdCOVGzI0KNn+HIyltNjX857y3MPE72bpUw/gs
         hJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772289856; x=1772894656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZGQzPieKJ0OmEUzH9MEqsMiXLZ0OEKh+iWDbKm8szU=;
        b=fEQ5/UIDd5XclOszFrT+KCNUTSc7TmVygTbNXc+kAdbrnw+GTC1RS+tGz/fjnlgKKz
         x5W5jP+xL/R22gUDQ+Z4PavmTsaSmhxpdoG35/T47aU1k1Q1qojEKoeFwJet3SDIMtRQ
         s9TBwlyHn5fGmkp1ouvReKuhSvw3G+Q2qZw/9BRIWA8gMGiKR0wIBeU6pd2jvpbMtoPi
         5E2Lm/skaKHccbo6qWLJcEghHKa0lAZwN01pApuHTzq4j7QwsM+rKznnKAF97g/8ds1F
         QhnxwIfvMO7MNcrR0+yauFATrlpiJsP1/24PfY5NhfLKH/cws0tqrHpI7k1D4kiN1Ebp
         STOg==
X-Forwarded-Encrypted: i=1; AJvYcCUcnvieV+2nslSzKXFYcXZDducjItvQb4+WoXsEPs/7KWYzhvHGPW+m9ByKSWsANCw+VABtkio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+nFIOTyHveeSa16boCqVbnkZIk2XpsPhMZ/JPV8yR2I1io1OR
	bLnIcf4v5V39qIfCZVetR9bwP6VRpFJzdEevzezC9h4sRzxrjSZvRLebnl6YX2yqwm0d5wl2Ltk
	e7ssBc4e+QCaW6BczJDvKS2smN2y/nbAmkl+De0UP
X-Gm-Gg: ATEYQzxQesIgMxw4c/Bj36OdBaI6WucwcsuZx2SVg1UrgJnqmhNzKxLPA1FszHYMOUp
	aLIKz6Bk3emCs8gxXRM6ypZ+cKqUw85QCbDNzfdAV+9B4HRmji7RVV4cX307mC1LAmh73Y9qn0h
	whlYoO3eweToqVhn0LAA+0/twHURpVRqn177RnEVwBPnVt3Uc0qtRERK6gjXvjXrTrSwXaadbLQ
	EI0JQpmaowAX5O8Q5g1i4pyIQpMRHEaNZ0OZNifO2WBSH/S0MRkI96a0nfqPN9Rj7/90yNWMzUA
	Bfh9c/4f
X-Received: by 2002:a05:622a:138a:b0:4eb:9eaf:ab4d with SMTP id
 d75a77b69052e-507528a8351mr80941551cf.62.1772289856004; Sat, 28 Feb 2026
 06:44:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227033903.3307272-1-kuniyu@google.com> <20260227033903.3307272-4-kuniyu@google.com>
In-Reply-To: <20260227033903.3307272-4-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 15:44:04 +0100
X-Gm-Features: AaiRm52PPDdnMBK9dzx5jaDqnnAoqhxPNQgs1GixcBU-UQLeE7DKtAFgKZzDqsk
Message-ID: <CANn89i+nCF9z3L0sGfyrk+vQzsrLMS=mSPT12pGbp9Nkq0HZMA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 03/15] ipmr: Convert ipmr_rtm_dumplink() to RCU.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262141-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E8AB51C3A38
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 4:39=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> net->ipv4.mr_tables is updated under RTNL and can be read
> safely under RCU.
>
> Once created, the multicast route tables are not removed
> until netns dismantle.
>
> ipmr_rtm_dumplink() does not need RTNL protection for
> ipmr_for_each_table() and ipmr_fill_table() if RCU is held.
>
> Even if mrt->maxvif changes concurrently, ipmr_fill_vif()
> returns true to continue dumping the next table.
>
> Let's convert it to RCU.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

