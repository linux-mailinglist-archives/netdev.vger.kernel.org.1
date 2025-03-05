Return-Path: <netdev+bounces-172021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFBCA4FF25
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BF28188EF9A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F285D2459FC;
	Wed,  5 Mar 2025 12:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TrEiBR+q"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855382459E4
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179446; cv=none; b=uQQtznPHGYlxVXh2O1LxVHhgieqB3IiPjkGSjCFC3L0SVMBYAGqNNXHYqqauUO3H9QsAC1TtYlb+4mJZVyB8uG83vDrAmbIanbaS8I9zCfBkHt4Ca1gDx5/hChUoIYqFm5PVF7B/6N0J6sOMGF9ynCCTez3DdcVQhCZUw1laWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179446; c=relaxed/simple;
	bh=qjSF8jIRsyMelV93W+KQ/HryVro6SXDF1wbUHAP7BD4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:References; b=qj0FFhx1P702qzUYXMsNzQVJDwp7YVwvWpwVP8OMCRZK2o3WdZMym73+FjafMAuYO9VBT3tFToHyqBK6EAh4/U8TGdYBZSs8V6wFvIdzBWkBVJbvii/sxymBC3TSxRHazM345FhxpZ04rlI4qaw1CPrpb+5IO/A91gheY1OHkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TrEiBR+q; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250305125721epoutp02615e391a508cb650a0ecc55509045aca~p6XoqMRsx2159121591epoutp02v
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:57:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250305125721epoutp02615e391a508cb650a0ecc55509045aca~p6XoqMRsx2159121591epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741179441;
	bh=gJTqKRJTpfqMnnraspq+3qUtcX/v+MUuDyp6qyCY7XA=;
	h=From:To:Cc:Subject:Date:References:From;
	b=TrEiBR+qekez73eASU67U0y/yDFMf9a4B4QZ3x2gWgV0ONTppcAoHtEfS4b+vhCIr
	 yjSHEhyC/Hk8BH9UnmjgtLufHxOv3Ckq7Hg0K2GbkrNtgkyVCix1SDv1WR+Zv0/NNV
	 jKKFO1T8AEeadxxhDl67y7LVgx4pZTb7LSou6ysM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250305125721epcas5p498e06039d06bb7590aa3a595aeb93c36~p6Xn8tLwm1019510195epcas5p4U;
	Wed,  5 Mar 2025 12:57:21 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Z7CHz2Cztz4x9Pr; Wed,  5 Mar
	2025 12:57:19 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.23.20052.F2A48C76; Wed,  5 Mar 2025 21:57:19 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250305091845epcas5p1689eda3ba03572377997897271636cfd~p3YwvyTxk0290502905epcas5p1W;
	Wed,  5 Mar 2025 09:18:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250305091845epsmtrp13ce4349a0492a94ea7ad1411fede4ade~p3YwtnWv21941319413epsmtrp1Q;
	Wed,  5 Mar 2025 09:18:45 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-31-67c84a2fd74c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.0F.23488.4F618C76; Wed,  5 Mar 2025 18:18:44 +0900 (KST)
Received: from cheetah.samsungds.net (unknown [107.109.115.53]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250305091842epsmtip281fe6bc11cada4780d723a78c6d42ca6~p3Yt_mHXc1556215562epsmtip2x;
	Wed,  5 Mar 2025 09:18:42 +0000 (GMT)
From: Swathi K S <swathi.ks@samsung.com>
To: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: rmk+kernel@armlinux.org.uk, swathi.ks@samsung.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com
Subject: [PATCH v8 0/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Wed,  5 Mar 2025 14:42:44 +0530
Message-Id: <20250305091246.106626-1-swathi.ks@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBJsWRmVeSWpSXmKPExsWy7bCmlq6+14l0g7OzeC1+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW9w8sJPJ4uWse2wWF7b1sVpsenyN1eLyrjlsFl3XnrBa
	zPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc97BZHzrxgtrjUP5HJ4v+eHewWXzbeZHcQ9bh87SKz
	x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snlsXlLvsXPHZyaP9/uusnn0bVnF6HFwn6HH501y
	ATxR2TYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbmSgp5ibmptkouPgG6bpk5QL8q
	KZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgpMCvSKE3OLS/PS9fJSS6wMDQyMTIEK
	E7IzZr44yF7QIlDx7tJhpgbGybxdjJwcEgImEjdWTGDqYuTiEBLYzSjxcM58KOcTo8TNtX1s
	EM43RokvT18ydjFygLXc/mIP0i0ksJdR4uD6QIiaL4wS+x9dZQRJsAloSFxfsZ0dJCEi8ItR
	4sOk08wgDrPAciaJ0w+uMINUCQs4STw7tQ3MZhFQlfhx8QaYzStgLXF58z02iAPlJVZvOMAM
	YZ/gkHh0WxXCdpG4cf0YE4QtLPHq+BZ2CFtK4mV/G5QdL7G67yoLhJ0hcffXRKiZ9hIHrsxh
	AfmGWUBTYv0ufYiwrMTUU+vARjIL8En0/n4CNZ5XYsc8GFtZ4u/ra1AjJSW2LX0PtcpDYu7f
	g8yQUImVODXxPOsERtlZCBsWMDKuYpRMLSjOTU8tNi0wzEsth0dUcn7uJkZwEtby3MF498EH
	vUOMTByMhxglOJiVRHhfnzqeLsSbklhZlVqUH19UmpNafIjRFBhkE5mlRJPzgXkgryTe0MTS
	wMTMzMzE0tjMUEmct3lnS7qQQHpiSWp2ampBahFMHxMHp1QD07aiRjcOzdlXPn18OllKd5H4
	0v6L2xsPG05Riw/Ve7cofZLu1OR1YTL/TNbvYKi8qMKiEXZcPU387B/TqAkTHmioHN971sA/
	//zNtT6vTjXoNJfzu2hb35zbqRkRF73TLib60Ymy1d/805i9So8/khJd88hak/VQWAu3zqHM
	ZAkdw10lZ0JkP85Ry61cvC0/Zu2UooptT7kf7OJVnMal78lj33e3bEdb7Ebfz9/jS2bM3+G6
	bh17ufnWL7Ln9gWvmOm5JqD6dMOxg1bHoic5/JvAeWjfE9/VwempHZNM8vX2Jj6JY1hfElyX
	VOhVsK7ntkpj3dopBa4tSS2Ojja181taI9aLJGc7zj9ovWKpEktxRqKhFnNRcSIASn7S80sE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO4XsRPpBkubbSx+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW9w8sJPJ4uWse2wWF7b1sVpsenyN1eLyrjlsFl3XnrBa
	zPu7ltXi2AIxi2+n3zBaLNr6hd3i4Yc97BZHzrxgtrjUP5HJ4v+eHewWXzbeZHcQ9bh87SKz
	x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snlsXlLvsXPHZyaP9/uusnn0bVnF6HFwn6HH501y
	ATxRXDYpqTmZZalF+nYJXBkzXxxkL2gRqHh36TBTA+Nk3i5GDg4JAROJ21/suxg5OYQEdjNK
	NDxmBLElBCQlPjVPZYWwhSVW/nvODlHziVHiwnkREJtNQEPi+ortQHEuDhGBDiaJPVNPMoM4
	zAIbmSSOXdoM1iEs4CTx7NQ2ZhCbRUBV4sfFG2A2r4C1xOXN99ggNshLrN5wgHkCI88CRoZV
	jJKpBcW56bnJhgWGeanlesWJucWleel6yfm5mxjB8aClsYPx3bcm/UOMTByMhxglOJiVRHhf
	nzqeLsSbklhZlVqUH19UmpNafIhRmoNFSZx3pWFEupBAemJJanZqakFqEUyWiYNTqoEpoHCC
	ttuC1inW+vJHT15hdnzD0/jeamL8ktfhk5JzeBebJ594adLZ8OOA6/IUd91dJSm/WGSvXlFZ
	X+PE/9Gk4zDja7tzV9nyXgteuXiyq9HzXmuc8ucFvEcLbzWvvxHKcixb1e2r1+qN/zk/tH4W
	WHd5/qFdh69MPZAttyhphw37t2WBraf357Qwv3X9YPFiFqf8g6cee0RqOWUzK5bWddseZIvu
	Dy05No+J+bOFNpeK6imuOb8D9h/nEjC/YvtV8r/29qtPH2VEbW97dXtrTPihIqlXHRNlN755
	31nRncIXH75veqLB5f2rXzX9bp1dVxnf3z3p24rOlFNFSvr/127OUd2lcelzGqvR9q/JSizF
	GYmGWsxFxYkAIH1Iw/YCAAA=
X-CMS-MailID: 20250305091845epcas5p1689eda3ba03572377997897271636cfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091845epcas5p1689eda3ba03572377997897271636cfd
References: <CGME20250305091845epcas5p1689eda3ba03572377997897271636cfd@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

FSD platform has two instances of EQoS IP, one is in FSYS0 block and
another one is in PERIC block. This patch series add required DT binding
and platform driver specific changes for the same.

Changes since v1:
1. Updated dwc_eqos_setup_rxclock() function as per the review comments
given by Andrew.

Changes since v2:
1. Addressed all the review comments suggested by Krzysztof with respect to
DT binding file.
2. Added SOB Swathi.

Changes since v3:
1. Avoided using alias-id to configure the HW.
2. Modified the clock implementation.

Changes since v4:
1. Avoided switching between internal and external clocks for every open/
close.
2. Addressed the review comments on DT bindings

Changes since v5:
1. Addressed the review comment on correcting the intendation.
2. Corrected the compatible name in dt-binding file.
3. Listed and described the clocks in dt-binding.
4. Modified FSD probe as per the changes in the refactoring patch given
below: https://lore.kernel.org/netdev/20250207121849.55815-1-swathi.ks@samsung.com/

Changes since v6:
1. Addressed review comments by Krzysztof on dt-binding file regarding
clock-names property
2. Corrected indentation issue in dt-binding
3. Addressed Andrew's comment on listing phy-modes.

Changes since v7:
1. Modified the example given in DT binding as per Russell's review
comment on setting clock tree in DT
2. Removed FSD probe since clock tree setting would be done via DT.

Here is the link to v7 patches for reference:
https://lore.kernel.org/netdev/20250220043712.31966-1-swathi.ks@samsung.com/

Swathi K S (2):
  dt-bindings: net: Add FSD EQoS device tree bindings
  net: stmmac: dwc-qos: Add FSD EQoS support

 .../devicetree/bindings/net/snps,dwmac.yaml   |   5 +-
 .../bindings/net/tesla,fsd-ethqos.yaml        | 118 ++++++++++++++++++
 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |   8 +-
 3 files changed, 128 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml

-- 
2.17.1


