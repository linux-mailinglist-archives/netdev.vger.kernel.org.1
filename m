Return-Path: <netdev+bounces-291823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BcsK6TJFWpEbgcAu9opvQ
	(envelope-from <netdev+bounces-291823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E2905D9A60
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75C953006522
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190863B52FB;
	Tue, 26 May 2026 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="REdH+39Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977138D6BD
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812655; cv=none; b=JijAzJa+jbr717xpLNkr8ov/3i4k/O6T34uX/iDuKZc33043cSAUXAyH7w39S69HSe25LtH1iLOX5C22DLR7O74b9qxaaCyHYBAddYLijjTbZJ5pnMXSym5vHpg3IBpJ38+1R5d393qfUEw5f28YijlXWHusjgCcvCyWs1XdXJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812655; c=relaxed/simple;
	bh=CtEKZlYFL8aDfjvz0FjwX5jq5ZaEQyaskrTeMkjM7JU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=I8gRmFOAfDeqmLFQTGle1W9OKeWq8RMrR3vh9szmnwUbpjoNtE8gnOQaWCaLUW8Ll9R1DBCw00jzbfwsTcoTEh3nkzOVsK/TiN7j3WCnTar9Vd7Pu3KyX0Z7H0sVPhjyqIC0fPLU2wAlD+IcyiuBmpp7hXKlHOTWQI6eF3a8Kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=REdH+39Q; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--bgeffon.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-914f037b7dfso234604485a.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779812652; x=1780417452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+RKfc3SD8L9S7pRMEqhVofQlZ8awVFm1p7D7m0PbHu0=;
        b=REdH+39QFVD39Cv/J/4ScsBeMwAKpeEkiko018sBg8bl9IrIfK21exDAZWAertyNha
         Y1dUpjeuXafHM48hDFRwtKod0yfmpZZvxfcWxDDnFsoRgbGqgffCdosNVL4/xCaxWMMP
         sZjgRybdfaZR2gCZBTuyXVXkGEFUO4oz0O+ZjsP1tXPD+YKU6cz6VTR/6DzP8So5i7sW
         CJx9JIqkmerhATqCIr9m7KZGp8oglHUzCZB4KETmsrpOWmrFOS0tFFfC9iXIWOLF0nYr
         p/f+8iouZM2Cij16xIZX8LXQaam5xENK+ImcxOoMMDaQlMm1+i/8kk8P4ivOaJd5zt7V
         cveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779812652; x=1780417452;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+RKfc3SD8L9S7pRMEqhVofQlZ8awVFm1p7D7m0PbHu0=;
        b=COWaeS1KjuMwAe4S+/IhcCob1RcLSF+01tqrTy5iWIXDn7+JvwaYxevmm22AoOQu6B
         43ZVS34IjXaV7/doMiSWzj4YVmLpyi19alc1FJecoBpgBHDWJHBQwweG5zVDDICwZhqj
         SH2ZUBfddH4RnLVYXwCIy6H/Qf0qIWK89V8U3jHzQS0bhEBfTVPQa34BWubJDGo4g7dX
         +vLJAZ4natr069ur6J+lTozNSNsVWLeHIUdMes3ElTllcC+XlDeOe++ivTjkNHOiQPxG
         g446frLuCIvTRTBDqaFjowKetHmmYPJSj1KWMICHEM4DQSlSwaUX75/H+G5lo72eCGfZ
         5X5Q==
X-Forwarded-Encrypted: i=1; AFNElJ90qUHAuG9gRyPk+9CLFAmgDK4eoo8zWqXJt5d7Fy3fn3d/L7n+YS80inf6L0xEmkHGoljr8/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RllIlAPuEtMGWwZE0l/fhD1CH/rVW5cRznjSK7sj+xMn3ssx
	Nyva2Q2N4W3IFG/HxBML3bUYQCwXPcAIv4BAaS+O/ntPOXoJBHds6feRtao6IcriIRvldR1xBok
	yNr7jvjxqYQ==
X-Received: from qkmy24.prod.google.com ([2002:a05:620a:e18:b0:90f:dbd8:afc0])
 (user=bgeffon job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:2242:10b0:914:babf:9f59
 with SMTP id af79cd13be357-914babfc9a7mr1745744085a.34.1779812652345; Tue, 26
 May 2026 09:24:12 -0700 (PDT)
Date: Tue, 26 May 2026 16:23:39 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260526162338.4134776-2-bgeffon@google.com>
Subject: sctp: COOKIE_ECHO can cause an out-of-bounds read and leak kernel memory
From: Brian Geffon <bgeffon@google.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-291823-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bgeffon@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.845];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E2905D9A60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,
When a listening SCTP server receives a COOKIE_ECHO chunk, sctp_unpack_cook=
ie() is called to reconstruct the association. If HMAC is disabled ("none")=
, the signature check is bypassed, and the server directly processes the ca=
ched peer INIT chunk (peer_init) stored immediately after the cookie layout=
:

    peer_init =3D (struct sctp_init_chunk *)(chunk->subh.cookie_hdr + 1);

To parse the optional parameters embedded in this cached peer INIT chunk, s=
ctp_process_init() uses the sctp_walk_params() macro. This macro blindly tr=
usts the peer_init->chunk_hdr.length value to determine the loop boundary:

    #define sctp_walk_params(pos, chunk)\
    _sctp_walk_params((pos), (chunk), ntohs((chunk)->chunk_hdr.length))

However, the kernel does not validate that peer_init->chunk_hdr.length is a=
ctually within the physical bounds of the received COOKIE_ECHO chunk.

If an attacker injects a forged cookie where peer_init->chunk_hdr.length is=
 inflated (e.g., 65535) while the actual payload is small, the parameter wa=
lk loop will continue out of bounds. If the walk encounters a parameter of =
type SCTP_PARAM_STATE_COOKIE, the switch case inside sctp_process_param() p=
erforms a memory copy directly using the unchecked parameter length:

    case SCTP_PARAM_STATE_COOKIE:
        asoc->peer.cookie_len =3D
            ntohs(param.p->length) - sizeof(struct sctp_paramhdr);
        kfree(asoc->peer.cookie);
        asoc->peer.cookie =3D kmemdup(param.cookie->body, asoc->peer.cookie=
_len, gfp);

If param.p->length is also inflated (e.g., 30000), kmemdup() will attempt t=
o read up to 29,996 bytes from the sk_buff data buffer, which is limited to=
 the actual received packet size. This triggers a KASAN slab-out-of-bounds =
read or can leak adjacent memory on non-KASAN builds. I do have a working r=
eproduction of this that allows an unprivledged user to leak kernel memory,=
 I can share it with the maintainers upon request. Because net.sctp.cookie_=
hmac_alg=3Dnone can be set per-namespace this is fairly easy to reproduce.

The issue was verified on Linux 7.1-rc5. KASAN detected the following slab-=
out-of-bounds read:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-out-of-bounds in kmemdup_noprof+0x3b/0x50
Read of size 29996 at addr ffff88810fa76900 by task repro/666
CPU: 11 UID: 0 PID: 666 Comm: repro Not tainted 7.1.0-rc5-virtme #1 PREEMPT=
(lazy)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1=
.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0x4d/0x70
 print_report+0x153/0x4c6
 ? kmemdup_noprof+0x3b/0x50
 ? sctp_process_init+0x11f2/0x2bc0
 kasan_report+0xda/0x110
 ? kmemdup_noprof+0x3b/0x50
 kasan_check_range+0x125/0x200
 __asan_memcpy+0x23/0x60
 kmemdup_noprof+0x3b/0x50
 sctp_process_init+0x11f2/0x2bc0
 ? __pfx_sctp_process_init+0x10/0x10
 ? printk+0x9e/0xc0
 ? __pfx_printk+0x10/0x10
 ? sctp_assoc_add_peer+0x1ff/0xd20
 ? sctp_cmp_addr_exact+0x3b/0xb0
 ? sctp_assoc_add_peer+0x2a0/0xd20
 sctp_sf_do_5_1D_ce+0x585/0x1700
...

