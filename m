Return-Path: <netdev+bounces-220421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42398B45F79
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CD6F1CC3D53
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47B9313292;
	Fri,  5 Sep 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SiInjCno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516F7313287
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091506; cv=none; b=A5rpjJTrRG25VqLTKZ1LtnIlB0DahZY8/La5p8j7iRMXbHX3cRlMWxU4KAnl6U9ERcyVW6YZjGyYiNFGrR/gnxRHCJJ6k3HecCQLk2SalO8pZ/p+zd5dHjslQQLFiFjSaJWXmbgI/ruVRQpqdc1WqQUQjNwmacc7BIK3tCCcKvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091506; c=relaxed/simple;
	bh=OKSo8eJaN9TMmnjOkBbKiSZMUM6FRoLNJvH8PW78/mk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hx4m/T4+hvj9C7pBDCOKZ3fQdrNBEPluQDLp/SjmLld+es5YmAClPDvwByghdqrYLBvlWzVvBi/snsT5ikW9MHNKhw3DGwWbyOxYCNJKeqTkw3V8j0SXsj2BV7YR3CC+6KZhtNW+F9tE6PPamFTzIydxZHJtaiPHs+BrgQPhACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SiInjCno; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-81312a26ea3so42806785a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091504; x=1757696304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOeivXLLp4Evh1IsE8foFLvK5UTD/d30gi1YNggIGXM=;
        b=SiInjCnorJfPOMoLJfNn6vRVUtKdTZHMaOYhsUHK9VUJ0ZcXh3NK/TKv0wBDi762T8
         eWvVPFrYlqg2vFxqCFPq7LEX8DmQVNIkKxDJeQuo5wvzHFBMb/b7ejGtTTVUnbvNOQom
         jXQhfJ/wTPDpqPfNQ60md+uxh5s6jCMGcmc0uahIuktGgE6J/ubQ8eB7AQz6p+mpBHoo
         xp8Xq0UAIeCqZJNszZGrYOYUSsqEqv6QQypIaSoqRZHncIHkA/CHXsiSeOwL8HWLA/Re
         ti/8sZSuPz3WNCp/GvSIFKp2OdgVMI+ceo94B2fAGFZPrHwQgkPd30p5hKvb1MOIhYre
         Rm7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091504; x=1757696304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOeivXLLp4Evh1IsE8foFLvK5UTD/d30gi1YNggIGXM=;
        b=cGk2RZ2e0bhMhI94KoLS4z4bigcM6r7+McE8LprqeETUCvbvOgIAF6pLt7XHs3lJn0
         B0r55wd9dRQeR0O4HaRRGMEMxtJcu4CvkuYBGAe3igM9Dul+BoSXT8MPmj0g3lElDNZe
         fVMUF1rXw7tH/rwlmlbknd4oQi9nLLljY0JEdMhEa02iF0rdzv2dKtrm3ggetGvrCoCN
         NOJFsTEoBXQGQyA0PnUiRHPyV2BLevWTaTN9VrfaezDHjOEEIzNpwqhjfaR1Uq7GGNCq
         6qY1EkmiERjiCKb4YiSmDNBuo+iqm+j8sHwDso1Ud7FTipcBamoEC5xzpsvbDeFCQjqJ
         zKGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsxVC8EEGdsc7XlxzadZc8qWNh3/e6vG5ERgFGA/tfB3qRBqdONuh/yiun8sDGz9N3tTn+jnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUw8A9ZtvmRuf6A/qwB1FQyF4Sbvpq+qeNiuV98cg9EowjAC5t
	R32Q89JcjLUEUaY+JDsAfzQfcVE+ua7gqnw8s45EKx3Lq7A/12+0kF8Z8ywihhd9f/QoQvea6SN
	Doo4zxqUGHkUg3A==
X-Google-Smtp-Source: AGHT+IGbs+SogdUeHBcUQrmKDwVCd8b52s5Ucxgt26AGGW3q072WKzrna5RH21M/+b3Ho70QVWypKCpoaP8SoQ==
X-Received: from qkab11.prod.google.com ([2002:a05:620a:88b:b0:80b:4507:33])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:43a7:b0:809:7a95:21a7 with SMTP id af79cd13be357-8097a9527b3mr1166652285a.77.1757091504067;
 Fri, 05 Sep 2025 09:58:24 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:10 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/9] sctp: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
	Xin Long <lucien.xin@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/proc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/sctp/proc.c b/net/sctp/proc.c
index 74bff317e205..1ed281f3c355 100644
--- a/net/sctp/proc.c
+++ b/net/sctp/proc.c
@@ -52,21 +52,21 @@ static const struct snmp_mib sctp_snmp_list[] = {
 	SNMP_MIB_ITEM("SctpInPktBacklog", SCTP_MIB_IN_PKT_BACKLOG),
 	SNMP_MIB_ITEM("SctpInPktDiscards", SCTP_MIB_IN_PKT_DISCARDS),
 	SNMP_MIB_ITEM("SctpInDataChunkDiscards", SCTP_MIB_IN_DATA_CHUNK_DISCARDS),
-	SNMP_MIB_SENTINEL
 };
 
 /* Display sctp snmp mib statistics(/proc/net/sctp/snmp). */
 static int sctp_snmp_seq_show(struct seq_file *seq, void *v)
 {
-	unsigned long buff[SCTP_MIB_MAX];
+	unsigned long buff[ARRAY_SIZE(sctp_snmp_list)];
+	const int cnt = ARRAY_SIZE(sctp_snmp_list);
 	struct net *net = seq->private;
 	int i;
 
-	memset(buff, 0, sizeof(unsigned long) * SCTP_MIB_MAX);
+	memset(buff, 0, sizeof(buff));
 
-	snmp_get_cpu_field_batch(buff, sctp_snmp_list,
-				 net->sctp.sctp_statistics);
-	for (i = 0; sctp_snmp_list[i].name; i++)
+	snmp_get_cpu_field_batch_cnt(buff, sctp_snmp_list, cnt,
+				     net->sctp.sctp_statistics);
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, "%-32s\t%ld\n", sctp_snmp_list[i].name,
 						buff[i]);
 
-- 
2.51.0.355.g5224444f11-goog


