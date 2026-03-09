Return-Path: <netdev+bounces-265799-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOwWKM9cr2lKWAIAu9opvQ
	(envelope-from <netdev+bounces-265799-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:50:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 877AA242BDF
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A40B53013475
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 23:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8DE396D26;
	Mon,  9 Mar 2026 23:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IQgsSFbn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1m/5zZ6"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49A3939D1
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773100236; cv=none; b=ZsQPtjJ5i+Kgp9jcJEXsD41TXZsjtjKFnA59ErE780Evhjwte5fQMZ/PEWFQSQpTSsnpfCOm2KFIXKhVSNQiH85ovDiiu/sJt8PY/f1qRuLHQEQ9LUqaA5ndKeG/J/ipBfwV7Qy3VIMt1BIHq+uZokT5Vp3N+c/IVShXSeW+C7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773100236; c=relaxed/simple;
	bh=2I18mxmMPuansctcCshuBD3YLdIUGz4SaCX8PGHGUaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUmxCYLvdT+njVLbqcGEPOlnwWtK7xPYUZ7ys0SsfINYAW4x8pAz3aYyuljl0lWPp/Q5P40QufSZHqqOjkjW+bVuMbfeeODekm331eQMBh+Eu5oAdBgvKKZdS+vmpnvpQvZx1S0p8g59Le8Xeq1yir4Sa0Fmfr9ryOkA/5dzQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IQgsSFbn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N1m/5zZ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629JFsTT2872796
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 23:50:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Usf2c8oheBhN4rTUg/6UxDx9DMs4PXDC10F9BFyFRk0=; b=IQgsSFbn0KFUnTb1
	KDrlCb6DNjAXoPA8Nwvhml10EY3QiGV6sjcWdNcnFvTJTrnhRVGJDtbhXabxBPnO
	BFpeIJL2HBaHQH7kQciQbJgYijhb3lehwUQC0cKolzAqoof+fVPKpuoHYKhB9Hgl
	BuQBFoeu9Hd+OfySMjSvJpeHu8TWZsotLGbmQdkOPDDb3/sqO2JBA9vS5polGetk
	fL4zv4ya9KZWdQVnq0gUkDwX3qHUozGvBXji0UFEYja0gt+AGzmuTNPejNDJohox
	OT/YvTyzG3CdAs6InKcMXboMSg94ba5A1lPk9z5x7jvLPjgpl2gEd4edPd7aC87I
	eaYn/w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477gpat-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 23:50:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2be21f89332so7691347eec.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 16:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773100233; x=1773705033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Usf2c8oheBhN4rTUg/6UxDx9DMs4PXDC10F9BFyFRk0=;
        b=N1m/5zZ6vZ70ytjMmHO8tN4FkQO34few6w1oBudffv2vjtKZ7pC8NI5A4ZcFhBKAvj
         ZuDC7CxYL5RSaPeNcBgodJGfvoeETJqYOq0RY2kF8mN8eswdU9UqkwbirLJ/izMdBLjx
         AtOLRbiFtqh0Ui00K5hV9SCdveg7MoBHxao64o8Vf4RZQqhusXtATv7xMt9W6qJRL6bg
         jPdEQR9nGwibXVCtSMfE5wTFowQqgwIIQLxHALn3ZifGlWnbJeWICam9svISwciwP/Oo
         EuAR4XzF5b4+d6zColDdK9mUG1mT3hCXah2K6/aVhAyjkF7YgApPMGHCvcK+qrbTO/AJ
         JlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773100233; x=1773705033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usf2c8oheBhN4rTUg/6UxDx9DMs4PXDC10F9BFyFRk0=;
        b=v8CtHrXH91gBlebadpZpnXFgM/sk0fkj3fgdqMRn/SgLByK79IoGPEzun4DsE+bA4K
         ZDvLxfVUxgSfjgGueeB1D/fhs4Sc5UlW18GcfOKGG4gq2954VkNxW4FjZxcxh+JkrHZC
         Un3jAmUhy+9ujKU7pKMShHeS+Ej+0uCIxxZ7ighUbaC2qWsjhb1XqIjUJVPWAm1updJN
         GxUX7GXf55jznlBMGwkaOoV+cxGSa7Izg0x4aBAwgF7Vy5NG9epj+DuJIrG+jy/tcU6j
         JpWQhPMJhTdnK37gbj+ZNW+lH6gevs6LM2XQyBLcyiRHkcP+od9MqeljLeheFgdHwo+E
         VkOA==
X-Forwarded-Encrypted: i=1; AJvYcCUIJd4K2X6DPejKkYTwsHYMIu1DwtnMXLvSKxiKNTqH1cngNKdkEIMTxjp9yVm2ZYMeyEd+VsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3hgZBtQuElzlGpfsR9IV3/CehLv415Z2A1A9J7/7YvqIFj0fS
	nsDFhIlBA5UHDKQopoFxEwYsYcfj2nIIrEypgiOPyF0qx+/MYrIGkhxq9L4A3/txXRw1bohe1BG
	W99nL/YMxQTUj/hHgHQ5wv3FJTdNyGjNiDtICrCuz4HsVc9jEHr00nBaeMBM=
X-Gm-Gg: ATEYQzzM1BdR13a2LZCtrf7vJBKf82cfhe2yQvkOE5Tpyl9eR50XrQE/rwKWEut1YGG
	c3fc5Rf5NcB4rgjQlilmWt6eNiNU7wCLoFlwlUzFvc5isTT9u09I5YGNXI9Bh2movR8hbULrvqc
	EJCnLvzLCUhebqemW62J1ZJdWec3tziwFQzeZQ1027/cx/djCmLCNVjYULBN8Uov+roCX6bjxU9
	5QSepLerI42fP3a2V8IMb2YDBxcHTuVhgB5J3i3C3qfO0UcVA6lv19fHYDxqLCmPhqi4ZsZNYqW
	/BR6G7/tq2Lp20fanojCYNGoI2N0WXngJybZzLBtkTXZDDZ/orc0mwR4ivjcdYvgLNZlF/CakH9
	b+POngYxlyhnYeDboqjS/7HPXtEhJ5weiKt1hi395+xzso644z508J226ScUWgh08Sm9ACD1Paz
	kDMSlrEjujeMpThA==
X-Received: by 2002:a05:7022:629f:b0:128:cf80:deea with SMTP id a92af1059eb24-128cf80e01fmr3402118c88.1.1773100230957;
        Mon, 09 Mar 2026 16:50:30 -0700 (PDT)
X-Received: by 2002:a05:7022:629f:b0:128:cf80:deea with SMTP id a92af1059eb24-128cf80e01fmr3402088c88.1.1773100230365;
        Mon, 09 Mar 2026 16:50:30 -0700 (PDT)
Received: from [192.168.1.41] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128dc848cbcsm3108879c88.7.2026.03.09.16.50.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 16:50:29 -0700 (PDT)
Message-ID: <9cc7638f-1232-4cb7-b4d7-cdac66a2f4ba@oss.qualcomm.com>
Date: Mon, 9 Mar 2026 16:50:25 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/8] Group QMI service IDs into the QMI header
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
        linux-sound@vger.kernel.org
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
In-Reply-To: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMCBTYWx0ZWRfX9fxln/bztrFd
 JXCb0e6qzfFh4Ib98gObnHiUPEtb1tzhaT+VkCVWY5cnBa8Ny68CGILXrM5u5h88sHhGhetm+Jd
 ar9lJurDVG5DFUQN0OUWMHiFiXazKVF2cQ1gW/bUCexU8dGyVzvJHmgt6aW1YaqJAiuVfOpmtNt
 8PlEtMqFGWEmZLYHHOOJqxw5wX4/9Xmyt/XVxIzzum/GE9pym81xvCDDphhNNsR/o+0SPlUzf6l
 ZmrTOPMhtR1CND3cqGqghvE3KhJg2LA+clHoM0MCMUAsoScyj66jmvYn2KPcmkSTFJcUQUJheD0
 YI9nmTIoiicWfy5GX9aFUZiX6vWHyOjFnfiKodaT7b3j1V+dqGg8c6N4qcP7wv6P2viJ/WHIaPm
 YuW2Z5fmG1ie7S3lsvMpRnriAH127+AzD/SvB96itwFPZSe7X6n0jwl4A5GHnTTeZPbYZkfOpMs
 XJWdAtnJkffIxM+mDIw==
X-Proofpoint-GUID: tLa2Xan0TBiN3HncY9B8kPxOpfjlvj_Q
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69af5cc9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8 a=20KFwNOVAAAA:8
 a=KKAkSRfTAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8 a=COk6AnOGAAAA:8
 a=JfrnYn6hAAAA:8 a=GmBS2Oju3p3q64JsNm8A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=cvBusfyB2V15izCimMoJ:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=TjNXssC_j7lpFel5tvFf:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: tLa2Xan0TBiN3HncY9B8kPxOpfjlvj_Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090210
X-Rspamd-Queue-Id: 877AA242BDF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265799-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/2026 4:03 PM, Daniel Lezcano wrote:
> The different subsystems implementing the QMI service protocol are
> using their own definition of the service id. It is not a problem but
> it results on having those duplicated with different names but the
> same value and without consistency in their name.
> 
> It makes more sense to unify their names and move the definitions in
> the QMI header file providing a consistent way to represent the
> supported protocols. Consequently the different drivers will use them
> instead of their own definition of the service id.
> 
> Cc: Alex Elder <elder@kernel.org>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Jeff Johnson <jjohnson@kernel.org>
> Cc: Bjorn Andersson <andersson@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Srinivas Kandagatla <srini@kernel.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Wesley Cheng <quic_wcheng@quicinc.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: ath10k@lists.infradead.org
> Cc: ath11k@lists.infradead.org
> Cc: ath12k@lists.infradead.org
> Cc: linux-arm-msm@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-sound@vger.kernel.org
> ---
> Daniel Lezcano (8):
>   soc: qcom: qmi: Enumerate the service IDs of QMI
>   net: ipa: Use the unified QMI service ID instead of defining it
>     locally
>   net: drivers: wireless: ath: Use the unified QMI service ID instead of
>     defining it locally

prefix for wireless drivers is simply wifi: <driver>:
so s/net: drivers: wireless:/wifi:/

>   remoteproc: qcom: Use the unified QMI service ID instead of defining
>     it locally
>   slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of
>     defining it locally
>   soc: qcom: pdr: Use the unified QMI service ID instead of defining it
>     locally
>   ALSA: usb-audio: qcom: Use the unified QMI service ID instead of
>     defining it locally
>   samples: qmi: Use the unified QMI service ID instead of defining it
>     locally
> 
>  drivers/net/ipa/ipa_qmi.c                      |  6 ++----
>  drivers/net/wireless/ath/ath10k/qmi.c          |  2 +-
>  drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h |  1 -
>  drivers/net/wireless/ath/ath11k/qmi.c          |  2 +-
>  drivers/net/wireless/ath/ath11k/qmi.h          |  1 -
>  drivers/net/wireless/ath/ath12k/qmi.c          |  2 +-
>  drivers/net/wireless/ath/ath12k/qmi.h          |  1 -
>  drivers/remoteproc/qcom_sysmon.c               |  2 +-
>  drivers/slimbus/qcom-ngd-ctrl.c                |  5 ++---
>  drivers/soc/qcom/pdr_interface.c               |  4 ++--
>  drivers/soc/qcom/pdr_internal.h                |  3 ---
>  drivers/soc/qcom/qcom_pd_mapper.c              |  2 +-
>  include/linux/soc/qcom/qmi.h                   | 12 ++++++++++++
>  samples/qmi/qmi_sample_client.c                |  2 +-
>  sound/usb/qcom/qc_audio_offload.c              |  2 +-
>  sound/usb/qcom/usb_audio_qmi_v01.h             |  1 -

You are touching a lot of subsystems with a single series.
How do you plan on having these land?
Do you have a maintainer who will take all of these through their tree?

>  16 files changed, 25 insertions(+), 23 deletions(-)
> 


