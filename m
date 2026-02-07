Return-Path: <netdev+bounces-257781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEMoGQWxh2nwbwQAu9opvQ
	(envelope-from <netdev+bounces-257781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:39:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E12C11072DD
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 22:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50FB630166EF
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 21:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D120D3542DA;
	Sat,  7 Feb 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="agiDOTf7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919B31E515
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 21:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500336; cv=pass; b=IAFY35FHT4eXxh0ORVM3vmUDdLr6CWq25IhyIO+fpoUH8JQiIDyN71WyNaHmJwZnwNDFHINH7/IAsn5WggYk5w/P0f36r2NY9w7TZ1V7/bt6zdSQkeUs9GP9tDzlodb3qJKYRZm44xBLfp9OhDJW5xjlEt7pg3DNow1C/R7XJ0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500336; c=relaxed/simple;
	bh=seCbLpCD5DBhx1LybGMQwqMaimPdApe10oJVslMS0lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho1v2TYxxDYfXAaeXRxhRdw2uC9oG+8UDvecOjbGwirWg4nFTBBr0X0bEahApeqicQj+2GNDQJZAOCMEM3QiSs7oAmYyiHuEnPlTjlAYYiv4aTbVRPt9BrMUM2/J/1/QcrmuGN5u2uHHP+gBWy+dB2IKkq3xyDzBEhxQd8/r+Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=agiDOTf7; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1249b9f5703so2380467c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Feb 2026 13:38:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770500336; cv=none;
        d=google.com; s=arc-20240605;
        b=k4shTkS209LVWccRm/J9ph5yjroRt6Bhmd3jwGubUoM3LOXUQSJ6CK3av0loRJcjmt
         7cvr0v0CfT4jDmkbxjv8DZIWuhbLfYEYvWK0jEGXRcgUcZ5urg7bKCECcbmIFc8XuEIf
         O8ADw6UHmaAPlXLBCLOHups/Bq6lE1YlLejsSSsZZkhRdIZVvJYD+Slt/itRVzaC5WOB
         UC/vhqsMjd2UnttWdDenAEBeBGKIki7JUPTrgm3Fcofbgt6+Jqfsjc7v/65M1us8HS2g
         a/xMRiiUsWY7unGSIxcYjywNjjoizBLWHSvoQrqQI9dN431PE7qPII8bVBSIJE4faNUS
         D+0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=seCbLpCD5DBhx1LybGMQwqMaimPdApe10oJVslMS0lQ=;
        fh=9pzOxY3Epsv2hDiah+gSgfDd0xMvl2qdRM/yQwD+Qoo=;
        b=S5IVbF9JATzXicTV3fiYYPSsuiAX3CuEd34/PQGfFtYzYj1CM5eJCsVMZ3OWaZu5Y8
         ss7Gg/MPuJUeSPukPUc5hWLMCuYg335hC3SSGRbOIX4oQglhigqB4tU8xRF4XWDsaFL3
         h47D3C5liVsP58qqd3RTykzfhO3/1edlK5qQQTrrRk9webWZTyZ9CpO0NjP7ZLHqPg/i
         fGp0/vNxLKFwydj6UvFdBRF5um72KC5FIA1f3I20Jj0qFSWcMamb1eqHKnp2hIjWh5iR
         KlBcKBv9KpfAxpXqQiB/j9/mVlF+NQ+hakDRx1ALpwUptdb5B2N+QqNq8oQ7GvNnA/nL
         oeDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770500336; x=1771105136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seCbLpCD5DBhx1LybGMQwqMaimPdApe10oJVslMS0lQ=;
        b=agiDOTf77ijw5OPubwKjOkMFZ/OgvCx0hKBhVqh1IG5Byx/zLhj+nh0gTYAgeJwSQP
         /NCbPeb+7azDXqycqDUhetkA7+jV5gp7AeO4FQjais9qTj9sf5hWrdqsn6WAXEMVjdtV
         562la9YRr/z6/WU2Pj2gM+i0Wzqiy4yznbo7kxnfAIr0VPaCM4H/9fWlbwFMU6xzqBaf
         zMDdvFjZC0SNy70qAK5IC9TCryQfZbljT7K3imfOAjaUw9S4MnRappN0lByznqlJyIFa
         0auExdTgcjyor7anW31b909zGZ1TUY6Gwt2BUqf/gFYGc/LNDowxBfUpW5hcDtxn/ETg
         Pjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770500336; x=1771105136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=seCbLpCD5DBhx1LybGMQwqMaimPdApe10oJVslMS0lQ=;
        b=tv5wSomWuy6qbyUXJdIIZo548Ylkfdy2AikNLkk1dMY8lmOHXTVVUMsTn7ja7IYMi9
         RppqYf1pNyN2nr73lyujERVxXE4Wvq69TFcr0/6n1qhY97/d0YBrhwfQ5mVf3ARt0Ru2
         FT7xF9/a5Dh+sgAPNx54mN84yodh+qOdvdAwSW2ObupM3K+mFVARkG/gUWCzyu07rE0X
         dugAFcaF4SyisqHiWU4eV86RHkUKNLUmqk0uqyxtxyx6Ejbz/6QArrnRx3qeERndgerG
         ecimvWGnlPh+rKXks+WjgA2jU7l7r0yKWmJvL4lQBPq3K9PxA3TO38A1eAhmAD5OO4XU
         8A7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVI4Z88Fizya/WIBfeJMz1AKAFI/DPq+I/dPrNigQMaRd8V8xHoGN2XweSRvQKqp63peADsfv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsMgV9o722Gc+l7o66beY4PRmcIBI72qEEmKZEhk8zguIT6YXP
	HLQTmCreGWdUlaFaBwLCGumgQmwA5B9h6M/L1n+WgenZJWoYMaYIEh4/kP4DBavZSrFToEd4ETQ
	2drfXVTbEDu+zE4nxLn11yKm3L9M1olNlmnGc2lJH
X-Gm-Gg: AZuq6aLRCtGjArrdPscGo6H0ssfK9kkLH5W/RV+/6vWZvbi9mWIEht/fTxh793JPCfG
	5Ymx6lfTVThOPwLI+tIHRaaLQLQKVMuLAEKQ9DVfjlTDw/za3dpqUSTGEf65U8/wwHMw1DSHBDi
	gyrz0YgnV1dE2OEgI2011+I8MOMv6/OWJLEBV5He8/hJOdhQrv9ZF3CtfZ6STpJyI2/0XZT6RG1
	pPuhsKrd6spN04AlVJm0ij/7w9PHPtRgr1ZLnz9+ltijf6Ti40f/51vMGRqIx9UM66MQnDDV9C3
	BCWq+trGcmKxF2GJQQ2jP8ojpGxUScTKDhf96AF/jzdBHgpN07ZcP1EY9hXeOMuCEYzUyw==
X-Received: by 2002:a05:7022:699f:b0:123:3424:eb5b with SMTP id
 a92af1059eb24-12703f51420mr4121901c88.18.1770500335332; Sat, 07 Feb 2026
 13:38:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com> <20260206173426.1638518-4-edumazet@google.com>
In-Reply-To: <20260206173426.1638518-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Feb 2026 13:38:44 -0800
X-Gm-Features: AZwV_QjFV0b20B5M3zn_M0ZBZW16qqWVm-65yy9y257xWk2xzAvlUSvOySZb9U4
Message-ID: <CAAVpQUDMsNZB-THJLZuTTiymR2buKYvquKqgTtq5HA8qbA1Q7g@mail.gmail.com>
Subject: Re: [PATCH net-next 3/7] ipv6: use inet->cork.fl.u.ip6 and np->final
 in ip6_datagram_dst_update()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-257781-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E12C11072DD
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 9:34=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Get rid of @fl6 and &final variables in ip6_datagram_dst_update().
>
> Use instead inet->cork.fl.u.ip6 and np->final so that a stack canary
> is no longer needed.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

