Return-Path: <netdev+bounces-256347-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCrCBdsfgmlIPgMAu9opvQ
	(envelope-from <netdev+bounces-256347-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:18:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BCADBCA8
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 17:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D96C30156D4
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 16:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32653C1985;
	Tue,  3 Feb 2026 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fveLew/F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821334F475;
	Tue,  3 Feb 2026 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135510; cv=none; b=SGywzQq1Xwdwyq7t0/Y8FEefIGVVBiFIhti2PRvix5Gawhk4LIniEmENgoWcnwK13MSeAWjT/fJSwHf7mbEK8MLIov+CcI4I09aq0BqmfKEBzg018M0RvYMixTqYJA1I4GGnrNRqgabSQl0oGlbLVwcPJqpCahhY+UP4KSxORoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135510; c=relaxed/simple;
	bh=Xm8StV/VBBnzlX2/DuSYybjjkUbrccnZSQVAwOjfU8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYrzD5EghIq3MrfwDRNMRUD4vvw3jiKPXFiYDRKAgl0LfR8/WsoH3Z0sgnmNz+630Dy3/JpFOHMcGTtwL5xk7Xiqwl2YfQ21J824DmCPl00qdqeK16o0NoD+7QEJGPjrqb7J2vLTZrZpyiKCCmjO4pUvNMgENxXMPqEqdoCpMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fveLew/F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770135509; x=1801671509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xm8StV/VBBnzlX2/DuSYybjjkUbrccnZSQVAwOjfU8U=;
  b=fveLew/Fza3aEYyjG5EF922eA+F3ly+6rMpQx5AYz+SsLFdz7WsNbNfF
   aMSoZYj+a61MWDsRFNp6ZXmiARTlZW8jd4gi9yb5VivOAKUi9o7W0uE3L
   2DC/BRDF7uyw8WbQgCNHoCRGCjhOwfds1sGkyfiDIsJfJdseQKwNbSs9C
   YjhrWebnNxpytCTaFAPebdU26a36QGvf+yKFcNgex6AbDIv96jsZwc/76
   LydMUilMJL95z19qBnWIJq5OOx8URMnHVKmfpZP0LrbgPYw6WPqYJkzzU
   GWOE4XJWowHTaq4HmsQ3YmNoNB6a3Wkfu6qVu8fVZrQxqRIaE5cmyk85o
   A==;
X-CSE-ConnectionGUID: TZ44peJHSJyCn58OAU60qw==
X-CSE-MsgGUID: 8JSxh6NVROqyYKAMEJd8JA==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71391872"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71391872"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 08:18:28 -0800
X-CSE-ConnectionGUID: LV6sKrIhQZ+vfSNOWriypw==
X-CSE-MsgGUID: qTbC6a91TDubloFgCKXxzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="214645519"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa004.fm.intel.com with ESMTP; 03 Feb 2026 08:18:23 -0800
Received: from lincoln.igk.intel.com (lincoln.igk.intel.com [10.102.21.235])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 4EFCD2FC72;
	Tue,  3 Feb 2026 16:18:21 +0000 (GMT)
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Tushar Vyavahare <tushar.vyavahare@intel.com>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Jason Xing <kernelxing@tencent.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: [PATCH bpf 0/2] Fix some corner cases in xskxceiver
Date: Tue,  3 Feb 2026 16:50:56 +0100
Message-ID: <20260203155103.2305816-1-larysa.zaremba@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,iogearbox.net,linux.dev,fomichev.me,google.com,davemloft.net,intel.com,bootlin.com,suse.com,tencent.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256347-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 86BCADBCA8
X-Rspamd-Action: no action

While working on XDP and AF_XDP support for ixgbevf driver,
I came across two distinct problems that caused tests to fail
when they shouldn't have.

Larysa Zaremba (2):
  selftests/xsk: properly handle batch ending in the middle of a packet
  selftests/xsk: fix number of Tx frags in invalid packet

 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.52.0


