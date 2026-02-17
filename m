Return-Path: <netdev+bounces-259054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGuJDhx8lGkfFAIAu9opvQ
	(envelope-from <netdev+bounces-259054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:33:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F8214D2EC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 15:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC38D300463B
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 14:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335F62D8382;
	Tue, 17 Feb 2026 14:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ex99wPKg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC52356C6
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 14:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338774; cv=none; b=ZgwVlZdcDMXEtlQEvwqlFcEnoX61g/ZoJN87IE1JRQuQEtHZbrQYXT6b/JEw5d51EshfxBs4WQyO6Etyw16H/pttcWoBXkG1OU02Y9Oi3saq0fGKGWYnfdgwKu/opwg+YholIir+6AiOaZIl8IzAIwD6exajIzjkVtQBPa7a+gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338774; c=relaxed/simple;
	bh=51regzvlTrVRH572VciJP3Jr6oOu0PTdqVUzOG+7Q04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmpY7Gjifs/qNZH2L3cFOFr9WILeuIKl9Vl85d582XP4f5afo41/Ch4n3vnXX29Uu+dM+u2cNpb7RzutbluMbiepiIHY25sm5d+0hmWNuPPSYTr+TidsOaGNrNHgPzDJjstfC3W6F+UHm8Ms6nguPhR0DwJ6FJYZxBFfXADEEyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ex99wPKg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-824ac5d28f9so3150969b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338772; x=1771943572; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PK3wDL94RvHZRaijVfhwQjim8sVJxa74bWIAAhmdngQ=;
        b=ex99wPKg+lacYDsbqnotYbdhN4dKn4VV6owBRBU8C/ftWz48u3R+0dMm5GOCbFgMDS
         Wh8HQrqDkXYrftzuKjPqcG3Ac2ZsTkeB6TAgZphCNBFcVaNmeEMbkA5KWzGcOj2ClICa
         OWQloX+gN2Qn1Z9LOSq1A0exgdbVA4KcJ1KWjcVgPwHrItugsc+8BlO+IBtB7xtQuIsr
         tHzkMmPe1mCgpzPz012mF2gAGA/InXEZ/xKfJzouyO49tCdCvSiY7jnjdk+kR8OB9v0Z
         cD47ufU4/7TOB+ojRl5M7E1CLe3p4u4i6HfCEx1iARCAkWf0y+byy8OeoRrHEhEPkNS6
         8pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338772; x=1771943572;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PK3wDL94RvHZRaijVfhwQjim8sVJxa74bWIAAhmdngQ=;
        b=E24pc5h5NkyLjq7n1ZNIsKQ6Yt7cxyJNLpengdIZd2EuQVqCem8X9/m5PeiapBq1m2
         FCPsUhtVmouY212UWJDL+ahg5iP7PlnHnnNPk0gu/IW2c2GRUKLVD+gErgwMDuUcAJQm
         t2wHFL5gOIjQp7u/M4g03B6lF8IXZU7CEn4JiAG14uU6eNdFpsyfM7oJO6rX9rCucW1j
         lOr9WjY80So9bPSu6JlNQ/KLR8x/wA57lPzUtXZKAowLB5mG7yFkKUSgqDk2Hg6pfM1v
         GdRDKCx0l2zkycGCDzebT0Sj7c7Ybg1YU8jrWe74O3ZqPVrzLfaSJdMDPHXQT+yh3owE
         gyRw==
X-Forwarded-Encrypted: i=1; AJvYcCWc2jeQAnBU9FLPVD667iQlFOmC5Xi1uV2brUPl/muYvLd59oN6JgI6ei8xSlGtVSiGvv+FJxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkls4iq9qDOB4fG5Q7hxBAKcSnyP3YHqIl9ROtZSi5BwA5/nxH
	h3xT7y01nZg7Hyd/+i/GSRJTTyBBfcm50QCqJThxpYH1/VspQ8TxwXb7
X-Gm-Gg: AZuq6aKr4Yvzwzxmse6fn04IRC5HnqXNGdqq1/ehj19zeQCI3dnQ1QibFBxZNNkodaL
	fRCX4VFuLmJuL+zemLp2IWEnVsXSNQ82gIaY3i0XnedItYLxeksEWq+BeggqE+/jRvO+3YpJP86
	erJZaoBN24JpExp7kkOu7qc3aHGeb6Q2G2vZcJWlqAPQfEPergmrRBorOhws0DhhsXGho49nvey
	MHFfgqmkxKkqfhUQFHu7Lbg1SMzjpTnFbD3jJBjo+h3f0vZXrSGOaSBtfuE6qPwyhoKK/f5kpCd
	zBI3dK0SIHEAiIq1GfD0D8sDle6rPiKtpdMd0yaxX6Bru6TuM/CSKmZQW1x7PQcZTzOVueNHE9L
	nPhNvMdlsQpwjhzEIplVU58a6OOFABlKLc999yuay7YOWrsgjYx8fuBvZSdSL+Y+h21XKSfS9uw
	zCjmJ60ySLaVacc0O4rRX5wyoj2x4RsJT0wUmwp2vIVqx4eQsgBD/S3XpcEoSD6oxZ2dGqQy+51
	Zp8pJZ/gNp1Tml+4g+Z
X-Received: by 2002:a05:6a00:3c90:b0:81f:2140:136d with SMTP id d2e1a72fcca58-824d951713emr10954343b3a.23.1771338772337;
        Tue, 17 Feb 2026 06:32:52 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b935c6sm14770821b3a.47.2026.02.17.06.32.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 06:32:51 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	sdf@fomichev.me,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH 0/2] xdp: propagate rx queue_index through xdp_frame
Date: Tue, 17 Feb 2026 20:02:40 +0530
Message-Id: <20260217143242.4404-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,google.com,redhat.com,linux.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-259054-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anandkrshawheritage@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53F8214D2EC
X-Rspamd-Action: no action

When an XDP frame is redirected via cpumap or devmap, the original RX
queue index is lost. BPF programs running on the second-stage
(SEC("xdp/cpumap") or SEC("xdp/devmap")) always see ctx->rx_queue_index
as 0, and SKBs built from xdp_frame lack proper RX queue metadata.

This series adds a queue_index field to struct xdp_frame, populates it
during the xdp_buff to xdp_frame conversion (both normal and zero-copy
paths), and consumes it in cpumap and devmap when reconstructing
xdp_rxq_info. It also calls skb_record_rx_queue() in
__xdp_build_skb_from_frame(), resolving a documented gap.

Patch 1 adds the field and populates it in the conversion paths.
Patch 2 sets rxq.queue_index in cpumap and devmap, resolving a TODO
left since the original cpumap implementation.

struct xdp_frame grows by 4 bytes (40 -> 44 bytes), still within a
single 64-byte cacheline.

Anand Kumar Shaw (2):
  xdp: propagate queue_index through xdp_frame
  bpf: report queue_index to xdp_rxq_info in cpumap and devmap

 include/net/xdp.h   | 2 ++
 kernel/bpf/cpumap.c | 2 +-
 kernel/bpf/devmap.c | 1 +
 net/core/xdp.c      | 3 ++-
 4 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.39.5 (Apple Git-154)


