Return-Path: <netdev+bounces-306656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D0pDI9w+UWrhBAMAu9opvQ
	(envelope-from <netdev+bounces-306656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678273D6D7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 20:50:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=KxSC6nY1;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306656-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306656-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFA4930095CE
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C1367B73;
	Fri, 10 Jul 2026 18:49:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E2637702C
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 18:49:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783709371; cv=pass; b=H652f+Eq5EM/aPdEN4EIzRt8zD+XegYP6Rf2eywAtwWXyArmAu7RnM622vHjypw9wVIcWhr/xuegUWTK8M37GiUwoUj7aCXinxM1EyRKjOH5/ozUPAAPiJvOznXTkl81xIN++umH3/vbA4muGmwQ0BSmEDUPz348qHhqj5uGVnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783709371; c=relaxed/simple;
	bh=GBswjxO/XImkwMLCdXbQD5FVKd842X8Y8HmfEMkT9A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eif5ddM3/NCGv68Hd7S9LRC9vIOBEOOZz9aLWkV9PMWz5Wuv2DSFolUllaJqQHW24qL5BQnxmiVHjouaafBf57McR1zSDHfZZdRsFIZLoFZcAlQ0Z4lLnfpeoHGHGRrjz9LHIZ4JPWV5uNgRj+w7gSXGrIq6XV1xVgrD5sXs4FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxSC6nY1; arc=pass smtp.client-ip=209.85.208.46
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69c600f76ccso62150a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 11:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783709368; cv=none;
        d=google.com; s=arc-20260327;
        b=RR5Y9ACSihElXpMTxuTM1EyeG9JnEBq8uREuPE3d00iZ8ExtqAuSSJpx919RwDw+Ck
         ZTpAelHoHbindvvxnxgrzt3l8pw+zgEVI5AMed1BVl3c+3BXxKRJQLrbeAT4pMRTvChA
         Ojy7l56UXVm/RRmyUTytE94MJBgR6qY0t0cOsddCDWzlP8JL9ruGG4uddJFJ7sEXL63H
         zXr5Pwz9DEGMszU3ONuo2kYtLoD/P5h05kEUKITADGiVpfdw9G+y8bm7vDCz2cg7Xtjd
         xQ7dCBplzFVxtGREXPx2h6KDZL0t5ejoO422F2iox33VYXLoBVsujrjEG962vU6eQUTu
         B2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GBswjxO/XImkwMLCdXbQD5FVKd842X8Y8HmfEMkT9A0=;
        fh=l2cnSbjngQzPqeyiabE3deg/pcYQH1JcvUsnGXs0Ysw=;
        b=ZgIm2alm8vC5fnXHlGiRJw+2TIIcYXGUf6NJg5GUVtpQcFnwBJDy8/m5h712+I3i3A
         GBYc8kvGtrfazowdjyfyozbzXsUKwuJoQ/jRx/sq3dPd5XXc7DbuEE/GSpO+aiZxupPo
         gTcFuIcD/wEnpEhAaVweIo03/S/GDpErUo6Z2MnXUicK3Jx5Vv8O7wPj9hGIfkcMOVjM
         7VfaicTb545qc0VB6Kys9jmgJ82ewSRGNJ8595s3R5eLDt6o4hPQnwFjgq8NiiUllRJu
         3PFno+VddBGn9DMxe3e8oJwOgsko9xwjDe5e6YgwuFFQ1QeXEqMAdo7qiFie0MGRtCFj
         1+3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783709368; x=1784314168; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBswjxO/XImkwMLCdXbQD5FVKd842X8Y8HmfEMkT9A0=;
        b=KxSC6nY1QUy5Q57svA7YrpVUhLbZFI7ogrh5u58hvf8J0T3k9bvjBuvEkxgHME6Loz
         jijEv7wpROg8NOL6QYObGLwMarFD7wkYR/OuS18C9l/SKlCIt0LkvzwhvKsSP8tyiQYB
         mU3oFzrXxANACQST4FtkR+YlWvsGZKp+GLLk8NyFMhIA5T5t/rzw8k9bEgEeLM92LcJE
         hnBrs0AuNsLfB5ZWN/yv2W+JKq6E//T0hbQ4c7Cel/XDVjJNmLSEreH2pHacVIgJAZCi
         mTxgA5VPtio39fT6xtsSvp1jlIcozJFP5J3eFmTBLT8qb48fVOkG+G1i9PD5XR14nWeg
         TayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783709368; x=1784314168;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBswjxO/XImkwMLCdXbQD5FVKd842X8Y8HmfEMkT9A0=;
        b=SUyUMDuggsRuf5iBxLLHQ6fUUOZX7RGBVj3/MpWv/TgRJW78HwyghlpAjWR4K3cn0V
         zR8RuDGFWYaFO4LaiPSAGeF3Pvi5/eGr7QM+aTe3UkyHRzJJuj7fz5hKbXItKMYC6+Ij
         cfPADfslFsZHXZeDbngp96u3B/T7Vr3UAOy2Kft5VQgVmdTQdHpCHs+HkByYptDJb9yv
         D4Uzz9a8dosplC3ImCQkgkVXxwtbud1lbh653oUdnUhY4ECZ/gVwRxOY+OGjLN3hbubf
         1SK156UWqnsUxk+H5FLQ46DT2Z/3EavaIB87nmQX9sByzQntEOba1o3PbTf8OolAz2Xf
         mv9g==
X-Forwarded-Encrypted: i=1; AHgh+RoWePVqyWTIXrqO6lUHgJf3eAikAQQ4StL+Tgq6B6TVitFoo/kFfb6Ssu3hgOdDzeN8yZem/Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/x5v9SbCtDx11yyelkrk6LwKcultC0LwO4FbUhorg+Z6AjaRl
	ydfEekBPncvMSdGzcRx1ZmS1gdrzpkHXTjeBUeUI4m+Nfnk6asaEuVR14GQbwDMQq/rzYeP9ecR
	vAqqaLYYyuyaCw65fTWTQG4kpwXIeiXbJOa5wlDLU
X-Gm-Gg: AfdE7cnHCVrCZtlnoh3G0DfEuLtF/NgKKc8bBUmXGN5juy0KVk7ZcDCGtmKLW5qgU3M
	hVyVzhoA8J62BJyJKDsaHNcCVvaXMpNLoK3v7PDI4beyWkvYwsrPaiss6avM768HFDMaXiZjFzc
	TccYe8qvAfJB/pdnmjI8nyseLJaYHOMFt7vGA3Ez/0pqAsW6r2q17E/ihT5rQRQI2lE8SNK+1TJ
	TYeJ6Xrzgy6/1dQoBadKKhS4cy+NgWv5wnhdE2GKqA01M6dDBhWxRwACmL/NStvcJYFemU8i3YU
	/Z9qYtPbXCPDKIuig/A9YK/fig/Rb+QhQGSI6xzIvqPsqOuH3QZLz1YnD0yfH98vTBwTczybwj6
	PBsP/jLGqXdcqG2dwjeyFG59Lvt98zaz+vGi1h2bRng==
X-Received: by 2002:a05:6402:5194:b0:698:be56:d7cf with SMTP id
 4fb4d7f45d1cf-69c5f0b3ceamr240064a12.16.1783709368200; Fri, 10 Jul 2026
 11:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710181317.4060230-1-edumazet@google.com>
In-Reply-To: <20260710181317.4060230-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Jul 2026 11:49:14 -0700
X-Gm-Features: AUfX_mynTij5kHKjcQua2caMSd-FRzyWmbVERKWTAVeZH62EB2Fl5pwqtAA1pGY
Message-ID: <CAAVpQUAEkkaXd8fN5fJUX-pGwfLfi4dBJ+0-xqHW0JdJBuFcdw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix TIME_WAIT socket reference leak on PSP
 policy failure
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Daniel Zahka <daniel.zahka@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306656-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ncardwell@google.com,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9678273D6D7

On Fri, Jul 10, 2026 at 11:13=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Release the TIME_WAIT socket reference and jump to discard_it
> upon PSP policy failure in both IPv4 and IPv6 receive paths.
> This prevents a memory leak of tcp_tw_bucket structures.
>
> Fixes: 659a2899a57d ("tcp: add datapath logic for PSP with inline key exc=
hange")
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

