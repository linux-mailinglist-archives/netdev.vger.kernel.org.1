Return-Path: <netdev+bounces-48510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69487EEA67
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 01:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF481F25984
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 00:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE19381;
	Fri, 17 Nov 2023 00:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LV/jzk7X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B201A8
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 16:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700181439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gLq9QND6ayr1x65UPXkRh82Mu4Sx1+2cD2sZ+Ae8qnc=;
	b=LV/jzk7XPLukx1wWFELwh2yiZ/p/CI0YSY5ytm9beQqSSu0AeAxRtpBOGkkDue6PPd43hA
	RBcnOiR1XugoFS6Fr5UOjhwN/6dh5JliHkTI/+nXRaA/P2oV/1ySenKO4UjVaQVm2khSdz
	IdYVfSbg/t4pp45Kdv//NIOTq9h+t/U=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-1LZqD435NEuL-5M1pzEuCw-1; Thu, 16 Nov 2023 19:37:18 -0500
X-MC-Unique: 1LZqD435NEuL-5M1pzEuCw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc281f1214so19464765ad.2
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 16:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700181437; x=1700786237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLq9QND6ayr1x65UPXkRh82Mu4Sx1+2cD2sZ+Ae8qnc=;
        b=iVHcvLNCDP5i0BbQBWHwEFlnqw2vL5ZrhWXKPrcyTVl7y7dq3S30ioXQYFeU5hviSH
         3o8pr7z6rD1jli8a4C8eZpz93vpWdG4tKXaqbGNJr+SpyYKOeQYGjekJhMXGwstVvocd
         jVjnXFsDrsh0TcahNPe5cVGJ2b8wMqjixfbhgPoqMcjpviRVJ+gLqZ5ux4yhAqjZDLUi
         /tVbOX+FAcXH4XT6SG9VLlRuvaGwAjaCyFv4LhAwcqLdzLKECo6hqZuXTgFs+7tnO5iq
         TIQU69bxovd88th7oeXQprP5wGzLvWl9Mi7E7o2miixzhlpCisvzDZlIvGd8iFFJNUE6
         Ptkg==
X-Gm-Message-State: AOJu0Yxni4YCLluI3+RuOQOWtJmfD9EiXYWkNHjrov2su4cFje0btKTS
	RXCQATGZK5vmqebR5K7gTDR1FF8OSqBolU4svO09a9kDe0SfFJCuAV7OL9qRvmtxl5mj3Wk7Aa5
	MQmmraJs5rXayJHzG
X-Received: by 2002:a17:902:ab47:b0:1c9:dfb8:a5a0 with SMTP id ij7-20020a170902ab4700b001c9dfb8a5a0mr9979177plb.10.1700181437142;
        Thu, 16 Nov 2023 16:37:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhqCMmksgqBhmIr37nfnk0at0x9kkOfJxVQwaXdZidniXfUab2Rhk+ksUDMtc+ZNY8tJiIA==
X-Received: by 2002:a17:902:ab47:b0:1c9:dfb8:a5a0 with SMTP id ij7-20020a170902ab4700b001c9dfb8a5a0mr9979170plb.10.1700181436840;
        Thu, 16 Nov 2023 16:37:16 -0800 (PST)
Received: from kernel-devel.local ([240d:1a:c0d:9f00:245e:16ff:fe87:c960])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902a40700b001ca4cc783b6sm256213plq.36.2023.11.16.16.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 16:37:16 -0800 (PST)
From: Shigeru Yoshida <syoshida@redhat.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net-next v2] tipc: Remove redundant call to TLV_SPACE()
Date: Fri, 17 Nov 2023 09:37:04 +0900
Message-ID: <20231117003704.1738094-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of TLV_SPACE() is to add the TLV descriptor size to the size of
the TLV value passed as argument and align the resulting size to
TLV_ALIGNTO.

tipc_tlv_alloc() calls TLV_SPACE() on its argument. In other words,
tipc_tlv_alloc() takes its argument as the size of the TLV value. So the
call to TLV_SPACE() in tipc_get_err_tlv() is redundant. Let's remove this
redundancy.

Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
v1->v2:
- Re-submit to net-next
https://lore.kernel.org/all/20231114144336.1714364-1-syoshida@redhat.com/
---
 net/tipc/netlink_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/netlink_compat.c b/net/tipc/netlink_compat.c
index 5bc076f2fa74..db0365c9b8bd 100644
--- a/net/tipc/netlink_compat.c
+++ b/net/tipc/netlink_compat.c
@@ -167,7 +167,7 @@ static struct sk_buff *tipc_get_err_tlv(char *str)
 	int str_len = strlen(str) + 1;
 	struct sk_buff *buf;
 
-	buf = tipc_tlv_alloc(TLV_SPACE(str_len));
+	buf = tipc_tlv_alloc(str_len);
 	if (buf)
 		tipc_add_tlv(buf, TIPC_TLV_ERROR_STRING, str, str_len);
 
-- 
2.41.0


