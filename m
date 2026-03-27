Return-Path: <netdev+bounces-272598-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AHHBI+hxmnENAUAu9opvQ
	(envelope-from <netdev+bounces-272598-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:26:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D42346B5B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5123053B34
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358E29AB15;
	Fri, 27 Mar 2026 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aI1ApZLN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UU33lzFf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ACD3A1D2
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774624835; cv=none; b=LTUYnM6GvGPZ/inPU52FEkHk6Gv2rGxs99ti4ahqmTLWeDnENfKBtW2IiSL6RRs13WMW3dijGJcqUacSD1npJ4JqfnceHZ34pftcGz0cgW5NAAz7cIJRbeTqwiqr374ID3KZi8bdBflacb3iJVTYUZu56ihDQ+UttNp1Ta4FRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774624835; c=relaxed/simple;
	bh=1lutWRbeovPF4wfoD0ZRR3zRwM9YCc0EsM6OQmir7lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sl12AVHgm4Os4f06uMfkpGt1n4G7JRpq+LIAtcCP7LBhK6rVyWqxm9jocauHXE1TwR3PnXK9o1Im7/BSwKDqhvN57mgNHRrLp5X3f46ge2Zq1+HG4nMQhsiE8yfZOh18osBmmvMjjPfGuzLKORJG9lC+pBMKA+t8E42r0qi8p0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aI1ApZLN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UU33lzFf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62RDhTsN2615772
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ss76jAqWiuezivNC5zEZJoYk
	XwE9ZyVbXGzY7OaUfHw=; b=aI1ApZLNF6MrFXweEsidasxUME6VrN4llo6ogWgN
	FK26tugsLvNNXbScTkuQxxJ2x4CAZq4hGVyXHc0Ny7LsJNqyJ8xPfYg468Kktf7V
	poPtCUCMXryEgglpwszTeSqDlXL861NbWRnYNHMiGlznpEXSgMY7tkrs3azJsRso
	0HRi70nfii+izCGIY9q05lXNSco5rCg5mrvCJ6lXbc5lKRbY5R7OKFc//35xUJfi
	mJVnF7SoOLs7tK4tz8dTjqpKut6HGHGPRAntsOlrRLGgpKuiDMWZdemY+T+2WHi/
	NafbzFBBLmEo0jdaQXioYR0rK2HnJOSSBGhiah1xIND70g==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxvkhkn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:20:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aeb90532f6so26511515ad.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774624832; x=1775229632; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ss76jAqWiuezivNC5zEZJoYkXwE9ZyVbXGzY7OaUfHw=;
        b=UU33lzFf1/L6MDe6P/pAA5z5sXoEvr7DEaQy65X3vZzwQ3KvDN6KBz8r2PUa/F+pMx
         t6aLLyOEvxUaMNydVqu6LthIilL2A5aDvR907pVtDmzxFsofxDskV5Rcwr4j79VWcYXE
         YFjWGUC3UDeuXJTOjiE1QkRhUvXV6/LRWLU2FkmmeMCsY97hH6DktQH9i6TbquHor8vT
         zwai5YRi0+hhtaTsnBLzzr5rYGBPCp7ggQpRqJ3BTFEFIWgw2EsCluc+E0pddDRlZL3U
         5BVOWPas9fN2pZu2i3DcoWSQPDj3HUts9yTqycuaMJvksHTPy85E2M7XOr1KoDGxZM4K
         XvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774624832; x=1775229632;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss76jAqWiuezivNC5zEZJoYkXwE9ZyVbXGzY7OaUfHw=;
        b=hOwjM8OVC0j9rRDp7HMhcu6JUJl8z3ZI9tr89P1QgP2nJU1fuPArheuOdHVsE1X1SA
         uC7Yap/ry32TWBub0KabICuh4z2gZZ3bFOLH6Dii97/52BayH2UQtpndBDf/E8b5MwcW
         6SbJ29bSkVwJh4cI8jkjRsDJNwjKoFreNdOlmVOAQjOFxUK+RlBdD2gWUOww0dAT/h3G
         Pi9t9ugNJyN8yDMvDTHmMwOXypZ3z77SwOYhPTGcNIKZ9VEP17pBjMxnnX2QmzmMYKxr
         x8n3sJwT+y4p9m7R7C35XjX93l9IlLvvv87zLFdBXrEwV7mgR2/VGvjEf1jJ6FhVnj1G
         Vorg==
X-Forwarded-Encrypted: i=1; AJvYcCWR2uakZCX6zq9CmwRFQCJ8uPrjvmjgliF1Pq5UcSoIGJvr25XTGcXXG3bE48mjRaMtgceFWRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygWfiOBmbs+g2uiLLwZLeN5RFtZXQxVILhYh8YG6X/sugPIpWi
	6Hq4dLX37wHWUPxLZn7FCF9f4i2mThPSVaE4c4LPSGbtGOwirD7Jw2QH+y7J6mhhrmLLxOOHokk
	srb9pJ/pdj8JYwKSipwTvV12WnEr02lkS10ECKM8Dhowx4FawvyN0ARCwZQ4=
X-Gm-Gg: ATEYQzxuxP7g2L0A1i7jmYcAp0lTI0QkssQud7fPJucbBmQYOAbDZqqK7I0L/aVaZ/e
	kcJ6CTOjP6e6pWKL+emQbgpVpbCVNwoQX09yeGY8jYQCHKIyiNqgXkmW8ZEWx983vJwxhMwUodw
	lNGvN/tNjyFWLQibkpC2fueV+6dJ5N9VKJwXcFy1a3J27WqeyfpqRDYFJYWeocdfG21/DJ839pr
	pBV2+RTeFHWwU9dHzC+vwDi6EA0yU3U5CEKr39BVc5HFfaROFgL5RXFUe63Oc6sVw1VNbG8rjh0
	5Twtcx/OXZcmwJx7ybPaBAKTrY43LT3NYqM9gl+Q3Z9dy1lKHWb5kDvaOxYMc3AciURXN1Vj7Sj
	rTHYoWPiSUifuNNEk+LgcuDgoD178AAMjvcc=
X-Received: by 2002:a17:902:ecc4:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2b0cdc4357dmr31891775ad.23.1774624832320;
        Fri, 27 Mar 2026 08:20:32 -0700 (PDT)
X-Received: by 2002:a17:902:ecc4:b0:2aa:e3c7:6048 with SMTP id d9443c01a7336-2b0cdc4357dmr31891535ad.23.1774624831727;
        Fri, 27 Mar 2026 08:20:31 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc8fac97sm60839905ad.71.2026.03.27.08.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:20:31 -0700 (PDT)
Date: Fri, 27 Mar 2026 20:50:24 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 00/15] net: stmmac: qcom-ethqos: more cleanups
Message-ID: <acagOODP2QD2xJf6@oss.qualcomm.com>
References: <acZDEg9wdjhBTHlL@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acZDEg9wdjhBTHlL@shell.armlinux.org.uk>
X-Proofpoint-GUID: yzEGuBdYCBHiHkb0bi_G7_oQs7ELlWRi
X-Proofpoint-ORIG-GUID: yzEGuBdYCBHiHkb0bi_G7_oQs7ELlWRi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNiBTYWx0ZWRfX8sJ5rklexkLR
 68R5skj5ONpajIuUt6EoKYGBTNFnB5oxiNKb+MSMebFz1b3i+9KTYdLLSFoUKeGLc29hHRntpYX
 YIqtDw5E7AeySawrYdQRRDgr74RPsKooYiW2dJkt4I+Iw9qpOHzXbLb/5b4jpYB3xr2i/U9nS1b
 /XLE4yaMThIO7Nz+Cy7VLUwAh5aCReRZW5zMWvgW3KHuJkr4sD5aKUWenL9LaT3H/xl4ahopu3s
 +bfmd4a4c44Ovdeg6icYZLMbgPmgjd+gKkA5tq+KTmIehGfadhhMGIns4UmCCy43VkfGH59Q8a9
 xTZehjnHwRGERsSrCSaRLpjOCiKR+W6zQuuiXWGuAbn8fC8bLRyi5po/ZB9xiesfzdoVyyRNoDY
 iGwZ9MR/SlvOgNyfOTsX1Vg0QH12gSA2hkwl6KSGFVSRPtjS8cATNB43gs1iqmJgEo74jMYlAkC
 QrEZ7vXByKhtTu3nVGA==
X-Authority-Analysis: v=2.4 cv=ToXrRTXh c=1 sm=1 tr=0 ts=69c6a041 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=j9A04r5R_e2Fnr00k4AA:9 a=CjuIK1q_8ugA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270106
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272598-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 68D42346B5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Russell,
On Fri, Mar 27, 2026 at 08:42:58AM +0000, Russell King (Oracle) wrote:
> Further cleanups to qcom-ethqos, mainly concentrating on the RGMII
> code, making it clearer what the differences are for each speed, thus
> making the code more readable.
> 
> I'm still not really happy with this. The speed specific configuration
> remains split between ethqos_fix_mac_speed_rgmii() and
> ethqos_rgmii_macro_init(), where the latter is only ever called from
> the former. So, I think further work is needed here - maybe it needs
> restructuring into the various componenet parts of the RGMII block?
> 
> v2:
> - patch 2: fix typo in commit message
> - patch 3: fix ethqos_fix_mac_speed() comment
> 
>  .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    | 220 ++++++++-------------
>  1 file changed, 87 insertions(+), 133 deletions(-)
> 

No issues found at 100M and 1G on the QCS615 Ride board with the KSZ9031
RGMII PHY. As noted earlier, Ethernet support for this board is not yet
upstream, but I have some local changes to make it work.

10M could not be tested due to limitations of the link partner. But with
100M working fine, I am fairly certain that this series will not
introduce any new issues at 10M.

Please feel free to add my:

Tested-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

