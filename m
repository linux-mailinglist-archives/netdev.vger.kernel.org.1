Return-Path: <netdev+bounces-251687-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJHOFPAscGniWwAAu9opvQ
	(envelope-from <netdev+bounces-251687-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:33:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E7B4F23E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 02:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 735BC8AFC79
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 01:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F8C3009EE;
	Wed, 21 Jan 2026 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsL66bGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9D9301037
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 01:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959180; cv=none; b=nEr199+tYnalZz95BqCxwHP7V0oPDEBNHHX/IF5/JUT/kcSvSJnzM8/fLhA4gG9UluRpiqGqyZjzKuj9MlVcz5IsqpYne+bIRmdjwSAmHMzZIzNPt9X92A/SY/Jk5tpjPs5m+FijYIImsMTBkiSsXtMU/nPfk2UH4lw97j0t3Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959180; c=relaxed/simple;
	bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XCDRF5+SOsGsFuYUFlRwV//E7yYu463xs4Zninu//i97WZIteehaIsgJMJZhaG6nqoNQ4kx9ThfiIekx6UZ1lS1DqnZ1A+9XvZzp+pCLCnVc4Ugh6F+cutEJkba/aXL5cuku6CIMUHTSI8b1Vy83ldhC0fhSaknyRnhlboHq3jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsL66bGD; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ae61424095so5995627eec.1
        for <netdev@vger.kernel.org>; Tue, 20 Jan 2026 17:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768959173; x=1769563973; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
        b=nsL66bGDl5jBZ3i3dYtIhunMBjsiOoQ9kL2L6NHXfTarSY5ZmS87UelzwSk67u8cCk
         uDk8rLK5Ublm+xbCtwTikS7fIb+hft3zJJ6SHZxJrki/GlYZnOIVwkuiQ0rh6L4eiHit
         Pxr2sVvQtUEpTxnbvWlRNorKK5ifc8e0D+83EWQF0gsfCWWfpTwXhb0RAKEDxMfzKZ0E
         49t+ZwXTpW4zzu2WJA9HepGEKVz0zPh4C7fCizMy6PC3GbXazNemXi8yGYeKc6vg5vZN
         juTOMAUXqn5Aia95dhqimkH6gjcWxC/SZIuG4iOIVDgKso9fjsJf/47WH105HL1gL7yl
         UXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768959173; x=1769563973;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hT9gGp+GTStA+p0XTftxURymXw7pEgxx81yY6VDE3+A=;
        b=G0iWzYQN59Ib9J01Vq4sCb+coJyLygwac0g+341SfmsaqppD/Oi/VXK48Zf46W7oiW
         P4VZvjdRkWP5U8GYxtSKgUpkMhq9Pwf9N6ziahUCjIObUNQP9hOVLmxtrcF8xo/yD1Uq
         JUZEMa8RcIahtqhUq0wD3JU76rOg08CJ1LYUtJMA2Wrk8hUi43tC5W2vGGiy8yUIpOWY
         FkBak0ZCh/9K4xB9I44wxvxQiPtVmW9MleQ4YIpNmpNhhsnzj0nPSJVbFYGv9B6s/E0/
         dmnLBhyR8pnFjxzyZIXmGLKu5L/4sg8YVf/5dPYpGaPjbkX0S3gpa8HP+Bfeig/QB3ZH
         fpRg==
X-Forwarded-Encrypted: i=1; AJvYcCVpMD7oM+9UAtYcA1MyCZg/HjJs4F+XI9shylwgHDZExjhm4eNyHOd0CAZTEKy03QuhpPhsmnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMJdmeqgad/br4NvuJlVc/oDfoxwFbInsf5wNgXWTsqHpDvXqU
	hjmWfcxqCy/xaYiSgTbwpwxwrFQG/mvGMh3I2ctO7FQpHAbdNmfSsYfE
X-Gm-Gg: AZuq6aKk7XdKzZYCx1S939TwjMrBSZas6ljxAxLgmbn95XxOnt+dnxJ1W22JB3cZEjl
	OB2sCom2qIL+SZIaXnvTakykOuWI5KPpLhepgIVW2IL7uVv59yyqlSzS7uaSmWwYhytSVE53JGW
	MCOG3XgMw+ZQ5EKKH+9p6YKjkP6RrSo1XUd4ah6J4ROu2byzzYkxkRw9u3d/+B5JKF278GTKiy0
	HEO1UT+sOp6VYx5IpdHHnafGOaaCBLxXp1WPQpFjW4VKmgviIOi7/68DlQXCXdE1vY+w0Lc9WsT
	ZxOs8ADUbYYLcQUYKnWOaJDpykVQGHRDx6VHkXn3EYMQjHEGGNUrLCETn4oxh0FIAZYm3PruIkL
	Jl2J+AoC2XoO7XDsABQ2eufbb6hkKqopC5uU/nC9SqiOZjrUFd111jiPEsEGqpOV0bAWGzpTeAh
	Vft3sjMcIrH9pzUNjSZHuHjkGOILLqop92ar6wHlZCtyG9TPSOvHtXqvSKXaFrNKiprMOm
X-Received: by 2002:a05:7300:690a:b0:2a4:3593:c7cc with SMTP id 5a478bee46e88-2b6b471331amr10168060eec.12.1768959172969;
        Tue, 20 Jan 2026 17:32:52 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:6a7d:961b:9e54:4392? ([2620:10d:c090:500::2:634c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm19194701eec.1.2026.01.20.17.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 17:32:52 -0800 (PST)
Message-ID: <bac96afe1a99c6a12cd85285c677f4eedcada066.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of
 bpf_get_current_task
From: Eduard Zingerman <eddyz87@gmail.com>
To: Menglong Dong <menglong.dong@linux.dev>, Menglong Dong
	 <menglong8.dong@gmail.com>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 daniel@iogearbox.net, 	andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, 	john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 20 Jan 2026 17:32:49 -0800
In-Reply-To: <5071056.31r3eYUQgx@7940hx>
References: <20260120070555.233486-1-dongml2@chinatelecom.cn>
	 <20260120070555.233486-3-dongml2@chinatelecom.cn>
	 <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
	 <5071056.31r3eYUQgx@7940hx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251687-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eddyz87@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: F3E7B4F23E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 2026-01-21 at 09:28 +0800, Menglong Dong wrote:

[...]

> Do you mean that the CI of arm64 doesn't use LLVM for the selftests?
> I noted that. I found that there are other similar "__jited" testings for
> arm64, is there anything we can do?
>=20
> PS: I tested the arm64 locally, and it works fine.
>=20
> >=20
> > So we should do something about silently skipped tests at least...
>=20
> Like a warning?

Yes, probably llvm-devel or libs dependency is missing,
hence jit related selftests are skipped. Same thing for x86.
Discussed with Andrii making llvm an opt-out dependency:
fail selftests compilation if libraries are not found and SKIP_LLVM is not =
set.
We plan to address CI config issue tomorrow.

[...]

