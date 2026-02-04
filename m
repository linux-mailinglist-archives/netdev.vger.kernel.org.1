Return-Path: <netdev+bounces-256495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAdVHoCTgmnYWQMAu9opvQ
	(envelope-from <netdev+bounces-256495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:32:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7581E0064
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E499430095D0
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ECD1BD9CE;
	Wed,  4 Feb 2026 00:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+1bdlC6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E30D13A3ED
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165115; cv=pass; b=Va9rs0+kTe+D/4qEHq2eP0rJUGR0hVQYTa7FVbhtY/ZhzOZLCGZ5E8Yl3yUY5oqQv+cKSC2F1hNEopAe9/zSjlfpOK2oIsVFlwRXbtK+wbiYwZQRGOw2dFEbkxO3zVHlD4IAj8Rf06pxPLXmCFx8l1Jx/HQjyEBPZkd27fi3k8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165115; c=relaxed/simple;
	bh=71TjhrYbJeP4k9gbp1bKqCphIISEwiMx9aqGdEn8qI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EEAUZLQbf/OxAIO8FqqjbXQWTbke5ugsi2kpt0C//MH5Wah9bqaAQDJdtpCNSECqsXATTY/jP8FIp6LJn+vWyeSFvFgE0VbvYiFRiW8C5ricPD55mRlSfxoLyFgadx7eckeG8AuetvLPA4W/c5PTXHO67k2tzG/2wJrf0JRgSC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+1bdlC6; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11f36012fb2so7324784c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:31:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165113; cv=none;
        d=google.com; s=arc-20240605;
        b=YuGhtRydul4EnNABjMftvXP50awfLqPmBPv4Szt9GXR38T07Ile5gCicwZspJ2tfh9
         oMNX42s+eQriGpSgY7UJgf2/kRSZotDouhHahyaOClpxHGUUnh3mx9DtX9IdrOfLrLBa
         /MKjABsW5MisBSVNTxDtBR2DjuRdGcQpn/AdR8uJcQrJFLEb8cyEmtyO2hx/qakn+FOt
         tQLLPyUdd73c7eHMnyoxBUyafIx+Umx0GgVOrldk0W+nhkydrTG/5XEN+t+/MKbAabW8
         JT8iFVhu90udflZ6rEYyJxz8J+S2BfG7QWoY+qg0xsB8D/2z+ZFzKvSGT2HD1ES0o1f9
         nawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=71TjhrYbJeP4k9gbp1bKqCphIISEwiMx9aqGdEn8qI0=;
        fh=FTj54aEsQSz7Q8cOiG4dRnTZS3orj14codtzfIokl4I=;
        b=j238uAySnSbZs46bn7C0w5mo9w0727HLK42MBCYW23oRqKaF68pnxJhAys+kD7S/Bs
         z+PaWJKQT9Qnh2o0Mip6P7o9hdrtaxsJt2H68B9LPvV5Yr66o901aKms6pVsNzgRGAUg
         B9AhbccHBEOXnP+ulV3Fbu/p6uI5p16/gvPdXAXZd8TJAo2h89BBxuRraRhZkOcn8a/j
         zT8amjDkhF2CMOpnkMILlg8IUfODwHLuLE3DDrktAgmUYllVE29pDbuUMeLyL+46qHBM
         hI2Fa80Pbl6k00K7EQGn29xFf7SO2sHR1REzIc/RyxxgTyYtrQYBHqXwLxczXDaWMO7V
         gfgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770165113; x=1770769913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71TjhrYbJeP4k9gbp1bKqCphIISEwiMx9aqGdEn8qI0=;
        b=y+1bdlC6QQ8OGYM+0PupVlYCEgcakAp4MAJvosdZHHLIM8YhpJwlAaH6lRNCFUVxj0
         0djd+af4dAqNo+RTeoBhSZCGlooKTjeVNypD4nOTV9/ECJd7LjwByKVYUpcukSRll+k8
         6K2eKnuOg84rQwKbDBA35kxhrnb35v8d4GilRxi3nSSv+ss60g1u0sj7CcSoHVDy17xT
         aLrCPknrQFzE7chVQ8P7yqLP0X661ubIfzgf5yKGFBrzXgN3lwn7GODrR2ELJM/o/OjH
         Q7VAdgHGd5gcAsjIEPvuiIQl3czYjwVWjKKzpaIEE+QzJpVWJLREbgRVjO7Alko13iUO
         qWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165113; x=1770769913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=71TjhrYbJeP4k9gbp1bKqCphIISEwiMx9aqGdEn8qI0=;
        b=As6Kkx7XJ3e4EzfLv9f88S0EQFc0sGl+hm7ptcVnBT+0KVPM1stFEehLjFfBknfVY0
         kDYOToOWxqYZNw+loduT4HmSPTwXi1kISIq3objaT/E1QjRsTBUM6nK/17J4qnKaeZeW
         0i2LAoGe7e9TqN0OsDCuivSewRMv6Tp4x38LL5ISncAhjwdxI08/0LAiHp1e0ia/sBkD
         K5CDZEs20fFb9Ijzqj7rP3WhP+KwrkdtOqiToCg7ixeTp/CHtNxeDnP6iFFDBHVp4iH3
         PMV5wAY901c1gadU1QxNgXNGrYZUg9a9DOeRlr4z+yFgBE1j1b/76cPY3E/HPPKnlLN4
         dlKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdSvFKdjcTKrBIywrHKzFJAFuBIPcsHJImb5SmGCc85JfjOv3eTtaisN6BLFeCSdqxk7VL2+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgPucALuNVKmM4S1wDrOpf6rBdcnc4GjZluwTq806UO1CbN5Su
	Bax7XmlIVzQes5tBExFGoptTqW/O7V93VEnxY+BxJWEMJYWysv/1KlsZmw66f9+LUrt+UVLlHyG
	CMGKdazjoI3tXE1P3DHxISXy1/B+5AOtSdKjw8BAV
X-Gm-Gg: AZuq6aLRz7L2sOy329bnwsrJAMyeUrnaKEXLL2wwufABXTOeBGFmAzGOVCTJho4Z65M
	6MwoA/T9BuLPYDUqoaiOl1BZqnbAq9/0iTrS1E2b+2kLhZijK5F+e1zF/IwKK0fOJV1FDpbX7Lr
	qzN11IzrwB+SONarwargu5ONzVB2AKD1UnfWKnA2mDZeoZ5b+hAYP/arMe9szW+X5TXAfR0ovEO
	8HVjCDcSw/yP+w22XEQyhkfcMu3EFrGI313/20ZSmCYvmSie1YZApT84WE8tFDna5apMMIufJaI
	jiSa5s6S/eBEUOTo8nY3MzD1qHISzPA7mFuFWXpPXiGWd+OLb67VTAwbjA==
X-Received: by 2002:a05:7022:519:b0:119:e56b:91f6 with SMTP id
 a92af1059eb24-126f47dc251mr499746c88.39.1770165112878; Tue, 03 Feb 2026
 16:31:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com> <20260203052210.3684125-2-edumazet@google.com>
In-Reply-To: <20260203052210.3684125-2-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:31:41 -0800
X-Gm-Features: AZwV_QjppSfVCaQ7PUqTeD2PpH4fv1wU-y9QctWnmVGDZ98QrYJVtyC5JYH7_2o
Message-ID: <CAAVpQUBHYodhJ+5jGmEse_VXMBeU8w70Z=_w+Bz4qyhERn75pg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 1/4] inet: move reqsk_queue_alloc() to net/ipv4/inet_connection_sock.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256495-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A7581E0064
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Only called once from inet_csk_listen_start(), it can be static.
>
> Remove stale comment.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

