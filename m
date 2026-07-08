Return-Path: <netdev+bounces-305980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XRBbMXW0TmrlSgIAu9opvQ
	(envelope-from <netdev+bounces-305980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:35:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A5072A3B4
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:35:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=verdict.gg header.s=sig1 header.b="BA/ERtkc";
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305980-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-305980-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D176301519F
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0AB3E0C4D;
	Wed,  8 Jul 2026 20:34:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2004a-snip4-11.eps.apple.com [57.103.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F03E00BD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:34:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783542895; cv=none; b=pUW2z+4xs1FoENsFkh5NcnDvYz4a0NTE4sAUcUZb//B9EQaVxYuUYiTjB2i+pG9HS3W8kBVW9X28vnoGTNrLtqizinbMImhBuwaPI5Sq7j+h0op0eBjv9njuKSwKcm5Jjl9UOLXHkQCRFDOjxrcnNnULQEI6g7WdUusdKVEqu1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783542895; c=relaxed/simple;
	bh=cKTqWKNeQpYFZKRzLGP3mK0x+DHNGDCBTEI86dwWR+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AZixV/0yG5/ND6mSyd7HRzFJHrY3huwNuopZ0B8gQB2lqLubTcRzazCrGhgNp5TSMKZvk/TMfPtyETAcT2lrNTmXq39P7RdEb1DkzJiDGjaPWFYp6eat+SyIHnzpgdaeRbfwpJcfNzsQIVkDkwhhsGp3j/v4+DCLWXpmGVGdtVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verdict.gg; spf=pass smtp.mailfrom=verdict.gg; dkim=pass (2048-bit key) header.d=verdict.gg header.i=@verdict.gg header.b=BA/ERtkc; arc=none smtp.client-ip=57.103.84.13
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPS id AAF11300009E;
	Wed, 08 Jul 2026 20:34:44 +0000 (UTC)
X-ICL-RepId: 019f4370-a882-708d-a5d5-81ada2bf8718
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMGWQJeCEABQwVdEhVdRVcIWwJAEVc4RQhFD1sTTVZUChcNVk1PHUEJXghGXl4fEx9UVgFDGRBWAVhWXQVNGlwYWQ8cAUpWWg5bBEcUFxtcABcbRgIEIwJfAEUCXglWATAXD1ZNTx1BCV4IRl5eHxMAXg8PTAtIAVsHXAJIC0gAWQZbHEQMSQFcGlofFFwUWh9WBXIGXApXBFQfHBdeRhMZThtXTVoNQBlYBm0UVhVSBFk=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verdict.gg; s=sig1; t=1783542889; x=1786134889; bh=vYoBJPpO2uL4VVlcC7jV1/CXwJbaRqJ4IBmz5iXbOPY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=BA/ERtkciXMZdtqVL0IC3V5YrhWuOAuBDAEJHzjaZDvZchl4xVw1RkKMK8PIc5xKpuGqd/uKKmNcJzjSOrmZUYE8twb473mfaINObZcVWk84hoDdpTaIhF4l71NUUbZ7KNWecgQkcO7lIQhRHN/8bTmYb9ZJFXQkA4rrGZWwtyKct/wqO3luq8el0QS5TOnlW8A+HuK/xVHuiWzHDdIOobE0HiDdC4lBynQpnqpixjnU6/zK483FvoBnE7QIhhi2H313U+AMUXzbrVdj7kc3ojx3jKkaeeC+dZ4qMM0hvRh/y0cbZwwGW2LVpMdd0xYz/6cuWz/a1SGQldHC1LPfUg==
mail-alias-created-date: 1621344842221
Received: from DelNac.mail.msk (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-10-percent-0 (Postfix) with ESMTPSA id 59B9B300110C;
	Wed, 08 Jul 2026 20:34:37 +0000 (UTC)
From: Vladimir Vdovin <deliran@verdict.gg>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kselftest@vger.kernel.org,
	Vladimir Vdovin <deliran@verdict.gg>
Subject: [PATCH bpf-next v4 0/6] Add the capability to load HW RX checksum in eBPF programs
Date: Wed,  8 Jul 2026 23:34:04 +0300
Message-ID: <20260708203410.45121-1-deliran@verdict.gg>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zQNJaRqpKCjpeW_8rRYGsYSRCFrT5GZ0
X-Proofpoint-GUID: zQNJaRqpKCjpeW_8rRYGsYSRCFrT5GZ0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIwMiBTYWx0ZWRfX9zezX2Lhrufp
 JjcrUWu/fiGOYri9228fif3ZL5UFWsHAyW2yPCtM5nktzM0kbacRld5p7G55OUi02SwgJvZxjaV
 MHbc3uZad2dJ/4Kc78WXPZFfv4dUqA/wGw0kQtX3OoKX1UJnoW8ovhy3NLFMItV5jrxLk6h8lBw
 w6GBtsUDJepJ3NmXWb1z8GtG+cdc9eLol5GqEsidmhlYpG/keEdOq5RvsDTfCJ8p/EHa+GFzzvT
 9E3UdJAkriVJ4HNebPWvQ8d0hlOP2+IyLt0YwD10zi2/3K5CzJqInJfLHI2/v+T4FJ9r7gto5KM
 Mc3j51gPg8/YGpavaEh
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[verdict.gg:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305980-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:donald.hunter@gmail.com,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:andrew+netdev@lunn.ch,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:shuah@kernel.org,m:maciej.fijalkowski@intel.com,m:jakub@cloudflare.com,m:aleksandr.loktionov@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:intel-wired-lan@lists.osuosl.org,m:linux-kselftest@vger.kernel.org,m:deliran@verdict.gg,m:donaldhunter@gmail.com,m:johnfastabend@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DMARC_NA(0.00)[verdict.gg];
	FORGED_SENDER(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[deliran@verdict.gg,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[verdict.gg:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,cloudflare.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A5072A3B4

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX checksum results in the eBPF program bound to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

If the hardware detects a wrong/failed checksum, it will report
CHECKSUM_NONE in the packet metadata. Moreover, CHECKSUM_NONE will be
returned even if the NIC can't parse the packet (e.g. if it does not
support a specific protocol). A possible use case for
bpf_xdp_metadata_rx_checksum() would be to implement a XDP DDoS
application [1] combining the info from bpf_xdp_metadata_rx_checksum()
and bpf_xdp_metadata_rx_hash() kfuncs in order to filter packets with a
wrong/failed checksum.

This is a repost of Lorenzo's series, rebased on top of net-next, with
a new drv-net selftest for the RX checksum metadata added on top of it,
as Lorenzo suggested [2].

A note on the new selftest semantics: for traffic with a correct
checksum the test requires a usable verdict (CHECKSUM_UNNECESSARY
and/or CHECKSUM_COMPLETE) but reports SKIP on CHECKSUM_NONE, since the
API allows devices that do not verify the packets (e.g. veth reports
NONE for locally generated CHECKSUM_PARTIAL traffic). For corrupted
packets it only asserts that CHECKSUM_UNNECESSARY is not set, as
CHECKSUM_COMPLETE legitimately carries the raw checksum of bad packets
too.

[1] https://blog.cloudflare.com/unimog-cloudflares-edge-load-balancer/
[2] https://lore.kernel.org/r/ak5ox296M46FAcWX@lore-desk

---
Changes in v4:
- Report ip_summed as a bitmask of XDP_CHECKSUM_* values and return the
  hw checksum and the checksum level via dedicated
  bpf_xdp_metadata_rx_checksum() arguments
- Rebase on top of net-next
- Add a drv-net selftest for the XDP RX checksum metadata
- Link to v3: https://lore.kernel.org/r/20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org

Changes in v3:
- Remove leftover assignment from v2 in veth_xdp_rx_checksum()
- Fix typos
- Fix commit logs
- Link to v2: https://lore.kernel.org/r/20260213-bpf-xdp-meta-rxcksum-v2-0-a82c4802afbe@kernel.org

Changes in v2:
- Remove XDP_CHECKSUM_PARTIAL definition
- Improve veth_xdp_rx_checksum() callback
- Fix uninitialized case for cksum_meta in ice_get_rx_csum()
- Fix sparse warnings in ice driver
- Fix typos
- Link to v1: https://lore.kernel.org/r/20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org

Changes in v1:
- Rebase on top of bpf-next
- Test ice driver using xdp_hw_metadata tool available in the bpf
  kernel selftest
- Improve cover letter with an use-case for
  bpf_xdp_metadata_rx_checksum()
- Link to RFC v2: https://lore.kernel.org/r/20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org

change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Lorenzo Bianconi (5):
  netlink: specs: Add XDP RX checksum capability to XDP metadata specs
  net: veth: Add xmo_rx_checksum callback to veth driver
  net: ice: Add xmo_rx_checksum callback
  selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
  selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to
    xdp_hw_metadat prog

Vladimir Vdovin (1):
  selftests: drv-net: add XDP RX checksum metadata tests

 Documentation/netlink/specs/netdev.yaml       |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 123 ++++++++++++------
 drivers/net/veth.c                            |  32 +++++
 include/net/xdp.h                             |  18 +++
 include/uapi/linux/netdev.h                   |   3 +
 net/core/xdp.c                                |  32 +++++
 tools/include/uapi/linux/netdev.h             |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   |   9 ++
 .../selftests/bpf/progs/xdp_hw_metadata.c     |   7 +
 .../selftests/bpf/progs/xdp_metadata.c        |   2 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c |  31 +++++
 tools/testing/selftests/bpf/xdp_metadata.h    |  13 ++
 .../selftests/drivers/net/hw/xdp_metadata.py  | 110 ++++++++++++++++
 .../selftests/net/lib/xdp_metadata.bpf.c      | 112 ++++++++++++++--
 14 files changed, 445 insertions(+), 55 deletions(-)


base-commit: 08030ddb87b4c6c6a2c03c82731b5e188f02f5b9
-- 
2.47.0


