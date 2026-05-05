Return-Path: <netdev+bounces-284517-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKbbOHMe+mmzJwMAu9opvQ
	(envelope-from <netdev+bounces-284517-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A59944D1902
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD354307B04E
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C126A49253B;
	Tue,  5 May 2026 16:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OjftXHJV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R5W2uVyS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A982C15AA
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999365; cv=none; b=uDbk6TkVvuY1qfpqD6VVoFZFd4T0AF5SdXtusmz4+7asOVelIYkx2wHFZjt23qU9AnwiRIA3NwGj3IvbiUw0jOhloh+C5oDeUoVbneVjtpIPFmBYGnnAQMOSO8wB0xd62AW6q0vpZWGhnBXiMBW39lFkx1bZD7zcCMTmqkWLKUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999365; c=relaxed/simple;
	bh=XWisdthpXEsZ1h/uQy51Wp0h5gBanWMeshjhe0Ik7mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYPaxLDEqsfVx6wEYOiyi9dkC2HT6/+4m9pzHqlfem5L2EnEVRYblhagdnPI/P3IR8+HUvmnSmciFPP3vL71uRzYs4OMCdYZEJ7XBWadKkdlDvgR0kHyfUCZX2G6Cdz/vC+DWd9NIZHEZBIe7a1fE3IDR3dtFduXRkk3yjo658M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OjftXHJV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R5W2uVyS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DCwwo3187655
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 16:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=iAYFcoBuVm/XcG40EG9yN1cf
	01dwHoZZydGSBQe+fRk=; b=OjftXHJV19fGxCUgY3Jz9FOUwuFlMyIvE2v9eq/r
	Csyto4GYkW31L5U9eST4MIKUcvENbIA8pp6Ma1FUOidL0K7MOjMfgjXVL/i0FnDA
	XphMZ8h4+N/0ZYpTL2BPZSQhxPzFo/K2KcmPT6DYB+4UKJ+dwRrvZoCKCj49KgJH
	7c718rJcgmjNAENjF1HDZTYX7JCdBHeSLp6Nn7tv8gPxJp0fMji/WDDx6CJCZaYB
	pu4dUwRprcupX2wyhzbWr/F8IvsWvCJJjOU9ScFdQkHTZVUoPg4jrN1N4dWw7f1W
	YfBe34FRZkVd/mj00lulLO0reQND555HWK3GlKXbsaM5bQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dybkkab6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:42:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fec175so73918465ad.2
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999362; x=1778604162; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAYFcoBuVm/XcG40EG9yN1cf01dwHoZZydGSBQe+fRk=;
        b=R5W2uVySS0pmd5cxcj13xoQMlKnhDyhJ3FyNH1guubs+B8FKBYog6KjcGw8GLymdfb
         q+idn8NadUnJen/L41Um04wHtGUv2qwV+gSH0fQM6xFaiWPdSg/dOIRMp3sTQ7P6PkpG
         Z4WZoTpMTdnjhnoLeiBFGG0/YOsq57ydnFt5Ilsf1ar+IUM6zoF+O2bWQr7O5/Noum/R
         uZcxOiIrlvfm95YyjBHOElvpD9ij0tS8siU4l1GEKhND5rCVMQdRd8zxzcfdincFsna4
         VRt14laUko8d+1WHvHwWTmOsbIL9Ui3LLiaLy5FrCSMZJ5uQb7aDh5BoKya64zoo6J9O
         5aAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999362; x=1778604162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAYFcoBuVm/XcG40EG9yN1cf01dwHoZZydGSBQe+fRk=;
        b=eiYE+Zg32gux+PQl2313ICxdjJudI8S8g4rMWnKXCaDVDpxXipcYpSMynS9cs+4bd9
         81s6DG0ROrDYLJrC5xJPXWDnY/R0YbA6ZHaLV2bdYM9jV1JXXnxeWWaOUlhS06bGOMpG
         A9i+uY5JGVRNQ11zCQZgxD02Av0jfuvxjpnPvl8Xk/5LJBp/YNLyCz48TBoZnEvOVhUq
         2mApR6iPMOtZuTEjccVoswtLoD9/XtW4PaDqswPuVkWaIwgG6fLlWwKtZa50w4BVWKev
         BQBmcuAGGoXHwdxEz2yn9zDityu9efZJhnbddTs+8cl+UjHt4M9ugch/N9KDOjPJNTsR
         2b1g==
X-Forwarded-Encrypted: i=1; AFNElJ+/MWG2ffWyUchH8AK8DrTHHvpQImVcLFkTT2OyGdvDSgreENQwSIfWOrGoVjej9q84UTWmRH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuFPavjjaCtW3DhuzGhPwjZk/bgSbpXD8QNzXWmEM7DWdEjaHv
	SLw6RzM9WVZ4QT76tYXbl9hu7UoiI3RTEP/kfzrI9I7380c9Pe8NSSfr7YJ8bWwP8cvgoIm8rAy
	nCsw6VOoX2wzv5U4gmeyh6jDjtiL9ehlHERr5XgdwkyrqHq48KgKjtB5FaC0=
X-Gm-Gg: AeBDietK0hZb/x3VM3UX4bEHsqkQnHtmHEB3urChhjh5wKrnwE+2YeqYTf4bbJvtHM1
	f1ho31K+yO+WwnqwhI6HvsrD6JBUTs44DqWw2zpeSSIOST0hYMjk/PYO2hb5keXRBoEPhNFRFya
	ua4xzwuSIjVDVdu9DSGIr3aRVNrfU4ywL7ckGf6UjAB9IZVzK8DWCSl7Jqz6pmIETvf/e3Bez+E
	JiCErMz+t9dpTeWO/pHCbCiaKG0E5SyL4BikiSVXdv2WkJmuLbjsnLpIzyQ1CjpoSMNVbEuQS6/
	ut4RO1OYdjeXhgG/jtLWzY+XW7slZsbJNC/uqL96b50H7fzp+DOkL85qGME6RzHeC9x4UA+223g
	QzZcSX8LDmhGylbfuTL2278OQTXl+fmo+DAlgnuinmPBi7A==
X-Received: by 2002:a17:903:2ecc:b0:2ba:15ff:345d with SMTP id d9443c01a7336-2ba15ff376cmr108941475ad.35.1777999362296;
        Tue, 05 May 2026 09:42:42 -0700 (PDT)
X-Received: by 2002:a17:903:2ecc:b0:2ba:15ff:345d with SMTP id d9443c01a7336-2ba15ff376cmr108940885ad.35.1777999361838;
        Tue, 05 May 2026 09:42:41 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae0f6d8sm144847685ad.39.2026.05.05.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:42:41 -0700 (PDT)
Date: Tue, 5 May 2026 22:12:26 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
        rmk+kernel@armlinux.org.uk, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, Daniel Thompson <daniel@riscstar.com>,
        a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
        boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
        chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
        julianbraha@gmail.com, livelycarpet87@gmail.com,
        matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
        prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
        rohan.g.thomas@altera.com, sdf@fomichev.me,
        siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
        wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 12/12] arm64: dts: qcom: qcs6490-rb3gen2: enable
 TC9564 with a single QCS8081 phy
Message-ID: <afod8ot7xb+g0wzN@oss.qualcomm.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-13-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-13-elder@riscstar.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX/6qDPAD00FAF
 DwDngyeqIYZxl3uUOWhlYEz+FQ9qL46UkFjmzbO8k8q71P3dUZVdFTUicAAxiBNbQYXybzozPhT
 wIUnzpQD1QApBJcvxY2+0GnMEmgDnzDSYh9qR8a2xRbJNBJEO5jsO/A/dRp6zMriEqSinYTfWyU
 ZzeL+m9bjqCbdTulGBfF7MtOuO8FQ6hLkBJdUXScNvb/+cSwn6roHj+wsXC250LUffSf7aXYd15
 Drfh6s5rRZPfjlY/ENGRH9yZfNmzj0xyzS1XryvAy0ZwyQwVd9q/uQ7ZEAAfdfV4Ja1reDbP26o
 QABXU0qqwZJaN1+D+u2iMQkXHkXOIjqZboc0e2Te8egfLcbD2WYp47yeJaHlusNhc8DUz7nPwlt
 ZKsVdyhyg1WGHe47XIKuiBv8psuyxaTrmTSiUiI+l8UD6t1hq/Tv7VmJO8Y2cWnYpWkhKgPx18x
 kkU0YBVcmuQRVFnK9og==
X-Authority-Analysis: v=2.4 cv=SPBykuvH c=1 sm=1 tr=0 ts=69fa1e03 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ee_2aqc6AAAA:8 a=lW0hg0oAPnnF6MRRTAsA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=VOpmJXOdbJOWo2YY3GeN:22
X-Proofpoint-GUID: i3QqghvKDIUtDBcod_Yt9Zx_bBhlMspQ
X-Proofpoint-ORIG-GUID: i3QqghvKDIUtDBcod_Yt9Zx_bBhlMspQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160
X-Rspamd-Queue-Id: A59944D1902
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284517-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,checkpatch.pl:url,riscstar.com:email,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Alex,
On Fri, May 01, 2026 at 10:54:20AM -0500, Alex Elder wrote:
> From: Daniel Thompson <daniel@riscstar.com>
> 
> The QCS6490 RB3Gen2 includes a Toshiba TC9564 (a.k.a. Qualcomm QPS615).
> TC9564 is an twin Ethernet-AVB/TSN bridge with an integrated PCIe switch.
> 
> There are multiple builds of RB3Gen2 with components included/excluded.
> That means whether or not there is a phy attached to eMAC0 depends on
> the exact board. However all versions include a TC9564 combined with a
> single QCS8081 attached to eMAC1.
> 
> Add properties to the existing PCI nodes to describe how the TC9564 and
> QCS8081 are connected to each other (and to the host SoC).
> 
> (Note: "pci1179,0220" is documented in the "net/toshiba,tc956x-dwmac.yaml"
> binding, but checkpatch.pl doesn't recognize that.)
> 
> Co-developed-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Signed-off-by: Daniel Thompson <daniel@riscstar.com>

There's a minor typo in the PHY name - QCS8081 instead of QCA8081.

	Ayaan

