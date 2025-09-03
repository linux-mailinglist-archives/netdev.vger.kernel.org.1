Return-Path: <netdev+bounces-219605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EC4B42476
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 17:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00A1E1BA8063
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 15:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1EC313527;
	Wed,  3 Sep 2025 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c7zz34nU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11497313E2D
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912125; cv=none; b=Zo8RNZWuhURo/KNOiTe6SsT8P8iu65vz8AbmK6XxCQc818DXEzqY/otC9bHqB3YgS5PFfWbnorIWO3+sGG/z3MRABvMcXII4ITnegpb655yPbuyhuIlxckLwRfqZxyS425bhvGX9t4OXL2OS6vF42PphUpd4h5v3tFivLXv8eYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912125; c=relaxed/simple;
	bh=PEIi8D0ILG9jAGxoIJMBRZSWEk2VBd2QP0UtYPalGGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLYgycx8Au2WWorShFLUISJPSTzk5lxg4KYtmNiWDlQASodG7j4ciX//kdU0S6FJeAHcMUSPmdM/loT1er+FVEN9JHFefdrfPmA1RgYQ+1UAYR4v8As5d+SxkDSJ0mEtvIifkMiHlapopwyNoQU7pvmZcbryczbmBoeS9Yfo1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c7zz34nU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583DxAaf001034
	for <netdev@vger.kernel.org>; Wed, 3 Sep 2025 15:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SoH3YrDUa+bqYy/B2DvJjbGT8HAhLxpc8jLwcSCRwOE=; b=c7zz34nUkwhhp/Eq
	Mdzh+jIjmrvNfvg2XDP9A6GiLYwcb70u1CPkEEPQWqWUlSR4yA3rJsiYVVZX/+oy
	FPFf2QVrEoMzhJQtj8fOWntauHfzkGH2g0lRgfhTxvRsh2TJ7+KY/gk1Pxp5BvMu
	zYfBzx422kavaKCTuORYKPi8Nj6sKGrMLTt04onUqcE0HRdL2+yPHsWrXJKBIEjN
	z98FHOAmD5EtQuteeua8/prVTBeS9o2R03Dc2Z+zL3pgUKpzRdO/1wWS9aqt6kz9
	cNyinp9j2oDWkLqn5rEAV6BrZM5s6VGeL7zdIfubBK+RyS7+ctzgYkUb5NB+avMx
	ZriPpg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ush341ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 15:08:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77237977e7aso7764b3a.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 08:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912122; x=1757516922;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SoH3YrDUa+bqYy/B2DvJjbGT8HAhLxpc8jLwcSCRwOE=;
        b=IYMst1PqE8gH+ne5eiCHhEcNyzwNboa10LNFo/3cW6lvEcYk6+wjki5S+vrqBSEksb
         8r3BYsAJYdPnW0H5A8QrVczyhk6D2lxbInJY0gjSaB/qZk1ySYRps6zxVo5SdMsc4YNi
         MQUo5QIPkDxAjfD2HRFH99N22ocIAvRnWueZDWGXBvbKeCIkXAP5AkjHPwq7HSGP4aKy
         mheqiL4jfzM8hfhKqyr9ljAJl16w7ygnySAvWydMUEr7li+Yo/gh0iduBjleNZ2EOl4a
         vX5ZKHA/QIU40s3zUhyCdrsdnbnNIZVtlGqK3rY1FYxDgKYCMqtePwzzLXPXCrEKIzwf
         40AQ==
X-Forwarded-Encrypted: i=1; AJvYcCXquJR/JnMrXljAj+So5fd0Pi4bLsVUW+KX4OZOTdt2ogp+fSS6GgolkHQiJ60zvgK1c3pEgWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCxP4CBQNT3mxWW3IGMD8IEoPdaCsTCOmFnaCecTkjrw3L5cGx
	T7N/xT6qpHd05FOfVKQKlhHPpwX9zsAsGgeSXC8j+xNNjVYKKdCVGiCzt1ATH2/oAKneDh/EKmA
	aNy5B2UZ/roh/K276bAdemea4eY2PRBroLOiBdmLwA+oizjGvDhckKL+M53w=
X-Gm-Gg: ASbGncvAyqDW90sMnWkA1XlLXWOvVjVngVTDgx77dQ23nJaydZSjY2dcrSxWX/h5bMD
	xFamR+rMnVFwcNyovAPSitEyNDRWH4dOnmKZULI8YrT4l+Qj+qW0DuIpqjZXKCGknjRmq9ou89E
	KtFsUYiVWqMPj/oIxzX0eiI2LQyyjv5ler0ck+6WJDxP0BNMqoJ/qQ2eP6/CmNqllngzGs2h81m
	bxFkbAsRRvUHAjfweSgjwtBtZAynoSz7OpHt4B+mNQvazJj6gTFr9hoMKvQsZHjJsHDdPe1/wdV
	KPlFPalgMKk+urVGVKJYXkAPXpSOsXjk8XOzUftHdsMxtvpXLdvdqelgx8gjLKvhH71a
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr21760183b3a.4.1756912121967;
        Wed, 03 Sep 2025 08:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoo21E/5aDqRCm9BjpK6u1Ze7qpiyckB+Jd3+cAAsY5ZXnVugKuxKFWIjKzAdwtxx5J+LzRw==
X-Received: by 2002:aa7:8895:0:b0:771:fab2:83ca with SMTP id d2e1a72fcca58-7723e21e641mr21760127b3a.4.1756912121469;
        Wed, 03 Sep 2025 08:08:41 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e3fa1sm16546097b3a.83.2025.09.03.08.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:08:40 -0700 (PDT)
Date: Wed, 3 Sep 2025 20:38:33 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>
Subject: Re: [PATCH v2 04/13] arm64: dts: qcom: lemans-evk: Add nvmem-layout
 for EEPROM
Message-ID: <aLhZ8VpI4/fzo9h8@hu-wasimn-hyd.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
 <20250903-lemans-evk-bu-v2-4-bfa381bf8ba2@oss.qualcomm.com>
 <39c258b4-cd1f-4fc7-a871-7d2298389bf8@oss.qualcomm.com>
 <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLhMkp+QRIKlgYMx@hu-wasimn-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3tF/OFlRXkDm
 SbyJHNfHN2yCqioNpSlsFOAFIyUX2AGzaBJOAvjEZpmjIfzH2OofFTtjewxVvbV3/3O6r6AbBmA
 0ivgrtTdYGkDVAlX2Ecaoe8duH424xYFqFsGmkQxhJd4kBaW6oKImM74bMXDMY+CkrF3812NSpl
 DEDRUbESOeUJFeI8508XLV0QxqN7j6+cLTKnEBP1dxbbXPUhPDgpU4nc0b9i/Uw0FhgZmsqj+fL
 g0X5Xijmsn1978VLOqTwPC597zLSvAv14rrmOrYKuc0EwOS2yo3m4AE7Wjtx0nb1OwEvEHHhE4h
 SmZ45+sRLfyL5VamIKEhOjFT9ijYFAkg4pKZRzfwsdWmmTdctaCJBjwY6k0vpd68BVMPOhu4L5L
 xRP5uXZ0
X-Proofpoint-ORIG-GUID: 1g5-O5saWX-4_18IWl1_IW2qcXGsFIE9
X-Proofpoint-GUID: 1g5-O5saWX-4_18IWl1_IW2qcXGsFIE9
X-Authority-Analysis: v=2.4 cv=M9NNKzws c=1 sm=1 tr=0 ts=68b859fb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=aoA1JJJOD3z3MUMqd-EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_07,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300032

On Wed, Sep 03, 2025 at 07:41:30PM +0530, Wasim Nazir wrote:
> On Wed, Sep 03, 2025 at 02:29:11PM +0200, Konrad Dybcio wrote:
> > On 9/3/25 1:47 PM, Wasim Nazir wrote:
> > > From: Monish Chunara <quic_mchunara@quicinc.com>
> > > 
> > > Define the nvmem layout on the EEPROM connected via I2C to enable
> > > structured storage and access to board-specific configuration data,
> > > such as MAC addresses for Ethernet.
> > 
> > The commit subject should emphasize the introduction of the EEPROM
> > itself, with the layout being a minor detail, yet the description of
> > its use which you provided is important and welcome
> > 
> 
> Thanks, Konrad, for pointing this out. I’ll update it in the next
> series.

Moreover, I notice that compatible definition is missing for this
EEPROM. I will add it in next series.

-- 
Regards,
Wasim

