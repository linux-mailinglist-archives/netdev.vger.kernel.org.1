Return-Path: <netdev+bounces-298113-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BQd6CBKsKmoRuwMAu9opvQ
	(envelope-from <netdev+bounces-298113-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:37:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A33E671EA1
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 14:37:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=lZj32ePO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298113-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298113-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D7E0300693D
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 12:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9D23F7A8C;
	Thu, 11 Jun 2026 12:37:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D4F3F6C3A
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 12:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781181453; cv=none; b=syxWOa6SRfE+Mxv9wLm1q0QJNTNwKTOSM8WDjqW1gys5oLXHS6zxRMbd9/0QoCXgJr0GLTB4b9zOV2Tozpbx+525opOq45YxM37oesqF1jIBL0h5ae2Fv9/fCFNFCOcMxVstYMtuWOnTDTxoC70v3DtA94D/idrnzJUoRix4K0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781181453; c=relaxed/simple;
	bh=8b/7eQFjT+UITLfSGtnmzyLGSOXLDyFeawmU0GSKuxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WaI6uOXSaKNeNyK13tRGXCiqci65ynb1P9fRcU4xX3r0TA16bod0/NGR7wHWGrg8VMyGz5Tv7VdX/VWdYaV8+aGt8tkEr6oo7HVOHZJuGBmApQ2nmIV94vrnqb511yMhhvKSiw1CKUyzt0K/mvFt4JW5h8yK9Q3aqRbYsgnoIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZj32ePO; arc=none smtp.client-ip=91.218.175.182
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781181439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYHg5dkLLTur5IAmFlDfUGRLb6K3EKX9VBpaTCIihkU=;
	b=lZj32ePOnIe61cEiX71wq5QJaaiIJUG4Ri/naMj9N5/IWHFQyjNNAjZ1s+nWJP9xyuV/3A
	T0MhotjaoV31MmhwDsuhbPrhEtBIVkQrnOuG/+LfH32nUErO3IL9As3scKofyMPbjqrrDy
	mAfHn1nJc16IJQk1d2ZrwHeIRiJ0Qc8=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sechang Lim <rhkrqnwk98@gmail.com>,
	Cong Wang <cong.wang@bytedance.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf v2 0/7] bpf, skmsg: some fixes for skmsg
Date: Thu, 11 Jun 2026 20:34:08 +0800
Message-ID: <20260611123538.156005-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	TAGGED_FROM(0.00)[bounces-298113-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:martin.lau@linux.dev,m:ast@kernel.org,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:jakub@cloudflare.com,m:shuah@kernel.org,m:hawk@kernel.org,m:ihor.solodrai@linux.dev,m:rhkrqnwk98@gmail.com,m:cong.wang@bytedance.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[linux.dev:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,etsalapatis.com,davemloft.net,google.com,redhat.com,cloudflare.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A33E671EA1


All fixes are from previous patches sent by Weiming Shi, Zhang Cen,
Kuniyuki and Sechang Lim, which have already been reviewed by me and John and Jakub.

https://lore.kernel.org/bpf/20260610081218.506709-2-rhkrqnwk98@gmail.com/
https://lore.kernel.org/bpf/20260520102715.3033936-1-rollkingzzc@gmail.com/
https://lore.kernel.org/bpf/20260424190310.1520555-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260424191602.1522411-3-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260423155807.1245644-2-bestswngs@gmail.com/
https://lore.kernel.org/bpf/20260221233234.3814768-4-kuniyu@google.com/

The automated reviewer (sashiko) may still flag a few other potential
issues on top of this series. After looking into them, they are either
already covered by the patches here, or only reachable under very narrow
conditions that require a specially crafted BPF program and an unusual
sk_msg ring state, so they are not practical to trigger and are left out
of this series. I'm collecting these fixes together because the same
problems have been re-sent many times in slightly different forms, and I
hope this series can be prioritized for merging so the duplicates can
finally settle. With so many AI-generated patches floating around for
these spots, leaving them unmerged just keeps wasting maintainer review
cycles on the same issues.

v1->v2: fix problem when fix the conflict.

Kuniyuki Iwashima (1):
  sockmap: Fix use-after-free in udp_bpf_recvmsg()

Sechang Lim (2):
  bpf, sockmap: fix integer overflow in bpf_msg_pop_data() bounds check
  selftests/bpf: add test for bpf_msg_pop_data() overflow

Weiming Shi (3):
  bpf, sockmap: reject overflowing copy + len in bpf_msg_push_data()
  bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
  bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

Zhang Cen (1):
  bpf, sockmap: keep sk_msg copy state in sync

 net/core/filter.c                             | 99 +++++++++++++++++--
 net/ipv4/udp_bpf.c                            |  9 ++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 48 +++++++++
 .../bpf/progs/test_sockmap_msg_pop_data.c     | 27 +++++
 4 files changed, 174 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_pop_data.c

-- 
2.43.0


