Return-Path: <netdev+bounces-266446-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGyLJKPhsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266446-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA87425B9B4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D5C331F1BE5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E76A3750BA;
	Wed, 11 Mar 2026 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRi6CcN7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118273750A6
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 03:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199443; cv=none; b=TZghyjBvJfd+8QSmOabPFJYfMVQ/Lm724c0h+HruHZsHx3yGHiB1itA7YlvLlLWpruAJ60VN4oHfaCkuqsomI/dE0g6xRlg1r8yVweJMN4WrEd5LTz0TJvrk4uBajY9EErVLQTY+o3iYFfRYFMtDY0aSUJljq4iAz9EmrneE6k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199443; c=relaxed/simple;
	bh=4CmlSSsCnPynyh+7RZ4n6Spv5D930upDulXja9oszS4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=t00jv3/+CudTFUytMwGkvbgg0qsdn31kiNKug+wUA6Amoj12JUYUpeh6GmqCKPpz32Jics8x3s/sFoH0TeapGe0bMVN5dNlgj7CzTkUMADP26sL0k1PDfe91fKXwMBRNBQF6hll5KQpsrOV+KvSm7uaqx85A83bZ/94faT421+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRi6CcN7; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-829a9c03780so4491031b3a.1
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773199441; x=1773804241; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7iE5HACLz4Z/RwSO9wFPzeTdq72RimNiWiYc2tOiIgM=;
        b=RRi6CcN7GEfMj4gi937EKxmsYBTK6LGLcTZPo++Z0cRL7XD8qjmrf1hbzn+VmtA3bF
         ZVmABBQ7DzLmyJ2tCHIFfSBo0mq+3HitqXNQ30230ORawWfS5d9pHvMNsiqgm1K8eDf/
         nOA15/vSbpMadVeoOxupDYHW3oGiJ1+/geXTUjndazP3yjXe3MYyBwDVSD8pO383MuR9
         10oTrD+xvHryAFOVG+rfEQbXZBEu4mRAEDCd8taa53HaF502aNr7Bappvw0PKGRmtN53
         J544bmhK6tk6aJwGu0BUi73vBIZ69hHRWu/XH9X8KY8fd6YSJpos9eYoS1lQ+wjr/TxO
         e5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773199441; x=1773804241;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iE5HACLz4Z/RwSO9wFPzeTdq72RimNiWiYc2tOiIgM=;
        b=EeWqqSNE+TI63+135N1mL7wgdljvPxL7D8RbOiSQrdcPx50XUDVljFZHy27jlTsdub
         RqqzErWUGGNpa/VdCerVjeaiTFo/V+2K46NRF1UdMAbizev31VjjthLQTg+mpXDgxElR
         iRlUwUb8qF+pwOXXOCatDCrEs/36t9IAP+hHxH7HFhAXjWTKWsv10sygrgXV2nl+Ws79
         6+m05eDKeY58Uby2jHkYYP5DO+m7EfmFqek3WtowQbKWp/bjV6pDrcDL7rRa2qVk6rMe
         Ylfg6DDAxiUMAqRu8uShf+VxIgyNZtWXUDQ342E2lOG8xEIRpUWHyP7Wi5GO7zECARRC
         DquQ==
X-Gm-Message-State: AOJu0YytTyhVwD9UOmqbHYm/0OJkIUEPXuXJbj7lk1Mawmj9Uhxpjm+w
	Kj668PjzngbD3IWerLymCrMsehGCUUpfo5YkCCAam6kJMahL8nH3Uq6y
X-Gm-Gg: ATEYQzyqcxuXYiTmTJ5iRztYi/i9FHjqS7gsokVFo0c1kzUxMqWXG/OLr3l5qiBxwGR
	V6/rFT5+f9wiD1pnXXOmRz/cQNYgmdvJBY5OmJ+2DEYzR1hHsfAFDaobUvBq2PB3SNOePt7IGbD
	WiQkB4poSif7rh1fOovnVC9cDhxoCXBD910HX8KvTHMjj4XNYyaGQ+pZ/719ONgX+yA+ODVxIFU
	ikQZLNXJAGmDqXMgBkFw8UyZD0rsD7j23SKVR8j/5e9ezeMWZV0jpEw5NlShhAT0VboaGs29h48
	gfTpHkpnskJIlCf/Sa/Idfi2bAsab1QCHo7hZsfaxFsUq5nvxpmX/T3WElcMCeXbaAFGhDJxXam
	6fT7xoBsOaDc9LDocVaqlVfKXn60nUs4YhEtSRptgvrQnD9gV7PFj7Us7mVpOcz/cO7KQx/q+7v
	qhydl7ZJq6634GU0gcj77VObFX0ShXRWngz4Yeo3+S33mcKtKOVNo7R08POmlbE4ctRuxfcP5u7
	HFg0RWY19edNJcDwgkEG4+pElGieDnP6ulQ5+oiVCE=
X-Received: by 2002:a05:6a00:bb0d:b0:824:9848:b020 with SMTP id d2e1a72fcca58-829f70eb4b0mr999580b3a.52.1773199441399;
        Tue, 10 Mar 2026 20:24:01 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6eec031sm704043b3a.41.2026.03.10.20.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 20:24:00 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Wed, 11 Mar 2026 11:22:29 +0800
Subject: [PATCH] ynl: ethtool: remove duplicated unspec entry
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-b4-drop_dup_unspec-v1-1-e0dfa47b5981@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBMarYiuEhHVTDUbFcUIorsnL
 d/i/wcSR+EEg3og8iVJvCvASsF2Lu5gLVQMpjZdbRH12miKPsyUw5xdCrxpQxa7fekNtQglDJF
 3uf/pOL3vB9y7sf9kAAAA
X-Change-ID: 20260311-b4-drop_dup_unspec-2d316fa82d51
To: Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hangbin Liu <liuhangbin@gmail.com>
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: EA87425B9B4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-266446-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,gmail.com,davemloft.net,google.com,redhat.com,fomichev.me];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

There is a duplicated unspec entry. Remove it.

Fixes: 0187e602c03c ("ynl: add missing pieces to ethtool spec to better match uapi header")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 Documentation/netlink/specs/ethtool.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
index 0a2d2343f79a..f47e9e68889a 100644
--- a/Documentation/netlink/specs/ethtool.yaml
+++ b/Documentation/netlink/specs/ethtool.yaml
@@ -306,10 +306,6 @@ attribute-sets:
     name: strings
     attr-cnt-name: __ethtool-a-strings-cnt
     attributes:
-      -
-        name: unspec
-        type: unused
-        value: 0
       -
         name: unspec
         type: unused

---
base-commit: 73aefba4e2eb713cf7bc4ad83cfc9b5d4f966f6d
change-id: 20260311-b4-drop_dup_unspec-2d316fa82d51

Best regards,
-- 
Hangbin Liu <liuhangbin@gmail.com>


