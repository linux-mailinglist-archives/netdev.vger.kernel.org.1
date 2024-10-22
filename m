Return-Path: <netdev+bounces-137784-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D949A9D22
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 10:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40AB9281946
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 08:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B680C1714BA;
	Tue, 22 Oct 2024 08:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52CF140E38;
	Tue, 22 Oct 2024 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729586425; cv=none; b=Re/SyiXzs/mRKPZF0rejC3NMr5FsalY8x3nVx7GuFgVjTNs0bfuaTZo8Iny3cgufge0T16UnA72gyMta6vLLEjAXl21TCUKp4HuudDDs/YxFq29XYMP+ZCSYoDFNz/Unwm1LD8oYmN74fMl0mR9d3QuVlbD5K38bsaVObgYnh3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729586425; c=relaxed/simple;
	bh=0vlvIv7gUvkskgNldVec0ci/6McdRPb/+W7tZ8OZpyk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVJ3GWjBSNRDwpdw4TRAvRwWTo+6mAkbqnbPntQi6uijUMT7mcJKDMd8lpYldVPOciE0K8H8S8wkb6x/GDLg4i8rnlG7vM40gQuGsIDZozPAgW8DukryVZwNAKk/NpTPHk2WpHYlpndEo5NfA1cXOYcno3FfjHuFrSl6SIl6jdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XXlwK28rTzQrx6;
	Tue, 22 Oct 2024 16:39:29 +0800 (CST)
Received: from kwepemg200005.china.huawei.com (unknown [7.202.181.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 159E514011A;
	Tue, 22 Oct 2024 16:40:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200005.china.huawei.com
 (7.202.181.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 22 Oct
 2024 16:40:19 +0800
From: Wang Liang <wangliang74@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <idosch@nvidia.com>, <kuniyu@amazon.com>,
	<stephen@networkplumber.org>, <dsahern@kernel.org>, <lucien.xin@gmail.com>
CC: <wangliang74@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net] net: fix crash when config small gso_max_size/gso_ipv4_max_size
Date: Tue, 22 Oct 2024 16:57:59 +0800
Message-ID: <20241022085759.1328477-1-wangliang74@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200005.china.huawei.com (7.202.181.32)

Config a small gso_max_size/gso_ipv4_max_size can lead to large skb len,
which may trigger a BUG_ON crash.

If the gso_max_size/gso_ipv4_max_size is smaller than MAX_TCP_HEADER + 1,
the sk->sk_gso_max_size is overflowed:
sk_setup_caps
    // dst->dev->gso_ipv4_max_size = 252, MAX_TCP_HEADER = 320
    // GSO_LEGACY_MAX_SIZE = 65536, sk_is_tcp(sk) = 1
    sk->sk_gso_max_size = sk_dst_gso_max_size(sk, dst);
        max_size = dst->dev->gso_ipv4_max_size;
            sk->sk_gso_max_size = max_size - (MAX_TCP_HEADER + 1);
            sk->sk_gso_max_size = 252-(320+1) = -69

When send tcp msg, the wrong sk_gso_max_size can lead to a very large
size_goal, which cause large skb length:
tcp_sendmsg_locked
    tcp_send_mss(sk, &size_goal, flags);
        tcp_xmit_size_goal(sk, mss_now, !(flags & MSG_OOB));

            // tp->max_window = 65536, TCP_MSS_DEFAULT = 536
            new_size_goal = tcp_bound_to_half_wnd(tp, sk->sk_gso_max_size);
                new_size_goal = sk->sk_gso_max_size = -69

            // tp->gso_segs = 0, mss_now = 32768
            size_goal = tp->gso_segs * mss_now;
                size_goal = 0*32768 = 0

            // sk->sk_gso_max_segs = 65535, new_size_goal = -69
            new_size_goal < size_goal:
                tp->gso_segs = min_t(u16, new_size_goal / mss_now,
                     sk->sk_gso_max_segs);
                // new_size_goal / mss_now = 0x1FFFF -> 65535
                // tp->gso_segs = 65535
                size_goal = tp->gso_segs * mss_now;
                size_goal = 65535*32768 = 2147450880

    if new_segment:
        skb = tcp_stream_alloc_skb()
        copy = size_goal; // copy = 2147450880
    if (copy > msg_data_left(msg)) // msg_data_left(msg) = 2147479552
        copy = msg_data_left(msg); // copy = 2147450880
    copy = min_t(int, copy, pfrag->size - pfrag->offset); // copy = 21360
    skb_copy_to_page_nocache
        skb_len_add
            skb->len += copy; // skb->len add to 524288

The large skb length may load to a overflowed tso_segs, which can trigger
a BUG_ON crash:
tcp_write_xmit
    tso_segs = tcp_init_tso_segs(skb, mss_now);
        tcp_set_skb_tso_segs
            tcp_skb_pcount_set
                // skb->len = 524288, mss_now = 8
                // u16 tso_segs = 524288/8 = 65535 -> 0
                tso_segs = DIV_ROUND_UP(skb->len, mss_now)
    BUG_ON(!tso_segs)

To solve this issue, the minimum value of gso_max_size/gso_ipv4_max_size
should be checked.

Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device creation")
Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size per device")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
 net/core/rtnetlink.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e30e7ea0207d..a0df1da5a0a6 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2466,6 +2466,12 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_GSO_MAX_SIZE] &&
+	    (nla_get_u32(tb[IFLA_GSO_MAX_SIZE]) < MAX_TCP_HEADER + 1)) {
+		NL_SET_ERR_MSG(extack, "too small gso_max_size");
+		return -EINVAL;
+	}
+
 	if (tb[IFLA_GSO_MAX_SEGS] &&
 	    (nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > GSO_MAX_SEGS ||
 	     nla_get_u32(tb[IFLA_GSO_MAX_SEGS]) > dev->tso_max_segs)) {
@@ -2485,6 +2491,12 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 		return -EINVAL;
 	}
 
+	if (tb[IFLA_GSO_IPV4_MAX_SIZE] &&
+	    (nla_get_u32(tb[IFLA_GSO_IPV4_MAX_SIZE]) < MAX_TCP_HEADER + 1)) {
+		NL_SET_ERR_MSG(extack, "too small gso_ipv4_max_size");
+		return -EINVAL;
+	}
+
 	if (tb[IFLA_GRO_IPV4_MAX_SIZE] &&
 	    nla_get_u32(tb[IFLA_GRO_IPV4_MAX_SIZE]) > GRO_MAX_SIZE) {
 		NL_SET_ERR_MSG(extack, "too big gro_ipv4_max_size");
-- 
2.34.1


