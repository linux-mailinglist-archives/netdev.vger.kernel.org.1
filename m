Return-Path: <netdev+bounces-301349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e/+3GkJsOmrS8gcAu9opvQ
	(envelope-from <netdev+bounces-301349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5996B6A89
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 13:21:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XuwEV5DW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301349-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301349-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBF2B303F984
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 11:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3DD3D34BB;
	Tue, 23 Jun 2026 11:21:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903337C0FE
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 11:21:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782213694; cv=none; b=V9tbGVtxpRVMD+5B0I94E4F2OBhUEcFVAPwYjxoaV5xYKh5z0fTexVsHoMSEfpvw4/d+vzdlCpEh+1UtMK70AxAPw0oFewjGeiX72LUchLtninahVjj6gadh7FeIJoebImiz4YABnCDvqI6TlPzK1JMMG82KJi/oENtU0QzYzxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782213694; c=relaxed/simple;
	bh=a4AMbgsU9vnD3f+9idFEn0dPE+OfDvFh/UXAkrsR24M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G27/4FVhEiiGkqKpPctdP/JY9sO+iISwzGU98JZw1EcyTm9i3Iq/HrxUn5XnjRiauOTTBtMvDs9wHngatMkSukpeUhagx0iKxdv+Q+NMpmAmVd1zob+QDntzjlZPfxVwFiEtUATXET/64zuK0MM5AJgIFn6JC5MWs3xMehskpB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuwEV5DW; arc=none smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6e21c47e6so3142939a34.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 04:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782213692; x=1782818492; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUJToStsuX+ZnU0L6C4YrQgVNiGOS5/f7s1ZTO1n2Qw=;
        b=XuwEV5DWrHplKPVDfZJ977Yn9NEo/ebHj9zhck42x3xNEg0QKIH0C/0YjjDPN2qSOE
         /y+dsUph0R8zIS5Zvv2iX5tiC9aLQ27B56mQFfNnhVplYx2DqayQre2zWzn8dkkdOap9
         5peHot6nEYWRQoNqdXx8ABRf/kU9yIPKFVITm/LwB3nh246PaGIPT9QnJENvliezBmtM
         HuVOPtycqlQxCe9jHIBGa3M9ZlLAE9E5myV1xtGHZTWlANRU1zP9gtpDWqVC5wUDajgk
         ECJ8+ay6UEoyOboW+ly9q5X9kvyBqb/b+MB+ik4UNWzBveXVb55PoQUVA6LLXs1YWMQZ
         R4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782213692; x=1782818492;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUJToStsuX+ZnU0L6C4YrQgVNiGOS5/f7s1ZTO1n2Qw=;
        b=Olimif3n7aqaLWhxS5Xzh6OJ/eVB63g1/59+21mljndm3zncrshd0iZyAX88J1yBzy
         cPr9Jk9t9gcfexXFSuAqkurH1QL8dWY6dDNrAYkDdw1sEewsX6fYXXK0WOHH9q2SMbho
         L5N+6MguDuQ1FzOa51OXG+cWLzzyHogoD9X+/7mWcp0cWo5geZZQJ0vVSlSa/K63t8nz
         AK4bCr4a8wPNTvhCnJXHnZFNwELQNxzW2rbdVjb0pN31Cu1RCiLsMZTWH659VDorD+Qh
         OWShPPOVXuuyWA2XUxtLlPQaCJo25qbaR7cgPqY37hkEwoBl8bgzTlRSHczRH6w77MQz
         d24Q==
X-Forwarded-Encrypted: i=1; AFNElJ+JXTuUnvCsGaW61O6K3BaA17dyPy+ivV9QveNue+ticC586d101g9Sho9tm29CEkj59ifvQ5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkwMgdWqrNrK9xuU/GuTzKCV65gvmVJRv20shV8BJzhXlDeHKv
	9Y57Qu3/uFCg48pecWv3wk93WKUIMpZCNrCQHt+8dyfltUGkogNfBqs4
X-Gm-Gg: AfdE7cki4dfmeSCCLeNmAZjl1y2WYAlOCkkQgec0QyDjAH72p2Co5pOqMo4lM8v/6w3
	cCHm7HIy5nNbMBAgeDObGXeeUyh/mpTwnGf6Cn1nK4b3EXdnEWmVFV+6x9o2uPmfCp1OXN/pb5a
	5d3m8QQr0mB5L6g3JxFRsEm2P6jWJNXsTt1Fm8Jhbv/HB7tac/XUbtkagvDT7vPRHweK1rlzZFX
	DnJNauJ9tGJgk5EczQU33sR53EF5M+l5/hMDd2E0wpCj+3L/D2fSaEtaWOq3vXjaBnfoLp8slCD
	OhVlJpy6nr5McvY+E965TJNKvK1baJixLWky8wZUCMVQVSiSAORo/JV+HuDorkcU6e+FTae6llF
	Y7dQGlW1EHyaT2z+njVDW2CJXJxCzRX8p2r97vptkKOluensOvgcu+uUf4smAxOcVxGShBU+Q7M
	iFiJOAEB8wBCmoA/eS3vuNseAZACC+
X-Received: by 2002:a05:6830:81ec:b0:7e7:45f:ce3c with SMTP id 46e09a7af769-7e9798d60d5mr1467767a34.14.1782213691855;
        Tue, 23 Jun 2026 04:21:31 -0700 (PDT)
Received: from GINKO1.localdomain ([216.167.189.32])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94406d488sm8630916a34.8.2026.06.23.04.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 04:21:31 -0700 (PDT)
From: Michael Pratte <slatoncomputers@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@google.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org
Subject: s2io: driver still in use - please reconsider removal
Date: Tue, 23 Jun 2026 06:21:33 -0500
Message-ID: <20260623112133.752195-1-slatoncomputers@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,lunn.ch,kernel.org,davemloft.net,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301349-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[slatoncomputers@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slatoncomputers@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF5996B6A89

Hi,

Commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
driver") removed s2io in v7.0 as "highly unlikely to still be used."
It is still in use here: an Exar Xframe-II (PCI 17d5:5832) in a
Supermicro X5DA8.

Bringing it up, I found that no TCP can be transmitted on these
adapters since v4.2. I bisected it to 51466a7545b7 ("tcp: fill
shinfo->gso_type at last moment"): since that commit tcp_transmit_skb()
sets skb_shinfo(skb)->gso_type unconditionally, non-GSO TCP frames now
reach s2io_xmit() with gso_type=SKB_GSO_TCPV4 but gso_size=0. The driver
arms the hardware LSO engine off gso_type alone and programs MSS=0,
which the Xframe-II rejects (LSO6_ABORT), dropping every TCP frame
before the MAC. UDP and ICMP are unaffected.

The fix is one line - only arm LSO for skbs that are really GSO:

-	if (offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) {
+	if ((offload_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6)) && skb_is_gso(skb)) {

I have submitted that patch to stable@ for the 6.6.y and 6.12.y trees
that still carry the driver. Given it is evidently still in use, would
you consider reverting the removal?

Thanks,
Michael Pratte

