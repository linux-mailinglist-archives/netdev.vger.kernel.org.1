Return-Path: <netdev+bounces-301246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hL9/C9T0OWqBzQcAu9opvQ
	(envelope-from <netdev+bounces-301246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:52:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769D6B39D4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 04:52:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="O/DR/nIg";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301246-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301246-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11157301D307
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 02:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8329C386C25;
	Tue, 23 Jun 2026 02:52:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68234AB01
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 02:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782183121; cv=none; b=Ej85a9WC7LR2zJBfenrQ/oH4sHvppxtV7KJDbPfvVlc/BGmghPYeS6tGNzDPbI9BCtUBWOhHzAHz7qn+a1ziUSXl/EXIIx04zrHXDco3Hq05dxsfe4QeweSWFnnpajo8lo09Yri+iDu09lGsyWudfpQTdje3pWFgx8Os312jeGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782183121; c=relaxed/simple;
	bh=p+nffAW408DMeJGJh50kWk8zhQg2b3tHyUIep+5bpYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEBt8KVMugA0OB7ELHTjsagxg9+pdVPYi9QEvNbDte8/t+ohD9+dF+u6484sG0pLo9oyxogJjToYjv+kw79af6s+q44Z2eyXxamPBgBHNHIuhiMS6YmCl9EBVG/aunUU3Gx0pK6K384kR1rriAFRixcwLBVyDynZmvRNeYLLy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/DR/nIg; arc=none smtp.client-ip=209.85.214.181
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c7c684353dso3479135ad.2
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782183119; x=1782787919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KV2chNMnw+kmRFfisbGqimiQM5mDTuIEZMht/aRpHIc=;
        b=O/DR/nIgi7j9J6O+k0kOUIYS6iTDPzoPM0oac4ANwIJvAhSBE8MDbijgo4KrNuGkl3
         YZ9njHxQ2FjFEJxWkMT29p3GPI1RCFDW8IcuEyf2TyhyAX09h3+DNRRiVEwUQ6/5CqO4
         5r5z4QXcEdRedSfd05g2Y1F2MgUnCsTsBmYPfOENKvIrBgbzUOiXY9VhDqqMvuYuCQrQ
         t0gi48TCtJAUSiEjHZh3mAZMbiqiSEUO/PKKDE+cfYDWvWopfYM3PFOQTxffD8udCDiG
         OWQ/xVRktN+AqltlgENRhIn8UqCYTq9MJi9R/nSsuCQiqtLgR7MiKUibALg9xii1KwQ2
         B01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782183119; x=1782787919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV2chNMnw+kmRFfisbGqimiQM5mDTuIEZMht/aRpHIc=;
        b=AF4G4qPXqJyddKQSW2h2zlcS7GXwKiKaVw1OTG6LXHCcY3ODh3CeZxTSpkI+Kas3NA
         QInHi12anuBJTGenAFLFyh1Tr6FKY+q6B8cziLhxITRtV6Mh7UYGAqaszSpaX/15Rbmh
         iQZ6BKQEmaABWEJNosuwAroysiBYEsLp7BvcsU0ENqKjrq9eVZxfHw0i1tx78JUc2laP
         vghEF9DloCHuWPxGKeRHM1LQ60DVzTnGz19hwTyIrVFQkClP2MaJ9t3uZ5GoH6cgqtec
         qz5uiObQsJ6ooXF+xBsUlSa59KUT/IXOqN5AAPUFu2aYQ/sog4vU4JVpz5wIoxQJEQ17
         OafQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpm5en0mZANghQ+/H3IqzPO7RUmh5kzRjHaLl8U7pp528cKenBBayfBn7ti2yozR9qPsieYGgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7AwcpXxb86Fh+sn/B6MKCpL8Sek09xn3ZQ+JGm0cTftNn9nYo
	sjiWIl6koM33SB/8LjK3yO+u2gTLacI0QnW6pkxHVx6LcdINFAciE4O4
X-Gm-Gg: AfdE7cmXL2/5711IIbp3BhjOZ9+HXRoh9AL7ObRRutdvAge6uxrf9IDWrgXRHVHlJi+
	NroP6qdl4Bs7vF7n4i+6BGUa3/IX6tGfsuqF68k3MwaGaq7+vRGQFw1bJtYHXscY8LXcGO9kBEJ
	4o6kdhxtLdaQ1F8XM49bJ9AMVdL1RnMYevQ9/HwqDae6lcQ5iw3Y6ZCMSszOgcc5zXVz7G1GOYy
	3uDDOTcUPIPV9so5lLlTGRfOl/Rh55U+uHrSwozevwG82fLcVW6XRH5vBsWyRHwb3Ors2oKWNFz
	C40tDFLJk3xnKNFSaw1a2NFkcaBoDCVe8YwMu8+u36vDh9cvcJBCTw1evbu5yxfxQVZzvzyd3yD
	k2/Ffp6nqmF0QWZvAYRaHphXeMd/lT75lcMf+7+jS8oxQeK/kA4U+utP1echY1FoZrwLD7aZoPe
	48ww7ZErIi9j4Lj9PYcHVaZd/BBLeWEKZGadBknODSImCbzyT7d5P6mX+1EpPn
X-Received: by 2002:a17:902:e5c7:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c7c995af52mr4223915ad.15.1782183119337;
        Mon, 22 Jun 2026 19:51:59 -0700 (PDT)
Received: from r912.tailbb6e1e.ts.net ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f8e51sm102704625ad.39.2026.06.22.19.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 19:51:58 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	yatsenko@meta.com,
	leon.hwang@linux.dev,
	kpsingh@kernel.org,
	a.s.protopopov@gmail.com,
	ameryhung@gmail.com,
	rongtao@cestc.cn,
	eyal.birger@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	toke@redhat.com,
	dsahern@kernel.org
Subject: [PATCH bpf-next v4 0/3] bpf: bidirectional VLAN support for bpf_fib_lookup()
Date: Tue, 23 Jun 2026 08:21:44 +0530
Message-ID: <20260623025147.1001664-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301246-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:toke@redhat.com,m:dsahern@kernel.org,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6769D6B39D4

This series adds VLAN awareness to bpf_fib_lookup() in both directions.
BPF_FIB_LOOKUP_VLAN resolves a VLAN egress to its underlying real device
plus the VLAN tag (XDP programs need this because VLAN devices have no XDP
xmit), and BPF_FIB_LOOKUP_VLAN_INPUT runs the lookup as if a tagged frame
had arrived on the matching VLAN subinterface, for iif policy routing and
VRF table selection.

The independent l3mdev/VRF flow-init fix, patch 1 in v1 and v2, was split
out and merged to bpf separately.

v4 changes what bpf_fib_lookup() returns in one case. v3 left a VLAN
egress that cannot be reduced to a physical device plus one tag (a QinQ
egress, or a parent in another namespace) as best-effort SUCCESS with
the VLAN device's ifindex. In his v3 review Toke asked for a distinct
error code there instead, so an XDP program cannot mistake an unresolved
VLAN egress for a physical one, and suggested the name
BPF_FIB_LKUP_RET_VLAN_FAILURE; v4 implements that. The
code is appended after BPF_FIB_LKUP_RET_NO_SRC_ADDR (nothing renumbered,
tools/ mirror updated) and is returned only when BPF_FIB_LOOKUP_VLAN is
set, so no existing caller can observe it. On that failure params->ifindex
is left at the input, like the input-side failures; a tc or XDP program
that wants the VLAN device's own ifindex re-issues the lookup without the
flag, the recovery path he described.

The reason for a distinct code rather than best-effort SUCCESS: SUCCESS
on an unreducible egress silently blackholed XDP. A redirect to the VLAN
device drops at xdp_do_flush() with no in-band signal to the program;
VLAN_FAILURE makes the unreducible case explicit, and a live-frames
selftest exercises both the redirected and the passed paths. Only the
immediate parent is resolved, so QinQ and foreign-netns are the
unreducible cases; bond, team, TBID and VRF egress resolve, as the
selftest table pins.

Changes v3 -> v4:

- Patch 1: return BPF_FIB_LKUP_RET_VLAN_FAILURE for an unreducible VLAN
  egress, leaving params->ifindex at the input.

- Patch 3: the QinQ-egress and cross-namespace-egress arms expect
  VLAN_FAILURE; an escape-hatch arm re-issues without the flag for the
  inner VLAN device's ifindex; and test_fib_lookup_vlan_redirect drives
  live frames (BPF_F_TEST_XDP_LIVE_FRAMES) through the native redirect
  path, asserting a reducible egress is delivered and a QinQ egress is
  passed to the stack. The selftest's VLAN_FAILURE arms are IPv4 only,
  since bpf_ipv6_fib_lookup() restores params->ifindex with the same code
  as the IPv4 path that the arms exercise.

The three other v3 questions Toke marked fine as-is, and v4 keeps them: an
unmatched, down, or cross-namespace tag on input returns NOT_FWDED;
OUTPUT | VLAN_INPUT is rejected with -EINVAL; the BPF_FIB_LOOKUP_VLAN_INPUT
name is kept.

Taking the tag as lookup input follows the approach David Ahern suggested
in the 2021 fwmark discussion:
https://lore.kernel.org/bpf/6248c547-ad64-04d6-fcec-374893cc1ef2@gmail.com/

v3: https://lore.kernel.org/all/20260617224729.1428662-1-avinash.duduskar@gmail.com/
v2: https://lore.kernel.org/all/20260616223426.3568080-1-avinash.duduskar@gmail.com/
v1: https://lore.kernel.org/all/20260609172052.81613-1-avinash.duduskar@gmail.com/

Avinash Duduskar (3):
  bpf: Add BPF_FIB_LOOKUP_VLAN flag to bpf_fib_lookup() helper
  bpf: Add BPF_FIB_LOOKUP_VLAN_INPUT flag to bpf_fib_lookup() helper
  selftests/bpf: Add bpf_fib_lookup() VLAN flag tests

 include/uapi/linux/bpf.h                      |  47 +-
 net/core/filter.c                             | 133 +++-
 tools/include/uapi/linux/bpf.h                |  47 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     | 696 +++++++++++++++++-
 .../testing/selftests/bpf/progs/fib_lookup.c  |  36 +
 5 files changed, 930 insertions(+), 29 deletions(-)


base-commit: a975094bf98ca97be9146f9d3b5681a6f9cf5ce3
-- 
2.54.0


