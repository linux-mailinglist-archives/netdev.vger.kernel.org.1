Return-Path: <netdev+bounces-269466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MK5FJ+4KvGkArgIAu9opvQ
	(envelope-from <netdev+bounces-269466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:40:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACC32CD04C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 97F0B3045061
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2B635DA6B;
	Thu, 19 Mar 2026 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QarXSthN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQY1xAGI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354D372ED1
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930414; cv=none; b=fE13s9/V6nJDB15Rtbl19cELKEFQZSQraNKW+HDWhzs2K/M9WKPZlqS/rS8qLjAkKGGghnqg+mV7K7JkkV9XJC1qwANaE+iWVSB5mDP8l4HyMqt0TW3elmvaVGr9fRlq2gexmXLpJuyvGLCnzZeWxv9d78kN1ikjvF8xUbN6OBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930414; c=relaxed/simple;
	bh=gv/hMc9jdlSB/rscIFbQEP/TqOb9j2QNFxeTSfCKR1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4Hj4n1P2eQTTsMsyV4shx8LVAH/X/puD56ig40aj/B+e/fNUG0pQDgqt9BzfbaDR2xh0dCt7pqGbCjIfFaZNP/V91wZJYU71SxE4Xj1XsIaGnJzlLxfOuBNOKSJh9cSByjtYZTui2h94WMClfgXYtKlF/rc57nWhI/xy4ltYis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QarXSthN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GQY1xAGI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62JEJJlE4155698
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=; b=QarXSthNOTFkFQkO
	al/Azz2zcOzljz5BjrIOubnbmfGGbJxmmQ6cd3iZzccgYCrqJkS037p8ei3Yw2FW
	fMzY7wYL+M5x2a7CvA7ibvc7ftLepU8jZ7dSDLW/7wr4j35FiC+FuakovAkA5bEm
	oGhBZx90FsY6NawlnD2SuBkSEDvQ96PcWAnwDx73MXSASpvIq5ZWduCJ2vU8umlO
	caIcH0KHhMuAYkUt63XzSI7fCMxfvrzce+sUtWLDPgdWVXG6MaJGGEkZZ+JBYqeT
	9j36iOmD17f1976Lp7w4hBhFRavlaBWubY2hiT8tzn47U08eYCOK0hBVP60sOrdU
	sPGUNw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0jt900wn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:26:52 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7d7e65e8acdso1270536a34.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773930411; x=1774535211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=;
        b=GQY1xAGIZYBfMZ8HFqzjBWfRHLQbkLwgn6iJZtpnYTi2+wZvOUzUcGPPiCqlB3/dxf
         U/O/+h/PrHD9s8GAz38hwaetwHdBLy/f2bbHPGcjkgqyNUxz2BN6N1vGWT6sxq0uvpUT
         JYYhtiqnPk8Hgaaow8VEz4c4FvzW99+QFqWrBVEXmsorZ+NBy72CSu5p2kvJVBB4ayy9
         z2+sMrXs+Q/KqSskYyS7xUvK+7UpLdTilzFXEsmeF9wCFTKWls6/eye8yvaVppjsyUGD
         0zEvycxEe3bB8xdHyVM1LJPR/homONc/F4QHunP5SFmufkLRbrzD3xaf5ug/2F/GwAav
         zf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930411; x=1774535211;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0WO3yovuzRdjBUY2nE2AcEq49hPJ3M31tQHHQvF6ywA=;
        b=DS1W0gueW1qaeDd0myJqdeHoVVzUy4e6HQ+e4f3hBiVEcfEt+OMEUxJt7olKtUl7h/
         bq8FgeLExwvTtEIgJXY7Xvc6NAxCw7hVamVdjzeaezdCZJ7wM9kQQ/C7a0SR6zvo+N1f
         4kh9F5qPkzlt6sveF2upS+v2d82O1T/81PSt8wYE9jTL2E994wiH0c4uudbZFHmLvkkV
         nhlNBEDmsHv+bSup8JHyzIm5HJQ6aZxRkQ5b3+a55idQ1jbLT8x3KoMg0IE2GT+7Pnbq
         /OkD7E0PxKY6hAjTD0DT02hpXdm/tPpu5/mDZ33+2li37Uxi4jGrNMKV3/xFPfK9xzGO
         tZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPq6DCgoZqnW3Zhsm9TyFXFwIPRtcST1AObl+Ojf5vUWg2myuVN6XcLS2mwygJialLkZKW5o8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkjK4vdxqqsY90VRiSmAc5/cMVNvc7uu5MQdoAePgFfBnThv/2
	zFhi+2GBILYU8Q2SRXVLmXHVcbdS+cEzBls7ndgGNQD8xy3VW44jY39gEhUZIsNf3RAGTWacoK+
	DqPcFznNCKmFpQEoJyVlhzGXldadVx6fVANK8fuL5rQGNTjP7ylJZWuhaXCw=
X-Gm-Gg: ATEYQzwTpIV6Y9mfuPPEW3ckVC6AanaoqWsQsDaWSBJcmQN9EKZsBgxK8E/6lD4QCPr
	CUolShYDqPuLoVVVrlrXJVntA5r/2etQ26VJobMCn8LBaoU626rHb6SVLpw5R/M8vMmzW/OJ7q5
	l9JCVsqXOm33UBXShZLNUOQ5A4oGqJwQDQwhAGRpXKsvpMuxaTdhPD7utM0gN353ZFR0BaQi3HJ
	aFVJ8eOD1IApFADoPVgcYsC0PowPXmL4ddljEql/oq7ayWXhdDb5AbFDhXDe/DoQRF3CLgDLCGd
	eoCLbJSOnAM63KIsAOw7P7NawjRfQus6m59LfPROyhLeNZJDdPO1lK9ph3+WvUWLZUA2l0O6uPT
	X50HhkDlUSI1fpXHzvcuN9af6bYpyuGcQCAktH7cqJnIotLNnzyg7fzqf3pB8kriBnS0YbRFbWC
	fJv/H4FtV9i4rGHQ==
X-Received: by 2002:a05:6820:61f:b0:67c:1e60:3e90 with SMTP id 006d021491bc7-67c1e604939mr746052eaf.6.1773930411227;
        Thu, 19 Mar 2026 07:26:51 -0700 (PDT)
X-Received: by 2002:a05:6820:61f:b0:67c:1e60:3e90 with SMTP id 006d021491bc7-67c1e604939mr746016eaf.6.1773930410817;
        Thu, 19 Mar 2026 07:26:50 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41bd2d14b63sm5729630fac.16.2026.03.19.07.26.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 07:26:50 -0700 (PDT)
Message-ID: <51e28a7f-8362-4bf1-9b9a-9af9cda1d748@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 07:26:46 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: ath: Use the unified QMI service ID instead
 of defining it locally
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, konradybcio@kernel.org,
        andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
 <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260316171419.2619620-3-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: CRetWrRdswLty7rkFRs9RhsZg2jYz-2s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDExNCBTYWx0ZWRfX4DBtKEYpeEtX
 0jT33Lu23ExNa74fIn4CNyduRALdoCTQtbzh6R7ai9ojpUe76PXUcsLF1/y4FxCrkdJD6Tzv2xF
 lgC5t5HsNzdW37Q8Rvd0SbdzYsYXrA8TDkjxzrL7j1yoahGP+ywcHlU161YUqAy57K7frHV5KKi
 SHRHGsVsoKtmLcRwXjWL0jY1XV2zYYBsdlOkU2Q/whm8ag7GYQHgORkvk59ygnpYYnbimE2T/K+
 aIrgVGud3Wpr2sCKTbx9zg3BuG0bA6Z2PFVaTFBNfcnJA9ZmGu3PHQObn93m4GY74W1yPOP6fGO
 FvV79piAvKIRytqmFhMdXW1jxB8qThr9FtqgTnvyGT34oHJ0qAhRB0QzVX7mCf9YfTjBTcVT1a9
 ATgwi9+uVYkc2j42UigNeDu5RZaXoPehv35m/SI5Jvwk4leIrDvg+/bOJ/OWBiPnFC+f4bIm7yh
 nVcSHodQ27x+3H0IIhA==
X-Proofpoint-ORIG-GUID: CRetWrRdswLty7rkFRs9RhsZg2jYz-2s
X-Authority-Analysis: v=2.4 cv=FKMWBuos c=1 sm=1 tr=0 ts=69bc07ac cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=yAZrW0GqhKXZdV71gCQA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269466-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8ACC32CD04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/16/2026 10:14 AM, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Bjorn,
Feel free to take this through your tree since I don't think it will conflict
with anything in mine and it will take time for the definition to propagate
back to my tree via the normal workflow (which I would prefer over merging the
immutable branch).

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



