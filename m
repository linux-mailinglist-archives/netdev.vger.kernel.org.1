Return-Path: <netdev+bounces-267642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IA8XMmCltGlvrgAAu9opvQ
	(envelope-from <netdev+bounces-267642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:01:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3226528AC9E
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 01:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA7593139E36
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB6B175A79;
	Sat, 14 Mar 2026 00:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN2vWmB7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675DA70809
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446451; cv=none; b=VzWtHRe7Ktw6MIc6mxtBfggpaZ36S+Ayd/005TqUPoYItOIhtCltIRKwE/J8E+btcyN0yFb0FWgBw+YjEzQ9OyecSOzFUG1FRWM/mSUf8f86FvPQZDkSziDJ5aAHDIAE+7yzhMMSbpffILrpQQCqlRNirV8Eok+KfcSjdgmVxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446451; c=relaxed/simple;
	bh=SzNVxez9V7PcAZk5QZpuj9c+Tw1VVy/fO1zY3LpJVPE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=GGH6eGAakOACr7C5R3oUC8bNnBfJAxk8mYwXsARcejPWPCD9tQ/wnT9DCrsLORlMvAJ0PE5oigXRukv9av15Y63atZAoAVK3dJZdFEkE8/afijwfTCz7k0EKmSp/7as6UCXAdHqpa/iz67faTzizpVzbS4PFD0MI/x/kP6kWdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN2vWmB7; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986e0553bdso24627907b3.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446449; x=1774051249; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WNbQtouWXaM1HjP+6LQU3raUMR1ZrEf/jm2QyUp1DKQ=;
        b=QN2vWmB7n3xuS/e1Uh9/uWXSL4iSDvOe272H/UGq/jF62o76DizbTK4/4XvPxuRFe4
         cgdaddZjqW78NeY2hZoWk5oSOZc3BQnYifOv+EmmldtgPFtvpG/Avj4LpAusxHlHva8b
         +8nFU24KdWKPHN3MdnKSgXAF8c0JTA4rSqz3Kf5tgnD6Tn52HTX5M9fomXHgv5TCw/9q
         HOeEblGPxYxG6UegVl1kEhgYXi4TfBYXZHb/fPg/b8G7HJuNk8kxLvjkFe1QcO9XavhW
         TaxWe7SGOQLf7SrPnlAIdy2D/PKHsRsRDho7Ff5G3dumCqmdTgCqLoKHcqpm4lijkzVa
         sqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446449; x=1774051249;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNbQtouWXaM1HjP+6LQU3raUMR1ZrEf/jm2QyUp1DKQ=;
        b=iMsB5EN5wzTm5FfKWtqrnxWUhg3MSka3rDrkrOE430cnTyB4fHypGlAZAx85el26yI
         okbkRAf7CaQRV/2gRZ0bzXtJZoOLKPSjDJ2/Q8wYunfeLXvyHZ72h0DgJhiqS47yz48T
         di14CfpVcRNVWAUNBusHyyZQjNsIuW0X/cd//X92gZEthDngWPt0u3U5M5R1B7F5OXPH
         tVC7cs2QWoZN7suHfT12oKMCCZ2wpgfoEASvMy0gSMAZ5OWTWgH0OE7opOO0Pq39UYcE
         krHBnbU7ymOx00UDQOSFZVzPnMSRbt+cUKdZ94B2KL+p8rNCaUnGregUPjk96ReAD/tZ
         HtvA==
X-Forwarded-Encrypted: i=1; AJvYcCVNflRY2ofw7F6IDQ+pAErX5Puox1TmwTWybuC2MiCjt87WCmoRi6TNvArDG1dhRsmPfBk4gTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5Z0MP1OaZGe72eJSkM4kd7vCEiY0o44QwOr8UWeuIxrt+GIk
	vxlZk/cdDKlSpFrdc+iEm0+TkAGT3CglfE4B1WUdo1K6LOSFeZ9omnKW
X-Gm-Gg: ATEYQzwMMIgq/Av4Xu9cHgda/C2oLH/3ieABXGAQHXjwmVzgetKzrr6sLUhCwxi0LIj
	ulhoPFNsyiLCS+WnIuFxC1cQ2WokaiJjoCE7TxC3CqH7wEzt/V7ghb7pTb+v2DB7xD7HP1p2E/P
	DU0TnQQkyv2EmcCoOqXmGhwXbnxZUjMemkx/9UUeWmm4HoHnmUnaSJlXjJ4/IAYXIDMKve+4QwQ
	yUxwZHGq78bAMtyYh/t6u2Cx08j5mNHoGq6PSgrYdMaIK4ATAFXrxVTcMkFWJwxqVZdAc/ZPfgv
	1W72Hjqq3hrpK0HTRvIuXHHmzHJh23T2r7l9LKKOi9qI1D5Gp4Ay04m1EsTq/s/0CDqrtw1tk+a
	os+mOje6+TRFLVyXqAhnJndaj3eN/USDC609SnfuStw77KTaQCdECQheq0GB6qKTMjPALioHFVq
	QsSv6LrpzR3ClcVRZ1FhErrsHm310HX3o=
X-Received: by 2002:a05:690c:ec8:b0:796:5a14:87c6 with SMTP id 00721157ae682-79a1c0892b5mr54774307b3.4.1773446449477;
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7991923673asm55811097b3.21.2026.03.13.17.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:00:49 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next 0/2] selftests/vsock: support nested VM runner for
 vmtest.sh
Date: Fri, 13 Mar 2026 17:00:13 -0700
Message-Id: <20260313-vsock-vmtest-nested-fixes-v1-0-d0e6274c3193@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6ltGkC/x3KQQqDMBAF0KsMf+2AMUVqrlK6EPNtQ2ksmRAE8
 e6lXb93wFgSDUEOFLZkacsI4jrB8pzzg5oigmDoh7H3zmuzbXlpe1da1UyrjLqmnaaTu67xEv0
 8jQ6d4FP4BwS5IfO394r7eX4B8SxAJXUAAAA=
X-Change-ID: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>, Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vmtest.sh:url,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: 3226528AC9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series fixes a few issues trying to launch vmtest.sh in a nested VM
environment and were discovered when trying to prepare the tests for
netdev CI/CD.

When taken together these patches make vmtest.sh work both on bare metal
and in nested VMs, regardless of the outer VM's user, coincidental path
overlaps, or filesystem settings.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Bobby Eshleman (2):
      selftests/vsock: fix vmtest.sh for read-only nested VM runners
      selftests/vsock: fix vsock_test path shadowing in nested VMs

 tools/testing/selftests/vsock/vmtest.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)
---
base-commit: 8f921f61005450589c0bc1a941a5ddde21d9aed9
change-id: 20260313-vsock-vmtest-nested-fixes-918fd4d3a961

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


