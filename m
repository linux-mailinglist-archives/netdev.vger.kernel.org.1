Return-Path: <netdev+bounces-284954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIfJH7By+2m7bAMAu9opvQ
	(envelope-from <netdev+bounces-284954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7D74DE6FC
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 18:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECCF83001A44
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 16:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D84A4963AD;
	Wed,  6 May 2026 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9n6Z573"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B3407595
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778086565; cv=none; b=AY7l91hT9+NIahXNws/T+3tpLNsf3L+Ej/A3VHgoOUT3VG7EGCWvxsk8N3HfTwf5aK+blgRVGYPzGtFZs6CVlOiIBXtOTihSGFHk9feVlcFWdldgJ6pAJGPDv4cmcGgdV59ouuHOylGfDELuEAK6DNpWLYEYenPuKqgpMzyH664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778086565; c=relaxed/simple;
	bh=qosT+ruvwITclDF0NJ68R4Aby8ekKJM8VfSsMWq/y/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vBCQR0kGTAw86y4EF+mm+CMtzTppTC+tC+DSdQrmLeueZT0ZSIopjd3DFp2xmNcP9+F1h3pscgkcl2tTD8BocDNWH/6h8aaWK+42tjCvJX1MrHVGkYvElciX932Hs7hknGhnQEPIkhE1YaFECfBGpSndCgkFiFxnLhm7uHX4Pgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9n6Z573; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so75164305e9.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778086562; x=1778691362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8zJz68VAHZ5t5g+Gk/nEZDa9iG7OIx3Z96QaAXq0MJY=;
        b=G9n6Z573R1KXxbXe4htdDILpTeEpUda92+nCMhx0XAXgGElE28J192zOUlXBuqdoFJ
         W7vB0zzIBCpd2Sz5xQoYh/aAihCXBa3h9mP7ApxEzxg7kFPgqoNZPJTsrLusLV2AV7Au
         gvDRi7Z0soZx8gpHpU98W+8xGw6GtTcJ/hvyFo7CmYH3Fj5n/xJ1dHhQ7OEhI1sPJ+hi
         tCQ2mU21Kg+VSJsNTx3Afn9OGFxNJebkuwgLCh1EKvN4N/HzssS/Sec0eEpdo0XsNuDI
         7tVLOTdlm3Wwc+N+v1F0xZVnI/6R5su1GNXsRnJ4+DNhIEpSMpqSmuWLCc4N3cxFa/oe
         FTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778086562; x=1778691362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zJz68VAHZ5t5g+Gk/nEZDa9iG7OIx3Z96QaAXq0MJY=;
        b=Ia5Bt+ciIXykbMa4RmM3ZNqzaeCzPConVL/cGCLl5QpatwcBgzpVf8VfjGucqUa847
         p+L2PmdkrDPdRglqBod4iUC9WfZXM7RVEm/LT4yTdhbEhHdN4wz3kkQjEt5aqCDi7Qzl
         fqRJzMjX+obqGn7W0+SXCvAC2pwNFjVhKFlnILPURBnRgI3wACn5R2prjxixppWP0jCY
         5WjPOP2djTiXHJa1aL/iwv+loz1KJFo/XCM4GgDoGT1RLIRNQ8B8ySMX9fD83odypDlh
         euLoKZryeSAxspLc0zY0cWVs9Zeyz4IxtDS8E3Dy7j+s/tYTTbeK0VIfoBX4Errvbu2b
         mIeQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xkjxmIcDgT9AkSiNgMARunK1zWcdXZhffHHXTy9h7XC2x4Mp6Is2h0gkpk0wvl6YqCNu+82I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl63sw/+7SBbdfgR5GjU2wiZ7li0bCiQ9FRrPxi2L6XzJCVK1E
	8iOUZlyF+2wO1WRE2T08+W+TDK/AJ853nZEQz6IPaawL1DdvRyi2CJrE
X-Gm-Gg: AeBDietNbg0zv4H5mVHy8ULjGrcjUd5t7TPyZjn58LardSXWg2GunJOQGH8qjRvuNfq
	oAyDaXmIZNRL+ve+bBlVjBHYuCP5dyL9iYHKI9ytyY/nwk6E5SHU4PYkgJ3QRmGjcOsM0rUdHa3
	sr3wdAA33s81s901vMsowKRJ+dZTThsJqGwdRTLpFCVK/ewNJvQGcrtgl1CDPb2U4eAJ10lPejw
	rmCEOHHjLOAPEdl9KypFNzCPwxC+KXYzwI+wIU1DEWaGSTgMUkcJsMc20QGfXZxxjrNTrRBoGFU
	jqN+rAEN12ycA6JX1vGxy1BO3sY/LpbER5PotkyJadIp5NLXGSlkKekKWaDYCGgqcKMNGNy5It0
	3uxv0jWMon/5mT+P/7uiTKCTcdvT2GbMslPr4xwWQOBFUqSCTAZM4GS3rAP0dEirIqKFVjhZTqj
	G4T+uvo/UHcRlOUKs0wgG501txI2KqyLlCjtqzhtBs0zq+pdd2fC80JFG0iDYhUl7Nfhb4msztn
	g/9zLDbQ0cFZw4NXIBuzA==
X-Received: by 2002:a05:600c:a118:b0:486:d76c:fa57 with SMTP id 5b1f17b1804b1-48e51f37363mr58100775e9.17.1778086562085;
        Wed, 06 May 2026 09:56:02 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538d2878sm94586715e9.15.2026.05.06.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:56:01 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: mptcp@lists.linux.dev
Cc: Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	netdev@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH mptcp-next v6 0/4] mptcp: MSG_ERRQUEUE support on the parent socket
Date: Wed,  6 May 2026 17:55:52 +0100
Message-ID: <cover.1778086500.git.devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D7D74DE6FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284954-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url]

This series lets MPTCP applications use poll(EPOLLERR) and
recvmsg(MSG_ERRQUEUE) on the parent socket to drain TX timestamps,
MSG_ZEROCOPY completion notifications and SO_EE_ORIGIN_LOCAL events
that are produced by the subflows, the same way they would on a plain
TCP socket. ICMP-derived errors stay on the subflow queue: the legacy
RECVERR ABI cannot convey their per-subflow peer identity, and they
are intended for a future MPTCP_RECERR channel.

Patch 1 factors the existing inet_flags subflow-propagation hard-coded
list into a mask, so subsequent patches can extend it without churn.

Patch 2 makes IP_RECVERR / IPV6_RECVERR (and the RFC4884 variants)
propagate to the subflows. The parent stores the bit so MPTCP-aware
helpers can branch on it.

Patch 3 splices subflow err-skbs onto the parent's sk_error_queue at
error-report time. mptcp_poll() and __mptcp_subflow_error_report()
already handle the parent path, so user-visible behaviour matches
plain TCP.

Patch 4 is a selftest covering the propagation path.

Changes in v6 (addresses sashiko v5 review,
https://sashiko.dev/#/patchset/cover.1777756707.git.devnexen@gmail.com):
 - patch 2/4: take lock_sock() before the parent ip_setsockopt() and
   re-read the freshly stored RECVERR bit via inet_test_bit() inside
   the critical section, then propagate that to subflows. Two racing
   setsockopt() callers can no longer leave parent and subflows
   desynchronised. (sashiko v5 #1, High)
 - patch 2/4: drop the local 4-byte snapshot and pass the user buffer
   straight through to ip_setsockopt() / ipv6_setsockopt(), so 1-byte
   boolean writes (char on=1; setsockopt(.., IP_RECVERR, &on, 1))
   keep the same ABI as plain TCP. (sashiko v5 #2, High)
 - patch 3/4: drain the parent err-queue first in mptcp_recv_error(),
   then splice from the subflows. A previous splice that failed under
   rmem pressure is retried once recvmsg(MSG_ERRQUEUE) frees parent
   space, and the successful sock_queue_err_skb() re-asserts EPOLLERR
   so userspace knows to drain again. No permanent event loss.
   (sashiko v5 #3, High)
 - patch 3/4: use skb_queue_empty_lockless() in mptcp_recv_error()'s
   subflow loop, matching what mptcp_poll() already does. The plain
   skb_queue_empty() pointer compare tripped KCSAN against softirq
   writers. (sashiko v5 #4, Medium)

v5: https://lore.kernel.org/mptcp/cover.1777756707.git.devnexen@gmail.com/

David Carlier (4):
  mptcp: sockopt: factor inet_flags propagation into a mask
  mptcp: propagate RECVERR sockopts to subflows
  mptcp: support MSG_ERRQUEUE on the parent socket
  selftests: mptcp: cover IP_RECVERR sockopt propagation

 net/mptcp/protocol.c                          |  74 +++++++++-
 net/mptcp/sockopt.c                           | 136 ++++++++++++++----
 .../selftests/net/mptcp/mptcp_sockopt.c       |  55 +++++++
 3 files changed, 235 insertions(+), 30 deletions(-)


base-commit: aa15c271d79edde595fb6f4eedb52fbc16325a83
--
2.53.0


