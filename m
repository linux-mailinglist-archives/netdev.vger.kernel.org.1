Return-Path: <netdev+bounces-289267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAmyIfzhC2qzPwUAu9opvQ
	(envelope-from <netdev+bounces-289267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:07:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C355771E4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E377302CD1B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B12F0C62;
	Tue, 19 May 2026 04:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PKT2RwJ1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fr93tShP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB31C5D59
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779163638; cv=none; b=VJ7m17YWk+kvob0+Bwjy1uz0k2hnQLlUeOvFwEr4uNwERkZ/Hahewpot2P+2ANUm18DGHk4pMTz1yMZSo6WlLehM27+x1Gea4fcWuPNtdSi713fN9J6sD+BgDFs/TAD5GhytRB8J96rbO06hVnvaLEiPK4jAQfUuuNPCdSasb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779163638; c=relaxed/simple;
	bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUnDkxDfJboTMRb6IdkSGQwPHCrpcY4KoTA03PrvpdOkmAWtDsGO2gkKWBqg6uNQ7i4lykIacYssD3BTp/9xAoFM73X5E6ih8SBneH5sVnfp7HFYu42WRmKGHxtWcmGVsCQ9Ip2nUHRrrt9uHBJzyRw11IvWASnf2Ewo9+mP4K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PKT2RwJ1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fr93tShP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J3AC1W2091009
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dtwft2ZAn+e
	mgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=; b=PKT2RwJ1EDSh07DUg/jgthv571S
	CGJitNzFkNsvVyjc2eF5+yWGiLKSeAP9zC0UtXe4OoNQQqI+n2wz7kztstjFq6Ox
	DUB1PPcumZ8zBXYRjqvRL78Qk633UEBYjbj72DtCCCd+vSEZmHVWPmaBKJPvc/p2
	mO1W3nV87+j3bOXqcaJGlfuixi3K1wYZyMyznxfd7ob5EPd4hGXVV13rqushjwo1
	wh4vFsXktOrMoitQzwyKLHYtxWCB/y7VLeePepUNyPUzX7QnVjpe7g1DnrYmpYmE
	t4KPLxr+GQcVztXzyvr/Xjqro0VQylBjMW11S6VMyT+p4TIE9h/aOQX8mCg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e80rpkkyt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:07:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f2d983d109so13286697eec.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779163636; x=1779768436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
        b=fr93tShPSx7YxO4lAeBBcPOz6Q1n+awEAz+ZCsYeUEMNVFFGL2z0z/f2/V90VhQs+P
         4LaWKo33zUIl5tSDD9BnlvnnsG/sGBdhMATnMQiW6qYxKcWxAceMwR71igkhZHOKotEA
         r7hZ39cUzJsZi3vcHTfb4jakao4oYDskP9BtpHIo2YD7YHYqZ+nN3GSIi8m3kCfh5NQY
         w7re6sPTycTjmxhAM65Kug9YRXaPgOs1Kd7O++Ww4ctGD+X+emKPygnZjPxw7ON7WKjz
         wk+elD8gHil+a83iCFJ0A4b8Q4a1yRdkJREAhxNVvMQhKMIWXjVlbaugGWQKqr0N+Flv
         Nxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779163636; x=1779768436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dtwft2ZAn+emgpNWFam/8M0EFSFiw1kKcLaYVRyaKC8=;
        b=Bf2gYS+Z4V6d7nbHrXYsmj6AGYoxkPvywPWK5mxqw4gB/kHbsKSr8Nx3iDLFUQuHZr
         Ukfjux8HbM/9ju8pBkad2zHBF9WzdQAMgM0mD3qOtAv0zZgLNxYjSArAYnhq9995p0ab
         STGqV+GmnpPfZA3OQRcmlFKSFkJnWnZRq/tgflWiWJjkleE6EKicMX1DpzXaps/jasPP
         3zKTgXF8d50WTqpSYepEGYyy4j0B3bkkWHj+JXga5KyxY1OkkvkMFqZrA/IjKn0varlp
         gDKAzMG1Cu6QbQTFTyRHZal/UzGMlEb/S6BhvlE7bceqqrU5De3KVxH3fBbZJI8gpe2H
         ewSA==
X-Forwarded-Encrypted: i=1; AFNElJ8OhJjbf4ABmfJ1blSP0KrxQmwWFEWbJdZ56m8B6uGbPfBfkmLWnmYPlh0aXP6ZaYHXd7puQTs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF28EQtzsuFGpxNqIQJ53OcVDclp/MR/KfW62V93hy3hLfjN5U
	jA+cN9wHCYQngf4pwn1anBkOWkD50aEYmh6vH3QuYbhlquNrtmkoF35p5QmdN6NXTGFME5E0Fpv
	bTsnjSbzDT30Qfzquqx/mIKzHdqxIdmhA1D/EJYj2LGogOGgbPHLUQ8ACQx0=
X-Gm-Gg: Acq92OHmJ+/2m0TSvwYNBk1uEWGSUAZdxE0Me1H4TP55865W9VAGTo2JFw9glATPbHJ
	mCqBxoO083wftbPgkZpHNKTnJrzjYfujWlU1PVXUE9xpMN7BzfFcEdrtdgEl9/iXkYfY8/qcCfb
	Ls0b0kYeYcQSzXKnkOAxpBpzsXHZEEMUACG9mUzEgweqlUc3Q1k0w40UHCiDlEvZNf2K3rYAlwW
	YrLUk198PcBPxFeCX/T+hQHiJFeChh3utpR3QRlAtiOQjoihXVbtbt4/6XgjuUemrswVJG0WNOq
	Kt2dNulzIZl61dVfpVRb6579mkc/28YIGrjOoGyoH7o8q/p3ciwnadR1SjG9T04NpSGl0cOyQoW
	sct65lLItgSnGNwlJ/tuyH7aaMY8C1CdtdRFV7jMpztoSvPRlc3WxsVkg61r70zvJyy8NMU6qRd
	/XgyBFs+/hog==
X-Received: by 2002:a05:7300:dc03:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-3039867718cmr8011764eec.30.1779163635610;
        Mon, 18 May 2026 21:07:15 -0700 (PDT)
X-Received: by 2002:a05:7300:dc03:b0:2f5:5907:3a49 with SMTP id 5a478bee46e88-3039867718cmr8011738eec.30.1779163635062;
        Mon, 18 May 2026 21:07:15 -0700 (PDT)
Received: from WOSSA.na.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6e9sm18592694eec.16.2026.05.18.21.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:07:14 -0700 (PDT)
From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
To: imv4bel@gmail.com
Cc: aaron1esau@gmail.com, ben@decadent.org.uk, davem@davemloft.net,
        dsahern@kernel.org, edumazet@google.com, herbert@gondor.apana.org.au,
        horms@kernel.org, jiayuan.chen@linux.dev, kerneljasonxing@gmail.com,
        kuba@kernel.org, kuniyu@google.com, malin89@huawei.com, mhal@rbox.co,
        netdev@vger.kernel.org, pabeni@redhat.com, sd@queasysnail.net,
        stable@vger.kernel.org, steffen.klassert@secunet.com,
        sultan@kerneltoast.com, tanjingguo@huawei.com,
        Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Subject: Re: [PATCH net v5] net: skbuff: propagate shared-frag marker through frag-transfer helpers
Date: Mon, 18 May 2026 21:02:32 -0700
Message-ID: <20260519040232.1395-1-rajat.gupta@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.2.windows.1
In-Reply-To: <ageeJfJHwgzmKXbh@v4bel>
References: <ageeJfJHwgzmKXbh@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _UrZZNA2xXjO77z0AcAjhzSX0765tcy-
X-Proofpoint-ORIG-GUID: _UrZZNA2xXjO77z0AcAjhzSX0765tcy-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDAzNyBTYWx0ZWRfXxQrcF3VRA7Nv
 Ow2FxKftNgI8u745WG0/ciiw4Dxxz2Mw/Tkm6hoYYjOH4wGrhnAtLz2lofrAbQ33y6+xLLika7P
 TwxRdk9qm0wzeBw5o88Hc3wPnnXjmlfFAigX/+sOcCZjYtqYDa6u2Ve0nIwk43Z9iide0VDYydL
 B7R03ycH2FMk2PJ1vJi58vNyh0bfinpuJgux7QkQsCvA7iB05fj0pXt52uiB962HDppuVSPauZi
 CMZJcXkS4zmRCmyvGB10qMU/DaID3GNm736IHpCJ1w8t8X9ClAw1Q2v00AhbDmj0XqFkSXzUEtJ
 LVfVJ0aBRS/eXsm+EklkXnkaSu1WrlwqXnHzEfOkMNfB/v1zJz/C+NnzqNoOJfQZpPSsW8RrLI5
 m3RNe3SMHvU6OUO7L6gUuiGesL2scRTebHPu9EMDBsY+XjFj6vJMTCawBOBpAsggS2bYBH17nCF
 DYC/jSmZyVVAWFqCn+w==
X-Authority-Analysis: v=2.4 cv=ecMNubEH c=1 sm=1 tr=0 ts=6a0be1f4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=qQm7GNJJ0ztNeIs_msoA:9 a=ZXulRonScM0A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190037
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289267-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,decadent.org.uk,davemloft.net,kernel.org,google.com,gondor.apana.org.au,linux.dev,huawei.com,rbox.co,vger.kernel.org,redhat.com,queasysnail.net,secunet.com,kerneltoast.com,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rajat.gupta@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 49C355771E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The skb_gro_receive() and skb_shift() fixes look correct -- we
independently reported both to security@kernel.org with working
LPE exploits confirming they are exploitable from unprivileged
user namespaces.

Could you add the following tags when respinning or applying?

Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Tested-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>

Thanks,
Rajat

