Return-Path: <netdev+bounces-85065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7232899337
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 04:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D62C1C21C54
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 02:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FD717547;
	Fri,  5 Apr 2024 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQob2qfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676417545
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 02:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712284777; cv=none; b=aTlyOprfkk9TPAlWzdFrCpTS62NU200bVPO4wbMV1WrazakHsc48niW4KO8U9napxhUWsjCEj69O1Zhq8kjx/0YlaBChpo1RMwjtA02ustL/wZQdA8ixiB23Vdc8JT6mUP2KFrNtFgkgymlZYfc9zPB7lJGpJ3P296W1yN7TGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712284777; c=relaxed/simple;
	bh=tTgPHWnpK1ARuYaqryAdkko9C7B0FiHVoFSbYKVwDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxmTwehAVzplwzb5WjtX+mEh7KO1yCgwtsFghjpWHfizyx52mqcHHt2hFeohyVe8sg0VuFNlF90TVHSoO+YS8cv2ZDcN7eVCUDKQ5TeSGCLpFkYak9ug1xuz3QjhxdjSrQzISXzSF706CmoqqpAuQI5Ie7rWm1UDtYli7rfouLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQob2qfl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf9898408so575698b3a.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 19:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712284775; x=1712889575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLePXVeMPfpQzwXoy7NOU9eXP6dijn/e0uzvyqDninM=;
        b=iQob2qflIHrnpFjIqWWmzAc0whYQRck/iAkrMUjjag2lo3/f1pwxeeleVWGsaqQpQz
         tuBYfTHWSNzkk4YRtUw4S55COGAW6j8SSNyL22v+t4IGD8vpN7Cpl6wxt/TnB0rO0PeE
         J4SEUw/FU5ZBw6uW7V0bULZX4PdIUwl3P0FdGpRcdqIlAW5/iLna9+yyuVXGKq+E/EVG
         RHxtSwINUpbgTYqj9Ff0oWuzGIupDT6PfHcDcDM5uYjCjTjpyyIfD8EnDxbFha7hlw8k
         EiNq0UOPgNwtlhgHHPCatXux0zwYpIvWFAn+2+tvRz8seFnX0NXHaSMaRFMcqvnoNeMr
         KCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712284775; x=1712889575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLePXVeMPfpQzwXoy7NOU9eXP6dijn/e0uzvyqDninM=;
        b=TPz4NfK82fdZnOtKC6mCNNsInwkf6AIttt/nLby9d7HY4RAeXbicP1Q+1J+B7a/ZpA
         M02B70/OZP2X6uyxBsSTwvHwNpieQh5tyRTGh9hpCQG+iYrcNNsQk1QSF5Ozq3bFpsiI
         Cwavl2zDbktE6TDDEu9qoCcB5m4v/TByAzo/KF9kUDK9ZpswTt3z/Kl7YYjs8woRo0Fh
         DXN2qrC5fjpT3DYu3o+FquPwz5FgKlElPXX6Ttjfs+dezj+ZfgZWShNKqzqvbhSuKPnd
         +SuD5WBWYGM/TrErrJNooJSco86tsGkm80sFC3ZLflY1lPMF7l6wiJAPPGGEyUaEfwfO
         kI3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzIFW6iZVsQiLEcpkBp29eaot0XNL57Bib+z+grjaP+eF/eptx1kq19PtNDwZWWhyYuPPgg01XUmSnWoeUwraF262UPb0v
X-Gm-Message-State: AOJu0Yy3vi5EiCk2l2FYM9dY5SoMdD49JnmpAOI2NR0xYXTNGfHvMQd+
	mG0OWBJP/omOSreN0KHSrelAvjVQtIKcKyAjAu7vJCMq8XANhGtT
X-Google-Smtp-Source: AGHT+IFgg+Or3iPiTfJ7Gpg6zUuzHOLtW8b/EWVJmICdCHYpjFDA+eeksmR2Rov5q5XFktbksHTv1Q==
X-Received: by 2002:a05:6a20:549b:b0:1a5:6c2c:2db9 with SMTP id i27-20020a056a20549b00b001a56c2c2db9mr1676278pzk.3.1712284775505;
        Thu, 04 Apr 2024 19:39:35 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.7])
        by smtp.gmail.com with ESMTPSA id g27-20020a63565b000000b005d8b89bbf20sm366494pgm.63.2024.04.04.19.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 19:39:34 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 1/2] mptcp: don't need to check SKB_EXT_MPTCP in mptcp_reset_option()
Date: Fri,  5 Apr 2024 10:39:13 +0800
Message-Id: <20240405023914.54872-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240405023914.54872-1-kerneljasonxing@gmail.com>
References: <20240405023914.54872-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Before this, what mptcp_reset_option() checks is totally the same as
mptcp_get_ext() does, so we could skip it.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/mptcp.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index fb996124b3d5..42d13ee26619 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -215,10 +215,7 @@ __be32 mptcp_get_reset_option(const struct sk_buff *skb);
 
 static inline __be32 mptcp_reset_option(const struct sk_buff *skb)
 {
-	if (skb_ext_exist(skb, SKB_EXT_MPTCP))
-		return mptcp_get_reset_option(skb);
-
-	return htonl(0u);
+	return mptcp_get_reset_option(skb);
 }
 #else
 
-- 
2.37.3


