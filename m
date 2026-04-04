Return-Path: <netdev+bounces-275407-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GI3BAh990WmHKQcAu9opvQ
	(envelope-from <netdev+bounces-275407-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:05:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AABD39C84A
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 23:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58932300B3DF
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 21:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E02346FB0;
	Sat,  4 Apr 2026 21:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kZ7FaHDm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dy+F/4p/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DB434029E
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775336729; cv=none; b=moWZdPTOpcQoNqu54MzHZje95sMD3aPODiXscDG49mni0vGXNYXnjj7G/5LYM2iJSTfq+PMMpFFMBwISV/S9QcOO9xApm3wSrd+gtOcCi/4PR5e+RD/B6ZDSEYwp3ql/7Db75I5U8orSCPvbdmdtKQDW3CleGCACBYOqp2wJyKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775336729; c=relaxed/simple;
	bh=HM5G1/JGcqaUtlq8xyprvI73HlG9LDW3DZ6aIrro/U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYB4yfWXCKG+WXYHmEv6xET+RS+dU+0QzUM7TJDTjtA0iJW7UyWVlYGhpz60CuiN6iNeHwM/GF/EuiPEmyp/rKVy4G/bwC0SNO35rxGhHjQHxVZQHu+4tyE2q2TwoLIwKgwYoVYRRtnISUTqlvL5d4HKF9Wpp/madaF9CEqy1Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kZ7FaHDm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dy+F/4p/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6343dxMa097814
	for <netdev@vger.kernel.org>; Sat, 4 Apr 2026 21:05:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=cTrkVv7RxA87UYtedNu+KTup
	uZyd1sP6sRCLIISx6CQ=; b=kZ7FaHDmLXN6oTi6I5w9qG25oUao+k+BaNrSKKUW
	uxoHpRmE/Yri3KEKo5BjwBvKhFmmew5GTPrRYRPmlRaaJK3is0cjoJLKAXPkZLiR
	/woeLPIlN/gIHsSDrOReZRXvN5JpEKHccvNU9C1p/fTb6i+u4GO3DekIaF4Im6qi
	nfwaT6/wvaB0uK+WuBWf3Ck2Q/tywv3n8CHka/yfPS5jLJEJvJOXDkxEmkIt8Djn
	KyFNTS/wmHc3FgBLyxpjaILtfXaUHNv5Ui1wL+/o+5QR9SPtLtQFeA0dTUIJZWp8
	uHf7MSsKiMXmLRZSnLF4Syh4gKPs1gV1YP762srdC03hbA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dasn5sm8t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 21:05:27 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5094741c1c1so9075331cf.1
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 14:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775336727; x=1775941527; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTrkVv7RxA87UYtedNu+KTupuZyd1sP6sRCLIISx6CQ=;
        b=dy+F/4p/jHQEBWZ638NIkkB7NofQb0c7SigbRVXNvQGtL6DWUqqGfuS1ezve6PuFal
         XaPGOF1bJxK4m1fGl5NwhhZIcCfcLbTwTQuD/tCSe8tFYrFGd9rh2wDwwXdZCirKfIKh
         L1SOt9MfUojEU35oUZ2w/66w1QJZRoKCFg6vz4H3+XT6BlxN11n+Rjp4vcU0Sr2ZlP6y
         UgsWZgWSslGhKOS+QRchCbuUCnszZrcIh5ZM/nuN0HP2YQZkFY0vjJ705/2+Hd/ynHj8
         CeHMm1xj1R8ExNGnW9JXU/MQAgRT6DLpDbRTRv68zz9XKSH3cCNUO0NJJQwM2+BVAu9h
         KfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775336727; x=1775941527;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTrkVv7RxA87UYtedNu+KTupuZyd1sP6sRCLIISx6CQ=;
        b=rS2I5wZdfXg9sR5As/wNCrfxbWmdOv6kqkKL9l+CerTEhQuKlAM8g00NrSLHcGBW37
         1G6h/6cgllm8kKBF8QusPhDW+J3zqKWvlUBhfVIy8BPWLqldgm9DAr2o0Te8qFITcPW0
         Ps44hHKF7rZcsa3VFLz1vOGqnTbVkvw/ATarNyeUITXBzhZmqhukOzaMqmoau9E6PVw4
         ZInESqvhYGyuFzxF4svalQH+H/1TLIdYkOAQoBNhjGrJkVWPGlMUKudpAwr8cCDqpPrA
         Qv45QrkgKMnCtQslvfcwVEy2tyFxUDNuNjj+mxN4SoL+u+6hviKJKLu8v7kHILNIClrD
         xCMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWajBk4mUclHXmlkamszE2GbEPtEJ8BBItj4YpFw2usHYm2bVpGaa/kTCy7fN+Rjcic1Ajm+gY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypk6SbN33jBPGGoA1Jx52uf/NnAbVVSr25cKhe4q3bDyQJl+lL
	ZIIFiRc9y7CJTMuW3o48v22cEB1KRUkxG1IfrAIMcLQaz3oQsRVBr7O2qCCk/e9ywII/BGJT7q5
	YUd/3CRYqhx41pTBiNXYrfEDYDeuP67tLa3YlhqkqdbLQGOo48Nh82J2bMr8=
X-Gm-Gg: AeBDieviF4YXccPt1zb0lGSzlmNpAGTLgo0ujgmV1zrH+0qMYtMMiNMnwlv6eh43NJc
	nO1elc+PjmjZnEDAgZL1Dfh3pJRxv2A8E5DnpKjDGWXlpY7+pqj53sXX8Bk3yYM8RkboZqoHsVr
	ET49qpOdF9zvAG4FAvqmU5wpm8oYl28tVLnmVZm59f9s9MBwd5ya/DHzF48nwbJM5dvs9/c9394
	xHnWZNyRbX2ZlQ1aUcqKwWQ6QXcoFNBfrc7UeRMIKu5aAkiMq6mj93+nXZTpYn4qEWCYHD7Wm6Y
	wm88FiEabnh3Fkbqz/DQeAUeh2Qkwa+8/YafMeeBdAQf6r1BHzDvgekv8iJMzXABoWini3fBOZB
	7EWfxce2qyO89kfdv5FhAJO2D2ZYs54vOMKZkict9ATrh2oOHQ97LqZa5TYHEoDUMScuWHbvew5
	3jl495x//pLbIOeSm/RtxDo8qNs4z4iGpkLbo=
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id d75a77b69052e-50d83de50cfmr22878151cf.20.1775336727055;
        Sat, 04 Apr 2026 14:05:27 -0700 (PDT)
X-Received: by 2002:a05:622a:124b:b0:50d:83de:4933 with SMTP id d75a77b69052e-50d83de50cfmr22877861cf.20.1775336726595;
        Sat, 04 Apr 2026 14:05:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c9cb95sm2274374e87.23.2026.04.04.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 14:05:24 -0700 (PDT)
Date: Sun, 5 Apr 2026 00:05:22 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: david@ixit.cz
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Martinz <amartinz@shift.eco>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Casey Connolly <casey.connolly@linaro.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        Petr Hodina <petr.hodina@protonmail.com>,
        biemster <l.j.beemster@gmail.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, oe-linux-nfc@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 5/5] arm64: dts: qcom: sdm845-google-common: Enable NFC
Message-ID: <3wejnbgrlcyagt7eqhrfqm6ih7tyo3kfgmmmvvwf6nqdr4y4bp@rhuihdfu54qd>
References: <20260403-oneplus-nfc-v3-0-fbdce57d63c1@ixit.cz>
 <20260403-oneplus-nfc-v3-5-fbdce57d63c1@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-oneplus-nfc-v3-5-fbdce57d63c1@ixit.cz>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfXxfQYVQ2iuamY
 tXkA1BeI7hYDpjQWdOJFbLxqkzLO9R8IL3LkAJ3RF6ceQUaBmluGOM7IEHoUon01LE/6BqGE5ij
 VKMJn90tDC/D+WRnsJPGCfXSBwFIpw/U3DOIxRm2dn0wL1oOqRkfJnM4Pk7H8/nvZUt28ftsOWO
 z/8Vm+dohyDCebTlnWylJ5lntxnx3eW9c2mPXdfUFjPz7mfgII9h1Kxbh/igIKcI13D4i5bLwk4
 p2co1g270LUGxZs8duIfrGxJAN7gFkGaQ04GaC5kl0QCnXrOagY2UK36jGosO4a1Lb9Yht2WT8R
 6GsQ/vjxkYKWQ7/iEx3mqE62FByLxewDORTnrddBQPGV/dC/zbqDlQQuwlVv/6r9+XDFnSrZtrh
 ++1Mja3/OfLdT2+GDEoO6y0zL1Es5mKbpT9vLNcEnbTtLfqooN1O9CNw5nmA+0lF3PJ9eNcQ/SF
 s20nSeR0nkjDywUcRGw==
X-Proofpoint-ORIG-GUID: k1bLjx4NFdXavALKYYyPsuz1g1O7qqhm
X-Authority-Analysis: v=2.4 cv=K9wv3iWI c=1 sm=1 tr=0 ts=69d17d17 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=k9HIGDZ-W5ShfVvnVaQA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: k1bLjx4NFdXavALKYYyPsuz1g1O7qqhm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040200
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275407-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,shift.eco,lunn.ch,davemloft.net,google.com,redhat.com,linaro.org,shiftphones.com,protonmail.com,gmail.com,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ixit.cz:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9AABD39C84A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 03:58:50PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> Enable NFC controller NXP PN557.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-google-common.dtsi | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

