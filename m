Return-Path: <netdev+bounces-288842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA2iMsCHCmqX2wQAu9opvQ
	(envelope-from <netdev+bounces-288842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D365656C9
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 05:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6C673001A75
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 03:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7673806B5;
	Mon, 18 May 2026 03:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUNfa1Z3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE5A3803EA
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 03:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779075003; cv=pass; b=hDJ+H2cxtdbzxEC6CSPZ7tsp7fc8HkLr+MZ9fsJ64Bn5dqbx3SgJiBC0PeNB76mw1WHBYI2s7Wt/XjH+ob/0vVziIcTQGbXjhmyHLIu57Y68RYEqOEAPYgTZ32jRdUMxfCq0GSDwUKyuh5WiyeEOsdYRHiQvxUf7aYhhZTh8f3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779075003; c=relaxed/simple;
	bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEF3n5W+OvVtZy0r5TXBY0YqSKS6DY7pXMlzgXwHXRMNQRXuXWMdj6tXUZrb5P5Kw/V6k8d4OGl6T/3xPE4OHf4n7bbfPIi7rlOI0mjUTGLrUIG5mDeVgPAbUZ09liUykBXRX4QP8vHFs750PKgtPiNdbmuIlyUZcGuOoK2ssDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUNfa1Z3; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b150559bso13404105e9.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 20:30:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779075001; cv=none;
        d=google.com; s=arc-20240605;
        b=Cbc4oA1+nnH7C+2ptCgQOGR19U2oQXp58X06y9NU3yz2T/GNf9jtrdL/hAQVcd/c4l
         NOTYkVTsehwTI2LEYg97Vx+KfIJqZlR8kVPRJ4ZBlgdQylz9YF7SxKxYSbWA/ZLnCBHa
         Aiqt6wyAkyEaeH44UAE5xwuClB1O1bnQ2dhCcg0wnRVZPFf71OjZurw2QDW/EzPETgva
         x8N5LhGJGubpy3hYnf6/SFWprV7zvr4vaQidAol2PhjxiQkSP9t7DDWTINp6WHrQDoQs
         JVVMQ1PhpcMg6YVPOf3uK5QxpRF9GFIOa73BktJo2Wohaug4CzwaTYqcpJ5x5JRq8tUY
         f1GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        fh=xzId8rkC6ngmx92gccElkzt7WUMmOoLFdwqoJQeatjU=;
        b=PYOmaZobW91spkbhIAyo/btNk2FHPtpMMCRs/CzFFkcIAE2yPxPu2RVBhT2xVT3ite
         7/jRGFDjJHG0Ys33Jrleln2qPwY3Az6qfQ9qbFelHuZF5pnlCvK0W1iXDDrhVTKrHGz6
         pUIgwYVdqbbpHlZpwnEGfzQYJp1uD4/vifx3b8Qs260tSmGcWVNTYWURS2oo7HSk/pdr
         jcdXluxWhfHSdJmsCH6X3k8VYhVh4bo+L8eStme2/mCXtGfrVodDuLJtEVIvXpynjg2V
         gWyBJN4TITRg6WbAMJRZq7gU0l7zry5RD3SMlxh8rwGCEEjUybkfcUSIJRgH+JFeE4u7
         rBOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779075001; x=1779679801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        b=IUNfa1Z3DM9Bh12g+I6TcllOzu8J/koiqn56iX7+DLbJu0VXaiFl/l7Oy97Qfm0u17
         xQzLHuer/I2vjy3DKKw6FzxEW81cJ6pEpB7KW14g5ZXKFN7oWKG7OuAWOSKz6gTusHf3
         r+d/oQdqbzl25DuBkSuUb11kyPCgY6N7nY6u6mW+lG+xM2S3/mMD2DPsi3d5d2YqVyRr
         BEWYgpDfYurKLER8J3vyVLBZ2mJLKZTyD6z7YRRfK0T0eks3WuUv7niTrQYRFC6sBpJy
         cyreFq6xqwgIYMn1Zv0ch9Y34heYlMdODr0R0cqx0y7o5ZOLxxdBi4qiCOhuryiTyKrR
         rzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779075001; x=1779679801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ah2or2wqmpMc/QA9Fh43Z3aAuzOVZJMZOOpqKfpS3T4=;
        b=onkyQflkQDnrzofiVucv9+CXHdFc17HA7c7k+V7k0yl7Y02e8phDCQhXtukIA28OaU
         /8L7AWM8DukIkd3Yr3vLVcYGbdi5smHyvKqx5yWQXh7gOx04nBkHwj8NQ659ck8yas+4
         BZWdoMHCkr9RdWdXV9I3pjA5Xp0XW0LUqm2QtO/eTDP3OKuLtwdneApzyFRcwDVtC6wG
         pQKiXotIV5sPpKO7sDinYfLFZzBBUh8N1h+V9lOQ4fNNciMJAO1r4Q/KyU6W6508YNDv
         kqHBjUbZfmdL41EunrdUMfgP4vaQxDTb1rzOFcSOjTuEAMHVKJmIt9eDIbCkTJUvrjpd
         VTsg==
X-Forwarded-Encrypted: i=1; AFNElJ9vdiyficHiPUvhiQs+E7gh4bnr/UL9SI9DAcYuTQf11rJLAOrhuUCgnnR2ru8RZH7A4N6Ynlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWJapPZoM/Sg73U39FZ9LOdfsS1+Nqy3BoIAeLMr0nzSgGF4Tp
	S4GVI1UOc/yIYCMafXSwNN+GuL3drwhxl5dnbned/7uRTuDffnz4UaYYdRVCqgR7l0kVQ4QtXYt
	1mZi2g54tDsgUzOXWG3x6sbmPTiXb1uo=
X-Gm-Gg: Acq92OFkUgHWgcj3Lc2CxJPnRkQT18yaC7j1YMuvZVAoDGhHoEBPYeSGYduHjE9+Hmk
	xRInoMbIkfV8auTuWEx39cgA4PKXptlIqaqbUqqqgkWQP0BYm8c3XggvXPc9K3iZXmPxRNtRDlc
	x4gzHuA0yn3qhny4bv53UAv+jEtYzcApL+5hQ0SlAq3mK8Vb48x3rJ1TyvkzSKGHOJaehc77oMm
	ANy+B9e9JniqL5jc+VjeVsRKPSsyWLg9ZQIwDmAX7azucn3yUWa7AM9MogIt9sjn8J3urCuojCz
	HA6c8icV47/Y0DvSc3YWK5eOEoreNxnqSmBKZZzPZCLX0a3GDu5vCET+CHSkFx/gVSRrpIh+7R1
	7di9UMuEwAY9GDWPMS50g8a8rPA==
X-Received: by 2002:a05:6000:26c3:b0:45d:b14b:23fb with SMTP id
 ffacd0b85a97d-45e5c366f83mr20413156f8f.11.1779075000433; Sun, 17 May 2026
 20:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-1-yuyanghuang@google.com>
In-Reply-To: <20260515071504.2054786-1-yuyanghuang@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 17 May 2026 20:29:49 -0700
X-Gm-Features: AVHnY4IEM0nvjSnXzFwg7aWUVavgM-pZSVaHMNKMxqjmbw4PkrOQcMdn5z4rIOY
Message-ID: <CAADnVQ+Mc81ciE+6i4Mvg5h=fRNq6460w0-NAw_bU12oaBWruQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] bpf: Align syscall writeback behavior with
 user-declared size
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D0D365656C9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288842-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,lunn.ch,iogearbox.net,gmail.com,google.com,linux.dev,blackwall.org,redhat.com,fomichev.me,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 12:15=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> The bpf(cmd, attr, size) syscall copies up to 'size' bytes on input, but
> several commands write outputs back to userspace unconditionally. If the
> caller passes a short buffer, this can lead to out-of-bounds writes,
> potentially overwriting adjacent userspace memory.

The whole thing sounds like a user space bug.
Please demonstrate a case where this issue is seen
by using libbpf APIs.

