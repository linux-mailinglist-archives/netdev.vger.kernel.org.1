Return-Path: <netdev+bounces-132121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9055990822
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 17:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919982868FC
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B261C3029;
	Fri,  4 Oct 2024 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b="kYFByXsw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFF172798;
	Fri,  4 Oct 2024 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728056733; cv=none; b=LsDQFeZdnRL8F2yoFx5TQ84FgzFlToKo3pb02jKNd3OUCUu9mPKTazdJG5BDThWSqh7Nc3fSTgC9HOmuBI9kId+i1g/8sE1Tq1jWI9REehN66FK4DMpt1SOLAN73vlz7E3McndAjc24+JhNcfRdt7nGe7zc4+KvH2CXv+ZIqhnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728056733; c=relaxed/simple;
	bh=66p7DdsIrl6EE4XosAG2YbOxrT0zz9D5FeNqspjVbRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lOFxuaJxLofJZog5RIQsQ9KSJo46W3rleI8MWzaDeomQjs+cmiIxE0gZnspEpRRtKnvI5n2JwdVI1HwCw6mmhfzwKKbDzOXKn2rOzb+HSR7YYGSRPpSEjsF2rTYtdze85hF+ox6r2cS/TDXG2gbukJei2EF+r+NLPCjGEQigGqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr; spf=pass smtp.mailfrom=gmx.fr; dkim=pass (2048-bit key) header.d=gmx.fr header.i=benoit.monin@gmx.fr header.b=kYFByXsw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.fr;
	s=s31663417; t=1728056704; x=1728661504; i=benoit.monin@gmx.fr;
	bh=CA2yO/d2EPO/ZW/AbxKwNzQWkYaUCX+FFknT/Co74Ms=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kYFByXswlXFgJEgvdSKC1BRi+t7NzXEU1hqw8T7KPUBh8VWPyhjPKl8dgD8yS0CZ
	 j3eyAKCRDpSu8zFyNimGeTr6zVBTdxOT8zbXgrL4JPtka5u16TRFWKYJNBDgv64Sp
	 aqPkcTkauKjg224yoaIRp2SKRjoxeefZ2uJYJJJc6Pudt3BBpHaUZ65n/AM7suk3b
	 S/t5xgXGFmsFL6tDED5XaMvxRsGPNH/9rJUcTycKoIIu8qG9aFfgRgdAJ5FAjWJBO
	 giZvNsJiHPeV+BVK2yQQwPRY7tAPKbFL/nm0rfjp1FFKOiHqNf1s9a/T05jJtRfkX
	 sdIfBfpwhqgi8338Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from pianobar.pianonet ([176.145.30.241]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhD2Y-1tb3K6246U-00ZXMM; Fri, 04
 Oct 2024 17:45:04 +0200
From: =?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Beno=C3=AEt=20Monin?= <benoit.monin@gmx.fr>
Subject: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6 header contains extension
Date: Fri,  4 Oct 2024 17:45:03 +0200
Message-ID: <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bQYS+6VQnmGu6V0oRp+Kz8AEJOG/XECy0nhPXUcqnqFde9kpyHe
 DS7jg0GmE1gxXApt2ylQ/VPZJlRsOSpTwLwS1xVtfFEwuTXeV4QvoBIQASg/PyR5fHErxfC
 an0YJIkhoQxPrK05r9LNnt+TRvcOJyXtFZ+2M4FuFVtJw3YSsJk75srKXh/nzdnYpEGIhAS
 AS5cC5uasVGwnlnFLuswQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FFsxgWq0j2U=;JcsCnGAtAPcEX0MPVfRzkUVUTip
 h4vmGLMKCPyHT98VXxJfsQ/1OA7FFA4suOXX2kU8HVI2GEWdcLCxScjcNe8Bq9jsNobxq9HbN
 2RAzHprKPHNRg0B4MZSMh2R1NDFx56+iCU8mQPWKSNb1/+IltZLwIDoWIDiWb8zkPvpXi3a3c
 irbdlaqNRVYhbDUdCkJw9rNfDFTU0tDsc3hSJv1aZ+TjmSpdsftWrFpwCuBwpRxv6hCq3fyWO
 olpGQ920+qgvz+1apo4BTEbAFt0+iY7Vag0Rcg5ixa8JggTNkvZm9R8B7EWTif+S+1L67vWRR
 7m/p70CYeK0Lq9EWYpYEw+8dAOIotYtqffqcx+jNB/BV7fa4/1XOkXImxt3wB0lZwltUw21K8
 m9Vg3eQfiBKMcV4PKwsptMFU8AHDg7A99+OM3x4TXCtOEs5cfFuVjnC1p/WF/+9yyxxDUDXBA
 m8oFiA6AftNi0mrAxhiltDdXlCAC2DNlzgDtfuQ3cGpze3srLRlrOJjDQ3v3G4g44LcIruknM
 /xau2enE+ujdvq+qSiDYibtAR73itzKxtzDQOBlK+k/wlHb1EeycG+sgUZmPU+C73HhJotiQI
 b3B5rAnWObpf/Q3bLcYSYt8Q09adGt204jcaDt7WLArWqCTrxIiyuX1aT2ATliavZhwZZG62x
 /JI9BpwTFg87qPIX8V2SIekQ2EiKgfNwsEmRc2OPSjUZZixvlyXHc3edJJPrAwXkx5+DgXB0A
 lr+jDHRZWdRic0KB4x1PuPhyGeXZvel8LW3sCbc5mSystsvpGQiuGVrVActbSf4ZQ5JabXecl
 aH1R+Tz9KDXKpA9NbfjvEqOQ==

Devices with NETIF_F_IP_CSUM capability can checksum TCP and UDP over
IPv4 with an IP header that may contains options; whereas devices with
NETIF_F_IPV6_CSUM capability can only checksum TCP and UDP over IPv6 if
the IP header does not contains extension.

Enforce that in skb_csum_hwoffload_help by checking the network header
length in the case where the IP header version is 6. We cannot simply
rely on the network header length since the IPv4 header can from 20 to
60 bytes whereas the IPv6 header must be 40 bytes. So we check the
version field which is common to IPv4 and IPv6 headers.

This fixes checksumming errors seen with ip6_tunnel and fou6
encapsulation, for example with GRE-in-UDP over IPv6:
* fou6 adds a UDP header with a partial checksum if the inner packet
does not contains a valid checksum.
* ip6_tunnel adds an IPv6 header with a destination option extension
header if encap_limit is non-zero (the default value is 4).

Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
=2D--
 net/core/dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index ea5fbcd133ae..199831d86ec1 100644
=2D-- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		return 0;

 	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
+		if (ip_hdr(skb)->version =3D=3D 6 &&
+		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
+			goto sw_checksum;
 		switch (skb->csum_offset) {
 		case offsetof(struct tcphdr, check):
 		case offsetof(struct udphdr, check):
@@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 		}
 	}

+sw_checksum:
 	return skb_checksum_help(skb);
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);

