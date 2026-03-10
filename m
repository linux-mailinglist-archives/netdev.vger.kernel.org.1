Return-Path: <netdev+bounces-266008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM/AM8T4r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:56:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BA7249CBC
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7416532200B6
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7840837FF67;
	Tue, 10 Mar 2026 10:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j1cI4VeQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FxfVEgeU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4E21F3D56
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773139779; cv=none; b=fAHHG57ehRK/rqs8rbi91NTYM0OVGlm8S1nYmesvMJoVf+0fJ6Adbh3EiYlxATAXqLXEZVc4Thvt9TSX8FH/lo5oO4yOkg9vILs8YVWZTwOMRj9TJOxmWrOeCKfRZHQdNGZ13I8KvAMpQ6RUikjUhGvZlazMAvCzfaTJppT/sJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773139779; c=relaxed/simple;
	bh=d4uT9vz55VMZ8lK6PT76AAj0kJ9Hw6YCt/Fp3ykSQpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LDGlrM5CIPeSN9jVdZVPARgRK/Uu5TYzmzFR8swXR+6WaP63CJVBELaqchybHVW7tszMY5lRBLnQ3TEQcHK2cJTD4P+K8amS6L4UfYLWVbfiDEsjJcv9R4DqkGPOrqaNdMk2/icsNOrw47sSUVEn1xcn6JbOoDHkXLTSqDFnOGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j1cI4VeQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FxfVEgeU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A8xkDW2363094
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UhtN4t8s2K41bms/kSTpWSYPln+wsvmKnk2d4yUllsk=; b=j1cI4VeQ67rnNDoH
	Qoom0vBje4gRYpMzaMcS4m/zzg+fmUUGsScTPIDCay4XPeNyxzJvV+2G1QEuULkX
	mcQBD0/pdZhmvFBUydWAmnZ35yPkUawpjceGWqU2JEupPiWqS430G3CMFROGRbSp
	2r/5emvqdY5OQ+DDdA6Wx1Pki2IRceuo6QU6fq7CB8TfCYA/e0LJ6+Qfm2qUci2q
	r/0yR5rfZiMKoBVzsieNw1imGykiXiE59QHSD9kHM+FyTffhEwS1N4Jr3fECttQi
	MWlFG/RbZZlLK1bNF+MOtb4uTlrbqoVxd0Nj4mZVN/nfYhD2N9PQe9J5hDjhhH7p
	3SsbZA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct032bvek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:49:37 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd84cfae34so105434785a.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773139776; x=1773744576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhtN4t8s2K41bms/kSTpWSYPln+wsvmKnk2d4yUllsk=;
        b=FxfVEgeUEfMNs3ZazefmM2mn7gpm/xq5e1Jr0knFoxB6eM8RRusIy8UEdpcHJir9mw
         NkygkMj8bUUxFMhqVwEvCC/E33n43S6nSJckwor4x2/k/gn7B/F6xZ9NJwcMUQR1lYu3
         3HiaXb7IqwAZ2QBrYNpmGcCGU+E0IIWuxw9IAfBJK5A8cp7cp+uXItlVjVZBRupcJfbl
         vSgzQ/dpyQ1z+D381NAQb3wdCIRb6uShMLHxEMrvOyg4WS7PzDIazWsa+Q5+7DeV95/0
         PlQnTLtZ/3HrIIDLovN3iTU4OzA4v1IpaH0Wzr0AZIrn7208hyCeoL+NMuyR4Av+ypAp
         /14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773139776; x=1773744576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhtN4t8s2K41bms/kSTpWSYPln+wsvmKnk2d4yUllsk=;
        b=vfJLOZDHPjW7l+GHkjXvBT4qkzujXxdHzFyyGkEhYDVn3gVOrAJuiMJ0g1jHqGDLr9
         xrRTBI9POhglGb8FxY9sCaSAeDNN9vX7aPLZt5c93U4hFjkhJa+PCyRMQDLcuPS4grqR
         E1Z+EMTJ9z+EwM2ejmvpJ/AL+CH4NIqn0kRyyWfPtON95Dg4Y2YElJmQOkyyNuhTA+HW
         PfbY0Vk3sDhmOi23XvuVwsnJ9QWRXfBlJOcaQ4y0zOylo8mqUyYYLNAT7EpP5W2sDBki
         bv51pmNtoWXuAQ3CpAVVNnBSio7DewB/PuFj4yYv3GkXrGbAwNhs0hGzUL6hO2EgtOlK
         E+LA==
X-Forwarded-Encrypted: i=1; AJvYcCXiIRwcV4lPiszNlTozwczSFF22kb7oLRdaTFzFo28fwf6JoA8DiaCDYK7s+uquu8PLKf1ynuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0Y77VPEuHkTyrNdiYb2s2ZUO+Mn7JNLnXF7g7xtv+qKzqedSD
	s/SJhRi+nmZTFeZ3epm8kz2nB/azt3sM3u2oaDpz/Mv71bDRB33a8ahKDLXXakIgZHDOl5Zj88c
	DCHtJm8R1dKbBb3+TvtFVvGIJwLY1mc0nXM0uQwikHZ6MOpEGEwzwcQEjLXw=
X-Gm-Gg: ATEYQzyFzNPBQaYw+uvzKESZDDYoywV59VDxBSJl0R/crVpKBXb/Nu1KfKKE2W/CKfV
	iTpRZtaMTCqcFaEjjALSYuZHmZQ6rTOvpHQ4BTeALBIpWg3omVlNZ5n4haQk/3S+v+z+FzipRT3
	Siz4kRBfzqO9PTB5wsaVEIO8ggbKS/I2ZsqXA4tst3XmBmloRgQUSEAXNdXkht8NdXDEWezmfUL
	iHBIE7PhZNCLVGNjmavFRw2ACaybtVTAv++aWsbxV6fBpWBjuLBsJuOn1B9llj+XD2czIhUbdYR
	4gRRTPpni2A8UcjNfTVmy2F1WYaPQ9hvjzulkci5srtVb1SbJ49j36nuhyPVJbaE3Cln3JrBFtB
	0GCrS6KdkF8QJdL+VHlHzkzPqbM1KuA1jujhusafCztYz3cfHqQdQ+GnZYs7kFSzYp8Cw1bR25N
	BehFw=
X-Received: by 2002:a05:6214:5290:b0:89a:44d7:6589 with SMTP id 6a1803df08f44-89a44d768a9mr88556286d6.8.1773139341365;
        Tue, 10 Mar 2026 03:42:21 -0700 (PDT)
X-Received: by 2002:a05:6214:5290:b0:89a:44d7:6589 with SMTP id 6a1803df08f44-89a44d768a9mr88555926d6.8.1773139340510;
        Tue, 10 Mar 2026 03:42:20 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942ef47a2csm478497166b.7.2026.03.10.03.42.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:42:19 -0700 (PDT)
Message-ID: <7bdb0697-f2a1-465d-83b9-c7b68238bf71@oss.qualcomm.com>
Date: Tue, 10 Mar 2026 11:42:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] arm64: dts: qcom: Add Arduino Monza (VENTUNOQ) board
 support
To: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: richardcochran@gmail.com, geert+renesas@glider.be, arnd@arndb.de,
        dmitry.baryshkov@oss.qualcomm.com, ebiggers@kernel.org,
        michal.simek@amd.com, luca.weiss@fairphone.com, sven@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        kuninori.morimoto.gx@renesas.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, m.facchin@arduino.cc, r.mereu@arduino.cc,
        loic.poulain@oss.qualcomm.com
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260309152420.1404349-5-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA5MyBTYWx0ZWRfXxntJSiiR1efa
 Na0oCyOhSNyMsej4zvFIvMjv7oagqSZGvoGtgqVOpOI2ucEwtsxd+85IZzi8TjxDLAIFq5zcM3y
 7Gvu6RdkUDhGbCbYkXtsC/fwJ30GXi6Z4NcR5XfoklMTJgm8Utuwpfmk12Z0feWVgfgAB5PfAt9
 ZRMV954qT0CxzZekIr9chmWVDqkg804x0BSas3dc9M6xJzKBYoVF+JOtQeEEb6KDNf7RYdKTp5J
 jpHcv8aTAhg9eqY+yzq3wjFHSUJebQWiRx/Z2y6d4d6UOR4F+fkQ0BbD05amuLUSBc0049XwS0U
 JPAn9CMf3KIjOgtfYRrHE6OlWBN7jqMOsVqHat91gPZ42vCd6l657L0+TDjwYK9EB+TnKwBqna2
 dcb/WmOEYZ7La1Zn0DlXQqvBN5M0yLMD2mdnEDu3hMpVB6b8RwY0pemK/FZV034AEwec+xfLpuX
 u67Di29YQVkpQUSQxew==
X-Proofpoint-ORIG-GUID: 8F4nJEbyEaL0eM-XEdKzQQX4Ndizi3is
X-Proofpoint-GUID: 8F4nJEbyEaL0eM-XEdKzQQX4Ndizi3is
X-Authority-Analysis: v=2.4 cv=WtEm8Nfv c=1 sm=1 tr=0 ts=69aff741 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=5D_ixgJ-nfAih4ZOxbkA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100093
X-Rspamd-Queue-Id: 35BA7249CBC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,glider.be,arndb.de,oss.qualcomm.com,kernel.org,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc];
	TAGGED_FROM(0.00)[bounces-266008-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,dt,renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 3/9/26 4:24 PM, Srinivas Kandagatla wrote:
> From: Loic Poulain <loic.poulain@oss.qualcomm.com>
> 
> Add device tree support for the Arduino VENTUNOQ board,
> based on the Qualcomm QCS8300 (Monaco) SoC.

[...]

> +	model = "Arduino VENTUNOQ";

FWIW the marketing material seems to call it "VENTUNO Q" (with a space)

[...]

> +&usb_1 {
> +	maximum-speed = "super-speed-plus";

This should be implied by the controller capabilities - does SSP still work
if you remove this line?

> +	usb-role-switch;
> +	wakeup-source;

These two belong in the SoC DTSI, the latter is already present

Konrad

