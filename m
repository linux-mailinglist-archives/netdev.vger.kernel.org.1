Return-Path: <netdev+bounces-231328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19050BF7756
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 17:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F9D3B5BCD
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5B1239E97;
	Tue, 21 Oct 2025 15:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="h6U8SwO0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B8338937
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061492; cv=none; b=lpy8aqpBD0hsWfA86UzcFQyAK8wPVAeb2jCx6fKpvc0vYRTWSK5F0lcnK7OdTLcfvFdu2rWXae+mpw5x/H8tYHxP7rrOYrsN5jLBYHEVvXBejUggMiSw57dLinaFXvGa9VP9axtMNOjl25xSGdylqlwBzhQTzucmPwGyxI6UwOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061492; c=relaxed/simple;
	bh=VfYqb1PteopDgPzSE++edDnlCe7KaGEpqIRlhlYWVmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hv+3cWVYZZ6AeKRlyKYQ+bH9G0ytlYItzVnAlKEF9r/nZA0O03T8KmaTZ6GPGlQ4mdW9Sx218cSf/upmYDd+AlxPh5DzEL5nXYblrrqlSmkZrNMUj6GryvAhSJTUGZXad+v/0fjVMzlfHIEPmDWJqSuEtRc+0R7+1fgxwHFIfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=h6U8SwO0; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 675F93FCD2
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761061482;
	bh=P+G8JYuaf9/ocVW9AZ1OS+iljK78E4LjTUi/n8zsx1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=h6U8SwO0DQpeWCJ5U/gNcEMq7hipQCVoxLsz44ROTyzNEy1S8kN2qU+ZgIh1YDjZU
	 iJAHz/wD6NQCStVbH9ZR7gzQwqNg8yFtugoxseNy/wtqmQSfJwcZb1b0VAJJvVjWjL
	 KQh7A0mpwQ2yH+fO+9rn75gl8OOIKVrzwtLz8UFo1rKFGTLkcazBFwv5adgQM71fXD
	 TMJpZa+94YQih6aZKZKa70oNcQzQ4U6d4UK39IOXHl5uYNXridvvS60olTrrcS3J2X
	 NuutTRzG2Hh5a/BzQCJKYHe37NgMyl2qA5taSINGsIW9UqCdFSNeb0J/z3a5lHnEJb
	 UPFsZvaWNChSXSHXgdnLlERCeaTcHvuUUDeMKxXKJU0uTKnhnqXBwYt1KBrIjtwYmu
	 tsBEoustbyY7snvuwBQjDpRVybst41ZA9krr23bHrW4+lbr1eYb8xOeRe9HIbALhPI
	 w7VTWwx6mFBiYUCqujKZ9xbgFwsuI15lhgfQ3ur4eWNdH4f3sgTziXeTFvyqwPv9tP
	 iFRxW+0OpfAxa+QuqHow/e42qcM70WIbl8bZUE9IwfzRFBRNzN6+xUfm/yv7NJzZSD
	 sS6b03YC2lfIL4+Rkijhivw3ny1EX0pLx1TabT+EIIeQlbqc6vUypPsLEvSQE+WFI4
	 DmB2OqNSqyQAywHLzlCWuIe0=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b3d21b18e8fso600089966b.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 08:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061481; x=1761666281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P+G8JYuaf9/ocVW9AZ1OS+iljK78E4LjTUi/n8zsx1Y=;
        b=q/OEW0W9YG9YlRigjtA03KuDUEu7K+rBTfqMucAl+asU8MEa+wttSX6gE671ZY0otB
         6+AMGMHPdI21qRvk9sQF/Z3pUk6e242sEsYqKnfAMUrQ3PMt6FrDNnFkfwRgrkjzjlYJ
         TVgSqAc/P7R3SrC8kS7HsIi051GM019XQbzkUQlmMRz8+MdouocTVnbaAYZ86PrT72l/
         hVgXrwRlFC/lGw+K+0Rt6sV5J5R/lHwqZ+CfOA6yAnElHyaUWhSnc+C5mgkC/JSIbx0l
         y6vMzy6M+Q7qkyw3x0fmcl2pSelAIh8pl7ivIyldjfNHrS0V15vyDVjuTvP/y2Phm+gP
         SDiw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Rx8p+Gfm7jveo7z/qUfgj3UaADbsC432MMT/54euGD/SrHsM2SZW0/3giKseU1GVflqeHzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzsSxIHvbeS6BitSgNAgk6Fb1XgbDDK2UuqA98Fl+VaWXGBqyw
	xFBm43KdcylgeBrnhbInKS3SM+C1ylWxWc2wTdomeBkrTE0Q3Hh3hDlXkrVIg2fg8jOGmr96oa8
	6ps+7Jm+FhvaNdUHQ85cUlfeAf6VA0GpMLq8im4qP/sO3Al7L5+tnYfdnrBbPV7lukzZ/RYMrsA
	==
X-Gm-Gg: ASbGncug+yjTjXofd0EsRx4Jsz46kHSw5n4ojFe1gYR9Y+HgfOjCZ3P8M2x5vXsbMrU
	ZPR0R9uehRr5qi1rqDtz8zYQudAJ263sYH4VE0/1JnNpHTNLOLjvLPgkkD7bq62Css1ilVN59Yf
	wfLOayQB9b198D/ubWX/xwkzJ+U9RGVkXzxpA161e9VjK/UULJ2f+tfTjqbm3hHN7nlL8WPwny8
	URbmqvsp9o2nSUojfDJEcu7AV8CLuYRn/oEmRFymAHIlraELoTKJJIw8quOWL+Rkk8ZGsM5RXbh
	EHfdjU2ZDllj8uDy3c8Nagxp55uf/PrBaQLOhNB1CmVGJCZdYardjSLT27Ta2NfC4WxYFWUsIoP
	6E2Om4JXEANiOp0pOyxSjMCZP2nfZGOGFM6CcQUul/HCffQYQ/xEjGW7EKgg=
X-Received: by 2002:a17:906:c113:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b6472d5bc0cmr1897294066b.9.1761061481424;
        Tue, 21 Oct 2025 08:44:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGm0wKz87sI/6oHhB29rkZgj45YdZCQPEnAd4R3RSLzzHhO5TmkzmBCmhcnqV1ji4CXZ6UqlA==
X-Received: by 2002:a17:906:c113:b0:afe:764d:6b22 with SMTP id a640c23a62f3a-b6472d5bc0cmr1897290766b.9.1761061480956;
        Tue, 21 Oct 2025 08:44:40 -0700 (PDT)
Received: from rmalz.. (89-64-24-203.dynamic.play.pl. [89.64.24.203])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65ebb4ae4dsm1087924466b.74.2025.10.21.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 08:44:40 -0700 (PDT)
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
Subject: [PATCH] i40e: avoid redundant VF link state updates
Date: Tue, 21 Oct 2025 17:44:39 +0200
Message-Id: <20251021154439.180838-1-robert.malz@canonical.com>
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
parameters. For example, Neutron may request to set the VF link state to
IFLA_VF_LINK_STATE_AUTO during every initialization or user can issue:
`ip link set <ifname> vf 0 state auto` multiple times. Currently, the i40e
driver processes each of these requests, even if the requested state is
the same as the current one. This leads to unnecessary VF resets and can
cause performance degradation or instability in the VF driver - particularly
in DPDK environment.

With this patch i40e will skip VF link state change requests when the
desired link state matches the current configuration. This prevents
unnecessary VF resets and reduces PF-VF communication overhead.

Co-developed-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Robert Malz <robert.malz@canonical.com>
Signed-off-by: Jay Vosburgh <jay.vosburgh@canonical.com>
---
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


