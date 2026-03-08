Return-Path: <netdev+bounces-265220-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9cC5borGmLvwEAu9opvQ
	(envelope-from <netdev+bounces-265220-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:10:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D022E65C
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 04:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67F593012BC4
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 03:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F20285CA7;
	Sun,  8 Mar 2026 03:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BiLF6UAn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21E4317D
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 03:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772939409; cv=pass; b=hkcDuneBSZLVEbDsGI45VE20aE1+5xhNBgqoiThYyfYwgR5gVi/6w+i1KoEXnne/TJLPqWufphidnHQnlYo33rwUPFOtZWe0dDJxasxLiwaQTsf+TPv1gQ1XYdMG+cIj6GBy8rvow9yjbpdChVsrMPXnT8ffbLKfGhSNJcR8VoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772939409; c=relaxed/simple;
	bh=OloeSfukuJMnikvS3cfN5z3KbikGEaBj7UsAGTq7k8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m95/HQnliknyArbTCX/ZtZsg4d/+e+kON82Hy77NNjMhDYYj1zuHA0aiSBrcSjApiMMMRv7OU+7JbSRNPmf7IOp8rulWb2tMNhOrOPLVxlwSSfbZwGBbMdZq8EGR420lyWrHFmto7EXp2L1V6IVmOr7FGfIaX/karHoLpAlLoEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BiLF6UAn; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-12732165d1eso11486930c88.1
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 19:10:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772939408; cv=none;
        d=google.com; s=arc-20240605;
        b=cCTSxaBjkiuT4oUusGxWgKM4I9xX8CBLLqlomFr60fwhHrpxIvlz1+61SfbkJKx/vt
         myFvsoGGHX5BpEX4+Zf5OK1USsEtwbAtnGMV8ZUkhhXrIV0yfyxWGcActJil0IlAu5xW
         bz726E5z3h77FVHM5Npqi3L6vryVPilPypw70IKeuBnMcgDYG+avcHjw6u5ZRQsBxto1
         Iz1Bd0QKlNM2usvPxmslTYE/Ydcy2FdlAgXEu9xPrCo50QElNmbpX1C6VSLpQ7t7H+C/
         cKxi1yNtu2CUdpg0xlgjMEEdqH5KbwFAsyGulBqs23O4o0TCMhSKzyP4YpnHAKJHiCfx
         do1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OloeSfukuJMnikvS3cfN5z3KbikGEaBj7UsAGTq7k8Q=;
        fh=CidkwCfprw7pmp/rMO/G3sokjTfGBWlh1Pge/uHs9tE=;
        b=bhRVVBNevcN3AWMJ0NCRXzWnsKfRwpoe0q2jds3N0WKQgKEFi8VLRcJ2QfI4/Tf6al
         alN9Kajfgw84RWjUuCwpvzBT31AH2Dku1wqB2bLGtgSYP1dmO5/Cpg24O31CheR/fmYF
         puiWKpX4pw90YtwBSnoFEv+pTI4F0qLoTg0/EzG7/sy9Lj8K+RAgq4EB8+yy//sAGqby
         8GJmxHDxJx1pvfr4Kiy2Q6k11sJWxxehb2VV+NgCuclzKABMeRAjNp1NizOSOq7+m0yN
         S5mXHGqDKisQRlcnBEoyUPS9fRdvNrOQxtxYBUNje6NrrLi0f0tOvNdHGAFjS64iNLW1
         QhOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772939408; x=1773544208; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OloeSfukuJMnikvS3cfN5z3KbikGEaBj7UsAGTq7k8Q=;
        b=BiLF6UAnYRBRxCoCBVG0YCSGr+s72U1G+jUZIIYKEQqGXR9GHsm5KzPTyu2dXHBWpP
         rBv7IqlLzI76AdcxLVUzZZ9pELu3ET8aAnRYGzT90BO3qp0oGTYiZGplgot30PXZvrMF
         IW2XVz2P3iAq7uPUN4IEHhCHNqN+2D6aTVdmlBkszsJ6E2Pahcu62Q8MbOL/58GD0ZHC
         adUwqZbtpMkhJgGC3bCV90/BC4jUtO/A965dQXfi11csbCPSPI2p9RhXu7Tf/559Tcuo
         OJ+twK0mUKQQi4ECJJa9SxrM2OboygD/XKy5aGapIJgB/TewXcbUX/6s0usIY2r5aZFQ
         CPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772939408; x=1773544208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OloeSfukuJMnikvS3cfN5z3KbikGEaBj7UsAGTq7k8Q=;
        b=EzSAGoTQFvjtETbWanb/nWa+EEhbdTfS+5OUJRPp0uBDGTuVDyebRdqxNNR+5DMFdj
         egSyXLC+Pg7AMPyQc53xPxrNSphWj67/EU4laaSmVWFzmtu1KVPD5T4+nAab83TZde+W
         JXQYWZJOPN966Ra8DUusYAHIqJGb6vRItDXS3Fkn1MzJZBDhTuDLD19mE6pRow9g5fjb
         4GmGcMo5kiSWprDhFyTfL9aDiJjnrC7VtQ3KlLY0A8SPB9ccXiGFNSgRUO7TD6wp2sKM
         BQrToTv+7NRQcf3SsKG7MOzdPEQxP7iUW2qRQdwL8oN6GNNVt+O+LQmu3RbqqqhQoxrX
         AuLA==
X-Forwarded-Encrypted: i=1; AJvYcCVu7Gx4DC0BQOEM3/g9nIyunOVxR6dvOj3f2Uyzg23y5FjgDd24gbOJ3BYc9XP2l6oieE8BoTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsOQwqLwcaSphZs6N4ypAf6F15t3gH6jyZ3E7XixUfhpSwXMN
	qVJuLbhVg7Wgj0YWg/NrWncutlJqz/zDSvccxtzmveGl/jIiQMVaQTFmsVd1h+TvL/w0wuZmhDf
	q5dKBm88LPOfI4pZRZEQ/sSckvy9Dwksnb40ceRr0
X-Gm-Gg: ATEYQzxMzVyYafL4H9IHYbaEeyZmqAXab75p5ZbINf466TtoOj06w+ZxQzjrHBDV4xn
	EhNI0+wKrA7OgLaOsX+I8bSFZ/gBfy0H8ESZWpJCwD7P5k3Eu1+8yv4Prvx3TX9FqdPnrH24La+
	u49qTLSsBVaigXhnhwKaWIu+POT+MTTlpaKzUnIhxTrBJiGca6vhD3nHkwmLKpCqc4WlYzLsImB
	xJK6/c/pkCubyMGxbWx4MH1qIv+of/8N6vbJDKSHuKdFe6KsJnw92iSE3FxpJGNvug0Bqxb/nCd
	lTIRitHEchRpcWI4pO4e+06emoBDYlAkyAt+FHFg4fJSPV76vvNd6yt1xJBtqh1Iu/b0VNzK
X-Received: by 2002:a05:7022:6ba7:b0:119:e56b:98b1 with SMTP id
 a92af1059eb24-128c2e96346mr2756869c88.24.1772939407183; Sat, 07 Mar 2026
 19:10:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306131130.654991-1-edumazet@google.com>
In-Reply-To: <20260306131130.654991-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Mar 2026 19:09:56 -0800
X-Gm-Features: AaiRm50P4tei_TuHi2P1ZD05tOhxyXYpZnpPnaR0nPj3GVPeI9MN349xFabX7iY
Message-ID: <CAAVpQUD-7NQ1XoWTA4rbqDg5LO4tzqhMXr-fs6-CjEdxt2_eFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move tcp_v4_early_demux() to net/ipv4/ip_input.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9C1D022E65C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-265220-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.989];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, Mar 6, 2026 at 5:11=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> tcp_v4_early_demux() has a single caller : ip_rcv_finish_core().
>
> Move it to net/ipv4/ip_input.c and mark it static, for possible
> compiler/linker optimizations.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

