Return-Path: <netdev+bounces-185017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E703A98390
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3163B7B1A63
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CB2749D0;
	Wed, 23 Apr 2025 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAsvJnjw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB9A2749CA
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396752; cv=none; b=E8JWphxj/nSSDZQy/7l8K+WDcYmqWnQv7hCku+UwAOgRERSXDful7k1cJu1Fb3DGQO+hWFksplUt6mGmDVqDPNuSXkv0q5gyaIh4wuad+IlZdAWvUIPmN9mDDwJoS6SFAH9JA0clh8402RTcPBqOQHcXE2WZ7TBTFja0kctwbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396752; c=relaxed/simple;
	bh=wQUGCqIwRiCAJNXe0S9/0jDLS0hUb0JxM7vV3/rRgZI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I16sathtDmXNTQNY0uTKF5LIURZYNrQm5tnC024fITXBngMDPDRzTzKowsR4+lqOzb6FlyG0N78mRBKUUQKDPZbx0KcQ9RtWOVfhBujo97QMC7uGalRGmFLgN49SLMRkLAi6NzfdYcZeXxFL1oJgluAGrIPSZDrev9ZrozlU/PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BAsvJnjw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso50160595e9.3
        for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 01:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745396749; x=1746001549; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cumGuXXvzB6S1IWSanPpei3FWjhooa/wauPws9AXZMY=;
        b=BAsvJnjwzoAkxcuLXHA1BM0GCT/wHzvjFhm8BZeZ/YQzJMPaMBFFDQbnHVFb78dyHR
         CUhalt6fOqeehz5J1vIvEtvGbaurhcd958BHjTRaX32stVNFggwVrm7RX0tba6Z4DyJm
         5p6coI2CS4uN06MHhi/60r9Imerhsexv3HxvinrgcxnPbDqpVyeBEVEkgNEd0O7O7z6f
         lwPzdMVRCTqh8Uo8P5JHkM+1aXxwHYI+cUdJKnZSmHXeFE+gZwDgDtw4o5wM3E9jIQ6x
         wh9V+tC6E26Q+fxEW1UzAPQxjmDUf5+lZdOw7zuMqtzG+B4IuQ4z3LhwCN2Qniyq/IAk
         1uPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745396749; x=1746001549;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cumGuXXvzB6S1IWSanPpei3FWjhooa/wauPws9AXZMY=;
        b=Z8KFjEgKl6zKC8M7BWVJmGOFJrJhVrhavpfCYlJRWrjEaOUgM+Betyok68aXHSf4fZ
         Bhb14Vy/ZTmA3PLBNniiFapTHG1fIL1HlzkCXIllZEYcZ2jcYZOwriB8HKLAcMNBc9j/
         T+dp+0q9zd6uJFwiKQLJ9DI00Ae8fwdBTKa/P8Et0voYoVOanXiNWFn6Jr885/1bL2+a
         2+Uh2XIGR8pynGN+WsQYP7SwjzOnSQrrlN5R+60sqLL2NOP4h3OJT8O8pFnVfi443CMv
         /ijw1V4JmHs7sn/wVilG58nDHX9UxTORKofFnHAYjCpQPlbchjzkssQiN1FqpxnEcssz
         NZsw==
X-Forwarded-Encrypted: i=1; AJvYcCVeCP5rCwd3ZnOmVd8tXYDOF/F47kFpJ9SL52qpizxE9ikRZT9s/ZbzP26S4u9DTXwehx+Y8zY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3//puV50G2eEATty/B93WR8w0VnH7RIrTLTZYa0lw2jDS7xR9
	T2Qr0EcyZIHoIXwDVLVz468n0rh8hAhynxjYjl2qLWqY5UFt9aiSwGqgMnzR7fo=
X-Gm-Gg: ASbGncvNO6j2hvv5UcikQbyftp3n/T2u0Qn0T4YOKmRMT+hA0UKfb8/Yu1uB36hy3aV
	3+/YP+hmuYnmBqKdG33kh1b1ffMWn06YxRwRnOPQgHeIlhaHI24PqFkOR8i9jlUxFmRYZ8BD+0l
	LEqV7FwUEDE96I0kaWeXbT9BSAqJs+mfOdhgaSk+/BzikBMv9nuwSfL/N7SlSu8y48OAzkswcAf
	NOGli7iS/tHItF34ugKmkuLv1/D1rAyHI+Vu4z0wfuemiknxhx58HaoLdGJoOE2GLxNkBaWVsr7
	XFqtpA7UpgjN2VnB5b5opL2MT4sbzpwevNpLUyCTO15B/Q==
X-Google-Smtp-Source: AGHT+IFpRv76nP4pFCeRNrK8Buzz7/miJML9dPdQu84BHUP/kQP8XSQQSLgAkC4W9foMctxFScbIbQ==
X-Received: by 2002:a05:600c:3c9d:b0:43c:f8fc:f69a with SMTP id 5b1f17b1804b1-4406ab676fdmr165779985e9.4.1745396748678;
        Wed, 23 Apr 2025 01:25:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-44092d179cfsm17268355e9.4.2025.04.23.01.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:25:48 -0700 (PDT)
Date: Wed, 23 Apr 2025 11:25:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Howells <dhowells@redhat.com>
Cc: Marc Dionne <marc.dionne@auristor.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] rxrpc: rxgk: Fix some reference count leaks
Message-ID: <aAikCbsnnzYtVmIA@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These paths should call rxgk_put(gk) but they don't.  In the
rxgk_construct_response() function the "goto error;" will free the
"response" skb as well calling rxgk_put() so that's a bonus.

Fixes: 9d1d2b59341f ("rxrpc: rxgk: Implement the yfs-rxgk security class (GSSAPI)")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 net/rxrpc/rxgk.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index ba8bc201b8d3..1e19c605bcc8 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -440,8 +440,10 @@ static int rxgk_secure_packet(struct rxrpc_call *call, struct rxrpc_txbuf *txb)
 		return PTR_ERR(gk) == -ESTALE ? -EKEYREJECTED : PTR_ERR(gk);
 
 	ret = key_validate(call->conn->key);
-	if (ret < 0)
+	if (ret < 0) {
+		rxgk_put(gk);
 		return ret;
+	}
 
 	call->security_enctype = gk->krb5->etype;
 	txb->cksum = htons(gk->key_number);
@@ -483,7 +485,7 @@ static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
 
 	hdr = kzalloc(sizeof(*hdr), GFP_NOFS);
 	if (!hdr)
-		return -ENOMEM;
+		goto put_gk;
 
 	hdr->epoch	= htonl(call->conn->proto.epoch);
 	hdr->cid	= htonl(call->cid);
@@ -505,6 +507,7 @@ static int rxgk_verify_packet_integrity(struct rxrpc_call *call,
 		sp->len = len;
 	}
 
+put_gk:
 	rxgk_put(gk);
 	_leave(" = %d", ret);
 	return ret;
@@ -594,6 +597,7 @@ static int rxgk_verify_packet(struct rxrpc_call *call, struct sk_buff *skb)
 	call->security_enctype = gk->krb5->etype;
 	switch (call->conn->security_level) {
 	case RXRPC_SECURITY_PLAIN:
+		rxgk_put(gk);
 		return 0;
 	case RXRPC_SECURITY_AUTH:
 		return rxgk_verify_packet_integrity(call, gk, skb);
@@ -969,7 +973,7 @@ static int rxgk_construct_response(struct rxrpc_connection *conn,
 
 	ret = rxgk_pad_out(response, authx_len, authx_offset + authx_len);
 	if (ret < 0)
-		return ret;
+		goto error;
 	len = authx_offset + authx_len + ret;
 
 	if (len != response->len) {
-- 
2.47.2


