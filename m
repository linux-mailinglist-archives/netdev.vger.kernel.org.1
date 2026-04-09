Return-Path: <netdev+bounces-276887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAKVGgRi12l8NQgAu9opvQ
	(envelope-from <netdev+bounces-276887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:23:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9883C7B9F
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4332530610C6
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC53A4F58;
	Thu,  9 Apr 2026 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOQENC9Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VdK8YVHK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B035B632
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775722720; cv=none; b=Sx6LERxIwBD0lGQ6J90VJm4riAB/87UyyRGfEuCNCBUly7km0/uYnnj5s5rOTXkyPuLHzlpORiDPMftF8DZKmtluyvvyGChYj8ulw8RxqdAZlo4pb47gcSmIfysZYAKD2zBfuUhO41cEyA2au4YTCjatsCKrdftX1r9pQy0hHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775722720; c=relaxed/simple;
	bh=m5tFcopWBSKNdB53LAhal06l0yyzaqheMmMZSLpC6Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DRuO/F/4U96jwP8/yZCQa0TlZIvftwLcfNkZHpbPPrgjEwN8irDokzCUCMKWjis2rp0zilB5J3B9jsBcC4p05Xt1erhVngtvSYnWVDIHHa10EbMGGHaQV5aPJv+Vr8inte3NZaoVuzIbLhT8pzJAFQlTBT7Slzv3C5pdY5xxkz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOQENC9Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VdK8YVHK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63958MQl2619001
	for <netdev@vger.kernel.org>; Thu, 9 Apr 2026 08:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8z8l8qSYfoO88CPg9LA+QREeSlAoVd+weN+GhlGYusQ=; b=SOQENC9Q2W7xoIA2
	7Zl+/EymyBhWDyDzQO4xyLCSdxUDHMw1OMMw7GLZJr/hJ1S17DoPcFTamBiljcN8
	TptuqnNopzINV7hd3cJGLuhOwxs44ZLOXxF17God9cmXbiDdz93koLxWi0ak4nLV
	YznZfd9FHhK4UM4N1AM/PltB2m10nVZFTFGpqtdT9wmOqcWMf5tRivbpeQvgkxIU
	vUSNCxF3q8NZu0D+ealf0sZ8qdKete2l2j2L5KeM2AnMKDCZvuQdj0l3FjGdTqBR
	umo+Byw+QHr8Pwu1OvTdyNQkbDHuv24S4ikPOaWFWg7tRgGpWWE5KPidBySr8okO
	xM5v0A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddt28u5rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:18:37 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb456d53a5so8153085a.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775722717; x=1776327517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8z8l8qSYfoO88CPg9LA+QREeSlAoVd+weN+GhlGYusQ=;
        b=VdK8YVHKezToXzakrYf8LiFn056ktoQ0q/FehYR88VNQuz9v48/QVkKeDii6oPK8hW
         9jqpry94kb5mxHtsSRBOtF8r9MsDeIrJQQzmFGJNjsLGLMF7HFFwfhqMFGrE3AMvZ7gu
         XZ7eXs96N0SEIy/wVl2YvPMmmmZhW08MdfzTWsSketAby19siNFQ/9AkxT2bjGI2Dlyz
         xoF9ijXFXcEfYYTFvQmZnwvuGHx4aMK4mpWqMadObeVdxs67e7qlzD/q9M2XyOMP8QUZ
         qO3wwYQnxwWLgRnxHoQEEbNn1CKO2QBmaKHxetyDn29cF7LpUdNgDRFrP7Xtma47TBKg
         C2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775722717; x=1776327517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8z8l8qSYfoO88CPg9LA+QREeSlAoVd+weN+GhlGYusQ=;
        b=aTiwTHvFVdZXy9sKY2n+hQ7lr9jN9aej/mW7YoZv/tDUeQmnTACwBoTX/bGC6WPp2s
         ZxS6pUNzdxAjzip3+xkvcbhGFz3kq5mRPkZlar2mxygPNb2R+Q9oa9V47Fq2FjxIAUpw
         3nNabHdjnjeMIbHG3B1Fl3iATv8DDEysqTHxyN1KoJCPseJJtYwi54wD2WtoawROtQkS
         /h83Zhpiy2R9VgJi3lZlFY7cd5LYeV51aBu/i4fbqPm6cddWiQr+s8DIVx/9oYMBzSdR
         BuJlRavqjeZ2pZZyOV0mpUSxhZIiDiUp50nuoly6rJvqKWg59Ysq9+jShagyHh2+zgXR
         2qjA==
X-Forwarded-Encrypted: i=1; AJvYcCV8FpYysDA/v81728NBjNwWvi7XRYROHdPpNribDB4G4HfVBFOi2U5hv8xa4313VKxFPiYcOFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJ7W5eK1aARcf7kI4t8svcCCkt6J7d9q/eKalz211cAzbbx6N
	aEA2ByUzhba0SlWCyBABcZ+QEcdH3xgJOduck1V1ra4IL7c0xxoyErexefupctQztzWIBAxrUz+
	yW0ebVWdDN/L92NpnNjPBQTKN3pv4siFJf4unGq5jxyFBBN2StcK5HymBp3k=
X-Gm-Gg: AeBDiev3NG7Iv55O+7BzXPa2sVkuKcLV0I2tsjxDjmysnJ26MA63vVg0uBMv8e+2dG5
	y3jSN/SzV8+XBHn8524DAzDvlR2hd/4GYHsDArPJrFR1yqO1klR4GsS3PN7j5q7PNMQqb2RfRPE
	HnU36O/UNo16qvzSiqLg+zK7BwjhqCsuUsfHlwtjL+Nonz1ZiFF6UREYipqk0MsLFHrRyyMQXZc
	F8okGHiiOvyVJnCyw5ra0+dXD1tB02dLcmxPwMRpjLyz5c3rKg4pVKQgQE2Tx+KXUXVYxAtL7pa
	a/ovugFnGU20cWDSeF1sy+M5YE3leMYuj0MWZSIw9v0YztjH6/dscAsQvgOq/WBdtOB4iwvUlNu
	K9qQwW2kMN5QfuhVEupXBY0wsOZE7A5DmuCKzJKMafjscaT5Hr81TnBCGoU+p2/DjGOlenrP3zS
	/qnNg=
X-Received: by 2002:a05:620a:2984:b0:8d5:bb98:f3cf with SMTP id af79cd13be357-8dadf2de6a9mr740953585a.2.1775722716807;
        Thu, 09 Apr 2026 01:18:36 -0700 (PDT)
X-Received: by 2002:a05:620a:2984:b0:8d5:bb98:f3cf with SMTP id af79cd13be357-8dadf2de6a9mr740952385a.2.1775722716307;
        Thu, 09 Apr 2026 01:18:36 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e034b9284sm5893094a12.22.2026.04.09.01.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:18:35 -0700 (PDT)
Message-ID: <e8fc04bc-5c98-415c-aa47-48f853fdfc2f@oss.qualcomm.com>
Date: Thu, 9 Apr 2026 10:18:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: ipa: Fix decoding EV_PER_EE for IPA v5.0+
To: Luca Weiss <luca.weiss@fairphone.com>, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260409-ipa-fixes-v1-0-a817c30678ac@fairphone.com>
 <20260409-ipa-fixes-v1-2-a817c30678ac@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260409-ipa-fixes-v1-2-a817c30678ac@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JYZFxyX9EBWMEyCVGbYbAXcnsGdm1YAQ
X-Authority-Analysis: v=2.4 cv=fIIJG5ae c=1 sm=1 tr=0 ts=69d760dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=c92rfblmAAAA:8 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=CILkcpHQ0ZtWuLMSmlYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA3MiBTYWx0ZWRfX/5nkHluby5Sc
 gp1tefPcYXiSZMRpgcrKBo+eVuywc0S6AySiOHZIVh88Pgqpr16pisz105r3/kvB9AgGt266VHg
 59bS0Vo1wMjfZJE3dafBGIqUvePoBh79pD0JZXyrmoBzHgZzc00vrlVrdk+WXdb6ItDXAYQWRMu
 9fdpcqDuqOavuDt+eqkS7++eMe1ww4stQW79PzHaLzg2eSfARko80BwyTXvkZw3Vchz2hawX2oJ
 w3fQDMO6h/VPGO4pSs8iKZtVT+pZz1eOgFv5lEBrooB01BwPkkapaxNcQSwF0LN8N4JHHLVE8s3
 glrzpc2BHBd6+neCbnYdpmxLgL8MzCCVPnkgqkdeoBcJ3p91YRGgMgmdRDffo/iWspsF9G8JCPy
 Wo4rhn6S5ALWbe7cph4H/QxHh01XwbS/t7zPTew2rkL8iT5S42NziF8nk+Id1ye8WIYCYeoyVIZ
 IFStV+Min8PyWP6H0Ag==
X-Proofpoint-GUID: JYZFxyX9EBWMEyCVGbYbAXcnsGdm1YAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_02,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090072
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276887-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fairphone.com:email,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EF9883C7B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 10:13 AM, Luca Weiss wrote:
> Initially 'reg' and 'val' are assigned from HW_PARAM_2.
> 
> But since IPA v5.0+ takes EV_PER_EE from HW_PARAM_4 (instead of
> NUM_EV_PER_EE from HW_PARAM_2), we not only need to re-assign 'reg' but
> also read the register value of that register into 'val' so that
> reg_decode() works on the correct value.
> 
> Fixes: f651334e1ef5 ("net: ipa: add HW_PARAM_4 GSI register")
> Link: https://sashiko.dev/#/patchset/20260403-milos-ipa-v1-0-01e9e4e03d3e%40fairphone.com?part=2
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

