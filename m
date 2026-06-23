Return-Path: <netdev+bounces-301452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BT8zB57IOmpmGwgAu9opvQ
	(envelope-from <netdev+bounces-301452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBDB6B9489
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:55:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f9e5Dm89;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E506D300516A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500FC390999;
	Tue, 23 Jun 2026 17:53:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF339021B
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:53:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237222; cv=pass; b=lpyFEx1WqhYgMMNg8nAjhg/iicQgSxPfz/H5Ukydri4YGjRWzrLFx/ijl+FioIC47I5KyQZGIHDAt8Yq4xA60uo5JeJwb0/UUf0rJU/2DCRegaklk4doNQQQJBlkBCJZIxiTxT7/tPTP6xyNrtunIvu9sZVbOwlYcgqPO8kRatE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237222; c=relaxed/simple;
	bh=p/MK9BZqCNWBzxLlwJR1m59YiSPFZbgMXtLKLEmv42A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mD8wxGyq7tKvp9Q977dl8N8pYdTZb/3opdO7rkI9wGhpPRHmwv1Bm2vpq4A9fUaczfBVyjikYoGGo0nvRN6uF1LykjrKc/9git9ElVF0KPLkNsst3OogK74bHXTfyhS/JsE0lk61+RXN8V3GDbJTaazWcJHcO6WWIkUV/SsIWQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9e5Dm89; arc=pass smtp.client-ip=209.85.222.176
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-915c48e6ae2so3156685a.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782237220; cv=none;
        d=google.com; s=arc-20240605;
        b=MoWNbhydQZv8yO4Grz+XmqTvS6Bd7r/dFN/gJ4ms0yTiLHlDSRMQhKanMSiWr5K20I
         8/eSTqPdMHU2QZ077CgP2yB+GITKs7H+ODVu3NOj5rr+1U5lQRnmF4FImLcZU16qmz0a
         kDG2vTbomq81Ye7ZBSVkcN+mEQCeOB6HmPv2N+7TSNXWzsQOi9Qb9IVZryPxw8N2i3fP
         CcK3tUurr1rW3EGItXK5iizk80OdgZZFItjwB4ONn1zH+b4tlriZT51AQT88BwpMvjn2
         7AnnqJfOCbHeBybXXoxwfYfMjJz7o+kymGX8waLT0+rU+4AiMyk8C/shnl1cBgwhoxAO
         MPwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=p/MK9BZqCNWBzxLlwJR1m59YiSPFZbgMXtLKLEmv42A=;
        fh=Dx5HQ8JMztK6BHJhryHCm/xcD1Issfo3IiuqWxpN3y8=;
        b=TIfDkruPTBcc+M8dDEch3voCXW7xUPymFhDIDQtw+SqrWbIdkk7QCs1AOAVCRj8o7n
         Yhw7rGr28FXAMLSzkh3HZ5oVKPrOQL2EQ3EpndB5ifYRH8LFSnV+71Q2KHUzMI/g8szi
         PCEvd2ltKVbGBW6/EIkU8VC+w6vo7h7yB3nl+p2upcioQ/01d/Hcd8uYgvZLl4wzlBq7
         8lBH9L8O3gBvf2nm33HZkEBye/mC/nb04VoUIr9pNX5jPN3LskX98/CO4+aOIVIV7arp
         gaUmP5SVaZFLXM4OFKf0SmWBxe4hdgGmZUtD2R3LmC25Xlsbk8hSoAjXYVPxm0iFkehT
         Pxdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237220; x=1782842020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/MK9BZqCNWBzxLlwJR1m59YiSPFZbgMXtLKLEmv42A=;
        b=f9e5Dm89C7fPVUbj2iz/xOdvJ+Y0H2ps7al1Mcsnbnl/s8zcHEOdo6rAIIsVBGTyjf
         KFD24xv/Gn9nBZPYcRJPQozIl06FtxWtk5jgDiFLoVhPZs0hrlCxLMSAVJX7p3zIhwYj
         QT7ukcRxzVhbvWE3TBU1SJ06EA9Qai3CZqkl5RQKhr+99gm/WdOueSDGkGawGGeDoDud
         wtgL+fRPwYic+hjWg5w9/EOM/r5mULHp8B6GPz1+aIa+0HPKht6VcXsI584Djj0xbt3b
         7sZ1a41Q07DXQLmVQ+/y9PSUETUy7UQk1o3BDww/4zTe7ysG1liCogxguqNC/I55JXEO
         2hiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237220; x=1782842020;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/MK9BZqCNWBzxLlwJR1m59YiSPFZbgMXtLKLEmv42A=;
        b=IlY/5GA4aZw+rSI/QngEeVaVhX25SaDQ5YJQ/Ygc6sgR7CfTGVr6TW/Wo6zeAex1vi
         qbhpYykJzMP+/u5vD2pzJF71tMdbcuu1FbUfV7UBnVduvZ5Py0qQTC//vN+zG42G2wTm
         EhSycPIifTifnKNsNV/IvGhHfZgA6zfrKOTH986/J24CoNRo4MFiPJzpC3othlcdG0Ob
         wGoZuQjHPww6jLZFv9qoahUF45igLQBkNJHVM+B470Xvz0rH2t64GFDa9BhvWinwIPrY
         pXHb0ilVy6SqaoxBEjCeA6Lb9YPxt1F/pBL0evwYtYuzHejubiTUPOI1flq2CiM/lwYx
         MnKA==
X-Forwarded-Encrypted: i=1; AFNElJ9QzVgxI7GaiqRQatTtp9dbSY3NDwNhRoih8OhYHvUBXgt7zCWyOpiRXco6xyf1W8hpeIx9AVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbvF9DXZnn2wY41XyGG+/x3k0gkFGSdwwW6d9UuHu2rWhnjGq
	yL21gAzHIN9xTjsMfQEVTAEVKaA2d3qYPUKBJ5jMbKcBRcTokispKrFg1TEZc3vW8iXNQ/taLyz
	9ok7hRR3PNwRNHJ2bpvaByr542h7RTBI=
X-Gm-Gg: AfdE7clkcgJ2UyRqe98GXR3cTdQ5P4KQuyQttazkLxC0QVBiGl98G5KydWTTRTyAAvM
	Hi8wUs+vrH7RUWgQChkIXcQIE5O0LX5QDrUbegB/IARcuOpEbju3TQ/U5ZVTOtlkfqKeGFgRldH
	isl+DM+FyNaGLeNS6yCD4LWwMxG11n4/HxvI+yNqx/iIJYPGkaSkOps8tl6/t5QUXXiHHzfVzZ1
	eXDADeMQeGoGmgLzFBdVS3YxmpPkkOTNFJi65spwOhte8vktxsjXyOpa7lmfu6SWO1RDLsRfQcr
	LcgYnN5GG5wBHchCISIwXVXhi+k=
X-Received: by 2002:a05:620a:19a6:b0:916:1806:302d with SMTP id
 af79cd13be357-927851e25c8mr3873485a.58.1782237219877; Tue, 23 Jun 2026
 10:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nils Juenemann <nils.juenemann@gmail.com>
Date: Tue, 23 Jun 2026 19:53:28 +0200
X-Gm-Features: AVVi8CfAn-qp1mc-0qEUgFBQ7TsNUtQFVuDhKiTwTNhcy049jP0LjuFQuj8dYAE
Message-ID: <CAMPsyauZ+jzG9AysO0FWv6ZY0kvCUpjX_U7o=oOjCuOQ87BCgg@mail.gmail.com>
Subject: Re: [PATCH v14 0/9] tls: Add TLS 1.3 hardware offload support
To: rjethwani@purestorage.com, netdev@vger.kernel.org
Cc: borisp@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	john.fastabend@gmail.com, kuba@kernel.org, leon@kernel.org, mbloch@nvidia.com, 
	saeedm@nvidia.com, sd@queasysnail.net, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FAKE_REPLY(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:rjethwani@purestorage.com,m:netdev@vger.kernel.org,m:borisp@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:kuba@kernel.org,m:leon@kernel.org,m:mbloch@nvidia.com,m:saeedm@nvidia.com,m:sd@queasysnail.net,m:tariqt@nvidia.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,davemloft.net,google.com,gmail.com,kernel.org,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nilsjuenemann@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DBDB6B9489

Hi Rishikesh, all,

we have been testing the v14 TLS 1.3 HW offload series on a ConnectX-6
DX and hit a sendfile() final-record loss on the device TX path. We
reduced it to a self-contained C reproducer and characterized it;
reporting it here with the analysis and a question on where a fix belongs.

Setup:

NIC: ConnectX-6 DX (crypto enabled), FW 22.47.1026, SR-IOV VF,
TX offload only

Kernel: net-next + this v14 series

TLS 1.3, AES-128-GCM, kTLS installed via setsockopt(TLS_TX) on the
sending side with fixed test crypto material and no handshake, like
tools/testing/selftests/net/tls

a server sends a file with the raw sendfile(2) syscall; a client on
another host reads the decrypted stream and counts the bytes

Trigger: sendfile(2) with a count larger than the bytes remaining in
the file (count > EOF). This is what a generic copy loop / Go's
net.TCPConn.ReadFrom passes for a file of unknown length (~2 GiB). The
kernel sends up to EOF, but the connection's final TLS record then
appears not to be put on the wire unless a subsequent write flushes it.
An abrupt close() appears to drop it, and the peer receives the whole
body except the last record's bytes.

Reproducer results (two hosts over the ConnectX - a loopback/same-host
connection stays on TLS_SW and does not show it). Same file, 226965
bytes (= 13*16384 + 13973):

TLS_HW count>EOF close() -> 212992 short
TLS_HW count>EOF close(), no zerocopy -> 212992 same
TLS_HW count==exact close() -> 226965 full
TLS_HW count>EOF close_notify, then close() -> 226965 full
TLS_SW count>EOF close(), hw-tx-offload off -> 226965 full

So it is specific to the device-offload TX path: the final record of a
count > EOF sendfile() appears not to be finalized/flushed at EOF, only
by a following write. A bounded count, a trailing write (close_notify),
or software kTLS all avoid it. TLS_TX_ZEROCOPY_RO makes no difference.
We are currently using the exact-count workaround in a preview environment.

We may be misreading the code, so this is only a pointer: with
count > EOF tls_push_data() fills the last record without reaching the
size==0 case; on the device path tls_device_record_close() for that
pending record appears to run only on the next push, and an abrupt
teardown appears to discard it. The software path seems to flush
pending TX records on close (tls_sw_release_resources_tx), which would
explain why it is unaffected.

Reproducer:
https://gist.github.com/totallyunknown/a8f0ad3c54e40befde2f5a8d360fa6be

It installs kTLS with fixed test crypto material via
setsockopt(TLS_TX/TLS_RX), sends a file using the raw sendfile(2)
syscall, and compares count > EOF against exact-count and close_notify.
The v14 selftest (patch 9/9) sends via send() only and ends cleanly, so
it misses this; a sendfile() + count > EOF case reproduces it
deterministically for us.

Question: should the device offload finalize and flush the connection's
final record at EOF / on close, the way software kTLS does, or is a
trailing write required by contract? And should a fix live in net/tls
(device record close on the final partial record / the close path) or
on the mlx5 side?

Thanks,
Nils Juenemann

