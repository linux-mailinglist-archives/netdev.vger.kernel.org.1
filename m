Return-Path: <netdev+bounces-283056-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LWqOTz/82n99QEAu9opvQ
	(envelope-from <netdev+bounces-283056-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 658294A9886
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 03:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEB6A3066297
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 01:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5D629BD87;
	Fri,  1 May 2026 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT8A8Nkb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF1518FDDE
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777598178; cv=none; b=CbFw93DNe17MndQwitc4Q2y4zDFhbzhscPMUqB6aBKcPqXtPG2eL5aqQ5xh/2MEJZiNNxH1zL/dWDzyFrjceiTwejRCgWbqqZnBDdvWy2m/lEpxMUukbi9u6jbAab/V5Z/8PLBqP68r4ART2TwIrPu4KGaKloPaQPqvWYf6ulWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777598178; c=relaxed/simple;
	bh=JO6PXjlfHfBnLGzUji8BB/JYESf8hMrMH8npw/5dtY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q1x8z7sKD4qQabZ18zjcH+TO+cnKHusFWosU5N701Cx3Sqc8fJNhkVhjJ+0ViIKWFEUz58LafxH00ywaVKYBBmixIfXVAEZr5cn9D2nosQ35CM56a0iuPW9Ubx8hBeH0ZqSBOHHsaDxrM3RLcmYTVWrR2fLXWiG418q+QIPWA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RT8A8Nkb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891f625344so16406785e9.0
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 18:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777598175; x=1778202975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZueHIPSPNTV1ZqBjmU63LlwYCH0Ig995X9Tl5eH7gHs=;
        b=RT8A8NkbP8Jgr474lOUqUCBHTxzS430vc+vI2zhCNYAMxU7D86CUJ23tW+fo1qYNOP
         iLGejOf7jWV/mOOaIHnkHvkfxSaqzAG1EA3LvmnxnKAutGtoMzJ+trrh3Yg8mKmQv1H0
         cL6DCf6c1KF1U6D6CM3HKyMUPW6MDT4HzGZiwFsoyCOccSMStjb9F9Y9qbW3/ovcMhbO
         tiNEG8730fSRI02uVloWc6/xLgIeXvL4VJWar/sLQQ+Sh+XiRRK3zN8NdjRVnBX2ZN6E
         VAGymZsRZF7BW7tp7NgfDr/BK+PCSlq0wEezMcJpWRMwng0L6WUxlfPvQfER7jMBh+ve
         HwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777598175; x=1778202975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZueHIPSPNTV1ZqBjmU63LlwYCH0Ig995X9Tl5eH7gHs=;
        b=jHKLaSonCgHeQ1HfJAuQmQ5Xb06uIJS85BwTCsO+wUSZEOI9c72C4gG4t7euQET3Qu
         bqgiIodjQmiYqgZA0lxHnm6JH8iVJILAqjugi8VhLtE6DdEOf9qz0DkgtSd+3xG92GvD
         685pM5Ma9w5r9cmA8ePqGYIeglJi2uwsL+FyDzGH9RqmYY9A39E8R3+5XEf5kEHGXWL7
         +udH0locFsT1veQV+oqcrhw1SoQ6zp+2njhSyT9qoVgLEC7yTWqvtlNoardI8WVppY88
         NJFiSbyAHc4XDgbx64QVgDa/LYAjguMGKtEOEcyLuoo5HM2ccGHMqSR8iBA4kaTvMZvS
         da7w==
X-Gm-Message-State: AOJu0YxPSckTz4pm9Ssc4MtnG2iSxl4xWaP/ldupcPu235xT4+j2ilth
	vuBl7HWP8sLOJ88is9q7emCRg2VrdYZaMIivU3Vvb7XUSiRv8H0sawM7LISDj4oM
X-Gm-Gg: AeBDies3cUn+7ICU80/ktuCazqBz+E4rLU6/isdL7JaE/tEvuwio46MXozc0M8s421P
	WtkF3V7DT4/IVdzHaQl/PfVEEvQpBWOh1vszr30ic5yeuwLhfXmcsV7m/TqErhE+eT2SwoiYuW7
	bXcoUUdOKA25DHDk6nio558DPFjVcqsSi2xOdxpdpWteBEE/UxIznpLtN4DUeX4l6Ckz+vzhHhS
	c1+HuGipvlcOwSa9aTaUPOXWmfelJbE3+2dzTMjKLGPQFHbuCYoMJMMTMG/+1W7MlBGePvwgZl4
	GAO6ehmLLH5K42S5NItnMKW7jfz9jtdjMJkiUrKbsDR9Mu+3Wy6G8Bz7qe6fgmootPP0cEWyuIl
	QZCP5Gd+4oZxvmh1fqrNu4DqpnszknKMvLgAu9tO+tpug4zZwIWMBfH8lyWJ16urkUCWfluBYTj
	YrxDp+FxaM1oDjbjjnF8ERYs8f6tWmDw==
X-Received: by 2002:a05:600c:4b1a:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-48a85dc37c2mr43435225e9.0.1777598175294;
        Thu, 30 Apr 2026 18:16:15 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8feb8595sm2694385e9.2.2026.04.30.18.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 18:16:13 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	pabeni@redhat.com,
	kuba@kernel.org,
	ernis@linux.microsoft.com,
	mohsin.bashr@gmail.com
Subject: [PATCH iproute2-next 0/5] netshaper: Extend netshaper support
Date: Thu, 30 Apr 2026 18:16:06 -0700
Message-ID: <20260501011611.3533573-1-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 658294A9886
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,redhat.com,linux.microsoft.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-283056-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mohsinbashr@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]

From: Mohsin Bashir <hmohsin@meta.com>

This series extends the netshaper CLI with missing parameter support
and adds the group command for building scheduling hierarchies.

The existing netshaper tool only supports setting bw-max on individual
shapers. This series adds the remaining shaper attributes (bw-min,
weight, priority) needed for TX scheduling, and introduces the
group command which ties leaf shapers to a parent node in a single
operation.

Mohsin Bashir (5):
  netshaper: Extract parse_scope() and parse_rate() helpers
  netshaper: Add bw-min and weight parameter support
  netshaper: Extend show output with parent, bw-min and weight
  netshaper: Make handle id optional for node scope
  netshaper: Add group command for creating scheduling hierarchies

 netshaper/netshaper.c | 398 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 324 insertions(+), 74 deletions(-)

-- 
2.52.0


