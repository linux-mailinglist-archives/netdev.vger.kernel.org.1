Return-Path: <netdev+bounces-140340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC609B6079
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5BFB217EB
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 10:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4E1E285C;
	Wed, 30 Oct 2024 10:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ArnX0dIz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1B1E32DE
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285321; cv=none; b=gOOCu/9Q/POSZB3WuJ0VR5+cT7iGvL6WbCuhLRd8h6wF3Tkic99axPFoqlKSre0G6hyIRIUF9f1MBPhwgQhnDD0JfoLybcdHyU+B16rU8nM+oXpppMq2ybVo9El8bVxU5Ht7aMAcO1SC0YMw2ZjTOYq9xFIlvcdx29jyNVon8ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285321; c=relaxed/simple;
	bh=Pvj8Kjvl9N+9Fewfg0SfTUEiAgAjE0OlNUHkwxCE41c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hyBDWEymP+0WN3T7St0Vxa/KaY4DQPQrFWXL5btmeaLKbg28AmtU4SWzTUKXq1EVanGx2Mer5AGlkrvk0JgxI0Ov3rg7nanBB49+Gwe+0GErqEsNpYaal1HP/rqdhaW/qRJyhriyFTb0Aqn6N9Z5+P/OfjXfGlFA3AiEamHwpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ArnX0dIz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730285318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Eyu2MVEykt9w1rae/CkawDrbUa0ShMKRyaeX4Ep4x7M=;
	b=ArnX0dIzAkqGMzcjzyhJ2bTNpPxu2f8npIonVRPL80ACVWsPwgD3IVPORdE+lC3eqowIng
	s+O8iOAgOmbuZuX4s1Q+Nk9CqSo5mahJkFRQWE9fLwvnxC3PjOZV1s59bKpM62G74ixFfP
	dMJpMc4OtVYFT+TYAfjc3UYX534Jfso=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-fAI0HfBDMVmteyKD2VvBmA-1; Wed, 30 Oct 2024 06:48:37 -0400
X-MC-Unique: fAI0HfBDMVmteyKD2VvBmA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9a1828916fso92005666b.1
        for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 03:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730285316; x=1730890116;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyu2MVEykt9w1rae/CkawDrbUa0ShMKRyaeX4Ep4x7M=;
        b=NJkAbBHDDt1NvOhwhRcF0X3cm+G+fEAqEmS/S4F6XaelASTqN4KXTNh/TSmf8LBKVq
         8cwEJd/w2RKBSiEiv9CFTy1FZLrDgC8xlJyD0fo9++7Higxzju5wbGzeTvwG0cuvRlC0
         CB9Iht7fYmrYIjy4sMRCaS3OHOCiQlpPCNpbRjFiY9xtyudyLyn0/3yT0U/CUwd2x4+H
         yIq9jqypxW358/e/iWpbFQUoGiw03bNmBpJESJWbk9bmlM7nptK2XAiVQa1urUHWGiiz
         q7Cw06EJKJgNPKeBXS0L1pNC8KK0+ae0+WFP9wc4NaQhD2HoxRiWi/9tljNWdP+nVuFC
         QNeA==
X-Forwarded-Encrypted: i=1; AJvYcCWKojufwcIeO7kfIl6XhSngkhP+evUqObrhnfFdb8Za+JeRkZnd7dypbu47qYsDGuqZbAljcH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEE6x8gM3mx2B2FMoztEWypBiy2HAoS41WuXLeiRPIP7ImDFB/
	bS6HwBvWcHlT8qnUuAZZ+f/G7m6XV4YSAsIzkxX4z+jGUsfH7ZPs9rGB5+I3XKHYjAbEXZtn4WG
	N1jshOeNCl8lrWP6X5FeSonFsawqd9qGHh0rSPl8pNccUvnrtCa86/rDfvDrQ2g==
X-Received: by 2002:a17:906:478d:b0:a9a:f19:8c2a with SMTP id a640c23a62f3a-a9e40b9920amr192440666b.6.1730285316062;
        Wed, 30 Oct 2024 03:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGq8Gbrre41EAAlgW7/PxvavM6X3h6TQKeIKajFcANVfw8aX39AiEdcwMp7UGFX33ps3lmcHw==
X-Received: by 2002:a17:906:478d:b0:a9a:f19:8c2a with SMTP id a640c23a62f3a-a9e40b9920amr192437166b.6.1730285315707;
        Wed, 30 Oct 2024 03:48:35 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f029890sm558100866b.56.2024.10.30.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 03:48:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 3AE22164B37A; Wed, 30 Oct 2024 11:48:34 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 30 Oct 2024 11:48:26 +0100
Subject: [PATCH bpf] bpf, test_run: Fix LIVE_FRAME frame update after a
 page has been recycled
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241030-test-run-mem-fix-v1-1-41e88e8cae43@redhat.com>
X-B4-Tracking: v=1; b=H4sIAPkOImcC/x2MQQqAIBAAvyJ7bkGzKPpKdDBbaw+ZqEUQ/T3pO
 AMzDySKTAkG8UCkixMfvoCqBNjN+JWQl8JQy7pRUkvMlDLG0+NOOzq+0dhet7ZryWoHJQuRiv6
 XI8zBwfS+H6qULmRnAAAA
X-Change-ID: 20241030-test-run-mem-fix-ac835c75ec3f
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
 syzbot+d121e098da06af416d23@syzkaller.appspotmail.com, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

The test_run code detects whether a page has been modified and
re-initialises the xdp_frame structure if it has, using
xdp_update_frame_from_buff(). However, xdp_update_frame_from_buff()
doesn't touch frame->mem, so that wasn't correctly re-initialised, which
led to the pages from page_pool not being returned correctly. Syzbot
noticed this as a memory leak.

Fix this by also copying the frame->mem structure when re-initialising
the frame, like we do on initialisation of a new page from page_pool.

Reported-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
Tested-by: syzbot+d121e098da06af416d23@syzkaller.appspotmail.com
Fixes: e5995bc7e2ba ("bpf, test_run: fix crashes due to XDP frame overwriting/corruption")
Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 6d7a442ceb89be15501069655a51671d6ddfaf0e..501ec4249fedc3d34fe39aff50eea66f82b88a11 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -246,6 +246,7 @@ static void reset_ctx(struct xdp_page_head *head)
 	head->ctx.data_meta = head->orig_ctx.data_meta;
 	head->ctx.data_end = head->orig_ctx.data_end;
 	xdp_update_frame_from_buff(&head->ctx, head->frame);
+	head->frame->mem = head->orig_ctx.rxq->mem;
 }
 
 static int xdp_recv_frames(struct xdp_frame **frames, int nframes,

---
base-commit: d0b98f6a17a5cb336121302bce0c97eb5fe32d16
change-id: 20241030-test-run-mem-fix-ac835c75ec3f

Best regards,
-- 
Toke Høiland-Jørgensen <toke@redhat.com>


