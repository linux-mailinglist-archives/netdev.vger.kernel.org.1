Return-Path: <netdev+bounces-273326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBLgOR3nymloBAYAu9opvQ
	(envelope-from <netdev+bounces-273326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:11:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B473614DD
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 23:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18449300CBEE
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 21:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B8439FCC8;
	Mon, 30 Mar 2026 21:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKSgzPkU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8F4126C03
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905096; cv=none; b=gxyQt/tSpFlyyWYA5mDZ1T4e4wOeS0fBL/Z6zi21kRXOouKmh3Wa+JniiXZDHWkEyKVCUjgiDDtPGIBsct0UTCmhkhyMenZVOHLqnTj3L8xDwge0RwvendqOPubDQ0NN5FkdDy02aebKAI7vVZrGQV3eYi+EGHPsNP1ONnebkIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905096; c=relaxed/simple;
	bh=WuW4P7HIvCgTqUS/kR2NzM6J7queKF9TF23AviiY0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nrix3Jrs5vmHv7syGOTYO2iqzDQx6LPCyLAg6zK4m2Y4MGBw0s4eTrQbIsMxk58BHzXvJOEhpOfY7c6Z/0TgNQQNAPdHegBHP7+kn+PDww4Mqw6m7+5RbR0TMfAMLI1Oo8sh1jio/cF9iTqOpD/ryix21Nva5WXw+umtMlcNqxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKSgzPkU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4873ce69ba9so14933385e9.2
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905094; x=1775509894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=HKSgzPkUR6Ga3XxtxRJ6sEmp/3MMmp6aTkjsQEWk0y4gALZwmd9xr3krRCXrMwXxse
         SAnra+o7+prT9bp/EEZSOqV3bMZNMr7qJfnAWtEkomsNbEnhZibtQ3Ukg6a/9JkvITAb
         NqYe+4o9dzvAlIg4W+dHyclzLtflLYFMRTrJNTNiVoEVJbhFq+a6FIIl0nKUGPp3oLlr
         quNk2tN+EMK3Al/+7Ck9WlZypk3bnMmIpaMFiahlCs7jgfDQVG4KA6BaRg1IzabcSQ4y
         6poTSoSeRzBSj+GJnlInp+DuSbhxKAifG+KfgnkgA8Cf4cEZVz/J2RT1Zgj87edQCu+o
         2r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905094; x=1775509894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=XZ8D+JQUryG8CoTmJPEkiS62+SRjAdBViyhglS6PmfCJ5zUhViEZOfRBo0+EYacJ06
         RxaC7ibPGu6ou7LdPNTCRQ8xcaUZYqNfOzx53PNEgHnZnm4ydhQrymVSZhtGwn+VajeT
         fmXFZRFieiI3e9X6V2EuwqO5XL3g1cBKumHSRKlhyHRCzo7as30MYg32tJO4dv5qd+Cj
         Av5eXphZkDcixkjUbrhIo1fix2n6b/jHAUNQeyeepXG42HDJEmzabTBmssoiNQijyhvl
         34zPLMtp5OcOhAQvrlSGMnS14XFPgl2OX87V3bYaYgLaaV2nUGPZZfoCAIuPLP1xNtNA
         byYA==
X-Forwarded-Encrypted: i=1; AJvYcCX8FHtmHC5/A72E2TbkeTyWwG1XsEEHu6qJ54G5eES+tcM59KwiUGfQHjbv964zhxTP9jVzZfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFbBvp2ySaqfcvdrd3tv2UntjS+jhXxM5NoUPgIB8c+QK4iZKb
	wPlqTI0fY4woTUVrBX3+PxY5vRUiojBU8GZ4vm3laLiYunzYgBP/FN9X
X-Gm-Gg: ATEYQzxJQNff1PArFR8x551dF7w4Dv+iRAbYMV/INbrYT2vRz25U08qn2tAOArbA+d/
	vT0At0xgXf/HY+xcMBEcd2y0ODEWnSCWapgJ1qoR37Bx1hIhlmH+RG/u3GKK9b7VisWM04tQ/eo
	hHEHgVewXtHY96hXZ9ruUpqvHsWxzkzwmFXJzR+KwiRq3r6P/wmvVgtk8xsFVt/DVfSBndvcQ+Z
	DZAp32O8Va64IQ7BvYhmX6Bmbc/c4mdyinTHjGbNn05sxIZggLCgpKz3uDR5oPF/X1xyvE9/mw/
	zyszx1ILSDTpSXb4b9GPwOn9mKKlZGfSNJXRAwn3j4v3WiddWm+j+0U4HAFbaUAfH71G+w7rSdJ
	/hfNmA8geUmhe2RQ2/hudawPT63b2fiBko+jYF5kJmTJRIHdFe1oJtNAVn+sELIcECU5dQB8a3U
	EXE65T6TLE4ScexSwgYWp3jn4CAA6n4dxwt9qwrwqzlWRPvwyfhVT8DLJPpFKE
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48727efacb3mr225543165e9.20.1774905093642;
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad8d58fsm1787525e9.24.2026.03.30.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:11:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] iov: Bypass usercopy hardening for
 copy_to_iter()
Message-ID: <20260330221132.1e1b1387@pumpkin>
In-Reply-To: <20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
	<20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273326-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 73B473614DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 10:36:30 -0400
Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected kernel memory regions (slab,
> stack, and non-text), which is meaningful when data crosses
> the user/kernel boundary but adds no value when both source
> and destination are kernel addresses.

I thought the purpose was to avoid accidental overwrites when
the allocated buffer was the wrong size.
This is pretty much likely to affect user copies as kernel ones.

OTOH the overhead for some socket paths is really horrid.
IIRC sendmsg/recvmsg does copies where the length depends on
whether it is a 64bit or compat system call.
These go through the full horrors of user copy hardening even
thought there is no way they can ever fail.
That is the 'control pane' copies - well before you get to
any actual data.

	David


