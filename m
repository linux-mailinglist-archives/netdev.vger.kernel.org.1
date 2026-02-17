Return-Path: <netdev+bounces-258980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBYxBR8olGk2AQIAu9opvQ
	(envelope-from <netdev+bounces-258980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F9149F6D
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 09:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31A1F301F792
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 08:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EBB2E1F0E;
	Tue, 17 Feb 2026 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1G+E8Ge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1502D2381;
	Tue, 17 Feb 2026 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771317274; cv=none; b=eujyhas03BFrZoJvM7CGBqLdZyreVE+65kd7V1HUco7YLtVjbKGRA3QW+U0mDh4Eo63lnOyH6hMYHHfIiZT1+jaPVoucrNLgUhlTtaiN7AuY9RHQuGEq5Kt0bDzp8JwPB1c3TlLHYnGn0F3k8qvWtNdEAnUUPrZFPA8ButLKZ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771317274; c=relaxed/simple;
	bh=uL4DxKFzQP1l9k3Kk1Acq3jftmgv8xT3AxsRIN0UWhQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HQ9t7IIf7XVMN2MqnVMPN5j+nm8yx+Wl0KX5dNJz+f1IHTTrxrv3ANHJOsA70++YQETBYXRJZ6iWXJ8DOBeLNQXRVQPqBsyXLw/YcqPpqj8oySZphMoWlh5oeOK5LQHeGhnI5fX8gz7cqCmZN1YEiCP5le0edOUFgfRm6r86pjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1G+E8Ge; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5960C4CEF7;
	Tue, 17 Feb 2026 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771317274;
	bh=uL4DxKFzQP1l9k3Kk1Acq3jftmgv8xT3AxsRIN0UWhQ=;
	h=From:Subject:Date:To:Cc:From;
	b=J1G+E8GemW3j3SNkjeWUN98fLzNofnJDINU6InSnvliGxzY2vnwomAKb/qQVHgYvN
	 bzHF0jxCfdhntCI1I6H6zVwhzmT5LWbYXx/ZCL+QlOTELVbhNiz+wrfjHSQoY90Ykh
	 VwaVy26CmMK3kune0GOQ64+uYrfqOrmsSwKum7jTWZj9Znxm5e4SS6ZRNBC+CDpESj
	 C7lELU7R6rLVRf/A+L/ocgrKROy03GXkaGzlxbJj77nN1LQ/iTpK1wjPo5cLaaR92L
	 0xHAStfTeWy2FnJizFlKA5SjGojKYM6/fj8SlJ2KYCe1Z1HGjk/nQeoRR8VbWFSvOV
	 oTYX7ZDLwIHcQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH bpf-next v3 0/5] Add the the capability to load HW RX
 checsum in eBPF programs
Date: Tue, 17 Feb 2026 09:33:55 +0100
Message-Id: <20260217-bpf-xdp-meta-rxcksum-v3-0-30024c50ba71@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOyw6CMBREf4V0bc3lQpG68j8Mi1Iu0CCPtEgwh
 H+3kJjoQl3OJOfMLMyRNeTYOViYpck403c+RIeA6Vp1FXFT+MwQUIBEwfOh5HMx8JZGxe2sG3d
 vuQRIUkEoQRbMo4Ol0sy79pr5XBs39vaxr0y4tX+EE3LgSR6VJNOTJhleGrId3Y69rbYBTyeAY
 fSDVinqOAVUZU7v9PZnCl8fNgt8sYTeQqIQQisFIv74kK3r+gRUGBv5PQEAAA==
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
 linux-kselftest@vger.kernel.org, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258980-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cloudflare.com:url]
X-Rspamd-Queue-Id: 6B8F9149F6D
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
Changes in v3:
- Remoe leftover assignment from v2 in veth_xdp_rx_checksum()
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
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c      | 118 +++++++++++++--------
 drivers/net/veth.c                                 |  29 +++++
 include/net/xdp.h                                  |  13 +++
 include/uapi/linux/netdev.h                        |   3 +
 net/core/xdp.c                                     |  28 +++++
 tools/include/uapi/linux/netdev.h                  |   3 +
 .../selftests/bpf/prog_tests/xdp_metadata.c        |   6 ++
 .../testing/selftests/bpf/progs/xdp_hw_metadata.c  |   8 ++
 tools/testing/selftests/bpf/progs/xdp_metadata.c   |   3 +
 tools/testing/selftests/bpf/xdp_hw_metadata.c      |  25 +++++
 tools/testing/selftests/bpf/xdp_metadata.h         |  12 +++
 12 files changed, 211 insertions(+), 42 deletions(-)
---
base-commit: 192c0159402e6bfbe13de6f8379546943297783d
change-id: 20250925-bpf-xdp-meta-rxcksum-900685e2909d

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


