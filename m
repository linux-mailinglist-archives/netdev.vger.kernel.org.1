Return-Path: <netdev+bounces-298544-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lG2VHL3NK2psFQQAu9opvQ
	(envelope-from <netdev+bounces-298544-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:13:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33967822D
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:13:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="aVuTXDZ/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=VJjO+9fk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298544-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298544-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BAF2A3184EF4
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AA839FCC8;
	Fri, 12 Jun 2026 09:11:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4439656D
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:11:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255502; cv=none; b=mF0o6qZVQCZ52D0qN80ou+vqyfHQcVEhrD7zXx8eIKPWjDFWy9l2vRe+wfHkV9/xHUTOyvaZzY0nSs+SsPi4vurpWyJ84zTp01pqx4LAPaNyavCQrEMkHFbhbpSbCqs1zHs6goyUs57PCxot2uFwVNN+4SbgS226jGiRR+oRpiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255502; c=relaxed/simple;
	bh=HVX+df4r4r4dxwN87XOAKz4MPubjc4ZqELInIOqinR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTPETyFtfU5SXZifMj0RRqDlVWB70FYB0ybXIbOKjsf7LNGZSD9RH1Lvu+AEIHt6lWrKF9C+VdTE0f5FQiK7tJlx/bFFAkp0sDV7XyJ3zYEztF2w3OHcQaJlUNVFhjnpLhETdZa4wcvUP0aPtZaIFukOL8vKJ5tUOUoNHHK7r+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVuTXDZ/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VJjO+9fk; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3Bgnv2548500
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MWlVxwNP0J33Tyh80UZciLId
	M0pPmHRLu6KbBtI6/ys=; b=aVuTXDZ/skZo9mrZ8H+DnfiSbPM3ru7HoXwGU7V2
	VzsH4v1NdM8uz2jofMhDBBSpV/dVsA+FHFT0XcAn0Rnc9jW3X/f46s0JtVrOK7dx
	IhHaqUk4N0oIWgVSGDtip7qjoKGlwfImWHQlV/Gpq4TqIYlKI/pr0kOhzdCPU60I
	+UwtIs1r7wSjgjYoAYfLpZxuhEGfCiQXZaoL09qwrDApCKR/4omYM/FdwiGOAJBK
	kigAO1j5mBber8zp30yI+XcnRqojTwNqgrZa5FIDVjo8UL3hkHgZCiMUja2ng8Qt
	LSdiyHjuYU4T+2qxZ+wGNVm61P7Bei8Ky2LgN6r3JlGolg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er29utf4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 09:11:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517a00fbac6so16512011cf.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781255496; x=1781860296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MWlVxwNP0J33Tyh80UZciLIdM0pPmHRLu6KbBtI6/ys=;
        b=VJjO+9fka4La0BpK0RSipyIxHR93KifwVPO5rVu5dMpTTU5zqLsm7sfV+6lH8noI/C
         5r1GpkW2G6ViM15P76LEQMZSYK2IzVfAzj5XoFrVh64xJbe565xNnX9CG3w2SBbD034r
         7BVw/Ye6BKIIZj/ioHBEh3KVMVoVY890P/NbEp4XHubjG7mW54eWaQCmVZBU66xyEczz
         VB++Io9PUjRojEIPA9C/4qxw6mjRLO7pWPKlqxcqqe0/g1gA9Gp00KHAE1N6ZCTQ9Gf/
         j6RL1lTFL98Q0q29jt7v/Y7Uj35JEp4MpgVKqPW8dT1tyrePpyQ3/ZtD7uPBut0P30x3
         94/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781255496; x=1781860296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MWlVxwNP0J33Tyh80UZciLIdM0pPmHRLu6KbBtI6/ys=;
        b=DUy0IotIrAeehmbFgCW0VGgXY4sBM64UiVRowJceXUu1KPSF1V5TVqVG7Z4klybWpE
         yvCTgBI+XjX89ROy15CUZ2QdYgh7GIS1kpGoQtzfI2vo+ZEW0X0imSTc9t2/ObEJstKg
         Ke3AJ/bDCL898xZ2smjZfPWyhwPhZh5KZsi3ra5C2EoKKB2wyI1l5BFDz/g9ZHmOoJwE
         FGwRH9iKn2QAGeXajTZrmq2EperM3/UDh49J/ybwN0qLwsZeSkZVxp7wOwolXXZDrxHG
         pU/4Pd6KtKOecrCzHsW72WQRg51mFSmcusUP9QoCKUrGM26yl0zZayctzs1at2fiXTyC
         /4VA==
X-Forwarded-Encrypted: i=1; AFNElJ800MkqRBL1+tqnoqQHmEo3bsho4oyHGcgO4axEcwf6VgPeIlwL6M4eFcbPW0zfvAOR+Bh02gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT/2LLIt4rxNBjqsoLLySsNjS3DXvOsCCX1RKuUu+BQWJFe0X1
	xd/8FqgnZyTXQfsZt0uvMgi8zosn1CLTVywVlhMl56M1Ij1NWaT1SOpjbOmvnLZ8wDNsvQ5MmEP
	N0dKQiXfSlKmBGABh2LKxcuupaG/MW5kf52Q+WtlYFAUz75XGZxKfqSfaHjE=
X-Gm-Gg: Acq92OHh/WpXFWH/v8CiInomgK6kGJUJ4wciT5US+W0z7nA+btQEHQEk+6Kn5XQ3ekE
	ej0EpyTLFPbVtf+31vnf2IVI//raC0ffGoJiMh/D8wUCwMSBrK81HZFpkZ6DfDlIAY/JFeHgfms
	nqGHWSbaeaLlVSY5n3fByInENhxipNK9YFh/6BsKvOX2Gsltk3j5SF2027IPrC53PDR32TzCqLL
	DiGY2gvNJxuZu87qqS9PTeAJgss87Yz3DU0GCQM+uakWQjVObzbLqeBGHN6ytlTdRpNpR36r79q
	8Sbql1BTcl6D3x7Ty++Q/5y0cKfzIvP4jtcCVPZBv7pi8PaATPqjK0IVpObATPCuNz16h/ZIyQM
	hz0wYS9b635nm+aUEd45E3gkMm1rZUKjAEl0TlgmHDGZjRvda3LFnnZt5WM/JBXXQzhKk0ThE3U
	ICYc9T9EMmpTc2ru+9C9OhcC4wSYrhLNFNZ9A=
X-Received: by 2002:ac8:5a41:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-517fe229bc2mr24342681cf.35.1781255496184;
        Fri, 12 Jun 2026 02:11:36 -0700 (PDT)
X-Received: by 2002:ac8:5a41:0:b0:516:e10f:7140 with SMTP id d75a77b69052e-517fe229bc2mr24342101cf.35.1781255495685;
        Fri, 12 Jun 2026 02:11:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e170386sm379979e87.30.2026.06.12.02.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 02:11:34 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:11:31 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        daniel@makrotopia.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Message-ID: <sy2ofvdbcxspxtmfdavjvdz7oes5ieuep4znf4ayknmuwhrlgk@7lp3bkegaeif>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
 <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfXwoun7TnvyFrz
 jC1XkwzgPneIyM2tOAeAOJgX2NspnA6qZ+4UmOF5UGTR/JwIrR/+zHA9Us4njxw1hSBC+547DMP
 URYQN/9JVPd5Zg4+KAVjr4jn/B3/Vow=
X-Proofpoint-GUID: qkF-lfkEYUXWenqVDwNGUJZ_izyubgDY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA4MiBTYWx0ZWRfX45wwxDBBLLSk
 VmD7PpebNntu4tNVyEBpwXjhATV0qyYwChs2vxGWz0EgZsv0Ma2PlAKm2zl2c5R2scQWovzfqGA
 14uwaTdYpGS6fMyoqeedvsFsZmEa4VEMCP1eS+Qzla82AMK2jxjLSkrO1ileXkgzwNZRrlmANKj
 WHFKsBMgXkwPkIYmV3RcZqbBjM7vIdtH94MX5pYXVjdejjtiWFUvuM4DRMs19Adnn5tOWs6xhgg
 B2rF83NkVRKYRoZJaOwQEMOOiJKi/JM8kjzhmh1Y0AagX+M2EXGO/P7vU70Ola6eR5Gt2pH4/SO
 v5och9dQOiKpzvoRotFhoVfwlr5xHnIIkI19Mh9uEOk3KuOzjf8QkMwuse2nVpsAEZH+66OiAyU
 qcY6kW7Lo2G7eYNd7n1FXrWLzF8gjrlLn+1CohY1JY6pjz9RnN8ktQ/LrNlRl667q/5D8ucXnWZ
 1F+Ol5j78rWs1zl188Q==
X-Authority-Analysis: v=2.4 cv=DppmPm/+ c=1 sm=1 tr=0 ts=6a2bcd48 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=dCyu47M02oNEJ4VrFMgA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: qkF-lfkEYUXWenqVDwNGUJZ_izyubgDY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606120082
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298544-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:loic.poulain@oss.qualcomm.com,m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk,vger.kernel.org,lists.infradead.org,makrotopia.org,oss.qualcomm.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2C33967822D

On Tue, Jun 09, 2026 at 09:52:31AM +0200, Loic Poulain wrote:
> Some devices store the Bluetooth BD address in non-volatile
> memory, which can be accessed through the NVMEM framework.
> Similar to Ethernet or WiFi MAC addresses, add support for
> reading the BD address from a 'local-bd-address' NVMEM cell.
> 
> As with the device-tree provided BD address, add a quirk to
> indicate whether a device or platform should attempt to read
> the address from NVMEM when no valid in-chip address is present.
> Also add a quirk to indicate if the address is stored in
> big-endian byte order.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  include/net/bluetooth/hci.h | 18 ++++++++++++++++++
>  net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -164,6 +164,24 @@ enum {
>  	 */
>  	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
>  
> +	/* When this quirk is set, the public Bluetooth address
> +	 * initially reported by HCI Read BD Address command
> +	 * is considered invalid. The public BD Address can be
> +	 * retrieved via a 'local-bd-address' NVMEM cell.

Why do we need a quirk here? Can't we always assume that if there is an
NVMEM cell, it contains a correct address, even if HCI command returned
a seemingly-sensible one?

> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_USE_BDADDR_NVMEM,
> +
> +	/* When this quirk is set, the Bluetooth Device Address provided by
> +	 * the 'local-bd-address' NVMEM is stored in big-endian order.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_BDADDR_NVMEM_BE,

Also, is this necessary? Are the devices which store the address in the
wrong format in the NVMEM?

> +
>  	/* When this quirk is set, the duplicate filtering during
>  	 * scanning is based on Bluetooth devices addresses. To allow
>  	 * RSSI based updates, restart scanning if needed.

-- 
With best wishes
Dmitry

