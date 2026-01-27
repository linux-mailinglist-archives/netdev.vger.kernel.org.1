Return-Path: <netdev+bounces-253672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAegHWEveGn5ogEAu9opvQ
	(envelope-from <netdev+bounces-253672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:22:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EDB8F80E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4060300B466
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 03:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572C2FE582;
	Tue, 27 Jan 2026 03:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YflV8Mz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67029E0F6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 03:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484111; cv=none; b=no15Pz+Eh4Z2Bx43INLkqaBzT9pTZaVxgE9dGxqZ4RS0tqTcQgKyUWPeVi+hFvQxSL8QLuJ+6hpiS6aeTEO2LV6F0KDHq3tsz2jmJNEd7janZQ16dMfRYUxcMxlSvv3hyIZ5mRIaNfw6RbV7LpInMPqMJu5UeSVtVWHyBnXIY4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484111; c=relaxed/simple;
	bh=1cyN3eefRpHJG1K4/2RVq/+UE7rr/AeIvJ7yPxDcfcU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DGkQo2g6l8lJV8V+VD4ZU/5GwaIM/ezMiSf9jGuE2BH6ggHCdDzyYgsevYSjVvJvDIpPVCfgfj0LXWXaCBUxEIjKqIBUynObT4e4M17HhutVNTXya8yD5Zsiu27oXcUlKetZKnsELx/vtDpaR4zSKOnF7ZsnNeodXXzBHcnFE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YflV8Mz; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-89470bda22aso141497626d6.1
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 19:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769484108; x=1770088908; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyCDOyua4bEMVA8ezAo7O1nNlJqJqpNZUZun+K8DHDQ=;
        b=0YflV8Mzkulr9uVSczvzwTErHEsNAxl0w+tgDNu35eEl935QtZpYxWx8ZUUH7Ry6NY
         eZTxJXyrEIEzxMsBzfiqXP56rdH9LRGIxOAuJ6BXEo+zmnbiwCBPJ3R5i7RJkJ/7AwKh
         SyR/DLc3n+r02iRuEuW5OwVP6uvkAnzlw2nkUl2ITfNq4LYMFYyFbd4okgozMJBn5yen
         LrJN1R4y/AdiN158/n5V4eW2a6TlS4QmZA8qiJDrO327nBmrZFTqeiYQrbK2Xa0O5a82
         xkCafxeoveOvtfPoKOe4fy6QQQ/Tu5NCKpsM8AV1SSoayVpPW9IobshkQUnHDTzFfpQ0
         uevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484108; x=1770088908;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HyCDOyua4bEMVA8ezAo7O1nNlJqJqpNZUZun+K8DHDQ=;
        b=bmJGAYejAdg4k/ZevLo06UzuLF3nG8uJIaKbB6Sn5Ifq2m2badI0y7mAN5BbN0I61X
         OSf+71HTZ2VeynmMKe+uM8HXAh660UJq0MFbB0Rn60QM2SS2zGzuJOXB/B4ocmOZblXg
         2MIVlvG/xQsO/u6r78S1W3PiT0HVy97ply/vp3fFkz8Gj31q9f7jaNaY30goa+vhghmd
         Isz6N6/ox5HdlzMWYExO9TQAEGIyftZjPK0Ox846jQhDMBOKuAGhcWyKc3685MXCTmu2
         rBk3rR3ApvP9uvi3PpmGpkae0JUxVhXfxXJQYwiDzvIj44tZp1Lhwz6L0msGV5VLCb/O
         T/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCV3gnUJ+1pUmaCV/FjYCVg5jX+pRpLy6K+u2zy7M1a9LPWIINUhLuoWHpH1KM34XH6L7jnXRQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7zcQO8cSKof0Yd0RO+kxdY7ft9oRmDTMDpEtHVH2CrQAe1rL
	utqCqfkbgjgKp7axDHu1/Scm5G0gPJjWviqZgNLbJ4X3OPFUnuFpJ16WY4lZ6hOgnB90HMOamVY
	FSmbcsd5pg+Bjbg==
X-Received: from qvhc11.prod.google.com ([2002:ad4:5aeb:0:b0:892:72f2:d23c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f05:b0:894:8004:b104 with SMTP id 6a1803df08f44-894cc8fdaaamr4849656d6.44.1769484108682;
 Mon, 26 Jan 2026 19:21:48 -0800 (PST)
Date: Tue, 27 Jan 2026 03:21:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260127032147.3498272-1-edumazet@google.com>
Subject: [PATCH net-next 0/3] tcp: make tcp_ack() faster
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253672-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D0EDB8F80E
X-Rspamd-Action: no action

Move tcp_rack_update_reo_wnd() and tcp_rack_advance() to tcp_input.c
to allow their (auto)inlining.

No functional change in this series.

Eric Dumazet (3):
  tcp: mark tcp_process_tlp_ack() as unlikely
  tcp: move tcp_rack_update_reo_wnd() to tcp_input.c
  tcp: move tcp_rack_advance() to tcp_input.c

 include/net/tcp.h       |  3 --
 net/ipv4/tcp_input.c    | 79 +++++++++++++++++++++++++++++++++++++++--
 net/ipv4/tcp_recovery.c | 75 --------------------------------------
 3 files changed, 77 insertions(+), 80 deletions(-)

-- 
2.53.0.rc1.217.geba53bf80e-goog


