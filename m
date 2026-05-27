Return-Path: <netdev+bounces-292476-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LFQI0Z/F2phHAgAu9opvQ
	(envelope-from <netdev+bounces-292476-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:33:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B085EAF09
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 01:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89BA7301D33B
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B6D37B415;
	Wed, 27 May 2026 23:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPQiM+JQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597531E850;
	Wed, 27 May 2026 23:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924803; cv=none; b=ESe8Zu2mhkIUaYgeoBgMksfJU1ke9L7pNb0ZzkNULKy/X2qqn9IN59HqvlqdtanyCMh3H3JfJPVrszcRHJtyER0YhZfL2uc5YDgan/eH0whtlbnbvEGymaJ9+oZtcP4+EgMgHypJ8tETkRelevA8M1WqMEf7AAjhSKK19fWghdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924803; c=relaxed/simple;
	bh=6PUm1E3LDoZ+68223PzWURdi0dxg9skuim3wzk3fRAc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g756RLyvQoqzf1luXTZFpWK+m3/CeF1TmlN1Av1OQiJHft5s42MlNXMxNaINzuosWx/DIBuMrCLtXScHdaizD0wvO7STi55fd7KN2OZy0iih3imibNpJ+5MLpP/lk1VyNcwsa/ENeEodDVe7nGGIM85b8uWzojfdreINJUs/CSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPQiM+JQ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789811F000E9;
	Wed, 27 May 2026 23:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779924801;
	bh=yqhH6oAjdYCLvVyb+keGbP9l49zTVX5ArxLru3gp0Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cPQiM+JQLxHw4K/XOKiuswzV3nVV1yWoQRRuXEqr/uJs51wRQYQV3QQJjgljkd9lc
	 e67wWxKJrPbk5HJVSnpKSwnlzJWJOGyw3kNTcqQ1NqgMH1hR7XNUAILEbiI9ZD+QDP
	 k9f140JN4xpypxhin28fMa5kNIlR0KEkzbSqHrc6lr0FlFHttaHT0uwN+eHHtzbu5L
	 tTc6IW5dJf7Fgr5V8TA7STdmQ/jQ/kYqXHZBNuu8nQ3pj1hePZiovM5Ynl+kbEaYk3
	 n3fXyLNVfO9LJl/TL6so++M+Vm7ahbmMPfKpsoe0iGBLQ/6jKVhhwByiY0DmjLKiuU
	 rDZW6PMpo5pKg==
Date: Wed, 27 May 2026 16:33:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?UHLDqW5vbT8=?= Ahmed <ahmedabdelmoumen05@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel Borkmann
 <daniel@iogearbox.net>, David Wei <dw@davidwei.uk>
Subject: Re: Linux: DMA-after-unmap race in ZCRX via
 netif_rxq_cleanup_unlease() ordering inversion (netkit + page_pool)
Message-ID: <20260527163320.407b4af1@kernel.org>
In-Reply-To: <CAN+TWHTGkGZu4vdbkMY8F-EDe3m8ScBctW-fdtfcpGbj192SyA@mail.gmail.com>
References: <CAN+TWHTGkGZu4vdbkMY8F-EDe3m8ScBctW-fdtfcpGbj192SyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292476-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E2B085EAF09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dropping security lists, security lists are for private discussions,
it's utterly pointless to CC both them and LKML. Not to mention
that this bug only exists in -rc kernels.

Adding relevant developers. Moving security@ to Bcc

On Wed, 27 May 2026 23:53:45 +0100 Pr=C3=A9nom? Ahmed wrote:
> Hello,
>=20
> I would like to report a source-proven teardown ordering bug in the Linux
> kernel that can lead to a DMA-after-unmap race condition involving ZCRX
> (io_uring zero-copy receive), page_pool, and netkit queue leasing.
>=20
> ***Reporter:** Ahmed Abdelmoemen **Discovery Date:** 2026-05-26 **Kernel
> Version:** Linux 7.1.0-rc3*
>=20
> Executive Summary
>=20
> *A logic error in `netif_rxq_cleanup_unlease()` causes DMA mappings for t=
he
> ZCRX memory provider to be revoked **before** the physical NIC RX queue is
> stopped. This creates a race window during netkit queue lease teardown
> where the physical device's NAPI can consume stale `net_iov` entries from
> the page_pool alloc cache containing `dma_addr =3D 0`.*
>=20
> The ordering inversion is fully proven at the source level. However, I ha=
ve
> **not** performed runtime verification, so actual memory corruption or
> successful DMA to address 0 has **not** been proven =E2=80=94 it remains =
hardware
> and driver dependent.
>=20
> The bug is reachable with `CAP_NET_ADMIN` (common in container
> environments) when using netkit with ZCRX.
>=20
> Root Cause
>=20
> In `net/core/netdev_rx_queue.c:347-348`:
>=20
> ```c __netif_mp_uninstall_rxq(virt_rxq, p); // DMA unmap + dma_addr=3D0
> __netif_mp_close_rxq(...); // queue stop + NAPI disable (TOO LATE)
>=20
> This inverts the correct ordering used in normal device unregistration and
> io_uring close paths (stop first, then unmap).
> Impact
>=20
>    - *Potential:* NIC DMA write to physical address 0 (or stale mappings
>    with lazy IOMMU) leading to memory corruption.
>    - *Requirements:* CAP_NET_ADMIN + netkit queue leasing + ZCRX installed
>    on the leased queue.
>    - *Current Status:* No runtime PoC or crash reproduction yet. The race
>    window exists in theory but its practical exploitability needs confirm=
ation.
>=20
> I am attaching the full detailed analysis.
> Proposed Fix[image: image.png]
>=20
> I am happy to provide more details or assist with testing.

