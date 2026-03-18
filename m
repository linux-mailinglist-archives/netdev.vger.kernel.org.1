Return-Path: <netdev+bounces-269197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMJ5Gakgu2lofQIAu9opvQ
	(envelope-from <netdev+bounces-269197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:01:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8522C336A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9325E3028EFF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5CE3469F4;
	Wed, 18 Mar 2026 21:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImuPffFz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jipYs3Kv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90BE481DD
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871192; cv=none; b=bHGayMgHEybRxbvB/0D1zhkJ6uWSuc+RlFBEJX6MQ/jAf5mDrC2f9FsssuC2HZrLF7qAyaVIt1gu5/LmPJnAWCZ09i9Jopw9tAvvifRkxESu5wUH5BVsUPlyaoevDpEu3xPddFqBRFDr42J6yy2oRLDb+u0/OJSCuvH+M2uwLfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871192; c=relaxed/simple;
	bh=lraAAFPPQWNZUci0uXGFjTSkJNRLITB2mNkNcAsWEUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hu3n9d/q7n/L5ryzxmDrwiVsjNlZePQMzTN3k0FLQrmI49MQ8I2q54DSf6/DO1kEPhLo227P2puAxdurMvhVQSf0d0wXNTbHLOpgVo0IEkjDltYsOpklJA+Ltv0Qx+i40UMzP3DG0juuGGHjX7BeDgI9RMT7/2Dy4bBDnTa3hC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImuPffFz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jipYs3Kv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62IFgpOV004053
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LBQfztnTegzW29zYjO4bRrqA
	t8SvJ6u0ZfA1KTQ6Eng=; b=ImuPffFzh+izuKvoUtZOB0iA8+kgAAkRr078s41T
	ZD/M5cof8k4lJNIXOExcLiZM5Xbb4eXkDorZ0rlqdBZb28FfgPX0+dA11ZhrLzcy
	z7X82mLhzRXB0vyhPBE8YsUNkA4gINaFYLVyP372flfafTqDlESBCERgzP4xl1Sw
	DAexbPokk+/dHj1rzkcKx5/LsQ07J6aQ7L/GLIxaX2Yaq2pk4nMSX239Qyi31xb8
	LF3Vt1G23Usi0uUJF2wzdcFQnMYLsNeUM7Vu9sUAJS/aNJszlqk/9bU00B7v6MX/
	nD9fVQgIkr65NBxzhCd+ciOnqKHcgMdZnd+v72rxst42DA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb2p0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 21:59:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b069bfa817so2946535ad.3
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773871189; x=1774475989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBQfztnTegzW29zYjO4bRrqAt8SvJ6u0ZfA1KTQ6Eng=;
        b=jipYs3KvYAhv3f+tFPygcEl4hW8lHcV/V2X4+rStZUGTemUiB+9/Dm5Eng4ep32/2R
         oRqdJNshAnMOki4PDJWG2cDILw2OiHKbgRdzAU/DkpZc9WRZWL84SK93rBERmUOUXDoh
         +neSsC5ruae7H72z1Ir/waxO0um5iG4jSeGo+U+hv0Z2A3rqVkB/4WE4b6N5gw8hghm0
         R25Zq3hcgMfO4DWXMIJSmxpAeuFXqlEb+wSECNrNLDJl1xwfewruoekW0pXZEGROLXht
         ZekhlzA6uf/17VYJB8ZBxbT6CuD0+u7okM0LGBy4+ralbYbbcOfUytA6ZTl0V/mTY7Dd
         GLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773871189; x=1774475989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBQfztnTegzW29zYjO4bRrqAt8SvJ6u0ZfA1KTQ6Eng=;
        b=Lf9PpA2hCKNAe51BO1LXv9Q5FAv4wpVXV989BkVjunz281hkEthCdpgnzdamPrGQt0
         De132pWiZ6CSQv+BcTEw9j9cBBCQLPzXybFGnAbAEQXH/kcVoTs/EWiweGtnWVmNvxDv
         NOerGOYx5KGZm1TZcRj7G1XBQpUWYgf730RBSU4vIqWbJX7M7lT+TK1Mtqr5i4+2Mvl2
         EjlesqPLRDQNAgeAmXDmTqZoYdLWGNKzvaQvOYwmhOjGwYwU8/6r5iG0vbKc2tLZbiDJ
         /0ak3ZXtAN7fuj98yn/wu3pI0wGoqlAMVqfhtG6tTuV1vY+pYGEYrFO7aRU8aPixriUs
         V3yw==
X-Forwarded-Encrypted: i=1; AJvYcCVPEO7zxdtwwW26eOGeoEt8Vyas3RQG1M5ej7ma345cK7x5kDxeDzLDvOy6EX04dnoZtrOMrkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTw4tsLt9aF8ClppXdD1e0cDHdKaJSRF1QZyJfifRot/ZUxgAD
	UFYr/zkO5ic6KYOBZ8e3kT+J77udCttruV6wxzBilrm2xyTfDcXEqiqvCt8geUb4QQNJ5dapwvB
	QoPaKxObMEUrpUxJL7AuvOJhtp7HUsGY1NFJeonWC30IpCjbErScG10H7uSU=
X-Gm-Gg: ATEYQzxVFOnQaqezeWRFI8LQ6hA0IXSSxLCgkS+XB3iZpEZaeq1yBHuQrvqkB/xbUvg
	00QGTkq9x+EBfZxQ4aggkC4TQRQXmFx5JAZHRdaTi5fKpK1yx5JwsXyTA9VSP0M0Uhrt0fPeFGC
	yVqSPGJupV2Q3hTqdxyi6KY8/wkMAUBgRbs8HHnUHVBFq3kKMd+I9T5CfF6bMUuP1lkCi5b5hlH
	L6UnjE2h4uoL3BjX5uFM6BjmaeLwpEV+s0P7vo/Uma410BA6YSrljev6MTg1o/UQQOiS+fCBJcE
	X5b3vd/K7DYbTYhb7X8BrUyKlFOj6XjAyQ+iTpMtk6Pcb8Ahku2jqVdAyfgbz8ppBvVrmDtmjab
	Si1X48JqpxY6yDY5WATod5NkWlFTGxRjLsKA=
X-Received: by 2002:a05:6a21:1343:b0:398:9ae9:7110 with SMTP id adf61e73a8af0-39b99cb7f07mr4358092637.11.1773871188673;
        Wed, 18 Mar 2026 14:59:48 -0700 (PDT)
X-Received: by 2002:a05:6a21:1343:b0:398:9ae9:7110 with SMTP id adf61e73a8af0-39b99cb7f07mr4358071637.11.1773871188066;
        Wed, 18 Mar 2026 14:59:48 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0dfdddsm3291363a12.14.2026.03.18.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 14:59:47 -0700 (PDT)
Date: Thu, 19 Mar 2026 03:29:41 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH net-next 0/8] net: stmmac: improve PCS support
Message-ID: <absgTcRS+JAdBs3H@oss.qualcomm.com>
References: <abQC7r38QLhSeadl@shell.armlinux.org.uk>
 <abdEscs44fU4kRag@oss.qualcomm.com>
 <abdYu864OmNWiWIW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abdYu864OmNWiWIW@shell.armlinux.org.uk>
X-Proofpoint-ORIG-GUID: el9d2pD8bcxxRiTmia-xHSZylU6cJqHd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDE4OSBTYWx0ZWRfX06VcokQBlJYw
 DSTO6Ymj4a5XeBhlQvjnGZfjYJiLKyxFdPsIJCIPry7pRxr9af30oHl8xT5dEaXbmaRZTqs+hQH
 cMo0MOzxX/NUHGRAEa4EbhoxPT7HULcmjJOf4ZNNbW21qSiif3hVN4d8ZGQNbAMgb6jLkMHmCUq
 ZbzhUnboxG/7xaJKNWAUYRUZwDfIDUeGOLf1vGG7hUhq+bP2y8yshYR2xu3OGtpn1lDXwb2A3zF
 qVrDnadD/Q4KZEBwRsugye6gxOx1eP6EVqVjxp+NYotIhdhFtFjkjbpM6eLtXQloMcnSaz2pzig
 BxjIDpekr4a2wTNHmlcb1xiLI4arHrLgnSJuwMDJBiG0ODEgV/8PcKmWySsRmx70QiHNfngyaUV
 lIvyrg+mgd8+NdgPZWoyQXjM36V+SLRYoMyuwwTxJJynNv11PLCleijU9CGdvbcyrgHDM/kEoM1
 Ml4I0hYA9hQfXrZMkIQ==
X-Proofpoint-GUID: el9d2pD8bcxxRiTmia-xHSZylU6cJqHd
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bb2055 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=OIreufjBPOA6zABoq-kA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-18_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603180189
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269197-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CE8522C336A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 16, 2026 at 01:11:23AM +0000, Russell King (Oracle) wrote:
> On Mon, Mar 16, 2026 at 05:15:53AM +0530, Mohd Ayaan Anwar wrote:
> > 3. With the recent VLAN filter changes in net-next, ndo_open takes a long
> >    time to complete as vlan_restore_hw_rx_fltr() tries to write filters
> >    for all 32 indices. This board previously timed out once, but now
> >    times out for each index. This is a separate issue unrelated to this
> >    series but I added the following workaround to rule out any timing
> >    issues.
> > 	--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> > 	+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> > 	@@ -158,7 +158,8 @@ static void vlan_restore_hw_rx_fltr(struct net_device *dev,
> > 
> > 			/* Extended Rx VLAN Filter Enable */
> > 			for (i = 0; i < hw->num_vlan; i++)
> > 	-               vlan_write_filter(dev, hw, i, hw->vlan_filter[i]);
> > 	+               if (hw->vlan_filter[i])
> > 	+                       vlan_write_filter(dev, hw, i, hw->vlan_filter[i]);
> > 	 }
> > 
> > 	 static void vlan_update_hash(struct mac_device_info *hw, u32 hash,
> 
> This problem needs solving, and I suspect we need more than the
> loopback here. It needs detailed information about your hardware
> design, and comes down to the missing receive clock. stmmac is
> unusual that missing clocks affect the accessibility of the host.

I tried finding more details about the hardware implementation and
it appears that the receive clock is sourced from the SerDes PHY.

As an experiment, the following in __stmmac_open() avoids the issue
on this board:

	qcom_ethqos_set_sgmii_loopback(ethqos, true);
	stmmac_vlan_restore(priv);
	qcom_ethqos_set_sgmii_loopback(ethqos, false);

What would be the correct way to handle this? Right now, SGMII
loopback remains enabled from qcom_ethqos_probe() up to
stmmac_mac_finish().

	Ayaan


