Return-Path: <netdev+bounces-291318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIwXO6xGFGrQLwcAu9opvQ
	(envelope-from <netdev+bounces-291318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:55:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 642DC5CAC36
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 14:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 964D6300F15B
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 12:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F637FF53;
	Mon, 25 May 2026 12:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCW5/4AJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351B237F72B
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713705; cv=none; b=f5ucGLmc9IXnxjpF92x5rC3C1GNNfmnUN/1bV0XR9QECfaBjLmTyMVtJmZ074pdDB3dat8DpvA8Vukm5Y1kp3EEkIfVN0ZRz6RekAzNjUBQrg8ymR2c23e9hrfVVlDI8aEkwQ2FOo7BCmYHMTFg2PrpbKOcRqm4UkyYIycPqB2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713705; c=relaxed/simple;
	bh=V/777KxR+z3pvQNxIt38bFOKAbIJ/cOiEQggcl+7R3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SCpULfAyzR2y85S65/0GKeMVtk/FTUAe5VO2U1NVbZAQR2VB+3t+QS+vVwcS3O9C70sfbPvpClo2pVo3XWWOlH8tgywjzSIFU6uv9MqXuKk10PKqAAqMDuHiZ0gKkVuL40XT746kRi5kbJAjtYbP+4CDlf6R0/wzJ8Zv3rrsSIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCW5/4AJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49042aeeb75so42517855e9.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779713702; x=1780318502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aNFaUMhq/EUuucPv9gf9efSJqa0QJ5AJ/pJfs0JaWOs=;
        b=fCW5/4AJJpm+htdMmVYbrv0GJchViexnxcYKT+imj6JXJ87f7WyzWmVbUh2dXKxbiC
         2Xuau7BKJ6t+dIPmaAC65DOWb2HDQaEioqHqAu+TqvSVfsVQz8sGMOcSRpOSgetRicZp
         JcLE1xPqWiNqxvSsVuhxWHyWnGHxRV7bvnFZZwoz7mNfgWPa6FCqHH7WfToO1q+7Kc5e
         R8p1fmGDBIlnIG3lm3cWO99fg40A4Q3EW0Otb6XaJSDLJuBC6PyAs16UtZo9dvR8fiCX
         m5FRofnSZY97ucoSgUP+h/yAWzfwwlhnkA8XWG9feovY+C4rZvbsJhCIq7KnL4daa5Au
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713702; x=1780318502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNFaUMhq/EUuucPv9gf9efSJqa0QJ5AJ/pJfs0JaWOs=;
        b=nXmYO8bnlI4/76erkemRIN4RNc5S7QhEFPZqgnUmydaU0S08a5Q/DoRQMTk2E0ncj+
         kvFCC5tijAvG5eBK0n04tTTJt0I8V/aeDmb1X0FztHE1gvQ8yCCNdge3h04hjM83lQuA
         WbWsu5Ia5n/wJF3pF91arykSGpRkZi31P+ax2dzVgsu5PiySGLWJOiCV6UGETUav8erC
         vv29AkpwjvvGGKeT6Uo9H43hvwsFcagcf2aqTDJZdXSnEntpBEk/k3OVCxw5mYJZnjN9
         QbXZXURLvraqvTrLbag1d+cuHZ0jeDfBDvevYEXS4LFhJ/gB2Z00fGPy0ytPvDQTpENh
         5GEw==
X-Gm-Message-State: AOJu0YwSYyLZiLAn8IserpyTSAbd8J8YiIl027O4WppMs/tg/s6q34yY
	haA7cpSwhEanKWJlGGKhTUYtXAa685Q8RIW3TYU0PcwXL4yTJvlqaXjin+9u2r95
X-Gm-Gg: Acq92OEkG48qmJgzFMk2JXeKUj12m6I0K2ATK4z0SDo+jUcG4fRa7RJ96tVKqCvWf99
	olRJsMj9+PXiesv2kl1qjjPDoCk0R3YmZU175+BglJJ1mW8UvkhTFwGB2l9c72Sl38CSdoL456A
	hCYH36NfAxawKPEMR0h/QBLcTEzCHfs2SdVZPOl2ULmmqhb9Vi+Qu4zwdyMkowiGuT/MvfeGNas
	tpprMPRiDEfa/kpzY43jSFw7LTaTG/JmgKK1Gw8DqYU5GxiPJRoh4UGXMd0igrwzPqc5s83Zi2f
	udvJjHHeIvSmf2J0kGufbsmzPR7xv8yCJGzwLGeQXqIAwSB+yThetTPgitT4nrWeqoL4VUkNSlE
	rYz7l1N275ejiwXyJpdtlbolqv7eXpJHUzefJU4BnWOE8W2Vq55GNxYv3197MHeIvWpTsxjmEPy
	7JujFda9aDss1INrDh644R
X-Received: by 2002:a05:600c:4f91:b0:490:6e12:5418 with SMTP id 5b1f17b1804b1-4906e12552emr15448155e9.23.1779713702348;
        Mon, 25 May 2026 05:55:02 -0700 (PDT)
Received: from oscar-xps.. ([79.127.164.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454ac6a6sm258009565e9.12.2026.05.25.05.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:55:02 -0700 (PDT)
From: Oscar Maes <oscmaes92@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Oscar Maes <oscmaes92@gmail.com>
Subject: [PATCH net-next v2 0/2] pcnet32: switch to napi_alloc_skb() and napi_gro_receive()
Date: Mon, 25 May 2026 14:54:35 +0200
Message-Id: <20260525125437.4061-1-oscmaes92@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-291318-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 642DC5CAC36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the newer and more efficient napi_alloc_skb() and napi_gro_receive()
APIs to improve RX throughput.

In my testing this resulted in up to a 25% RX throughput increase in iperf3
tests in both directions.

Changes in v2:
- Clarified why releasing the spinlock during napi_complete_done is legal

Previous version:
https://lore.kernel.org/netdev/20260520063329.6387-1-oscmaes92@gmail.com/

Oscar Maes (2):
  pcnet32: stop holding device spin lock during napi_complete_done
  pcnet32: switch to napi_alloc_skb() and napi_gro_receive()

 drivers/net/ethernet/amd/pcnet32.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.39.5


