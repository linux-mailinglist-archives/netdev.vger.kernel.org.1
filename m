Return-Path: <netdev+bounces-264713-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB20KoaYqmmIUAEAu9opvQ
	(envelope-from <netdev+bounces-264713-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:04:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 314DC21D941
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 101663029258
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 09:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C5533A9DE;
	Fri,  6 Mar 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xbOV+6jn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-106104.protonmail.ch (mail-106104.protonmail.ch [79.135.106.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E19233858B
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 09:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772787841; cv=none; b=tcFizB5E6q3dl3mI8A7C71KtnqQ3LA8MeQPOPR4LC11ExH+95IYPawwmyMqZIC7ugXU+MHNrLqhnQc/7gjLejB/CRFw3c5Ls+Qvu9J0Mx9XH6yc5IChx/zKryVRYAdeojjUV8XG+VfNeprsjwszzHi9oDdjEa7niDgSK6nRk0zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772787841; c=relaxed/simple;
	bh=Eli/FPRcHAeLJQQC1JfW7qWN6/2FvGa4kJn8GnM5+tg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=MJ1mkgZMHC4T+ZKwwHBvLuD1jI2EvgqbVHvJuTHIVdigVEWSy43PbuquBylAkaERWHXBaOlY+nvt7bmmciNS8vEgK5qTNEkhg63PPWZeIvFGsEVza1+LYXiW8oIkNXeAoo+DFpTG//K53Ovyzb36oDqLsGTuBQp+xT2qDZ14liA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=xbOV+6jn; arc=none smtp.client-ip=79.135.106.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772787829; x=1773047029;
	bh=BG6MsfApo6WVjCvrJZzMRyHrC8k12X+r7HRvskBvFSU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=xbOV+6jnTWPybEXNCk9xakM3vEfQ7/EumXlFb65Wg+cDNLCXbZO0ZQEW2TFynXHqU
	 m36mhHfllgnHZHtEvhehUH/5SHqdJce+5ahf+WEMMFcvyjvtWSBfXJDbzHR+Z8zmWG
	 sCj5eB2GW+6spv2XialNBXF3vSjlovRdi2Y9AhNkPaKyWoyhIEdfTpV019enkSBB/J
	 xjc5RxlCAqhSWluZSdDXWVSkHkjSs+7hvZf6hyrKm9r62T5A7e8ho7m7wJ5bt0lTlW
	 ODSpfx11QTFV8dAD6WFIq6Tp7rpldntjm7m65ap/v5A3VoWR/t0+9UpYo6bAC6owC0
	 Iae00b3qrfI4g==
Date: Fri, 06 Mar 2026 09:03:46 +0000
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From: CyFun <xcyfun@protonmail.com>
Cc: "daniel@iogearbox.net" <daniel@iogearbox.net>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH bpf v2] bpf: fix constant blinding bypass for PROBE_MEM32 stores
Message-ID: <ymj6l4pBrhKjzHeR2XYjQcvWswW_741UgkR05M3iYsrzxzhD-3AfAZ1rNJ5k1b6ex0tosQAorJP38DfNDkyqbhkY-DD6RW_qTfuJ0z86psE=@protonmail.com>
Feedback-ID: 42070492:user:proton
X-Pm-Message-ID: c1ab93d6db44e1386836cdb366981766d0ebce10
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------e61a83288252667a3c0566d3be7e1be1b93edbd2e6c4554f28de02d4c70668e6"; charset=utf-8
X-Rspamd-Queue-Id: 314DC21D941
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-264713-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:dkim,protonmail.com:email,protonmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,iogearbox.net:email]
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------e61a83288252667a3c0566d3be7e1be1b93edbd2e6c4554f28de02d4c70668e6
Content-Type: multipart/mixed;boundary=---------------------96784b056a1fdb1f93c88584c16caf76

-----------------------96784b056a1fdb1f93c88584c16caf76
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org, netdev@vger.k=
ernel.org
Subject: [PATCH bpf v2] bpf: fix constant blinding bypass for PROBE_MEM32 =
stores

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
v2: Rebased onto current bpf tree (commit 56145d237385).
    v1 had a malformed diff header that caused CI to reject it.
---
 kernel/bpf/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 3ece2da55..bb2fa75de 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1422,6 +1422,24 @@ static int bpf_jit_blind_insn(const struct bpf_insn=
 *from,
 		*to++ =3D BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ =3D BPF_STX_MEM(from->code, from->dst_reg, BPF_REG_AX, from->off)=
;
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
 out:
 	return to - to_buff;
--
2.53.0
-----------------------96784b056a1fdb1f93c88584c16caf76
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
-----------------------96784b056a1fdb1f93c88584c16caf76--

--------e61a83288252667a3c0566d3be7e1be1b93edbd2e6c4554f28de02d4c70668e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wrsEARYKAG0FgmmqmGQJEDdFhOkF7h23RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmfkciulAq1i7V8rQA8XzSIt/tW7VTDaiO8aVj6I
Te7JkBYhBDNZauekw/1HTib39jdFhOkF7h23AABL0wD+NFh5liY8sC2z7y9x
xIHAtSlyShmIfn5ml0TSiK1XmkEA/3xhn3jW13Y2ByxpseT4AkoqokaI71un
5t/ls2/vlbIF
=p2P+
-----END PGP SIGNATURE-----


--------e61a83288252667a3c0566d3be7e1be1b93edbd2e6c4554f28de02d4c70668e6--


