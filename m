Return-Path: <netdev+bounces-220363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44732B4592A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15612B6213C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E313353377;
	Fri,  5 Sep 2025 13:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="I2iDrcK2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AA35336E
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 13:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757079095; cv=none; b=AAIpd1E8yh4BBcWM7mlUY2RQjuCA5eCCLmO7Cpkqh43ScfMufFTo34H/PLay3dEPX9oJwHZhFulF7mGWWRvLpE+oDjry4nncIennrVXF2eijzQgD9wrqF8HC0Ae/otquwpmEc6DU4QnQ2ZhY57VJvq7qNJTkL/EABGXYU9qoDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757079095; c=relaxed/simple;
	bh=u71qfKOWjyVGncxnFyXAU1KTKw0E7c1hs3vkkIOrnAA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfMmzYyFrxvK67sbHyg+7sCTMbd5U34qYRWl62s1ztbzsLFdX+7AbO66opTyRVNGPEdnrchP9gMXs3ISbjej6/qt6Wmv5VLqFzvJFDEwgHJsDPhEzk9x5refBGvReQNXBZAb4Nwny1vthnyzKhCAvhPOFK0ja9J/ciLuyLFj9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=I2iDrcK2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5857JQJ3013602;
	Fri, 5 Sep 2025 13:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=+aB+iZJnL8ozb2pDFXduEFu8
	qABJrtYdff1K70ebeAQ=; b=I2iDrcK2MtkwVOPA+dlHtSA5J7zfQxu0rYmziqH+
	cbcPv2FznN/UqiPECDfEjy2+99U/vtjuRm/mOLxKIjwofbuMn+2P5ISX3p8sjdL5
	7qSnITFbD7hRQ5ShNQKxqOjFRMkrL5nu9JgSWvOjNH6hqNovIE3xLIpOe5PZ612N
	/olG8fUXjIudIjG8fveehNl4AjElKTEQNBJwyg+bWm2UIG1xzdWtUgESRocyamEW
	ov4MKhunL6PY+xQXMy8BZYFJgWij9N9kdVHfDOjLbgdHBQp1+QZcJCZuDRYJLZ5C
	nDgX/1qn1WUhXq1NdMHvlBTUqB9CNSxtjm+iL6PWiwqF8A==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wyf709-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 13:31:08 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 585DV7hH029888
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Sep 2025 13:31:07 GMT
Received: from quicinc.com (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.24; Fri, 5 Sep
 2025 06:31:03 -0700
Date: Fri, 5 Sep 2025 19:00:59 +0530
From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 00/11] net: stmmac: mdio cleanups
Message-ID: <aLrmEzyxzo1DRBNG@quicinc.com>
References: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aLmBwsMdW__XBv7g@shell.armlinux.org.uk>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68bae61c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=PHq6YzTAAAAA:8
 a=COk6AnOGAAAA:8 a=UbDMmHRTMWTSUy5J07AA:9 a=CjuIK1q_8ugA:10
 a=ZKzU8r6zoKMcqsNulkmm:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YCkfEWMsAiv0yIOvixc3HIKlFi2tOG5r
X-Proofpoint-ORIG-GUID: YCkfEWMsAiv0yIOvixc3HIKlFi2tOG5r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX7Sk9AX65HGTR
 +yaae3yNsjsCY8k3TeqkbgczQendvtlfhcSXhcwyCwSe1GYsvrkmA4xgyRtzMFFmCdtFstBtwnJ
 CEqL2jpzTOtyexlVDjO/w8wBR0pds4NfMBr5ZQtqrfE5RuzClfvkHhVPOVrQuQAaX0U2GKH4pYa
 lnoU3A1yJTGde98s12J038RTVu1oHLIKHVtsThYO8Al5BR6UuytlJN4bzWhgxK5n/NClbKOm5LE
 Ar76YeNMBLBC5jr0qrb89AQITGVR97610xG3uxbI7sCDbB8UcWzqJHNhNbcmcM7Bw5Qxhr0w5dm
 smqkb3iQo6N4fkfWGYNnYdl38Nu+QdNmxkO/7w4/42S3jOWGMr3DDL+mNgPHGvVh3Ekl7Qx3K+C
 fQ0hZScY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101

On Thu, Sep 04, 2025 at 01:10:42PM +0100, Russell King (Oracle) wrote:
> On Wed, Sep 03, 2025 at 01:38:57PM +0100, Russell King (Oracle) wrote:
> Hi,
> 
> Clean up the stmmac MDIO code:
> - provide an address register formatter to avoid repeated code
> - provide a common function to wait for the busy bit to clear
> - pre-compute the CR field (mdio clock divider)
> - move address formatter into read/write functions
> - combine the read/write functions into a common accessor function
> - move runtime PM handling into common accessor function
> - rename register constants to better reflect manufacturer names
> - move stmmac_clk_csr_set() into stmmac_mdio
> - make stmmac_clk_csr_set() return the CR field value and remove
>   priv->clk_csr
> - clean up if() range tests in stmmac_clk_csr_set()
> - use STMMAC_CSR_xxx definitions in initialisers
> 
> Untested on hardware; would be grateful for any testing people can do.
> 

Picked this series on top of net-next and was able to test on the
Qualcomm QCS9100 Ride R3 board with the AQR115C Phy. No issues seen with
C45 MDIO operations, so:

Tested-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

	Ayaan

> v2: add "Return:" to patch 1 and 9
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c  |   5 +-
>  .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   3 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  82 -----
>  drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c  | 345 ++++++++++++---------
>  drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c   |   5 +-
>  6 files changed, 207 insertions(+), 235 deletions(-)
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
> 

