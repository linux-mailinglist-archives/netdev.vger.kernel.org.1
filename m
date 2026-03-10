Return-Path: <netdev+bounces-265806-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wbrkF8pgr2kmWwIAu9opvQ
	(envelope-from <netdev+bounces-265806-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:07:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F14242E02
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91685309108F
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF011459F6;
	Tue, 10 Mar 2026 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RH3i+5Hm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lz7hMBhX"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD3B2B9A4
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773101201; cv=none; b=GFonZS7Q+ns5OgJpoI8JWrAe9Os+7/O1AYjbWZEY//QOKDEQlX9+eTpQlrDKVhwLVWmZ7jWVEgf2kJZJCCKKcCiSdD5qtu8PsfnKI0sc7suIKGIMf3AGbWRZQ8OkSF0/D0URhSJONEzLYtukYmA0B1L30eqr4+drac9FJGN9hZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773101201; c=relaxed/simple;
	bh=tUmt6OxyYKm3dZ2u6t/zmku4MTRZYJky3GUiLcfgz/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HVMbXtAiDMoXwZ9C3/o6/4yEO7gIZyOIC7P/m0NwOB/fUHoEIfNsMtf7xfifaY7v1ol68aCD3R5G2mi1QngY0QnMs17HNa3TL0+9DLW+EUYNiUEEOf+bhYlC0ZeaAHkpDFrUdf5EB97imra55M/VttO5U3JI2Ic55TROUj66U8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RH3i+5Hm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lz7hMBhX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HBl65296200
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hhzas3m6jtpCWQCVIcrAsr4W
	EI6JkmKF0k2Y62ZMW8M=; b=RH3i+5HmDrcWtIsbYsGLYPAucQJ49p5jSFCP1XK8
	cmD1TTszcORCF20BgNAuXaMv/jJiLRErS8OSN8QmqlCTHyPy1z+QkEdtxohyjYG7
	A2mADZnPK9mA9JpXvpYpZGSIN7dK+BD6vZgH+2IvNkfpcXulgdym5sqCTauzjtkf
	vtuiyUTc65s3tMmjbV0vaKA2UBoopnEDP+Wh4kABNLM7l2sm0CNYv97yvtbjRe+8
	S+oMT8HwInm2qtDIf1ZRhXBmNqquWgIRW4C+P3hXW2N0zjD2euQ9JQXbhB2aEC63
	TEvjc5oqXJ7b/UHtcEB1uZLhcWij+XqY/Bv4WDu7ADTmvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4csyfy1w99-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 00:06:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cd83cfb36cso1292986985a.3
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773101197; x=1773705997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hhzas3m6jtpCWQCVIcrAsr4WEI6JkmKF0k2Y62ZMW8M=;
        b=Lz7hMBhXTcTAhut+tWMjq23JjIGrRVAj6Rwy/noN8p1xxb7jhb5SwVyDGw9z+3Hp59
         3X3LwkcAUVL9UAizuXmoJKhB3+TKeFFJHOOS9SqpJjVQ0YSOA/XjHtwSHxruxuKthPJL
         AoTDbyQh9UyVfUeUcO8c2tpLMxp8K5vD2uzDYWSyISP4bNZTE30q/N0CD1TRg16Ugc3H
         rYzjTxphR2PiThhK1SXaMD81PXGZQXkN/dGf6tkQh7KO0KExg2nlAEbNzHlKNN+6/BFI
         ++7CdmSnmAeFUYh6OybHOmJaUPaBn03nGQwRBYR6HXKqI1okFEz3VTkVsTSjRJHqv3Zd
         dz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773101197; x=1773705997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hhzas3m6jtpCWQCVIcrAsr4WEI6JkmKF0k2Y62ZMW8M=;
        b=Nza1UC9Qa0M7zXb3wo6QUEQACYLm+Y5rgVX83noIV8wvJ2N21PIy41Pn+1fFsq8hQX
         TLfGp4D1H9CVz7XQrpnll7AXtJEMLiIqsVotskHuJXBlWt50qVeH4CCMlDwaWED/nx/I
         2kBTUwf971Lheb/1T5x6rB4XlaVyXIPpI0Vmqy/g2RbJ8OqME07fW8PySFirTS+pa6r0
         uD9KTnUp17TlRm/BzuYZg2uk7VMqBWYQ9EFIGvSqHjzHt1uonqqDGGfy4RxUMaDHjtE9
         GJFE7dT3O+i+IIEZiHpil+Oi8QzR621jQYnRY57jwFiovZGrOCEduyAXWVMGGL2LwJ4A
         X98g==
X-Forwarded-Encrypted: i=1; AJvYcCVF7o+cg2RQTy//+1tAgsJGUd5GFRyUNvOocu9+ndFGFLMg+n989ox1xVs4UIZ4ajyrvpCDWe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6zB51T4BcKaWZFcyeMY9LzQd/tMwOoNdgYe83ob2fFxw/ncd
	LCkiF1/gwBdJiDaChwCTU0mTuAYKil4CVjs4EMyQa+37kRAQXHhM1i8bblM+/rDRlHi4BP9ng5r
	1xfOQ+H6NebpbgS9GanrWrcb9/GqHDsD6bYsWrSGVAkxln4zLjt6uKEzAoGs=
X-Gm-Gg: ATEYQzyS05K7bSg5qwg80xgPpWiakg3mD7lcOU+yi0kQkIGAWp1D/mLrKmUY/8R8DkU
	LxNSSxLwpzttiJkE64UAf07ttTXt7WoipFt6i+9fjWLx+NqZy3jjncIBzq3DuWTJGaCwHzJbbzQ
	fhRJDLE6/6Uy/RZcacpyIsubTxxrdyki3oYzLqifZAH4EDlB/2bldE+xet0ECAGEoCfMi0Eyj7c
	ctie/GpX+wALJqIoShaSMSdO4R0TEwMgz9a3Ox4lXOshqafQBg2A7+sDeUhiOWUeeC+MBmYD8yb
	S0BxrlEw38RSkLg4Q+YQZV6aa3B3xOi262jIrWboweBxBNu0TISItAtZ72WkVuc5hICOrTHlCPJ
	4jQKKNZMkuFtc0HRaRDZGe0RsmzJAhX1ad+X1W59RIlZVfaAXgQHnDVCa90SnBKo7h98y0+OL4H
	3+gG0u7D5AZUdCiDK2csM3Ig9PA4ur6Rnt1VA=
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr1491597285a.78.1773101196849;
        Mon, 09 Mar 2026 17:06:36 -0700 (PDT)
X-Received: by 2002:a05:620a:25cb:b0:8c5:2f36:660f with SMTP id af79cd13be357-8cd6d4afe58mr1491592585a.78.1773101196256;
        Mon, 09 Mar 2026 17:06:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a13d08d269sm2464700e87.84.2026.03.09.17.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 17:06:34 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:06:33 +0200
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
Subject: Re: [PATCH v1 5/8] slimbus: qcom-ngd-ctrl: Use the unified QMI
 service ID instead of defining it locally
Message-ID: <6dvg5nev7sbqyfhmzgw3oln7hb4b4jlw2yhrskrcibdscoziox@hir4jpjcrzey>
References: <20260309230346.3584252-1-daniel.lezcano@oss.qualcomm.com>
 <20260309230346.3584252-6-daniel.lezcano@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309230346.3584252-6-daniel.lezcano@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDIxMSBTYWx0ZWRfX2XszydR12FRx
 blXXKf9FXusoPTMNFJl/aOmZ7ms+iyRMBI/RVALQKRefEeWWNMKVe/wKClHmN03zwLgeZw94Rlp
 zWGQShfFbqdAgAuWMih9T1+LSwsqJuanqGSTcjGVM/BAt6W0/79PG9Qg0OToLbl+QdsPMvqLgnG
 sXkH7vJlFXirDLlz2PpAlb/Y3AdSFfYgUdky5qKMJ1KpU7NYgT7WZdxbGyF/wtLuinBGyiYpXTA
 qQ7RQmlW5YnYQiXZVgnFIHPZmH8Dbugr84mCGFXxSYN9SgMTLsWddoO4LUqVwCz6K6zGhOWcdIC
 3O3r4oYzwVPRoubTi8GUS8GhX/i0XjO9KyK/3tFmF9jSBnBoJnkRyp3Iwe1+UDxA3a0ItrdnhFF
 fdEr2VwvX0/dUyj2SzJZzT0DwUjYb2AU1Z0hxlQ/C/xyN32gPBgfnldDajrbu10AOGRLntVgbSE
 rDq3W1CGNmg9R6NV45g==
X-Authority-Analysis: v=2.4 cv=OcmVzxTY c=1 sm=1 tr=0 ts=69af608d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=ho3SWJPnPTLIVTUpvTwA:9 a=CjuIK1q_8ugA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: CL2JVWpJGC06k4Bpy-pcXBCDVUn8n1Lx
X-Proofpoint-ORIG-GUID: CL2JVWpJGC06k4Bpy-pcXBCDVUn8n1Lx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_06,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090211
X-Rspamd-Queue-Id: 00F14242E02
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265806-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 12:03:34AM +0100, Daniel Lezcano wrote:
> Instead of defining a local macro with a custom name for the QMI
> service identifier, use the one provided in qmi.h and remove the
> locally defined macro.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

