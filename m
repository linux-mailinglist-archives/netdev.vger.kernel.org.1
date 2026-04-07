Return-Path: <netdev+bounces-276114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNRTCmE/1Wk73gcAu9opvQ
	(envelope-from <netdev+bounces-276114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B4B3B25D7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 19:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CD923032DE7
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 17:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8D11F4CB3;
	Tue,  7 Apr 2026 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RBp5aW1w"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882601F3B87;
	Tue,  7 Apr 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583051; cv=none; b=m1+/WOYPbcHp1roR4LTQhtxT8f7pZ4AjUlh7Yi1huQFgNjPsrEPb7QsBEEGCUKxDFJuSh6thFeOLvREshWbMswIkhLl/T6w2E+aPqIBpU+HmFagxrcqYgy/vge8QNrCbolHOBdk4agNcOc+Cw1PtZDkGaL3x0AJU3Z5HGET8cHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583051; c=relaxed/simple;
	bh=1NCS9gYTZrgbYxx9Fl3+Y5Fmo9ikKC3KhdLHIGn2jVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmDX2xiw3pa0YmPcuJMxfky7W3R1so+wSDxVSvJq4TQsvJDkf4M9FwRqZFb1fREXFYuhOnUQJXPaYlkknx9V0UFtpoUVWvXqUNpySEALNBlof7d3cGip97fIIZWWFLY4o7aRDcWmmjaTKH5TIjVhRIVxKq1oEnbYbP5MhAttTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RBp5aW1w; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fqtWn6QWZzB14f;
	Tue,  7 Apr 2026 19:30:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775583046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fJ7zM5V7ZzJ0suotcdnEmX2tSdOwa9vrNHy5SWQdhjc=;
	b=RBp5aW1wHytr1Sq6QjueW2EIHrWjuQ5kE2VwYua1H03KM3S6Dvm2z/rjdhE/PE4lqKxeo+
	BldZfmDuIwCMfvYy6y4Z8b+QKkp4Swyim5WoxcBxr3pJiU/UkYYhuynbphrFtUK4yhcgYg
	Yx87bpj8z/vmCK1ds/8wpzduuuAS1l0mgGps68mkGCDQj6jfxtzm/RK5jDVjIhYWSQsRoU
	/8NLg7YkD/S2MGOPreOZGoFuY4jXbfVuAH28MvZAY8RFIW6XXL2a6dMZF7fqMd3mEthm1q
	Ub10DTRIkJ7lXGdNqwjcfppyDAwr0nKemVMU7vbu2C3OOlXmjLoJg6PC/Exhrg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
To: horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org
Subject: Re: [PATCH] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Wed,  8 Apr 2026 01:30:34 +0800
Message-ID: <20260407173034.107268-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260407165007.GB469338@kernel.org>
References: <20260407165007.GB469338@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 6c81e7fba9t8u9d8zwe568b4q54mh9i7
X-MBO-RS-ID: 710b1589b8f0d540d6f
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276114-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mailbox.org:dkim,mailbox.org:mid]
X-Rspamd-Queue-Id: B5B4B3B25D7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026, Simon Horman wrote:
> Sorry for not noticing this earlier, but AI generated review flags
> that while this change looks correct, it's not clear how it relates
> to the sysbot report: IOW, how is it that bytes with TTY error flags
> may be uninitialized?

Thanks for the question, and for the earlier review.

The TTY receive_buf() contract is that for positions where fp[i] != 0
(error flag set), the caller must discard cp[i] -- the TTY driver does
not guarantee a meaningful value there.  In syzbot's fuzzing harness
(pty/ldisc injection), the fuzzer allocates a tty_buffer, sets error
flags on certain byte positions, but leaves the corresponding entries in
the char buffer uninitialized.  KMSAN then detects that sixpack_decode()
reads those uninitialized bytes.

slip_receive_buf() and mkiss_receive_buf() already handle this correctly
by advancing their char pointer past error-flagged bytes before calling
their decode functions.  sixpack_receive_buf() had the same structure
but cp was never advanced, so the full original buffer -- including the
uninit error-flagged positions -- was forwarded to sixpack_decode().

I have also dropped the Suggested-by tag per your note, and submitted
a v2 with the commit message expanded to explain the uninit-value
connection more clearly.

Thanks,
Mashiro Chen

