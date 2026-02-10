Return-Path: <netdev+bounces-258128-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDlmLUhpi2k1UQAAu9opvQ
	(envelope-from <netdev+bounces-258128-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:22:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD1B11DD40
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A716B30498FA
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 17:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B06032AAB4;
	Tue, 10 Feb 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqofsrd9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFC264617;
	Tue, 10 Feb 2026 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770744125; cv=none; b=CRvDHogQkaEQfevlgYrqMwYrK2XV45zHkCWhOxcKucym2Q2rkOU2LnvljHL87Ec+caCrQgjvGZ3iCdsIohPFoRwqOi1wPYJYitpeO8zSyQEIBXVU8G2bXWDGc53qvyuvJRUA6WTpFbxVsCBFS2xFd0703PqgAPIMzffaQrMornU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770744125; c=relaxed/simple;
	bh=2gXAQUZwt1m8QP/RD9+/QxmuC5Ub8RRVPrxGR9ZsYoU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B3uLKVt3b/xVhPDL2TnYt01PQJfjstmP7OcGQqyLi/Fs7iWk6QdiPK799pC0AMa3xDRHEJw1hUbXSdIGsgFA/L6SUWt8pANNvEVfABV1jxeezbmSk87wbnOwgOjh8wG44sxUTtZXY7/dcFwPRVz/Rz+jM+AyTinplLpHo8uqtVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqofsrd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519D8C116C6;
	Tue, 10 Feb 2026 17:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770744124;
	bh=2gXAQUZwt1m8QP/RD9+/QxmuC5Ub8RRVPrxGR9ZsYoU=;
	h=From:Subject:Date:To:Cc:From;
	b=Nqofsrd98XpnLI5MRiATQ28YBTk/rzXZjVERm8iB11RKSRZXkH57TMEDejNr/awZO
	 29nvxpL0FFKpGXsMRSxScdzGQmfveZSwzIU8AMhesztdS06Od0AAlsbJ/iMnSGWYHO
	 8domYBkwWPxgOveYFlAsxZjg1u64kcgJWRB3FyNwZeykfEYdFG3F+I/kgVv3RJ9JfY
	 a1ClyowQ1BLlqQg/G8+ZdvL8kj+ZXzabgDetiZxrr1rAuee9GvDRlqIOawwHSDugGc
	 3WhjX0qgvs5HNxKuTP6oWMPB44c9DQAQyQm+5MJ6cbEvg22adEeq9i4EpJJKVjcMK9
	 0A0Z+Tv+SR2+A==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next 0/5] Add the the capability to load HW RX checsum
 in eBPF programs
Date: Tue, 10 Feb 2026 18:21:46 +0100
Message-Id: <20260210-bpf-xdp-meta-rxcksum-v1-0-e5d55caa0541@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WNQQ6CMBBFr0Jm7ZhSU6SuuIdhAXQKDUKbKRIM4
 e5WLuDyveS/v0MkdhThke3AtLro/Jwgv2TQDc3cEzqTGKSQSmipsA0WNxNwoqVB3roxvifUQhS
 lIqmFNpCmgcm67cw+68SDi4vnz/myyp/9E1wlCizamyVd3jvSeTUSz/S6eu6hPo7jCxFkhzO5A
 AAA
X-Change-ID: 20250925-bpf-xdp-meta-rxcksum-900685e2909d
To: Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, 
 bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258128-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5FD1B11DD40
X-Rspamd-Action: no action

Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
RX cheksum results in the eBPF program binded to the NIC.
Implement xmo_rx_checksum callback for veth and ice drivers.

If the hardware detects a wrong/failed checksum, it will report
CHECKSUM_NONE in the packet metadata. Moreover, CHECKSUM_NONE will be
returned even if the NIC can't parse the packet (e.g. if it does not
support a specific protocol). A possible use case for
bpf_xdp_metadata_rx_checksum() would be to implement a XDP DDoS
application [1] combining the info from bpf_xdp_metadata_rx_checksum()
and bpf_xdp_metadata_rx_hash() kfuncs in order to filter packets with a
wrong/failed checksum.

[1] https://blog.cloudflare.com/unimog-cloudflares-edge-load-balancer/

---
Changes in v1:
- Rebase on top of bpf-next
- Test ice driver using xdp_hw_metadata tool available in the bpf
  kernel selftest
- Improve cover letter with an use-case for
  bpf_xdp_metadata_rx_checksum()
- Link to RFC v2: https://lore.kernel.org/r/20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org

Changes in RFC v2:
- Squash patch 1/6 and 2/6
- Introduce enum xdp_checksum definitions
- Rework ice support to reuse ice_rx_csum codebase

---
Lorenzo Bianconi (5):
      netlink: specs: Add XDP RX checksum capability to XDP metadata specs
      net: veth: Add xmo_rx_checksum callback to veth driver
      net: ice: Add xmo_rx_checksum callback
      selftests/bpf: Add selftest support for bpf_xdp_metadata_rx_checksum
      selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog

 Documentation/netlink/specs/netdev.yaml            |   5 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 114 +++++++++++++--------
 drivers/net/veth.c                                 |  20 ++++
 include/net/xdp.h                                  |  14 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/xdp.c                                     |  29 ++++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   7 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   7 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   1 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  28 +++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  13 +++
 12 files changed, 204 insertions(+), 40 deletions(-)
---
base-commit: db975debcb8c4cd367a78811bc1ba84c83f854bd
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


