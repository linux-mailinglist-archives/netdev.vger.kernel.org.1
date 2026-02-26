Return-Path: <netdev+bounces-261113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPQaEOSjn2lfdAQAu9opvQ
	(envelope-from <netdev+bounces-261113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D52A319FDD2
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D377B305E9B9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC95372B3C;
	Thu, 26 Feb 2026 01:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuuyaBdu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DF3624A7
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069821; cv=none; b=OMpR3f9f82cBJ8QaIsmXcedf5oo+H+IVhfI6+LSGEBtpvS9Uvbkw0nw6AHYpn5ByNns5nvsLJf8YNKr0QfMIL0LnjN23ZV26ZGNpvnQHajnJJ1692hMBvVkjVrhq1XnjNtr2wCBw3gzCSmQwOBuiIChHq+JUTOY6twcVqyTMbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069821; c=relaxed/simple;
	bh=xYRy53zQ3Mn+Reu9g3U+AsM5aCYxddZdPcApXQ+X49M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZB/SonLMWraGF/rD0M0N9nZMi5Om4DoQWE3UoqY3sgkHLHCGpMf+pw3Ug7tI27PdD3zAi/FOWoi7OZSC4QkYpYyyFQIb1LYU+ulJZODvatx+619QiaOQYOjc7YYkKZv83jjGRpDLtbgfTTDSkTVjFY7E0rDLTtLiXZWJxTwxFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuuyaBdu; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cb3dfb3461so24506885a.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 17:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772069818; x=1772674618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8fhpa1TxtKtjGG2mp/0OIHM8y1DqiUuoXPWDCoBGlr0=;
        b=PuuyaBdubQCiZsVTd29IN0hiVVwGchurHEZz1dU2d74YfaRZitBlVqpJzkgwtJWVkL
         JldRfbXnza492/YOZyuNKyTnqwRwoVSpg4tTAl3Rlu/y7q9yOQLoQpphtc60gEgDCngg
         OdTNxO2khQ1zfUF/PP3+6JzTqF1cAfntHFkG2GMHBWka8+OCk+CiHuwA7+D8zmQ6mRS5
         1KeOxgK+vuVMp8lg0rEvKezZUfBuHLhJcvno/eDyZ8vPgLFDkkOQyONStwAk0RxSKK7B
         b3PEKHdmmF4ybzT8QAImSjLXa52LuZqMBAUUXuWQRHHwssRLhwGLQnPkaemrXOYEYjmF
         V0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772069818; x=1772674618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fhpa1TxtKtjGG2mp/0OIHM8y1DqiUuoXPWDCoBGlr0=;
        b=HlHDj0URMTSGh8ayeWdDWqELcsvYXNDx7tR9ICc09WIJnU++ny6WfY1XluWeslm8g8
         JjPSbnqU3eTKTZmMzJAhx0U3zfmJBWKaP9X4MLD8dDXxuq+GebVycMurZ8MYTat/1F1T
         5VSRfTuB7DzbxtpGezwDFk0+Z8WzW5kx5cMCVB7aLWEUq6sL6UnwqO9zv47mtTUTB/ie
         ZMecHLBk3AsDKtxTQPUmRsnAtwKS5gQN0eyRFI3/Qxkya2WGwSIKlVREvqOg/f/31FkJ
         o72wdQ18zw29xxY9fOWa4JpwfGM38Nz+z8S9TLqh/7Q/CXdarLwRlyLYWHqThPDiAroK
         2log==
X-Gm-Message-State: AOJu0YxUtu3WnLj+GVkI+vu4FJrPMrSMDBAXM5A7hm72Mi6+VyxiWaFD
	h4Sl3jEXon4QZB6Obc3pDtnOUipscScf9ZCQ8JldJSgGNzp55lmxB7ki5IKjRq5g
X-Gm-Gg: ATEYQzx0//ZHKMEP+1aQIB1Dhsq+pxXQvAf5gfD2UEELAOjjx36S0hHUyUStWOd+QRa
	6smEvmYliwekm2MaIws/NBD142VOncZgKj5DSdAlKAZSaeQVkXHx0hJ6oCNHKtzEBxKo4hDbqk+
	xqxPdenOT7IOBRSJIOHtqUO1L+GcboSjzJOaIrOvsjTzr8rJm7uHPFhHPuUN2yfdZbLDXkuE92o
	hgMziXMIGB1Or9B07j3DhBzWS42u/0GBWOTE2cj2bcuDhK+Ts6avAHKhRou/h/+/WBkbO6FET9Z
	8TP+7nARTRyGLx+7uJ9Vwx0vP/hcAuSS+QMWMpQcniHPEN7aRQLENooCgcG9JbgXiUio1yWOoef
	xg5pgY7wF5+oDS9VvD5H/094X5s60juITKUuGU7FVyHoylCka7ry4OlccD3WA2zdq9DdYmjh0BL
	lWgIozBuDk7OXUOWVrYoJ5tjBSLrDppHnj+RDUuMUTmoJZKQWyM/1iVg==
X-Received: by 2002:a05:620a:1913:b0:85b:cd94:71fe with SMTP id af79cd13be357-8cb8ca03fdamr2273905485a.33.1772069818032;
        Wed, 25 Feb 2026 17:36:58 -0800 (PST)
Received: from I4-L-HQH5357-01.ad.psu.edu ([130.203.159.160])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507451cda23sm6638401cf.18.2026.02.25.17.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 17:36:57 -0800 (PST)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	hdanton@sina.com,
	vadim.fedorenko@linux.dev,
	simon.horman@kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH net v3 0/1] serial: caif: hold tty->link reference to avoid UAF in pty_write_room
Date: Wed, 25 Feb 2026 20:36:41 -0500
Message-Id: <cover.1772055898.git.shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261113-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sina.com,linux.dev,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shuangpengkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D52A319FDD2
X-Rspamd-Action: no action

Follow-up to the v2 discussion: further debugging shows the KASAN
slab-use-after-free is triggered in pty_write_room(), and the faulting
access is on tty->link->port.

The report points to the peer access in pty_write_room():

    tty_buffer_space_avail(tty->link->port);

This patch holds an extra kref on tty->link for the lifetime of the
caif_serial line discipline: get the reference in ldisc_open() and drop
it in ser_release(), and also drop it on the ldisc_open() error path.

Changes since v2:
  - Update the analysis: the observed UAF is on tty->link, not ser->tty.
  - Keep tty->link alive while the line discipline is active.

Link: https://lore.kernel.org/all/20260215025141.1106576-1-shuangpeng.kernel@gmail.com/T/#maee804ef687b4442f18c74e8801f5cde421ab000 (v2 thread)
Link: https://gist.github.com/shuangpengbai/c898debad6bdf170a84be7e6b3d8707f (reproducer)

Shuangpeng Bai (1):
  serial: caif: hold tty->link reference in ldisc_open and ser_release

 drivers/net/caif/caif_serial.c | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.34.1


