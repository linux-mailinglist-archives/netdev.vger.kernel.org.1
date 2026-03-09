Return-Path: <netdev+bounces-265744-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJnRNtwhr2myOQIAu9opvQ
	(envelope-from <netdev+bounces-265744-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:39:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F8240332
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 20:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9FB9300D341
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 19:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4713EDAD2;
	Mon,  9 Mar 2026 19:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzPzsU3Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CtShxfqg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2042D739B
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773085146; cv=none; b=HVXCM2Jwh4xn2zjh/siK5HnM8igdU469amKgg8IOWFsA0gxVy5IcHmErpTqEcX8TGlFjAuWS/s/9SMqP4Xdvsvyn8GQruCoHfcvYZAnpmvo4Q2IcL/hWMysVD51MVCWpKfEtXtfDP/CL0fkX/Le482SaInZ0Si+JFKrS/A1uvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773085146; c=relaxed/simple;
	bh=La+wCaOIk0Spj8J36Drs87QjYCaG+Sa7EiLzeXmmrs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie542TD9lL7hktZ+xyd98b/bvxMwRgD3S8u24hqPD9XXfOcc+eyQV1DKZAMnmIlfEayvjFjTA2InxBQjLSTeCBmau+qvh6zLe/uV18r70a8om8rEnQjF0gdRD2zo4zcNFz4oaWNMNXaX3c8QDSxc14xYarMVR34dS8cpvCq0/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzPzsU3Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CtShxfqg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 629HDMFj1214071
	for <netdev@vger.kernel.org>; Mon, 9 Mar 2026 19:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L0hx96Erq47qWv0Jdm8NMjeg
	uVm3B5yxv3mHoAlYQQA=; b=RzPzsU3QllcaSiB/xcWMt4EfF9MkFa9h7sRVeA8L
	9+c0SHRzP3STIaGqn/gOD3Axfc0hb5P4csrea2K8Czag6iuUMYYqsBKzTjDn8BsG
	Ss7eeMqy9Kh2qReTFAkXyObQUqVRtlfvanWJGl5a48DXuecygnk+1gW2Wvwqp5fQ
	aBV5jWBctfQ5hulJxL7YpESIzCGcwEfaVuUeip0d0avGqtj97vDdfyeSpI5GmdQL
	tYXDAvmd8q8SuJtRhwmGvif0JBcQ6ReQKqchhRhwCJdJNuL6shLBlOSuQGZFW2tG
	cKPstTIShKjsCi9c+lO40ToX00mBpyunqEEavSnnL3M0VQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cswwkhfj5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 19:39:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5092135f2e9so31812861cf.2
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773085144; x=1773689944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L0hx96Erq47qWv0Jdm8NMjeguVm3B5yxv3mHoAlYQQA=;
        b=CtShxfqgLI0WNUTkvwHEC0Uy7IRQTLpQcAovfr+280y/A0GX0HdUldUBx1ARxskxOr
         zPbKOMr0CTSPJ0f/x/6r0iAjglpf1KTCNg3cygzu5wC3Z32RU/1FqmhKyioH/gA/GD+0
         4eXD3MQYHPjMopOcpeuBDiaJMKIJiBXnPx8FVnWuGNcjfE8ae+9X+C0bJVH5fDwIP+2K
         4nYoXPhziiHHZUuY4KdCmji3v/Qy27BMx2HOO3vFDaPzu45w5yughEmO6niFO81vBcml
         k9xIJ2MZ6z2q9rL1lRgQUZM0/rGL/IVQAnAzGfnl5uW23CdXkF125yzNEZrWddsYUGya
         Q/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773085144; x=1773689944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0hx96Erq47qWv0Jdm8NMjeguVm3B5yxv3mHoAlYQQA=;
        b=bKiHaSeFPN6BJ+BYcHKIG2IZT2pvJNQlBNEzqKWvK7swKrnz6WJIseNNta56u+NBm4
         LDo1ASZl8txYICHsPHDhhxfJNj7VVZ7NBx470fp+UY6QRANCHIeMdHoCoFyPx46x0qBN
         LmFY96ELZE/ZQk4T/WTbgOK1qRNBdTawQJb1HDwRqrfhObcd9ANs5NQ4k6spDHKIZf0H
         8ZUsnZdPZ3/Ch+4ktglqZCyhzJAzLV8m6pjoJbiNBMftyBzQ2v6iXJWBqRpM+3HHZkiu
         kn8YX+93xCgMSBMg4jLqIsVyk/lQqv21c0wqQF1UeqH+zVNwcnjcbvAc1TyClqiYubFP
         Xyiw==
X-Forwarded-Encrypted: i=1; AJvYcCWF7zt6EufSY/bWZKGd9+jScFa+Vvd0Rw9kpIGQIL6Z5JBLUT/J0EaEwtrJRk22TQ1P1OyshMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YykQKQHxy9ujip9xhjDk6QisAJvV50JRQRRmjb3HENRxaEL6FCO
	IqMw4TCON8c4Hyj+gmcmg1sAM8lgWU8Lg3Crt5tFUlO75426ctCIKsDveDhuJyZFxg4cmjAtTJE
	N4W0c9DEqhE+Fx7yw75oFcLbVAssLnBe179l/e16IS0kaHTgoumJoret5fIk=
X-Gm-Gg: ATEYQzyaUhDOUPHgWodE6l+L4S/TjkkRAV7qD1MQ3YnAs7/b5iOPmwybKCVfcDIq1V/
	mQIlLvrBDybDK/yec97eV3NmKJDACWLhHontaTatU/5NpZgsdZcdjnN5oNZGA4GSoOhAbBdYFtJ
	kyzgc9NIdBVF3Vnq9byfRuBk4sqq3ijI1qbsQltXb1e1orxoJ3oN4zL8hIQqsb+jtwTxeuF238f
	TWfkhtuZ2NVVksIxR5d5nEJd0Uy6xtEOCKPwUITCGxrb2a7/U3mXPfUtDwtGnkFXd9tOUd8Grj2
	K3qJ2GfkNED/76HzObiokaIW7KPsNo2+NQiQ6aOuHRXLb7CbtQhDxlTXhrs7bTNYQFphSh/3Z5B
	fA4uLtEEGa4T1Vd8selbg6cYObHzLPmQoxzGD2tRun/Qka/gfuDutIxu4v8zO7AAYWFM8GXlSNv
	iQV2MPacszwIMqB+Xx3PAxr3zvvfFhOqPOwmM=
X-Received: by 2002:ac8:7d8e:0:b0:4ee:2721:9ebd with SMTP id d75a77b69052e-508f4942e3emr175533741cf.45.1773085143865;
        Mon, 09 Mar 2026 12:39:03 -0700 (PDT)
X-Received: by 2002:ac8:7d8e:0:b0:4ee:2721:9ebd with SMTP id d75a77b69052e-508f4942e3emr175533301cf.45.1773085143445;
        Mon, 09 Mar 2026 12:39:03 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38a5d0578b9sm861571fa.35.2026.03.09.12.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 12:39:02 -0700 (PDT)
Date: Mon, 9 Mar 2026 21:39:00 +0200
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
Subject: Re: [PATCH 7/7] arm64: defconfig: Enable configs for Arduino VENTUNOQ
Message-ID: <be36jdraqezkbt6y3uiljuvijwb7cx4y6i53slobjburfs52ny@l53ordmgdgvq>
References: <20260309152420.1404349-1-srinivas.kandagatla@oss.qualcomm.com>
 <20260309152420.1404349-8-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309152420.1404349-8-srinivas.kandagatla@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=cZ/fb3DM c=1 sm=1 tr=0 ts=69af21d8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=WfKmF3k0nw495lT8CIwA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 6OAwGdSWOPMdHftV5etX9hzF9sJJYspA
X-Proofpoint-GUID: 6OAwGdSWOPMdHftV5etX9hzF9sJJYspA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE3NSBTYWx0ZWRfX4E0LIpURLd2h
 etHzIFzHIJTEGjzVmV/oeMC3T03TSqqcL4xuyDkFrKPkI0sq5mq5FMJlB6NEkXO8Ap0JYqhfT6Q
 FUGZ8hKo6d/Fu2E+OtkaCHX3pEMwqu+/yof6KYgsBtag55ZdxUde5V7cQz/q51RCC5/w6WKK2CM
 3wVqzLG7AbM2qgx5zxJThUpSnMwwwE8as/AHM9OoLbTCMqXz7JFyGgVofGezLpBYxGDfuIIe5O4
 hJwMXQQJEAheX9ZNuInCPOi99jAN8fIfejkvXmVyLKpa3m5nQHF5RA9FpF7aKDVMowkqv//eYf9
 G5WKxzVz4ZJ9L9GTwvQoVH5qWWY6hAZTIXGNzE8HbGOQwrfTz8gNgpqINvBPfFMSf0gjtn8T60c
 P1oUukFIAi69E1m5vLwRFoN7gRpAfRmkVEjV8aWo4mdXaFH83FXvU+2aVFH5BFY8i0cjWpbJzRO
 O+y8b+kTKGlsiuCIwVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090175
X-Rspamd-Queue-Id: 837F8240332
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265744-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,glider.be,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,vger.kernel.org,arduino.cc,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 03:24:18PM +0000, Srinivas Kandagatla wrote:
> Enable ETHERNET PHY and Analog codec configs required for Arduino
> VENTUNOQ board.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

