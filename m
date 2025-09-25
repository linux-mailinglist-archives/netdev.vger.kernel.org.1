Return-Path: <netdev+bounces-226552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1849BA1E38
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 00:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACEC23B7E07
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 22:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53E02D837E;
	Thu, 25 Sep 2025 22:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p+lBJp33"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DE9291C13
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 22:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758840558; cv=none; b=Mmr5oIvcMou29HUPK48MT/B5EFddlm9fVMoDY+kXz3kqH91B/SenuIW4x45mbE30LaMi+gu4tvu40mxgkW0k89+Mm7cXo8lYZNXcoFfWBUoiws3Qu8R9RXKsrNXAtaIemGUVweizxKTodRAQBt65zIvNNVLhPocEVwpqQ37vp7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758840558; c=relaxed/simple;
	bh=yvaV/IhV2Mbsq//ng46tFPRIifzd7hkUJkqFbkwZLHQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=toiLJAtgeihURnAwuJ6lb9lUgl4qGDPwi5n9wdquAXSKJWCKqAYyORUo8oRZKgaB5qTNjB5pMPkiVKKYcoVOVwOK3dbjD7QWsxZiRAkM8etph17uKTGtk+blglb/d8kPV4zawSJoNzJziNRVwO8XWiXnRfxHe92u4L58tCDnZWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p+lBJp33; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4ca8c6ec82eso35101661cf.3
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 15:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758840556; x=1759445356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HXqtc4Y27FIHoOkI+0t4LhyaWzhpXXRU/L0MKE4tcEE=;
        b=p+lBJp33Jh2QqTdJt7UFmn/kMenVNwUZeiIyXvZ8EIe2bf2ShyJWSb4O29IZapkGai
         tbznyAdEdxtlcQBfpqHcAIy4Id838ECnzyHwpaNqOLQdedGGCNCqT0Gad/kIu+2im/qw
         jtlWzHg5lVWL0xZjj7ozzznq3iGuwZtPZMsq6+GUZaP/79Fxw7qjZvPzlBlVu/34v6CZ
         VtOwrQ5dDgbVnNBgB2GB+5ZXlc8726qsaZrWJzB8ZHSvT5BRnV/96QHgNLUu6eo74jmV
         AKPOznCgpphEVVabDzFTIx9b8sZ6GyXWOEqp9CcOEmXqEu0pG/mcjhsefX8eFTV7CAcW
         kTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758840556; x=1759445356;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXqtc4Y27FIHoOkI+0t4LhyaWzhpXXRU/L0MKE4tcEE=;
        b=Zkit4VIG0+qJJDCPq3PSVdPOKrR5CjZVmJ/MnNsYDdaDloBA2xvpK3OVEjOCSMo1P8
         9V6VIDEBfkPrN5YsRb/biRHkHKRkLvOUCkJyUvtzrc1vM6oop9db4tUOpT8MFvNPaA1g
         N72RZHgewSJkzgbWUWomLVGprvMLO6QpVm84D1X01IwkPuLfPdsNzVoW4j+/fDhrxAqT
         7RSNf55YJISTCTKtpA99CWVcIsOiFJHmdhEwxom5ixJzBfoIcMxXvRNsly6lSrse84KQ
         EBGuizsuuyOfqUpw6ChCF0J3RauN0K6gn+s1MQLXSCPTd9Xl9zf7QGOuyWcXMAYZm9lg
         yXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUbAyXIODq1kJ+zrq3EjnatofTyJ4/mRBObhS299AtbqLPo1RQK2uylOLqBCYJwu2BvJBVFcL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXsmfjcdoMrYgLqn/IPnlbd86oPpgIKdzbrQAmfxQbpZ2KGYaP
	Vu5CZcrzqNzpJMBcSehZsD1DY+ZTHHHHe5uk512QrhKK6gDTCgJUOnhskc6189gKidzngJOzlwB
	rROD555zVci0LUg==
X-Google-Smtp-Source: AGHT+IEngZnsi6cMy6oAiwU1ezmd2/4o2m6oydvlQFYaY3K+PJHeYflnKtYNkl0zEIL0qbWHJHeIjF0Ral9CFg==
X-Received: from qtnz8.prod.google.com ([2002:ac8:4548:0:b0:4ce:12a7:aaca])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:758d:b0:4dc:d013:5b5 with SMTP id d75a77b69052e-4dcd0132d3cmr20018251cf.73.1758840556234;
 Thu, 25 Sep 2025 15:49:16 -0700 (PDT)
Date: Thu, 25 Sep 2025 22:49:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250925224914.3590290-1-edumazet@google.com>
Subject: [PATCH net-next] scm: use masked_user_access_begin() in put_cmsg()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the greatest and latest uaccess construct to get an optimal code.

Before :

	lea    (%r9,%rcx,1),%r10
	movabs $<USER_PTR_MAX>,%r11
	mov    $0xfffffff2,%eax
	cmp    %rcx,%r10
	jb     ffffffff81cdc312 <put_cmsg+0x152>
	cmp    %r11,%r10
	ja     ffffffff81cdc312 <put_cmsg+0x152>
	stac
	lfence
	mov    %r9,(%rcx)

After:

	movabs $<USER_PTR_MAX>,%r9
	cmp    %r9,%rax
	cmova  %r9,%rax
	stac
	mov    %rcx,(%rax)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/scm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 072d5742440adae36757592c102657a9a93391be..66eaee783e8be8ed650a1679a15d0a41309f9f0d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -273,7 +273,9 @@ int put_cmsg(struct msghdr * msg, int level, int type, int len, void *data)
 
 		check_object_size(data, cmlen - sizeof(*cm), true);
 
-		if (!user_write_access_begin(cm, cmlen))
+		if (can_do_masked_user_access())
+			cm = masked_user_access_begin(cm);
+		else if (!user_write_access_begin(cm, cmlen))
 			goto efault;
 
 		unsafe_put_user(cmlen, &cm->cmsg_len, efault_end);
-- 
2.51.0.536.g15c5d4f767-goog


