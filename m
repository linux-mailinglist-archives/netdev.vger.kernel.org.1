Return-Path: <netdev+bounces-246306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A506CE911A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11F4D305A0A5
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E02A315D58;
	Tue, 30 Dec 2025 08:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUoZKvKt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJNjo+5N"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5379315D20
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767083671; cv=none; b=iHQUZ8nqtXGPtWtPmoz7Vzb+Y2hiDiqpuk75YPeyykawlZoZTxf5ISQZS6rQz5lo2l1Rb4WoDilye+Eac5Fqx5NkgBMHVtD+AJrjcQUZr72mqJHb6zrksMRNFhBheGhzTB/xG2ltbcEc/1g3Qp9T1s29GK/Pa6Dvhh/StIjN4z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767083671; c=relaxed/simple;
	bh=INFJcsfZWSxlRJTQvyv59/fF3HyhE8f6DQqtQubMPsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZorFgkDrba+x7HV2dhKqBhtvtyQQCpi/FkVBfY081CRicASyI25El5vVJ+opdZ67yFBidXgyljuSBwes/nUEHlTrdjFaxeK7+kiljEFWfJzG3f+p7IgMh+fp9zwAvPX0lfaXA0cRdn/nwn7lPYqq7m4x7oT3w5mgYLzK9B5PXl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lUoZKvKt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJNjo+5N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BTJqbka2284786
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=JmDH6onz2F6hM8wCmi09imO9
	YMGocJ/IDEUzPjUhyhY=; b=lUoZKvKtFwUy2gargGc34RtT/ln6LD3QrGHWk8Mf
	U+3sUAxSMPosp8rrC52acszSiqjn1U4XPkr2XoURZzQcZH7C3cBSkDjsrYNLeH0s
	9/ioqcVyt0mz8j45o2givH7nXIehKdYBINXTL92n49854blDzklyKTTFaaWra67U
	CoS8JwgdKlAmC61pocHZIYMdozUnV/8J3S1zYBf0OUL8aSnfaO7rdbfTjhJ7VBoM
	dYDx+aOPySxZkLNT+ouUTz6ArtT1iyXfj2oUcBX5jx4Z7k77C8AcJtiu74umoxVF
	y+BrnyM55ujOSdZi1/pH00Qp/HUqAAPA5UkdnnePwyKCJg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc06gscxy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:34:28 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b2dbd36752so2359447785a.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 00:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767083668; x=1767688468; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JmDH6onz2F6hM8wCmi09imO9YMGocJ/IDEUzPjUhyhY=;
        b=UJNjo+5Ntbok04+2qRkHc0bEI+abIKbfVxvY7LSOWYXrOT3O9eykQMdtsjSC30Hq7U
         b4U5zhmMazeX6WBiwdmQC3p7iPtfNOAkQTjsTfUl1Tsk9B9/AwmhpLTK4SWk0p44OHed
         bBQxXwrZxnwl2qXobYgyT6jdalni6Fy/uuiKyOuhhcw/vOCnEOw5Me8ENjARj22ACIcj
         N/FqZl0H9vVDtB+/y7SGnv9XpxRZN+OV8X1xI4NSGbUL/3GuXFZLu9Ju9PvSiPMWNrnj
         ExRA7MxtkRNSzMM82fjLAM2E8dbBthcAsmtu20PI3wDAc7vcx0LuE/3aL9uqk/CH02Ma
         yj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767083668; x=1767688468;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JmDH6onz2F6hM8wCmi09imO9YMGocJ/IDEUzPjUhyhY=;
        b=Sc6MXfvnrf1cF4WApwJclOXPekazpxKnCdkTmt4f3DE2KBpD6wMFjvU1qTuY2r/2T9
         IvsPT9PuSl6/jIJ0gknBkdG21Qz+TVE9d9kkbi2JU+JEyMjGes8fJAYI+bmdk0+6saj7
         vbD/agzqmuRbGfXu1ndVs5ZDuwpJKaO2uTLUvk24bJF2JSnDZ3tEHZwQzorg6mMTncQn
         /dw1Z0twpv+YMn2yhGCtXM2iZe/1FM/vXMbe5AVLiMu94nt3EjiPsIzCSBLovg93OAII
         GpSvUBsy6CsYeFLOuDzfZZQ9W70/XQIanT0rPAnO1lqpoewVeQOzTKKpzA0iIRbf4xVg
         PGvg==
X-Forwarded-Encrypted: i=1; AJvYcCXPEXLntX/ZaXxGGEHaxORd/MZontQcpEpUCwhBgVq3/6cl00np3U0BO2qfA+/r9sD6MO8sQCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv5WSWjS0ZTIcLTOqMsHZ2smIZGWo92cZpIlszdhql1F/dGVnu
	U7z96M3GJXo2kdZTd/VHAW6Ase4sHEqmlkwYDGtIqZgQpq+9lsD8mdWxYioQlXd2AE1w9S48koe
	1poefa3Iy/dXUMShBXwyde9jgImCd7c7T74XZ8VHk7J6GmoPqozp/XAkv7MY0R+w7JUL996IoR2
	4LXvYdgwF3mapEGzb9L5sSh5lLaehaNWxCfQ==
X-Gm-Gg: AY/fxX6or58cGBbyhzB+ioRuAFRU3dwEcIMp5qh8iwbLJ70bIBxaEMzxKaEHCYYTVvp
	fap/OkfS458loFv4DlcCawfZ7UhPJp0vZc0GymCCgLvp3dwkoOauv9SWLISf5TeskjAKoRtcK2m
	iDVnb5HtO/hw5fXEJhMoUeYq5IuI0VKMqJjqnRUrhEzOcK+QhIBzmGnupLYatIN5HJMX3Z2RX5D
	WZQexrODNUgcUnr+LVJ+aqtMW0=
X-Received: by 2002:a05:620a:1aa8:b0:85e:b7b6:81e2 with SMTP id af79cd13be357-8c08fa9f3d0mr5213231885a.50.1767083667781;
        Tue, 30 Dec 2025 00:34:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzJchHHxEM1euOPShZ0ariTVwIbtKLoOxUGQ98o8W1guZoEqPO70lDEIP4XASX1Jbhc8MtmZ5uSdStnMhixOg=
X-Received: by 2002:a05:620a:1aa8:b0:85e:b7b6:81e2 with SMTP id
 af79cd13be357-8c08fa9f3d0mr5213229085a.50.1767083667381; Tue, 30 Dec 2025
 00:34:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com> <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com> <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com> <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
 <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
 <CAFEp6-18FHj1Spw-=2j_cccmLTKHDS3uHR4ONw8geiTyWrxN2Q@mail.gmail.com>
 <16c0b1fa-9617-4ee1-b82f-e6237d7b5f6f@gmail.com> <CAGRyCJGHv19PJ+hyaTYf40GeGRHMXKi-qO0sgREnS3=7rfWGqA@mail.gmail.com>
 <90747682-22c6-4cb6-a6d1-3bef4aeab70e@gmail.com> <6d92e13b.5e8c.19a81315289.Coremail.slark_xiao@163.com>
 <CAFEp6-3pvrMmyRg37Vyv_NhXeOukY9A4TYBE9f42zMR5i04k_Q@mail.gmail.com>
 <40f27470.6281.19ab4a6d782.Coremail.slark_xiao@163.com> <2273d069.3c59.19b345318b2.Coremail.slark_xiao@163.com>
In-Reply-To: <2273d069.3c59.19b345318b2.Coremail.slark_xiao@163.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 30 Dec 2025 09:34:09 +0100
X-Gm-Features: AQt7F2rrgUbgjIooZIds_JjGEWKmh9PohpGVe5k4ha2YLfC265R92bCjQugwIU0
Message-ID: <CAFEp6-1u=HdR8FLS7fb5Wx6eX2YwPq=3FDvO5dhCbqOx85E8Vg@mail.gmail.com>
Subject: Re: Re:Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Slark Xiao <slark_xiao@163.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Daniele Palmas <dnlplm@gmail.com>,
        Muhammad Nuzaihan <zaihan@unrealasia.net>,
        Johannes Berg <johannes@sipsolutions.net>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: f0UeetWgHWDmaw5ICTQ8NI_Np_SYg0Dz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3NiBTYWx0ZWRfX9Bvf8bUl7J8m
 eR+JHjIb8FeA+9/H3st1JNAyYGL29KpVpNeouHF+FzePWoUv6l8u9qXW8UdOGV1HEpUOwBGqHtD
 rf5bRhuA2plcaoFifp9iRETiz90kiC1KuFjSrrybJMDeOGdOh/7b/zHG0/YcOCKUBxBE+GIeXj8
 /q9UdvGyq9Ztookrn1JoCgONHnvDood6wn/sAR302HzhFzXwkmjBZwNbZ3sPY6W8VhQNSJK9Rw3
 ep/mHblKqovJhnoR4pziEI7vFMxvTlwapFXwGjTW3hQg2GJBNthFBPpLYLs5SgzKMrgBnMoYJs+
 Vxz+vrmoGWRZ7qMzmqiMmJENhyO4GkY5xXNo5FhquiUOk97TUS/hpIGRm8s6ww7W0azM6BcMH7N
 rN+xhpdl0eGMEchve2UMeZoNsueCLA2lGEshrSlNh1GltwTiMMV7o4+BQcnsckclV2l3PLbyOej
 vVxzyyLt1TdpOCwmvVw==
X-Authority-Analysis: v=2.4 cv=A45h/qWG c=1 sm=1 tr=0 ts=69538e94 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=V4nyA6uAbYqQMD6alC8A:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: f0UeetWgHWDmaw5ICTQ8NI_Np_SYg0Dz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 bulkscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300076

Hi Slark,

> Hi Loic,
> We just verified this patch on our MHI device and it works well until now for
> basic function except a change in drivers/net/wwan/mhi_wwan_ctrl.c:
>
>           { .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
> +        { .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
>
> May I add this into your branch and then you can merge into net ?

As you tested it, please submit the series including your change so
that it can go through the usual review process.

Regards,
Loic

