Return-Path: <netdev+bounces-287896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ8eDi2dBWr4YwIAu9opvQ
	(envelope-from <netdev+bounces-287896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AC15400D8
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 12:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 745C3302335E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BBB3A48E0;
	Thu, 14 May 2026 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzR7dTYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22B3F4103
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752779; cv=none; b=uQPHVpW5gw8coF6apzQVBhw8EtBTSQ+E7MoTzwhYjHF9q/bgDSeB6E+E6XFiFoDBxKverVc8gqctUlb3tAXECtAbIsDMvsL012twmVMLmSSHoHkeKL3XjVXcbl5HxXGgv6mDZgnrL7ObOV5sgtJozPrDLN7NSCvQuS4pJ65HD2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752779; c=relaxed/simple;
	bh=T2Prjcth75UWUzJav8ccwoKWXTiFzRxX22hj53W5fDA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OwN1eK7+29lAbLQRdsPdOWVKLbmhPvVA23MjauDkrHudH6r6LD2BQ+XXgOmPbfQbO/iBPfZgDft00f78oE/TLj47DyhBjC6RAEYe0EkzQdm06NPe+R1DNN9Va97Yik9xL2S8s8My5RSbEUllcotaZGgUCR4J7Z3wIbn9uhWoIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzR7dTYl; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fbc70cfbdso188771751cf.2
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778752777; x=1779357577; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ZKAMMsyPjzW0MlpUTi1OTnvrfGwVJ9IMR/RNuH6NAQ=;
        b=dzR7dTYl54qaPGPSixuLt73ppvGFMX9uVW6ifn0s1ABpzoNbYBwq5MC34fLTh2MXCx
         5P4+u9Mm6JeIdMO2W/A4ouwqhGx8YXrGFkmia7WoRKghmBXxmKoZvtO7+W3al08+6gJ6
         fFMce/Ly/DolaHgX0V9p5fHMAkbb1SGWgUc+8mGxlGuRA5PXX7hfAUp0xRghRb0MHEC4
         uBXo8g/CVN58bLHl3ifjPgkUQvShLOZIaz+Y16p+BrxzNGj+ynBJ6HLG9g3+mz2gbeVQ
         2WdHgeUamQoCMJyHer6xiWR0gmc0Ffn/fisAEbBRMldOvWpN3TjQqeu7vbWyK0oB2HFu
         d4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752777; x=1779357577;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZKAMMsyPjzW0MlpUTi1OTnvrfGwVJ9IMR/RNuH6NAQ=;
        b=qzMj00ZwjEgVtwI0rzCP77akll2Sm5ZWWLE18bBB6LFd0cgQHL1P2kdcmbduC25Xoo
         NYma0x5jEf9FxHH9aPYhXOmFAUyiptu6KX5+JiuZ8pc3Odyy8DGW9Alqi8F9adhoHN43
         4KNveFmp7Y33gGKeRygDQv8aYm0pitLiHwUX3JRv6SBX8ekuQuec03wmLS2kY7uhCS3M
         dbst0aOGS/6IEqdtWOoMT25r8R5NI9ke1tMPsAJw1hhPaZLRLX6h2tQEisYHSMOGLLsK
         sx6BIhos5MTGW/OpEt2okpQ951SJ0bf0S1TXk/o9YjvtSLXk3JZAUOT8RFMBkj90OM8h
         RdQQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RKDw4yC3NtoMZnYaKNyccL9qp87v98JOXpLn5rNJi/0CYoLvMja1nabNhvP9vgvcGhxwfHFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeffTlGyJnHTMZF8ET8Jud3iWpxT4WIUfemZLSdcgRFGy8BwtF
	R2YNTDf4p4+A8vk3wr70hp5WM4S6uI5DLXUyTglNBMq/TAa/s4xafzaCXV3yPm0ztwf8jqTWNGk
	ZIGLl8ldKozu5dw==
X-Received: from qtbbb9.prod.google.com ([2002:a05:622a:1b09:b0:50e:60dd:eb31])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:58d0:0:b0:50f:b9e6:e056 with SMTP id d75a77b69052e-5162ff0ef76mr92833291cf.29.1778752776367;
 Thu, 14 May 2026 02:59:36 -0700 (PDT)
Date: Thu, 14 May 2026 09:59:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514095935.3926276-1-edumazet@google.com>
Subject: [PATCH net-next 0/4] net/sched: sch_htb: first round of fixes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 90AC15400D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,toke.dk,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287896-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

First round of fixes in sch_htb.

I chose to send a small series, to reduce chances of multiple versions.

Eric Dumazet (4):
  net/sched: sch_htb: do not change sch->flags in htb_dump()
  net/sched: sch_htb: annotate data-races (I)
  net/sched: sch_htb: annotate data-races (II)
  net/sched: sch_htb: annotate data-races (III)

 net/sched/sch_htb.c | 54 +++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

-- 
2.54.0.563.g4f69b47b94-goog


