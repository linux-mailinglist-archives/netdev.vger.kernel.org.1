Return-Path: <netdev+bounces-248034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F980D02D01
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 14:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42B1F30CBA42
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E5548DA2A;
	Thu,  8 Jan 2026 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpcmpK6T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DA48DA4A
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867941; cv=none; b=PII4bwNF/hrWjHtJgusqbKs1jhM+65Il57hkh0BvTnOIyD0tdQNMpkPdFWWxtdC3nnz3ralznslXr7atig0OMXMcUttFEV0nrVTN540VJPI8Vks7aogExmLLfW5XL89YyRgDH3fgYEULIZMTEn+UIkUxZNvDXxR3QBe+ZqvQ5Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867941; c=relaxed/simple;
	bh=gLupk7pkyhMRyVZ4jAeXCwK9ZKuelYKRs+8X67Kj6XU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p4G7G81uBInXTr0R8PpbPDiCT8iqKIVD/ES4/rUYpu5nlUvzkr8xsOdnNLCeRrVa79u8wAcV2sV50YNyRPZPR6hiPndnY2oEapFbp/XFxRWePMWV7Hcwa1tQV3t7mKFd3OVEOMNwlJl26aPgnhFJtPZxRFB1jjlY5nSnuJoxLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpcmpK6T; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-88a32bd53cdso54760606d6.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 02:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767867923; x=1768472723; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=cpcmpK6THsXLqFgOnvtxJ7bqvQNH50LQB6dmNiUb2qrPgDFtXaYEXNXyYlPjjGmn4q
         dqyhrorpb3ykVPlyFMAL/YGUNJycNXZqPfnJScr6UzAvRe2Cs8s25HHN/bE55/WBdB/p
         3KnK/cgz6VA2qypj7CeLSdthm/BJCSPBAtIPEqVcJPNsUeC0TgrzLsc2oDGuaP7qWJ1b
         v/0XJRB+OPFmI/tZZuURSutF7tpzD4a+WBMOAQbYHKr+OEopyYae7Tg2pR7NHs58mDvE
         8Melke5X9XEoy6MntPI6EToY0FwisBw844IXPxHn8Fqeq+uLfKPFtWKahvGvN1YOCyZu
         1pAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767867923; x=1768472723;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ekxs297qQPFSvF26tF3NNktqGOevw+/kYcudT3GgYk=;
        b=nRWAsBa8usBp8SBv+gR53oou2wim9GKQHLOjQ8e11FIrEKfQEeDm5+T6MRPT3A1Zaq
         VB3838tKC3XHaTK2mS1jH2RqLSEzJz76d4JzFhnmtSEtdrJeViU5TuDG+b9zCs0ew1cy
         LL7M5Ibn1VMwA2OGOl3ED13275+tQhZBt81TbJ6gSTq7YlQTGdzTbxRPaqaCQYd/jMWQ
         RwxnBOzXlW/Io77eZxJoV9tJE55MVestaQv5oWSREUkQ1FSVF7w0WJsN2WNQTJz+Qivu
         V6Fyqy43sUHDBavH1/hnh5nluxnkh7Yvi+/FidWOk/L2jdtHDV8kPH8YtpIMiHN9iM8g
         1Frw==
X-Forwarded-Encrypted: i=1; AJvYcCXpZKobTTs9fkHFfPcnEfkh0c9VJuhGuInzhnRlT/JcF6ztK28tho6CDkodcpv05+xi99BYxfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNEigrp/+d+o5jpA/Moo2LjC+2ipgInk/mcfUc+s1dc2TRloMg
	ZzhgyMXWtkRn072btZcMO5y7x7/0WPON3Pc9GIraHOb0itWuyWefWa81cbXsd3ImPqsqAS1JWtV
	vpg1l9MX+jm+9BQ==
X-Google-Smtp-Source: AGHT+IEkRfWC/XeNlNnBAN+U28DwGlu/TP1KYx3zvViGsFM2019wehNzF7LuZKIttyiMh+1R4x5jip1jwcuKcA==
X-Received: from qkau19-n1.prod.google.com ([2002:a05:620a:a1d3:10b0:8b9:f221:4cbd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:46ac:b0:8b2:6443:8401 with SMTP id af79cd13be357-8c38941924emr683726885a.76.1767867575563;
 Thu, 08 Jan 2026 02:19:35 -0800 (PST)
Date: Thu,  8 Jan 2026 10:19:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108101927.857582-1-edumazet@google.com>
Subject: [PATCH net] wifi: avoid kernel-infoleak from struct iw_point
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

struct iw_point has a 32bit hole on 64bit arches.

struct iw_point {
  void __user   *pointer;       /* Pointer to the data  (in user space) */
  __u16         length;         /* number of fields or size in bytes */
  __u16         flags;          /* Optional params */
};

Make sure to zero the structure to avoid dislosing 32bits of kernel data
to user space.

Fixes: 87de87d5e47f ("wext: Dispatch and handle compat ioctls entirely in net/wireless/wext.c")
Reported-by: syzbot+bfc7323743ca6dbcc3d3@syzkaller.appspotmail.com
https://lore.kernel.org/netdev/695f83f3.050a0220.1c677c.0392.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
---
 net/wireless/wext-core.c | 4 ++++
 net/wireless/wext-priv.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index c32a7c6903d53686bc5b51652a7c0574e7085659..7b8e94214b07224ffda4852d9e8a471a5fb18637 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -1101,6 +1101,10 @@ static int compat_standard_call(struct net_device	*dev,
 		return ioctl_standard_call(dev, iwr, cmd, info, handler);
 
 	iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+	/* struct iw_point has a 32bit hole on 64bit arches. */
+	memset(&iwp, 0, sizeof(iwp));
+
 	iwp.pointer = compat_ptr(iwp_compat->pointer);
 	iwp.length = iwp_compat->length;
 	iwp.flags = iwp_compat->flags;
diff --git a/net/wireless/wext-priv.c b/net/wireless/wext-priv.c
index 674d426a9d24f9aab7657d1e8ecf342e3be87438..37d1147019c2baba3e3792bb98f098294cba00ec 100644
--- a/net/wireless/wext-priv.c
+++ b/net/wireless/wext-priv.c
@@ -228,6 +228,10 @@ int compat_private_call(struct net_device *dev, struct iwreq *iwr,
 		struct iw_point iwp;
 
 		iwp_compat = (struct compat_iw_point *) &iwr->u.data;
+
+		/* struct iw_point has a 32bit hole on 64bit arches. */
+		memset(&iwp, 0, sizeof(iwp));
+
 		iwp.pointer = compat_ptr(iwp_compat->pointer);
 		iwp.length = iwp_compat->length;
 		iwp.flags = iwp_compat->flags;
-- 
2.52.0.351.gbe84eed79e-goog


