Return-Path: <netdev+bounces-253910-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGO+HzTTeGmNtQEAu9opvQ
	(envelope-from <netdev+bounces-253910-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:01:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5D09636C
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE3D53150C5D
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08E935CB76;
	Tue, 27 Jan 2026 14:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXN7MZta"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCC7357A26
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 14:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525077; cv=none; b=ZOFn5305LQMWCSFAFJ2Vk8F3nPCajCMghlmQHHgkCkN8q6dgEdkHmGqt/CQqsd46akF6/ZcLGHaw9t0HkaUNXV0qbIzInzzkcs331E0ns1kqCHtimWD6NkbPNThmZH2mV95NfQuVdcmOKunDm+cQxP9k5xRNb7eQ+uE83all8Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525077; c=relaxed/simple;
	bh=KMVl9/gf9ftHMlrNCaCL/oi8dCNpvpgPzgsVAW/084w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CdZS4Qi6BkknlGWmd2zzDkgtMhMputw7DmBuUCrMKbedN2JUGReDCC6cqYsd8aIo735UvJJTv51RpXI7wqA6JJGLed8CfycNFurGS+X/DzvFzeRuRmWQdcn1pWdxcS/RtTJFiM78hmFIgGE5Rpgj8xys8q6ieSIkl990Oge1VNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXN7MZta; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7903fc98229so55283427b3.0
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 06:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769525075; x=1770129875; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NXsKfDW2pJBcO84KnMkM+kAEFZYrQpwXoj0fFAgFrqc=;
        b=lXN7MZtaApiLM9RroAKsyilmc9SuYloyjLPdvut2kiGlJkngjTs6SYS8AoxrGG8o6v
         fZlIzCpzZnVw3onNsewymJnGzuxzkRu9H2btR7mfcQvVJ5LW0TbuN5t+Oiv8j5CVtNVR
         633ycW9m1UyAG2RNQMuU6m3/fI3vyohuOOUMYnR9+ifKgifHzpbUy3OJmJpq5kAceOmw
         p/A9HuoqnJXRQ5W8RsSG4I3cCy22Zp70H1k4pwhb53efbqOOdEzqqSfAxI6bx70emIca
         b0QuIEHt+DtJQMG3vRDrc1MZxDQE6DCOKTVYYiFdz1PKEeGMzimo3FIOT5sfQzJJn+O8
         lmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769525075; x=1770129875;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXsKfDW2pJBcO84KnMkM+kAEFZYrQpwXoj0fFAgFrqc=;
        b=Dcs/R66e0jFiMkGZRrQRINn3JqZd7im6NjQVtievRi2IEiRqnrVPu0rC2bM1FbNr9P
         kPV4RIVWAh1gKJIoCko/7QrDiiBC5n8lW+0WDfBAgbr/Ba/KVYCbCHmvXeFXW5hSYk9G
         y9bbhbabgO8iHN4uojPjOxiQxdarn+9/GyQwpmW51uu5ao67pjP0UxJ60gg8Nx0JFm6k
         kUoLtxLzq2FtQlA30uA2I+8NrMsEFkRNUZDdH5C1GahLQu3poEkTPHyfgHJDLXnCHjcJ
         9m5rMY0bYvLsM+GZYQIEstBENZ+Ef2ApXShI1efLr9KtubarkJE4rd48zY2SoN1f4VF0
         Rnww==
X-Forwarded-Encrypted: i=1; AJvYcCVC734T12FJkOsPs+LDEUqJVK2GpuEgd63cw7jCb3egzD4IElEIaiBLZyfr5jhJQQzHUezV/yM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx+wG/f4XSD4EtWzzbxM2o9cLnL6CMfIZQvXfBQFQQ+RihxbZ4
	XUamILvvzeVdCBWL3DnRXlKM6uLksUpDBh6w/ePEjkMelRMwIPSgnbt2iTwPFYyX3h7wPck+yf2
	6hr4+M6GYm+QW2w==
X-Received: from yxk16.prod.google.com ([2002:a05:690e:6d0:b0:644:5de0:129a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:344:b0:649:3f2e:5285 with SMTP id 956f58d0204a3-6498fc9fdbamr939978d50.90.1769525075260;
 Tue, 27 Jan 2026 06:44:35 -0800 (PST)
Date: Tue, 27 Jan 2026 14:44:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127144433.196836-1-edumazet@google.com>
Subject: [PATCH net 0/2] net: fix potential crash in net/sched/cls_u32.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	GangMin Kim <km.kim1503@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253910-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,gmail.com,resnulli.us,vger.kernel.org,google.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB5D09636C
X-Rspamd-Action: no action

GangMin Kim provided a report and a repro fooling u32_classify().

Add skb_header_pointer_careful() variant of skb_header_pointer()
and use it in net/sched/cls_u32.c.

Later we can also use it in net/sched/act_pedit.c

Eric Dumazet (2):
  net: add skb_header_pointer_careful() helper
  net/sched: cls_u32: use skb_header_pointer_careful()

 include/linux/skbuff.h | 12 ++++++++++++
 net/sched/cls_u32.c    | 13 ++++++-------
 2 files changed, 18 insertions(+), 7 deletions(-)

-- 
2.53.0.rc1.217.geba53bf80e-goog


