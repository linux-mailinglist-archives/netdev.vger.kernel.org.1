Return-Path: <netdev+bounces-176721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF1BA6BA2F
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 12:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 812471896EFC
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F37223335;
	Fri, 21 Mar 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnNInn+7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556122332C
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742558047; cv=none; b=eNNQDQ0zIL95rGYBoWdNjCywP+Y4NcUxbYXwcyl5DXMZta/c8e+vf0Dex/TUVNqh2/hEx6+MgrpXm45MVmz9DBAXmkwBxxXLUf7SdE92KxZtaFFsd3OPTQo62EjQ4sZrx/Zj4EHjR97LLaUZ0S1wqZ6fG638mZszRhV+ojknhQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742558047; c=relaxed/simple;
	bh=fUyfcu7JQF5lDF+GGfk17XwbuAbPq/fE8E1QzqK7GBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+jsk6tSAB+xwX8ZtOm/nv8h798CN0kbTHdV49P7P0cFWc/Y0zBRM36Sz1957AW/VNyL8EkNXSQEbeLMO4R0f316uC5b6eu502/YgvXPULKGcA4fYamH8Uvc+xA3rweOdJ3h+aJ913kDhaIMIhE4n8RRVm5DlTw9wMy0+br6zuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnNInn+7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742558045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ax0yzd92ySS/YqU6nPgZh27nficwYyRDz3W/JAP2gsg=;
	b=RnNInn+7tUclMRNV4sTviTvSQoRnc65DV+HxTFSjUXm+Mcw2204x9wsiz70scZA53pVglG
	ZQr4quJXfrdNavbW7QptJvvL3tpScm+BC3cJNVKAtIXuOHU9sN0nmwCpQcoAT/TQnkxvyq
	q0Pf2JDsqosrsjdwu/wpGUd5EYWx6zQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-M4e8-ZDTNn6KNXUrvOj8Jw-1; Fri,
 21 Mar 2025 07:53:59 -0400
X-MC-Unique: M4e8-ZDTNn6KNXUrvOj8Jw-1
X-Mimecast-MFC-AGG-ID: M4e8-ZDTNn6KNXUrvOj8Jw_1742558038
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 668A619560B1;
	Fri, 21 Mar 2025 11:53:58 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 363C2180175A;
	Fri, 21 Mar 2025 11:53:54 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH net-next v2 2/5] udp_tunnel: fix compile warning
Date: Fri, 21 Mar 2025 12:52:53 +0100
Message-ID: <5c4df4171225ab664c748da190c6f2c2f662c48b.1742557254.git.pabeni@redhat.com>
In-Reply-To: <cover.1742557254.git.pabeni@redhat.com>
References: <cover.1742557254.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Nathan reported that the compiler is not happy to use a zero
size udp_tunnel_gro_types array:

  net/ipv4/udp_offload.c:130:8: warning: array index 0 is past the end of the array (that has type 'struct udp_tunnel_type_entry[0]') [-Warray-bounds]
    130 |                                    udp_tunnel_gro_types[0].gro_receive);
        |                                    ^                    ~
  include/linux/static_call.h:154:42: note: expanded from macro 'static_call_update'
    154 |         typeof(&STATIC_CALL_TRAMP(name)) __F = (func);                  \
        |                                                 ^~~~
  net/ipv4/udp_offload.c:47:1: note: array 'udp_tunnel_gro_types' declared here
     47 | static struct udp_tunnel_type_entry udp_tunnel_gro_types[UDP_MAX_TUNNEL_TYPES];
        | ^
  1 warning generated.

In such (unusual) configuration we should skip entirely the
static call optimization accounting.

Reported-by: syzbot+8c469a2260132cd095c1@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/cover.1741718157.git.pabeni@redhat.com/T/#m6e309a49f04330de81a618c3c166368252ba42e4
Fixes: 311b36574ceac ("udp_tunnel: use static call for GRO hooks when possible")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/udp_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 02365b818f1af..fd2b8e3830beb 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -83,7 +83,7 @@ void udp_tunnel_update_gro_rcv(struct sock *sk, bool add)
 	struct udp_sock *up = udp_sk(sk);
 	int i, old_gro_type_nr;
 
-	if (!up->gro_receive)
+	if (!UDP_MAX_TUNNEL_TYPES || !up->gro_receive)
 		return;
 
 	mutex_lock(&udp_tunnel_gro_type_lock);
-- 
2.48.1


