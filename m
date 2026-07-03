Return-Path: <netdev+bounces-304444-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JKMdChJzR2qBYQAAu9opvQ
	(envelope-from <netdev+bounces-304444-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:30:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71696700109
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:30:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jrPIi7+K;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="O/QWZ5Gk";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304444-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304444-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2CF03073246
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A8F37755A;
	Fri,  3 Jul 2026 08:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C73769FF
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:06:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783066005; cv=none; b=at4s+OJsZbHzJzkWZ9MgJgC+MI8P1EpeGwzVHLWuJcM0e3hXJYt10FZ5OrhIuxRQciUR0ujp2AjojMYJI8hLKDcdDrmIt/LpvGQKeKK3lYXNLUOk/nqQsXCbfORKi6gZ2R8CXu9wzcn4vjHzfFvwXomPzcGVgsSR+x8TOKBqbYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783066005; c=relaxed/simple;
	bh=BFqvU3xWw1bOp9Nmrz4FB2lO8Yi2p657NBtepv8BVGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gq1GqV5gtyeVR2H9VMm2Dqw/M6/8v+ejG36sf1TacCvj/Qp1SorxQ6VLF68zhLWW/nrwA6LTSfLypA53zuWnjVKSb60AyH1Nd9v6uHStkeyODlYUzIiGBUiYnv63NRkgi8gIVG3nz7801lX1ELy2Qe4rXwBOV4dhac1ooTYsSm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jrPIi7+K; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O/QWZ5Gk; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rvOK3126357
	for <netdev@vger.kernel.org>; Fri, 3 Jul 2026 08:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S+KYOUYk9xDFCFdTKcVTLC0PMMm0fauNzk+Db/iRFyM=; b=jrPIi7+KtOIoYAsw
	XMzc4Cw/Kjh+usndpDvElQzs53VlFralWMWPbobnz9NCjDB+ugYYG+5ZeWzios+e
	1iCWACIMGr0laAfFVepzUKQOxk3yzxZYWzOwDz0PmMsyXOcgGuLVtuaNd1jRctM6
	GMErbgoDFtK5ceSOk9mPxBhVTE1f3gne86zx3NfV/M5rX8ULgbTUkcHIPcZUZHHb
	syavbdTkkZUSFsewVBQkeLpYFe89tSm0UwqVg0dSuiuW0idFG46+FeVU+/v9JqQF
	6hbE2p0jFqCXiBYn4wySedi/rJQRQDdUndeTgutQIPcUA7kIBCHXYq5cKPF5m0aQ
	MyIdfA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5tpnkf2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 08:06:41 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8478e9c4bd2so393389b3a.1
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 01:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783066001; x=1783670801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=S+KYOUYk9xDFCFdTKcVTLC0PMMm0fauNzk+Db/iRFyM=;
        b=O/QWZ5GkQL8KcBqAey/LiwL+2QkgpWiJFED9d8EqQTNK06VyLd+wD5uNwmJwUO3Rd9
         o4Lu1/sTaWZNQtcMo9zOKXq9SqzymZPADfqeVYlbdSKITWcyIMJvPMDhV9O9bVkn3eEN
         +pH6zpVXNaLy7dWJcnx5pKTTJDvrebJZ2Ej8+a6Mfn91EL0GhoIq0AkOox4zHiekXpTl
         TojOz9cqcEtu2g5hLDEMXefdVnuSNyj1CCJoUrktWYnZh51DxQtWEWSbiwjRA9z1MYuQ
         Bfmx7PtlXia7t/AYNjpo/NfmXHHZ3H1fqrLbxl7vhpfxp1HH8B0C0c9cwNPkEG9dPH+Y
         bffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783066001; x=1783670801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+KYOUYk9xDFCFdTKcVTLC0PMMm0fauNzk+Db/iRFyM=;
        b=nwZpqt03Cs844lT8xKlJDlGLVTgMjNm9pcV11+eB4YdSnNAg1pN6oG2GEahf9NnAPI
         /nQO7qH6N1UusnCAkhM6Vgu8SPiiAe6dJWbyhJaCRqWIdL/7XbPhXHuoih/DKGI9RE97
         Mz3arYPwti1tzqR1rpgzcSheyjxLr697IL5EU/BZX/Dew1XPUIKKh+VhCvWeydC+Ws5Y
         xZ+ANG+olbD+YceTsrh6vi9PcDC19Umq4TMQT6wpbD5BkEiKbIpfxmPAI0so2/cE3xKo
         VmdkzNqrP0+/jdW+ZXFVYfi3PUX/YJFOlMYvyg2644s7/MOmIrkVupdt6GKHYY+0sb2P
         aeYA==
X-Forwarded-Encrypted: i=1; AHgh+RrxIPDSS/KcEEx8rhDWj5tqHqKnpHzqzd9oDYeeYDb5N62gbH+ybxKbMK/Z/SQLCqFv1ClSEJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRv+fIa0AbTAmbvcDyih1OBgtQnZ6+2O1puj5tb+vuc1Sjy+Ny
	rlIZ6vEoE6fof+1uNFXLXEONzoNKuMMKmVn1APcJi9NA9uiJweRD+J3pZEZNLniBM4FHgQXc3+r
	uQYBxEqkAN7tckqd02DDJvpC3LXmPqD5yuUTrznZFoAfKKixW7/kBJpL+xqo=
X-Gm-Gg: AfdE7cmuRjmpmyVuebNjJedMc0uwaG9bbAPKzJaUSaupAw2/31JFsTuCLP4kNI2kTRh
	WjwKiQxEzl6rfgeVgYnv1URnLbQSFkpihtqc9br93b5o1TYSzHf3/xsPK4iUYcHfTQFppoW4i29
	ZyMjRAWrpR+t0NT7n+tAUSu3rBwR1yKVx/VydQCg3BTq+iwa0xVT8DUUIYaWrHRPeHLuRn0+bKd
	xogorHNyaRtsLfDGKGimTbxiXmyEkpNyk5KO4WqAm2lpWgSz2S/T2AD8fgBRJ2p/4awhap6sX0t
	Vr31fbf/GLsWhUwp9FaWC04CdEn5giqPfm9u+MJHcJqFLJjC+eMqVbbIanl6HJoq2ySX6kN8oh0
	SQm4Clj+7UxmxoR6P4qaNjerv5/2im+dAUXDJmBNfq40xQWW3AEUCuQwfhLPPAe4Sf9tPuc50L4
	s=
X-Received: by 2002:a05:6a00:1816:b0:847:87bd:6021 with SMTP id d2e1a72fcca58-847c512cff3mr8846609b3a.39.1783066000711;
        Fri, 03 Jul 2026 01:06:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:1816:b0:847:87bd:6021 with SMTP id d2e1a72fcca58-847c512cff3mr8846587b3a.39.1783066000161;
        Fri, 03 Jul 2026 01:06:40 -0700 (PDT)
Received: from [10.133.33.27] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb6e218fsm2461976b3a.1.2026.07.03.01.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:06:39 -0700 (PDT)
Message-ID: <98fb7d4a-8113-4e8f-9e36-524ce3633671@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 16:06:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: ethernet: qualcomm: Constify
 "queue_map" in ppe_ring_queue_map_set()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260702094908.79859-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260702094908.79859-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Jie Luo <jie.luo@oss.qualcomm.com>
In-Reply-To: <20260702094908.79859-4-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: rm4KMmoWewu0b_L8jyJug0qQ6Gl_oXW6
X-Proofpoint-ORIG-GUID: rm4KMmoWewu0b_L8jyJug0qQ6Gl_oXW6
X-Authority-Analysis: v=2.4 cv=UMft2ify c=1 sm=1 tr=0 ts=6a476d91 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=VsuWDRUJ-s9NbHNxF4oA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA3NSBTYWx0ZWRfXwi88t6G4qZzq
 AAyS4nP+XbdNF/MuQ7QDyyHFF7RmmrvE8j1SpOMzyMlMiDDcbR5vCGqG2Qm2wkB2r2PUwuxRx+3
 zlfhD2i3PwMacryxjBUYLj/UW3j5Gh8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA3NSBTYWx0ZWRfX/iBhgUtp3mLx
 yyPy3iL9kkQ99YvsOkG57UyXBu+QPuFZ37+SKr4iySLL2H0RxfVH+KF8hOSjwFQhQLNgnCNsFhg
 twHnPHqEYwluPfUbxQF58YyRYO2YdGOMCRZtUsymsexsgPGBvBFx0hOpCdT4NuwKIkL1FcII0x4
 pAtMUHw7g8N4Zz38PLpW+V8LmLQ1vRWk8oO306QCsihPCrBF/3pwUjaOUgVTgbE+jvBA1PgenmJ
 Vgna/BotVtcBsxMIIMNCqf9Mdy0UG8vE5e//l2ZPx7h0WVQ8M3Jgvnh+/rTuU1GSmA/PP/0+NCE
 EWqG3B6lB0jCuqi9+NTzpPZ0JpvkNF3Jb7qJkvsegCqCUI1U8jt64v4wkXo9AwdhsGkkb9uuagW
 +swqWwaemWmhfk2h9pKXoqEciriLqls3OUdwGNpkX9zc0YSJCR96D/ZtxC9a+xU/OkdRBqHQWkz
 94X3G7QehGob+aVq+yw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030075
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304444-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
	FORGED_RECIPIENTS(0.00)[m:krzysztof.kozlowski@oss.qualcomm.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jie.luo@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 71696700109



On 7/2/2026 5:49 PM, Krzysztof Kozlowski wrote:
> "queue_map" is a pointer to "u32" and is not modified by the
> ppe_ring_queue_map_set() function, thus can be made a pointer to const to
> indicate that function is treating the pointed value read-only.  This in
> general makes the code easier to follow and a bit safer.

Thanks for this improvement.
Reviewed-by: Luo Jie <jie.luo@oss.qualcomm.com>

