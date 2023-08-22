Return-Path: <netdev+bounces-29739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 606D57848DE
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EB328116D
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACA31D2EF;
	Tue, 22 Aug 2023 17:59:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518962B544
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:59:06 +0000 (UTC)
Received: from [192.168.42.3] (194-45-78-10.static.kviknet.net [194.45.78.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 29AE5C433C8;
	Tue, 22 Aug 2023 17:59:03 +0000 (UTC)
Subject: [PATCH net-next RFC v1 0/4] veth: reduce reallocations of SKBs when
 XDP bpf-prog is loaded
From: Jesper Dangaard Brouer <hawk@kernel.org>
To: netdev@vger.kernel.org, edumazet@google.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, lorenzo@kernel.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, mtahhan@redhat.com,
 huangjie.albert@bytedance.com, Yunsheng Lin <linyunsheng@huawei.com>,
 Liang Chen <liangchen.linux@gmail.com>
Date: Tue, 22 Aug 2023 19:59:00 +0200
Message-ID: <169272709850.1975370.16698220879817216294.stgit@firesoul>
User-Agent: StGit/1.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Loading an XDP bpf-prog on veth device driver results in a significant
performance degradation (for normal unrelated traffic) due to
veth_convert_skb_to_xdp_buff() in most cases fully reallocates an SKB and copy
data over, even when XDP prog does nothing (e.g. XDP_PASS).

This patchset reduce the cases that cause reallocation.
After patchset UDP and AF_XDP sending avoids reallocations.

Future work will investigate TCP.

---

Jesper Dangaard Brouer (4):
      veth: use same bpf_xdp_adjust_head check as generic-XDP
      veth: use generic-XDP functions when dealing with SKBs
      veth: lift skb_head_is_locked restriction for SKB based XDP
      veth: when XDP is loaded increase needed_headroom


 drivers/net/veth.c | 86 +++++++++++++++++++---------------------------
 net/core/dev.c     |  1 +
 net/core/filter.c  |  1 +
 3 files changed, 38 insertions(+), 50 deletions(-)

--
Jesper


