Return-Path: <netdev+bounces-259298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJARN+mclWkESwIAu9opvQ
	(envelope-from <netdev+bounces-259298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:05:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7DC155C8C
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 12:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6674C30028EA
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2239308F33;
	Wed, 18 Feb 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jkum4PWp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XYyYnd3g"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C013EBF22
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 11:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412708; cv=none; b=JuCZSJS2/I1/s9D2jVnPv6npgRJBS1LYBxzBCyiczWh+mrPpnUSzsarg3zDzHJB0GIWnZt3SMNK1ZfpZhvDDuq/6HjxXh7RmF9txlIp2NC2BnR86RqEIMY+BL2oCrvIfxmg+ay8pzMb7cXTvtbi2OKezKQWcd/NbSaTCiXEomHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412708; c=relaxed/simple;
	bh=rxMu4x2D0L9uBLvIPBiCEoVnr3u4nFT74v5nQ+RkYwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XljjugxEDdbiiEP4/0SISlhddf19bK+adl3PhHqCdmSnNtQ6PWmYeocIkZ17vMMCxbGVaMDbuRrriv2CEVKvIQYNUf8LXBMoo+PBfr1GISKv/2hUCh0kL/0t1fvZxsbDiR1FaI/wyzlXmM+UTdk1XViM6Zgy1n+M/Ac4bTjKPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Jkum4PWp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XYyYnd3g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I9trqH2784578
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 11:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+1v4Kscw0kuO/DEc81qahfsz12tKP1JfFz8HRwBsjcg=; b=Jkum4PWp0eNwHwjW
	hLNt23vElzygmGhx/1XQ4GI0jqkIgpCH4a9YzbFg3B7XBWsJ40ZzzvTGb9SQcMPW
	2B/eeCNpoljs0XP76lZMb35Ndn5sxCrWuIf/9y/zuVY7Plz0N5GBKIeM9cd4pwy9
	iIHWQ8iJ8nskjUxnZ+C8XWOgU3L1ZhaHZswlvukpTsRDRFSLDUNSsv2EjZ4sNm7V
	aG8QTKiGx3RgAddi1n4TLkD6bIgUHM2gNdYTpci2/6si+oJk7g0fuXrxDm4VH0e5
	iSxL7Qaw3+H5nzUwsYOUo+jZ1wfue6k9jvNOx7pTJKNpJn7fTN3U2NVqgd230XqB
	WCrKAg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ccyrk1x9b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 11:05:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb399597fbso333307185a.3
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 03:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771412706; x=1772017506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+1v4Kscw0kuO/DEc81qahfsz12tKP1JfFz8HRwBsjcg=;
        b=XYyYnd3g3oOMoQCbLvuFFhRqIGYf28gFrAeM6nIED6JvLk+q+i+uPQaj7qEcEkAlK1
         sNxX5KzBbhPOKx3ggCJGcDFs0KMzQnfB1g6OmaMTmJ8Mffjl7hdAeDzPv3dA1aRTE6Im
         gc0Cr+XEIIX2XeE3gF9Qn9Ykau17bQNfRbmgfEpRir4XoGqKdKjLHJ7yTKJzfcv0ICiN
         gFweX1Xa6JIPvkviR+p3+cNTEQG2PhSWsuJVRhu9KywqG2V4nrqh0J8O5puqT8CtW7xf
         tkN2an0bQZL5smXdiHb7YOV2kDqFnAIBFakY2tt/AAq14yj/N8m/N0lKF7mxANEcHRls
         sEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771412706; x=1772017506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+1v4Kscw0kuO/DEc81qahfsz12tKP1JfFz8HRwBsjcg=;
        b=QtvLojh8OROOS3HpuaDcaBIirRv4Ja1yhi4OruiKe5FX+8pvXX0Qt8O2G6fDdqqOcG
         0KddyWnVz4oBVjn5+yZMDgnqeQ74usyYe6wMQOLqPMnJx/X6a1G1VBq2MMJ4ptftPwFJ
         abbKnDTKELm7vpwmG30GrWfm60OVirhJsDlv9fr0MJgJzmL5EfXd/c6x+ny6AIAfu4Kj
         vqFxKp/WHyQCO8nlEi9HV0Zj4ZOoFesj/tX8+OUjth+NyJ7Pjb2JHvy8aTfjWV4K9oLt
         tdPuMp4ESz1rAEjWHTPm8dx9ZE8K1HDb+26ubPF+X3voVbvAeUzflshhlRgOQ8vUhqlI
         N6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCV+UVdg1aKFDBiaoiihoF48eLBfLqEHUjFyQ/yO5LPliTNvomtNwOqiJ5W3WK0jnCsOp4jV8CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZUlKtVp3hQg+NFbfemDjxe38xcGlgwEOSbUv0RcvZ939LDqDd
	dCQvH9N2wXhCbeSNTXw+9uoQh3mVxmm1v/N8p6ByvLmos0aB5hY+1Tu9kv4ZDpgESuieM+5bjx3
	NnE8NiqKCyZJ8xUPU2SMaFIATad2ZTjtQp2nJ1FvrTXyzeIYwljDNTSOH838=
X-Gm-Gg: AZuq6aICy3j83bq6MLxbv3lXvm51J4f2qR9b7ycx/Vuu/3GHGTwuSCnuR6Kcclhk5ad
	l22CRN8Ynz8DAV5fwmFUN+esakO384tS2mm0zVyUBnplOOwa0amjrFVN9GEBEM4xSxyhdwtlcE/
	t1vlxw/J59gXy1+Ir2If9zJeH3x6pdmm4A5FsXMy2RbNWKrz2G6NuR4fonO9jer23JDz50ML1Gx
	V3Z6Q3e+ucjahyJTHnJMWyREJDpubI02Qw5hoakAXxJxOZaUZJYdEAP4EY+xTRGsfESU3qFRtTa
	4omGvaiBuk7FY6pSo8bMG7bs5WCd0wwxSI6wmlbKiRkuOAqtJ8lP+UpUokHwcxnbgrPV8SpNpDH
	Ufhnhf9Qg706EaG3y3J34G/rS4f8r3o1NXhWKZsl1s10UX+JIXctraqtNULqwuecLhavdJFgFaR
	aM9Ac=
X-Received: by 2002:a05:620a:6910:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cb408c9044mr1661348285a.7.1771412705814;
        Wed, 18 Feb 2026 03:05:05 -0800 (PST)
X-Received: by 2002:a05:620a:6910:b0:8b2:ea2d:a5 with SMTP id af79cd13be357-8cb408c9044mr1661345985a.7.1771412705367;
        Wed, 18 Feb 2026 03:05:05 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc73f7c24sm448899366b.30.2026.02.18.03.05.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 03:05:04 -0800 (PST)
Message-ID: <36f0a71c-a8b7-4aaa-81c3-1945b268c57f@oss.qualcomm.com>
Date: Wed, 18 Feb 2026 12:05:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/3] dt-bindings: sram: qcom,imem: Allow
 modem-tables subnode
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller"
 <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alex Elder <elder@kernel.org>,
        Marijn Suijten
 <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20260217-topic-ipa_imem-v3-0-d6d8ed1dfb67@oss.qualcomm.com>
 <20260217-topic-ipa_imem-v3-1-d6d8ed1dfb67@oss.qualcomm.com>
 <20260217-godlike-silent-owl-0a8487@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260217-godlike-silent-owl-0a8487@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dPMs4XmHsK_kgF9VjeIiNWKChPFQ95xT
X-Proofpoint-ORIG-GUID: dPMs4XmHsK_kgF9VjeIiNWKChPFQ95xT
X-Authority-Analysis: v=2.4 cv=eOweTXp1 c=1 sm=1 tr=0 ts=69959ce2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=rVRdtUZ5si-n9qu6NxkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDA5OCBTYWx0ZWRfX190uGvd7M2na
 9Jrhn17KK4XqZgBr32zjj/MsUBoFBnh7G1HABvmC8KaxF0WMtCadV6ftNG28YJfgVoQazhjVy11
 ejetpAcWRzIld3H3lFeiOmVq9fsCxEPdaSCDDI/289EZls/SiRXwBfpJl2GR6XP1hR0LQ4KS3xr
 kmV1AkfxeQgqi7qO3jSoq+i3LB/RkLyN/n5lyvjBIt3c3025xPONyLvtR6VV0QzTMcO2H2FlJ87
 Fo4/Rjp3sG8OfKEYems8aG6H9kYi45B7qniZqDvhVO8vV6zCSHald/C94ZeJcXlnbNtQ4gaVX0+
 jWANjP/w/vB25gE0aGDkPbsV323rtne9B4csSkcoiXL2xTpmGnMfWd6gbDtaUh1doCpAVLH4E68
 RkY4isrvuNU0Z+5pMdY+CmJm33JlB4sW/lTJzd4Tzobg6aAJlEUgnjw/D6KdQS59+85rhmaWENd
 BgEH9X6QzpxoSgID/aw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_01,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 clxscore=1011 phishscore=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180098
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259298-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0D7DC155C8C
X-Rspamd-Action: no action

On 2/17/26 9:25 PM, Krzysztof Kozlowski wrote:
> On Tue, Feb 17, 2026 at 02:30:31PM +0100, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> The IP Accelerator hardware/firmware owns a sizeable region within the
>> IMEM, named 'modem-tables', containing various packet processing
>> configuration data.
>>
>> It's not actually accessed by the OS, although we have to IOMMU-map it
>> with the IPA device, so that presumably the firmware can act upon it.
>>
>> Allow it as a subnode of IMEM.
> 
> You do not have compatible, so rely on the node name as ABI, which is
> fine in general but... I do not see usage of it in the driver. Why do
> you need to define modem-tables child then?

I don't really *need* the node name to be an ABI. However, the current
binding for IMEM only allows a named "pil-reloc@.." subnode (which is
consumed via of_find_compatible_node() in the remoteproc subsystem) so I
figured the intention was to keep the list of allowed subnodes strictly
moderated

If you'd prefer a blanket pattern declaration with say '^[a-z]@[0-9a-z]+$'
with just a reg requirement inside, I'm fine with that too

Konrad

