Return-Path: <netdev+bounces-212480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9832B20CAF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3059188395B
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 14:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721A1DED5F;
	Mon, 11 Aug 2025 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aC0lyn/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22602F9D9
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923977; cv=none; b=tiJSckq5VJl1qdHvbMO8/P3uWjupPh4LXSW7eelCuPCS3kuAI9P5HbOuBaucS1nS/XDV8P85D8j87dwvRtTdPg3UetKG+jRRhCxPKiski5/Fkoif7p+e1N0ekS8XS/LENiWncd5A+fNB5NAH2ZPWbPZIBUtIc5E0EmXNmD2fKuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923977; c=relaxed/simple;
	bh=Z9gS3xdpPmGTZ3u5IdZbV3C7+V8xV2q2b6Wyw+yeox4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tEw59SP4+68Gk9+YJPB/j9zrv0/qnHoFoTGtm/q/DN6Ds+oni3r7qmKc2RcYcz4ouO01l+MFksC5l4hUo6oLgzIinL+90uq3hVGYCaayDJMw6VGbEkhhc696+ltKUtTNUcxt2mqhuMBoROjP3OyAmpQ970ZG5dvov999P3ISxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aC0lyn/Q; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7e7ffcbce80so977415685a.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 07:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754923975; x=1755528775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CZ4ETBx6UKKljk8PTuIVWEpwvgKTirefKYhWQT4JupI=;
        b=aC0lyn/Q6sISajX6OaRBiemo9PFsGQoNT7PYWTNiKKlv2f4QVh1jO3tYrjhN0QN2KI
         r5sa1uvsvBSdXejvsi2JbcfRwZDOvqGYffjosVVliJLGcs4hb64GgeFTBMzk49F8zHUX
         sbkxvVm4SVrf/N3154wqARFljMd0BrscYaLKz7k9bmO/4tUxPR5LNFXl/fVR49dfw9/v
         Cn0EljL4taVvEB0RhAI6N+bqS/NhSYeBdOXucJ39dsboqbC09SncQarqN5duI0gMe8CC
         PPXwVDn/68EyOMxKn21VZD+4zGqS/SUYGWIw8pn6HslXDHR3VngMywxoMICjm0eOAGME
         q/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754923975; x=1755528775;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZ4ETBx6UKKljk8PTuIVWEpwvgKTirefKYhWQT4JupI=;
        b=VPCYjMP5x7daVtwJyHV3pm+lNfoPZnN0c10ApCCUsbUm/106d9nMf2IkUpyWzVsrZf
         nUXQL5HTF4afK85KbZf9GfCwndfAZsDw4jcu+qvD64v2/q71pwsGkBNHfKC95qkWLdfb
         KXHwDJu99imxnTTARsi/H5Gwc2ViUOgxV5bmwJTSLw+lVEBHu4G39Lgjhp+L0XfwKNC+
         E0pWyEoFeVTb5Z9wXJv4xRB4h2wxmkBzvxqyfdLKIByWC0QdO5YPB5PmKeZdNv+ezs3K
         g7mTe8ax6yzPAcoWHfbhqeF1fOVBMeOKsYuA6OPY0qQUnfOQUUo7RjAni6zJz9c40Itq
         tLOA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmVTi24W0CECXQv2iJ3hDhyzjAwlNQoPOm92EbXJFFpOQoHswxqR0IUJJ3VG/87tr0ajXjc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVN9/muoPQ9mIZALB0wXfSlSW9rdQhbC5ZCmiIFQC+owo1E6mo
	DOVRxaYL+K/8Z+ieLXLguiaiWzXEyOlQi4Ur5HXzG2kH0Hoa0OdXLIMsD9XMvDoYR7tly0bu5gu
	GQoCegi2gE3dxOg==
X-Google-Smtp-Source: AGHT+IEawFOaaRGg6xb/hPp38BD4gm4G/P1pr0JkzRbnduBt2RzpihUYW6Fycv35kJ5VWiJZ+zXQtO1D0157XA==
X-Received: from qkha22.prod.google.com ([2002:a05:620a:676:b0:7e3:722b:bf24])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:a30f:b0:7e8:1747:62c9 with SMTP id af79cd13be357-7e82c6b83f4mr1454146485a.24.1754923974832;
 Mon, 11 Aug 2025 07:52:54 -0700 (PDT)
Date: Mon, 11 Aug 2025 14:52:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
Message-ID: <20250811145252.1007242-1-edumazet@google.com>
Subject: [PATCH net-next] phonet: add __rcu annotations
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Remi Denis-Courmont <courmisch@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Removes following sparse errors.

make C=2 net/phonet/socket.o net/phonet/af_phonet.o
  CHECK   net/phonet/socket.c
net/phonet/socket.c:619:14: error: incompatible types in comparison expression (different address spaces):
net/phonet/socket.c:619:14:    struct sock [noderef] __rcu *
net/phonet/socket.c:619:14:    struct sock *
net/phonet/socket.c:642:17: error: incompatible types in comparison expression (different address spaces):
net/phonet/socket.c:642:17:    struct sock [noderef] __rcu *
net/phonet/socket.c:642:17:    struct sock *
net/phonet/socket.c:658:17: error: incompatible types in comparison expression (different address spaces):
net/phonet/socket.c:658:17:    struct sock [noderef] __rcu *
net/phonet/socket.c:658:17:    struct sock *
net/phonet/socket.c:677:25: error: incompatible types in comparison expression (different address spaces):
net/phonet/socket.c:677:25:    struct sock [noderef] __rcu *
net/phonet/socket.c:677:25:    struct sock *
net/phonet/socket.c:726:21: warning: context imbalance in 'pn_res_seq_start' - wrong count at exit
net/phonet/socket.c:741:13: warning: context imbalance in 'pn_res_seq_stop' - wrong count at exit
  CHECK   net/phonet/af_phonet.c
net/phonet/af_phonet.c:35:14: error: incompatible types in comparison expression (different address spaces):
net/phonet/af_phonet.c:35:14:    struct phonet_protocol const [noderef] __rcu *
net/phonet/af_phonet.c:35:14:    struct phonet_protocol const *
net/phonet/af_phonet.c:474:17: error: incompatible types in comparison expression (different address spaces):
net/phonet/af_phonet.c:474:17:    struct phonet_protocol const [noderef] __rcu *
net/phonet/af_phonet.c:474:17:    struct phonet_protocol const *
net/phonet/af_phonet.c:486:9: error: incompatible types in comparison expression (different address spaces):
net/phonet/af_phonet.c:486:9:    struct phonet_protocol const [noderef] __rcu *
net/phonet/af_phonet.c:486:9:    struct phonet_protocol const *

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Remi Denis-Courmont <courmisch@gmail.com>
---
 net/phonet/af_phonet.c |  4 ++--
 net/phonet/socket.c    | 23 ++++++++++++-----------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index a27efa4faa4ef46e64efe6744790c47ec34147ac..238a9638d2b0f6a23070b0871515302d8cba864f 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -22,7 +22,7 @@
 #include <net/phonet/pn_dev.h>
 
 /* Transport protocol registration */
-static const struct phonet_protocol *proto_tab[PHONET_NPROTO] __read_mostly;
+static const struct phonet_protocol __rcu *proto_tab[PHONET_NPROTO] __read_mostly;
 
 static const struct phonet_protocol *phonet_proto_get(unsigned int protocol)
 {
@@ -482,7 +482,7 @@ void phonet_proto_unregister(unsigned int protocol,
 			const struct phonet_protocol *pp)
 {
 	mutex_lock(&proto_tab_lock);
-	BUG_ON(proto_tab[protocol] != pp);
+	BUG_ON(rcu_access_pointer(proto_tab[protocol]) != pp);
 	RCU_INIT_POINTER(proto_tab[protocol], NULL);
 	mutex_unlock(&proto_tab_lock);
 	synchronize_rcu();
diff --git a/net/phonet/socket.c b/net/phonet/socket.c
index ea4d5e6533dba737f77bedbba1b1ef2ec3c17568..2b61a40b568e91e340130a9b589e2b7a9346643f 100644
--- a/net/phonet/socket.c
+++ b/net/phonet/socket.c
@@ -602,7 +602,7 @@ const struct seq_operations pn_sock_seq_ops = {
 #endif
 
 static struct  {
-	struct sock *sk[256];
+	struct sock __rcu *sk[256];
 } pnres;
 
 /*
@@ -654,7 +654,7 @@ int pn_sock_unbind_res(struct sock *sk, u8 res)
 		return -EPERM;
 
 	mutex_lock(&resource_mutex);
-	if (pnres.sk[res] == sk) {
+	if (rcu_access_pointer(pnres.sk[res]) == sk) {
 		RCU_INIT_POINTER(pnres.sk[res], NULL);
 		ret = 0;
 	}
@@ -673,7 +673,7 @@ void pn_sock_unbind_all_res(struct sock *sk)
 
 	mutex_lock(&resource_mutex);
 	for (res = 0; res < 256; res++) {
-		if (pnres.sk[res] == sk) {
+		if (rcu_access_pointer(pnres.sk[res]) == sk) {
 			RCU_INIT_POINTER(pnres.sk[res], NULL);
 			match++;
 		}
@@ -688,7 +688,7 @@ void pn_sock_unbind_all_res(struct sock *sk)
 }
 
 #ifdef CONFIG_PROC_FS
-static struct sock **pn_res_get_idx(struct seq_file *seq, loff_t pos)
+static struct sock __rcu **pn_res_get_idx(struct seq_file *seq, loff_t pos)
 {
 	struct net *net = seq_file_net(seq);
 	unsigned int i;
@@ -697,7 +697,7 @@ static struct sock **pn_res_get_idx(struct seq_file *seq, loff_t pos)
 		return NULL;
 
 	for (i = 0; i < 256; i++) {
-		if (pnres.sk[i] == NULL)
+		if (rcu_access_pointer(pnres.sk[i]) == NULL)
 			continue;
 		if (!pos)
 			return pnres.sk + i;
@@ -706,7 +706,7 @@ static struct sock **pn_res_get_idx(struct seq_file *seq, loff_t pos)
 	return NULL;
 }
 
-static struct sock **pn_res_get_next(struct seq_file *seq, struct sock **sk)
+static struct sock __rcu **pn_res_get_next(struct seq_file *seq, struct sock __rcu **sk)
 {
 	struct net *net = seq_file_net(seq);
 	unsigned int i;
@@ -728,7 +728,7 @@ static void *pn_res_seq_start(struct seq_file *seq, loff_t *pos)
 
 static void *pn_res_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 {
-	struct sock **sk;
+	struct sock __rcu **sk;
 
 	if (v == SEQ_START_TOKEN)
 		sk = pn_res_get_idx(seq, 0);
@@ -747,11 +747,12 @@ static void pn_res_seq_stop(struct seq_file *seq, void *v)
 static int pn_res_seq_show(struct seq_file *seq, void *v)
 {
 	seq_setwidth(seq, 63);
-	if (v == SEQ_START_TOKEN)
+	if (v == SEQ_START_TOKEN) {
 		seq_puts(seq, "rs   uid inode");
-	else {
-		struct sock **psk = v;
-		struct sock *sk = *psk;
+	} else {
+		struct sock __rcu **psk = v;
+		struct sock *sk = rcu_dereference_protected(*psk,
+					lockdep_is_held(&resource_mutex));
 
 		seq_printf(seq, "%02X %5u %lu",
 			   (int) (psk - pnres.sk),
-- 
2.50.1.703.g449372360f-goog


