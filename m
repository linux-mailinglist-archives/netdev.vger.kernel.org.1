Return-Path: <netdev+bounces-245142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E10F3CC7FA5
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015E130EA290
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 116A534D4E3;
	Wed, 17 Dec 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGnsDQXA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B734DCE4
	for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765976281; cv=none; b=KSxF/p9wrn2UuQeKRfsrv/pE9w8P/bSAjT7p2V+bDqi/G1tSvwRkVgC+Nuy72NkvIaw0EDZIdGgOqSncu74d9P8aK/03QyDH8Qlifa+uAM4xKvu0Eb6cSIjRXaZCfGjxCywBK4w5YcvNVAXw4Xg8dTl7H3TBjho5+ZkCvVuZST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765976281; c=relaxed/simple;
	bh=JR4+kJaBlmpbY4kjmuT+WtD5sCcuiWQvS1lbYm26OEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fz4jFGLGDzWw3OL4Ucbq9lBqxXrx/MBk2vaJd5V6mfKnu9nGNQIXILvNUCVb0jit3hAj/O1i0Kq6m3iUYiJpbJ4ZyEJUFjJWSg6ebUEAWdRCCbKbSlih55QOuFmsMVIVhssEbcHXQQyqHYYstsEfPNhehpYNBVlpTb5paRdURno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGnsDQXA; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so374123a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Dec 2025 04:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765976279; x=1766581079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=NGnsDQXAh6iw+EUoYkWvRRhp9aYu8icQkynwWnGh4a+pf1/Rt6P+GW9JVDAKtPDGJO
         gbBvgnsUsf35lp/QxcpTeauUDa7gz2a16pdAAbPfkmEZNOQlZ9/zdu0WMpgntfd2rz7w
         gdhHXo9n93mxq8Smv6NtrXh91Dieas/ndTGJnS9hWXOeSavmR4W6oRcKgTzDZ969Gl9Z
         jf1TwL/GHmzvbknaOnz5qy61Xx7QCFlF3hg/05SCKDYyNqfjdxMnja5EQ+EeBp2mP0sv
         VrWiwYwHN2/SiYp8dlQyGsa0SevLOeLSriLH1RWUYXmiAOvi82e1GVEZMeLrBWftk1W7
         EDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765976279; x=1766581079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3j0D4wFBpoCqxcj3+92dqkBBHNQldTemKoyK60bvQY=;
        b=fBahEkZYhGbrCDjVIwlwoQKn6iLsOgtciN91XX6kKZtKXj0cew1o8PBMjjEZamg9RZ
         iRKgvOIC5CarvaMszMbkdgwMlQMEAaZD78j9+IWJbv/uURLeuAYaasXVBEr0YEOV8r7Y
         2LGISi7x/Z7dBmtePoAm+W9OkypdlE8JdSvHW3I9Q6Gq+cYtdcjFtNoCerH9Q6BRowVv
         v99wkPpTWXdodfgTVGHNuNDTbr5ON9awNorAoj/idfEdYU8aoshyzNZ7A60e20CeHbmX
         ghMVYPhMgaqdqzQrjLPanlKlYWG4O3q+V7SZoEzwgF4jhNshpWdYi554gbx9zV6XuOtv
         qP1g==
X-Gm-Message-State: AOJu0YwdCTSpIZg1kXyfw+eh1Go79QpO0CdZcxKGzUwp4rWjfobI6jPD
	KWou+YGKbHaXwLTfUZIJDJBcLZ50NsqEHeCffmARhwyqa6tdMrrv5RlMaXSOcqr7
X-Gm-Gg: AY/fxX691sXvWvUM0K9GODJ4lxT97h3GQn7xSWnWx5Gnt4VvUT8OYPpllpJHMM4hKkA
	z6Fit4a6mS3Ednv+rLazgH8pZDpBg4T99uyF+XxA54W3l/KRwyKPCym41n63+2vOEp1h8Lx+HNe
	bNFVff3kKJMGzqTN99cfxI8SWt37cz/71fIDZLVGPPT9ZDx1Ve/fXb7byQzZOa3HidIj/iz2qZq
	K8UcMF1jNP1mQBKcT5aGi4SROk2U1kcRGrefU1MHfrsydz4YvBFf9jfviKOagizTUsLpRctzSUE
	FWK848YkXMToeqnahfeY/h51jyRvqOJ/MH8e3tZBYMpLHxCgTSmJcBuzPqcWKuQCyksWfnnVBuQ
	aUtKepaZWjnSnu8L2tTMtOoVGfzptsW8XAghkdB7+dJ22GQAXt45BUB9IVRlEFCNB9CybCUVQXa
	+rrmbvUVkBBUFWP0zF/0Zclg7bECs+AiLeHobaTa6LvU3rdMKcW1ulNxZmy9gJBXpt2ZaE+JmI
X-Google-Smtp-Source: AGHT+IHeFwiM3NT69mj8CR+qRtoImQENjTvcoKBveMjhuZe4k2Ra/OXcxgpLyAQfJWV1SlZBc8mGVA==
X-Received: by 2002:a05:6a00:2290:b0:7b8:bab9:5796 with SMTP id d2e1a72fcca58-7f6690b510fmr15170891b3a.3.1765976278489;
        Wed, 17 Dec 2025 04:57:58 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fd974aeb37sm839335b3a.11.2025.12.17.04.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 04:57:58 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Qianchang Zhao <pioooooooooip@gmail.com>
Subject: [PATCH v2 0/2] nfc: llcp: fix double put/unlock on LLCP_CLOSED in recv handlers
Date: Wed, 17 Dec 2025 21:57:44 +0900
Message-Id: <20251217125746.19304-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a refcount/locking imbalance in NFC LLCP receive handlers
when the socket is already in LLCP_CLOSED.

nfc_llcp_recv_disc() used to perform release_sock()/nfc_llcp_sock_put() in the CLOSED
branch but did not exit, and then performed the same cleanup again on the common
exit path. Drop the redundant CLOSED-branch cleanup so the common exit path runs
it exactly once, while keeping the existing DM_DISC reply behavior.

nfc_llcp_recv_hdlc() performed the CLOSED cleanup but then continued processing
and later cleaned up again on the common exit path. Return immediately after the
CLOSED cleanup.

Changes in v2:
- Drop Reported-by tags
- Add missing Fixes tags

Build-tested with: make M=net/nfc (no NFC HW available for runtime testing).

Qianchang Zhao (2):
  nfc: llcp: avoid double release/put on LLCP_CLOSED in
    nfc_llcp_recv_disc()
  nfc: llcp: stop processing on LLCP_CLOSED in nfc_llcp_recv_hdlc()

 net/nfc/llcp_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

-- 
2.34.1


