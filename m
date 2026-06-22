Return-Path: <netdev+bounces-301137-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zW1DI0BBOWp3pQcAu9opvQ
	(envelope-from <netdev+bounces-301137-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:05:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D65306B025F
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 16:05:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=nbH1VXKe;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301137-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301137-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E650430B5C97
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 13:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6172C3B5E07;
	Mon, 22 Jun 2026 13:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57C3B6BE5
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 13:58:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136727; cv=none; b=HENC7d6XDtBE5vyPHZYhdJgpmfmO2j3UqKbT9JtlBlJcVxCV+rgGzGCK4gOh0Ref4yQ0v9kWmOl8f87QX+4ph+Qg4O4d9XCB+JumqbqAKCItEUW/A1Vuhr7C5brxdcxVXCAJE7mdGKyyYc8SOW9LYoX2ZczDOnBcVswVFGaTWJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136727; c=relaxed/simple;
	bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHWZuWVGFAFtI7+OzoJy85BaYuYrqttdbGiJA48Lmw2DhrGhln6kqWpxEpkSg4a5blod1PiMhE4/HuYBdkcT4Ik2VcNDOkF9VTNDtmaR9Xc92cr5BNgxqHI0Urd4jV6VZcaA+jZbiu/CmbwSlbp6cav+oqDxy351ZJ1UT8auEGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbH1VXKe; arc=none smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-696bf0e7c9cso973865a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782136724; x=1782741524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
        b=nbH1VXKedQA3kX7XPNt85mRKNZQyR5gUWsnmACFGmvrr4uGVIskrxLRbImeC75US5z
         v/dQqtd52uke5mAwjiab/H30Yi5e0Lg1PKsuMiz0p223dX/0aayzEMFP7Y34SxUg4mwS
         xOqI80ljzBKo0dLaGUQYxeJQB9hDboju7bFTPgEfHfdDrMPC+Gob6J4oVgmqFP9EaijM
         oW3I5vFLAdEbnOM2yyrmOeJ2YY71fwFpHGW7B9+HMzo6M/5b9Hgu2gReF7rs+gkc89YS
         A+wd3ODH1D/9iFF+wRiIHzQvnhWlsQU8N3BP3bmm/lmuPNkJE8RZ0qzpXQkjeUQfAJeX
         AFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782136724; x=1782741524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2YVYUXSYaBRv5EuPpzQlID5z4oH0xM0C3Ad7xeAKGU=;
        b=YfBEzc37EXadZHWYDe4R6b6BnMFSbkAchK0elx4cHsDRnMJyI2ISQXkTkRVhgUAd8k
         RGwL6cKUPOhoacOYD86gqAtxx6OUbrZkc9vOOesUqQL2D/rOTUClVp2Mt3SNklUFg4CH
         xWM/XGTWzvqOe6wsIcU1khLVAgwTmXHtyqKX3jdJPaeDhyjQS5ohkjC/c2nBFQOyIYwM
         HKlsb1eZjqZGNxX72hXRl3nGMqwcymA8y4AoFkmIDsePjpDTzAhmyDoILyxG1HxAwaTM
         8eG5Vz232icfydZtBPmOf6PLpyg3RDj97uF0ETgs8oFhuIlEIuL4FNIUMoVmsfeRw9FJ
         HlAA==
X-Gm-Message-State: AOJu0Ywi6DiS4up0wUcQxM6he/BuywZxqitnlQkm3tCBxm72f1553jlx
	Tm0d6TuWKYXlNkfokQFFgs7ilyVcOVud4RH2AhPd0qREf6YjqX/olO7p
X-Gm-Gg: AfdE7cl6G1c3zB0w3M4Zg2ARcHG3x8/ohGhM9WuBIilNq87QC2YUQPL+CXRG6ql7rcI
	JeTBsp1+m4b7sdYdv/x6XF6ujb54fgaB6RtQNylu2uRwCoWd6wmfxNsr/AsBECebLqDno/HVyHe
	vr1LQep01GZVYc+/qOvgIAEbc8zZK3vGcIggk+XhhOguL5ZhvJTsqsqWqZRMJNeSeTo2ANbFzZX
	G6pc7iwGvVzjNjaeQMV93u9QCYmHGyKdhUl6azXPn0o4xbmJaGtCjx3+fdY5dV0pbhCu4XWv1A4
	BLksQBvI88pqk7nNGvA8CHHcr0sQAgwW4Uten2BPs8itJLEMFgYYmfK9o9atYHO/4irfcEJZ/ui
	+R1pSAcuTUnuhgc5eu1O5SHFlDJ4wyPC4UY6Q1JwKSM11M0Am4E1H/9S1etEPUJRdEg/d7c2wOT
	6bnBJJu8HAp6TkgKKdchCjS4kPjRa2rgyxzjj7KpQa0PSF1cPwMBETonlP0qm+XSk=
X-Received: by 2002:a05:6402:5288:b0:68b:ca3c:6bbb with SMTP id 4fb4d7f45d1cf-6973bcaa247mr6412241a12.11.1782136724049;
        Mon, 22 Jun 2026 06:58:44 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6977be64ddasm3156308a12.28.2026.06.22.06.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:58:43 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: david@ixit.cz
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] nfc: llcp: fix OOB reads and integer bugs in TLV parsers
Date: Mon, 22 Jun 2026 18:58:28 +0500
Message-ID: <20260622135828.241486-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <78e283f0-1493-4d72-92fe-e6444458fb91@ixit.cz>
References: <78e283f0-1493-4d72-92fe-e6444458fb91@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301137-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[meatuni001@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D65306B025F

On Sun, Jun 21, 2026 at 09:52 PM David Heidelberg wrote:
> could I ask for the patches rebase against for-next?

Hi David,

Rebased onto nfc/for-next.

v2 is now sent and available here:
https://lore.kernel.org/netdev/20260622131802.239035-1-meatuni001@gmail.com/

Patch 2/2 was dropped because the equivalent fixes for nfc_llcp_recv_snl()
were already merged (ed85d4cbbfaa), so only llcp_commands.c remains.

Thanks,
Muhammad Bilal

