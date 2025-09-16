Return-Path: <netdev+bounces-223377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A87B58EBA
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32E4C7ADE4A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 06:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9252E0B42;
	Tue, 16 Sep 2025 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jVa8Sre4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337CE2DECBF
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758005848; cv=none; b=HJ4nW93NmAm2qaMuWILriGKxCmEF5dQzTc1zsd6RjTCN8vLrZQKmhP7imR1m/F1JY7Yxg/TksTxE8PZIU3ZTNllHcWXVEgeOKp+nAOHPaJO9YqBufBpIPfuKA5WCqxTT9OmL/fZYTAFCda0cfsZJuQS/ZyZsQYqzyFPIXzxZSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758005848; c=relaxed/simple;
	bh=VJqgGR+I8yQ3u1riqJusgJNxUJc7JbGh1X7CuNzrMz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrXLyDoaQvVxTgmijvmEjDhIu2lgp9L7zYtLeFvWy8RmURNZdR1fFDLQJOp6n+SJPXCzpiGzXcl0o9BMqsOVQxIhquAyejxET8U0R4xGAiPJnsTJBwKuHrUsWWoOZ5hVMslgXDHxzYpvQGZbvYk82zR2HVWVG4LW/oKCVas7IRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jVa8Sre4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3piR4019573
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yDOD6naCP+XeV3EVxxXgXxWe
	VWa+eq7jpdDsyJP98B4=; b=jVa8Sre4w3lXoBUivmQ6mnN9e46kDSeXxdGBWGa0
	JfG4j+WY/GXv2C/PmWlnx7kJUtfjgSAmr3xOC5jGtMqBSGYhr5RLiXTGyCIxzDb7
	LUpVq94FDMjHLam05wUVqrOmzP5HnM0LSXpA2SEZ/2kLa6RGKB19hMYmSkeNXLIL
	4cPdD/NXIW0k/1p+317qN9PYGdEPSComfwjX9ZQQBDT4dAG3J7iIjEDMNGBt9EVz
	EpSbUNbamEjdNLpGFh/PTZ3Z3fpPWUBpszoFgyCiBkZSPk2uQAdw1d+hhZiKWSO6
	Q5UU2mFtt211TfDLK9C06ESo90+NzfgZ898aWF0K+fbqAQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 494yma7stg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 06:57:24 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7779219ccc2so2177816b3a.1
        for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 23:57:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758005843; x=1758610643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDOD6naCP+XeV3EVxxXgXxWeVWa+eq7jpdDsyJP98B4=;
        b=nD+rTcOzdT0r1S4A73RwbK4NPzPUgjwnbn3dwoJir7Ze2bvC+Br+Q6VKbr211FBfLJ
         8vhukgD+6QhfXM/biHVn4sRwcPq4wlCEOXm7fXHCzv/HePDr75K4or4rJf2zUtsy8wgP
         zEW3yb/W6/z2pui3YGgO5ICVTOZPv4IqH9z2hlQlZoetv3xWYgVk5g6wd2kHVeR42kUL
         AsudvA+OoO0n7loOesAqe9HGJwUvW0m7kuokB8I2qwfbjKrsG6ZDL98DXQ6PPCp36cW3
         FXyL+CyUaWYGYSw6owtgTTWdmCzThzS654wRBt20DiajzuFB3p/PChWejQ4FZgebULnO
         Gl5g==
X-Forwarded-Encrypted: i=1; AJvYcCXE4VPo6vR3F0TvZLt5FzcerzTjaLl0BjEfQmGqTt80H6Xj+siiwJQoQgZowj3N2JNAhJt4DPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmPFJAV6E9DGzIgOqN69/xWOC3Uuz/DYG4rEn/3W9N7iZ7EIX
	1ubQ3GP+poAu1Xf+8k7BvZKvdtBeyslPjDu3TcUKd5ES0tqklb7W9QeN/nsl83eNzu1M8tXEy5y
	IM1colONCuX3FK4tNU4XVBNWlMD4ssTwXMaYAuOE8Q6o3ykReM+O2aarr7dU=
X-Gm-Gg: ASbGncv63XNqCvx5ib6PvTEiXsPVK/+fvz2bI5mQSfoOgSV+oNJP26t/fFCBzEFprV2
	SGtA+cvwtbBnzDLvchP3RB1Xr5y7nfmsKq4kfRhqgdqyP6uDzM4oC4ciZBxD80NDh6pYAVNTesE
	UlPZdpc1HmTUZdjoJP7eY353rQMwOwxcAlMWnKrm3WrEtLi39hHc0cbeeE+92UPFnFixfjijLgL
	sq/ADZ0NLAUKPoi1ortjEDSijrsvWlMdZ/jIYt20ay1GLUVV4TwG/1i/y1pYTOJk/nQblgw9ynl
	UJlJ7gXEid0kEQ06Wb8UACqau5ATFrUPt1S1qEfC3d4zPOqEDQeDqgJ/ckUqC/7pIKmh
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330685ad.15.1758005842681;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4HAqsYboh1u5zQJIXFoukFFzA+7Y7eq8ylmhIrbJbC2vY6iiQjqmYMwdKUwYE0LFccwGbPA==
X-Received: by 2002:a17:902:d589:b0:24b:270e:56c5 with SMTP id d9443c01a7336-25d24ca88aemr166330495ad.15.1758005842191;
        Mon, 15 Sep 2025 23:57:22 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-260cf673181sm92629055ad.99.2025.09.15.23.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 23:57:21 -0700 (PDT)
Date: Tue, 16 Sep 2025 12:27:15 +0530
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
To: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, kernel@oss.qualcomm.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH v4 07/14] arm64: dts: qcom: lemans-evk: Enable PCIe
 support
Message-ID: <aMkKS6m0QEOWz7md@hu-wasimn-hyd.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
 <20250908-lemans-evk-bu-v4-7-5c319c696a7d@oss.qualcomm.com>
 <cb2a5c93-0643-4c6b-a97f-b947c9aad32c@oss.qualcomm.com>
 <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f8df889-3f88-4b9b-a238-16044796d897@quicinc.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOSBTYWx0ZWRfX8MZMkII+NlkY
 +8DjB8zKsLJDp7AnJJkI0lRwdz4XmxWTArbbVVqqIw16vrCj1+AvIhvO982VBeg9IZFGzO1RPIU
 lsGkr7LF+T3YIrfxdjn89FyQcb/Nl72dUdNlS0hbliyuKZT9Jz0V9GDTYUrp7WQOn00X4R47Zvp
 hD725cox1VJZz35OEy9OQKG5hJLgtWoK6s+QYfYXXgoQU405sZXI0bGWY+ahPBA7DO51WP8dEK9
 bW2pKr6Yi8642ei0XVjlftuEBGeLh7xqCgjuvORK4VOkIdl0MlSplJWVHVmCDLx3WbnhCdm2RwX
 eJc8KqO9n74Fs9mz5vHB2gW3KZbhTL1udXu39I57zZsh+aQg0ems1OVDFjb/3zo2gqm5uc4O/e5
 wQ9iioQV
X-Authority-Analysis: v=2.4 cv=cdTSrmDM c=1 sm=1 tr=0 ts=68c90a54 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=aPFnfdsyqS22SUcEH6cA:9 a=CjuIK1q_8ugA:10 a=IoOABgeZipijB_acs4fv:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Xor75WsaMwQ4bc6Fmf3kbGoUm-fO4ay4
X-Proofpoint-GUID: Xor75WsaMwQ4bc6Fmf3kbGoUm-fO4ay4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130019

On Mon, Sep 15, 2025 at 04:03:14PM +0530, Sushrut Shree Trivedi wrote:
> 
> On 9/12/2025 5:57 PM, Konrad Dybcio wrote:
> > On 9/8/25 10:19 AM, Wasim Nazir wrote:
> > > From: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > 
> > > Enable PCIe0 and PCIe1 along with the respective phy-nodes.
> > > 
> > > PCIe0 is routed to an m.2 E key connector on the mainboard for wifi
> > > attaches while PCIe1 routes to a standard PCIe x4 expansion slot.
> > > 
> > > Signed-off-by: Sushrut Shree Trivedi <quic_sushruts@quicinc.com>
> > > Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
> > > ---
> > [...]
> > 
> > > +		perst-pins {
> > > +			pins = "gpio2";
> > > +			function = "gpio";
> > > +			drive-strength = <2>;
> > > +			bias-pull-down;
> > > +		};
> > Pulling down an active-low pin is a bad idea
> 
> Ack, we should do pull up.
> we took reference from the previous targets which seems to be wrong.
> we will make it pull up.
> 
> Bjorn,
> can you make this change while applying or shall we send new series.
> 

Let me send another series with this change, rebasing on top of audio
change that is part of next.

-- 
Regards,
Wasim

