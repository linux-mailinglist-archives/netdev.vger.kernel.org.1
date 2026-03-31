Return-Path: <netdev+bounces-273474-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFsWFgFiy2nCHAYAu9opvQ
	(envelope-from <netdev+bounces-273474-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:56:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63536442D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 07:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 39FF9300DCC7
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C5371041;
	Tue, 31 Mar 2026 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UltW0E5K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82235611E
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 05:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936573; cv=none; b=A60dNmLKei61VIuMdBZFKa/bwyhSaTufbtr0aniI7+3etYnzzFwgoUyvXJHoX1zMdFI6uIcBUufnhtz286cZXcmYgp0S5iJQixL7D/wNC4sBEjftsIqLDeJPoQNJ5VT+xCESiB2lR0hIAQ29sv+FdyEy48Fweg7Or1ykoFlw52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936573; c=relaxed/simple;
	bh=pV72EqT5bcVKWItDa+vXTFHlll9HnMWHUwlsRmZ5PWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SHf8nYmk77dFTQmT5h/WA0hPVukur04Du5xUw9SYjVX+/RFQT7nhfQ1tplkWopo2bpZREHezt8RCsuO/Nuq+svN8jgxRzWvivMyMorQqyjb6OgxJkzvcFwfgLETLqhfyfLXIFy9l7ueae/X3YKpWiqgGGyq9uVQ71RVbUlR4Kmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UltW0E5K; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-66c24b42efbso1436694a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 22:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774936571; x=1775541371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xgRGMIbUJ3AhTjO+w1QNBWgEKsQRuVAdG0Urvbs71LI=;
        b=UltW0E5KdexKAUmJBC6roWmSHoruS9qLPRdX+iyq/G8v/g3+j32BBPK/yIRnV6dobF
         0KpipBzbtoJ+/cu2vsvBeQrCJLaoDm8QONdyaORlFg2IlOOglLDOorIBy1inUNh5s/wH
         aX5z0Z7G757px4LSJXhvjbHbxwWKK8SSBTWSn6qCD2Ha220NGYZQGZ8WL+0C+gldy2uR
         jOMjA6odnFPiTKEzOmqCdZrHY2Vmi2tRi8Dck05SGBDWtQCaRDZexJOae7IF2MZqyigp
         Dz9ohDu+B4EHBeOpC3iAdRSy3udGgulQ8/7vvQKyQCNkqS63y9o/Vi3zbJ3IxhsydHd0
         CxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774936571; x=1775541371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xgRGMIbUJ3AhTjO+w1QNBWgEKsQRuVAdG0Urvbs71LI=;
        b=VUXwJ6Ib0UINR91mqnC3bBCrpYw4QS3a/U1A/WJqafd+xDtsJRCW+AM7MLPtP8Zw8s
         ffDmKb/dvwbfjwRgD8jICOjFqVPsjHzku5v7C8jU4F3LOvmdyS6Nc5QXI/wY10Gw9dIJ
         1tgcgR9wGRKU5wwtdtA9HwkN5ED80pMwdoPka0K3VidRBHJgB41Sz2yOu3n8ee8hyxTx
         OMwTDy9Z0d3a8UxOv97X2LPLaqrOCTm6dbI27NX+dxwQirMxbwbMAX5dD4oKSUjnIlnl
         vLV3UMXoN7YKqEx8+LQ/vWnHQJwPJKblg7FhV/mB/jlD6r+oPzR1zj4F4HL1+35LQH4I
         KOcg==
X-Forwarded-Encrypted: i=1; AJvYcCUdHKAkklsrPe/9kFemXYcgVix2D6Ek5tTXhJgrLTo6nb5HOWuM668cDrMo4qY1QbifJ7A5ntA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuqY7r1OUsbSt7Rjy80IVv8ZzA30+SJHQadpaDwOR6CecbS+y3
	6uSOAmkaLMU2aFULKjDu/ck3vn6dZ3Z5k1mXsCoPxdsVdz5yk1VhnQdm
X-Gm-Gg: ATEYQzx2nUQWKtOoWpWGto0D647mE6l7es3+4cl7Yh5lOt8YTj6uYCT+ETTp7/drKRi
	sMLTTKbupxYMcDFK98jroEfra0M6DgK5Yj4Lb4hnvnoULq1cgc7to+ijFXt9ONjYr7kqE3V2gwP
	CtMMzUUxdulnDif+YlJxa+yTKVv0JggGGfDeCHUx303MXaUOhnu114j3J64Lgubwm8c8tTo/VVx
	RokzjJkK64v2dGAPBQ/F44mCKb628j5UZIeqQD4gcWjBj4vbUAhyXGALPXs764uGzZ/sqjbaj7c
	V+/YmPb4xQ3Amh2WQRSXmMj/h9TtfcZ/SoNCIW1V6Ym1FMIPLO+ECFEXkqTYQPVYo52w8f4sLQr
	0vWZMWe/TUHSBmwYthQPBYIxejYU6InN4MszZQDDyY8r+8DbSWAWZRXzugu66s3TQajwimM8SDF
	qH2xM=
X-Received: by 2002:a17:907:9816:b0:b9b:1cad:fea4 with SMTP id a640c23a62f3a-b9b503520b9mr979230166b.18.1774936570576;
        Mon, 30 Mar 2026 22:56:10 -0700 (PDT)
Received: from gmail.com ([2a09:bac5:4e22:2719::3e5:12])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b7ae50e8asm358016066b.14.2026.03.30.22.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 22:56:10 -0700 (PDT)
From: Qingfang Deng <dqfext@gmail.com>
To: Julian Braha <julianbraha@gmail.com>
Cc: andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	davem@davemloft.net,
	kuba@kernel.org,
	ebiggers@kernel.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppp: dead code cleanup in Kconfig
Date: Tue, 31 Mar 2026 13:55:58 +0800
Message-ID: <20260331055602.35880-1-dqfext@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330213258.13982-1-julianbraha@gmail.com>
References: <20260330213258.13982-1-julianbraha@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273474-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED63536442D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 22:32:58 +0100, Julian Braha wrote:
> There is already an 'if PPP' condition wrapping several config options
> e.g. PPP_MPPE and PPPOE, making the 'depends on PPP' statement for each of
> these a duplicate dependency (dead code).
> 
> I propose leaving the outer 'if PPP...endif' and removing the individual
> 'depends on PPP' statement from each option.
> 
> This dead code was found by kconfirm, a static analysis tool for Kconfig.
> 
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

Reviewed-by: Qingfang Deng <dqfext@gmail.com>

