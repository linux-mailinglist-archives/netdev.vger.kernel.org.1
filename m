Return-Path: <netdev+bounces-265807-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHJNJ69gr2kDWwIAu9opvQ
	(envelope-from <netdev+bounces-265807-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:07:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2F6242DD6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94E1E3013CAE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE1175A6D;
	Tue, 10 Mar 2026 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JapuiHfL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RJV8BRjR"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779A38DF9
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101211; cv=none; b=FDQ2SwQabJFe32torvNBfvbPnQG/8Mk0iFj4K/YqbW51dOjSqjcDXyiC8k7kOcCD7BMXzVmu1rfZCrsViT6p40VnvekqiK/I+AcLJCMjLj0+N9E2Cv/q04HqvvlZO+gjUXmIMYKyWNTT+9NAJCOJJoiwfcoep7z6LYGP5zNMuLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101211; c=relaxed/simple;
	bh=EeFpgHgJ4EK0P/FdP0P6/Wa/ChILFm1ALZyRl6FBEdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYTEx63ZO/kxtKsGMcoGQEyA3bxeJ1kC66UhIfuhMUZtr+8z5ENW4BBEToTwYOJ2iomi2AuiVe9lg9AQsWJuZlgQA+uZH2yaXEInQ9EjQqRY0mdpdVL0mf1wLTMPGqapdzC2C52odFraVta3rDfVxLPtGG6YMiRRCOqizU03wNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JapuiHfL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RJV8BRjR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBlgI296193
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=VFmhFycj2WExrdRTfkSysTZd
	dOqHarJ5plPefogYPpg=; b=JapuiHfLWZPy7Qf1nLM6DfJ2elKq7wWA9Yz5rN8O
	RpcjqtxbVZQzPTeEaWzhCzJvIQB9NqUTVZPR0OLNID2rxrhJ9m0OKBhLQdtt+uQB
	yuFo+H1vhdnVA9t6TKi/gGnCrozq5gKa6R4+3bReYtOAad9u/0n8Jo8QPHo7xI8D
	cCt/YeY2P7veEZ7jG7qhD9+DzYDBeo0J0H2ZHl7U+XfV0as0rPy10njp4OBO5Vhz
	yGlYbJ/CR7EkMmFIcuI0Ai5YHFdPRfqBxlTo6PghMlnTWcANCodJh/75Qk/GjMov
	kGUR7kIDRhzZa9CTzNtrE8raj+VEE+v7OFR4E0kTo741+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy1wa6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7d66afceso1324689685a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101208; x=1773706008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmhFycj2WExrdRTfkSysTZddOqHarJ5plPefogYPpg=;
        b=RJV8BRjRQrzvtXO+9ZiuKZvWLhgIURVucA9aTWLXXE/X4KA8IKA4x0iNJvWL9Eo+MN
         H2vMK8BtNG7+oHHp28sHo4l9d6sOZ5NePQvFD9fXFcuv4ILA7EAuQjH0oF/kVL34fiwF
         TDQxBu4pg9IslEVHI4OhLItpAfHchyFXnAkFNxh5uZ/Kg7lpBDdSskM0ILJ53an6IP2d
         bfyvxl1o7FfZBJMc0R1GS/ScESfLeFLszs1RkPcnj3bX+YyXrxY+Imj62ImTTffuygfi
         8MXMMPqCiCMgGrHaUJHeMB+x9TNT+2FRuGsDm67UZLIbmOLuVUWJtxgLCYHvJG8ueUvR
         wh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101208; x=1773706008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFmhFycj2WExrdRTfkSysTZddOqHarJ5plPefogYPpg=;
        b=Za71CbYpNPmHONwOQqol9ofKbqn74wQ50FyhOueCPUiGl8roLMa4yemIisnroD8S7Z
         Nr3W4o2vwTVoWcCacqny/I3F+h7Qt7Uy//0OK7kVQE+gKWPnUq/2BZNZIHbMTNrWyZPE
         jWKa3FdNj10Qvy6pN0yHZrJJfcdJBl5zWuceRn8VGZQbgNOlZz6GgtIzWwK3yeZFaX2t
         QFe0QJCjz3iNvfHaj3u94T9usGSZfoezrDD34FH+8vEbbLbngWK04PeEocYKROw3EzD4
         v55tDzqlHLODoIQj2iAQlWYYMyjvqhGxF0ne9KtJTx4sStUQ2CWwniLmuOnS3yJJ68ed
         kJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd19imH1O6BuLydhIsFEUxa7pgbElYP6YeBE0N02p/h1HSmLZ854lqqBJ+GCP6R2nqvcqFR8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFUvWiSBdX5s6jVuXbN56xDh9WwP88UhUpFZoVcaXDFIJh2J5
	GVSlJWt0mVaeRXlQWjeeIiTAb0Z+bUBKT19yqNyohwciyGo2vGALPCyR64gfFJl9q3FGp2lbNVJ
	oTT8T5eLEQ/NmQVWiPfbvYjNxxbPZ5wGZbIkbWMJvb7r3kjVB3DHGIHgrj8kfmILxEFw=
X-Gm-Gg: ATEYQzy9kYOvF3sBj7D2z1eglfIRSdsC/uwqWpy7eMjHglpeAv7mRW5UVLF87Sjma0V
	txEcSNaIIx7dezZfnj+l6FghTSwgpl9CHGE6mTeNh2h8hPZks+1BG+ehrmCdVx50AZJoID/xAz7
	9zjSswWhmRJgUZHCbn4HBy6FVnBbRN85oy1L3EZBHpqcJr6UhCviz05X63kJG3EUsODz612Ws0X
	sZnlWv32vfBk/AQ2hw6PGDJN/lbmrCop84V+uBb5Gu6QFuJ4SlpvP9zljPrWijSB+GJ0yJzvQ4Y
	LmR+YwjUSnxsQzSb+1o7ErMAiAoW/7AbNqn7pPAz1YI/yJVI5kbjomqF7GSISL8RgZ5PzvnJm8l
	gL4zapqwlZE+btW6ykvT/ZNsjAwSfi/4pdTRs3DhvMVH+s8GrEGXqU9tljn/qNW9V+0I4lbYsKb
	qultRa+GotNfnjmWRvKNUG6BiJ7bdAHVT1NrE=
X-Received: by 2002:a05:620a:46a6:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8cd6d488044mr1675000585a.59.1773101208084;
        Mon, 09 Mar 2026 17:06:48 -0700 (PDT)
X-Received: by 2002:a05:620a:46a6:b0:8c6:c9a2:504d with SMTP id af79cd13be357-8cd6d488044mr1674998085a.59.1773101207669;
        Mon, 09 Mar 2026 17:06:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08641esm2376849e87.74.2026.03.09.17.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:45 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:06:44 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: konradybcio@kernel.org, andersson@kernel.org, linux-kernel@vger.kernel.org,
        Alex Elder <elder@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
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
Subject: Re: [PATCH v1 6/8] soc: qcom: pdr: Use the unified QMI service ID
 instead of defining it locally
Message-ID: <sm2yj2zmhswp6ydjeonal2upnm6qwokivmrnyajmw42iw2zeyu@d7kwprkm7voi>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-7-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-7-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX7F/shb2LFY/b
 K9NVsIRtpFCitztbNvyO/NuBWUowWVMD3AfiRLcPl5yG9AtvAg74usFA8k/nnnsQd/tMhu4go4x
 vuCaLmrtDIP8HVsOdlGFCDXEzrIgu6AhmOjzhXE7tapaKq28WYJiemz6thg9yPwLfcuPWhjjw2F
 /aRZo4V5CQBK80c5tygJom85Srq9wjwef2hOLdkBGmlSLv6mQf2BmFM/7ZOSh45YmgFtbIiGShT
 kMKSR2SCKybWr4aoUnAwDVW7qBe2tpZY9ST6gnHNf9EjXMVI5fdDcw5J58waUTqiB5sPI98f/IS
 RQ1yy6DeQlnS/FMYRH6IFbf77jgJebt8X31g+5mNDrEiv1UAYzs+wS8ocjjdyUOL8M+W7V7cYd6
 u3s96qG9ylAZgXmlzbXim6KVIylTRF1531EE5ZI4UhU5nd5LokJiHXeQ7j/n9/wgQeCzi08t29m
 SOxST5a5AtPYj6vq32A==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af6099 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=1EgtvGsZK5M7WpkkhHwA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: vUwbodQ5eDjrZ_ooNigEKAcheaKgYim_
X-Proofpoint-ORIG-GUID: vUwbodQ5eDjrZ_ooNigEKAcheaKgYim_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: BD2F6242DD6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265807-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:35AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/pdr_interface.c  | 4 ++--
>  drivers/soc/qcom/pdr_internal.h   | 3 ---
>  drivers/soc/qcom/qcom_pd_mapper.c | 2 +-
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

