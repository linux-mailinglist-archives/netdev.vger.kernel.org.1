Return-Path: <netdev+bounces-280917-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5TTCI3TV6mlQEgAAu9opvQ
	(envelope-from <netdev+bounces-280917-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01974458F9D
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 04:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57989300E3EA
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 02:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB6421FF21;
	Fri, 24 Apr 2026 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J99JNfrb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466D1DED49
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 02:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776997742; cv=none; b=R3LaqzkStKDGoWPjaC4JkBsXtq9yd90afc4ZLFseo+Q8x1k0lINS4U7yfpqG1/UbpxgY5bNIfJABqLPsJQZ0vnVIqVSzaz4zjyRcyM7WmsSIR0AuSmFcNdyadWGUAKwbfqLOcQZkl9Zf9irUgAjoK7vOj7t+KObymz3Xc+2kV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776997742; c=relaxed/simple;
	bh=1JJuCd1indy68sjG9MpkJnD7jnqVkpzl1iwBTM3zMuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RP6O3M460yMz+lkRcKPV9CawmaduyDru+i30CzkWBokRB64u7udZxEbTlx/XUs/fKrPPHDZhExlU9PYS3p+gXdo9kl4cXNUOcAlMi40CKPRyhGzJCWio+Jje/zf/TmIrx6L/UlMgDBS1sTktHaytLBNozNOgmZPUPiokC9mlhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J99JNfrb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c79467f128cso2755272a12.3
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 19:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776997740; x=1777602540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JJuCd1indy68sjG9MpkJnD7jnqVkpzl1iwBTM3zMuA=;
        b=J99JNfrbSYYxlcUIsrR6v0/7UI7pKWL709C1NLpUa10543Oc26QT+LntHCOLm664/M
         qgq6e6JOKRte+M2rUfdV7+Zn0sAajiDq5o0luUlz46pqrsBx6pJcfq6p4MMykCTWX6zY
         sYaTYTgFl6rRT+jPjCSmVOvPM9NRwnHpsDSO/PfyJQbUYIrox4QWS5ji35bWm8sGon0r
         EqHxbt+o7N+XwqNpZ0bbetcFRBEnifz2hDmaGviZgD7uuh8Rwav5AgImq0CvHX5Ym72A
         dMaamWedX+3gB2e/HbUrjIHJ66qbcaP5HpMIxZBzxcj3rJv/W3Mdeq5vME8uRkPA+ano
         BFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776997740; x=1777602540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1JJuCd1indy68sjG9MpkJnD7jnqVkpzl1iwBTM3zMuA=;
        b=QQ+UsC/Z1x1yogWN+G1HQ8Jw5/eoyymSKSN8ez9jxWnwNMdcYPw1tEN2aikEw2THLy
         +seHoI9dyWH017Kwbr/YlOlfo+Css3ssXXFaK7U5SF773ermxPcVIymHw2wGBnC+Via+
         3I+XzDamQdtk3Kt0SvAfYzVbpWKB0/1bwkhJG0XXFVszlPZAGlP6ufAsvyOxTR2RxwOG
         uRu85/neAVMDPhI6SJCjN7jKjele5oQA6//hol9dNk9Vk7SX/ORX9H1RK+BS/GqSy5cm
         bf7m903i8UIX5kAkYksRzVPrhpACE3n0m5TxNyLEgHLpl7wM37c9OnpeoLHu9m3NUUYj
         23Dg==
X-Forwarded-Encrypted: i=1; AFNElJ+SQvp9rFEzwLsgX4K1ZlP3WEyFHZpQMtgcPAdGtdFcW4NH5Lj9tASps2MmyVAsjEAFwjpf8Lk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlUZuQJTzn4p9l1ynEhWAztLj7BbsxCzhUcPkHh2N2xKMyMxdd
	/zEXQycMRp7ra/IDtvUMVxxTIHp+UrvUBQhMpGR+zlcAKP+IJ4+e5ziT
X-Gm-Gg: AeBDiesvBcHbvjYb8JiZF/gloGa7nkscXTKrycVUjwaZwPjGRvCOvcxEXAPjyW9ydQo
	Ci49NUBhaDuo+GnTrMRU0OW+K4Fo0JfmZwmPx6FrLg9VizMMWJDWXFPR8IaurJR1Cq5TCRN4UoU
	XP5eBLbIKJHlPpbWqDijLo/zmfpNhaWT/fHd7rSejT4af09MH57oZxfSoOCIAtOsV+c1wUtk7pj
	dhOsjyRt+wh2S+rbvAap9K07gTpruaD5yQoqaS76cissvof9zdQlQoV3uMpNb/R1NW5d9FyD4BB
	/rbNKmpVywsH7DJAVmYwP33lQGChZWC5uDz18xPmn0K+6QIe6aSml7aKWKJxTVUwhyfORgpzzNK
	H0PP8W7+dfCGmocoh9gpDDJiwWUHIAFXK8QlKg6A5uz/P7rLkV1oPcnkav/Sm+r3e8GFb92TAw7
	6QwB7bBl9S6S37NK6zUbmG7u0tcDogqhoGXWuwtRkhDUC7dTrB9SvD6ibXb6XV5gitt+dXe4oxe
	Ya51KAWpc4GBA==
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3a27ef485b0mr23721970637.26.1776997740243;
        Thu, 23 Apr 2026 19:29:00 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797703059fsm16477626a12.24.2026.04.23.19.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:28:59 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: qyousef@layalina.io
Cc: mingo@kernel.org,
	peterz@infradead.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vincent.guittot@linaro.org,
	jstultz@google.com,
	rostedt@goodmis.org,
	pabeni@redhat.com
Subject: Re: [RESEND PATCH] connector/Kconfig: Enable CONFIG_CONNECTOR by default
Date: Fri, 24 Apr 2026 10:28:53 +0800
Message-ID: <20260424022853.1113287-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420230630.205527-1-qyousef@layalina.io>
References: <20260420230630.205527-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 01974458F9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280917-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[soolaugust@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 04/20/26 23:04, Qais Yousef wrote:
> This seems widely enabled feature by distro in general.

From testing on an Android device: schedqos depends on CONFIG_CONNECTOR to
receive NETLINK proc events for both native binaries and Java app processes.
Without it, process tracking silently doesn't work.

Not sure if this is useful context for the decision, but wanted to share in
case it helps.

Best regards,
Zhidao Su

