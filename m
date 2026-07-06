Return-Path: <netdev+bounces-305129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vzRJOGnVS2pdbAEAu9opvQ
	(envelope-from <netdev+bounces-305129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:18:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7077271321E
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:18:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZOlsPwHz;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GEAVzxHm;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305129-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305129-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35A43053454
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 15:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCAF41A766;
	Mon,  6 Jul 2026 15:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674C3FA5E7
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 15:46:46 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783352809; cv=pass; b=MyigsF8XAv5ypf6xtINygvQ9cpk55rmdsOBfjp2Hfygs3VI/83ITZvTUGuxvsxfn4U/nthp3u6clFkOmyF77Sqc++7Dlyc7PcfNlavfnQcXbP+9zHhKIWXAu52H23LDpDMuRQChpkBS8zUOL7VyILBuX10ttnyjzytrHnuBGsmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783352809; c=relaxed/simple;
	bh=OT763+765AL37S5BJLMMQbirCxNjzAlqlQVzlwCI4Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyS3t5UGdVoKSJG7nfrIphI9Ko4RmGKmFJ9TC/wLT6AZaglftzff8O95XGC0r8F21OwRat9TRLswp5u99tAqGsdH928VtPRn7SUg8zUbsbqGUgnBoU/VQHdYpnOHqeOJiVFSHzH64Lac2Hk0SD2M2J8fiRT8PH+GpF6HS99VxBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZOlsPwHz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GEAVzxHm; arc=pass smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FFFgo762456
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 15:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=; b=ZOlsPwHzz3/nLKmD
	mSazt2nRu9GtZ0+YjI7Krw93S8LOBlHU4p3rkx/C2yIXPJIgBIRFTlox35JOlumq
	ltVC9qqV2Nkf0VAvnssny5+1VQXgVZo0yAtbFxWwxyJ0ztuyo5bmRLPlcgKNTPi7
	RuFInMYyg3oAoXgywhKVuuF9IZJJHpv+5m4JLyaG8AyhOP+2+Bnxhy5fBoNHHt59
	XlzxeDfgZ3b0/h/9/LqVm+fcQsfZH+MRJpOlS/QdAUGjlsxbKmIMzDannw7pW6cL
	Ao5y2uvUQDeowET76q2qeK8zaXxcs3ON1S0y9FnWgr0Lf7RkvxRUbpzXNnR5I6jI
	6M8kfw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxt8r2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 15:46:45 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ec3314f65fso34311246d6.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 08:46:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783352804; cv=none;
        d=google.com; s=arc-20260327;
        b=IemIpnbIxZYVkHGIet7G4fz9JGhc/rQ67wssS5kA6sIePl9eNMvphMzYeEEeWFpSlM
         cAKtq3Gh2Pt14f4463Yca3Hx5ZcMN8RGGnB+kX2gEnoguEWJqHgIjddIad0LMtO9AyvZ
         OTrQYJid0AD7dtPw4495/QX1mawKqyjnsy0maN1AsRneJ9rvBUGot+prHagvjNyzj7IY
         RkGC2XydQLcKsQswRmCmsu2NiKk7MdR8KB+ss252igT8+3wq0oX5IKm+VHWI2UtRmpbr
         XDbTQawameqnB+7udo+wkOY0dRAWP+vrpL5y+RCaIEDrCcHSbneyiTnLSa8yKebnIMkD
         7hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        fh=orwF8N7ppC4rpl9B9NirG7j3p+Sbd6S79c7RDP2sYFQ=;
        b=lrBBuOTyzfaJPt5Xeks8ExizfgoBBTpiTufOUZEJwTeHZpT2xaTJAtdAbcw+tg4SSl
         tr87ATlPYb8yyKoqLRnWxQmMKfKB56Y5dBmIH+lT2uEeHAA0ylEejM4LUnAG0dTgqYs3
         ehrfGUIu1T9EQZpVFpATD08rRsa0VzlJgLhc3lXPxFdAe+eH0M5u/O1amPgYX6DJubFJ
         DqP22YL4yZJOImfU/zr7B38Cxzae6ZchGnRdY59qFv/Bbt4y8Krf6y40p4gq+gi5G03w
         u3dMCgLY4GezHVnkl5fRcnjBOwt5gqjJVge8Tay1O1Zpn4e0BGQUUuJzRYnr1FlfshuA
         tomg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783352804; x=1783957604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        b=GEAVzxHmZT8MvGlOeA+dm3eELmrJL3uldb0hEDt6XvS4AFnYxXYJ+GWy0cTxdp8ySV
         WNLYI9SSiF80oGvLEccx2tsxZd76V0MXkPUeSoDlS//eeoGQFxXW2E11Nk2Bg9YxAO0V
         8w8YzakGoUY0AMCZCsS0GmcMYvZ3A9DWzDbdMFwGEMWxRX96ZEo1pHpL/U7tJg6HxHlv
         7ldnKsH8PoDwI1vdhyJCATI5KxqwBStowIUJzcoSqjewZop1g0fpTb5gtkCDZR1/3q4q
         XVvp6pD/T9xrD1cK8wEG0rwYxzpnFtxicgm0erDVfRMKXMgOrIUIu9oEVddgup3G9eIy
         +hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783352804; x=1783957604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F1tL7ezKmgwPKPnJpdHXHHXoZTxCOuZrev6KT6hfwTk=;
        b=iZr9w06SBarL4EYYeeaSLPTaabq7WMRG0JSjCAb4opCUA4zTYMNBdYbyP6ZF5L/N5q
         820bXxCFr51xp6EwV+xTzDxlFDOABzROZLWU70dD+zi4Ar0mVdOk+Gjqig2P6xK06Dzv
         R5dqR/hdAgo99uEc9Un3IjWnII0Qhghm9sCFvER6NpQQ7rRL39GXGBl7XlIl/I2GR0h6
         A3tKytuNeVteZX9yKMgGmm2DhUWn58qas6HKMqDo7E51xBonXU9hi4fsD5/4hCuT/aya
         NR654xA721mQuSuDvuvsJpy8sBf/eIjaaMyWn4CA3dq6vmb5u928bpiUyLDbZ5pDQg/+
         Ulng==
X-Forwarded-Encrypted: i=1; AHgh+RqOvEeBSt6lxJc9/G9u4vqTkhhUR601LtRACIWAT3VkZDvOacbl3R2CMlvhQKuIWfs0qxRJBh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyeBrbj5x8E3B+EK9H2+8c21mSFgIAPstwdIXMWbUu8MAy7wgk
	FttjFAX0x+302HaPBcjOQDoq5guS+MRf8Mks65PHSt83HyT/Y8N4pY5M434GKoVbneK+yYaygbu
	u6j+JsdOhoTWEbiiBTwLQup3elVHlSTuWdn0QG6D2xY6Dr5S2reIH/e9FOQVPMYw4CXlriwyQvV
	K5vihfyuLyFKfZhibpcCe4y3ALMMAoywPX1w==
X-Gm-Gg: AfdE7cmGawLWTsyCQybzEXPD/RMh4w+AF7mD/DcyVxqxO5dnHrSGcWIfAFtKxkHfLll
	+thgpf8n6GMcBroHYCURP8A8p9ZzjMR1Xog992BERFxepBT2JMOUpwhKNZz+rGx27kxybbPlk1N
	7MaL3xsbC8VoVNcZTgXvlqG30u56wxXZMadsKSlH6N2kGvP/bITKv+87jph0stmtgPxkhe
X-Received: by 2002:ad4:4eac:0:b0:8ec:235c:7a66 with SMTP id 6a1803df08f44-8fcb4c00ee9mr13393926d6.27.1783352803877;
        Mon, 06 Jul 2026 08:46:43 -0700 (PDT)
X-Received: by 2002:ad4:4eac:0:b0:8ec:235c:7a66 with SMTP id
 6a1803df08f44-8fcb4c00ee9mr13393296d6.27.1783352803240; Mon, 06 Jul 2026
 08:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609142139.1563360-1-gerg@linux-m68k.org> <20260609142139.1563360-5-gerg@linux-m68k.org>
In-Reply-To: <20260609142139.1563360-5-gerg@linux-m68k.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 17:46:31 +0200
X-Gm-Features: AVVi8Cfdl1DNUQnUfsfYJ-HKaMqWUP8hicUf_E8fyBBfHMErHTWhOeyxDX2mfns
Message-ID: <CAPx+jO8YPs-B1AJA6ShZTNMapFhmQgS79h7EHL7ZWQ3rc4g+qA@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] mmc: sdhci-esdhc-mcf: do not use readl()/writel()
 on ColdFire
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        arnd@kernel.org, wei.fang@nxp.com, frank.li@nxp.com,
        shenwei.wang@nxp.com, imx@lists.linux.dev, netdev@vger.kernel.org,
        nico@fluxnic.net, adureghello@baylibre.com, ulfh@kernel.org,
        linux-mmc@vger.kernel.org, linux-can@vger.kernel.org,
        linux-spi@vger.kernel.org, olteanv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: 2kttnXJZjlpO6Wc0AlIRUct8a5eu-qrH
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4bcde5 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=tBb2bbeoAAAA:8 a=IpJZQVW2AAAA:8
 a=GOXD6VkAu_hHpBIGSSQA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
 a=Oj-tNtZlA1e06AYgeCfH:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX4X6sngFw5bJ1
 MoE16c7I8bMEUrHhQHbtvOLAxUUIWq2kfvNkJnGv/AHevHrqY8t5ehJL1TVxSd5KfsYDQq79+Iv
 b6M2cjK3GZf5k6KxvaL/hyVKIafD9Mk=
X-Proofpoint-GUID: 2kttnXJZjlpO6Wc0AlIRUct8a5eu-qrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE2MCBTYWx0ZWRfX1XHcdUApucwh
 0uMCMxnH1+xlB/1NYc7XTrmIoE94yzYZ+MO+RNgYBqA6Ht9DAUAdb0SBGwn5Yw1rEwqTa6DrLsr
 V8HEe88KMBJtLh/J8f3lokr1XbDH+XPH8qim7nqMPzDBXxEe1nHzhJPeHAXth9Ttu0xickxq4dq
 /0RN1sdVJjwxpzdE7acEqedIWIpRV4nSQ1nitokyaAzfaOTWf0hwEunrAaZBzBEaYByXv7Fp53z
 V3TNQn8sgzucf/xwuUjonCYSyIzBud0p6Qvqty4hhkMM9ES1mrZ1MA2g2tk4/fGn8VRgDkyy3k5
 9HBQNqqKWIKHSIpGyo6ABYLdqgFXhq5aEx4HL7zIkv0AkyBvoQWSmC+bG0MMrGqAqa1VwM0OyJg
 Xl9Q4y8ikL0GR6BB/ywkxc049WCVOc0rdLWvFBS+7/Q4vCkFFlHF2cO5OVTVsJIVbmJSypkeEGQ
 fKuYnEbW2isSsgyByOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060160
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305129-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gerg@linux-m68k.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:arnd@kernel.org,m:wei.fang@nxp.com,m:frank.li@nxp.com,m:shenwei.wang@nxp.com,m:imx@lists.linux.dev,m:netdev@vger.kernel.org,m:nico@fluxnic.net,m:adureghello@baylibre.com,m:ulfh@kernel.org,m:linux-mmc@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ulf.hansson@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,nxp.com,lists.linux.dev,fluxnic.net,baylibre.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,baylibre.com:email,mail.gmail.com:mid,linux-m68k.org:email,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7077271321E

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org> w=
rote:
>
> The implementation of the readX() and writeX() family of IO access
> functions is non-standard on ColdFire platforms. They check the supplied
> IO address and will return either big or little endian results based on
> that check. This is non-standard, they are expected to always return
> little-endian byte ordered data. Unfortunately this behavior also means
> that ioreadX()/iowroteX() and their big-endian counter parts
> ioreadXbe()/iowriteXbe() are wrong. This is now in the process of being
> cleaned up and fixed.
>
> Change the use of the readX() and writeX() access functions in this drive=
r
> to use the recently defined specific ColdFire internal SoC hardware IO
> access functions mcf_read8()/mcf_read16()/mcf_read32() and
> mcf_write8()/mcf_write16()/mcf_write32().
>
> There is no functional change to the driver. Though it does have the
> effect of making the IO access slightly more efficient, since there is
> no longer a need to do the address check at every register access.
>
> Acked-by: Angelo Dureghello <adureghello@baylibre.com>
> Tested-by: Angelo Dureghello <adureghello@baylibre.com>
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: moved from RFC to PATCH
>
>  drivers/mmc/host/sdhci-esdhc-mcf.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-mcf.c b/drivers/mmc/host/sdhci-=
esdhc-mcf.c
> index 375fce5639d7..6853521e8b2c 100644
> --- a/drivers/mmc/host/sdhci-esdhc-mcf.c
> +++ b/drivers/mmc/host/sdhci-esdhc-mcf.c
> @@ -55,7 +55,7 @@ static inline void esdhc_clrset_be(struct sdhci_host *h=
ost,
>         if (reg =3D=3D SDHCI_HOST_CONTROL)
>                 val |=3D ESDHC_PROCTL_D3CD;
>
> -       writel((readl(base) & ~mask) | val, base);
> +       mcf_write32((mcf_read32(base) & ~mask) | val, base);
>  }
>
>  /*
> @@ -71,7 +71,7 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *host=
, u8 val, int reg)
>         if (reg =3D=3D SDHCI_HOST_CONTROL) {
>                 u32 host_ctrl =3D ESDHC_DEFAULT_HOST_CONTROL;
>                 u8 dma_bits =3D (val & SDHCI_CTRL_DMA_MASK) >> 3;
> -               u8 tmp =3D readb(host->ioaddr + SDHCI_HOST_CONTROL + 1);
> +               u8 tmp =3D mcf_read8(host->ioaddr + SDHCI_HOST_CONTROL + =
1);
>
>                 tmp &=3D ~0x03;
>                 tmp |=3D dma_bits;
> @@ -82,12 +82,12 @@ static void esdhc_mcf_writeb_be(struct sdhci_host *ho=
st, u8 val, int reg)
>                  */
>                 host_ctrl |=3D val;
>                 host_ctrl |=3D (dma_bits << 8);
> -               writel(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
> +               mcf_write32(host_ctrl, host->ioaddr + SDHCI_HOST_CONTROL)=
;
>
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writew_be(struct sdhci_host *host, u16 val, int re=
g)
> @@ -110,24 +110,24 @@ static void esdhc_mcf_writew_be(struct sdhci_host *=
host, u16 val, int reg)
>                  * As for the fsl driver,
>                  * we have to set the mode in a single write here.
>                  */
> -               writel(val << 16 | mcf_data->aside,
> +               mcf_write32(val << 16 | mcf_data->aside,
>                        host->ioaddr + SDHCI_TRANSFER_MODE);
>                 return;
>         }
>
> -       writel((readl(base) & mask) | (val << shift), base);
> +       mcf_write32((mcf_read32(base) & mask) | (val << shift), base);
>  }
>
>  static void esdhc_mcf_writel_be(struct sdhci_host *host, u32 val, int re=
g)
>  {
> -       writel(val, host->ioaddr + reg);
> +       mcf_write32(val, host->ioaddr + reg);
>  }
>
>  static u8 esdhc_mcf_readb_be(struct sdhci_host *host, int reg)
>  {
>         if (reg =3D=3D SDHCI_HOST_CONTROL) {
>                 u8 __iomem *base =3D host->ioaddr + (reg & ~3);
> -               u16 val =3D readw(base + 2);
> +               u16 val =3D mcf_read16(base + 2);
>                 u8 dma_bits =3D (val >> 5) & SDHCI_CTRL_DMA_MASK;
>                 u8 host_ctrl =3D val & 0xff;
>
> @@ -137,7 +137,7 @@ static u8 esdhc_mcf_readb_be(struct sdhci_host *host,=
 int reg)
>                 return host_ctrl;
>         }
>
> -       return readb(host->ioaddr + (reg ^ 0x3));
> +       return mcf_read8(host->ioaddr + (reg ^ 0x3));
>  }
>
>  static u16 esdhc_mcf_readw_be(struct sdhci_host *host, int reg)
> @@ -149,14 +149,14 @@ static u16 esdhc_mcf_readw_be(struct sdhci_host *ho=
st, int reg)
>         if (reg =3D=3D SDHCI_HOST_VERSION)
>                 reg -=3D 2;
>
> -       return readw(host->ioaddr + (reg ^ 0x2));
> +       return mcf_read16(host->ioaddr + (reg ^ 0x2));
>  }
>
>  static u32 esdhc_mcf_readl_be(struct sdhci_host *host, int reg)
>  {
>         u32 val;
>
> -       val =3D readl(host->ioaddr + reg);
> +       val =3D mcf_read32(host->ioaddr + reg);
>
>         /*
>          * RM (25.3.9) sd pin clock must never exceed 25Mhz.
> @@ -245,7 +245,7 @@ static void esdhc_mcf_pltfm_set_clock(struct sdhci_ho=
st *host,
>          * fvco =3D fsys * outdvi1 + 1
>          * fshdc =3D fvco / outdiv3 + 1
>          */
> -       temp =3D readl(pll_dr);
> +       temp =3D mcf_read32(pll_dr);
>         fsys =3D pltfm_host->clock;
>         fvco =3D fsys * ((temp & 0x1f) + 1);
>         fesdhc =3D fvco / (((temp >> 10) & 0x1f) + 1);
> --
> 2.54.0
>

