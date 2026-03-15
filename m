Return-Path: <netdev+bounces-267975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKPhMeMqt2kLNQEAu9opvQ
	(envelope-from <netdev+bounces-267975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:55:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EB4292C19
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 22:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3017A3007CBF
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A235D37B3F2;
	Sun, 15 Mar 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDLWFYNX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB0437B02B
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 21:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611482; cv=none; b=gwKsnWUsXYSVDQ208xivR0EzXfb5LylMHcvF3sIuwVy5Xiac+4tfKJnJyJnoNrYQmHu4Ow+XqlMfjaBkjragm8R7fWRm3hDTeXhwwFL5LwXy/kLldGBtOPEwgGUgk1HUTGH5w4Ovo4wzqLv2nRRmfW1yu8PpAI59h/fFdTZTvfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611482; c=relaxed/simple;
	bh=che4Q4OuxSKufNXTblHdN9Dc0eJDBdzbT8fKmEuSH5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nnbat9KD/PoYlK1QEPDd9NSzNlz4mhUjRzn/5dlrW3qb3GQMyqr/CIrKqSZtBjDpZ4mYP+2jBNJYKfGl7wwwb25z/MavJ7/qatm3UlM6NsXnf5v64lIxkGaWE8ixlt+OVpHfJc+ZYaBexuVzOQJVZMtFP5San+H5ZGBkW+UlKOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDLWFYNX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC34C4CEF7;
	Sun, 15 Mar 2026 21:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773611482;
	bh=che4Q4OuxSKufNXTblHdN9Dc0eJDBdzbT8fKmEuSH5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDLWFYNX1CjrcIqNLF2Yg7McNGXwi3XE076BPu2HGM8GW97PAgA4aXQ3+Ms5XkSGs
	 iDrEKqZqs8UE0eU1ZQSOlXH+eQqPb+Xoo0wq1qqyaaPpB3ajz/SklwDc66fqSvr5EJ
	 GuEldLeedT8YMHr/GUKPi0HPumHrzXhrPiZfalhrqrqdlZ57CwKk+KIjbWG2I236oF
	 gNpSxKEqIvIXt9iGtMsjFF2ddDyV/rmiKlmdroHboI/Lf7SkJ/JrApPaYbAJtwvveQ
	 QAhzDzxKAH7mcw4GPccqST+AJy/o7VDcU7JkmNNBD46n/ealtcgAYKjCGASRk7GP4D
	 42JDNn5QnbzIQ==
Date: Sun, 15 Mar 2026 14:51:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <20260315145120.1a555d81@kernel.org>
In-Reply-To: <20260315154003.1851513-1-edumazet@google.com>
References: <20260315154003.1851513-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267975-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 29EB4292C19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 15:40:03 +0000 Eric Dumazet wrote:
> v3: fix tools/testing/selftests/bpf/progs/tcp_ca_kfunc.c (Jakub)
> v2: fix tools/testing/selftests/bpf/progs/bpf_cc_cubic.c (Jakub)
> v1: https://lore.kernel.org/netdev/20260313202802.1201129-1-edumazet@google.com/

Builds but does not run:
https://github.com/kernel-patches/bpf/actions/runs/23116079851/job/67142296478

The BPF CI can be triggered by opening a pull request their
kernel-patches/bpf repo. We can also also Martin to help.

Error: #23 bpf_iter_setsockopt
  Error: #23 bpf_iter_setsockopt
  create_netns:PASS:create netns 0 nsec
  create_netns:PASS:bring up lo 0 nsec
  serial_test_bpf_iter_setsockopt:PASS:iter_skel 0 nsec
  serial_test_bpf_iter_setsockopt:PASS:attach iter 0 nsec
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: -ENOTSUPP
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
  attach to unsupported member cwnd_event_tx_start of struct tcp_congestion_ops
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
  libbpf: failed to load object 'bpf_cubic'
  libbpf: failed to load BPF skeleton 'bpf_cubic': -ENOTSUPP
  serial_test_bpf_iter_setsockopt:FAIL:cubic_skel unexpected error: -524
Error: #34 bpf_tcp_ca
Error: #34/2 bpf_tcp_ca/cubic
  Error: #34/2 bpf_tcp_ca/cubic
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: -ENOTSUPP
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
  attach to unsupported member cwnd_event_tx_start of struct tcp_congestion_ops
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
  libbpf: failed to load object 'bpf_cubic'
  libbpf: failed to load BPF skeleton 'bpf_cubic': -ENOTSUPP
  test_cubic:FAIL:bpf_cubic__open_and_load unexpected error: -524
Error: #34/14 bpf_tcp_ca/tcp_ca_kfunc
  Error: #34/14 bpf_tcp_ca/tcp_ca_kfunc
  libbpf: prog 'cwnd_event_tx_start': BPF program load failed: -ENOTSUPP
  libbpf: prog 'cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
  attach to unsupported member cwnd_event_tx_start of struct tcp_congestion_ops
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'cwnd_event_tx_start': failed to load: -ENOTSUPP
  libbpf: failed to load object 'tcp_ca_kfunc'
  libbpf: failed to load BPF skeleton 'tcp_ca_kfunc': -ENOTSUPP
  test_tcp_ca_kfunc:FAIL:tcp_ca_kfunc__open_and_load unexpected error: -524
Error: #34/15 bpf_tcp_ca/cc_cubic
  Error: #34/15 bpf_tcp_ca/cc_cubic
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': BPF program load failed: -ENOTSUPP
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': -- BEGIN PROG LOAD LOG --
  attach to unsupported member cwnd_event_tx_start of struct tcp_congestion_ops
  processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
  -- END PROG LOAD LOG --
  libbpf: prog 'bpf_cubic_cwnd_event_tx_start': failed to load: -ENOTSUPP
  libbpf: failed to load object 'bpf_cc_cubic'
  libbpf: failed to load BPF skeleton 'bpf_cc_cubic': -ENOTSUPP
  test_cc_cubic:FAIL:bpf_cc_cubic__open_and_load unexpected error: -524

