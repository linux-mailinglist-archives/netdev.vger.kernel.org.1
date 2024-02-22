Return-Path: <netdev+bounces-73936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBD85F616
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06E88B2524C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81474597F;
	Thu, 22 Feb 2024 10:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="txcTRq/k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201513F9F5
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599033; cv=none; b=PxlBQ0Q0XruVWse5j3DxqqhVjaLmXfxjqhXRBje+n9FaTtcmxa/ufyJx0CizFKqDhPVdIT31+xEweOh7AxuBtZo9nu0GIJAujrrXSV/i9/hHogrpHt0R2cCbvG2sgaiPlMznUjHj9IJbW9CDhLRakeDvRU2WYSSfTGu/Zmc20DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599033; c=relaxed/simple;
	bh=lwNIvZDZLExwPjBTRdtAdUNymQznBK3uysM53tCYtAw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RdcDA6AHYf+aEfQlF8UbzXReW5NcxpaocCKDNyeHMyAg/UJKoLMPDpf7codQ27B98bRWPIYUBfFHXfkloUQoPQBxNSbudgQA+uOpM7F7ve/NZb2AZLW2Nl5tLxX9hL8dlXxzp2mUCTrhiN2mPgdSza+SBINy+Ah4nCtXCRUOdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=txcTRq/k; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7873e819853so655736385a.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599031; x=1709203831; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=002344eBGzEWpuOidpRheP4s8jUhv7SoQO5BKVmyoIY=;
        b=txcTRq/k0MTR6vEbpvrbiOmB4pXe6E28TCGElS/Ei4b/NOSg/JBjZTFedv4JRUP/FM
         cpqVZSMnMQz/DjEknFhyZfjuU1nuNPCDuQQw/99tgw30l298zvirZCToK5gHzn1r4nTk
         1shXs8M+yCB3hwMWmAU8lZCxWbnyOKy50UyZ9ParW1i1LhMF6qYMbSt/C/rIAosA1Mqx
         dZ43HxfW8Vqi/JPUNKKF8JtKJx4d4GlNxJnaOmQo8hEDUHztfMQM3vssI6SMug4H7gSJ
         8kOxtooYx3Cx+U3NWoSK/goesAuuncgkRlOWjpz9XmEN6dfs2vofjYUZbs+U9NIsTCgz
         bQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599031; x=1709203831;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=002344eBGzEWpuOidpRheP4s8jUhv7SoQO5BKVmyoIY=;
        b=e+wY4YeI+FAukqsxgGWMoWYQkw6fhV1yEii6nRjFYpJ7T8Oyc07ZJGu9YG4ZpYAcwU
         SVZHv8rDhPhLVlZGjAnBYfXpv5Nh1OLXtFVmSRKpX8n+1EmA9RG+kV04MKpQxjkAz/Oz
         3ovE/Lri/y8yrmWEh0w73fXhXliQUEXQuF4hjicUGKg9MtsuehXoKZwZANcXIO//fUpt
         pX2plzY1SLWt2JAv2tA4MmlF/x4DGzA++BC2eMxyZZ/Tbj3y1UbVqxIIW5a9nh0oTatw
         +REZRdRDgrz+HewVjHYJml+o4bsoRjz+DKsJJQo3J7MgD9/5QMFFNFpUoc0qS1F1E+6A
         +1aA==
X-Gm-Message-State: AOJu0YzWoX0I09gdZw7ms595awOMqQLKArnORN5IuKalPBQE4GaqWXfs
	vT9Nk+7nXC5Yc0mml6mcWUK6fXDWoggy7EqwLt+NKI4Mdp7ea90TufszHmMMJQVXBLH9XDN7R74
	BdSAUrgS7UA==
X-Google-Smtp-Source: AGHT+IFWrIXUs8jnFjXgyOVCcxe5uojFZ3J3MgjU2sNy55yyQ3eB5Zyhh9sWntenk7D0dVqsPkiIyrBEj3Rf0Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:2850:b0:787:3fa6:51fd with SMTP
 id h16-20020a05620a285000b007873fa651fdmr133700qkp.8.1708599031058; Thu, 22
 Feb 2024 02:50:31 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:12 +0000
In-Reply-To: <20240222105021.1943116-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240222105021.1943116-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/14] netlink: fix netlink_diag_dump() return value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

__netlink_diag_dump() returns 1 if the dump is not complete,
zero if no error occurred.

If err variable is zero, this means the dump is complete:
We should not return skb->len in this case, but 0.

This allows NLMSG_DONE to be appended to the skb.
User space does not have to call us again only to get NLMSG_DONE.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netlink/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index e12c90d5f6ad29446ea1990c88c19bcb0ee856c3..61981e01fd6ff189dcb46a06a4d265cf6029b840 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -207,7 +207,7 @@ static int netlink_diag_dump(struct sk_buff *skb, struct netlink_callback *cb)
 		err = __netlink_diag_dump(skb, cb, req->sdiag_protocol, s_num);
 	}
 
-	return err < 0 ? err : skb->len;
+	return err <= 0 ? err : skb->len;
 }
 
 static int netlink_diag_dump_done(struct netlink_callback *cb)
-- 
2.44.0.rc1.240.g4c46232300-goog


