Return-Path: <netdev+bounces-190609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B86BAB7C2A
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 05:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C5E7AE77F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E3A33062;
	Thu, 15 May 2025 03:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="IA10/sBn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72B21A28D
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747279178; cv=none; b=CjeXlgJYuOKC8v6BhLMCMSEWkAR7CZFa/uUyK6GGVVPKzR0rIapHeAAV4LZxCaR13TSVjUvNn8JsBkTp+qttus2RAUN7BR9NPrj6UwpeOvAUyJxeiRSInuFlP5SLUs21EjeSb2hM95E6QvQfauvOxi83ioTaoP4jUrazbsZ0d0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747279178; c=relaxed/simple;
	bh=RGsz8GUJyHumLz/zlouhynrVpH55+CmE0b6I6wej3z0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIWT2ZYYZsSFrVtsy6pdbG9DF7ChF7ZDRSGIuz+/63P1k3pocJoHvolBKgLLm5QER041+QtwZ1FGZnkQvrMok5NRQ0SPq2sn36dpeXbDOMkWmi3NRnZ7TCZ0h/N5cMTDQPt94sN81o8ZKdWx5SeGrGpEzDobx1Md/ift8i1oLIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=IA10/sBn; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747279177; x=1778815177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MJIl/Fbpb6rbw7iZdOYCGVj0nEPI4n7g27Uv/Js9GKQ=;
  b=IA10/sBneagIfls18q7ntt5xuYzUzdPRuLRgjcQ0+wj9ZkmgwAsBXRLe
   26w0mnOt6UEVuS9L6KBLt5SaTUh4EQ2bt8E4dWXOlPNZpRPbt93vfpihE
   dZ1pw/fLP6Vm8SS57eEnFjZGACcihTdzKAqQeJrYlYGpK7XPaUEk+3WxD
   KuEVYQmFGulvKEeOz1nnDZkD0UWOFylHL16aBxrKV5t9WowWs0Uysj8VC
   9uRkJRIonMcJv/PTmE4NI0RPb+ZN++vU3b/ZoBBkxqZZaxsmH3niGHPQJ
   rOftYd470j1OVqBzQlR9BX0kEMlwJjwc0AY5pg6o11gI1nRdxZuYlO2dT
   A==;
X-IronPort-AV: E=Sophos;i="6.15,290,1739836800"; 
   d="scan'208";a="490155843"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 03:19:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:35269]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.148:2525] with esmtp (Farcaster)
 id 4f0fd333-3269-4819-a218-68ba0fb9c37a; Thu, 15 May 2025 03:19:32 +0000 (UTC)
X-Farcaster-Flow-ID: 4f0fd333-3269-4819-a218-68ba0fb9c37a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 03:19:32 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 03:19:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v3 net-next 6/9] af_unix: Move SOCK_PASS{CRED,PIDFD,SEC} to struct sock.
Date: Wed, 14 May 2025 20:18:47 -0700
Message-ID: <20250515031921.28817-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-7-kuniyu@amazon.com>
References: <20250514165226.40410-7-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Wed, 14 May 2025 09:51:49 -0700
> @@ -523,7 +528,14 @@ struct sock {
>  #endif
>  	int			sk_disconnects;
>  
> -	u8			sk_txrehash;
> +	union {
> +		u8		sk_txrehash;
> +		u8		sk_scm_recv_flags;
> +		u8		sk_scm_credentials : 1,
> +				sk_scm_security : 1,
> +				sk_scm_pidfd : 1,
> +				sk_scm_unused : 5;
> +	};

The bits had to be grouped by struct, otherwise the compiler
treats all sk_scm_XXX bits as the same bit :S

Will fix in v4.

---8<---
diff --git a/include/net/sock.h b/include/net/sock.h
index 0268c28538a1..f17a82d93e5f 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -531,10 +531,12 @@ struct sock {
 	union {
 		u8		sk_txrehash;
 		u8		sk_scm_recv_flags;
-		u8		sk_scm_credentials : 1,
+		struct {
+			u8	sk_scm_credentials : 1,
 				sk_scm_security : 1,
 				sk_scm_pidfd : 1,
 				sk_scm_unused : 5;
+		};
 	};
 	u8			sk_clockid;
 	u8			sk_txtime_deadline_mode : 1,
---8<---

