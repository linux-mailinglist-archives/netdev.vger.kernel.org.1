Return-Path: <netdev+bounces-213827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE44B26FE9
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 21:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81854A07975
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 19:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F4C248F41;
	Thu, 14 Aug 2025 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYr78f7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F42472B7;
	Thu, 14 Aug 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755201524; cv=none; b=rjgEN4mgycWyOMAwO3IFyHS2+mx31fp6g/+Bsx6Cbf5ahcQKD3xwZZckfUIpC0soonUJjOy/E8WOny2UJMZWVQSx5WAvfEdrwYDac5wO+SKUfMWlCcTWfiPbYVBxICHLmoykwKAV0x7Cu5Rq1nbx5m212f+Yb/3yKQh9UgzGvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755201524; c=relaxed/simple;
	bh=nrlkrGOj9FqTVo2wmyTaurACgaNJ4dRf1Fq6fsT64vA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z5EnhXUPb/1XT3fHrdIyEhRsSAxZj2Ne4qHybek4+PsktT30Maqc8OED/lBffRWfGpYTrV9tfOglWTmG5U20H6019VWORqDEgwWkiMxrTCcwFSKBzI22QmHxfvTUnEr47RqeVrUrLqIn5FendKSbcALsJ6Q7DEJ5st8A/es4S1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYr78f7F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb09041so1297539b3a.3;
        Thu, 14 Aug 2025 12:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755201522; x=1755806322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TTV/lDDZEqi/BsEhizG8Om94UxJelIedyE+K0f5Dktw=;
        b=iYr78f7FOjxjM88H6FT0tmNT+wetghXtw8cSGZNUFPbrjp46BSlCDMYG/6Q+naOWk1
         HnsDRTGgLTXJ+iCr+lBxAPnpXobd7NS8LgND0hrLMXjY1mM5KK6Kdk/KtLrszEuYYy+T
         y0QJ/LIskX/4jj0G4rKf9LX/M16y9d2TTyODf+DQjijGR+kEpZNcFmtHsQ6RN01+pCnJ
         2hKzCyDYsFAYQdbEHC6F3IGot8LzH+rcpQk4VEarkw2M70qQVCjKY/uRkdICv8ug3Xul
         qaSrqf0dDFiHOl9p4Bw1m6+FaypXJ2wIzbU0P7c6Uj7DfEwCfEbI6yRu+zxzYRVEO1Gq
         Mggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755201522; x=1755806322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTV/lDDZEqi/BsEhizG8Om94UxJelIedyE+K0f5Dktw=;
        b=l4knTqrri0r2nRk5WGet1+VGgmIBC1144VO/XciWDKakvw1nxFSp9KkWcKFNEs+LjD
         pjIEXTPy7c/Jo2dNodGrnTTKomOC7fu6/2mKuXZ/kKGW7U+pddzMoAvHB9TN/HFV+Ysw
         qLhE57euVo7d4k8aIn2pUK+EFo7HALRKAl9bRcqwclOJcE8SpkBSq9dCbXgfM43k8Yaw
         TWNa+ZS6Ao1v88GymLBpIB1Xx58i/AHFtTjWOh27eWI29srv/HEv+IqU7KfCEA+7hC13
         MIpVv1FlwOgYfnREfU4DJkWjb0UGrGJ+kdmq7zfhHOFTgHryQQDdGaWxYih3pXeURTGd
         wsbw==
X-Forwarded-Encrypted: i=1; AJvYcCWhlXd8ZnMpHqBFSUwNQH18NXHU8/GkOrX/HY6azuV2GaT2TZJbvhI/jH9z7fIIywfK5yQdz2UE@vger.kernel.org, AJvYcCXninItpOig7uYWIakG45GZgGBfRb+ymqUYkZJkXEySC1UXMFqAZyDJbf6qA+ossR5KU+ebKtZz1/NF/Rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2i2x/BKpLiAu1Fhpw/3az8qvz/85g8dh4KimxiDxf8MTUn6CW
	G2kkIqkyo6MKKmTFQoSM4jTGGxiiBYbmaReW33TGIWP8PRnagIF0B+PU
X-Gm-Gg: ASbGnct4QZA/ndCEcBdFPi4FmLnWu2Cy90tshvafXf0Le6eEn1/M7MCd3wtAXuIsOxi
	PKFDbcKN2UPXPOA+wE1QD6llh3T0sbaSgF6AwaBhPM9i9zEjOkQmieHulhVJt2Wc2V0nE/EcVZ3
	ODs+TrgE3jUU0OlBWqQo5jyE5ER+DwFdOFmr6ULf3X1tDSI6IVrr3TWH5k4O2TZs698pRz1vXyN
	KDs4KDtBAtjhhmxmesv04faU720odeKm5vFVKSV3S7AXeJN4ZXeyB2baCFFJ/c6wLWOpsRR30Hr
	TDwTQqsT3Hx7XyMI4CjNt9fQvADJ9EsdZpYKpC3D7TmWTf9GjwfNerUP+YROMrL+zJ9Wf+CZUe6
	Y+isupIWBu8+blJmVXExXumH+LecRIj76
X-Google-Smtp-Source: AGHT+IGfqAEK4l5/msrW/qNfWimt6bHO8cTnrAWKRlRK83XrpYBg6McxN2mX0rKbCM7Sw+3yfa29kg==
X-Received: by 2002:a05:6a00:3e1b:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76e31eb9d76mr4896477b3a.5.1755201522541;
        Thu, 14 Aug 2025 12:58:42 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e2037acf2sm5380761b3a.112.2025.08.14.12.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:58:41 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] net: openvswitch: Use for_each_cpu_from() where appropriate
Date: Thu, 14 Aug 2025 15:58:37 -0400
Message-ID: <20250814195838.388693-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

Openvswitch opencodes for_each_cpu_from(). Fix it and drop some
housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 net/openvswitch/flow.c       | 14 ++++++--------
 net/openvswitch/flow_table.c |  8 ++++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/flow.c b/net/openvswitch/flow.c
index b80bd3a90773..b464ab120731 100644
--- a/net/openvswitch/flow.c
+++ b/net/openvswitch/flow.c
@@ -129,15 +129,14 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 			struct ovs_flow_stats *ovs_stats,
 			unsigned long *used, __be16 *tcp_flags)
 {
-	int cpu;
+	/* CPU 0 is always considered */
+	unsigned int cpu = 1;
 
 	*used = 0;
 	*tcp_flags = 0;
 	memset(ovs_stats, 0, sizeof(*ovs_stats));
 
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+	for_each_cpu_from(cpu, flow->cpu_used_mask) {
 		struct sw_flow_stats *stats = rcu_dereference_ovsl(flow->stats[cpu]);
 
 		if (stats) {
@@ -158,11 +157,10 @@ void ovs_flow_stats_get(const struct sw_flow *flow,
 /* Called with ovs_mutex. */
 void ovs_flow_stats_clear(struct sw_flow *flow)
 {
-	int cpu;
+	/* CPU 0 is always considered */
+	unsigned int cpu = 1;
 
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+	for_each_cpu_from(cpu, flow->cpu_used_mask) {
 		struct sw_flow_stats *stats = ovsl_dereference(flow->stats[cpu]);
 
 		if (stats) {
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index d108ae0bd0ee..0a97ea08457a 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -107,16 +107,16 @@ int ovs_flow_tbl_count(const struct flow_table *table)
 
 static void flow_free(struct sw_flow *flow)
 {
-	int cpu;
+	/* CPU 0 is always considered */
+	unsigned int cpu = 1;
 
 	if (ovs_identifier_is_key(&flow->id))
 		kfree(flow->id.unmasked_key);
 	if (flow->sf_acts)
 		ovs_nla_free_flow_actions((struct sw_flow_actions __force *)
 					  flow->sf_acts);
-	/* We open code this to make sure cpu 0 is always considered */
-	for (cpu = 0; cpu < nr_cpu_ids;
-	     cpu = cpumask_next(cpu, flow->cpu_used_mask)) {
+
+	for_each_cpu_from(cpu, flow->cpu_used_mask) {
 		if (flow->stats[cpu])
 			kmem_cache_free(flow_stats_cache,
 					(struct sw_flow_stats __force *)flow->stats[cpu]);
-- 
2.43.0


