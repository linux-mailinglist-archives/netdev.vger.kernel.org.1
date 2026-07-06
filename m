Return-Path: <netdev+bounces-304966-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id un8HIs+MS2pxVQEAu9opvQ
	(envelope-from <netdev+bounces-304966-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:09:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C718C70FA99
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:09:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=UE2stpZi;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=NWWwFlOI;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304966-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304966-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B6C9833A423F
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87C0399011;
	Mon,  6 Jul 2026 10:18:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC4B379EFE
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:18:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333103; cv=none; b=mD96HuBAuHKCi8+qmNv7XHyRafZZKvrYlMfxDCul9RFbuUKL7RHSaW48821UIcxWsgnTDHsNQL8fPURGwi1EWNCvyN1CEro4PK5mjjnROf4JQmOAxtZbqE5MB4SkJ+nl48FQRej7+LO/hnB9FozV/Zzm+bJc5TsS/Sx5pFPQcoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333103; c=relaxed/simple;
	bh=obkWoj8K353j+24JUq8OuRxXxWy1LaVi6SoHC+ucQIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S3sul/rKkuazjS9Z8a+DbHm7QfacUDe8QgHsPRQLT8cSIwxyOJz9T8qe5beAjGXm33XKFUNm5F1bKdJidguta3YZKKnHDGhgHlDBw0BGkKmO8Sp2aHGNvZaXuW82jLEzeiQWV7efktYBgLewrjjNOGcZ9yqNqR/Ns3naP9MKiEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UE2stpZi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NWWwFlOI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669pDhO250640
	for <netdev@vger.kernel.org>; Mon, 6 Jul 2026 10:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=Jq5aig4q/CfeLfzgOURl0BGdrV2VPhrf3Nk
	WbsmyyXE=; b=UE2stpZiR4XE95Swkaac9AoUqRRNblQs1WIF9z0gNgeH8/jX7y/
	mNF2TAqzFCHXhQRTQ6heSTGeNJdhB9pUYIQ/FPAat3NfRTKrJW1VxBXP1AWlcW5d
	zwN1nrdc70kkE5f1lyG1uwhuWVzVLtNXZaR6Sev0JFcJQ8+mRbywTo69ZuIVP+s0
	4UoxmVNmDFgvvTyPYs3AU2AyOi8NEZKA4iFwQmS9/YJrrn3FDpYFmqdbTedqwa2F
	I5EPi0CFJ6cLtJ8VUFOqPdmo3MXK+LVcSwuOuQuCEF+Q8prnU9rWXTGYBnWLD3tE
	B4rMw8ShGdFv8ihpuO36wZmlcD9D2Iof4Mw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gr3f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:18:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e52306621so201420785a.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783333100; x=1783937900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jq5aig4q/CfeLfzgOURl0BGdrV2VPhrf3NkWbsmyyXE=;
        b=NWWwFlOIAjbx/iENp2wGXa/JBGLNEpFMh04LUpycuqlp/36Ztaa9toQB17qzaUSvN3
         JRNwy/UcYn8cVKIwvVyuTiC4tMW6/9C+vtbG8vvTJaN/GnWVImCJlPalBqIgk8pdNwPU
         XYfTRhvLTiFKXPisGBQzbNUevWBGlrpRZOowvtaBz+RsKVZJitfBFTNb+dBoliwg9gQs
         u2PycyS32Zx/rr1NkNv0wqAjOAhc0i3XfZ2Id+v94Q6FkpcHa7PQpXVDqzeQDXAi4DOB
         votO3XIvhqlnJonEBKCmDrqyIY9GHSoO9WRhRVJ0ad19BSHVR6jvXDrm54mcZYQgYX9A
         0a4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783333100; x=1783937900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq5aig4q/CfeLfzgOURl0BGdrV2VPhrf3NkWbsmyyXE=;
        b=a8EV0i1OZMJt08W3ZeaDzprMAxK4zQrFHikbelzE42Cf8u/axIxGpTRiyFZTL4SkDZ
         kAnAzKtEZa8bWfSnoLXdF/K+xOgiGrQKS4gHYxz3FsNX0TsOiehdwKg6fo7mC/CuOL0q
         u6j8qbYJuJB8ngMZEcTyeHiZ7o+jHpJ+PH+G0v5F1Sx401ghwz/gA8jl3eD02ba+Q9B3
         5mTS9EGKiLNFUpl4xpbCBNi0lsXbg1faChemWMgPQf8TCeyImkmlR/T5DDkmDMYQhtVm
         0IZQebEkNVT8MyUi49WZAkQbPufW1WcWyadA7JssPW56KXRPVVQsQCwYr65cB8qeuq0q
         wnMQ==
X-Forwarded-Encrypted: i=1; AHgh+RqXWWwYziIBjIYvgKtsE7WsatXBIR03NwiD8ApNkK5R8QOqmyZ7fE20ZTxMOD4HQkubntOGrjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYGJlTUeNLv97a8667xuRh3dG91DZTlBQRmSAAhZQX/urqiSGd
	q9ddaI+FIATaz148eqXS9gm6GeBuAV6lUrDuaCshoGcNwOMUSyvZNjIgby/BsHDgni40ZuvrV4U
	sypY5PLHWyiMy+P/IcKFprWCg+5tiLBBjxRMsMxjbX+nxBnE8t3eydW2UAKs=
X-Gm-Gg: AfdE7ckwn6frB0fcbl3NNa5sQxxAPU866QhFusuoDAt60mKJC/tOE6vSei+e54qz81c
	PXmQecMjqbzaouvz+t0n17D8iZBljgqfA11MSaNlQJ8sS9bN1hXeorTLJeQs69kn+ZqUr48a4vm
	Z2sfv3lKVFXkRVI6aQ2UC2ttABmHP9tIPhrl6J//5HNcQDOPI68BcfeoT9tGtCI9PxAMa6TjCJ8
	9FcjeUyr3No4JZMWQO2Cn7MH2ltNWSIUKMwlcd7tVWB2LGKDdZK61yR65sqZBBw1/mdhPzelD+K
	wYrv7DYU5RYyiVqFXNTG6pIr24N7F91viuScJeI0EpxDJKKIUKTEQgUAAzfl1HYMjlkie1oVjxF
	JWcIE7sR4PUudsoV1aPH9jY4mZ+M=
X-Received: by 2002:a05:620a:46a9:b0:92e:46e5:8f12 with SMTP id af79cd13be357-92e9a3ff388mr1279024485a.30.1783333099908;
        Mon, 06 Jul 2026 03:18:19 -0700 (PDT)
X-Received: by 2002:a05:620a:46a9:b0:92e:46e5:8f12 with SMTP id af79cd13be357-92e9a3ff388mr1279021185a.30.1783333099347;
        Mon, 06 Jul 2026 03:18:19 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c637bbcfsm337511305e9.6.2026.07.06.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 03:18:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
        Andreas Kemnade <andreas@kemnade.info>,
        Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] ARM: dts: ti: omap: Correct indentation
Date: Mon,  6 Jul 2026 12:18:16 +0200
Message-ID: <20260706101815.341184-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12355; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=obkWoj8K353j+24JUq8OuRxXxWy1LaVi6SoHC+ucQIs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqS4Dn6Wcx//U+a1el+qX6188RZvOU4Wvr2ey0k
 4Lmb14kBnCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakuA5wAKCRDBN2bmhouD
 1ySqD/wI19sQdjYJ8oESm9pcn5Guz5nDINCKXWmhsXbc8D4itiV8MXfAoiJyMoTdel7J4AholNM
 T7GfocKSdeKJ/7G98zXC30loNMhW9mW7T6OnN4EcSl5PT4VNETSFUVihTAbCzHJm1ryIqUjo/aT
 klWm8WKjoGY6PGxCjWu+yW1puebSdum6poO1+PYTO5NLr3Uz0A4XJ1atKHdNmsiNaOoggH85NQp
 gRgEwqDMhEY++NpL2kA9RFo9Y88WoQg/CX0Md49V9KL7it0cUIamTWRtkKDFJ9HTZeFTytukLJe
 70QYw7U3bibLBzsm8FLKSGPL9za2N9Bgp9xN/tMKoPNJxJ8WbrhBfRxXJK1pCqeSJgSxBiGF1zk
 qexp7j9tmHKEX2ldNqJmVQUdGccWYFU9jfIDSVpOMDpYXIVKuvI+wu+FFV5mubdGf2tQco0I/HE
 xmqVi+ZbGpY3GEp4J+BxAfV+5mHUrWNQVRmH+akd91GmTAjILyeagZHbiWloLylhkb81wgrQLij
 CWuke1fIZivWJ1XpkucZxAIlJLq6UsxNOFpf+Qoj3fXL6f+py2NpztfLUyUavflyFRtt3TaJ35H
 0nGJqz2V5aGRqymalk7TuqifGVSwiaisxAME/AZUfQdMh8oDawsRoBgylaaV8Bwuyt4ktd7JEaZ KAdttdx7e3R5AmA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 3SoCK9oFCE7vHx_scYk0f7a1UPTRD22R
X-Proofpoint-ORIG-GUID: 3SoCK9oFCE7vHx_scYk0f7a1UPTRD22R
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4b80ed cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=67tiAkKgIB9i3FVbouEA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwNCBTYWx0ZWRfX4e9oBsynOWth
 9dGRaSzrmB2JBI4JqjYc8cOFDSeh2Qb/GF8DqHu57thl1StyOuebAU2dNuwndB22bzhxhYxeYeB
 AX2K2CLhkNlmrhnb2oPcOL7hnuV2fHi1PtrjgBxazYpnZei9EO9TcnydXqw51RDZagNp/K/9Mye
 IAigDFzSLbEUqs3MhWoFdQ+CA/Fth18lZ03b7eGnj/mKIOIZdOLguai+6SD0Tz9JAHIGdeenIsd
 MOQzahvom6OKo2dn0BWhuvcwanxUWLmI9Jv7922CNBbXbOECjq2GHnnhSkJRhgNpV2Nb7DaiOKL
 7POjvVQn++y6vETMpO/CfvvQw1ElqD2JDQFZW/HFFIU5Tu5XS7qWDj9YbmIEq4rYB6g3rtZ2lm/
 Wt4SbdZrFSYvp71bcvCWp1Wb7xoV8YfivhK+WA6PXHcdoHsFyVV5oFL/5PaJ3Ef1WRrCW2HUeMQ
 w7GaHBD02Dm7/DXxxhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwNCBTYWx0ZWRfXwk6PW/L297lv
 TUxvfhtEUJL6wxZvK20FpAL1bDkQ5Y9sGjjyCNUgwOC7PQ/4PauQro0xpSNtktxDd0c0dg1C973
 0PnscG4xBlzXBXWrUrCbvpDNuADTOc8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060104
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304966-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[iki.fi,kemnade.info,baylibre.com,kernel.org,atomide.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aaro.koskinen@iki.fi,m:andreas@kemnade.info,m:khilman@baylibre.com,m:rogerq@kernel.org,m:tony@atomide.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:richardcochran@gmail.com,m:linux-omap@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C718C70FA99

Correct spaces or mix of tabs+spaces into proper tab-indented lines.
No functional impact (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Ongoing bigger work for all bindings and DTS with built-in checker (dt-check-style).
---
 .../ti/omap/am335x-icev2-prueth-overlay.dtso  | 126 +++++++++---------
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi      |   2 +-
 arch/arm/boot/dts/ti/omap/dm8148-evm.dts      |   4 +-
 arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi  |   2 +-
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi        |   2 +-
 .../dts/ti/omap/motorola-mapphone-common.dtsi |  10 +-
 arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi |   2 +-
 arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi  |   2 +-
 .../dts/ti/omap/omap3-overo-common-lcd35.dtsi |   2 +-
 .../dts/ti/omap/omap3-overo-common-lcd43.dtsi |   2 +-
 10 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso b/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
index ffed1f3d046a..c0f32c889f69 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
+++ b/arch/arm/boot/dts/ti/omap/am335x-icev2-prueth-overlay.dtso
@@ -19,61 +19,61 @@
 #include <dt-bindings/clock/am3.h>
 
 &{/} {
-        /* Dual-MAC Ethernet application node on PRU-ICSS */
-        pruss_eth: pruss-eth {
-                compatible = "ti,am3359-prueth";
-                ti,prus = <&pru0>, <&pru1>;
-                sram = <&ocmcram>;
-                ti,mii-rt = <&pruss_mii_rt>;
-                ti,iep = <&pruss_iep>;
-                ti,ecap = <&pruss_ecap>;
-                interrupts = <20 2 2>, <21 3 3>;
-                interrupt-names = "rx_hp", "rx_lp";
-                interrupt-parent = <&pruss_intc>;
+	/* Dual-MAC Ethernet application node on PRU-ICSS */
+	pruss_eth: pruss-eth {
+		compatible = "ti,am3359-prueth";
+		ti,prus = <&pru0>, <&pru1>;
+		sram = <&ocmcram>;
+		ti,mii-rt = <&pruss_mii_rt>;
+		ti,iep = <&pruss_iep>;
+		ti,ecap = <&pruss_ecap>;
+		interrupts = <20 2 2>, <21 3 3>;
+		interrupt-names = "rx_hp", "rx_lp";
+		interrupt-parent = <&pruss_intc>;
 
-                pinctrl-0 = <&pruss_eth_default>;
-                pinctrl-names = "default";
+		pinctrl-0 = <&pruss_eth_default>;
+		pinctrl-names = "default";
 
-                ethernet-ports {
-                        #address-cells = <1>;
-                        #size-cells = <0>;
-                        pruss_emac0: ethernet-port@0 {
-                                reg = <0>;
-                                phy-handle = <&pruss_eth0_phy>;
-                                phy-mode = "mii";
-                                interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
-                                interrupt-names = "rx", "emac_ptp_tx",
-                                                  "hsr_ptp_tx";
-                                /* Filled in by bootloader */
-                                local-mac-address = [00 00 00 00 00 00];
-                        };
+		ethernet-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pruss_emac0: ethernet-port@0 {
+				reg = <0>;
+				phy-handle = <&pruss_eth0_phy>;
+				phy-mode = "mii";
+				interrupts = <20 2 2>, <26 6 6>, <23 6 6>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						  "hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
 
-                        pruss_emac1: ethernet-port@1 {
-                                reg = <1>;
-                                phy-handle = <&pruss_eth1_phy>;
-                                phy-mode = "mii";
-                                interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
-                                interrupt-names = "rx", "emac_ptp_tx",
-                                                  "hsr_ptp_tx";
-                                /* Filled in by bootloader */
-                                local-mac-address = [00 00 00 00 00 00];
-                        };
-                };
-        };
+			pruss_emac1: ethernet-port@1 {
+				reg = <1>;
+				phy-handle = <&pruss_eth1_phy>;
+				phy-mode = "mii";
+				interrupts = <21 3 3>, <27 9 7>, <24 9 7>;
+				interrupt-names = "rx", "emac_ptp_tx",
+						  "hsr_ptp_tx";
+				/* Filled in by bootloader */
+				local-mac-address = [00 00 00 00 00 00];
+			};
+		};
+	};
 };
 
 &am33xx_pinmux {
 	/* MDIO node for PRU-ICSS */
-        pruss_mdio_default: pruss-mdio-default-pins {
-                pinctrl-single,pins = <
+	pruss_mdio_default: pruss-mdio-default-pins {
+		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x88c, PIN_OUTPUT | MUX_MODE5) /* (V12) gpmc_clk.pr1_mdio_mdclk */
 			AM33XX_IOPAD(0x888, PIN_INPUT | MUX_MODE5) /* (T13) gpmc_csn3.pr1_mdio_data */
-                >;
-        };
+		>;
+	};
 
 	/* Pinmux configuration for PRU-ICSS */
-        pruss_eth_default: pruss-eth-default-pins {
-                pinctrl-single,pins = <
+	pruss_eth_default: pruss-eth-default-pins {
+		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x8a0, PIN_INPUT | MUX_MODE2) /* (R1) lcd_data0.pr1_mii_mt0_clk */
 			AM33XX_IOPAD(0x8b4, PIN_OUTPUT | MUX_MODE2) /* (T2) lcd_data5.pr1_mii0_txd0 */
 			AM33XX_IOPAD(0x8b0, PIN_OUTPUT | MUX_MODE2) /* (T1) lcd_data4.pr1_mii0_txd1 */
@@ -105,14 +105,14 @@ AM33XX_IOPAD(0x868, PIN_INPUT | MUX_MODE5) /* (T16) gpmc_a10.pr1_mii1_rxdv */
 			AM33XX_IOPAD(0x86c, PIN_INPUT | MUX_MODE5) /* (V17) gpmc_a11.pr1_mii1_rxer */
 			AM33XX_IOPAD(0x878, PIN_INPUT | MUX_MODE5) /* (U18) gpmc_be1n.pr1_mii1_rxlink */
 			AM33XX_IOPAD(0x8ec, PIN_INPUT | MUX_MODE2) /* (R6) lcd_ac_bias_en.pr1_mii1_crs */
-                >;
-        };
+		>;
+	};
 };
 
 &gpio3 {
-        mux-mii-hog {
+	mux-mii-hog {
 		status = "disabled";
-        };
+	};
 
 	mux-mii-hog-0 {
 		gpio-hog;
@@ -129,28 +129,28 @@ mux-mii-hog-0 {
  * conflict with PRU-ICSS
  */
 &mac_sw {
-        status = "disabled";
+	status = "disabled";
 };
 
 &davinci_mdio_sw {
-        status = "disabled";
+	status = "disabled";
 };
 
 /* PRU-ICSS MDIO configuration */
 &pruss_mdio {
-        pinctrl-0 = <&pruss_mdio_default>;
-        pinctrl-names = "default";
-        reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
-        reset-delay-us = <2>; /* PHY datasheet states 1uS min */
-        status = "okay";
-        #address-cells = <1>;
-        #size-cells = <0>;
+	pinctrl-0 = <&pruss_mdio_default>;
+	pinctrl-names = "default";
+	reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
+	reset-delay-us = <2>; /* PHY datasheet states 1uS min */
+	status = "okay";
+	#address-cells = <1>;
+	#size-cells = <0>;
 
-        pruss_eth0_phy: ethernet-phy@1 {
-                 reg = <1>;
-        };
+	pruss_eth0_phy: ethernet-phy@1 {
+		reg = <1>;
+	};
 
-        pruss_eth1_phy: ethernet-phy@3 {
-                 reg = <3>;
-        };
+	pruss_eth1_phy: ethernet-phy@3 {
+		reg = <3>;
+	};
 };
diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 8a693c478bea..57a45609f9f5 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -1870,7 +1870,7 @@ SYSC_OMAP2_SOFTRESET |
 
 			gpio2: gpio@0 {
 				compatible = "ti,omap4-gpio";
-                                gpio-ranges =	<&am33xx_pinmux  0 34 18>,
+				gpio-ranges =	<&am33xx_pinmux  0 34 18>,
 						<&am33xx_pinmux 18 77  4>,
 						<&am33xx_pinmux 22 56 10>;
 				gpio-controller;
diff --git a/arch/arm/boot/dts/ti/omap/dm8148-evm.dts b/arch/arm/boot/dts/ti/omap/dm8148-evm.dts
index 57a9eef09f6f..8236d9eb438a 100644
--- a/arch/arm/boot/dts/ti/omap/dm8148-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/dm8148-evm.dts
@@ -99,7 +99,7 @@ partition@780000 {
 };
 
 &mmc1 {
-        status = "disabled";
+	status = "disabled";
 };
 
 &mmc2 {
@@ -111,7 +111,7 @@ &mmc2 {
 };
 
 &mmc3 {
-        status = "disabled";
+	status = "disabled";
 };
 
 &pincntl {
diff --git a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
index 338449b32a18..76ebc6c3c3e5 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x-clocks.dtsi
@@ -177,7 +177,7 @@ mpu_ck: mpu_ck@15dc {
 		compatible = "ti,gate-clock";
 		clocks = <&sysclk2_ck>;
 		ti,bit-shift = <1>;
-                reg = <0x15dc>;
+		reg = <0x15dc>;
 	};
 
 	audio_pll_a_ck: audio_pll_a_ck@35c {
diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index 9df7648c4b79..a595745afe59 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -1695,9 +1695,9 @@ uart4: serial@0 {
 				reg = <0x0 0x100>;
 				interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>;
 				clock-frequency = <48000000>;
-			                        status = "disabled";
 				dmas = <&sdma_xbar 55>, <&sdma_xbar 56>;
 				dma-names = "tx", "rx";
+				status = "disabled";
 			};
 		};
 
diff --git a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
index a0c53d9c2625..28b4f12b82a7 100644
--- a/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/motorola-mapphone-common.dtsi
@@ -91,22 +91,22 @@ &cpu_thermal {
 };
 
 &cpu_alert0 {
-        temperature = <80000>; /* millicelsius */
+	temperature = <80000>; /* millicelsius */
 };
 
 &cpu0 {
-        /*
+	/*
 	 * Note that the 1.2GiHz mode is enabled for all SoC variants for
 	 * the Motorola Android Linux v3.0.8 based kernel.
 	 */
-        operating-points = <
-	        /* kHz    uV */
+	operating-points = <
+		/* kHz    uV */
 	        300000  1025000
 	        600000  1200000
 	        800000  1313000
 	        1008000 1375000
 		1200000 1375000
-        >;
+	>;
 };
 
 &dss {
diff --git a/arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi b/arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi
index 0e942513560d..6c4916ec41b4 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-cm-t3x30.dtsi
@@ -29,7 +29,7 @@ OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLUP | MUX_MODE4)	/* uart3_cts_rctx.gpio_1
 		>;
 	};
 
- 	hsusb0_pins: hsusb0-pins {
+	hsusb0_pins: hsusb0-pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x21a2, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_clk.hsusb0_clk */
 			OMAP3_CORE1_IOPAD(0x21a4, PIN_OUTPUT | MUX_MODE0)		/* hsusb0_stp.hsusb0_stp */
diff --git a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
index aa4fcdbedd8f..519f7b42a59a 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-n950-n9.dtsi
@@ -287,7 +287,7 @@ lis302: lis302@1d {
 		pinctrl-names = "default";
 		pinctrl-0 = <&accelerator_pins>;
 
-                interrupts-extended = <&gpio6 20 IRQ_TYPE_EDGE_FALLING>, <&gpio6 21 IRQ_TYPE_EDGE_FALLING>; /* 180, 181 */
+		interrupts-extended = <&gpio6 20 IRQ_TYPE_EDGE_FALLING>, <&gpio6 21 IRQ_TYPE_EDGE_FALLING>; /* 180, 181 */
 
 		/* click flags */
 		st,click-single-x;
diff --git a/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd35.dtsi
index 0da561a23f36..2f7a4a717359 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd35.dtsi
@@ -103,7 +103,7 @@ ads7846reg: ads7846-reg {
 
 	backlight {
 		compatible = "gpio-backlight";
-		
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&backlight_pins>;
 		gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;		/* gpio_145 */
diff --git a/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd43.dtsi
index 981f02f088f8..35701f596972 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-overo-common-lcd43.dtsi
@@ -134,7 +134,7 @@ ads7846reg: ads7846-reg {
 
 	backlight {
 		compatible = "gpio-backlight";
-		
+
 		pinctrl-names = "default";
 		pinctrl-0 = <&backlight_pins>;
 		gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;		/* gpio_145 */
-- 
2.53.0


