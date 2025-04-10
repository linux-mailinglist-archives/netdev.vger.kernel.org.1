Return-Path: <netdev+bounces-181100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC578A83AAE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57BF7AEE32
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8993920B204;
	Thu, 10 Apr 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="tuwPakjw"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A074205E31;
	Thu, 10 Apr 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269488; cv=none; b=EImK6kNVJFpD+0R9igxkXUjUjoCtq8AbktOGPSvazaIaTAlyIH+5WnTig1ouQE1OQ1Sx8qOZ7T5Q1WqGB1QqX2Ac6JGwd1r0czuf2JM1/Ab00o0UNugiraH8y9hiJgS8jAnDW5z5XyFPA0K/zDb+59YvXzj+elKG+QW5dnle5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269488; c=relaxed/simple;
	bh=Pb9fhhNlRDXFLApQGjgSX564cAnPyXxob7s56veHzsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=No3Ay34TE9VTNtRsAvQcIG4ArMsjXiEBcMAjfM/m5WO9uAjAS71bMp+wCtCQVsyF0tZbXhMLesWX0+4pU/HZAifgS5ga+AsjV0ndDwYm18Yw/zVigmRcHFfVeZReuIUKYhABjTOosKq3PrD5DHPAeFulvtodjjANXM7lnQ/NM7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=tuwPakjw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269483; x=1744874283; i=ps.report@gmx.net;
	bh=Pb9fhhNlRDXFLApQGjgSX564cAnPyXxob7s56veHzsw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tuwPakjw9QjAjCLt9ajAYNCYcVvnu4bQLX3IOv3GZM9wYdD8dYTsE4Af80jYdYxd
	 534dc34OGTTJUOY7pkiwc4dy3ZDcs6efyrHOT3HUL0DIlq8glVorSskdIxQZ1JiB4
	 lCweYChvZyDPvLAtBeC9uSSbubN7vGyzVF5uY+MTciWHaOWJ5ZKQj7PtoN2YHpzKw
	 571EkN+NMWzhdiGugi5LDPYeK4frf4WLiF2qDWchYrToUW39Iw6PSGC6nBZqbzfRT
	 5TotCcVmrdKP6R0FutYxNs9i609NuskObF6zpILyxZMEb5sktiB2BiqaY5b2ZLUrl
	 CEqSOWRW2HV9SOzIMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1t5QFH3EBU-011qD4; Thu, 10
 Apr 2025 09:18:03 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 09/11] net: pktgen: fix code style (WARNING: braces {} are not necessary for single statement blocks)
Date: Thu, 10 Apr 2025 09:17:46 +0200
Message-ID: <20250410071749.30505-10-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:xxII8a/JaxjpUB34YoW12Xu8FOQu7OjbwVTOfK84CSFLol5C+Sa
 TMg+Btb0tuNGrgLpTob1XcNcSykQRN3v91kCxacnE3ru6SLaVWNbITqeLp21Jtcb7SWV0Oj
 Bm4XixNy6RNggE52XbgecX111GpRDtgUSU3TJd28HaxUwo/53D+6WYc+Jr2D4Sk48zmMqjf
 Qs1hfwap0TOU8SLnTyo+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bqBWwJH3wGM=;Er30y8j0C7cRasSE1fthzubPMjS
 mOj6k5su7znl+C09VwMM9TY2eWIcyjlDmaIFFJslntyIJzI5ib9mkBSIG4PwZva05puoHUy7M
 pEabutNhW/RY5YkBRR4kyKNSCMUnQ2Gjh3V87QQJtusoB1CZuYbWQDyet8yrM5fTefAkpMXrm
 Wx1hIi76C3SQGqlwyRjpw740ViSVqRsSO1ybLs0e5EyqXdeYM7uqjmnLftRbF0y3k5dysRq9m
 fLTA7C+WHf1LNA/cBbFJhGnJJvhcH+Ve/agA3i3kuVlsPHIEozjFfcMLfDJ7szIf0IEbk5sOI
 0Qdt4pGQTI10j1jmWKRe6eppieCh6a5aofH6lmnTNEV/sPXC6DvbD06IsvMyHkp5l1tOe8HIc
 1kBe1h2WaCyCnY5fmEVVTDBAX+q34iI3L9ZqRn0O58917jYIPElaMdKX5spLX5cjlRMX/B06g
 FN62rIOiL8wpNyMbOfyXQn+Hxc+qHtckLgOtyhjr+UMtZ/49x/JdfApSHXTmIMDsKuM7rkLSl
 RT7SThqGLpcBOzTrB2F7M5H/xqfXamezdRo8hiNYodI0aJEVYqN403vQrrLWuekQIQDK6UW74
 Rxm8tMGxbnZJ03i1ZdShHW99mqMRwll4m8fdPUAZzMcpdOtQaOZocW5g0eJPIxIwsaDUd4YaR
 iAeAZnd3WH9pFXKjjogmf/muupoXR1ORh2cU0ngnLHJ28R+HleBsmFKWOTwCIY3d0QyIkTxUD
 H3MjFLIZIo2UTO2vypdaU6eD2zMNoGpwGBNQVrD4Ve8s/s3jk101F52IVmNx1XeDhO1jPAvfI
 gTgTtb19Rn+arJeYuvkDxMlmcPBURRmZJ8R6pgeiE/4aJxyJxZHheGosYdFlfosc4yp5oDrC0
 7OW1/LlD2ZsLPrdZeAqNrkEd2/6VrO/wTBxBKn5DeLZq1x4zeh2WL1L4UO1X9xwqxEsJgawjS
 sragO+V5xun6pAa0ou19ZFVtNOAjukWDYPpA2714R9AjBNq3uy79kDoVxF6+h6iQjgx7JUK0f
 3eVuUeqKzlAn7ltXTzzNKun0jZIW4gHL4GXOEfujlGFpryI/YlfvPpZtc+jzo8NoNAf+OkC/D
 rRp+FJUzOEsJavSCm3WNyha6m6QBo9s0Rx5shn4AQslyQYFuVuIqVs1ncYZbQXZr5WJBd3/ES
 vN7tmwU9UGcvlHW1oos5S4wbEucevjDxMP5jJvrnFejxd7b03aSRardj/xvalD3pVdmIt6pgP
 Nmg+4WKacypdqxrHWHquesMM/BPyiW/Wus8bPC8jrRoevqyV41zW2j7v6CR9SlNT56Rj5hpjS
 TAIZw1IGtxolPM90jMmf1gclESjognOXACYY9qWg2tY5K13LIEi09yMsGr+5YseUbXsflXLln
 FsbSP+AIm47aViISj50XOlaZzMtwsobRVffvh0Rc/6jL3AHfXD8OGw8atDH75xpHPAwman4gR
 JU8GyH7vqy8V2r5M9I0Mke2Mb7oA=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogYnJhY2VzIHt9
IGFyZSBub3QgbmVjZXNzYXJ5IGZvciBzaW5nbGUgc3RhdGVtZW50IGJsb2NrcwogICMyNTM4OiBG
SUxFOiBuZXQvY29yZS9wa3RnZW4uYzoyNTM4OgogICsgICAgICAgaWYgKChwa3RfZGV2LT5mbGFn
cyAmIEZfVklEX1JORCkgJiYgKHBrdF9kZXYtPnZsYW5faWQgIT0gMHhmZmZmKSkgewogICsgICAg
ICAgICAgICAgICBwa3RfZGV2LT52bGFuX2lkID0gZ2V0X3JhbmRvbV91MzJfYmVsb3coNDA5Nik7
CiAgKyAgICAgICB9CgogIFdBUk5JTkc6IGJyYWNlcyB7fSBhcmUgbm90IG5lY2Vzc2FyeSBmb3Ig
c2luZ2xlIHN0YXRlbWVudCBibG9ja3MKICAjMjU0MjogRklMRTogbmV0L2NvcmUvcGt0Z2VuLmM6
MjU0MjoKICArICAgICAgIGlmICgocGt0X2Rldi0+ZmxhZ3MgJiBGX1NWSURfUk5EKSAmJiAocGt0
X2Rldi0+c3ZsYW5faWQgIT0gMHhmZmZmKSkgewogICsgICAgICAgICAgICAgICBwa3RfZGV2LT5z
dmxhbl9pZCA9IGdldF9yYW5kb21fdTMyX2JlbG93KDQwOTYpOwogICsgICAgICAgfQoKICBXQVJO
SU5HOiBicmFjZXMge30gYXJlIG5vdCBuZWNlc3NhcnkgZm9yIHNpbmdsZSBzdGF0ZW1lbnQgYmxv
Y2tzCiAgIzI2MTE6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjI2MTE6CiAgKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0ID4gaW14KSB7CiAgKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdCA9IGltbjsKICArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfQoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2Vp
ZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgOSArKyst
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCBh
MTI2OGJlMWVkYzYuLjU2NDcyZDU2MzEzYyAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMK
KysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTI1MzUsMTMgKzI1MzUsMTEgQEAgc3RhdGljIHZv
aWQgbW9kX2N1cl9oZWFkZXJzKHN0cnVjdCBwa3RnZW5fZGV2ICpwa3RfZGV2KQogCQkJCQkJICAg
ICAgaHRvbmwoMHgwMDBmZmZmZikpOwogCX0KIAotCWlmICgocGt0X2Rldi0+ZmxhZ3MgJiBGX1ZJ
RF9STkQpICYmIChwa3RfZGV2LT52bGFuX2lkICE9IDB4ZmZmZikpIHsKKwlpZiAoKHBrdF9kZXYt
PmZsYWdzICYgRl9WSURfUk5EKSAmJiAocGt0X2Rldi0+dmxhbl9pZCAhPSAweGZmZmYpKQogCQlw
a3RfZGV2LT52bGFuX2lkID0gZ2V0X3JhbmRvbV91MzJfYmVsb3coNDA5Nik7Ci0JfQogCi0JaWYg
KChwa3RfZGV2LT5mbGFncyAmIEZfU1ZJRF9STkQpICYmIChwa3RfZGV2LT5zdmxhbl9pZCAhPSAw
eGZmZmYpKSB7CisJaWYgKChwa3RfZGV2LT5mbGFncyAmIEZfU1ZJRF9STkQpICYmIChwa3RfZGV2
LT5zdmxhbl9pZCAhPSAweGZmZmYpKQogCQlwa3RfZGV2LT5zdmxhbl9pZCA9IGdldF9yYW5kb21f
dTMyX2JlbG93KDQwOTYpOwotCX0KIAogCWlmIChwa3RfZGV2LT51ZHBfc3JjX21pbiA8IHBrdF9k
ZXYtPnVkcF9zcmNfbWF4KSB7CiAJCWlmIChwa3RfZGV2LT5mbGFncyAmIEZfVURQU1JDX1JORCkK
QEAgLTI2MDgsOSArMjYwNiw4IEBAIHN0YXRpYyB2b2lkIG1vZF9jdXJfaGVhZGVycyhzdHJ1Y3Qg
cGt0Z2VuX2RldiAqcGt0X2RldikKIAkJCQl9IGVsc2UgewogCQkJCQl0ID0gbnRvaGwocGt0X2Rl
di0+Y3VyX2RhZGRyKTsKIAkJCQkJdCsrOwotCQkJCQlpZiAodCA+IGlteCkgeworCQkJCQlpZiAo
dCA+IGlteCkKIAkJCQkJCXQgPSBpbW47Ci0JCQkJCX0KIAkJCQkJcGt0X2Rldi0+Y3VyX2RhZGRy
ID0gaHRvbmwodCk7CiAJCQkJfQogCQkJfQotLSAKMi40OS4wCgo=

