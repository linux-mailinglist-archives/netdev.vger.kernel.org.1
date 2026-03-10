Return-Path: <netdev+bounces-265809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GqSMABhr2kmWwIAu9opvQ
	(envelope-from <netdev+bounces-265809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:08:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D34C242E37
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECF1B3043D6E
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF3813B7AE;
	Tue, 10 Mar 2026 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBGRUKGK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WjbqNOsO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77E83B1BD
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101252; cv=none; b=L84nPM7B914p0I8z+/eK90r+SEnMa+hrwsR5jX9fsLbpCmFfv2XBoEd+Sjn0QbTnXvuKew6CXWyX356mG+O/e45n8r5fLjeZ60nX86y2FnU9/RrWcvZgY2mI19ijNdk0XK6X3K4mIseq00bwemYAxqPs+0bSGlU2kqQeHVV7jlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101252; c=relaxed/simple;
	bh=P58zuoeK3XyttEuYCWkCe3W/ylCjEQK5c9GEr+Rcz90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Klv38Lf7e3BaChWkoktQqncs52gwUt4FAvvB+adrue09kD2dhPZZm5TLqKsd9Ftf2WlqdNKECcStuBu+MJLqh/drbGuCkNKWb3GZ+o3Cyprrfj4+9JrIyuJHV0O1C92Qj+CJVB6q+NjKka3NgaHasF3qMTwnPppd6m2AF75cO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBGRUKGK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WjbqNOsO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HCaKP1662024
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:07:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=0YVUDtYbGk40peP8Fv0PhsiX
	AN6JtNcjR5HdQiC2+Yw=; b=YBGRUKGKp4X8kuGY4wfe8um+rTtWTGXrWmBCm52/
	YmnC48PB8jAjc2w72djinZqmLw97ldx8NF6Q13KdgcRJ6+HFbkkI4HC3guATJU5R
	A1RxdF/kCMTwlpY2Ax+h5ouzuSE5BO6HwVGwZkrgOCJJtQAmbocjM2dz7QkoVZ/0
	53X8aniUG67zMPK+entrUHtLZcyJbPcCarxm2CdbszkI8t816M7214oDk6ol//qU
	QBqlJweYj/i2PuvKGFhQbSukSHaBK5cVd/siY3kcP67fHvPVPIGWnwohIentLOgB
	0bArccSY3c0DAe/0pC/Wb6tzpXIzsQeVlZfaMitsAKN9ow==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyr41r0d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:07:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd7774be64so1435195285a.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101249; x=1773706049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0YVUDtYbGk40peP8Fv0PhsiXAN6JtNcjR5HdQiC2+Yw=;
        b=WjbqNOsOvwHAeR7IlYPUQdC+urszHsmpN+Ch16oknNRmDo6IYnpN4z5S40Ot3t5gFl
         q5+3Y9VSQ818nnF0uHEU350MLPR/1n9Hq+0hkJ9Y5DrWDRa+mvrPJc3S/g421pnq82GY
         w9J6sAfkI+/0VJghgD6nAVXKhu9fY/lATPd79M8xBqAk5tFTMYf5wJS1kaA95jLCCpay
         WpPMKoakFO9/qy8aK11f/xUbZEhnxzEePakAAMMcCgWTu91/ckTwfg+B56SNueADpMZb
         MFw4EtoY+7ty6PiV4ZRVoKjP+XoT8heA+cYEXrQPtrsc1gV4qXVYq/ExXqyzt7FDWHJf
         e25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101249; x=1773706049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0YVUDtYbGk40peP8Fv0PhsiXAN6JtNcjR5HdQiC2+Yw=;
        b=uGCcT7zktrInddKVMtWYVYk+12HqxcqnRzGkDHbyKhI9HOrz4i+4YvYw/WObLsy6XW
         xSJAkDZ4r3gc3RhPZpddfrKmZNNbxj2tceaP/MT6abTZuBIY+oZ8rYfT9wn6gS0vx657
         jz6TTnUbz+T6wBomNt3xvhbaXGZzhG1EGQvc2PeDPKCL39WMTbvQpIC8D3BqfVcFkylB
         sLZuZSoQ91tY8sZawmQnTLvbvDfRgYu7j9m4wioE+DZP3PJbC7kOBySdkOLm64A+ecgq
         GBMT7UmOFPYcDAUjiB4PDyGYWLcn4z4sl9RKyFdg1p3wh1N4uotHdh9FrV3Lmv2K0DXT
         EhkA==
X-Forwarded-Encrypted: i=1; AJvYcCXmFzIljpC86QMYA+uUNRYy+wV/5XajOzaaVUdeYFkXUsLLjAItvBrqp/cae97TdJGiUQ0e8b8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn/zCMvDgX0jGq9uyGzRzBqpgcBewwD0t5lIduIfaAZEPcFAdi
	qnJDk2S4WeRDEylqm3ctnXAAd8dOCu7edR1ECNLCiaqoejYxKKqxnG9RpCuJthkeMIXL8KDWZnu
	a1iYpAsilyjLF9vBNiZAPXLLZiHBPaDPh+hw2aN+7OqGF+fDKyI19kzmU1TQ=
X-Gm-Gg: ATEYQzzC2J2J9Qg1XwhotfWzr+tqcSZ0+T7RIGXmbRHSaJ2E3bXmj1YCzEAxbQIp8+q
	A7MnGEPl2vHzBBeNqlgIL0bilDzQ/pIcRdRDoa+aZsJ/emvjWNHY+pXqCh3xtaKxAW+4TPR65a8
	soPTTXZb0BYMcqHnxiexdkseU1d+5RuoqYuSd+kd3FBVVJZO8q8FNMHOT8mkikegrGMNTzIpdyQ
	dqsiQZXOEmGvaeCrmpK5o0ETks7G6JdRB2wgjd7+rbFwmMa9xcid3BQhA7Eb7cngjf18WAm2i6y
	irK0ryWzPmeGr/qXV7m0Mp4CV4yc2/QXbx/uYM/XOYDa4rtTigrsc57hsCgHxd06SdlUJRSqxZR
	YUB0adQ2ztfQX7nFe+UP+UcEYR3PodJpR8Zc7IkWOMDDDZy7XdEa6rFE3nK7dxAL6R/Kg+KZTv9
	oi0QrZ56fjt9aH8gCMkBzHvWYnZPg2MRmlU0M=
X-Received: by 2002:a05:620a:4495:b0:8b2:7558:409c with SMTP id af79cd13be357-8cd6d433536mr1656408285a.36.1773101249445;
        Mon, 09 Mar 2026 17:07:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4495:b0:8b2:7558:409c with SMTP id af79cd13be357-8cd6d433536mr1656404185a.36.1773101248996;
        Mon, 09 Mar 2026 17:07:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d086159sm2355811e87.66.2026.03.09.17.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:07:27 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:07:26 +0200
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
Subject: Re: [PATCH v1 8/8] samples: qmi: Use the unified QMI service ID
 instead of defining it locally
Message-ID: <b4didhxklg6j3oqjhpjw474j5ces4qgmnyjubgwmozfaoua37x@d63ya2n5bmcg>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-9-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-9-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX4q5fsVp8Rd/G
 FHWJa4C4jgUkLpPuL/sBKblObuFqVjAzGIhYQaXayuxT1IZzkgSYZyNVfJuYv2i0ertT4K8akeA
 fID7iODHi8LUyCW5x9pfodRYEPoB2gCWJXI9iwbUGkWDmyGcQWgvVtOfy288J267UZ4yaI+dB2L
 yx+se7IxZ5NSb+kzzg3aWooigKxfPcJVFOib4SxEeM2ODtEFHFdlwTHrCt6Y/ASdGmnNnrOrlec
 ftsrCDoPaGKXqulY1bqZcpLGjc3wnEp5XYV11CtWyo5DELrzvawTLKabestHNP63ekONbng+WYT
 zqkUVQzGxx7vuJgYmymE8DKuHDBKCIGFv9w++eKvjVZAIqqoPEhYm5H4s2SRyBtAjVYBaHDKnY9
 tD338oajPfp/06fOo3mQ+H7fXZH4XejK/9C8SurEWwJoOGVspCd+uUSjd1OyqnpZtSVjwFcssEs
 D8MHnbxaBN1us3BjHkQ==
X-Proofpoint-GUID: RUqp1VrYmtIP-kR0VXPvsUPGIUjch6vU
X-Proofpoint-ORIG-GUID: RUqp1VrYmtIP-kR0VXPvsUPGIUjch6vU
X-Authority-Analysis: v=2.4 cv=KNRXzVFo c=1 sm=1 tr=0 ts=69af60c2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=JDd5jbiArqgbxbPHNCoA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 3D34C242E37
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265809-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:37AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  samples/qmi/qmi_sample_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

