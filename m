Return-Path: <netdev+bounces-290903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDNUO6OZEGoMaQYAu9opvQ
	(envelope-from <netdev+bounces-290903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:00:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D635B8B0D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 20:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EB863012C51
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512623655D8;
	Fri, 22 May 2026 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n19aScrf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420526D4C3
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471743; cv=none; b=eulPR8nUsup7KRUiIgLfyOafQEmjjQUqYXvaB3cZiWh0Hgf2La4O/S4b6wuUXoB+iTX27R8vcT8UY48YPlZ0cmqUMpivAvgXjYr/gkeBo2ue0/vhZRfKPQm2pu4nVpf35ZFJok266ScYEPeb15YAGB3m+z3gpGs9mC6fKUS86rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471743; c=relaxed/simple;
	bh=LJw/uzRCeFuBErAPsv2kbea4idSDnIAJ4odAjP9OlwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fcTVJOA2RJSb8G8USHKhMrxgTisNw2YG2h6WjbISopVGat0HWMoZkZ2/nbSAac5IUYj/6oOE7wkXyVm2m4W8sYmfAkrNGrf65EiKIAr2IZpiI0vA5zz+kPtIlPiqzs/jI8tDwt+itDunTTgNP2LvRG3Tavh1fDlhJjds0CBGFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n19aScrf; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-69d7e72b052so851143eaf.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 10:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779471741; x=1780076541; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Chiz5lJEDuUWdjYfXfKI5L1x2C+h2MwB4LLjlr8EAQE=;
        b=n19aScrfrwKBOqr2wwbzTxtWNfXq4ZXyZRbpkh5vGJDByVoG+JimQtyo3oolMLUNG4
         f3hMUhjva+YRyCXqWFEgMSTch3Qsar3ZPw/ezHhzjClBKgDZ3Ez4dZk3HF4xjhSZMQZ7
         YMp7eSs55jXYT5vT5BlXz1zBdRs0loG/zUwX3NuhMHuuaSfnLfcX+iixZ6oIRMQ+FjY/
         V7PWyfm6nkLocQbnYsmTYCsQQg1EGx2wwVmHM+DZrJYqbLq8LTT6MnprY0M9tlCzwLDM
         l9mCWksCgNMoud12EzjKGXwGZ9LZrYQNnAjJRSiCVC0RlTmu/XH16SCPndcc0Wc5mVg8
         zaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779471741; x=1780076541;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Chiz5lJEDuUWdjYfXfKI5L1x2C+h2MwB4LLjlr8EAQE=;
        b=hvtuuHf0VNhOlvb2iMHXkfsvJoYMWzXBf2FnX/xrklBDQjH7toJ00gVMd3xYIk8TV6
         iDYFV4kNAyfa51PtdTvO9Zj7npp9+FzjOpLe4UpvApyK5zJ5c/dzJKftHT4rJ8ip18c1
         YgMKGCtooxeBhGGEVpIuJA63jGRd5lWGh9xK2SMXOwFr5vPa/8InTT4L5m2kXs3uVvV/
         9M0JFgG5kW5BLCvi5u8e7kvLnwFzrVJA1j+rXZIGGMsfioUD667O8/rRl0eUhq4Gv1hA
         59uIeJHwTvhemnecZWgfXaRwfJF42/zX/OzQBoQwvckWjp1s2WMrx22N1FtbMHX5TBkA
         fSDg==
X-Gm-Message-State: AOJu0YwbYS++F3yc808gq3efjj8rDgxLDo4yJQ75pOtN/Sk/1JkauA0O
	Bh+PW23Vq/Mc6Tw8jbXbTPBSXyf+mEIDnGWNuE1b+3Azks/ShXf/rpKx/CT9jItU
X-Gm-Gg: Acq92OFYsyQlAtznqpyEtyfYuR3gP1OIjKUTHKuB5y0SMvIpSSmh3u3NRo0BuRa92Ta
	Ca7DCwtA9OT1GwlKhl+4Ed17+f8PSxDwMXIq5YoDsEzQj0XO6IYp6cQ1ZVkptlHOEnAUnt3dMEO
	sa9Kl11Q36Xp0jZW2ljuX/acXbuoB4L8fKqQqcmsltUW5EOpnf/zGdeYfMrkztQvsD/5niWNuOl
	pP0Sl6uENpzAjsYMQmZvdHaXoGRczN3ixZYDgTw0GvhQKX2apt2p8Z8Y/KZJoYjzmJPkE31DRu9
	N1kGj9YDyC40PjDGq8B4hmETnRJUKrhgwwS55oLk49rB0IxBoBy7FqHHrtfuPadjkiO+za+rBfa
	w7ntEN/IDKNYg6aXqJbjUaET7wA3hqbYakqG2lZlFSt9C3k+QSp8sU+krDMH9TH8uzOizd9JROv
	FcQM0eIFabXJjHecNwOqmvhDoRrA==
X-Received: by 2002:a05:6820:174b:b0:699:900d:7caf with SMTP id 006d021491bc7-69d7ec7c028mr2001014eaf.47.1779471740694;
        Fri, 22 May 2026 10:42:20 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b635d26b5sm2287249fac.6.2026.05.22.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 10:42:19 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	aconole@redhat.com,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5 2/2] tools: ynl: add unicast notification receive support
Date: Sat, 23 May 2026 01:41:54 +0800
Message-ID: <20260522174154.720293-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522174154.720293-1-houminxi@gmail.com>
References: <20260522174154.720293-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290903-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E6D635B8B0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ntf_bind() method to YnlFamily for binding the netlink
socket without joining a multicast group. This enables receiving
unicast notifications through the existing poll_ntf/check_ntf
path.

The OVS packet family sends MISS and ACTION upcalls via
genlmsg_unicast() to a per-vport PID rather than through a
multicast group. The existing ntf_subscribe() couples bind()
with setsockopt(ADD_MEMBERSHIP), which does not fit the unicast
case. ntf_bind() provides the bind-only alternative, with the
address defaulting to (0, 0) but exposed as an explicit argument.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 tools/net/ynl/pyynl/lib/ynl.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 010aac0c6c67..092d132edec1 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -682,6 +682,7 @@ class YnlFamily(SpecFamily):
 
       ynl.ntf_subscribe(mcast_name)      -- join a multicast group
       ynl.ntf_listen_all_nsid()          -- listen on all netns
+      ynl.ntf_bind(addr=(0, 0))          -- bind socket for unicast notifications
       ynl.check_ntf()                    -- drain pending notifications
       ynl.poll_ntf(duration=None)        -- yield notifications
 
@@ -767,6 +768,10 @@ class YnlFamily(SpecFamily):
                 return None
         return None
 
+    def ntf_bind(self, addr=(0, 0)):
+        """Bind socket for receiving unicast notifications."""
+        self.sock.bind(addr)
+
     def set_recv_dbg(self, enabled):
         self._recv_dbg = enabled
 
-- 
2.54.0


