Return-Path: <netdev+bounces-302625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ey7/KVJtQmq16wkAu9opvQ
	(envelope-from <netdev+bounces-302625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:04:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 037286DAB75
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 15:04:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NMdpH6YD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=ZWBBhSBp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302625-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F34D03075CB3
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FBF403AED;
	Mon, 29 Jun 2026 12:43:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539F403151
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737021; cv=none; b=aNMAEJBIyUGHIgko10ea/7ayLwD8ODVrmSnDv/nJmPrQIoa4c/aKOcpW6ie9e5z3VeFLPTHx1/wOKMxxZZqa6nWE2snmX7SQWvPW+xE1YtCZAFqsq+zlteBqlsnw/CtQta+l3vsPZyDUOcK4XmNGxIILI/d5vDaeif/JGprn64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737021; c=relaxed/simple;
	bh=iL8eQCnQSbG2ojygIK5P3cXtGszj1MWC/yVH3lFhswM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lE5/PGMpKRILQSXfvifN7kNis339EV9GY+NBqBMbLj+Lki0z13l4bwkRzrr9hEFOazIsHb1Jy8ZXM2xz9iC8+3Ud/YXs9Z8KfOLLjL/NvaZPMIYPzxKSPRbNFqDlpYZzG2k2oD1JlFBLaYEqkMCMkV/iY/AxjA8DotG/AEx1SP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMdpH6YD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZWBBhSBp; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATKTf2579262
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=; b=NMdpH6YDeqCM6Ng2
	6l+u1JT4xPqzvjoTIliP40I8uS1vyj+L87A0s/qye2JFugwtFubIXUyRV7TGDunu
	R6AT7ytIJgsoT9qLUDl4wVFliJkW4IuqsH8CbCK3KeaS2RCkVYPYUJb3E2XmVf/n
	n3hDCcBxNJlzKeVUAMJaWhtjvocMm4xmBllzsNmFZBHpLfh9MoNKpAQANg8pAcNm
	TXF0zOy0GX+9LwYTaSDruBciQSlEcjcnL39ePRYOwyzIFsHATrj9EfyXaS+7TQfj
	LXtLZZhSE0HawuL0/q6HT7LO9lTXKMaK7kYXAJnJbjWc2xRjybwKZ0RF9NkF8Rk6
	8fCEwA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hc7h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 12:43:39 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-37e4045395cso3804899a91.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782737019; x=1783341819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
        b=ZWBBhSBpkN7U1a4i9A+0lyZi37P59NHUTaHRxPctYZd7M5PKOhhxHhsrbRHlyXSPaA
         7g2pTDiUT2cMwStL6aFYlTt9xcXUfjFg6PZm5M5A08PV+ZQczYWLkl3msHBYC6pcA+I/
         xeBlQHDX37KX/jltvdN/s6XCJWMH7mio4NbpE4Oszi90X2bmxyZ4jvTriu9et3RJXb4b
         dq/GtcOY/W4kwIz9Oee0eg1jZfqMkEWl+CoyAUIeO54TRy4aReXE6b9EAdkZXkK0FsQZ
         oVdtRw+Kfe0GzbER2JtWZG0NcZBAHeFE4T36yW1KOWu+n1fZmsWkmVbdQ0gNI3z7MrEv
         /aeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782737019; x=1783341819;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpHcwEms8mZxbI2w+Md5BrpKxIEKLFyT45Gg2vM0YiY=;
        b=UucTd/ATtay51GjbQf2fpKbL0kR69E1eOKGgIsIxOV6UMtrNcRtNRnFs38iJBMuxc/
         apYxAi0rOJsGpuXuvI4Met98ngGX4NZeQYhgpog1IZpZEhizhbo7uS5KlBOkBhSEymyL
         o8djyDOvZGg3FWQh0yNaBnq8wMr3dcwa2e8NGi6trnrhA9y/uHS6l8mvE1XDpfhcPpYH
         rMpUKdhhvixAgyftnRY2ySlHRWXGQq+KiolFF3lVMEVxU+ZpDODDeviQJhMz5a8RkZqM
         aj64pEh9TN5KTuzUPwVnjnCOh7YSQTXcBTI+luPjNqooSyqg34e/SCU+jfI0xNBOyN91
         n9Bg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0iJc0ZPSgYQDYIPsla/IA1gstn31Xv6g5KDAydG8As97iyhz6hgf9YKLRya0LONomqsPzZ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTdqNYW7JKiPUG5zuZEUNLt4plJy8pu3pTPB+Lx+8Q8u6n9lED
	cQ6qYXMoH1IkCWr8f5BP1n438i6hM1p3XtbmH+/WlL1D6daXCDycX/kt2t94An+8vZb73fMpD42
	+5FlRdxHMcIBNr40Ir5YRpGL2cW5zfxJFzrBM0nRND/jSUao8raDieMm0mtw=
X-Gm-Gg: AfdE7clPTAKSntxOW8jduCfDVVjcocSmNmRs0i9manuwQxsHOd+XLT1kf6b2QXeQVDA
	RGfKPuglV+cVq0jAMAFQG88NzR6gsi9gVxDJtd0t/Vf/ENLExGXGyQJErYHW7t66PwlDojDNMQm
	6ceFAu2n/N3ZI01e9Jszf3nKIjs2uTJh9EWi1++uHaD1+paEtAKpn6f5WWvd47hI+regbYrnyg/
	k+2GaIVsOKrqQQUOBFUUyjULpPOFsgm2oHn1XDtYbOOdbS0r0ScUGj61HCIjhXaqOuDnHHqAmH/
	IEEUqVb+XeJO+lnmeHgwuofKKRtePk9pW3jAzma5zSfgLMYJLR40+dFrMshqGNySPetmVtDiriI
	YLq6/iXZFVmtpYvgzYqpkZEQ5k+GL8DfIBAn4O4yjghkpXIiU94/Y/acwxuQlQ08ZV9DpHcgxdG
	c1Pr3wUw==
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id 98e67ed59e1d1-37f9ce2229dmr7491042a91.30.1782737019087;
        Mon, 29 Jun 2026 05:43:39 -0700 (PDT)
X-Received: by 2002:a17:90b:4ecd:b0:37f:9ce1:cdb0 with SMTP id 98e67ed59e1d1-37f9ce2229dmr7491002a91.30.1782737018606;
        Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Received: from [10.133.33.246] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37eaff87f61sm5602580a91.17.2026.06.29.05.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 05:43:38 -0700 (PDT)
Message-ID: <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 20:43:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
To: Guru Das Srinagesh <linux@gurudas.dev>, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>,
        Abdiel Janulgue <abdiel.janulgue@gmail.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andreas Hindborg
 <a.hindborg@kernel.org>,
        Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
        Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
        Alexandre Courbot
 <acourbot@nvidia.com>,
        =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
        Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
        Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King
 <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@gmail.com>,
        Simona Vetter <simona@ffwll.ch>, driver-core@lists.linux.dev,
        linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, nova-gpu@lists.linux.dev,
        dri-devel@lists.freedesktop.org, zhongqiu.han@oss.qualcomm.com
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfX0bcemhWbehOS
 Llhnt7WPctspYSIVfeXcMaJHmFNaXyR9yxUyN/nHmUBfhm73/eWAZECwaYQtRaKgDNNtq75k+EH
 HmHoiE20CUeHGqJRqKzWwf7+bdTCaXY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwNSBTYWx0ZWRfX6VyvQ8EF8atR
 2oVD/GgSAmX6ZYFHBvsUwdbz6owFbsiu5uRLHblfZ3Rfr8QBSby5UWA8z3XzSetBc73Cx0+BL8L
 hbRpH7EVtDQwmdWb7DrD+B7HdRe9f3u52MVy55NoaP3t1IEl7sdiUGD9IHmQDP4YYGiy6IAQng0
 r2allMcwScj+AGS9g52SCzIHMcEikwXxHjeYZy9Ny4qMLsVIyLeU86oINEmsfu5G0oQKD+llER+
 B4TbRKg6C13wcTYlEO6MIrCbX4LEPJX+8x9w/tjMjv7cUM6DLLaqvasAJtjieW1+to9nH5Iv9Zy
 viy6PQSjuiNZ+ao08GWBKk9mjfhFeURldq++4l0ZkmczezUEYJJ38+DhkFR8syfdZKtItcfWn7a
 9ni78ZqQpssCfYsvheq1HwmpG5jAxIeuFw75RhmpLuyxSeCTcFcqWndvKYoaH0BNF2pCtIi34+i
 ETLC6B/uSx7QnkeHksQ==
X-Proofpoint-ORIG-GUID: F4dHcWqkScch8Kj_IC91Me9_ompk7FXi
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a42687b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=ecjbvcZnrCEMvoAzKiMA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: F4dHcWqkScch8Kj_IC91Me9_ompk7FXi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1011 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290105
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[45];
	TAGGED_FROM(0.00)[bounces-302625-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux@gurudas.dev,m:ojeda@kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dakr@kernel.org,m:abdiel.janulgue@gmail.com,m:daniel.almeida@collabora.com,m:robin.murphy@arm.com,m:a.hindborg@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:fustini@kernel.org,m:guoren@kernel.org,m:wefu@redhat.com,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:rafael@kernel.org,m:viresh.kumar@linaro.org,m:axboe@kernel.dk,m:fujita.tomonori@gmail.com,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:driver-core@lists.linux.dev,m:linux-riscv@lists.infradead.org,m:linux-pwm@vger.kernel.org,m:linux-pm@vger.kernel.org,m:linux-block@vger.kernel.org,m:netdev@vger.kernel.o
 rg,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:zhongqiu.han@oss.qualcomm.com,m:abdieljanulgue@gmail.com,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhongqiu.han@oss.qualcomm.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,collabora.com,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,nvidia.com,onurozkan.dev,redhat.com,samsung.com,linaro.org,kernel.dk,lunn.ch,armlinux.org.uk,davemloft.net,ffwll.ch,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.freedesktop.org,oss.qualcomm.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,gurudas.dev:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongqiu.han@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 037286DAB75

On 6/29/2026 11:38 AM, Guru Das Srinagesh wrote:
> Convert `use` imports to vertical layout for better readability and
> maintainability.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
>   drivers/cpufreq/rcpufreq_dt.rs | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 

Hi Guru Das,

> diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
> index 10106fa13095..6f83cf8955a6 100644
> --- a/drivers/cpufreq/rcpufreq_dt.rs
> +++ b/drivers/cpufreq/rcpufreq_dt.rs
> @@ -6,7 +6,10 @@
>       clk::Clk,
>       cpu, cpufreq,

The change seems reasonable according to the Rust coding guidelines:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/tree/Documentation/rust/coding-guidelines.rst#n44

     "each item goes into its own line, and braces are used as soon as
      there is more than one item in a list."

If the preferred style is to place each imported item on its own line,
shouldn't imports such as

     cpu, cpufreq,

be formatted similarly as well? Have you run: "make LLVM=1 rustfmtcheck" 
on this change?

>       cpumask::CpumaskVar,
> -    device::{Core, Device},
> +    device::{
> +        Core,
> +        Device, //
> +    },
>       error::code::*,
>       macros::vtable,
>       module_platform_driver, of, opp, platform,

Likewise?

> 


-- 
Thx and BRs,
Zhongqiu Han

