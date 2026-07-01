Return-Path: <netdev+bounces-303780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ioFTK8RLRWoA+QoAu9opvQ
	(envelope-from <netdev+bounces-303780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:17:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAC96F045C
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:17:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b=LshjrYu5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303780-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-303780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1710E300D862
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC06388E6E;
	Wed,  1 Jul 2026 17:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ms.icloud.com (ms-2005a-snip4-10.eps.apple.com [57.103.72.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6458386559
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 17:11:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782925872; cv=none; b=Sc6eqWUD8jseQdtDRHbHzNK54cukYJM9umsC5Unoll6oFwlcsAQ3lCjFvnRBhovsQgRAKo6t/IktiAgv4nMh2/24uw/GVWI/95vcETZotMOaTGI+ziGEQ88cRJFcFm5bobyq+NmhIMGv8N0xEjYIwRqcg1BpgCIzuCglPj7WePA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782925872; c=relaxed/simple;
	bh=oJRnrYvJPwJWBEXTRVH7A79TUXWT1PIOip4ufaCLJ1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N5in0Iw+8nVX0kf2LF/cZOf15910932QC4wf0O89OjgTThzzUUXntvv2TNn3Hlqi51NJSfewlCMmi1rUGhZRdTXNfdeM6XLpyUG7CZsCIdseEg9nrNimMdiPj9uOMgeplpfm7WyRoYF5+fbzfdm19n04UkkVqiVAOibC1qf0KfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=LshjrYu5; arc=none smtp.client-ip=57.103.72.72
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPS id 809D6180047B;
	Wed, 01 Jul 2026 17:11:04 +0000 (UTC)
X-ICL-RepId: 019f1ea9-adcf-71a1-be69-dcd8c6563bff
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgNDGRBWAVhWXQVNGlwYWQ8cHUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJBCE8CXQJcHEQKSwNABkZWFVURQQxZK0QVSxxaDkNFVRcHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1782925867; x=1785517867; bh=Ux7+DOdhq925QFrHXROFexh8o7u6tNSyc/XGZzwyn+k=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=LshjrYu5hea0XNelNbATHPHVpRcXMvrvwMtxobwp8CUYBDEG3OiR3S59ps8Goqh0uSXhbX7e8ZtnjMLumMW7dm9geAnouOrZgPhCC3LCOQG83bBUw6oAlzvj9nEkb/Dwcrzef1Ev1MA2nqRwFV2QxcWthVwXMfv0gydr846PLC30MnqkRN98XOhhl0aYr2LYH2iDjDtV6cxsinqRoqWGJioK5aPB0WxlprY1pYwa29evDPWGIrGNEHMTB+85uKdr93Qh/vtQcg41THEkZGERap7mTzI37hB6qQRAkVp39X1gF/CgjoVpns9du91D8rN2ItFEWiZ1nLSuN33BSiAugQ==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-20-percent-0 (Postfix) with ESMTPSA id A219018004A4;
	Wed, 01 Jul 2026 17:11:00 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: lorenzo@kernel.org,
	sdf@fomichev.me,
	kuba@kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	sdf.kernel@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: Re: [RFC PATCH bpf-next v1 0/7] xdp: RX checksum metadata hint and checksum assertion over redirect
Date: Wed,  1 Jul 2026 20:10:57 +0300
Message-ID: <20260701171057.4330-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <akRAUTAqVKkxmoVa@lore-desk>
References: <20260630191510.81402-1-deliran@verdict.gg> <akQyT2d0wNF5F5LG@devvm7509.cco0.facebook.com> <akRAUTAqVKkxmoVa@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XoCZSw2ihQeYXaZeorvaKpw_P-MtUnbj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE4MyBTYWx0ZWRfX7/8CHOYakImc
 JoJQofyUX4ikAALH7wMSE/qCNYvnuRTis7kli79H0PfrprAUtJ8q5YxDnnL0I8OOtT64/Vunrgz
 XfBtX9SlEoKcj7fYO/DE5J28y72VSfNBrMurdJk7FK6wvLh/Tura7iSieMc4lUc3pXzWNdUFDmb
 6ea+JrUCQarqkHP6NA09Q24idOXcP/b8zu92DhaCZpV81ZzHZc6EDvbadeC11tR1yRQdSKMTlfR
 DaXa4VR9XtYHJJqSeAfmG35sX4D1JHrSSd1QF5855JIxPJKHE1xz/fds590H5wJoiNqb7IZBPJ7
 I7XQH0OOhNAvUFO/4ry
X-Proofpoint-ORIG-GUID: XoCZSw2ihQeYXaZeorvaKpw_P-MtUnbj
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:sdf@fomichev.me,m:kuba@kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:martin.lau@linux.dev,m:sdf.kernel@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:deliran@verdict.gg,m:johnfastabend@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,vger.kernel.org,verdict.gg];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[verdict.gg:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAAC96F045C

Hi Lorenzo,

Sorry -- I blindly missed your earlier RX-checksum series before I posted
mine, thanks Stanislav for the pointer.

To answer your question: yes, I'm happy to take on the driver selftest
Jakub asked for.

As for my own series, the read side clearly overlaps yours and you own it,
so I'll drop my bpf_xdp_metadata_rx_csum() hint and its driver bits.

What's left that is genuinely separate is the "assertion" half -- a non-dev-bound
bpf_xdp_assert_rx_csum() that preserves the HW verdict across a
cpumap/redirect: it sets a flag on the xdp_buff that rides into the
xdp_frame and becomes skb->ip_summed = CHECKSUM_UNNECESSARY in
__xdp_build_skb_from_frame().

Should I resend that as a small standalone series (v2, assert-only)?
It also looks like a PoC that you and Jakub discussed on v3 [1].

A few things I'd like to confirm before writing the test:

1. API for v4. In the v3 discussion you agreed to rework the API to report
   both COMPLETE and UNNECESSARY (+ csum_level), per Jakub. Do you plan to
   send that in v4, or should the driver selftest target the current v3
   signature (enum xdp_checksum + cksum_meta)? I'd rather write the test
   against the API you intend to keep.

2. Documented behavior. The selftest is meant to "check the documented
   expectation", so which rule should it assert -- "a driver must never
   report CHECKSUM_COMPLETE while an XDP program is attached", or that the
   driver downgrades/repairs COMPLETE on the XDP_PASS path? I'll write the
   doc paragraph and the test to match whatever we settle on.

3. Drivers. Your series adds veth and ice; I don't see mlx5e -- was that
   intentional (left to the driver maintainers)? I had an mlx5e
   implementation in my v1 and I'm happy to contribute it to your series if
   it's useful.

For the test itself I was thinking of extending
tools/testing/selftests/drivers/net/hw/xdp_metadata.py, gated on the new
"checksum" xdp-rx-metadata feature, with good-csum / bad-csum / modify +
XDP_PASS cases. Does that match what you and Jakub had in mind?

[1] https://lore.kernel.org/bpf/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org/

Thanks,
Vladimir

