Return-Path: <netdev+bounces-298141-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K9DkJ8K3KmrqvgMAu9opvQ
	(envelope-from <netdev+bounces-298141-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:27:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D2A672542
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 15:27:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="QZ4/Rdxp";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298141-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298141-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B27930512AA
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3F83CE49E;
	Thu, 11 Jun 2026 13:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8CB25A2DD
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 13:26:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781184390; cv=none; b=dX76R/P0S+akQIBW1bxuKEM8d6fXhECV7b/sBIcLupiwlVbS9KCbgAftAIVMqTatPN6tN9qjuM2R5zelHdyvJPoHwg0Dv3CLiMCxHodPq1lh7iyKAN2f89DDCw4CKad89/FGc+6vU9WTe/AoQHvB2iWbTAs7b5UemQmLe8Sx0TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781184390; c=relaxed/simple;
	bh=5eiDG72FmcTIcymywOMWrf4fpsSQUC9Tucr/Q+S1XmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QdlsKXv/45mpQudEX0UEaQqIWHZRnf0/JmVXFGO6aaJCpPrmGqR1LW4pEC7GhmuKnTpNzi9Ze8WTr9UjgQy/Ak9CmAuJ+QG6K+RLUjwidGXuEcYY66qTG0MgnaRYBaD1Kg5ekbkWm26ZV+XM2Cn1pWMLaQCa+TQJLibFVb8o40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZ4/Rdxp; arc=none smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c85a297d2d2so4757341a12.0
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781184388; x=1781789188; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=phN5hwMvPB/PB2fAfWiuemrqSlpROfyR4bfERnZKQ5Q=;
        b=QZ4/RdxpEWSnK5OBxdUQg/3X4CwWaWDIhRaWArSzz5ycuJz4T9ycTaIUaIRtvDfbsS
         sNJmyGKIdZy0ECsyUUuMYQ+tjWeo7WgUl5ad5qv0G9h/S/5raA5HQBgXIZIRH0idWjRu
         pBu7sjRkMi33NuxrPK0A8Otl0hsnqeYXTZhj87MbPOs5eZl/hCkBGzDyOxgUGvJpCt/f
         TS3aodnvTPYutEWJJUJfvplXfaXNA1r1TvSsF3FeQlhZKbA8eBbq5biDpzBG5MPYfJ9z
         NZEq5N0ikPWkHNwfgyvrjG6UTpm9A8JgEvmkkyZIwBkkQo0YX32u6IT7aSqPqbmZ5ryN
         wBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781184388; x=1781789188;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=phN5hwMvPB/PB2fAfWiuemrqSlpROfyR4bfERnZKQ5Q=;
        b=Sihe5hDt12yGua1R6iI4qp7WIbrQ1j2IN7f4K5nIse9vFA1AJixSet/wRGJh+/dWFN
         vD4ffODI/jevSSbNAglxMlwklhlpFOuGo1l2N9fiwQZ0UfIb67ZgdNvaNVsJAC36MfOX
         LX/0PmmbXKQ735kO0ZLnzH88CktQ0VFfXoOSMC2ilIcgsn0/v/vSQJCO1jljflhQtHWw
         46dH0qfdAuRCjI3wSO62ejJgOM6tmzjB8qAZylCKy0P8RLKIEHVVejp8Xb3IAoGuP+hs
         qwBVESj2/JqfYJZZZ9rZYyn1S6QSu0rXp0NsZem6NVk9GbYbj6Y47cnMTE4gRvHdPJsz
         QCXw==
X-Gm-Message-State: AOJu0YwtoOumhkKaCvtwTIKMd/AwHuejSLfJIjHMKwu9TNWO23Z8Ka05
	+Lcj4adD9cZB3aWvCwm/uhgK3moXId8yuCm8uzzS2nR4XlAlOTBw7ShfoL/XEbTzDv0=
X-Gm-Gg: Acq92OE8B+BnBmsHDTN2Z/JSjtaZbduKR3y0oLeD0w6O+Xvx6pOfDzssJHMV3piiGK+
	t1D6Is3oozNgBOCbVCFM7qElWeZhxQGAGjIYT0J1j5GhQk6Ax4mdoc8k44IZa3vk64Pzu0Z85x/
	XRa2lhqCnEYC9P9f37lkAVBpdfz1a8v1ayhHBC1gR+T0ihypYJWwRhSTfnG41OK0Seq/qqXZAw8
	cj9qthqytEKg8jWPreBx2qpJ43M2WXjjn0IumHygSC5RS/tmoJKzPfSEJ6tK/Y3oIbc+8x9LFfj
	tF1T6zmg7cfb5gFVHiTBjjA4oJks/VBfNi4YUXA6XDUDE6csMfxp5640D+QPj7cf2SY+mCv8iId
	LHPVPjuvx45ERRgjGVBdAkxnTKk94AmVZyWxCM+yvLdRv7SiSuqyEBgKuqXZEx7HuLDWEZ4fxky
	pu1Q82uPrk5MaL4cDP8hEA8Mz1wEt4ddW4ptQG6BUGp68kUQxTqloEO2k=
X-Received: by 2002:a05:6a20:914f:b0:3af:6704:18ca with SMTP id adf61e73a8af0-3b5e33e168emr3313891637.35.1781184388323;
        Thu, 11 Jun 2026 06:26:28 -0700 (PDT)
Received: from DESKTOP-19IMU7U.localdomain ([125.242.148.221])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8658816730sm1937962a12.27.2026.06.11.06.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:26:27 -0700 (PDT)
Date: Thu, 11 Jun 2026 22:26:23 +0900
From: Wongi Lee <qw3rtyp0@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, asml.silence@gmail.com,
	dhowells@redhat.com, willemb@google.com,
	Jungwoo Lee <jwlee2217@gmail.com>
Subject: [PATCH net v3 0/2] ipv4/ipv6: account for fraggap on paged
 allocation paths
Message-ID: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298141-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[qw3rtyp0@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,DESKTOP-19IMU7U.localdomain:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D2A672542

Fix fraggap accounting in the paged-allocation paths of IPv4 and IPv6.

The IPv6 patch is the v3 update of the previously posted patch. The IPv4
patch handles the same code pattern (by Ido).

v2->v3
- Add the IPv4 counterpart.
- Mention that the IPv6 corruption became triggerable after ce650a166335.
- Remove the stale comments about copy becoming -fraggap when pagedlen > 0.
- Add missing Cc entries.

v1->v2:
- Fix mail format.

v2: https://lore.kernel.org/netdev/aigx83czv+UJZA0d@DESKTOP-19IMU7U.localdomain/
v1: https://lore.kernel.org/netdev/aibiIYMAwUErTw5U@DESKTOP-19IMU7U.localdomain/

Wongi Lee (2):
  ipv4: account for fraggap on the paged allocation path
  ipv6: account for fraggap on the paged allocation path

 net/ipv4/ip_output.c  | 7 ++-----
 net/ipv6/ip6_output.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

-- 
2.34.1

