Return-Path: <netdev+bounces-80925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485E8881B60
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 04:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9FE1C20CE3
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 03:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7D26FB2;
	Thu, 21 Mar 2024 03:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QVwWePKB"
X-Original-To: netdev@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8DF6D39
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710990181; cv=none; b=mgDjPa/aHLol5rVWGELZEL7b4lFHsieN3qMufzISjtD7Wba3Sssar07X67CJSlKmN25cIKgIRIHhGERezXzWfaUhQDyfrvefVx/KLmFi7CNMPM05PSB/jBth+TObDKdjgexx343VFz1Oi/cUL9CJQvk8hnTpgLA8WrcE+WetYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710990181; c=relaxed/simple;
	bh=CqIEiuVYe2BRVibqyYvIatl1+Wb+7tHRc8z7RdY2GqY=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JxTo2L3uY2qWRkpVNo4xknuZinyCKiasqBcxKRNfEY4ZhhQKgVyOAX2WpSoXRUTRufZcFlVfCYtD/fKMpv4maRROCmp8v4pjc/SMhYdMwYK7jA93EDswEK3UwpKVhlUf9Jp8f13e80K/5rMsCUeyzAWcLOHfaKI+l1k8kVbRGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QVwWePKB; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:
	Content-Type; bh=7fG3Oq5+uPbIt7iydqFSQ6UpWBpcnEwstevVPkWEQd0=;
	b=QVwWePKBWZktc+wIeSaMfx40HxO/yUIzWDCChVbACMouJ19SYh0YtfAS8lUhGa
	JYbl/tDujXHO0gqO1XjiHfKG3hEIibxs1t2WKUGAXLzS4jlsk+G5Wd6Cyof+uYMe
	10E/m4YBRZHI5U0eHEfWCrFjEtbjmZdBvGKX+jTIo7UuQ=
Received: from [172.22.5.12] (unknown [27.148.194.72])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wD338NMo_tlVPPZBA--.60211S2;
	Thu, 21 Mar 2024 11:02:36 +0800 (CST)
Message-ID: <23b5678b-1e5a-be6c-ea68-b7a20dff4bbc@163.com>
Date: Thu, 21 Mar 2024 11:02:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
To: netdev <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, davem@davemloft.net, kuniyu@amazon.com
From: Jianguo Wu <wujianguo106@163.com>
Subject: [PATCH] tcp: Fix inet_bind2_bucket_match_addr_any() regression
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD338NMo_tlVPPZBA--.60211S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr45WryxuF4UGF1xWry3Jwb_yoW8Zr43pw
	1UKr4akry5KF1rJrnYyF9Ykw1akr4UAFnrCry3tFyFkFyDXrZIvF40kw1ak3Z2qayvqan5
	KF4rZa4j9a93Ca7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTUDAUUUUU=
X-CM-SenderInfo: 5zxmxt5qjx0iiqw6il2tof0z/1tbiJxyokGXAk+UuIAABsf

From: Jianguo Wu <wujianguo@chinatelecom.cn>

If we bind() a TCPv4 socket to 0.0.0.0:8090, then bind() a TCPv6(ipv6only) socket
to :::8090, both without SO_REUSEPORT, then bind() 127.0.0.1:8090, it should fail
but now succeeds. like this:
  tcp        0      0 127.0.0.1:8090          0.0.0.0:*               LISTEN
  tcp        0      0 0.0.0.0:8090            0.0.0.0:*               LISTEN
  tcp6       0      0 :::8090                 :::*                    LISTEN

bind() 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.

But if we bind() a TCPv6(ipv6only) socket to :::8090 first, then  bind() a TCPv4
socket to 0.0.0.0:8090, then bind() 127.0.0.1:8090, 0.0.0.0:8090, :::8090 and ::1:8090 are all fail.

When bind() 127.0.0.1:8090, inet_bind2_bucket_match_addr_any() will return true as tb->addr_type == IPV6_ADDR_ANY,
and tb is refer to the TCPv6 socket(:::8090), then inet_bhash2_conflict() return false, That is, there is no conflict,
so bind() succeeds.

  inet_bhash2_addr_any_conflict()
  {
	inet_bind_bucket_for_each(tb2, &head2->chain)
		// tb2 is IPv6
		if (inet_bind2_bucket_match_addr_any(tb2, net, port, l3mdev, sk))
			break;

	// inet_bhash2_conflict() return false
	if (tb2 && inet_bhash2_conflict(sk, tb2, uid, relax, reuseport_cb_ok,
                                reuseport_ok)) {
		spin_unlock(&head2->lock);
		return true;
	}

  }

Fixes: 5a22bba13d01 ("tcp: Save address type in inet_bind2_bucket.")
---
 net/ipv4/inet_hashtables.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7498af320164..3eeaca8a113f 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -830,8 +830,8 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		return false;

 #if IS_ENABLED(CONFIG_IPV6)
-	if (tb->addr_type == IPV6_ADDR_ANY)
-		return true;
+	if (sk->sk_family == AF_INET6)
+		return tb->addr_type == IPV6_ADDR_ANY;

 	if (tb->addr_type != IPV6_ADDR_MAPPED)
 		return false;
-- 
1.8.3.1


