Return-Path: <netdev+bounces-181106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD21A83AF9
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18A048A2EC4
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878D20F065;
	Thu, 10 Apr 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="FycS+Ctr"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9638B20CCD0;
	Thu, 10 Apr 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269499; cv=none; b=d5C+5rDs4GUPKk6mka4xZnhtw8OTZAg8VlFTZcGn2/tZ8uUAnXYMngNNfsT/h6Xm6FcwvNNntVpB0pj0RFwbRnspc1AxT1D+fSNx7X3xIxG6ZG771X8CCOwoJOgZM6Ps+7aglgUbY6HIkSscL21BbgHLSwt3So92IRTcI5uRB+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269499; c=relaxed/simple;
	bh=IgECv3hjYg1JSen2eCxwSIQ9w/POgvVNdDJiBiLTi3U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a8C//sZep7d1NzEF/mDN3dXVJcq1KnVd25SQ8t0KOfY4e76P6FZ/Xp39r+51ilObie/egoki547fFXYVQgeVDAZfVD7wdGSjuhhry6M9Xa+CA4YBaBkOV66CJQ+fkQpBfNQm8nwbgNHiMlj0vFa40xxJ3SpdCEEOXjH/Zon+2/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=FycS+Ctr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269482; x=1744874282; i=ps.report@gmx.net;
	bh=IgECv3hjYg1JSen2eCxwSIQ9w/POgvVNdDJiBiLTi3U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FycS+CtrjTymDnCYu+nncJhyZfSXtn2I8Yo/nC2PbG7p4pnbG3zVUlmHGt/kq7wF
	 hRmxhW0OQFIG7A1OkT5SG+04B73fecOhJwlrJn3is1NfSIcVzJtnxSjMTmWRuEVdA
	 XVZXbNkpVipeNtnOS7WOIwR6Wgyw5dj1Q1XvepT+QU76qNHgDSbPPk2m7yjrcjwZ7
	 1748DYQulPuUWxXr9Ra6yymWFLA3lmtj0zP+9VZc+AQixaoLdsQpsZ9RJDcvXOaD1
	 Us6sfitdJnZ+0xcOhvOk9PdAam2dcxM+4jwzNq3iqA8WtC+E8l72JJ+OWr307MCGH
	 k3vKBIF6XtnY3Zli6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhD2Y-1tOkax3FA2-00eEZ6; Thu, 10
 Apr 2025 09:18:01 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 02/11] net: pktgen: fix code style (ERROR: space prohibited after that '&')
Date: Thu, 10 Apr 2025 09:17:39 +0200
Message-ID: <20250410071749.30505-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410071749.30505-1-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:ZEFMZBN5BPNv9NgQYKWgVv+rSzqBUCYIX7S1ODeL+MCR8VOc8Ae
 ZiZmzkscbNYNG+3/oBl+xFWoN+DDHsD+17o0cynQcv0yMq+/9e1NFJppkyr1QlQPa3gQLC6
 IDAJQjwSN3L92V0pXKrzo/K67oShvCSJvX6M9SMJFzMnz18k8vjNBox7m8AGjd6kYDoRMBx
 3x5EnHiAHbTh5u6g9CcoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:48xfYmTJP6k=;2JClBxMsLBMO/1RLbyg439g/uAF
 WD+YP1bwsVzz33VICvk1bcQonoSoHJO2hxhUlHMVRILujEbM6etr8nzeU/zc0gkKuqzdBFEh3
 PxeAZ5H8QWFORr4geq+9PiwwgFck1DtxhNKcgGmGOUEoAP4B7ga+r2mC3X45ElNi1bWI105Sr
 pHMHXn+bgQqchaAC31epfmmeEUB3NdmSxvge3v0VMvSpnAnqt9duCmO0nbsno419rsv4zSY5o
 0eM8/FLdKyM50k45ywIas21Z1k2qORZXJJZ8GdGyBx46AjS6yNOwWgve/uKVeUIOBohaRt66J
 ksrcHBPqJhHbI+5nQOn/Gc/TqeNwknNupO8FLYxC5GHMjXDl8Msw+snlSRH3+VzF4fCPPy78O
 pFW7525FIedJxvnWh3omGTCWIZ7tBq4kwMM1UqYAXJbvDgEHFnEf0jP+HGukJG47KnIllddUA
 ft9YSmufd++uTk0gt8TiyNIfQ8P91EZZQf0rrwInbouD8RSHFsIJ9BD/rr2SL3ZnREXJH76Iw
 UeoZWI4w08pyPUb9rr8zNAp/1Cwpe4uMcsUzkhviavnVcthRfzPmrnxEjg15zP/UBhR23K8rG
 D/ZWJ81tncvC9h1jRZcyNN5luykOTy08EEV7uqeboCCo0uZpFh2hH+Xs4qx9JW3R8/JreWAeI
 e+rPdSXwt0v9b5+8+fCAaPLSRN06K5KJS0ZtlQYIPOW8FHucEmm4Wi5giuTzv6jl4M+2uvUwh
 MkSPvdSexLaQXI45klA2cjsbT6kgXp2yif3Ft/nZTSed3Sbnw9tEbftW/izSJmgXbW472KUHk
 oF07l2RyZQo5VGsh1p97UsXsE4+aAUQy6FMs8ilqGVHx59/1uotAv5dQPIBCC7dXNGX1skQ8U
 igASalhLRegEFntkinXGgHmZ0qqVGPmsXj/tE7x9Ll8B20+X7u0VdRty/vOe1sjtf0FoFRmud
 hl0jbGrgLblE1m0D7s007JdfrBnQZ5PF/DZ9t7/y/ga8frMuOQ5Si+7KTVHulVcTbmqVDHBoh
 ClYEPMVdtO0A1mlOEgvCXLgYVYKgeuRh3gL4Ga+Q1U55Bm26Q2CgIps9Wt6P0Dc3vbhODTPFz
 dgfoa94VVRIL8Is3qMou5rxsy0bdeFUyYNexyplBJiUs680X/MsUuHv/OKlL4n/6P//C4+X6v
 5upPcR8gL2c5Py7NQTfdcLy1+KcAySOge/ZknJsOQDHgfRDuaP8I+9n6ywmMk9l+XGvvMqRBX
 D/xpu15FCqaw3nqnGs7XWVVzmD9hgkb48uj5sKFi8zsIU9xdw46ZtNd84ZE1vHHM1N3vzoBF8
 ip5O/eesOP0N2cXM559pKhMoqTGYmztNsyoj5NA61SDjaEmf6e33oYA0ld2v81V/iv0RyWZqv
 Az7vJqzZjBc41hmdgXDMOJOfX60Ms5wmeAzKiNwjDyJJaOOtKydJAZ7QygwMiuvxTWkgzALiu
 IpQqgatuRO/l3YK3TyiK71Kspyms=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSBlcnJvcnMvY2hlY2tzOgoKICBDSEVDSzogTm8gc3Bh
Y2UgaXMgbmVjZXNzYXJ5IGFmdGVyIGEgY2FzdAogICMyOTg0OiBGSUxFOiBuZXQvY29yZS9wa3Rn
ZW4uYzoyOTg0OgogICsgICAgICAgKihfX2JlMTYgKikgJiBldGhbMTJdID0gcHJvdG9jb2w7Cgog
IEVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyYnIChjdHg6V3hXKQogICMyOTg0
OiBGSUxFOiBuZXQvY29yZS9wa3RnZW4uYzoyOTg0OgogICsgICAgICAgKihfX2JlMTYgKikgJiBl
dGhbMTJdID0gcHJvdG9jb2w7CgpTaWduZWQtb2ZmLWJ5OiBQZXRlciBTZWlkZXJlciA8cHMucmVw
b3J0QGdteC5uZXQ+Ci0tLQogbmV0L2NvcmUvcGt0Z2VuLmMgfCAyICstCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9w
a3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmluZGV4IGZlODkzODRkNTZkMC4uYTU0NjgzZDlk
NDRhIDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4u
YwpAQCAtMjk4MSw3ICsyOTgxLDcgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpmaWxsX3BhY2tl
dF9pcHY0KHN0cnVjdCBuZXRfZGV2aWNlICpvZGV2LAogCXNrYi0+cHJpb3JpdHkgPSBwa3RfZGV2
LT5za2JfcHJpb3JpdHk7CiAKIAltZW1jcHkoZXRoLCBwa3RfZGV2LT5oaCwgMTIpOwotCSooX19i
ZTE2ICopICYgZXRoWzEyXSA9IHByb3RvY29sOworCSooX19iZTE2ICopJmV0aFsxMl0gPSBwcm90
b2NvbDsKIAogCS8qIEV0aCArIElQaCArIFVEUGggKyBtcGxzICovCiAJZGF0YWxlbiA9IHBrdF9k
ZXYtPmN1cl9wa3Rfc2l6ZSAtIDE0IC0gMjAgLSA4IC0KLS0gCjIuNDkuMAoK

