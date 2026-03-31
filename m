Return-Path: <netdev+bounces-273747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBZbOi04zGn7RQYAu9opvQ
	(envelope-from <netdev+bounces-273747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:10:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EDD371660
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 986F3305FA0B
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 21:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02233426D30;
	Tue, 31 Mar 2026 21:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQBVeCXu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B693F7E85
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991258; cv=none; b=uli0BgIew70ekh/U5+qhmly9QOXFH1Hwf4We5e4GAEquVdB1TF8ibbI1wUJWFMxFo8I5Rg1vLWjehlRTWP/O2ktJbfcV8bE2O3mLc9EhE6wm9nK/CiIWCNWZF8P9Di+JOSQfqlFpLUDeyJbZwyml5rl1uvEOqOPuSC5R46bEeAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991258; c=relaxed/simple;
	bh=pwg7obW1F45qdk6CF931VQ3fdTHsQqpoLghThsE9nsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCegfgf6sptvP2tywwiob11wWEh0iFfq9SHRJ5fHHVjs4x71hpTqfqQY4C01Y5y8R/QMw4ZApcSKCywV0Q5XiSClxILcCUbrsIR/2DgWd/fSJZFwwCv9e/isuZOWahMFc8EqUkP2klkuFex6zoUzzGoqVypeE8dLQFmk7vuD3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQBVeCXu; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d03db7f87so1327048f8f.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774991256; x=1775596056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0roaam8cmLBX+UQ0cLs13fGICp7YbtIQisTozBtEwtY=;
        b=aQBVeCXu02RZ5/XP6IqVZc+e+ZsjpL1m7jHgrhYkqewLr24JRyvjzdyFcGgJ3tGmRW
         ACM5rujXmA3Cq8sRfOW/goJt3iiGe6Vje9BMyvT+MncPVuSSe0r64LyhJe4JnuOKecrz
         +AXk2BGgfMW+/yI/aGzWQDvbuGlPZheFhN81w8zvQO+oGAgjNMMq2Pt1TRTR22f6larX
         PB7LzCCjEdCkhILbA3x00AMI3VJhywGGF+hNk33CyjCVDvuc3sK9u9Bb+mWcTR08BEqH
         Yo37QIo2VT943GnUTuM1zXwiVHRbGmErGfbcmagMFD0rktr7qA3VDxwy/K6qxn6Og4My
         yNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991256; x=1775596056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0roaam8cmLBX+UQ0cLs13fGICp7YbtIQisTozBtEwtY=;
        b=o6WPSY+234CPmUncm61fsiRKfSoCJQq4syljr83Wi6MKYHYCTpr2ok4j0cGulCLQRj
         0xLZSJ1/AKBuFOIfePfWzylgy6q0NSTPPlCusBxDLx6tO3G/qhPstpvDbodHlqzuUBlF
         GqY9Mq4yncNZGFp6wLzbJubxas3LLaIwJhcGvLfdNvxH4nureUrfqjs0dysE9msFK+2v
         rf3BhEQenQ6nJufZ/KYGAh67ioxRplmpFZu73xOsNJ9tNL9G448WEZj+Ab/au9Z3n9s9
         TTPDOVcZVU7n7ZSdzAH+WB6swxRErKA3XQSZ7mIL0MnCQHdVOgl28nJX5KvWRuPhQeV1
         kXyw==
X-Forwarded-Encrypted: i=1; AJvYcCWh2ExCYka7k39EoLJIZ8UE82CrHC0AiA0vZNYifnf8zrOp5JqBEmh1JL+IliquJ5d1dWEKjrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktHMLJyFvcq3UP5fLYTIn04gVdIHUeCaCrLWDouZTFWzy34sO
	mWnxh6dEYWt8YtDGn+6Z2CFeuzpvhqU6XyDOQyDkYzWy3m+MSVJR9YNo
X-Gm-Gg: ATEYQzycg6+pN5pGVRAIJQEfnDEoWsz8yDq3xjPn2ezVGEEl31mpmZLsU+JikId+UWw
	ZOBEZdWGy3IH+CNk4TPJzdqdZSVGHw+/mrgnrW944TgLjKUAeTh2Nj6JiEFSSuTP5bdi5/25O69
	zL2k/utAJNkc/7/NtrZVHyuvoGDe11ZzrIpgafTB8B8YbvuaTlqqBLdhQak5Om70PDgxrJ70cWA
	g+cWYO24DNv/yuP2ZTh8GEyg5ywlrNh/TLbrRzn2aaw3nyflIOPk1jjJk7GEn0yHMg5Wvg5ORH9
	61on9+5lfLsECjEGBHu8pzmUzWROtIRUpmAHd6VyBtDnTiOetg1TVB5gMAWj3xvylv8npxn6uTG
	uLkrXLxweMZUYt6yiJ+U6TfxxOFPN/lvF9FHeiuM+NBs+koWs2K4lL4NRxIOvbDAPagG7ZfVBXt
	/6iCxXT9/BiAvJ+7UdD1MyqAKh4RhgW43Sc+xp7UR3uMrkSanKuq3fNKxstzx/l5l+IlGawxqVO
	jKLNNO8DXQb7XniO4lVl0JJH4zCQg==
X-Received: by 2002:a05:6000:230c:b0:43c:e7a7:9256 with SMTP id ffacd0b85a97d-43d150513d6mr1976348f8f.12.1774991256052;
        Tue, 31 Mar 2026 14:07:36 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf2570b18sm32431393f8f.31.2026.03.31.14.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:07:35 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	axboe@kernel.dk,
	netdev@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH io_uring-7.1 v3 2/6] io_uring: cast id to u64 before shifting in io_allocate_rbuf_ring()
Date: Tue, 31 Mar 2026 22:07:39 +0100
Message-ID: <52400e1b343691416bef3ed3ae287fb1a88d407f.1774780198.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774780198.git.asml.silence@gmail.com>
References: <cover.1774780198.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5EDD371660
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Anas Iqbal <mohd.abd.6602@gmail.com>

Smatch warns:
io_uring/zcrx.c:393 io_allocate_rbuf_ring() warn: should 'id << 16' be a 64 bit type?

The expression 'id << IORING_OFF_PBUF_SHIFT' is evaluated using 32-bit
arithmetic because id is a u32. This may overflow before being promoted
to the 64-bit mmap_offset.

Cast id to u64 before shifting to ensure the shift is performed in
64-bit arithmetic.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 1ce867c68446..b8f15439d5df 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -384,7 +384,7 @@ static int io_allocate_rbuf_ring(struct io_ring_ctx *ctx,
 		return -EINVAL;
 
 	mmap_offset = IORING_MAP_OFF_ZCRX_REGION;
-	mmap_offset += id << IORING_OFF_PBUF_SHIFT;
+	mmap_offset += (u64)id << IORING_OFF_PBUF_SHIFT;
 
 	ret = io_create_region(ctx, &ifq->rq_region, rd, mmap_offset);
 	if (ret < 0)
-- 
2.53.0


