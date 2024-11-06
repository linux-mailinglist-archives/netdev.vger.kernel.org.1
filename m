Return-Path: <netdev+bounces-142400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794C39BEB87
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 13:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F16F284F73
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 12:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC831F80DF;
	Wed,  6 Nov 2024 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EP02+HXi"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB9D1E04BA;
	Wed,  6 Nov 2024 12:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897140; cv=none; b=isyyCPI7N2IzcWHO5MciA3pmHYMcbq+0zg3rXzLC4EapNRzlBnQVXuQT4K7klfvcVkZue3l7oi8bS3JlP15XY1LvJXhnTnaOqm8/9XNPnp7fUWerHO0GzrFzfJVIb+rz6LdGvH33nmvWIOVq+VS3pplXw1kfkIczArfl5xKhEKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897140; c=relaxed/simple;
	bh=s/HE862Ebjc4x9QSbLryT2tjzrtXi+x51IAifw3w0tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jGDPWqtiie2Wqb4bkDNxc1d9ejoySlBKNxCkxbGD8BtzGfxT4U+iFQYZm91zSFrNkLRfvwkvKNjKOHAjz+Lh++x0npdb9ps9ufv5TklSFmIMQEIFgZssBsUWUfrGeEmTO8+ywEEWmRfr+NMgIELWrphOnIsBJyDHSNHTs1KHtHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EP02+HXi; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=0mQMe
	EqbIH1W/gwL+X7sQKXQSByBBidMVZJPmvHc5LI=; b=EP02+HXiPtv6PJ2JJf9iM
	dhwANGW36VX8J1WcfU9LF9WabLtDLWh3MSiZX9u7GN3p6gDlB20rv6PH1D5Ha6GI
	CV8k6CwnROQ6AS2SWK7nOugyhW2K7GmV8TtZG6psrG95wXTFldAHc2zaRXzMzKwn
	WudKqkRAxVow3sgrejbhhE=
Received: from localhost.localdomain (unknown [47.252.33.72])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wD3P43DZCtnPigDBA--.6575S2;
	Wed, 06 Nov 2024 20:44:56 +0800 (CST)
From: mrpre <mrpre@163.com>
To: edumazet@google.com,
	jakub@cloudflare.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.orgc,
	linux-kernel@vger.kernel.org
Cc: mrpre <mrpre@163.com>,
	Vincent Whitchurch <vincent.whitchurch@datadoghq.com>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [PATCH bpf] bpf: fix recursive lock when verdict program return SK_PASS
Date: Wed,  6 Nov 2024 20:44:31 +0800
Message-ID: <20241106124431.5583-1-mrpre@163.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P43DZCtnPigDBA--.6575S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkAr1DXF4Duw48JF4fKrg_yoW8Aw1Dpa
	4ku3y5GF9rZr18Z3s3KF97Xr1jgw1vgay2gr1ruw1fZrn0gry5urZ5KFy2vF4YvrsrKF98
	Zr4jqFsrtw17XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piX_-PUUUUU=
X-CM-SenderInfo: xpus2vi6rwjhhfrp/1tbiWw2Pp2crYkExlAAAs0

When the stream_verdict program returns SK_PASS, it places the received skb
into its own receive queue, but a recursive lock eventually occurs, leading
to an operating system deadlock. This issue has been present since v6.9.

'''
sk_psock_strp_data_ready
    write_lock_bh(&sk->sk_callback_lock)
    strp_data_ready
      strp_read_sock
        read_sock -> tcp_read_sock
          strp_recv
            cb.rcv_msg -> sk_psock_strp_read
              # now stream_verdict return SK_PASS without peer sock assign
              __SK_PASS = sk_psock_map_verd(SK_PASS, NULL)
              sk_psock_verdict_apply
                sk_psock_skb_ingress_self
                  sk_psock_skb_ingress_enqueue
                    sk_psock_data_ready
                      read_lock_bh(&sk->sk_callback_lock) <= dead lock

'''

This topic has been discussed before, but it has not been fixed.
Previous discussion:
https://lore.kernel.org/all/6684a5864ec86_403d20898@john.notmuch

Fixes: 6648e613226e ("bpf, skmsg: Fix NULL pointer dereference in sk_psock_skb_ingress_enqueue")
Reported-by: Vincent Whitchurch <vincent.whitchurch@datadoghq.com>
Signed-off-by: Jiayuan Chen <mrpre@163.com>
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index b1dcbd3be89e..e90fbab703b2 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1117,9 +1117,9 @@ static void sk_psock_strp_data_ready(struct sock *sk)
 		if (tls_sw_has_ctx_rx(sk)) {
 			psock->saved_data_ready(sk);
 		} else {
-			write_lock_bh(&sk->sk_callback_lock);
+			read_lock_bh(&sk->sk_callback_lock);
 			strp_data_ready(&psock->strp);
-			write_unlock_bh(&sk->sk_callback_lock);
+			read_unlock_bh(&sk->sk_callback_lock);
 		}
 	}
 	rcu_read_unlock();
-- 
2.43.5


