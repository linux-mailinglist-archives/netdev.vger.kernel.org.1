Return-Path: <netdev+bounces-174229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE046A5DE53
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 14:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9984F1899CED
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F82417E4;
	Wed, 12 Mar 2025 13:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Wa+u7SCb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B981482F5
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741787291; cv=none; b=AFklT9o6Ad87ApB2W2+lki1m+BkA6q9IbssRRl6s1H34UqDarYZWXZGY/EF8lgN39Hwz5jq/K6yg0CUVzfoi2MMYFgZ6wrQ+ytKIMDsQIglV11zkpbgc7tAXCK6Ezee+tHQ31JfCxa3Hzy6OSvXgtFM/2cSthb5Gl7fyQdeuRik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741787291; c=relaxed/simple;
	bh=KD9An+ccD5C8XIqh46sRdCeJ2VPqLAg8xm24MZ8XrUs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=bFmYcvq34ozIjQ/bBZIXWkQZXXMxGbR5gAsqFt/IfvDDtIMqpMJkvMpbSc7OjYozSIXherGyDFTtmKWdDiX0h+ZWMTHj3gBrug+Jv7Wd8HI8YJedZ0sjtkP3a8fJe2HAIcnejnvZIrkuLnO/JF333dkqbG+QXDSxO8AqMmhrDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Wa+u7SCb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dbe706f94fso1243177a12.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 06:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741787287; x=1742392087; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C3Du7y9tkkBQlWyFQ8liLPMllQ4ABgjDlEQHju4YfDE=;
        b=Wa+u7SCbbeETsff8BBcrCwF21pudfnDWaO4uFKxPZ4m/mGbXBME/6dowH7ljAgY+YQ
         LwiH+dZT6ZVUnxPaQ0E3bhCO7CiMezwZtlwjzsN117+yx9epcLURgO7nicgC9a3XUOBP
         n+jJlb+8xyS3YgEVECU8FBxINnkNrTD521wzW0CpDjM44QVPvZ1Q+CTIeinbbvpdHuoZ
         /ZtolOy6ioePA0l0ycbWgOM5kOj0lDuYxjoipCvScdNTDRdRY205WtPAwu5wi/DkXixy
         eomLXd6l7yzgzTsPcuuHTOGQPSIUk//Tqp1CrrilDCJpmfxOOVu/YmKnL2JnHMYTks4A
         NKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741787287; x=1742392087;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C3Du7y9tkkBQlWyFQ8liLPMllQ4ABgjDlEQHju4YfDE=;
        b=rcYjONPfrc5QheMhU1zjksgMC9k57/JNXqjKeBO3mJuC6Azq9Uv3eZZ1xNaskyLp0A
         /ppR2JR99QEx6T/fBkwvjaEfoOuGVi1Qq5iY4PtwwAKh6VQMa185PDZAN3XEFQtX062x
         IoaSElipkE81t3NwpnOma0Mgi7fvZW70CoKNXa/wHxsGCzUHkR0Wda5bw428LjNyjmNL
         XAw2N2XSITa5oZe+2exfcJK9yskvWAgPpnoDLd+ljy13yuXZyvN5RJFpmUG89G060yXd
         krGZfjOcFFxpCWoNUxfabh4UhlZRSfuwssX3qEsqI/ssnufJwxMLFl8NOr4ox6Qa48vB
         Iw5Q==
X-Gm-Message-State: AOJu0Yxeqhxzb+FPwqL9cB92qcueznw1W618eoAdjqXI5L29IAgppMYT
	gnxpxp8mLxR5TTMWr/lehWZJOBaPHAKT+gw++UOkrJrsCogPHq0iVN4KDu2XFj/6DKdnb9M6GY9
	S7tQ0HQ==
X-Gm-Gg: ASbGnctyIyh7d1Z/Rz1J8/DOG55JLIV6wJJFailOUpB11k7LK1vahRNpogJV/6NnwdU
	yHVKDOxxBS1p/GrvO07vj7+os5NW6DDmnNOfJAkJ3z5V6uIjTrY5yUks+UM5L7Q12KX5s1RBN4K
	6Tv9x1WF9jOhXp9pFNf8DQH0GkGXTwaGOLQfKW7lsR3d3OOixiPbe9tGykZZsN3qYBmJ+IX2sbB
	t2KxMsMhn8HMFrk1SrQFQeAVZKwVp7pu2sSGbWAovO9/T/fzywOmPVyxW3GvOe4/9p4GgoYg8J3
	gHRCpxvZGVIZrO7my5DpgUFB5/6ja81GNyFFPb1RQedRBPOKSPHFTxVB/v+JmQ3LPYZgvC5Ktov
	nZGflGH47FC5QVrpL86k=
X-Google-Smtp-Source: AGHT+IHQMo4Q99DaO/FiWSlSR/M6/IKyFfEcgyiJibKjhMiE1TMXFUxGcMyxMlljO7KjOuIzzOhWpA==
X-Received: by 2002:a50:9b57:0:b0:5e7:633e:5afd with SMTP id 4fb4d7f45d1cf-5e7634d9d6fmr2868926a12.0.1741787287474;
        Wed, 12 Mar 2025 06:48:07 -0700 (PDT)
Received: from [192.168.0.185] (77-59-158-88.dclient.hispeed.ch. [77.59.158.88])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a960esm9904718a12.45.2025.03.12.06.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 06:48:06 -0700 (PDT)
Message-ID: <dec1f621-a770-4c9a-89e9-e0f26ab470e2@suse.com>
Date: Wed, 12 Mar 2025 14:48:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nicolas Morey <nicolas.morey@suse.com>
Subject: [RFC PATCH] net: enable SO_REUSEPORT for AF_TIPC sockets
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Content-Language: fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Commit 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets") disabled
SO_REUSEPORT for all non inet sockets, including AF_TIPC sockets which broke
one of our customer applications.
Re-enable SO_REUSEPORT for AF_TIPC to restore the original behaviour.

Fixes: 5b0af621c3f6 ("net: restrict SO_REUSEPORT to inet sockets")
Signed-off-by: Nicolas Morey <nmorey@suse.com>
---
 include/net/sock.h | 5 +++++
 net/core/sock.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 7ef728324e4e..d14f6ffedcd5 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2755,6 +2755,11 @@ static inline bool sk_is_vsock(const struct sock *sk)
 	return sk->sk_family == AF_VSOCK;
 }
 
+static inline bool sk_is_tipc(const struct sock *sk)
+{
+	return sk->sk_family == AF_TIPC;
+}
+
 /**
  * sk_eat_skb - Release a skb if it is no longer needed
  * @sk: socket to eat this skb from
diff --git a/net/core/sock.c b/net/core/sock.c
index 6c0e87f97fa4..d4ad4cdff997 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1300,7 +1300,7 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		sk->sk_reuse = (valbool ? SK_CAN_REUSE : SK_NO_REUSE);
 		break;
 	case SO_REUSEPORT:
-		if (valbool && !sk_is_inet(sk))
+		if (valbool && !sk_is_inet(sk) && !sk_is_tipc(sk))
 			ret = -EOPNOTSUPP;
 		else
 			sk->sk_reuseport = valbool;
-- 
2.45.2


