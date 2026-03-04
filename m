Return-Path: <netdev+bounces-263679-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCaEB6n2p2mtmwAAu9opvQ
	(envelope-from <netdev+bounces-263679-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:08:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AFC1FD3FB
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01FC630E8A17
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 09:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE2C3976BC;
	Wed,  4 Mar 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D1m8qnvk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RM0EI69t"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FC33988E0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 09:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772615015; cv=none; b=RQnzZmLkfhgZQRGRdyJCbjoXyDgjbuftkyJOOrt+qxfu1L1AIAn2fjnEnxVWOEW1D+YUeg6XT5rmF8SWqEp2ARL1k4SHVW2uWY5Wb8Mdu3/OoPRF1MbCz/axxST2MztBUvsyLOc6laYti9FUpuf1hEXrGtAB6dKwsA1SNCpG/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772615015; c=relaxed/simple;
	bh=ThHFh3NlTGr3cmL2+FqY9w+FucoHGvdn5gmiPzKUOnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uh6gags9Z55N1Cneejq7S54dYu/MLhGliU1BDXWKqKUPmwPaQVdlV99WzqH2uf0va2s2HUEf8AHqxSQcprtaaOMsPs3Tp+uTBFaA4mA6NUcHmtcD06b/MGhahBqby6cKlhnFnRDTktCmRMEKOwxN49NwdBU0mj7oSfWsjYeOoQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D1m8qnvk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RM0EI69t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SfAp1072656
	for <netdev@vger.kernel.org>; Wed, 4 Mar 2026 09:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=; b=D1m8qnvk3E5LhfpN
	3QUokB1mBSULrq/CdIG1gvd6CO8eOlzfQSz6frcriPGOVobjPUD7eQqddi0kPWW7
	LbjMvyAguQ0HaBgVtyx93QHvRTCo2bPd84Y4+GvyvQVfYCJse9JhM47kgvuIjenM
	FRAskzPXpM5Dt3drsssUvDqk8KcXz32SAU6JRDHeTbjWrsEhzH1n7L2X9AM29pgR
	1LjrxlnR88mTD7Re2O2hVilruhiy4vGOGYZlcR7J7r78Ipw8TRrAZAlx5CsWP49Z
	8YRrd7Z+1qSFEpv6ae2lephx4GZIpjJNQnokM35jHDfMSE+AT04D4THaXNEr/JkR
	bTADHQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cpcxfh0mr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 09:03:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb4a241582so3790891985a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772615012; x=1773219812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=;
        b=RM0EI69tKWZZ0NXyeV3zJckgL06pwqG06GAB/3LQ7lxiSCzIHyuEzFfSX7rkaXzhNj
         aU2ojL+vddORnqRH3eu+vnKIpvsGTzSnUvW3rr39DxkJ3Nz7la7oyVdjBf0Eizr/7w6T
         mKigyo+MOYWfFf+JLLbuWSuAK222Qo/yBIcJtt2617wBrXPbk3yyor6J1/kO0aDv1ZRq
         Va5igWc/MmgTEUjoY4L9S++oUqJG3yzOUOOzxu4yEMLb9tkIU/RwqsBeNVw16jho5vej
         jx2YGw2FzW9cWk3IuAAxwcV05I0srdAfCV4UvhAzB9tveWTaJMA3N9KEV32KLfI/o+PN
         YakQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772615012; x=1773219812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V4DdJrigh17FkqHoOs5hVpX7lVxAfGwxLPSOp0C/QmQ=;
        b=WwPn6/324DLP87FeZOaYXqKSp8PL1nnRexEUk528tqn6bMm04pQFHX57aAQi1J1omb
         HTcfJNgTWRb1TMtf4Dxmsia34oRNP0ywLhMpTqG1eowoHXicIpSGppAmxpk75nHECKfw
         dGnQ6421dT5ZX9JDgaO4esGn1t6IP5Ub6hnmQIz2fURA7qM2RTKBW8+amKDwTWpaGbVI
         LkE7204Eua3l5ND8ORdXQ3CWKGdmgQbrqgw8VJy+1kn4s2+Se5Nhdqkcg6r52/59vuom
         tdu20d3Yvuacetm2CM9dxziKPg3fEM4zM6BJSuKdxMwduFZ0OzA9yrmrgFNFhtb261eP
         wiRA==
X-Forwarded-Encrypted: i=1; AJvYcCXaRxN7TkZINoCLpL0RV5qNybxgUyHFU4ZY/riqVnoBxbeZpZz4ROMcE8mzWnu10Xkzlq/0t3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPyqhGpTBozg5jBOcTsrdn/5zBK0WJRBbOoi5yRr0CzJED449w
	tHzF00ROal/G2K6kJwsscdFYZRnecFn9KBkzk1Pv/j8/5O9mwi+p7/mQSV++niAwqOYKIYDYD00
	CE5bhVaKGykk3xPJQ0UY8niPbYXBjt3n9gpVbk482n3ZNFbxUwyaNuMQc/ek=
X-Gm-Gg: ATEYQzxp1CuNl9TaVeRmd/CBVVnDuYsWS8Sn8wlmP/Vx8YW8+28uSQHUsOJGOWDh3Jp
	GO2ilZnqDGt5NnYRTZBkjH/I085oCB75e+IjbrrYDkigmkg7MybkzC6bATsjNm1gw/31eBL/p0s
	XIxRKb6WvbEZxWQO8syIt4pmjvMGv+DQjG5hMdbB7/UdhIcSB3F8Z8xwhrMLORZLGkHP8LORF4q
	O9sGa3t9WZPAI40Le4c8eyOZe4eP/V9zyHxzpezOva1yZLR+yqvz52Q9rZ6Xz3BP59SipKTtxew
	Zrt++w0KN2UTic0mnmmLn1NLTM6iJa156EuMQRBehn3iimr6wjmEeB0NaoYIDSmIajbbYA6pNgA
	QZu5bXmmQXeoKjgEZkNI4hfKNaUVTU9454JKd9Mp0ML4Vz1904/Hz
X-Received: by 2002:a05:620a:d8a:b0:8cb:5393:20f8 with SMTP id af79cd13be357-8cd5aebfe1amr147314785a.2.1772615012024;
        Wed, 04 Mar 2026 01:03:32 -0800 (PST)
X-Received: by 2002:a05:620a:d8a:b0:8cb:5393:20f8 with SMTP id af79cd13be357-8cd5aebfe1amr147309985a.2.1772615011499;
        Wed, 04 Mar 2026 01:03:31 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:edb0:af14:f4c7:c6ac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851ad02ffcsm3644895e9.20.2026.03.04.01.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:03:30 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 04 Mar 2026 10:02:31 +0100
Subject: [PATCH 10/14] watchdog: convert the Kconfig dependency on OF_GPIO
 to OF
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-gpio-of-kconfig-v1-10-d597916e79e7@oss.qualcomm.com>
References: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
In-Reply-To: <20260304-gpio-of-kconfig-v1-0-d597916e79e7@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>, Scott Wood <oss@buserror.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>, Wells Lu <wellslutw@gmail.com>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        netdev@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pm@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=ThHFh3NlTGr3cmL2+FqY9w+FucoHGvdn5gmiPzKUOnw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpp/UzSi5Qn3DgaD6FivvuKNsOUmi1EyHHFH7/+
 rwJ4ztzm+mJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaf1MwAKCRAFnS7L/zaE
 w2w4D/wLgntjU8j/CxmGWummrsoPSeGrn5cCG8PaCqyxiIKXvDtsH4EKd9slSZb07jfj5yDj1Uv
 Hd8iwoA0IAl6pyIMV8F6C/Le2nEX7Ag7qKCpG7EJ1SGQNamiw0jejArYX8VqkDPB4WQ41l93U7R
 /iOjI+luNjSk9ILZc2s4d1gffEwK0h4ReEorHioIZZJo1QR7SYlvfnspGsytExzS9DaE6BkalDm
 MZLZeaXNysxrzwAkbWhP6fqxo7ce8EhXQzu5U6cyfnjIoKwj4BhY9wQT1vlqcKYu7qwSVCLLwRv
 34dGqURaxeXWUTxumDYguIk0OCt95kbMkJZ7I4gEtIOnoIYXmoE0cXQi7q5eKTHEx1Pdv68JpLm
 xUME2wVPPXUFvYpnkGg9WctfBpmtH0SG0C2Cm9kjCIo++i/NcoGl6yF6nhXUikBqO/r6xnXxM1L
 4i/5PHvnF7c3MgEvaXLjzXmtMjDihQxuFpBA/rXFEgK+cDMLSostTYnJgZaWZWTIqz48EyeBDaE
 3oyY2BMrSsjPTPJvgwUHeksiIYVrTNq30Dy6zjt6d1hl4fWedFAUf3WqvY8s/nfm8xIYBlTZ6i0
 2iigsSnPenUOrcRGMY5Y9N9i6rZROJNbSrXdfQFtt3gUGgfoSeHrntObLfNOa/4G+sndGUQspVe
 1RAylqZe+NoE1Lg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: pFRPCoW3pso8MLwGA0dkMSG_UQlsZ1NW
X-Authority-Analysis: v=2.4 cv=R4gO2NRX c=1 sm=1 tr=0 ts=69a7f565 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=QGo3Xwuj-Fjf7Q_gFxoA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA2NyBTYWx0ZWRfX8zAEKJ62GvR3
 FpeRgtz15dfJN8c7idaLR6HSBz11qamtyLY5XqIbXol2HjpiY7g9OP2HITvxFju3zANwqbpv/kv
 3FPkPhsS9zKqJieGnWv2TrPbqU3LRH6ht12XmLf/8SMihh+4nP/+Vmt4lEi7QDW5cW/q1CLLLAH
 BlmWUHhz0jjCwqvnkbL335xI283hh26rava9q0Z+Hqx2mwSgVZzNePtqBSWlxS2LQY7qQIiuYJf
 h2spG1avEI8x6ZVrtwk2V8yVn7QJNXIj0ZjR2bwd5r5AQziHePkL1DIQuR4X5ZWlSu+mvewVTFF
 M57G3SBVnEenSf9NWPi2YFYqJpG9kqmx3YTT5Zku5uwkqikrYWKeqeQA5bNBgDT4StavQFwjxfH
 cxccuv/WxUMi2nJkfA+LkpkIbTutbX2Epd+2+HetEKLKn/3Tsoo4J5T/DPqKmJqLwYcZtVHhZHA
 XoNonmaeP3lPQNmh2lA==
X-Proofpoint-GUID: pFRPCoW3pso8MLwGA0dkMSG_UQlsZ1NW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_04,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040067
X-Rspamd-Queue-Id: 85AFC1FD3FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263679-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[arm.com,kernel.org,synopsys.com,buserror.net,linux.ibm.com,ellerman.id.au,gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,redhat.com,linaro.org,baylibre.com,googlemail.com,tibbo.com,roeck-us.net,linux-watchdog.org,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly. We could simply remove the dependency but in order to avoid
a new symbol popping up for everyone in make config - just convert it to
requiring CONFIG_OF.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index dc78729ba2a5d6e035ed3cbe5c2b631d11b76b20..ef200339a22a6f9c51a46c9c0b8466add74313e2 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -250,7 +250,7 @@ config DA9062_WATCHDOG
 
 config GPIO_WATCHDOG
 	tristate "Watchdog device controlled through GPIO-line"
-	depends on OF_GPIO
+	depends on OF
 	select WATCHDOG_CORE
 	help
 	  If you say yes here you get support for watchdog device

-- 
2.47.3


