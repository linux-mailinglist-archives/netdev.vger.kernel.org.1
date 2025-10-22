Return-Path: <netdev+bounces-231777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BABFD69B
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2847F3BB47F
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 16:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E035B12E;
	Wed, 22 Oct 2025 16:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="lq7PtUW3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD7535B122
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761149523; cv=none; b=XSn63aQySti0wp2Y16lAZ7bI30VlWgw39XgCcPLhVqsGNZprQfOG2ieR84ceZcOTBkaCvKdcd/N6ln1qxQWnYdl8D3OKfMnQGuElW2TWm7UtVy2PRKdgwCm8x5+BIYrKbQMxT0QtTe+Cz/njFCcxrova0GQvb6mj9tTWqSwj4as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761149523; c=relaxed/simple;
	bh=MYRiBXo/2SYsN7m0ssFE9OarNO83Yxq1TyCrISUvu6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+nxz7sHHc/xaBGHWriSIwpb/J3W3atYLY+Qtuu6/AxPddI0pEPznfEbOI+W2Wb5kTN7b1j1+jlFF6jPoW7+ZQBBqVKI5kg9WZfdIYJE4Vbt1TTobjcwz8Gyi7SVJkrQ6XkzSnW9kpY5NGEQ/vB2aQ8tM7N9IYJp61s1h026whU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=lq7PtUW3; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1BDF83FCEE
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 16:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761149510;
	bh=fJ4eaCLAd1T6Qi1tAvgT59ff6VgTNShusVhiWjf+ZSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=lq7PtUW3t4+fQxHunzHrT2Y9IndVcm1MKv6z95bsYP3vOcBO95KTOtXQJvFaxuJcj
	 1UXUvBVt8oY7Xy2CMPeAYIDGIvhlpq7se/NgVxTSrU4KPlFtL/L8mBQ9tzfi/9gjQo
	 bGlOUMWgMxIMtEVjHlismMry0PvA6eBVhkeEoCXPfWReJ02fBXfba8ZCftglcRFLJ6
	 o/pGXopBS8zDtP/L5yMUwTCU6V9eGoBj+ydyco9sKz3pcdZazCsb+tWFUcZb2PJceU
	 nVgeeTz9nyiPLhiszWXLHgAzumfKujtcMFW7CjyKtK9QdyLMHBv8fF53tDvg5MxwNO
	 blnJ+LPMXkb9zIWoWHLnctG2EOXM8w1c7857B6NAwaTu5uK443WAN0gZD57jp805fT
	 /3ZR5tovUjuptwdXEP6yh0QAOKfgUpgCHL2w0fT78Bh0moy4vHaT04ql+/LcQ4kRjq
	 +Km5IvZiM7pvEmhz8N8x1CBsBclqAOJkoJ+3zg4D1THM/iYR/aw3enX/m8kcnfVPx+
	 yw7NnzF9jK0mHJYCfnAkc57nCsNIy8wm/wM10BYSUqHQNy1fqWUyvE8LKlOVfef3sM
	 hEhEUVKBHEfJhC5JcmInMIUKHHGlKRvezTrWM9EmdxFTusWaB+Ck1tjAPnxuslZaQv
	 d9MfaH/LwlNlgIrlf07H0Efg=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b5cbb3629f2so899496066b.1
        for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 09:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761149506; x=1761754306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJ4eaCLAd1T6Qi1tAvgT59ff6VgTNShusVhiWjf+ZSE=;
        b=ObsIbL5HCKHAbtS3m3pCbsV6OklkVTljZLkHU1o8tepM6vuqIvo++WcYR7dIhC0bap
         1m/klDgZUTTyR91zFhskXQOfyPUlIQN99ucYeq8/McwPCudJvc9flmAB/TiUbzl44ooM
         oKnLGmqrH+qgzwjpiwTcsflNHBnd6w+N2NFQivqSvGskcwfadY2nRvXw1bAe1XAPyjoW
         W6Dsu8Z6U1Zh8cKEzocYNSme7fpzvVUXZeBCPsRdYYQfBNTyhWoBwtbRbqfYmQSVwrp9
         6i37G74L/fD7Y/Cr6Wv65BdP7Mg2BjtjfWQRqdif6oqniefg1F5I4MvQfk1fGhZvMC3b
         wL1A==
X-Forwarded-Encrypted: i=1; AJvYcCX8PgTXrZ2c5ZN7HmRZ8l4PbDt3xKO/ITwopdcr31OdFQyLXbBz6zi55iqHwC3vve+1PEDQHLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiQOYgz22VcsefHuilJt8FFy6etpaJTfBaH3Ssf4LZz4cAOqbh
	pWk9tFW1Osx6GTkGm3uu7uVyih6hPjtD1YzIqRwYlIINEMHC9Y/iwk7Zo+Xdbv2mbu7fNxibXY4
	ChKuqgRHL2lGFXTGclrPejyDug8OYvJTnIV6O4KAOco2m//5MCGALjwJZ1WBhrsWvG26yTwQXvQ
	==
X-Gm-Gg: ASbGncuxB8kzQBY5AYTa52HMvNLzWwmkM+ioTydPUss7/ZG9UXmOp4ZwuFhkAZ90Vi/
	TXPz3ijRRXJ3cQbVOpcK338BF35maEH776DbBmhvYbHvu53GFZH4ElSuzNvmeigJb1IxU8Z4c9x
	BqB4k/FrGLUo5qQLAuM+tfx49rsAsRtUUmjT4RW48vSanvjLKp0PpL/yayhPAsB7QruFY/G2+uB
	Jcp0jGVZZJeqjkXdiART6R/desihDTowPIR4M9HsDZMhPCZM39lruFrKGE3c82BDxSX/O8DZ1ZG
	acbFU1SshF0Hc/rbrBMyCJer3U83pRXF3YWTkSyddCVcQkkQ+J6LwXv2oLFkWWPFtXJaLmo8Y81
	EmdxCj26PKgrlJxLkVySKKtDYTJQvnoneWakrN2sHc5ojKRRWpSAAz6nhi/E=
X-Received: by 2002:a17:906:fe4b:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b6475a0347bmr2374826066b.64.1761149505837;
        Wed, 22 Oct 2025 09:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsIOTZ0/NmXygXvRAij62k1mXr5cxAWBu/F6+ubCac0eQdjwISwDyzdPouZt9bR27eiPT2Jg==
X-Received: by 2002:a17:906:fe4b:b0:b0b:f228:25a with SMTP id a640c23a62f3a-b6475a0347bmr2374823266b.64.1761149505472;
        Wed, 22 Oct 2025 09:11:45 -0700 (PDT)
Received: from rmalz.. (89-64-24-203.dynamic.play.pl. [89.64.24.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e7da33c6sm1360296966b.2.2025.10.22.09.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:11:45 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Robert Malz <robert.malz@canonical.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Dennis Chen <dechen@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH v2] i40e: avoid redundant VF link state updates
Date: Wed, 22 Oct 2025 18:11:43 +0200
Message-Id: <20251022161143.370040-1-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jay Vosburgh <jay.vosburgh@canonical.com>

Multiple sources can request VF link state changes with identical
parameters. For example, OpenStack Neutron may request to set the VF link
state to IFLA_VF_LINK_STATE_AUTO during every initialization or user can
issue: `ip link set <ifname> vf 0 state auto` multiple times. Currently,
the i40e driver processes each of these requests, even if the requested
state is the same as the current one. This leads to unnecessary VF resets
and can cause performance degradation or instability in the VF driver,
particularly in environment using Data Plane Development Kit (DPDK).

With this patch i40e will skip VF link state change requests when the
desired link state matches the current configuration. This prevents
unnecessary VF resets and reduces PF-VF communication overhead.

To reproduce the problem run following command multiple times
on the same interface: 'ip link set <ifname> vf 0 state auto'
Every time command is executed, PF driver will trigger VF reset.

Co-developed-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>

---
V1 -> V2: updated commit message, added information how to reproduce

 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 081a4526a2f0..0fe0d52c796b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -4788,6 +4788,7 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
+	int old_link;
 	int ret = 0;
 	int tmp;
 
@@ -4806,6 +4807,17 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	vf = &pf->vf[vf_id];
 	abs_vf_id = vf->vf_id + hw->func_caps.vf_base_id;
 
+	/* skip VF link state change if requested state is already set */
+	if (!vf->link_forced)
+		old_link = IFLA_VF_LINK_STATE_AUTO;
+	else if (vf->link_up)
+		old_link = IFLA_VF_LINK_STATE_ENABLE;
+	else
+		old_link = IFLA_VF_LINK_STATE_DISABLE;
+
+	if (link == old_link)
+		goto error_out;
+
 	pfe.event = VIRTCHNL_EVENT_LINK_CHANGE;
 	pfe.severity = PF_EVENT_SEVERITY_INFO;
 
-- 
2.34.1


