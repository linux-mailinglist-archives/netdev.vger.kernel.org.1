Return-Path: <netdev+bounces-284516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPlHE1Ed+mkJJgMAu9opvQ
	(envelope-from <netdev+bounces-284516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C344D178D
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 50120301D4CB
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D534921BB;
	Tue,  5 May 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M+F8y2Fs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VuMFEPFL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA348C8D7
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999152; cv=none; b=hJXVM35BudU9bwyaz2mtt1SSXe9Q+qR/Tmt2JM3/kaUkDz/m4egD5PvUiDLIujIVD5TnTe8VBikRJ3J6YSbsg8qGpXAhCyzQLqqdTNtdkAT+JqOpUvybeiT6HugxLmHu3AX0mg9q/ja2GEDVD/CNdx7DaiDz1UvcY9YKGpAnoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999152; c=relaxed/simple;
	bh=xyEx4G2wKir++EItxT2osj5+hfVEdh42Mr6R7Zl3tOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6y5ST/JzdhYYXgDHObiNHXz88xhTRLFhgSsF/xpx4sM7meKrUFeVbjxJikud9xo8lhBZmZ4qtEepUdoxv6fDMDTOcC8XJXm12ZpKKFPOF1S3TzXpcLq8Iwuz04sBrL4h9qO2dwlC7acafr/I1Ac0Od3bEDl5erhiv7iFW7lpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M+F8y2Fs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VuMFEPFL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Do0I13475625
	for <netdev@vger.kernel.org>; Tue, 5 May 2026 16:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kcvBYxHAlvNI6sLP0AoxikyR
	e9LehpKzs6txgD8Qv9A=; b=M+F8y2Fs4/hg36XqYjUZ2aG/CZNEeOdd7UKhLo9j
	8Y0UqL088LknMkhUQRRyzARuoO+oNdGh9YxrOOAxY/U7s1HsLB3jq8q8b572Tqb5
	2J2XraWuZBz9LdfA9uEUNIDzVwbtTmdX/TNaSRaMM6PHAW6gsR0T2etdCqgyjR9W
	OtKYqNDll3aDE4gWGrusBKXkSTVYtXtVbLt7Z4gD7cN8n6QH/CpYQCimZn7DQWrF
	m3GQg+lAgKMKOaKN63Lthabq8F8NRozdfQsqR4fdsT1/DalMjesfDByXRSWYZ8Ws
	d0ZxdzHiQipQdq+w9AFeL3epabsWRpQeHSAmWpEXG/tBww==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyhsgrr9s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:39:08 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba718173d1so4991535ad.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999148; x=1778603948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kcvBYxHAlvNI6sLP0AoxikyRe9LehpKzs6txgD8Qv9A=;
        b=VuMFEPFLEnWQfKlZNxTOy21MJ4cTuCEYI+jFFeGNEuyLcV61JFa2+/bg5tns4qzngr
         +V438+52M4/+U12YdSyhzaytn22IZ3Ca5TNE089SIsSAMs4YicVY1RGxrW5ki5xmbdMZ
         P5BHwB+e3rXSdElDvbIYTJtmC5ixF6zRKor+UYDFWgBRY951cUmuDXnSEAGHZbdNVOSk
         y0fOQY39aHi3gpRKiC0JWq271Ps1eER2XrDly2dZ60B79naNbPkMJ0QdOndwIY4I8CjS
         EDA2SliByOW6fQpnoY6tBsUSjmS1kSa+xcu9JPyrpzsG0QCWT/modDBSGCppXq2yKveV
         S1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999148; x=1778603948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcvBYxHAlvNI6sLP0AoxikyRe9LehpKzs6txgD8Qv9A=;
        b=kB4mYp1gaImlFmmEBgNGD8V5MPSZ3CnVuNxv6C9WAQHv1Wr8nCwH5oOjTo3sWkQWg7
         HppJPQOiiP8mCXPHWcQQthE3bXSIcWSWShtgJ905iB5pHBRYkJ+YbvWn4b+i506EjJRD
         pFqxwwR9yr9rQvyu7jWi2TQzAIHbF2K/SjvJIWjAedWRJNE3+sIDJ6/fKr/1qsorWsQx
         rZ/HetgdgH1ACo4AO0EqsgnMDsheH0ZKWp9u3mWxgH5J1Sd/q23cIcD5WjLI3vBgIwCT
         Hd0a0ARtXeyryh4bRl/tL3BCshqiMKgShY+AA1mznk0NydNYIuyK3Uol1jG9xElFxo4V
         kr1w==
X-Forwarded-Encrypted: i=1; AFNElJ9DubwqvNun7oB3SU2NcR1onTfKKYSKdYW/XVTx7gzqhEve3z32rebUSaJmGSdafHxehTBrGHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkrJAvQAT3D0J8OFuQYDU+uBBGRm/K4GyjFpvQnESWu6/uwwh3
	7NL+aDNJXQQz6xWpuFxHuxFx2YQXRgNYptfcSrWeJaeWn2eP6RKrhS3xvPcVuFdlDkqllbUehfx
	DBDmHKhgA9/wqK9tjE2wvMXzCxnt049s5ILCxjdL3s0ceyc98zN8pt8q+K6o=
X-Gm-Gg: AeBDiev1OH06WP1n0Lr18dQM89qZ9U5W71vYFAR4yEYMzzzHjGvKXH1Y8yGMnDDWeZ8
	EuoxethAiQP0meqcHtE9QBNq/gf4bPfAFyyGo3H06XCSW//lJ3gOgQWYAkMfO3LdkzBN1HNZvpH
	LTT3uiKQdmfALT4wyCrHuKJQJ/mlUjIct/ewe2I61Y+Tubx/9et0kFWf6FOQVUvCksjxQEWxIo1
	iDBpCD2E4DKFAkQ6C/Rxyh5eQjDRg9FXlG6xYeaT8WZuIxTPVcOcy+wJvQ0YmVL3kqyc4p9L2xP
	KLnugFShe14+yvY9BcZKrAeC16m4QyJiyZtjviGaZAGU3K0fHhbNAiBoeRPek5kGkanzNOOqTq5
	jzOfJcv6otY/+s+WZ911WyNGa5wRhmChNDV4ky+vtdZiHpA==
X-Received: by 2002:a17:902:ebd1:b0:2b9:eb6a:68b5 with SMTP id d9443c01a7336-2b9f28348efmr149463205ad.38.1777999147938;
        Tue, 05 May 2026 09:39:07 -0700 (PDT)
X-Received: by 2002:a17:902:ebd1:b0:2b9:eb6a:68b5 with SMTP id d9443c01a7336-2b9f28348efmr149462845ad.38.1777999147261;
        Tue, 05 May 2026 09:39:07 -0700 (PDT)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae15fb6sm148392135ad.43.2026.05.05.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:39:06 -0700 (PDT)
Date: Tue, 5 May 2026 22:08:51 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: Alex Elder <elder@riscstar.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
        rmk+kernel@armlinux.org.uk, andersson@kernel.org,
        konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linusw@kernel.org, brgl@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, Daniel Thompson <daniel@riscstar.com>,
        a0987203069@gmail.com, alexandre.torgue@foss.st.com, ast@kernel.org,
        boon.khai.ng@altera.com, chenchuangyu@xiaomi.com,
        chenhuacai@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        hkallweit1@gmail.com, inochiama@gmail.com, john.fastabend@gmail.com,
        julianbraha@gmail.com, livelycarpet87@gmail.com,
        matthew.gerlach@altera.com, mcoquelin.stm32@gmail.com, me@ziyao.cc,
        prabhakar.mahadev-lad.rj@bp.renesas.com, richardcochran@gmail.com,
        rohan.g.thomas@altera.com, sdf@fomichev.me,
        siyanteng@cqsoftware.com.cn, weishangjuan@eswincomputing.com,
        wens@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: stmmac: tc956x: add TC956x/QPS615
 support
Message-ID: <afodG9uuopgfvSmu@oss.qualcomm.com>
References: <20260501155421.3329862-1-elder@riscstar.com>
 <20260501155421.3329862-11-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501155421.3329862-11-elder@riscstar.com>
X-Proofpoint-ORIG-GUID: fuYme0RWokf11b-juDXnYzX-O12Gllaf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX8rQe8NZqBLPj
 5ATpV4kecf1sL5SKoeUZ4EIL+Wf/XUT7ROOM1PNnm8WM+iGytjCggUibNVvcXFZzIwqVkCzNYOh
 pztGC2NwlYfCb1EQgxlecvoR+4YFuPXoTfzIXgy0eEuyN39HTO0YKY8ZilDkTpwsKEv0PAFPBxH
 rtUgqJkxRj996OvqOFRS3RFhZxl2L2QpdYNVGUTKbC4Fzi3IjIJpRW9fVO6B9rxpxfNBs2fqlaC
 U+KsNWATn3ofI+IG0gOv7gkKu47r0UGnqSkZiYstH4Cy+/CaqpxoV2V0RtlYaSd4hKQ7Y5sczUq
 npFX8q8oeolY3v+2uyWbnjelOBw2EhLeMusPi9EYwsY2kiMvRm2u7x9pvxzmV8yvF472LfGTA1s
 phML2bT3wdRRXXudk+/aGC8dgH+68dAmwI4Gr79Q53HVLt9J3J455X7DOZkx2aQZjJyZsv8/P6A
 nxpG2z7/oTIfFnFZDVQ==
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=69fa1d2c cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YOnX06L-6IeA1UCcW-kA:9 a=CjuIK1q_8ugA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: fuYme0RWokf11b-juDXnYzX-O12Gllaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160
X-Rspamd-Queue-Id: B3C344D178D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk,arndb.de,linuxfoundation.org,riscstar.com,gmail.com,foss.st.com,altera.com,xiaomi.com,iogearbox.net,ziyao.cc,bp.renesas.com,fomichev.me,cqsoftware.com.cn,eswincomputing.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-284516-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,kernel,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Hi Alex,
On Fri, May 01, 2026 at 10:54:18AM -0500, Alex Elder wrote:

> +	/*
> +	 * TX956x has 8 TX queues but only #0 to #3 work for general IP traffic.

Minor typo in the comment: I think you meant TC956X instead of TX956X?

> +
> +	for (i = 0; i < td->plat->rx_queues_to_use; i++) {
> +		res->rx_irq[i] = irq_create_mapping(irq_domain, HWIRQ_RX0 + i);
> +		if (!res->tx_irq[i])

Typo: res->rx_irq instead of res->tx_irq.

PS: I was able to successfully test this series out on a Rb3Gen2 board.

	Ayaan

