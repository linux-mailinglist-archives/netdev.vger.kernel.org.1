Return-Path: <netdev+bounces-280884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPsBGAWc6mnF1QIAu9opvQ
	(envelope-from <netdev+bounces-280884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:24:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CFACD4581B0
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C4FE30215BC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 22:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FE38C2B8;
	Thu, 23 Apr 2026 22:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PILc5M0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B6537B413
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 22:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776983040; cv=none; b=ABo0NhCT/LAlwmsNkc58d3GBRn44ETtyqIHGzimQSxze0CE9Db6YxDSNz2z+4RdAh8iL1Q0KTMDUnW59+vwK47ZNB9yeJ8oF49RF8Xp/zmyXigWpJybTRZ0WM0hkFkg4AABl8xM1Fw7IRbLpRdimJ2MZQv9mHYf/PspScj0QBDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776983040; c=relaxed/simple;
	bh=3MGLOZpKp80lxHgcr23oz1JZfL6KqD8v5+Rx4tNyZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=co4Iv8UHDjGGUATz/CYDKGnDPFHtCHxDweI2Pzv2lQlU4qH1lza18na/QO+7SkzApOIu+66zyRsMsn80DEHsuW6ygx2obM3GYnEXIktbuQDcpwtgV8WCDKvYr7X/GPWiAqitQfBZJfl58p1srQOnDRQvyOekXJyazzp3GKDEJYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PILc5M0p; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9f316d68so32546755ad.2
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776983038; x=1777587838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w+K7aikbu3d3KpiPlkvmM69YJ7mz4TSGa6MsAPjOgyI=;
        b=PILc5M0pbgrhN6l4pclQvnAB5eeLQnAmiai5g89iUdK9+VAz82ato8giJHa/gIMfzg
         bjUy085lEJZZrsoTJ4m9tqm2RZAISQPp9buWSXwmUMbsslYUFeYdsenhjQae4gP/j9Qh
         zQh0Z5I9WmjZE7+1gw0ahbk5aJQqDIAehgHelZZPjwrsELwV1UC3OpU2BjIDcLy1jzqh
         1zyeW0KVk2IANBfqwpHirTk1LfljHDQH0jOs7vNj2nHMscmY5L70VqlFa/EhQXvS0OmD
         EQMhjdv5BBkomyJ4BEUavtQMtpnI4PMvz4NA3PglPLy50U0BI6e9JqYJJPwbchkdM/6+
         /AdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776983038; x=1777587838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+K7aikbu3d3KpiPlkvmM69YJ7mz4TSGa6MsAPjOgyI=;
        b=ICJOZZOKQ8EwAmh6BR6kf0HXI3J2k2AHT1B+a9X+9+8ExKpcwajglJ1Hja2jV/I2Ip
         oUOpuxKFLYOntKGa2vtXnXUBDf/c3Y/7E3AGLlfJ5j/lf2pFbXbb4s/Ew866xKIIUzAi
         2N9x3OPmheogAVbwhNAsLPVkRjyibRG2kEantZ3+Rzq9BnhCHUzcLpRUfDNICIDaxXjH
         jp1yQGMA675Jzs/KCWngGxtPseiidcS/gJoUeXTgPP7NKvSr3VWM1tjaueERtg3+Hpjx
         L6QTGi+KwBiq2tKliwtQCqFSzggqzeQAp8V8hROe2HuY5RPLA0Di7e0UoohT76f8UEVX
         1Epg==
X-Gm-Message-State: AOJu0Yx5CqCMToOAYv6t0zzj03edzujc5QLXPcfz/XG8u15ZejI1irvL
	V3nQeanR+mwkjGx2RPmuA2GgZsw7KuEB3cYID6RuR+DYpgj/qz6d9xST
X-Gm-Gg: AeBDietyp+D6u9E6AiLva6G/drllgXbrVMSUvnWAWnd0+nsyDXQMptGZ0UAnWk+fcc0
	JDB1i63X1zXq+e+slcLiWFSlre8ebzhdLEWpDBAuLobOqPO/xypg8Wn0KZm5+hn2Vs1l83fOhXE
	3mH8qHGUtqy2DNHQ003YWlKcjLtyHL5mP6GUZbDqwlwLulx3uNUBN0YRBBvXKAcGu30EdisT5PL
	uXT1dQPFnVDmuyeE6OKCyk+5ysa8cTTxdeJbgZXWqijUDc/gh9F2d2uvCWpjK73EymJmW/kiXfU
	BvHbGtoOZk6DDSlR1fj4QTlNREwRMcmuXIihF2t8gyW9NNezndRKav2kPLUZiBZqdugoqV87iIS
	16vWR6DD5WnohCWMELg8Qvdb80AWWkSm0+w87jVwe/BkJUJuwj0LWp7glb+gZLPeFgzptjCnzWj
	afly33OJMfY9/+yNjDDxEtOcHAuYQLVRrddgE=
X-Received: by 2002:a17:903:3204:b0:2b7:895f:407b with SMTP id d9443c01a7336-2b7895f4214mr125430125ad.21.1776983038424;
        Thu, 23 Apr 2026 15:23:58 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm201377395ad.9.2026.04.23.15.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 15:23:58 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 1/1] bpf: Fix sk_local_storage diag dumping uninitialized special fields
Date: Thu, 23 Apr 2026 15:23:55 -0700
Message-ID: <20260423222356.155387-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280884-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CFACD4581B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Call check_and_init_map_value() after the copy_map_value() to zero out
special field regions. diag_get() copies sk_local_storage map values
into a netlink message using copy_map_value{_locked}(), which
intentionally skip special fields. However, the destination buffer from
nla_reserve_64bit() is not zeroed and the skipped regions contain
uninitialized skb data can be sent to userspace.

Fixes: 1ed4d92458a9 ("bpf: INET_DIAG support in bpf_sk_storage")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/bpf_sk_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 14eb7812bda4..b50d26a542ed 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -558,6 +558,7 @@ static int diag_get(struct bpf_local_storage_data *sdata, struct sk_buff *skb)
 				      sdata->data, true);
 	else
 		copy_map_value(&smap->map, nla_data(nla_value), sdata->data);
+	check_and_init_map_value(&smap->map, nla_data(nla_value));
 
 	nla_nest_end(skb, nla_stg);
 	return 0;
-- 
2.52.0


