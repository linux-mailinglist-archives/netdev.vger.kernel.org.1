Return-Path: <netdev+bounces-291244-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN8QGEj4E2puHwcAu9opvQ
	(envelope-from <netdev+bounces-291244-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:20:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1075C70F4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 09:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A142C30022AB
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 07:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08337269F;
	Mon, 25 May 2026 07:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppYcIuOM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FA53D1A8F
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779693487; cv=none; b=Hr8g5V+2qpEV3yGZ6lUW2R0UxyYm9wFx0nkN5Ynx3/OgGnxuTSnSPbEaKLZyOCANnyybbRUr9xD5bxbXDqEiP8CO5ghUWR3h9kDI6oIM+Ay2Ju/OjzcjLApM2hM2UUqBxXyto/bpw8qmOwY2ZWynzaKv0p+/N2ox6lbiMl0AC90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779693487; c=relaxed/simple;
	bh=elVZL+cFaEjt0H3zP2/DXuvpO4bj2FRLORne/b3aZF0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/CxV+VH/zO2wNxY0jEbCcVhrUnnp++0aiQD3TJprZoRXDbdD6Wja4MixAxL7GEcOyDq+TX6zyNUPCa+AHJ8Fp7wKDst43L+c6oTGXyp6oNLISKUyduJXyUZPLV16Xr5Sr4aksj6/s8+o2+h+6rf7ZKd3y/1G+daL5lJsi7gM04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ppYcIuOM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba856db1c0so68861405ad.3
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779693485; x=1780298285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dY5VqgEpZOUQ9fXY91xibrPNtOIYayMgpf0o5tFN89Y=;
        b=ppYcIuOMHhHY2N9VZoXpdCDWzhzLXvmVxgrEnokp+vzWJwvxgNG1XEob/Riu6R4rdd
         ducLgXRxxITonUV0VqLvRlGh5WBij1t+HZjOgbSogUj0TApWJOx5QOyJ6fCuFmzcshWM
         GVjvi4IVLumj4KYnFc0RrGQKgZstyPmTAOB1tYanL6dYJtkQYFVVfPd1ZvjcdaehTFhn
         bWRrtiRVf1eyJ6SQArRnHmF7RdhR/VMsOApUJeDAZtnMGGpFsLwsjn1wVZr2I5s4kicP
         dyeg92fsiexSyNLS1kBUMNI3AQ5/ju0hAHQj0zCuTarVnML0PYi3Q31Aa9dytBJN7lv3
         W3SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779693485; x=1780298285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY5VqgEpZOUQ9fXY91xibrPNtOIYayMgpf0o5tFN89Y=;
        b=oG4ZdHFxyLOoNVKNhWbRVJTkvkmhnG6EW3Im0ZdJlRI9f8TaYZ3HP9FR4rNaqwicz1
         QjA0dnLrMn11zu8iOBzCKJtHs9DXv5iYzDJCiOWYtfsVKWmhwdbE1qcKVUvU1LqCeMT3
         A8pOwCm885EUjNMoPki9eApT0hiNkjAms+DAJE85WdyD7ZKvxVOolzvcyhnKsYNnj61M
         g8PsegSHCid/F7i7jJQcAlai6f/ybHK7WS5kTR/VMkMxyOYVmu7mtGOUS7xac10PRoIQ
         aNBD1aCl9qph6icwAxzDG7Z2E7/7Gguuv0d4B3gnsWS05+xK+aa9uzgAVpMqJR9/FpVq
         YneA==
X-Forwarded-Encrypted: i=1; AFNElJ/TYRaxe8RWcdN8KXuVhe5SIIdqby3I6WeccRRZRDFTeht3w4Xdrih8C/diV8jacbY94DC8DOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uhr5DqwWR/3my0c0CNwv6DPvFsD1Ur/VuvdO6ox3bT8bB03l
	Tto0NBv+El8bhPyIdLGkfzMqtZc0lT+TEvXF7Fn2a2YbtuDvdcfcQBzW
X-Gm-Gg: Acq92OEaX0skHV5vSNpdHH2GwTHG95IAYD4AL6mGRrMJySQpOOBRAPxC1LkERrwUqPV
	iBNy15AR31cPhp+qIR01EJnguNeflM9f1xFwebCs8qA6CfEKCjFB5TkcEbGQ1NfQyLKr7tg5vrt
	eYEGF5QEb5rBPVlGrtpZFnkqHPsqdkew81YzX9kk24AAfBVdm+LBwqGaAU7evee+aop58ZBqJZo
	B/UQkAnpwDhA24Q1EsJa+VNVfubME2LqTdyJsRiRiPha69uS/rzPyqomwxBaFvn8NaV2ntJ5y/5
	qXlX0VBvaiGwAt7oHfdGwpkW2604TzEt4ski4t/QwOxdr1zzj8eD0+AdqlsHuSAaxp6Gg09AKym
	/A37AyXs0xJk/dkdnYs7kFH183oVzXDCqS5WRYWvkgX6xzlPqk6IsHzXe6u54NbCHoxha2emEAZ
	Cvq0CJzLM2kzaQ55ysjacQZpViy21VgMy/3egRnGqRtC+G8TXR5gJpZ498QC5e1xGL3+fNAA==
X-Received: by 2002:a17:903:1a23:b0:2b4:5cea:f61c with SMTP id d9443c01a7336-2beb0631933mr154289955ad.4.1779693484605;
        Mon, 25 May 2026 00:18:04 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dba7bsm83293895ad.66.2026.05.25.00.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:18:04 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mlxsw: spectrum_fid: use a dedicated list head pointer for sorted insert
Date: Mon, 25 May 2026 15:17:59 +0800
Message-Id: <20260525071759.1517576-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291244-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC1075C70F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mlxsw_sp_fid_port_vid_list_add() inserts into a list sorted by
local_port. It walks the list to find the first entry with a
larger local_port, then inserts the new entry before it:

    list_add_tail(&port_vid->list, &tmp_port_vid->list);

If the loop falls through (the new local_port is the largest),
tmp_port_vid runs off the end of the list. &tmp_port_vid->list
then ends up at the list head itself (container_of() offsets
cancel), and list_add_tail() inserts at the tail. So the code
works today.

It is fragile though. Anyone who later adds a read of another
field of tmp_port_vid will hit memory outside the list head.

Track the insertion point with a dedicated list_head pointer.
Initialise insert_before to &fid->port_vid_list, set it to
&tmp_port_vid->list only on early break, and pass insert_before
to list_add_tail(). The cursor is no longer touched after the
loop. Behaviour is unchanged.

Same shape as the Koschel cleanups from 2022 (e.g. 99d8ae4ec8a
tracing, 2966a9918df clockevents, dc1acd5c946 dlm).

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
index 4f921bbc1e77..8d6cea43be61 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
@@ -1021,6 +1021,7 @@ mlxsw_sp_fid_port_vid_list_add(struct mlxsw_sp_fid *fid, u16 local_port,
 			       u16 vid)
 {
 	struct mlxsw_sp_fid_port_vid *port_vid, *tmp_port_vid;
+	struct list_head *insert_before = &fid->port_vid_list;
 
 	port_vid = kzalloc_obj(*port_vid);
 	if (!port_vid)
@@ -1030,11 +1031,13 @@ mlxsw_sp_fid_port_vid_list_add(struct mlxsw_sp_fid *fid, u16 local_port,
 	port_vid->vid = vid;
 
 	list_for_each_entry(tmp_port_vid, &fid->port_vid_list, list) {
-		if (tmp_port_vid->local_port > local_port)
+		if (tmp_port_vid->local_port > local_port) {
+			insert_before = &tmp_port_vid->list;
 			break;
+		}
 	}
 
-	list_add_tail(&port_vid->list, &tmp_port_vid->list);
+	list_add_tail(&port_vid->list, insert_before);
 	return 0;
 }
 
-- 
2.34.1


