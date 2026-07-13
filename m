Return-Path: <netdev+bounces-307274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lJr8KiNLVWr0mQAAu9opvQ
	(envelope-from <netdev+bounces-307274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:31:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0877774F0B6
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 22:31:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="RL/4Blut";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307274-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307274-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBBE43005798
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFEF35AC3E;
	Mon, 13 Jul 2026 20:29:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C973B357CE0
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 20:29:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974580; cv=none; b=fjxP4bHePAR3UXzEuR2fuygc91fwt3M8VSwPfAflf51T5vT8s29WQ0DrWGUlxssz9vRvoVA/jMPAm8oJV51iJJ5SXI98O2oPcGc6kAxmCqSK0cKE2V52ZzZiVWAXNiqMSZG/ZlpfZb8ubjCWIBz8duHfJriN4fUfoQPVX9j+CKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974580; c=relaxed/simple;
	bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lpzWpwvG8ZJr1oNxUgXFdAW0sCZFBnhZImnB/iD7ucRuBfnPwDQbm3sqV5qUN6kh46f/9PHn94Eo6WLV90uTXx+7Ydt68rsWT4GnEeEdpq8Hr9l8lkv5VQGtHXl8FAh2sGtdXy+pEzYoAEWYGn5csotElfRPHVuOCytsom+yYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL/4Blut; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so31935525e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 13:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783974577; x=1784579377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
        b=RL/4BlutHr2b1g/WoWedg1TTfxqOZYtzhRJly9tQilDBxWqxRX28ESzvMVqOp2negm
         RlQtQdX4iV7hjoFbzsmL1CU8hORTzFlsKlDlpCBFaKJPJF+xtgY9g0GIviBk18dspzjR
         e92Rcr8R7/9+j5B8XLJhAVu0/cbKezoYgjosP+j5zSFQCchu66ZkD1DWcjbnxxEv0BYg
         46c9x2B/7PVrsFW6JqLAvQxuOJrD/yH0tUTYmVU+RC0eAMeVVozudrnUh6ZIUAIJnlnJ
         /puQgK2OHZp+IzJg+LS9md8CBNAcGV5hKlu1aydw+KG8ODWkVY4q7Z3Wgx38fWkUiuKP
         BLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783974577; x=1784579377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x9tQjUWjYVsPnrJSRs8ZwJKtHiDSOdJeKDqHoYOL4Kg=;
        b=ZhuxqYF+SrQVHKxXy+wUO+XxKDJhJfHiVDswKeGhx2xCyMPHQvEc2qVHFV6i1AzpJV
         sc36ky7l6+BuvrIsMg/Jjrc9wZWoxEIUV+bW9U84z2fMbZtpdENDiTRl2qqlhFndDHUA
         wsxI2DOB9N04jXivcGfpMVIqpespTQT6LUrb6OVJv79Whys8lHsL4Lgs5VT/rbUXM0YN
         c0E0oG26Nq7At8bId8JwLZm+pdS/OYHlDmVkMzNjffuV1eZlmMo5y2PGoBQ+auN5+F33
         Svzut2iIT3Dc+UXcTSh4nwZqsQVo+rKgoP7oo6AadgXeKRYRHHTqAtpaBdjMx/NGJKLj
         NLvg==
X-Gm-Message-State: AOJu0YzSYIAkXsMPpKHdRqIp8+wNciFM1EdLrfH70d5KhgM75XStuJ4Y
	tWEt4YPinMd0zfGFiZ7S9A8scsJH7fZV89+5UN6b/v9PgfMuGGn6NigHkG0aoPl3
X-Gm-Gg: AfdE7ck2LGK9bdrAJA+APf3bk3f8cDLtVTw9vrIOjKd/IrycmyApPP7yGW0u9GjITEt
	GGTQAWcOBIuJcX5sK6tgc74WXJxFwpQZEuwZRplQnwJOu6EuIYvjMSmMAr+Kyf6qC+DDzuKsoaT
	s4ngWfd7aXQSLjOPy98MmxkuGnxkdqU4aa6SpkFSU6kGcc7k7jzNyTagUUFp2EIxvBLXmq4mXur
	jb//n4oKxzBk5KaoQwv9joN52wyrDvAfr3Dg4QX8Ogj4f7+S+1xASB1ftZfEmNAIffAHo3vQav2
	7eBuWdr8UcNV5T4t6dJTcSRPMz0kb9O3x+trvOr3l8wwpP5fZHTu1rSNFrgzEZ5yu+YWbs0l96t
	iogY5aKqM3H3b8rAgyTexZx/6dGDiD9orpKkGu3B90MTKJVB5GWJksNqDaSQxEeoIYiH0y04EFp
	kBNjbbyvAi2EfTVL4QzQ5ysbajlXXioEd/nwLIYPU/7GGVd/TDBrOuj7M7PtCmo9DW+TE=
X-Received: by 2002:a05:600c:a00a:b0:493:bf88:edbe with SMTP id 5b1f17b1804b1-493f8818e35mr107750425e9.19.1783974576636;
        Mon, 13 Jul 2026 13:29:36 -0700 (PDT)
Received: from localhost.localdomain (i689755CB.versanet.de. [104.151.85.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493f2e77c2esm244525385e9.2.2026.07.13.13.29.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 13:29:36 -0700 (PDT)
From: Nils Juenemann <nils.juenemann@gmail.com>
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	nils.juenemann@gmail.com
Subject: Re: [PATCH 1/1] tls: device: push pending open record on splice EOF
Date: Mon, 13 Jul 2026 22:29:33 +0200
Message-ID: <20260713202933.48674-1-nils.juenemann@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709224436.1608993-2-rjethwani@purestorage.com>
References: <20260709224436.1608993-2-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307274-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@purestorage.com,m:netdev@vger.kernel.org,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:sd@queasysnail.net,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:leon@kernel.org,m:nils.juenemann@gmail.com,m:johnfastabend@gmail.com,m:nilsjuenemann@gmail.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0877774F0B6

On Thu, Jul 9, 2026 at 4:44 PM Rishikesh Jethwani <rjethwani@purestorage.com> wrote:
>
> On kTLS device-offload sockets, sendfile() with count > EOF can reach
> ->splice_eof() with a fully assembled but still-open TLS record left
> pending.
[...]

Confirmed on ConnectX-6 Dx with TLS 1.3 device offload: with this fix,
the sendfile() count > EOF + abrupt close() case no longer drops the
final record.

Tested-by: Nils Juenemann <nils.juenemann@gmail.com>

