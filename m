Return-Path: <netdev+bounces-80320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3332187E57F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2261F2117F
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54A28DD8;
	Mon, 18 Mar 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPaf+Uo0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB6288D7
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753366; cv=none; b=jFPHspPnAnhmlKfGRrIMtuMkVLGoduLy0qAJRVMxL/Z/JA6AsEARm5lLjNu+jY0HGavbbnvGgOkaSBQ30iS0GeI6hCcg+tn2XU1ksg3CregduQXE+/rA+5zWov1hUEm1sfQ2Ku1jlJLnt02n9tEdZG+eEgxDPEYl58Eiv766Vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753366; c=relaxed/simple;
	bh=ku9bWLHRKUYcvEwqRD25tayiqgDkHKNv2edDYapYL8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N8jGPOdw4FASF6+N05ai/+4x2VIApuw205Mc0E2nXNI2kQJmPUmhF31TCd4P0aHkesBPVbQPdDUJJFZ3PvNKNOICYoz739toYrztbU4APlpZ4oLY21PfOn7u9t3E6Ic9qih5GKYcW9qdxxsX+Zv1yEnx77ZY1TbZoXGdwiSr+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPaf+Uo0; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513dca8681bso457353e87.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 02:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710753363; x=1711358163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1HNCk+K6DfvbyoIyByBLQlVI8Y5dUy/g4xzem5BE2Jg=;
        b=SPaf+Uo0DkRVYAKVSiW+rdJlcP06sVu86NZu7/UUHcJi3nUDjLusTjokvLeuY9Dsjh
         y7Jiir11Qooxfe2tSkXEoSmuDdS/Suz2ePf4Gcl15Ou+xlIZsqFtmxJRPEx2VnVOTPoN
         31PdpYa6/dHl0QyPMSsmw9gTWD3ouQZVNJvyr9/srG9xuTMoRASZyeqkyE47YbJ9Y5pF
         NFxNhtkdInP1oyZu3PrkO9lE7TRbl1/X9tXPAu3roh8iHLBM8FUmInV4+gdRZROxIl9d
         gTZYi2mUR/UzOJa+Q7mrsd3Rou2954GvJfFO0E2D4cZm2FHH5MxU2jEgm26L4RY5hgPs
         mLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710753363; x=1711358163;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1HNCk+K6DfvbyoIyByBLQlVI8Y5dUy/g4xzem5BE2Jg=;
        b=eR5kT5ciGcndfbxPAZk1kjxcpOdojEbybgUD6Zd/f+EzbxzoJlwpgGiWb845ywAnFI
         XSxE+bjGifdQgwSisP8YJM8/+qkiXKV3+QAdCAbBcGjAbFTKWwMwT8V3Ol71qjg2edV1
         ugFOZVdPob9pdDfyqPhxx6C3gpQJS20sLYdC6MMUxzw2jyYDHK6XWhu7KQIMLyLoxTXx
         +6o7ejttSYCxSmX8oms+GXVDmej7hTcx+1DUgFjd/a9Y7kKov0XXzV6fzl/gCvdYKqDB
         6O8uFjlAxLlhds4RVWtcADwFeBmmulc/fVO7PmkJf+RK2wqG1DeWWHrji0gWxlzoTkSt
         hUDQ==
X-Gm-Message-State: AOJu0Yxf52nTBR1nzGhUQ9FCS1lNy3Pn4Dlk0wNeWsqtDPe7XYooxgXf
	ZGrnlre73TjMBIf1bNwW05iJy6/NYJhNhOgs8WWopA9NvoNPK/u7oObiVe7uxdS80Q==
X-Google-Smtp-Source: AGHT+IGEcxwucJvb5UVL7BgpkqiEi9pnsLIpJronQy8bXz9NXnFB6befDGc8lua9ZenElYdbFl1kYQ==
X-Received: by 2002:ac2:5f81:0:b0:513:c98c:7d02 with SMTP id r1-20020ac25f81000000b00513c98c7d02mr5353058lfe.6.1710753362400;
        Mon, 18 Mar 2024 02:16:02 -0700 (PDT)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id k24-20020a192d18000000b00513b1027d9dsm1553214lfj.215.2024.03.18.02.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 02:16:01 -0700 (PDT)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2 v2] ifstat: handle strdup return value
Date: Mon, 18 Mar 2024 05:15:41 -0400
Message-Id: <20240318091541.2595-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_nlmsg_extended is missing the check as
it's done in get_nlmsg

v2: don't set the errno value explicitly

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 misc/ifstat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 685e66c9..352e5622 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -140,6 +140,10 @@ static int get_nlmsg_extended(struct nlmsghdr *m, void *arg)
 
 	n->ifindex = ifsm->ifindex;
 	n->name = strdup(ll_index_to_name(ifsm->ifindex));
+	if (!n->name) {
+		free(n);
+		return -1;
+	}
 
 	if (sub_type == NO_SUB_TYPE) {
 		memcpy(&n->val, RTA_DATA(tb[filter_type]), sizeof(n->val));
-- 
2.30.2


