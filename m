Return-Path: <netdev+bounces-298019-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkYmK3x5KmpLqQMAu9opvQ
	(envelope-from <netdev+bounces-298019-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2670236
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:01:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Z79e2KId;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298019-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298019-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E29A3228F39
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB53BA236;
	Thu, 11 Jun 2026 08:56:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C4838D404
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:56:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168173; cv=none; b=CrbIvG7iV3Ir9Zg/uffhXpAgOPX5ObUE+F6m9/nJcat8qrNzG7xDksAYEbvpgoKlk/ebLZ6vtKSRVC0yALOcrlMODsJ0RMa73MNUYx5/1LDLZcWcEkQt9ZKPHn2TZFpnD3eA30nMi70pgoAPxZc4aVw5g4QddxfSHF3RyUG0GNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168173; c=relaxed/simple;
	bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtr61InyXzDZZyWowIqFoW3sh594vXFpK9i4xsaCAmhBIQ7UoYFCULznRTBUcbPFhILCYXMr7UwdPDsyvs0T0KuVko72Zh4T39AB4Sfl1EWnImhuceB3iOsAhabYvrfFoYYfE1CMGbt2GfgR9LU7pLQH3S9htF6Zg0aFlgaBKyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z79e2KId; arc=none smtp.client-ip=209.85.214.172
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf125989f2so58036425ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168172; x=1781772972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
        b=Z79e2KIdtHO0C9/IN1jygORWGSYEVZE2THAwP0AW46P2OXtH1lFywjAkJ5xFGiBurp
         G33ng0i7Ahy3zJ2DN+tS9iO2kx+Hm25YTlWOnA9GqmTuxoUEa03yDDHkhVsxX7/lyTKc
         g6niZ9KGgQJLlS5EJS2s6VJ11ZW6Q6Ii4Ff6JI6YsstFeXmggc6dYafUr6k45NtAM1vx
         mWw3vNvRuS4/tsrISMoL7AZqNWV4QRo5aS4itPpcxcq0RVE1KSjxXWgnECogN/NvThrJ
         stwFmJVEJtxiY8op+96jd+wPdA5/LdAlgNAGouqwISDEg4j/UqEbdcN2pUoNWJ8MBH3P
         I+Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168172; x=1781772972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ekKXpimJWy22uIkS5AsFE3xQblvl2h8os3O06ForToQ=;
        b=Wo7PQ27LhrbT3YFZmL3w/5B+Jx5Uv0jub7YLamWDG1FHhi0Q76nmwCCMRPNejMJaul
         Lo4YmhMAI2pmXYKRa33/3dnOcVYZEg2V2vJy88e4nSJ1RCHa1To3f4Oap41U0OqzEM6c
         95Vu/8l+gaOJQ9FGU9mVyKrND24fC39ne7V/X850PiKbIFxTr9qyzD8KHtCyYKthmbTD
         5FxY4lLFyGJbuNDODqyoO6sUTott5nmVbRChOlWSRp1W3jPwlz3Q0jv2/wklniCJEAMM
         x4f6kKz3KH+JjQKgZBVET6iIrcS6Cxporcd/CXu0Z0Wg4zk6FbQyNET2ujiCa29ioLSA
         16ZA==
X-Gm-Message-State: AOJu0Yy98TmY5hJ4ccQcp58j6iuQ2hG56O6tUBTsHiL7E8knJXX5KPhm
	Vn1HpV/scaBIXPKD1ND13ewVZaPZfS7BillyYwd/5kkSdBI09bTAOvQ=
X-Gm-Gg: Acq92OEnTBki8O63p80F5RNNcqvl3PKAHuU4+bxoLS3UiJ2wVesRVtGsY/NEQrd6Px8
	QcFHhJtEj+lklmszJ2svWZr6nPhDpDxv1FZpm4RCoJKtZEMYVY7FNffbmHoHUnjbT9/OU7zx0eU
	p64NzIHOooIgQpe7zX5wHe+Cu61xHmywXXXji983fcNv6r0Bw7KGRSsK9VdlJTsRi98IfNoHBMd
	+2Hp/1Bx/RTbugeZnF3x3u5vPInNCQHUf6D9/Xklwt0iRjYKl2MUG4guo/H3QI3EaKNI2ffSfpR
	C+E66+qk5F/GRc+En5WiPrfwS/eaVCNgXudUUDVxGzPtLfBYlXl/92Q1Y7ucXrGv2uPDkgdBKdK
	se7/8QqKwHfF2nCrdohskUpthy38RKQnTRvsLAhtWs6n8OkdCgstCBOTcaECGPN9TBJC2qADvp1
	llpBC6s6FgWkgFxM4o05K49J9Z4qayQn0ToBeLpDpyy9N12/kTcDgBhGErHBPcDwqu+0eWNSUtj
	BHatg==
X-Received: by 2002:a17:903:f8c:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c2f2a780bamr21367275ad.31.1781168171973;
        Thu, 11 Jun 2026 01:56:11 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fab9sm271803255ad.79.2026.06.11.01.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:56:10 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: sgarzare@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 08:56:18 +0000
Message-ID: <20260611085618.626923-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aipzlgTKa1OuKrwg@sgarzare-redhat>
References: <aipzlgTKa1OuKrwg@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:sgarzare@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298019-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B7A2670236

On Thu, Jun 11, 2026 at 10:37:30AM +0200, Stefano Garzarella wrote:
> Thanks for this, what about fixing also hyperv_transport ?

nice spotting, hyperv_transport.c:326 has the same open-coded check.
Will include it in v2 of this patch.

Raf

