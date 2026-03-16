Return-Path: <netdev+bounces-268093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KABgLCLXt2kwWAEAu9opvQ
	(envelope-from <netdev+bounces-268093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:10:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FD7297B4E
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 11:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4122F3070374
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 10:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D4338F647;
	Mon, 16 Mar 2026 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WGyHpnek";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gZssnYhX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD7338236E
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655461; cv=none; b=UPLgf7mX8QCA6SDiTqxk9qvgqeYRQq+gnTjU4Sj+P7jjqTL5bdY6n7KcuBBUb4nDDzNCIzeBeXeeqOa1YdQgPEitdB5skZNnrZhDPZsR8/G+uO0t0e2+uFLJ66lqlYeVn7irbrCSkGtjukQfgVStOGMmZ2WgsfwcfExO7Imb/fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655461; c=relaxed/simple;
	bh=jpBPIFlugcb5aVhRchlZ66Jv7jBbvLQUxCb+TRtYfiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e0dYcNySfYKtUGl/k1jNU5TK7x9eGF+/aij6YukjcnHQu26h9aK6sePZSkYaSXnPp3g+YQm1RvUKHR1z4tCcTA6pPp9CagGOrVqSCwDuzi+5JAewMu5ICByiSBxDW5Oxt/JKrarEBIuD3w6cNnMVsxx7lgF1JoA7NIffjehyC9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WGyHpnek; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gZssnYhX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64dY83777679
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yrYx7pOJTaptrV0FL6njnQf/0Yp/jiuWPRNlZw9drdk=; b=WGyHpnekF/80JPSo
	vKmYoFHVHHA9EWI4JOkVxC1loagvrpa2XWj9p+hLqt/u4A2sA/BBAn7+2psq4kvv
	eJt8l6k2Fh5Etr4IJanKoxVxoDT9bnK4aKqVn5IHx5V5Z8r5rGKgE0uEyWr92GN0
	Yy2Et7qv6hNVOjRxAKP0h4MMe6Js1FO5iuV5c/fnZbUqMQwtlSZpCswg8XZQN3YM
	IEyNHIHQMrfHhklAcnBeJo7pOqGam1JTMsPHfCcypDEZVWLfapLVzBlu+IMsIjsB
	hLU2FC0i/zHEgwMGxxkbzjyD1O/DdCcwLJUkYI7P8rDxeqe4N8Srw79CYjoyfPqf
	ECONhg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7w220-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 10:04:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cdb995a1bfso2807873185a.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773655458; x=1774260258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrYx7pOJTaptrV0FL6njnQf/0Yp/jiuWPRNlZw9drdk=;
        b=gZssnYhXxl0YO01Eu2vq5hn+TAqDXq49znLnT+bWWD1QZkh4yrpZ9otPTOH+cqVRwY
         xpqJdbitI0aevLdrmGcGz2kWB0uvX3sKudFBYbKU9ok84+d0dKU3v2JYMvKaRANfqGmJ
         CF5V0+oqOcrC1XT+2jBug6gL9jZMziKRmHk+nDzawAb7Q+3AKhR2zbNiH7LqfWBHk+v9
         nrYaoKCGqieQHnxcKEL76+0J5MM5d/Ntgbd0fnX38NUcCrfsoXWj2DlaA0e+Csge5LcU
         IWQiX6uUcBfqDXK4/FCqy+SUoa3LqjiaWlvQI0yCChFs5/60VzMFO/0BwHanqpDxehVW
         a6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773655458; x=1774260258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yrYx7pOJTaptrV0FL6njnQf/0Yp/jiuWPRNlZw9drdk=;
        b=mbmgK8M91hZmp0g6i0LdV8StHJlhBY0H332I0Cy3mnh+Mh7b1EpYYfRuN1ndOMoBSe
         aSnE3iR8lGOetMFBjI2lhfRkXxRAgUfKgF6tk8nZtxhuRWHtHwgClHUd+2O5IxMUPlrP
         V+wlaTd9+BSw8CZSMWG0+01P4dRPYByeQhghEBUGvQ7UnranFEwHMaUO3IGwaYFxoZ/Y
         am0z6tpsCoFFqOX6GoXUGgZkCGu+4gP7d84SVufpyVqbTfIAStQs1ga4+xftbI2Nv2dh
         zi8M+qGs4svgqDRS5R9pys4iShCAcM9/JeZwh/y+/UNly2a6m5MU/upaewToJMnJyC+a
         Eccg==
X-Forwarded-Encrypted: i=1; AJvYcCVJB6NtSnwZK3iyOsoXf0VMOVlYauPZnsIOy0d7BrAntBloftr6bIj86B1zDO/UWGhbdWRxw7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsPvyouS1QoAyqYbM4xZbdBKS21waLlk72mn6LIIAuuAGewrK/
	mRSlGpdzry5YrOIzsa2BN4PXGKHB0dd8dK/9rr96PpLw80GfaPRIEqocFSn2xwbOLiX2+m/7Td3
	dzAuaGXt3QlMl90XwRAa1dJAVjglk5rrNVHkBTGNDL+CalcqGHJ/79N5GViY=
X-Gm-Gg: ATEYQzzZsbjzRMQDIyKC7+QCJwblE+sljrky5ECidXOswdl3gaiE2xfAyn8714KAZak
	OpVttSJLvOYAHPOTmm939FzD6wekfUlbNYugy7fleOevhh9Qy36jYnCyKht1nuxvLfRyrtjO7Tm
	afUV45lt7br1Qj1CjpMCAWkxzaF+a1LgbX66UOiZe/74aBKhUfkGIkVJgJ12lVoUNbWatOeA+wY
	Oj5rftYUUWSSoKs6/Iy16iEoT1Q9VklwKJZmO8TU0gsTmSn0AeqwsIb2Wo4uQwv2RRtgVWd6rM+
	jPnzM9yAaE3JqReswA1UyveEqb9YcjOw2ttJ4wotKIg7zGRQOy60rbFRJov/w+8VPs1qDA8uCEi
	ghCzfolP09m5ajKFY36wrXjRwdf5ZLjkqICg5xeWddn23lt4X9aN9
X-Received: by 2002:a05:620a:46a5:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cdb5b25d0fmr1622435385a.45.1773655458549;
        Mon, 16 Mar 2026 03:04:18 -0700 (PDT)
X-Received: by 2002:a05:620a:46a5:b0:8cb:5176:f00 with SMTP id af79cd13be357-8cdb5b25d0fmr1622432485a.45.1773655458121;
        Mon, 16 Mar 2026 03:04:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b457cfa07sm5065465f8f.6.2026.03.16.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 03:04:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 11:04:04 +0100
Subject: [PATCH net-next 2/2] net: mdio-gpio: remove
 linux/platform_data/mdio-gpio.h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-mdio-hdr-cleanup-v1-2-2df696f74728@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=jpBPIFlugcb5aVhRchlZ66Jv7jBbvLQUxCb+TRtYfiI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9WbuC/BsY6MToC4p5/n6ke52twmrjj/0WGzO
 4njlPqRv3CJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfVmwAKCRAFnS7L/zaE
 wzPeEACQHgTIBTpaYinuptwVwMPkMmQo7z9GS0OHW83FXMIsbZJXYuKaNihIsVoYQBU6ArB6xut
 r+UXeZpHLSDn6vwZKLiG+qPHABOV4ZsdsibKu8tckZ9Jbl1BL/SH5UeV99ygU96lDSkQF993TFO
 nWMAZCVOYMnQwAocqZg2Q93LLas8ncWXHAiG5UZgvkR7MMfVlX4dEMpxrU7hL9fINra8b2E6wkG
 DJ6DRUuuo5VCEv7VAT9/VdQFFZ7mwImdBTfrHtHXN8XnNfKUk8c0zEehByS/P8w/MmksVX+JJnr
 9xGxcUkGR6TufOD3EWB93zduQ4FXFhJdvulkc1y6uCIPQnPeVh4D9aNJJStLX0WYV0yeKD9dpEv
 C+Hi9wpShafc4Mc1GJZ2IrXIHgGV5TYH1+VPFBzs4iyhnrm5wUsPRvySIBEIpJeXgsICd/VSNky
 5es9p4RI3Y2IYIxMmRM3tIvXYnOCee12v1P2A5pWVonIIvX/u4UKdO8GFn8W/lD86g+aSUTqn7K
 L9EsL3gN+01agoa+0bqnNBy86g9xTol8OR8mIvi9S73hyf0RNuoPYDcbrk1ZBFcWcjL2ZmTC2vZ
 Za2DnPOBd6Y0wjF0DdumLNlSyjTTonnTWRyxF/mmBsoBg9nq+XPL0MG4q/JBS50/OTEprs0fhZ1
 ckr+qe7ol7umeDA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: rvglVt0UX9R9MwWKVKVTu2M-t_6ZgKdl
X-Proofpoint-ORIG-GUID: rvglVt0UX9R9MwWKVKVTu2M-t_6ZgKdl
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b7d5a3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=pq9OI2qBjpj2ol0dRqoA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NiBTYWx0ZWRfX4pH8+LyDK7BD
 utURujje4bJ7DBHrBDK2KfMQF6EJ+C5JVtxxHn2NLHSyMDMInbmgni689aBtpKnoY4dXvdRpNkh
 9GjJ+hD3Jg1vo5RorVTm9vqc1KebSTKDFvaIe0tTU6IFzeadEI5vhr/QHhmYJoJn3b8beW4zcQP
 cjJTaKqVvmCTAKH1xoOAusDgBNL43psqUh8dc8JIkgF8UmgocnuEG/T4Lcv2JJeTQUpVLsGLcTC
 j72WfmGDvzir8QG+qUF8K35huCldVPvEVeEAERpggz0U75RViv6wFUKnDZAZPeVx3fVIx9ASfgV
 rciZguTp2TFXbYo3dJuL8gmx+6XOoMf5mE+4TvbuLmi12sVrX8WqlBX/qfB40wks2p/LBWxCq4n
 4aSQpN2IE4DOgMJbjAcCpGPrbpwfGPjEngdfO6Lr154KdPc6+f9L2v/SaO7DuoXgYfamUMF86MV
 8tM7ZCPK3K7WO7pv3cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
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
	TAGGED_FROM(0.00)[bounces-268093-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 37FD7297B4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nobody defines struct mdio_gpio_platform_data. Remove platform data
support from mdio-gpio and drop the header.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 MAINTAINERS                             |  1 -
 drivers/net/mdio/mdio-gpio.c            |  7 -------
 include/linux/platform_data/mdio-gpio.h | 14 --------------
 3 files changed, 22 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4efaa76a0e6da830438661d2e5eb5095e4eb5020..50fd7077504683f557d730a3acc88babb0861909 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9593,7 +9593,6 @@ F:	include/linux/phy_fixed.h
 F:	include/linux/phy_link_topology.h
 F:	include/linux/phylib_stubs.h
 F:	include/linux/platform_data/mdio-bcm-unimac.h
-F:	include/linux/platform_data/mdio-gpio.h
 F:	include/net/phy/
 F:	include/trace/events/mdio.h
 F:	include/uapi/linux/mdio.h
diff --git a/drivers/net/mdio/mdio-gpio.c b/drivers/net/mdio/mdio-gpio.c
index c993108898964bee9048a19c40e9de4e5c943b48..958d1c6608ab76b8761d9d9f68d67311cc06fc98 100644
--- a/drivers/net/mdio/mdio-gpio.c
+++ b/drivers/net/mdio/mdio-gpio.c
@@ -22,7 +22,6 @@
 #include <linux/mdio-bitbang.h>
 #include <linux/module.h>
 #include <linux/of_mdio.h>
-#include <linux/platform_data/mdio-gpio.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
@@ -113,7 +112,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 					  struct mdio_gpio_info *bitbang,
 					  int bus_id)
 {
-	struct mdio_gpio_platform_data *pdata = dev_get_platdata(dev);
 	struct mii_bus *new_bus;
 
 	bitbang->ctrl.ops = &mdio_gpio_ops;
@@ -130,11 +128,6 @@ static struct mii_bus *mdio_gpio_bus_init(struct device *dev,
 	else
 		strscpy(new_bus->id, "gpio", sizeof(new_bus->id));
 
-	if (pdata) {
-		new_bus->phy_mask = pdata->phy_mask;
-		new_bus->phy_ignore_ta_mask = pdata->phy_ignore_ta_mask;
-	}
-
 	if (device_is_compatible(dev, "microchip,mdio-smi0")) {
 		bitbang->ctrl.op_c22_read = 0;
 		bitbang->ctrl.op_c22_write = 0;
diff --git a/include/linux/platform_data/mdio-gpio.h b/include/linux/platform_data/mdio-gpio.h
deleted file mode 100644
index 13874fa6e7679fe9754479621adcab0332312356..0000000000000000000000000000000000000000
--- a/include/linux/platform_data/mdio-gpio.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * MDIO-GPIO bus platform data structure
- */
-
-#ifndef __LINUX_MDIO_GPIO_PDATA_H
-#define __LINUX_MDIO_GPIO_PDATA_H
-
-struct mdio_gpio_platform_data {
-	u32 phy_mask;
-	u32 phy_ignore_ta_mask;
-};
-
-#endif /* __LINUX_MDIO_GPIO_PDATA_H */

-- 
2.47.3


