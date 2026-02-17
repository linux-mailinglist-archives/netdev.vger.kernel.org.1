Return-Path: <netdev+bounces-259126-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCxfAya1lGlbGgIAu9opvQ
	(envelope-from <netdev+bounces-259126-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:36:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B4514F35E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 19:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD6EB3016ED6
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202437416F;
	Tue, 17 Feb 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PJoYPYWQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EQlh43wh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099A36F409
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771353366; cv=none; b=G/5Bpy1vZoPGNymrpSzjzHg+PR2T42B6VMS2BA7YvF+YxLBSrLOdrTS6lv/OUpaAPKyRjGhWM91OAvkOcGMDqZe7pRFZfB6Ma7KIBaR8JP+veZdzaE2zrNUpOnwG9Qw8GiqYa4jvGg1dCIHp7Ykfzsq8WRG4EgHlCf5eWqg5Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771353366; c=relaxed/simple;
	bh=9uAHBw/2TpRNgIOnjFladpYu34dzrYRFTycnroCjZ3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP5aCt4Mfo3vxsJCBtM4Wima4X6VpMJy1Q7yfpAI3N2sWNmmzKMzAwO/TBJN4IOm2TbMVsd4eX+JT3y5QwLQfUrNJSD4uTNtEzr+ZLZTAycn7r5uAAH5T6dqU5r1eOmevRgGg0jiz8ZxHUx93Ju09L57EPhcK/kwR7Az2Pwq42M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PJoYPYWQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EQlh43wh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HBqWjL919268
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uMrQyicAZEEqH/BJVyGmHveM
	n6L1dPKlkyYCF6REmA4=; b=PJoYPYWQuUsB5FEZvA830Cal0DSGAMo+QGMVb6W5
	+dkW/CDoED86KiVFlyG//hqnjoEscrW4RLYHTuM9ACB5yFBkz1qYTYyJrbsef951
	j1iRi75pMnls7+m0t660Cuu1/7TRi6O1B9IgeLY2ZpQijJ+IfsFmsr8AsFdoCsu8
	GnvCWUwr0VmtccVe2H/8bIP+CnqKzc20mjEFOJWZBeAgDweS2CeGT2SoULFxFlbJ
	VXC6CkXFWByQXTsusr7jbwnJXgTIZaa/gjd6wba+gTqepAPx2QNIzf7W9gqMc680
	7UUdi6G34Dgvr7IYZu7HWjYs714WfEzqQrEJWJtrKmoP3Q==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6d83htw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 18:36:04 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-824ae2c9ff4so11707608b3a.0
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771353363; x=1771958163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMrQyicAZEEqH/BJVyGmHveMn6L1dPKlkyYCF6REmA4=;
        b=EQlh43wh0pWL0DZ4c93zftY/0a9g0V8MbzdjLUer1KlqselAaqRNBxydGl52mmz/El
         L+u793fE+13cxvB0pUIUjD5jQKB+X3oEscG9GG5KvUGkeEcuIv82veyEn0tQN/px6Xrp
         yHFieqFrdl/cdW9E55EVi7vyeAE9iRzi/wo26Oas0pdZH0r0cySgePgdb2e1bmtM1mQe
         4HyeZvng/kc376siqMaCAhVLoolCU6VuKiTXr8H/Sq7aVpajZ5IcRLdmZy3EXten+XQk
         L4QdUuXSlTd6ot6bAi9RAOT6zOKhNLqdFe1jGKZKRDTjtkGnIdmdcCRTqfh2/8Mz9482
         +V0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771353363; x=1771958163;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMrQyicAZEEqH/BJVyGmHveMn6L1dPKlkyYCF6REmA4=;
        b=cJ8eLpzaF/bJXfcHezHydnDhoWQThp2HMUIFqi9zreYSrDkpK8exGftwF69gH+DyKb
         BdmUnKV7vCONfJR6NoITGTlXETKKgweoxmxA4sch2mV28YMs/D2dLtmOt33Ngl/KcJHT
         +Y0SAL8rrE+nEzV/w/E+e4czeWlvCjGVsMPnxGY4mtQiBKugkiKCEbPzkTHbDdnF+uon
         gKuKxgNcz4caioBqNrB54f4+X0c3Klz8Wq5I/Jnmww4AiujRFpFT/fjE2SLIcPfE6WvY
         tE2LJkgMJZCPWVUhhokXqHTyu2RvfP3e8AhtLpxDZWBnG2tmj0Dl+nrukDpNCfAwKi22
         fRCg==
X-Forwarded-Encrypted: i=1; AJvYcCWjfuclhNHoahG011OnQMwMCzWdFMsxYezzuqYpM1NaMrJxSf1WPkdHDl0khZQlLLMNHYt8SQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOGf1bmVwJM7t4nGdci0hb/TU22dvEzRlqib7fmMH839217FSG
	4CFWSPeMK4bjuUu6+zx9IC0S3rOGrn83diZP1vbYm0Niodrjag2S2v20oYWuOJkHEj+CKuHms2u
	oAaUeopG/7BwIbzyyK8RGzI9UtSBhPSt0Fy9SUYwh9lBhLqn199F3LfqQexTBl/0/W00=
X-Gm-Gg: AZuq6aIz+VwfUvMMy0gwVPjKyRm5IUcOLuxQvRzKC3XmEVq+5aR680oL0kXSsf7NyTd
	I/gjI9wXKndGHz/07kMLSdr5vn3HeXfKsH+VADuAQ86+V3mDHAXZRkR5CzoY47/hSHxLSRDF/1K
	Z5ZILCONFaKH+siglcr9D2Lk6GTl5F1pAtSjMgjTApqjuJdZACzTvsgQRXjfIEYKjlyCffba70r
	CM9LynPx9G3CCfjfQs6xb2CWvljNdvyBlKoEpEgkjGHcMg0MAtpxTrkkI4CcNRoUUJbJNYCmarb
	4tNyJ/H4QT8uuJ6Od8Hak2EK2Te1EEqWQLNU4IkDl3l1CMh0bAi2UlmHxh+Gh8Ytcf5TCbqQXhy
	AjzQCC3H/W6MK6QBQQM47EgK06u+agH/8A24=
X-Received: by 2002:a05:6a00:808e:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-824c5ea230bmr15684879b3a.11.1771353362500;
        Tue, 17 Feb 2026 10:36:02 -0800 (PST)
X-Received: by 2002:a05:6a00:808e:b0:81f:5037:a317 with SMTP id d2e1a72fcca58-824c5ea230bmr15684842b3a.11.1771353361950;
        Tue, 17 Feb 2026 10:36:01 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6b69b13sm13401027b3a.30.2026.02.17.10.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 10:36:01 -0800 (PST)
Date: Wed, 18 Feb 2026 00:05:54 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Frank Li <Frank.Li@nxp.com>,
        imx@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next 3/9] net: stmmac: qcom-ethqos: change
 ethqos_configure*() to return void
Message-ID: <aZS1CigRWTH12scL@oss.qualcomm.com>
References: <aY0aJppQWUC52OUq@shell.armlinux.org.uk>
 <E1vqKP6-000000093mN-1IDF@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vqKP6-000000093mN-1IDF@rmk-PC.armlinux.org.uk>
X-Authority-Analysis: v=2.4 cv=bqVBxUai c=1 sm=1 tr=0 ts=6994b514 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=OS3fFONSsTUfBaauNq0A:9 a=CjuIK1q_8ugA:10
 a=2VI0MkxyNR6bbpdq8BZq:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE1MiBTYWx0ZWRfX40ttIEWGXl7v
 /M/2Pr/xhGR+8F1JtxUu0+c12eDzhPDLcOzBRtzMMGvOemY5Nn9aV4W/2vstr/tRnfGWNx3wrve
 C4uV/YtFgh83I/1CJXhpsqyf6r9O8k0Mrd1x2s6K1Mu43iDSByJXKWc/molJFW9h70RyTfE7BhH
 +UieMT+FDz1r5E6JyaDl4QhlOcAWmbfKPrFSWxCNp43CyoozzYvwmKIg69K/BrHtUSWfKACPBE9
 gRIcYs6sMcFpclJBtentrJZ39m/KqN6DosSLubRPNa5oonP2b22xeJaqIbU4+WRd97oFXRZakaU
 OyNqb+E42x1oyZi+EHAAtHig998Myfnzi7Kg4VRbq9c4XN65g0SmmnDXBZJdrlHZYsDE4+65Me7
 DThfI1gZxn0FXN1bmsB6OFcPWRtPEiteTKJTfWaoMTRe3xryFkUR8ZPFQB4KTiJkT0OcemgpoGY
 Ot9SJolg09tTjTJBtWQ==
X-Proofpoint-GUID: kX8sJ0bkvIyBE4PK2j12yhy-4ae-zfNN
X-Proofpoint-ORIG-GUID: kX8sJ0bkvIyBE4PK2j12yhy-4ae-zfNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170152
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259126-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0B4514F35E
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 12:17:56AM +0000, Russell King (Oracle) wrote:
> The ethqos_configure*() family of functions always return zero, and the
> return value is never checked. Change the int return type to void.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

