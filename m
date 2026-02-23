Return-Path: <netdev+bounces-259972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrVNnMjnGn4/wMAu9opvQ
	(envelope-from <netdev+bounces-259972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:52:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EA174443
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E66FC3033885
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEDA3502B9;
	Mon, 23 Feb 2026 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PmD/ngZd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIS4JLf0"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9364934EF0D
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771840340; cv=none; b=JiRTx9e2gib038pU6Oc8KzQjCDuUoAixWg8vWueyZjhldelJWdgiUyBFKva67QAgvTtj4n3nlCM7S3SZvsNPJ2ReBEvGq+SLiI3bR6fWKtHRd4iLPezeUXJR0B9/ZvpRpZ2weEs5Zu8hz7R8EuN4lRfl061YKhGxf71G8WB8O58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771840340; c=relaxed/simple;
	bh=NC8c2KvYVsHDNf0i1l9nwpNQ3EDyGkN49jJW0VSEurg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0MK9d1Bp46IzLbwxSuLQwHwdvatrPMEei66ZUzKNhlvaG/PTfOPX1qBUDOurH4yzFC49sGoBM7/N7tnPgjwBiJ7zWutDVEdZLEXLrj4pgCceMKeoljEprA9nKwT8WdzG3c2VCIj7iTxdTzzSDjv5Xp0ITKvec5uZQzWmhy/zsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PmD/ngZd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XIS4JLf0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61MNvaQb2916725
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uoHMTBb8IpVzr1yOCWWsa13m
	cN23kWHrFMIDsOYWxZQ=; b=PmD/ngZdTMeiHW3/nGgDiCP5TsITHRVqW170k49n
	qWSXXuUYbS8lzGkkHqw9bgWAqISRDGuhZhQoyRZv1qTDjQUUbYzzqt59myo/93GF
	onCixjAKIX8+8sySzi5VattQbfqINFnRRgLHUNx7clQMLpdaK/nQaQ7P9gY3U52y
	grodMrdOfHlwAVjWtcYHxbciZlYTMjr5Tl3NkKC6V1gr4Br6JIw6nFrUPcTdBHuk
	34McvIGWFAyqHrShfNLOXeCuEeUSi2HiZvPJsuW1tRuNXkuS3P/f1BFW92t5EIAJ
	PE4x30UCIh3SEUWArj5TSV5HlG7TtyeyJjOhX6xC/NDI8Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cf5vgv993-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 09:52:17 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e74e55d35so2922195a12.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771840337; x=1772445137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uoHMTBb8IpVzr1yOCWWsa13mcN23kWHrFMIDsOYWxZQ=;
        b=XIS4JLf0lIvGD3+HLoNhPahoBGPidiF00OdJhfGm6/nPXk/3UnR3YEk/99QQAcYizw
         5TtcU8pWqTQGp/CVjBXHKHVcRjoYAS9paQ5ivjnZUoI28SBv+ywyBo19Uio53Bo7MAga
         +gFfJ8/i2Na03HiqE2MZp98y7hs04CFuO3qPtxLCcUAwM1soXPyo4bU7VduDqTyB/2R5
         6WUU5dNOY+uKO5BxU5XtLHAyED01h2pJLgK9xGlD+jlSHuDsIzdWBr9Skp7w3PUZ2Wzo
         osjeKNcFfg0kCjieBc0KyeEHH+yREn3ct9ZFXeKwij9k5RcZlnCnYxCRP4GKzHzWoG5t
         EDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771840337; x=1772445137;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uoHMTBb8IpVzr1yOCWWsa13mcN23kWHrFMIDsOYWxZQ=;
        b=uZL7UpPPPSsfZzdjvrHcxomcIHxXXHZCEQi/Whhmwc0u4EvI6oGxbH3+/UO0ggqZpa
         TQT5NTL1vx0bd7iHRAWYT9LCbocesHcqXvBB4hEhtWpLgZXasQijJCS2Y5TSZjCKPthZ
         qNKhS5eS7kjqSFMC4hstyTjN1Ev0REKRj3ZTk3khRJYOB5kr0PSk0xNjb5X+ifgq/4oi
         F33WshibHI2tLvO8a6oObJbofYqC0qSVdbG1NWexZH86xnOQz8FcQX8bNLPxjnJyav3t
         5TDWne69O/vSMKqyeSGzU8gFqCdV7zpTMYmSsdthY8SY9Q6AtB2b9I2Q/GMAfEV5GoNB
         bVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWci0SzWzJ9WLxIhVCvjCsH7xVbzg5JLThOPNZWpY20uvS32+iKOzW9rSMfgG9ZyScCJtzjOKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk/3n12tQYV0kG2Yk+vAIFMbVP46NbQ751d29O45wwkvipDZQB
	OH4Q7bKWOpJaN9kdbkARxL+fVoT5BmJ9UhAhVhqb+pGvUWvgCuTaNb4elYT4G7CwMeHRA8cKNQg
	bm06ebrPsCD5zETFwqdwhhxFP0R53ZsoCrpWjzMzyLHvu/8YV0udcFvJlfkc=
X-Gm-Gg: AZuq6aJah+vkkFGQ7Io76SAKiaunajGujqKrOxhJzMKBbSy8ODSKUbOQCizDDcDw5pi
	SGZqq3FjzBzbqsyjYWw6JVH2rwRXiouYRXOcTxEnT9XZ5bLfCwku9Gkr6jHzBxVUCAT6jyQR0PX
	LxvtkiqDmifCndaiK1TASN1yTG+nWRyJVjaLxDQ3M75oMqHQB7OxxOYtJgJZaPf0wZWd+QDvjUQ
	dPTEP9ew7uE4pRD5+YvuuC7UpzUtlacCy1Tushb1NtKTfRjOvEHz/QcUAc/8olrw0A1lmJ+fIM4
	XF80+jUwk96TeqRlpycegQAYopLBUujluWwBpaA7FOezcCajN6FYOUceg/06OCvG3gQGBkkqRZv
	9N93T/DYFguZjV6CpJOveEAdKx1Ai8EPpSHA=
X-Received: by 2002:a05:6a21:2d42:b0:38d:b865:3a2e with SMTP id adf61e73a8af0-39545ec839bmr6508776637.25.1771840337210;
        Mon, 23 Feb 2026 01:52:17 -0800 (PST)
X-Received: by 2002:a05:6a21:2d42:b0:38d:b865:3a2e with SMTP id adf61e73a8af0-39545ec839bmr6508755637.25.1771840336687;
        Mon, 23 Feb 2026 01:52:16 -0800 (PST)
Received: from oss.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71a735csm6444453a12.12.2026.02.23.01.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 01:52:16 -0800 (PST)
Date: Mon, 23 Feb 2026 15:22:09 +0530
From: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH RFC net-next+ 2/9] net: stmmac: qcom-ethqos: move
 ethqos_set_serdes_speed()
Message-ID: <aZwjSe5zF1+fKoGa@oss.qualcomm.com>
References: <aZcGxDBwfMXHbo_O@shell.armlinux.org.uk>
 <E1vt3UI-0000000A5e2-0Im5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1vt3UI-0000000A5e2-0Im5@rmk-PC.armlinux.org.uk>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDA4NCBTYWx0ZWRfX7dyEo41Lq+zE
 vtVAbGrSJCYYlPNB7L/ChlcQ1g7FbqwDGuVbwwLfub35dI+6PeaKG7YZ80eczietr/d0zhycR+H
 sLREfH0TchvyrGfbJ6DC4VPmzbg5MyYLDypLcf0lEh5LBMuGYie9Fh3LU4N29buRCo4tGMEtKYc
 2KmGrX4qeoQPk5SxxMpSQ6AmqIZ2lkDZAmD54jwpsnGff3kvnTQhTDljt0CHzSIirAG4SicEhls
 kVQnume9JyYUTyV8CeC7BbJA+ntVHWBpS7aXA1XQUxM7+SkeifbEdKBZiAhOzbXfiLE4X3kkOqM
 qtvdjGDJ5TCGBZchn1AzC65goxHOmrDonAy8F3d81AEdHsSnEfEighHKg0kqCRfwlzn4XuPleAQ
 QALLJXFQp684BEWibyqGMhYElaVlITOD+xk3ToLAIsmfHO+jRqepgTW61H/xRnOh1QdcMv2Ppt9
 L1tMENTK+QUpB2PC4Rg==
X-Authority-Analysis: v=2.4 cv=W+A1lBWk c=1 sm=1 tr=0 ts=699c2352 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=PHq6YzTAAAAA:8 a=EUspDBNiAAAA:8 a=4YUTyhlxiuLjCXpWR_UA:9 a=CjuIK1q_8ugA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=ZKzU8r6zoKMcqsNulkmm:22
X-Proofpoint-GUID: W4YNXKjrWtlp4EQpPqcM9te7aKOa_wLz
X-Proofpoint-ORIG-GUID: W4YNXKjrWtlp4EQpPqcM9te7aKOa_wLz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_02,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230084
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
	TAGGED_FROM(0.00)[bounces-259972-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[armlinux.org.uk:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mohd.anwar@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 615EA174443
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 12:50:34PM +0000, Russell King (Oracle) wrote:
> Combine ethqos_set_serdes_speed() with ethqos_mac_finish_serdes() to
> simplify the code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 22 +++++++++----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>

	Ayaan

