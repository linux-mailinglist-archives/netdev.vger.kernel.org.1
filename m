Return-Path: <netdev+bounces-299308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TefqNbN3L2qIBAUAu9opvQ
	(envelope-from <netdev+bounces-299308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:55:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DE6832B1
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 05:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=PBqZaOn1;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AMHa9Zzm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299308-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299308-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8DE03003EE4
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4AF2DBF75;
	Mon, 15 Jun 2026 03:55:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4599D28B4E1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:55:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781495728; cv=none; b=b0YiR8aY2X9nZtl3snu+GkvqzyCwnP7asmHZSiiDCQLbJ2vNCPFL3q1+GieUw2X4amsZFtSrVtnYHIfS7ALsKOnHbm3CTskDeGFCg1R7P6TU9iAgFGweCA/r+ocEHHh3k+3CoBauF+GMgrlycEmG+tkTS+xMOX+wJYZMTLEmU1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781495728; c=relaxed/simple;
	bh=L15k8u3orIgT0R6SYaW0sHn7giGstxi9IUpykbO6UXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VErNH3cJmToaBkD0wprWy9zP9Zd3EtFlnsQ4advHCR53CsnsfhCIkLitPJlhdxSom4Bqfmzxe+N7kvbQz3jPee+LrKLNzHWmoCvTB0sodKMHneYCF5z3P6DgF04eS080Wavyx7qQ6B7ty+WHya61KxHTF0QJo9jI/jivXB6++A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PBqZaOn1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AMHa9Zzm; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1j26a3244029
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:55:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=V5iYWamYBGi2g8X7XD8Ib5OY
	dq2ngK3owfPK32tRL48=; b=PBqZaOn1Mm3Oh21rL2hiBioLYSupkG3cmm4KUfYe
	mxmuJm7Fm5A19YvPHu6zLwEKJVGvRvSCgGVeYdo/NBzXqDM3lYkRzU9tF9JEtaNJ
	5VTXoNHPQaceMTusIrT+dc2hdQJ1FTvHfiQEW+Np3V/D+/HcwhCClYB+idhK6CwA
	+vTGh3weu/DDo7VhLdLaxAhsHhWz4MNWJYwJ8f9R76jmz9QKqVkm+guTftMjK3kC
	6yATU0P5UCM827/3ekTbic95ipQZMw+IxZN5jLtjdq2QM1jsdst/ewu2rCWLK7og
	cgB4+/mjT7mWnD1gOPKDfSwSBUiBrJZwVaE5Knt1jvrv+w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ery7gwdty-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 03:55:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8620ee0971so3111681a12.0
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 20:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781495725; x=1782100525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V5iYWamYBGi2g8X7XD8Ib5OYdq2ngK3owfPK32tRL48=;
        b=AMHa9Zzm9A5ymAgh5yxiVeY/6sSOiywDTHAhC/qtVPophLSr98dSRoAtEM2Bqg4BwN
         rcTvHLBaObZsjMRuDrtdxZ53nnvRiM5jTySmRisyeO6E9dWE6uhItkUlgOSqu/7mzTg5
         S5LF6Nqy4gak25iEDeHkAQcJp5O+jRveDVhWeRvdXofloEW8G7qpjeRXbmzg2Wkw5leU
         AHuNxBXIGYiqhjUynlKUPY7tB+FDOjZo2vt65Zs+setmMfDaTsyx7KXqbIS3C8BMmlv3
         1RwF2tb0sitQi7vS7/W5/AvIjpDnmyGwTLkb6N5hzkX5kTmwewNIcCsvGtlYQxJwTjJ9
         37jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781495725; x=1782100525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V5iYWamYBGi2g8X7XD8Ib5OYdq2ngK3owfPK32tRL48=;
        b=lJ7tlRPbFfl791YwEJF/J9zEHCbEBiOzTHyHxzgp4FqcUdzWw79ru/BL9aZS3RZwsy
         TeReVSMbfJ4L8rWjZqPsfg240qdFkObrKxAeuIPChzSM1V0JfotH9V5KW6weFWLao7RW
         +0pdFqNuLqoPK+/gDzF/bhxKj2Fk3REFRJEi5uHsHMzdoJsvmRCR6pgGcaGkA9mPPf13
         e5YX1sdDEmP9dt1S6PBhKzcr/cd8ECWCMJkt5GuTeLeJx6hA6HJ/10FwI0TE5wGOnmko
         i6kZR9EcrcAO9J2jCL/MJuEYx6HCTP0MzQx4WO5gioQ8D7j5y4CMLkyJf8Nl9DZjSbJl
         y+nA==
X-Forwarded-Encrypted: i=1; AFNElJ8a8/VgRK+478NV5DCe7/V3XPQ8Yy49mBxLj9+bvtmboyjkv4thMHsCqbFT9djw2MOewBt1gnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4f42ouOLNYR/UnVgpWTKYrc7Dueid0U+lkRQEXDPpoqCrVrRR
	XCHCtvpGp2TzLxQcKJFPJ1V2qcEqgygVM52ITBNZDmAVWZnRATz9xwsjh65lwruan2ekTQPGbL6
	fVW8QGH4/csNXjCthtt7RqBa/8bRH8QvXjsx9I9Sm8aZP3vIMKptDAcvG8qY=
X-Gm-Gg: Acq92OH9FJJJVXT0ffXP9hCRM1THwUvOeHHG+PdIn9/lrM1FMMWT8ZKeU854fwv1h9U
	SvUc4rqQORczPJSIxhgHT411R2IzAMvo/NBhITnFJFDWDzxAUBs4joMmf2b2SbBzr8SWjMRlIv0
	pjVE8rP+Ac65sqGgsl6yKu1TL7i209EBbksrzIUVd/RsC1gj/4SG0fkp3BbwhMFJ1Ikk3aaw0/0
	3R4PDB37jjWYEavJxzuFVmy8cZq0msaNu8fqfnDR7PeA3fNtvGdjTeeSFJ1Sfvz5lKhhWb18byi
	8krZBj61jWty0W+tmKqKpTdIgq5zwtKYMT5t9SUcydPgKm9b3Gn8gmmXAX+lLxZQEfi2pb8DQE3
	Oi/SPtesS125NpiIeDn1XZjQtCXiExMx3Q64=
X-Received: by 2002:a05:6a00:23c5:b0:842:6004:3fbe with SMTP id d2e1a72fcca58-844e1a28e6fmr10448207b3a.25.1781495725011;
        Sun, 14 Jun 2026 20:55:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:23c5:b0:842:6004:3fbe with SMTP id d2e1a72fcca58-844e1a28e6fmr10448182b3a.25.1781495724608;
        Sun, 14 Jun 2026 20:55:24 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b05921bsm8482573b3a.59.2026.06.14.20.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 20:55:24 -0700 (PDT)
Date: Mon, 15 Jun 2026 09:25:16 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Russell King <linux@armlinux.org.uk>, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 7/9] arm64: dts: qcom: shikra-cqm-evk: Enable
 ethernet0
Message-ID: <ai93pMA6MQ2zBv6q@oss.qualcomm.com>
References: <20260612-shikra_ethernet-v1-0-f0f4a1d19929@oss.qualcomm.com>
 <20260612-shikra_ethernet-v1-7-f0f4a1d19929@oss.qualcomm.com>
 <6fde35ce-52dd-4679-9952-728b6553b843@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6fde35ce-52dd-4679-9952-728b6553b843@lunn.ch>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDAzNyBTYWx0ZWRfX9kdC/zbWiVlD
 2O/71SziR/88ehNvqMiqCaPNyltPtpchJHQy8G1Z2E2OXX+igewzhJSJDyF7iArU2Vf4pNHxvNt
 TuLtgi6v8QCqhkT+R5FCgeG+0ilu94Y=
X-Authority-Analysis: v=2.4 cv=fLYJG5ae c=1 sm=1 tr=0 ts=6a2f77ae cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=HuS8l_LH735D3i-wPbwA:9 a=CjuIK1q_8ugA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDAzNyBTYWx0ZWRfX/dYyJF5Y+6xE
 q97kk3suW3E1qgaQ+8C1+ntXnN4WR7ahpoW/TPaBzmm61jhoRGGtgfrLs454+M8XDS6rizCiCE1
 lwkD7DhAQOhaBm2ATZXRF9HQyENRqhmNud/V607BRKUoty6Hnlfr4RxFWN6COE9zPJzgdPom07R
 yLnbjvHMMfo4g8vlzMB9OuGmwkJkNgggc9Kx6INbscE4Rt0uLmZOc8acyt/89vTsAPL+KshDDl8
 VvBrXb4SXExM7ODaDWpcvJuZfnrmhUJoHhz+lORvBZ+b1pOpRdJZ9vtffJw7mrlAmcR9X8dDtix
 DMIP8ucZ21FNYTy8mO/fjdQqvfJXXkZE5wSxKuXB8oAjMBxA5D4O/8HQ4tE1ekQ5vKBr1rxEYFE
 gAmqpok7e+iXxvHr3Ak0WKSA9uheRfXpYQckl3jDK+cVY4AP57IxNjB3Uck9KUJvlFq2ZVnVa1F
 1u+zRlP6JsFyAnJTJMQ==
X-Proofpoint-GUID: TpjQTS6Po_FCvAfH5k2LCpLSpt5AZuIQ
X-Proofpoint-ORIG-GUID: TpjQTS6Po_FCvAfH5k2LCpLSpt5AZuIQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150037
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-299308-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux@armlinux.org.uk,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:krzk@kernel.org,m:conor@kernel.org,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6F1DE6832B1

On Thu, Jun 11, 2026 at 10:58:39PM +0200, Andrew Lunn wrote:
> > +		ethphy0: ethernet-phy@7 {
> > +			compatible = "ethernet-phy-ieee802.3-c22";
> > +			reg = <7>;
> > +			reset-gpios = <&tlmm 135 GPIO_ACTIVE_LOW>;
> > +			reset-assert-us = <10000>;
> > +			reset-deassert-us = <50000>;
> > +			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> > +			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
> 
> Are these two needed? It should default to 2ns, since that is what the
> RGMII standard says the delay should be.
> 
That is true, I will remove these in v2.

	Ayaan

