Return-Path: <netdev+bounces-265954-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCdZCprjr2nkdAIAu9opvQ
	(envelope-from <netdev+bounces-265954-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:25:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3E248580
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 682A830209E8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF5A43CEC2;
	Tue, 10 Mar 2026 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oIrOA7u5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PibvsG+S"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714474301C2
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133857; cv=none; b=bV1KWKRfPY4YrWDrX4YCSB2AOBrSxu6WZxR8Qu+lUHsY2IC1lZTiQIpYuzxvZ1I2uONhHmp7Bwd6Mha1DKPFnsVAfWihlNZk9/KFpcu9kwGioKEw8x8kjZEgXr71mszFmqDtek1TD6h+rXxNv8U4wMeMRUydIg60jvsUgUcazd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133857; c=relaxed/simple;
	bh=iNZ/Hvg6kNomyJ/AnRPnOSqTaL0BnqgYzf62LJiPknw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VzTp4HiC5jK8IT98wkXPiIs5l0v8VFWF72bJGKGcZA+KflXg8c92R5QAtK6YdKR9z2uqe3q9W/qWHu5QnSvtIxhTXyR8ekCyl9zdgeE4OC9Pf7M367TC4tlOjv8U/ZaOHtd0Cw6P/J/I3+0OiRtXl0kpnITZIzwkEnzwB+CtjRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oIrOA7u5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PibvsG+S; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A97fGn3754619
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8htl7qpsjJQZfsq7CD+YXOG9QlNQpgsiH3AG2qg9LgU=; b=oIrOA7u5bVMJ85JZ
	XkCp5Wycv2FltOSCIvVKOz9l8f9gGDRG2HaO8OMci7QV31xdGTEKhYozgz0TInoi
	+cbwVFHV407cOAHrIjPcfryXQY6+d6NYezSdqMXs40wYlf/hMFhO21o7kq31wt9L
	f/e4bBqr0HkUuo9oCTO7ZGpaOCzyBSBOiZzO5SU8tYo/Scws2z8LMhR92b8Roytg
	jXyf+sjPrQC70QBnCh13E0XqCsak+DfLAK6lka1egimkkoupNEiNHBli2Lgf5lHP
	jnLFlJ/J3OmiKXtEhlsoS5X4KmP0OIYpemCdV4luE5XV5uN5HuPtDlbm2Acf/6xR
	kvkBHw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ct477jctf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:10:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5093025ffecso8681191cf.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 02:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773133854; x=1773738654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8htl7qpsjJQZfsq7CD+YXOG9QlNQpgsiH3AG2qg9LgU=;
        b=PibvsG+SqzVSWBurxFgybz1i7O5aPJ3P7/J4yvfw0K3xqr9CfTxNXMFC20nVkoTB3K
         6V87nXb+J8osFKQOUQpXZ48RXc2V6jboOEGbASg3YKML+knXd0+Y/cVdTbUz6aZPSQxY
         jtmlJhr+7KOxA+lYSNDay/IXc3XrE8WbU5qnzL/Fd1Ow7s21DRW/iovO1/sbHt5H5jxX
         1nQvh8/oFJv9R2eUAb+T03G/k2NiCh9huRLCUFMedVNqlCOHVg5btVn8Xmfww5AzrCB6
         wOi7deg/EV6pSXLBPsLtTWDxykLCwM3lIcwf7zaTiKUgPhdZ2MU35wnrDMSqKyHxPYvI
         SSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773133854; x=1773738654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8htl7qpsjJQZfsq7CD+YXOG9QlNQpgsiH3AG2qg9LgU=;
        b=bNYKSI7ovf5776oOJYmu4KrllbdEeFStSBSq5Ljfy2Zp/frDohXP4JfigzSnl8FAyy
         LFayN1WU9WvOPVfpJDlElPrOeSGDrlf2zFdrDmwg5tWafLsHJkSPJwIgvu0Fwz/KW/o4
         VnZH9cxcJKnwsj98wW1Ux4tY1zY5RwN4tBoK7POpEAGOyVVfVDafr/4TL5QfvnUJ1cGD
         HpupLkvbJXuR+u2VjhQr7fXfZTLHXcee+uJ2/vi9UeYwPdloEeLXtNT9Qekh4yk8RFEQ
         D+gjHdPlMiPZy+RS8JtcMBPgKwxXEcmRS5i3hQSgCN/isOqLbtLfukRHSGVTiRCOIVJV
         F+7w==
X-Forwarded-Encrypted: i=1; AJvYcCXIicGvw5xSfhtrPAbk1TImoaXXCb5en5HwkeI20If31V2qACHF5gCoiSfOWkea50coDgLW0gE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx43iO5nFQcU8SI4VBHO6wUpmSrBdlTeTcmTanE+SiFY+snXPWL
	X4RK7iEG8k+qy20M1i4vcOdIjQqvbMYmr/M2/mq10n36P6FnYcos0ROTfEmGWFkXqdzIaWfK7dq
	TuOVjkj31OadNSW3YUnYZ3b+MqTUt6ZhxcUukHdqJE9YBJsDro8WzsYceQYg=
X-Gm-Gg: ATEYQzyZ3jbrBeI3hAIlZ7vkXxE4sfiO27TYpjyJhH73t3CBxqpfbAbIktkzCSDBvqa
	dWstxMx6c3jckJiYkUHkZXaA4HiCTAl9SfSlq2xbFVgEZJ+S4Qnye5UHHHxOl0M/rJkFygsyumv
	IRqJwmFKjVpxqSGoJCu3iWhxvKNQd4vQNzU5/nmZYOUOz+xeaWX/Ym6B07pIgcTYrrl7o/TehIP
	d69jzA0WcYsw4kzUFS185khlq/Zgh1VKGxtraw30M+hd/otXBlhOwz52+7cnjNB8bPI4vkQ+Mto
	kORqxTDiMVxKW/y7hgs11WzsbNIVbq3wrag6YOIuDVw2KBdZ/qCcLPE/otHsFnh5nYLUwshsOj9
	FfMc5GsVySJARpmvXqqaKIH/BKvJ9koHUikX3LRGt4p1qSesIVu4=
X-Received: by 2002:a05:620a:258d:b0:8cb:b062:c2ec with SMTP id af79cd13be357-8cd6d44b020mr1883780785a.29.1773133854550;
        Tue, 10 Mar 2026 02:10:54 -0700 (PDT)
X-Received: by 2002:a05:620a:258d:b0:8cb:b062:c2ec with SMTP id af79cd13be357-8cd6d44b020mr1883779085a.29.1773133854122;
        Tue, 10 Mar 2026 02:10:54 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:c419:a350:1e47:af0d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485419b8526sm65155455e9.0.2026.03.10.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:10:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Jialu Xu <xujialu@vimux.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        brgl@kernel.org, kees@kernel.org, krzk@kernel.org, linusw@kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Remove <linux/of_gpio.h>
Date: Tue, 10 Mar 2026 10:10:49 +0100
Message-ID: <177313382930.5248.1395703981822013627.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <7131965EF4C8E8BD+20260307030255.3490715-1-xujialu@vimux.org>
References: <D5F95320CE72E20A+20260306035539.2443355-2-xujialu@vimux.org> <7131965EF4C8E8BD+20260307030255.3490715-1-xujialu@vimux.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA3NyBTYWx0ZWRfXzAFGT36NBLAa
 2T3mooBRIcM81GBya9x/hrsLvz8Xi8pjIjfvN71k9GkvXyyLu5BQkrD8oJy7eIUvE5pG2dQdAy+
 Mv1OdQ6ntHGF7GnI+QptxmTr2r9hSbgn9heOtBro0EzeB0sf59BL4KGzew7RS11HTiGSvtBBKJw
 WB79TO5fY5fbrxJPRDToMKY7d1p2V16+QMx+vbnEi+C/GSMGMW56H3Prn8hr7fEtKtgJY0pWiRE
 PrY6TGsQgRm8gJLVh86aRD7YaxFafMeSztAVkPpQ66AGPzojIoYDba/4pdMy0D1CDbnF+tUUOao
 xe+ONHUbyfaBQwMBHMyLpEBDkyBUwE3GHhUUunCQHZ0i7UF7qIg7i710qi7bBgpq5thui1DKxay
 EbH6798IXOajsUiqxG0CsX0PrkWKLyvixK9LN6FrzbO5UnGiVItQJNEtB5i+Ac7ZR5jETTDvoNF
 DURd6j3VYyuM/FHGZZw==
X-Proofpoint-GUID: S78wScMTxvbo45FeMTL11epPT0AOG20A
X-Authority-Analysis: v=2.4 cv=KLxXzVFo c=1 sm=1 tr=0 ts=69afe01f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=-0JcDJgEzJC3EdZAtYMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: S78wScMTxvbo45FeMTL11epPT0AOG20A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100077
X-Rspamd-Queue-Id: 78C3E248580
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265954-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On Sat, 07 Mar 2026 11:00:56 +0800, Jialu Xu wrote:
> Convert the last three NFC consumers of <linux/of_gpio.h> to the
> GPIO descriptor API, then remove the deprecated header entirely.
> 
> Changes in v4:
> - Fix uninitialized reset_gpio in I2C/SPI paths by initializing it
>   to NULL in nfcmrvl_parse_dt(). (Jakub Kicinski)
> - Fix GPIO polarity for nfcmrvl: use GPIOD_OUT_HIGH and invert
>   gpiod_set_value() arguments to match active-low reset line
>   documented in marvell,nci.yaml. (Jakub Kicinski)
> - Fix continuation line alignment in s3fwrn5. (Jakub Kicinski)
> 
> [...]

Applied, thanks!

[1/3] nfc: s3fwrn5: convert to gpio descriptors
      https://git.kernel.org/brgl/c/b544927d75574330b0a8a33c113556b67df56f39
[2/3] nfc: nfcmrvl: convert to gpio descriptors
      https://git.kernel.org/brgl/c/253350dbf3e7fbd136905c98bd9f800fddb4fead
[3/3] gpio: remove of_get_named_gpio() and <linux/of_gpio.h>
      https://git.kernel.org/brgl/c/b6420bd5aa0c374331bad6c0fa2eb5f0f87cf5a0

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

