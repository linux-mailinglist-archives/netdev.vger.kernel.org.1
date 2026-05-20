Return-Path: <netdev+bounces-289773-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MERuMdhVDWr9wAUAu9opvQ
	(envelope-from <netdev+bounces-289773-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:34:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A235882EF
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47E2E30086A7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145021E51E0;
	Wed, 20 May 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVgzW6Pl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C5E3FFD
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258834; cv=none; b=WgpLgp2DivT/5bwbRUrqA7Rws6Erg5ilp3ut+lQVU+hiwCm+oEZtSIlkLnauqJrXi11yCXS2MdPI/xmJBav4Hq6A/XDFQvovYrW+IHRfRNjt6ht70hqYx9ZFcW7kzIvAyhkLMivtIq6AKvt6yfnnJvFVx9Un/6X2SIjPTeOL01A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258834; c=relaxed/simple;
	bh=5hm6QrJG0OQD4T5fj3W2Zwl/Wje9q6BjOa7wS2f1i/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qLaGeOXOc0Vi7UecGvOzNSFJlVUja8FZYUpq3vZIZI3tN+uHhjO6lxz9mNS1cjkSJUkEJ7Fhgm0HpiW2JkPFooNuGPLsQ8W1CNvI6/Ayv7w+XQcquFkMgsHXoas1aSYO79APGlEOWnoUB1nn/0VwUKHUONtpWxXTYFxwXndj0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVgzW6Pl; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48909558b3aso47010355e9.0
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 23:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779258831; x=1779863631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y+6KPgSMS/SoGvigvZDGqr28WHDQEEpApUJOcw+2lps=;
        b=eVgzW6PlLtj1RFzucy3YbHjBzTSnKkBr0XdDptELMp0rf2o0vC/p205dz5HeHgKEty
         v/lIDYO5/3i633jqU/WI2O0MtvLwhGHh0aTLJJ6R9+OamdWa4fVNdjl27fO84pnd1Ulr
         w4v7wW5NhzrATs91PBf9/kv/h63XjHrwBzO0xMKQ77zBgXcCw4yqoMJAGkzmuy5S8UH6
         UO/Grujgu8nV13k1eC30TSnM4WDwv51oIBw8ELFDlz3OsVdU5u5JyNyj5yy+6+J+rkS3
         eZLfp0sPeMwyhT9pTF0jDiRj2uK5XruvpGQT3tgUsHv8VdMUa53inAMd9fVV4VNLEeTQ
         Pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779258831; x=1779863631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y+6KPgSMS/SoGvigvZDGqr28WHDQEEpApUJOcw+2lps=;
        b=f7BoIWVlAsdBSqYinxSV/nNfcDVNsQWuDXMT41nV1COJwUOqiijwnKny7CdQkzlp88
         HQx2/iiQNdv1Yjj8zwjFpf9yD8ma4Jy68539+61X10nx2HTP+Q75hGAcgFfEgkwWQztP
         PzR4A3y+swAoVunAviEcX7/Zj7Rf51Pj5oLSVC43CS5y6/VOvjl2/pmY+aXMSroOWY5O
         tVFRmjKfnaWrOHdfw4ck78xMuxWj4CUav/HBY+Sn2msAqfWDQU3QcFBumpVdNs5IbaMi
         VEaXGBj115BMDSsGx9tDaAkfNMLZhw7m9ksR3I7OSNTfjGLHYzTjKQ6MCFe0xDdMMx54
         kcRg==
X-Gm-Message-State: AOJu0YyxivLCjNhSuqeKzn3kkheecZeYm2IYgNxlXc+Hk8yeyA2v6iGD
	G9OPqhrgkGHwT9zvqXCfKdT825V2d/FEgEXdzsgp9Cc7u/ObLLwroZ8Q32VMxigC
X-Gm-Gg: Acq92OF2flw2BBZNzuIdYbenAg0E1YNiCHHt9SZGB0u7lQBP5OxvSm2N709NtbW9kF4
	14Gm0H6cdi/XVjDQeJuB/qHvxkctXjEajfaHOZ0KSk8Cwemnnf/s6q6uH+Ge/IPbuG6GUdcemx8
	+oBBVkcHxo0nKMfy/d+83hG2CUxd6wn2ZPP5fEhPSXbfSiqZ5AK1jV0sgVY23V9xfW1dZD0L/vg
	2YlUwbQ5CyJjpPYsBj9+xcb2yccayHSlbewS88aIDU4UCB0OKAidiIziwvGZi1GKZ4AJMoN6BJA
	Ztw90Cmq8G6LEBitH67WKzmr3dX0+UGcD+6GTP3FKW/RoAfIuKc+/NyGPFJMPiY3aK6davAOxn5
	6CZpw2rS316tRKEQOt4lS3fYBYx5RLm66rSKTo86PojZFR6CNnMevT/3EVy69kK2iLgA1RKWR0b
	me+MhWfxpSk8alo4i+IwXI
X-Received: by 2002:a05:600c:c087:b0:48f:d612:3c4a with SMTP id 5b1f17b1804b1-48fe60de6bdmr270899195e9.1.1779258830819;
        Tue, 19 May 2026 23:33:50 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm374290485e9.2.2026.05.19.23.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:33:50 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next 0/2] pcnet32: switch to napi_alloc_skb() and napi_gro_receive()
Date: Wed, 20 May 2026 08:33:27 +0200
Message-Id: <20260520063329.6387-1-oscmaes92@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-289773-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oscmaes92@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C1A235882EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newer and more efficient napi_alloc_skb() and napi_gro_receive()
APIs to improve RX throughput.

In my testing this resulted in up to a 25% RX throughput increase in iperf3
tests in both directions.

Oscar Maes (2):
  pcnet32: stop holding device spin lock during napi_complete_done
  pcnet32: switch to napi_alloc_skb() and napi_gro_receive()

 drivers/net/ethernet/amd/pcnet32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.39.5


