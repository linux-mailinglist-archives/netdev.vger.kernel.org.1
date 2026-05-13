Return-Path: <netdev+bounces-287680-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECV1MseuBGp6NAIAu9opvQ
	(envelope-from <netdev+bounces-287680-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:03:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 071485379E2
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9202132F7480
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAFA43E4BC;
	Wed, 13 May 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0fBBqU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6356E44A724
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689662; cv=none; b=ddlO0xt4I76O8yGTtX47NONIKvH2Luauzx1eXBZmyNrmzEjddw37/IKMoLCdz0QX2YiD3bslw6KIIqHUrbA0AG0ksknXpSrxXtrcToixZXH0keTYSVI464zuqNAlKzJ+5TNKClzBXru58FL4Z1MT+8+Y6rn3UFnvdHq/0T4Q26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689662; c=relaxed/simple;
	bh=72FY41gb9mZKKXnsjICIXsJKMi4s/nNoVyD/bctU3Zc=;
	h=From:Date:Message-ID:To:Subject; b=TP27q/YjYUX/vPOe947NaC81RFdP6AqD7dAFpov31V2CdYEnRK5Mi3DzH2AQRW7QHcaQB7k9NbYZRAATi+yBCXguss5W09FxZYvMoskHVRBjlRlYHbXy88UTzNG40cornROVymdAiSRK1goIdym3zCh36ASzSEGFE2mhcC1xQeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0fBBqU2; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bd4d7f4fa02so54958566b.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689660; x=1779294460; darn=vger.kernel.org;
        h=subject:to:message-id:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72FY41gb9mZKKXnsjICIXsJKMi4s/nNoVyD/bctU3Zc=;
        b=p0fBBqU2CKtwtU+1FSRlLMOOhuKihIFGCvCok+4ZqJnWdw/R8LxJ3QhVAQaXIvCZmb
         zcnqnxOIkEtEu3cfIrJDJ1PxhoWH2WbgtM077664/9/YWOqCY4coLFXSZ0H5ztqrYU43
         dSANfm0uo066xXAs+yoZRmyCROi5QNfuJDLAGyOVJCaADQCrCHS/zzloyfvVeIGHv/CR
         /nFW/y0/dHomjqLY+2BtY6FBCdFzK9INypQlUS47BClHJ7bRZ06gun0wS4/WckH/LICD
         Ep+gdNS7j7Xdfl87pT2gw61cZaJQe3mA0+5chO+/3awDoeEY5xK+bv/Mvuz1aWq4/dhX
         6Slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689660; x=1779294460;
        h=subject:to:message-id:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=72FY41gb9mZKKXnsjICIXsJKMi4s/nNoVyD/bctU3Zc=;
        b=bq56IOILs1xkhTohZHl4Tvd2hziRauDJyDKk7TGCMBzEm1g4Lbdd2N/jjizaBS1/Ow
         XvsoDmTUGrAf68rNtx6W3cmMAB3fYDmDmYO3mrbrYzZwjQRIDsYThe3rlUeVS8TPcXZQ
         KGS82KvJUzAsAuHaze/EBDHIAGM42ELMkXLk442E5mIO+RWd+wSlchBCG/4HQKVUnuER
         AodPKK0YcZgzJopNFilJ2kmaGu66HMf/zWUI8wBR9lSjCNFYIkCvJXZLCwdzRkID1iQr
         k0WEU+cpUrLO5B3CIWmXafyNdI/1aRY/d04ZDEmkPr7fThyPIiGBP1DgOJ6Fiol/DwT0
         yFTg==
X-Gm-Message-State: AOJu0YyzNMOiWF/WspnKeJDh1tf4fT+Ex+8beUvacWgld4JEcEC9V14h
	Kj/i7lSsND5wkIILgwfk/Jk3MwJuESOOVI5P7leNoTQT063vnxZ4k60zST4eYg==
X-Gm-Gg: Acq92OGfO1ZGgUphWF0JT5qrF3ALuWa6jlz1iRs2WV6ZS2DWUyIPCAYsvRKaw8Efe4Y
	Hw+s7VKBcxgnY23koT0WK80CoTLInK6P9y6uta+X49+9nZHSba8i/5EEaxwdY9+NBBBxCQxZdy3
	mRkRCAe9AEuVVUd24KZwXe80UoKbfbnHS6omXz14GJGWiBG8e+MEsX8Tukc9MPsmJDgHwUsnhTd
	zMpEcVisQgOmGR3+1Mpd4P45u5YSe30XC5dVdMFEWbntdrAQ8v1Ol6zVIABNw5dGGb0/AjDsi77
	MxJho4Wtc8dCYy3Zn0fJu2c4F5xlW65DBD6r4M3sKfT53fHn0gbrXFy2SltVtgPz527Lq2Uu/wG
	HeTWdfmQsKrl6O3iV6fXGq81+6f7FUMp5ZtdGWd1ZFEeY6qgaf2xaSw7Ch11zcjKiXzYKH8K83R
	9TaVVPSmCiHOzC3ILspLbEZ38Z9LsT
X-Received: by 2002:a17:907:7252:b0:bd2:47dd:e0c3 with SMTP id a640c23a62f3a-bd3c10ec262mr275179466b.20.1778689659669;
        Wed, 13 May 2026 09:27:39 -0700 (PDT)
Received: from localhost ([146.120.47.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd60f726desm635270966b.25.2026.05.13.09.27.38
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:27:38 -0700 (PDT)
From: capyenglishlite@gmail.com
Date: Wed, 13 May 2026 19:27:37 +0300
Message-ID: <88b4eea5b5daa681fc9747cd844904e2@gmail.com>
To: netdev@vger.kernel.org
Subject: [BUG] rose/ax25: use-after-free in rose_transmit_restart_request()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 071485379E2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-287680-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[capyenglishlite@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi all,

I am reporting a use-after-free in ROSE/AX.25 networking subsystem.

Bug:
In rose_transmit_restart_request() (net/rose/rose_link.c),
ax25_send_frame() accesses a rose_neigh object after it may be freed
by rose_neigh_put() in rose_t0timer_expiry().

Root cause:
Missing reference hold across timer vs transmit race.

Fix:
rose_neigh_hold(neigh);
ax25_send_frame(...);
rose_neigh_put(neigh);

Syzbot report:
https://syzkaller.appspot.com/bug?extid=9c8999af06ca7df15fc6

Best regards,
Afi0

