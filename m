Return-Path: <netdev+bounces-281001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Ia5BgGH62lBNwAAu9opvQ
	(envelope-from <netdev+bounces-281001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:06:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 727BB4607EC
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38006300C024
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A92848AD;
	Fri, 24 Apr 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ea9yJbyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFD281369
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043024; cv=none; b=XgeNAVlYEoT4jhEljUtsaRMDzgnHGjN4JaZ9DEMh4qMSQfscoah2bZKrm0yo2vN6kRcuQkM88t6yF1cLxKhjJweISNwKPWcuEF6kaCDKlyj+4iJ352atmfkR8vM8qFFXGPhzAKKQnJZuocF4McQbcqC6MLzHsyrtsMYzLoyLvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043024; c=relaxed/simple;
	bh=sam5CzX7hUFWo2rSuIUY9jL5rVRI1ZwRvCUUTaLpc/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYWXTzcbUJ06AFn4ZzK2kIyUZoIy0BdBWPtQtWhjgoyRN3VCtb5jaEpbtBOj5jBZKI/d3S3b1yvyPx8kJgvZSn6vVWNtxJNEN0mPC+wNC36WuRDpnVHUPpLeSq9I/olfyQA/w8UNKc/E/jOpFtFNPmckcfjk5ctBHxwNFuScl7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ea9yJbyH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b24fede2acso52973695ad.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777043023; x=1777647823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=Ea9yJbyHQe82ThmrdwNs9z9RSGsQMh08rJfRXjLI0A/EKGyvxSHOcseDdXM8enl6aw
         ZTTE4RgSUOgs28it5Xj47AdbqXFfnfjxTjCqoSLHoLDWCLF/gzepeIxoT0C1I4ew68i2
         C7W1+PsA1CdnUczpB3Ux94tUjJNRv9qFeQUP+lRHljHIuAH9dwb8jrIZa7sIOoOsTAEB
         l5QVAHuVcUimynAFtMPqEnNnaUiWDQSj3tYB9gw4UYAVW7nwpuWLJ9fJyZ6U938PL4aj
         gkheKpepmyTGJ2zQulMx4AkRR1XobfJbzNnYZOPr0m5KLLgIlst2xk2VxRuZdQ9GoIn1
         9M8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043023; x=1777647823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdnOmdvYkq1xF25fAEazaVF6DIg+bGDl6V2EYI1zKDU=;
        b=JioczUUXbIGdmbWDSlY4mQ3sHpICNyKE1gcQaMtt/abNoEKIWpBpNYEAFeX0fjbhhO
         W7Q8BsVIStbunnmx5NZinZuF+Jl1jlkeOHTb5CPA5O/m+PYLVuO/xYqYLkQc8lS4obPQ
         JQNfI5BQh4D66+YXbiVshxGR9VWMZcxe1rPf3L87FBQmnR96s4MY1pariInXZ14A0/0k
         JVlafXmQvdjKVRlTxnhpaGWO6EoCWXS/dzU/2Hrq+eSyh98OYqbAgTFn9Pbq8le6DvRC
         TSAGgW+maSHe76TU3X+M4m3d0j55gG9rRG0u3G3PL0P8a4wCOMLRPEnV5+lmWNsbMWBq
         IxaQ==
X-Forwarded-Encrypted: i=1; AFNElJ+nUyBwUVYfHnLZFIQNsEKVI+WOP5SsO0byJipAW6qvNkqqUqqZ1WQFejtNHCRY0XIwvZXiE14=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIPeL2y1TrqxkKSkT08NavlGn+2naoKt+3cUF0sf3JL05IPYw
	06W+PSKW2udow/2TYJeyT8nyDAzspt42zBnD1xQZLZWC6KttO9PhunFc
X-Gm-Gg: AeBDieuNewCOr+eTeECadWm8Q9uLUh1aYJ/TE8CB5oKN8xDiMSMm1EpzUWOMN8fqQPI
	3N9etBiFGpvA+3kqVqICKhwvMxUFlNrRTLwejw20assMju8qAVRF6RLG2OXsQq3UlkEcEZXFhgT
	MnhlEGrrJsVp/p+uM3Qh0Xmx5eRvLecoPiOqsIOBflEe0j1hxDbASGsoFdWeuXGTqBizBLgKZDe
	KEZh34GrdmDIRxj9gUmlFMVtVxlYOI02gE8WG3vM5dEFIajwDjncC6j1bfdrZXY7Fs7ImaB+o9m
	fYRX6Y4ARASQypAFBzeiqKLNyenlk0xQN/2BGjgbBtNOU6II+mU21C28tIMQmNpfv+XJpC0JUkJ
	nqrH3sA+QN6wi+jg8TvBQq87XdJZvGXOKxPaZhqmj8KxVELgtO+MzG49Qr9r69+9Xu5IsjdVYND
	y6V8xahQ1w63FuxGxWjoFyarHH/VSNw4lmnztB+q3+CMb1UoCyNFjA/Rbgcs3N7yaJ09E1wIowW
	81RZIs43AciFXL6
X-Received: by 2002:a17:903:286:b0:2b2:680c:2193 with SMTP id d9443c01a7336-2b5f9f64affmr349377755ad.31.1777043022350;
        Fri, 24 Apr 2026 08:03:42 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:ba99:851:d885:8271])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab4cc47sm233257465ad.82.2026.04.24.08.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:03:41 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stefanha@redhat.com,
	sgarzare@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen()
Date: Fri, 24 Apr 2026 20:33:10 +0530
Message-ID: <20260424150310.57228-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 727BB4607EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-281001-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]

Two bugs exist in virtio_transport_recv_listen():

1. On the transport assignment error path, sk_acceptq_added() is called
   but sk_acceptq_removed() is never called when vsock_assign_transport()
   fails or assigns a different transport than expected. This causes the
   parent listener's accept backlog counter to be permanently inflated,
   eventually causing sk_acceptq_is_full() to reject legitimate incoming
   connections.

2. There is a race between __vsock_release() and vsock_enqueue_accept().
   __vsock_release() sets sk->sk_shutdown to SHUTDOWN_MASK and flushes
   the accept queue under the parent socket lock. However,
   virtio_transport_recv_listen() checks sk_shutdown and subsequently
   calls vsock_enqueue_accept() without holding the parent socket lock.
   This means a child socket can be enqueued after __vsock_release() has
   already flushed the queue, causing the child socket and its associated
   resources to leak
   permanently. The existing comment in the code hints at this race but
   the fix was never implemented.

Fix both issues: add sk_acceptq_removed() on the transport error path,
and re-check sk->sk_shutdown under the parent socket lock before calling
vsock_enqueue_accept() to close the race window. The child socket lock
is released before acquiring the parent socket lock to maintain correct
lock ordering (parent before child).

Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Tested-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 net/vmw_vsock/virtio_transport_common.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 416d533f493d..fad5fa4a4296 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1578,6 +1578,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
+		sk_acceptq_removed(sk);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
 		return ret;
@@ -1588,11 +1589,19 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 		child->sk_write_space(child);
 
 	vsock_insert_connected(vchild);
+	release_sock(child);
+	lock_sock(sk);
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
+		sk_acceptq_removed(sk);
+		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
+		sock_put(child);
+		return -ESHUTDOWN;
+	}
 	vsock_enqueue_accept(sk, child);
+	release_sock(sk);
 	virtio_transport_send_response(vchild, skb);
 
-	release_sock(child);
-
 	sk->sk_data_ready(sk);
 	return 0;
 }
-- 
2.43.0


