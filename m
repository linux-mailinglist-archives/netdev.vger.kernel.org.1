Return-Path: <netdev+bounces-264700-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uj9jIF95qmkHSQEAu9opvQ
	(envelope-from <netdev+bounces-264700-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:51:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1553521C302
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 07:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4E2B3019C9E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 06:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7237189E;
	Fri,  6 Mar 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="cadGr/rW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106103.protonmail.ch (mail-106103.protonmail.ch [79.135.106.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E744628DF07;
	Fri,  6 Mar 2026 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772779865; cv=none; b=Aj3vCJPRtJ7yF/xsvZtfzQIUGE900tEplzym1zDVMe8ekj2cOQacMCkowmqaxllS0bF9I1GOhRLW3GQoHiCxa71I88uaMaDll4cxQ+OuafKi/bOSHl3pO76/HmawFb4Uv1r7mrZpDdFs1MUNA456CvH3jAcV+Qpu6E0e6x1LdSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772779865; c=relaxed/simple;
	bh=qX8yZbKmJKzCJ/mU4bleURKb1OADuC0T9bYnl1KX5oQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=BpPUTk0rkXsssnAcJo6Ti5jvMFK9k/58x+J/RbYgTmfRfINlAHGcI+zMi7HVguWMNnEo6ZqDyrcXpECjaChUWY2Frj/3cgkENEkA0y+97tYaorP1FTnynZS6u4zZ7Q1y1g1ujMaoLsSROKN+il7m9fxM5ORTEli0/yFrHU9v3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=cadGr/rW; arc=none smtp.client-ip=79.135.106.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772779855; x=1773039055;
	bh=5+GoP3hdzkiVHraGH2z9mX5LdHFugaZmLIDV8TP5eQM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=cadGr/rWcwCKz4fJEEVPdO+eg25xQJCQO8fEI8PFaLYxc+SwWfD8Bnts67WUnmhlE
	 lH0yFd1ilA19S8EYwy5kkwUMKlWaaYMumxGWmPt4V6XOK7fgPqbIT1jAXLZvIssjGU
	 MIaP7EA5Kb2LIudkbMvVzX/Q7StE9fDc2w1x+3uyjWD14nwrByCYMZKR/0+yxVGIjM
	 wFVCn/+KGw2wwOYpw8Lsrz2qzjpknbwi5yCjxpaw/STCUgrE/0Y0pSfjP/kkkHgNzf
	 64dWOx7I6SpYzPH7Kp37KYhMvHypD4Fs+sg6aR4b/GwQUK0JMwK+kWCrKgHP+UuhAf
	 XQy9r6sv5RQhw==
Date: Fri, 06 Mar 2026 06:50:48 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: CyFun <xcyfun@protonmail.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH bpf] bpf: fix constant blinding bypass for PROBE_MEM32 stores
Message-ID: <umqDAnqu0EKHR6iLptii5BdlVyxFAGfVI2rEBNWpoFBW8otE_iTQsECS4QJsk9no3fq5QQjuloPsuagqM9H_AQb0XryMX-gz2ZQygKtHln4=@protonmail.com>
Feedback-ID: 42070492:user:proton
X-Pm-Message-ID: e81a235669ddb56e208f28d9cb85f52eb9d83001
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e6f8e76f139ca3abf740ebc9eb9b72f2008bff92b25a6ad503a0483bce4c2f84"; charset=utf-8
X-Rspamd-Queue-Id: 1553521C302
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264700-lists,netdev=lfdr.de];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:~,4:~];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[protonmail.com];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xcyfun@protonmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[protonmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,protonmail.com:dkim,protonmail.com:email,protonmail.com:mid]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e6f8e76f139ca3abf740ebc9eb9b72f2008bff92b25a6ad503a0483bce4c2f84
Content-Type: multipart/mixed;boundary=---------------------b497c15bff88b79c5b75a6edbaefa4c9

-----------------------b497c15bff88b79c5b75a6edbaefa4c9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

BPF_ST | BPF_PROBE_MEM32 immediate stores are not handled by
bpf_jit_blind_insn(), allowing user-controlled 32-bit immediates to
survive unblinded into JIT-compiled native code when bpf_jit_harden >=3D 1=
.

The root cause is that convert_ctx_accesses() rewrites BPF_ST|BPF_MEM
to BPF_ST|BPF_PROBE_MEM32 for arena pointer stores during verification,
before bpf_jit_blind_constants() runs during JIT compilation. The
blinding switch only matches BPF_ST|BPF_MEM (mode 0x60), not
BPF_ST|BPF_PROBE_MEM32 (mode 0xa0). The instruction falls through
unblinded.

Add BPF_ST|BPF_PROBE_MEM32 cases to bpf_jit_blind_insn() alongside the
existing BPF_ST|BPF_MEM cases. The blinding transformation is identical:
load the blinded immediate into BPF_REG_AX via mov+xor, then convert
the immediate store to a register store (BPF_STX).

The rewritten STX instruction must preserve the BPF_PROBE_MEM32 mode so
the architecture JIT emits the correct arena addressing (R12-based on
x86-64). Cannot use the BPF_STX_MEM() macro here because it hardcodes
BPF_MEM mode; construct the instruction directly instead.

Fixes: 6082b6c328b5 ("bpf: Recognize addr_space_cast instruction in the ve=
rifier.")
Signed-off-by: s4ch <xcyfun@protonmail.com>
---
 kernel/bpf/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55625..000000000000 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2114,6 +2114,22 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg,
 				    BPF_REG_AX, from->off);
 		break;
+
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+	case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		*to++ =3D BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^
+				      from->imm);
+		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
+		/* Cannot use BPF_STX_MEM() here: it hardcodes BPF_MEM
+		 * mode which would lose BPF_PROBE_MEM32 and break the
+		 * arena addressing in the architecture JIT. */
+		*to++ =3D (struct bpf_insn) {
+			.code  =3D BPF_STX | BPF_PROBE_MEM32 | BPF_SIZE(from->code),
+			.dst_reg =3D from->dst_reg,
+			.src_reg =3D BPF_REG_AX,
+			.off   =3D from->off,
+		};
+		break;
 	}

 	return to - to_buff;
--
2.53.0
-----------------------b497c15bff88b79c5b75a6edbaefa4c9
Content-Type: application/pgp-keys; filename="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"; name="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"; name="publickey - xcyfun@protonmail.com - 0x33596AE7.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FWTdKN3JoWUpLd1lCQkFI
YVJ3OEJBUWRBTkVzQVFrd2E0bU1TZlFIU0l2bXFZQjdIQTQvQVFabVoKcVpjOTlUZk9TRTNOTFho
amVXWjFia0J3Y205MGIyNXRZV2xzTG1OdmJTQThlR041Wm5WdVFIQnliM1J2CmJtMWhhV3d1WTI5
dFBzS01CQkFXQ2dBK0JRSmpzbnV1QkFzSkJ3Z0pFRGRGaE9rRjdoMjNBeFVJQ2dRVwpBQUlCQWhr
QkFoc0RBaDRCRmlFRU0xbHE1NlREL1VkT0p2ZjJOMFdFNlFYdUhiY0FBRTFuQVFDSjVZMUoKcU8z
SjkzTWRXbnJOMzRDYTNlaGRKVEVscTNkSFFPV04wcTIwRVFFQTZsV3JCakZ5aDE1cnNtMlJ5TlFO
Ckh5ZDlTNm5heG5mbE03WnJDRVVldndYT09BUmpzbnV1RWdvckJnRUVBWmRWQVFVQkFRZEFVMk9P
WTBHQwo2Q3pBQWJOQ2p4K05rc3AySlgzMHByWEpnWjZ4eFJHcXRIY0RBUWdId25nRUdCWUlBQ29G
QW1PeWU2NEoKRURkRmhPa0Y3aDIzQWhzTUZpRUVNMWxxNTZURC9VZE9KdmYyTjBXRTZRWHVIYmNB
QUdGM0FRRFJYSnd3ClZDbjAyRlhCWEhnRWZDNHV2Q09YTDUzVmRmMENaY210bFJFd3BnRCtOS2Jv
TWRrU2RlNHY2UVJXeldidAo4MmRmTzFBTHBuMnhscnQ0RkZvbjJBaz0KPWwxanYKLS0tLS1FTkQg
UEdQIFBVQkxJQyBLRVkgQkxPQ0stLS0tLQo=
-----------------------b497c15bff88b79c5b75a6edbaefa4c9--

--------e6f8e76f139ca3abf740ebc9eb9b72f2008bff92b25a6ad503a0483bce4c2f84
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmmqeTsJEDdFhOkF7h23RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmcFa77aGWnInC+W5BdjzHiZLiA8tAQ6MlAFbOcN
37BY2hYhBDNZauekw/1HTib39jdFhOkF7h23AADGRQEAzba+R/HmFIY21qWh
42Yu5QsQe7kejqSeQcpjdERlKUABAKiOAe/G3M0f4f4HGmAJVfCw13+k+6JI
OOskyy9bdbcP
=s/a/
-----END PGP SIGNATURE-----


--------e6f8e76f139ca3abf740ebc9eb9b72f2008bff92b25a6ad503a0483bce4c2f84--


