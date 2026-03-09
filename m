Return-Path: <netdev+bounces-265743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MTLDSQjr2n6OQIAu9opvQ
	(envelope-from <netdev+bounces-265743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:44:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6EC240470
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31B653097A5D
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 19:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB9240FDAE;
	Mon,  9 Mar 2026 19:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TCW3MZgJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJxU/q/i"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0470B410D06
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085114; cv=none; b=DLWrRWMGTud7Jx57A1Vyiksjzov4HWIevZI7A1dkDwQPA7qjuNC72TsGO+oyUplev5EmdSCHbeNbX1aaMZIEqILbTBJrao8K//Uuxpa5dCKEY8f2Y4BJTHyEsSsCzoy5/+en/iIOxJdhjaz+C6CUmFSKkK5MlCQdvVlde0qCY64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085114; c=relaxed/simple;
	bh=Loslotr9NW0zDRfJCdEhJWGxURNCLV/qgMJ5loZUKjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfh73tEcgv8tRZhI6E0j2ehCP0Xrmt7mAMTaWCXQf6uqoz1veLwL9f7q/TrkaZieztBXDktROgDC05OL6Z9iQ9UH2mtz3es2HhrcSKoyjARCpVpuu7tW7lvwToJd+ycqysA9F4+f4RZi4fUIZj1bKZwWiN6Wa9Qxqy1yTeJRXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TCW3MZgJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJxU/q/i; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBoAq1203524
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 19:38:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=b8esErilgfq/s8BkSvNufUOr
	3rLNwqSWbF5fuS60O6c=; b=TCW3MZgJ+oboxJmoQGpkU+tXKUuzG9xxkSExPkI/
	2wnB4NKydHf9uXY/Nh3L2VHTN8AwO3ZRIU1c3ZsqpteNTYabeGieklSatJZ5oDsf
	ZSDxGVioUeqGsLTM6wIAvXurPG4KNkDBZWlyeLbP8R7hJiPbAb88on45RaqGZKWI
	FUASZAoSxfBjM1ME+W97KALovwj4zZZ5y+RvXPMrbsfvkjI7HcSih3JrXhzqx56D
	T3dj4Rwcig4RI3PBYmQjVHhSvKEutMa1QsK0lixFFjkyaI89cqeWyoGuMB9K+tLg
	Pt/O1mqEbJDVcP1A01kW3hDuGArq6PLzXPEHwkmDBbMReA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct03294qg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 19:38:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cb6291d95aso4039599285a.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773085109; x=1773689909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8esErilgfq/s8BkSvNufUOr3rLNwqSWbF5fuS60O6c=;
        b=MJxU/q/iKS525HFXjsCfdwwEsPUwc2+jYrNjHl1epljgKhJQsRkkM6P5FT0zKaSr6g
         A1EbHEG1FtCANr4DRt1vtQE8LwBVM5cpQApFsV6DQPKzDJKCQ/HLGQFf5iKjcI1T13yZ
         rgkx2Z22+vKhxeWPqIpWv+N2fdomdFtsT/RrA19XCiHDTt9vj6McXL2AuU51I7WYAISQ
         HPejnCLrp7afqu1SGaJHx993Yi9DeMTpmXTUupoKNpUe6dMC3CiiewhXTmEEYhLT3d+Y
         r72oLhFF7kE4WCVrljW5CGptvzEshgXy49ybdbkZNa5OfCCSiIQ9ktytRPrTyxUxGMih
         3STA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085109; x=1773689909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8esErilgfq/s8BkSvNufUOr3rLNwqSWbF5fuS60O6c=;
        b=Nu21A5H2cmP9puivTmt7CVR22a0LMh1zhouSWF5z44s4VvAvKPXP7atPLztYOsZSBZ
         i5i5lEoRwDWScqaIHFWGw8l7nCto1QUkp7peOHrAS/WzU/MnUdU8vvYWVvroalMFsJT1
         pJhMJmifAE1GS5r2haBrsl2nhPGQqQnwsCYOI7XUWdMAR6EO6Dq1K7KRt6UEBDUOM2U4
         9TQr67wgJBE57H2PbwvoBwkvorp7j/MDcSu8uaJv3M2lDMOOVWgJii/raH7CSgZ900KU
         1F3Vzhi26zMg9UwatxXrzeAwycnr0hUE66E7PzGLwTvHRzydRPEQLNUA3gomxKipbzqV
         R/CA==
X-Forwarded-Encrypted: i=1; AJvYcCWiHeUEhe+guwdFAm5ilwuZC44PD5eyWXJH1WnKTu62S73V0EsVhBt+FuChX6p/h2kcopxU01I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzop5ZpzavU+g3ax4iGaHfv1ALUQhmSPoIrdrMaeiJuPzmIoUhs
	gsfJhJCsEYpTav+4ToxFg6YjIM1fzxSXJ1Njg/At7n9rNV+wpwBYR9zHeWmrl1cMRcRryp62Pr1
	RxfKVvx64QuFjkbwpqVO277N1p2zTmSmXs4fhq5ys4EmtaI9sYdEOOHoPKE8=
X-Gm-Gg: ATEYQzzrYlDq+2pYTqyYUgw0YlgIRij6/HQ66kOtbBPyQHualTHV5ARBE4sS38vFzJk
	O/34KEnTC8V+bdo3VWoijaH085v+hH2mzjLHxTS1LL6NToUEqrvZfTNcpJBc0J3xJIo59lIY3Ri
	q0pYotq8ZbMi0ADRJ1VhL1PPo2Jx3XUloc2vj2V+68Chr8/FYEBoXikWM+7z7Yh9z/FHW5GxdWx
	YLi4jX22x+pPkPha09pfj0uIXLcPtTPsmb9m2cTuaqFGn8kvYryvoLRQr2MXvTxoOu1yFDIa6Xj
	vzwLsoSGAbJzfVram0bnRO0ODhsjMa0kPXE6CTlA4mzXveGYoQgtawYNQW2PRrIQB8HLB10IrRK
	lJP7rqDxg2/7l5V1h58+FXEzKChIXv19qkSDPFdJl97pXNszuTJyDvCbgKZP7a2noJ2qoqZb9+h
	Z9UhC2zdlICrtHbbi57KgpVg397LaDbj1RKaA=
X-Received: by 2002:a05:620a:44d1:b0:8c7:1156:efeb with SMTP id af79cd13be357-8cd6d431747mr1653862685a.24.1773085109100;
        Mon, 09 Mar 2026 12:38:29 -0700 (PDT)
X-Received: by 2002:a05:620a:44d1:b0:8c7:1156:efeb with SMTP id af79cd13be357-8cd6d431747mr1653856285a.24.1773085108412;
        Mon, 09 Mar 2026 12:38:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d02b184sm2337010e87.23.2026.03.09.12.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:38:27 -0700 (PDT)
Date: Mon, 9 Mar 2026 21:38:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
        geert+renesas@glider.be, arnd@arndb.de, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
Subject: Re: [PATCH 6/7] arm64: dts: qcom: monaco-arduino-monza: Add sound
 node
Message-ID: <mnehsjwwp54sk5bck32emtw3e5t66b5o447m67po42vahydkv2@cdnc7yzzkwlx>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309152420.1404349-7-srinivas.kandagatla@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NSBTYWx0ZWRfX5lw5ED44vCIC
 J9s4q5CMKts+m79nOEyO3p9eIqTVhohR1tAPtIqfYk9uKL7K8tqzVbcvzM4gFxpKvTzV6R7rzaZ
 sIHTtlwwLX9x4c8PERoC03y0diANblusjJdXyexcf00cSgCfZ/Qi+WRngVAnUZOQZFUqZKQJvDN
 L27qM/vqhiM/AXTOzg8T84MAWfmv2MZgtF/JiqB2Suc97HSZTbJ8nZDHWQw9hwwMzFic1QkTj6N
 1eQRX4TIhGfFoW9ANACaUvZv0alxtpoiuh113kwtr3HIlyYGGpFIIBppmhIsO6t7E++0UbS4RUU
 cC4lCyyMnY4ETO1/9WRdkfmcaYMgBpYt66lIiAD93q95x0GvMWpjeYZhTMUYG6XY3hGEGHLPZlf
 KsYK+LrsQkH4EPA9bm37oU6mum6isTbxtFb652G2yFzMz3E54IigdWBzhAIEJDkXEHnmEOjtFhZ
 rnK9oPpcIIW2T918fVQ==
X-Proofpoint-ORIG-GUID: 9nhCurewEDXgOwleqxuRrviHty2s-uV5
X-Proofpoint-GUID: 9nhCurewEDXgOwleqxuRrviHty2s-uV5
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69af21b6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=fNMmvbdrdlD2suN_VgQA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090175
X-Rspamd-Queue-Id: 8D6EC240470
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265743-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,qualcomm.com:dkim,qualcomm.com:email];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:24:17PM +0000, Srinivas Kandagatla wrote:
> Add audio support for Arduino VENTUNOQ board, which has Headset, Mic, Ear
> and Lineout connected to external Maxim max98091 codec, HDMI audio
> via ADV7535 dsi-hdmi bridge.
> 
> Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  .../boot/dts/qcom/monaco-arduino-monza.dts    | 66 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/monaco.dtsi          | 55 ++++++++++++++++
>  2 files changed, 121 insertions(+)
> 

If you've added the file just two patches ago, why do you need to change
it again? Can't we squash this into an earlier patch?

-- 
With best wishes
Dmitry

