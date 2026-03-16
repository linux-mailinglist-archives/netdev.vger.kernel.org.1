Return-Path: <netdev+bounces-268092-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EdQHwTXt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268092-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:10:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01626297B2F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 19258306AED3
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F238F243;
	Mon, 16 Mar 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VO/rnXev";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W+KNSvaQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FF15FA81
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655459; cv=none; b=IMYeopa/Ku5RR+YrKuq3guIDCktCbI2C0SY81kdoitRzVINGjZLNHw+soJqcB+7oBnqiY4Lq58/78HHOccnbfNHzc2wvrrjstUXZmeNacsSe1mpI6w0sYiB+d3YSb6Qs6JF0LT94bhG538aHdBy8Uc9MEgx8W2YYb3CH45ELDPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655459; c=relaxed/simple;
	bh=Ifhe4KqGUgSTNydAbcFeUl2m8dKrAitNuBY8cKNEABA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBTXq663TJRh2zGy8BM6jPLrFLwoyXIiTm/0FCeRPFBAdigHqhF5EsXfhNSYFkl8JTszsZEicqJydHAXZfUD9MdThfVjvJL0D3D4cEkBdJK7j9VPQp7I7zFXxY7m2Z9r7DLw1HkZFsdf8uVSuciBXo44nntDV/wJi2Avror86ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VO/rnXev; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W+KNSvaQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GA4DGa3125150
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CGWtYXFE38t9PlXD/nop6savxbFB90P2QzjToTCkTuY=; b=VO/rnXevcqBXagfl
	1wpovyKVy7Zi1WHb/0D4SgaFqei/RXf3zBPxjK9WXzTFHxpXgAae3zB2+peHu3XU
	Zhr7CfQJ27r8scrIoAqJO0HlROlW4fg2Byr+xzgId+fDjcQRUbuLNcEW9xuJwiej
	YXujc+ZHPbveY13Js/BwSButluE54PUtHW7516YUFbOx56/WQYVg2E2NBlrv2alp
	eiCjEvoWmG+yPH91KhTdsq3p2iZ/IS7NtfEqbpg1j6kyA6clkZqZ0r1eNEYQTyZG
	BIhcS+fO39JBcfz7dwTJ4zm4Gf7bK8CejNr2hMHtPqxMN66YlNoRmZAXs33zXWhe
	7U+SyQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxfsmg016-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd827a356aso2929509985a.3
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773655456; x=1774260256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CGWtYXFE38t9PlXD/nop6savxbFB90P2QzjToTCkTuY=;
        b=W+KNSvaQ27db0tDDChaRHrnaB+psJoz6yjYKl1ZHXuG/j0bS0jiB56CiKZFBEBnXRn
         DqW31wycGzxBI3C38on1yRpi3PnJeXSCOOU627KO+rdwR+1Y9bXpjbNv5fh+2oF8w223
         zaPM4asn6sh9jx0bBUwnx9AQwhiCCBYEZLQkMRlsYkS3bXFq99OI8lLopTjlFJm2jxdz
         bHgfzZK05VwAHDwhXUuEa2YqV1eY0r7oZ24HVPGmHie4DGxMJ1QIkHS8dEIN4h2kP5es
         /cObb7JD4ohg+JpbvD+C0LcMpbdz8V4UlRdBfdLS+eWCp+EIzLmYpU6MviadwFDmOz95
         Zgtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655456; x=1774260256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CGWtYXFE38t9PlXD/nop6savxbFB90P2QzjToTCkTuY=;
        b=ajPIiOQcf5WPWDSnf4BrUHe3xH2gCOEGV6kyfmlRj0ZVHr3CMFwOlNF4/1LRmAqMFl
         0KA8IS8UnUaoG2aZ/KT8hoJNCWB7HCQjke8Qj7rlIvd9CPJ6ctPp5x725Hjb0GVff+2S
         nHuW3W5NMGXio2BtU/rpSY7p6VXiihDaTHc+6TsBtZtitoSmixZZIGmtjY3jqnmvjTV3
         SUSwf98Xkv/HrnCr7SNPta8zOe3yOwihbdOsRktRJyTF7ql6hD5zcnVzHRZUTS4ug5uN
         ntLe4wNYbBq1LhJh6YtXtdQdtTgcjEKTQinHZWPa/Fu2VdpHLBYJK9GDDKErzvbVyEF8
         8hqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhAjElX4eTCMhCxH9t0+EvEpkT1SGynDk9xPZfn0tdr9GGYY5jb9hBjP+JE4VFVbg3FZg3+kg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT2YUlpszMXfuXmLnK8/FT21vNahwiLmW2MB0fNnlz3zRTNRhh
	s4ACMgbybqwD4/1BJAoAee48wDS06tMdc9h0zKo2xVfxtiUWplpTqw533YpwaiVuStfTWstXyzj
	gHhdnJuS1tnmOTd8G0LeLq3haEWlS2o1wnTesU5Bj3I0dck6N54JI5pyhuh8=
X-Gm-Gg: ATEYQzwAoab72/vtn4nWoPTfiDP9pATWSmyYsgcySmrDPCTFWAc/bnvsTYbwNaNXEKO
	Xf5C9JpLrRusEaBG873vwFsLGlyPhPuRUOmt3h9ZI/ToZZkx654UAk9exT91W6ZWx6IKLuUtDpD
	AwI+3eUM2CUff6UosX3gdW8NdHidfceobYW6rLMMGU+Rmu0Prb8/0GYQbfGKasNSSSBGXVtxBQ+
	tIQiqop7Z5/DlC718pMUj/S+GNZ56lsAUXNoQZ+RK/Z7EI58EPyf3bHzVLgtlbl2HIkDaSrq6tT
	1bRX3F7si/BImGlE7kXqS/00Sl5g2OngWWIWtE9TP5LyyQHJhXBO8KN0jQv/Qa0l7zMt9efLgaR
	P6W4lptADlbXtZ7cB4euvduL53aHy1j06mosItqm0gu5u/hsZ6Rdq
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1630998785a.17.1773655456444;
        Mon, 16 Mar 2026 03:04:16 -0700 (PDT)
X-Received: by 2002:a05:620a:7103:b0:8ca:4288:b163 with SMTP id af79cd13be357-8cdb5a05dbemr1630994085a.17.1773655455989;
        Mon, 16 Mar 2026 03:04:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b457cfa07sm5065465f8f.6.2026.03.16.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:04:15 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:04:03 +0100
Subject: [PATCH net-next 1/2] net: mdio-gpio: remove linux/mdio-gpio.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-mdio-hdr-cleanup-v1-1-2df696f74728@oss.qualcomm.com>
References: <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-mdio-hdr-cleanup-v1-0-2df696f74728@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ifhe4KqGUgSTNydAbcFeUl2m8dKrAitNuBY8cKNEABA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9WaUtfMtFumjskaYWFDmXtZgWVygBbfg6fdQ
 ehch8Rrg6SJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfVmgAKCRAFnS7L/zaE
 w2L8D/0ejnkMwnZ31/tC6S+NBwUzaC0cwSeTVwkDZeQ3NSTbGrmv4EtpQAnu6PCGqtoi5HaN7EK
 hawWIRD2u9V77nFv6zmPDVD9qLRJ3VJuEzxnFNsvmd2FmZPRqM+HUInVjxGisIhJy1+a3d9QtfA
 ntm7men9+4TJhDLOetaV5k+jxfaVa9x2dyNORb86JznG6Hhzon3FIfAdsR0CKhlqYG/MIpn5cSI
 XXairGi9/eOxXv0Eoo04JTyBXc/T1XuaoGvxhcyN+YlU4AtWSXdvIcdq5dm+ncYWpTZqkoObMas
 cL0NYmN74T3AToQ0m6ZM4EBEAiDFk4UaVbtfBPopdnITFFROvV/kOG6jRRLiqEjnqVQRuxMIHMy
 U3fxEIPEbAXw4zrJgqEKdRXWz8toohRbMk5RnmKNhPAFExevGwUCG2uHrsvwstBfZfspU/EdZGF
 f95Mk3I/E6UlHtDVeXrGxxYqypbMpjUrZK2P5QIFWXtEByBbsAcOu1KHHqXd1SeiwklmG90D6V0
 03u4Jdj1yYsVt91eUX93JKxC59bYD3FrjuOXNgMiG9df0RFNkVQF9yVMKmjeqkPPG2uqiAtYzRX
 ZtrfxZe+RTBUc0FusWnygt4lz5H3eRS/dyjqGvT0NJZjxpii7jsmsZQywCC9585cezl+oTH7/9J
 vdxeTEcl1T4oaHA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NiBTYWx0ZWRfX2ipcEpnq5ZNb
 ocUt8ys340FGvpEdTPPDz9jgHcUEy4Xti8C7CHWKa8FQ5S/tgOhg7nt/5ZDPZnUH7JxLMaiK3d9
 Q6es8qXjgkAeoQq/Jx58/BPrjgVLHLnE6yQ7nT1miB32Xwj3bVdHk6kltFyx6vPqvPCrjRQeiBN
 bwoLFuEZCXKw1m8PLp52j8qxZnNo4dZcWdeFUAcCkClq5uWW+Xwgv35Vg0k7zxPjK2c2GPqO1Te
 zgMSW6dU4TlFmLZH6PcxE54kI+21b1ZUc8py5f31UrC6AMkyX0dxO36H9M1w9dyb0k6DoT2zbTq
 WI9aVzi57CSZL7BfZWLShZo6wk7/q1bBsdKsBy46zEAaNgSfdaHzDpmjG3Q3NPNWFUgSYvQZeu6
 LsWAETJVmcC5eu6RCV9fffCukV6K8koX3S9nPm8MSULvJJdzTUzy9kQuA60LNj53woXI6Kf29ll
 B0UZ8Eq651rJbUBd91A==
X-Proofpoint-GUID: 35jv7MovW4DWUbG1xyyGYDdFGy9tvhEY
X-Authority-Analysis: v=2.4 cv=V/hwEOni c=1 sm=1 tr=0 ts=69b7d5a1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=H8K6PwV1nMUzeaH7KZQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 35jv7MovW4DWUbG1xyyGYDdFGy9tvhEY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160076
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268092-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 01626297B2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The three defines from the linux/mdio-gpio.h header are only used in the
mdio-gpio module. There's no reason to have them in a public header.
Move them into the driver and remove mdio-gpio.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/net/mdio/mdio-gpio.c | 5 ++++-
 include/linux/mdio-gpio.h    | 9 ---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index 1cfd538b5105d9b0621572c22bc93dddef85d6f5..c993108898964bee9048a19c40e9de4e5c943b48 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -20,13 +20,16 @@
 #include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/mdio-bitbang.h>
-#include <linux/mdio-gpio.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
 #include <linux/platform_data/mdio-gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#define MDIO_GPIO_MDC	0
+#define MDIO_GPIO_MDIO	1
+#define MDIO_GPIO_MDO	2
+
 struct mdio_gpio_info {
 	struct mdiobb_ctrl ctrl;
 	struct gpio_desc *mdc, *mdio, *mdo;
diff --git a/include/linux/mdio-gpio.h b/include/linux/mdio-gpio.h
deleted file mode 100644
index cea443a672cb4bc466b7844756aa6261fca864e2..0000000000000000000000000000000000000000
--- a/include/linux/mdio-gpio.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_MDIO_GPIO_H
-#define __LINUX_MDIO_GPIO_H
-
-#define MDIO_GPIO_MDC	0
-#define MDIO_GPIO_MDIO	1
-#define MDIO_GPIO_MDO	2
-
-#endif

-- 
2.47.3


