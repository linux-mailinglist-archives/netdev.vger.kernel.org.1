Return-Path: <netdev+bounces-181109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D2A83AE6
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0987D188B276
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2703421931C;
	Thu, 10 Apr 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="pQCJfq1h"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B8A20E703;
	Thu, 10 Apr 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269502; cv=none; b=OZiIY8ywLrnjSylwuM77UiwJrcI9x2yhlSneScH1Poswo2Pd06LobL4p49y606b66z73dSNItZXnKSOPMNDcuyou2Gp1VMQIOoCEOSiC93of5ry16QXRioOWfK37oB20WArB+LTervgO+ceTBWzuWKjOvcKQpVztebo6+AMnoc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269502; c=relaxed/simple;
	bh=KlNaIGSmY/cxwxFm873Op22eUAKNBXsFzNciq9lkiw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scDTLb4O6L8XCAIoO4KRqZOBLvLS3XvBbcpNUMLKnXBgXt/btujL63SnTMJVf2VRarFnLSiNzumWyeI8s6S6eebSLQOwhgKa1iJSXZOEx28GdsDYsJhbLKkRrZ9AJk5ftvSP8xpEXC3g6kFd5ZMttyqQOG+IR5DNEMkK990ml5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=pQCJfq1h; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269481; x=1744874281; i=ps.report@gmx.net;
	bh=KlNaIGSmY/cxwxFm873Op22eUAKNBXsFzNciq9lkiw0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pQCJfq1hq4NcRPDxWMxmydg2HMYlB49n+FKySYY7gg5XjwwuFMJQG5Fa9b/5k5gC
	 3r7qgp0rjvrtEjUDJJY6ixLIr9vipXonvIJVg20WhrJHSdJw58XwfUK6jl6PIhnuc
	 3aYWyPtt+AKMyLwFt4uTuzSje76dOTUdtRUyXOrDGAcPeLqb6OIP24sBUNEIQwLY1
	 XVENAgN6EoIKZpRSfPnVHa/1wdOacjrvhaHbT6KqcnfLADklUxKMIn5MaSqSqcfoc
	 Dsk95wqOpDc5UQv9Kumr/78WK9AlfDhfTwFDDbJZSMPFV3MXUMDBz6P7MLmTJOnXX
	 IVJGlVW22NWDjBy15w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1t3DK524G0-00zdHu; Thu, 10
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
Subject: [PATCH net-next v1 01/11] net: pktgen: fix code style (ERROR: "foo * bar" should be "foo *bar")
Date: Thu, 10 Apr 2025 09:17:38 +0200
Message-ID: <20250410071749.30505-2-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:zEfPRes/7lffLsDAzcbLi5TCSHON2zDIcqu7+XfAGCdwAUiUCrV
 Fr7heltgjsiiIYeyQ/B0wliRxHAoyCIOuwUTi8EZ4rHU/dsT+uRp1c7UG0+qYGNVSloJkOR
 MoUKeVZAtcdSv+0PuoJheVW/wSeDGW9ag0VGg4rLt411NnBwZqQfr5I2vSv3ksaB7rlnsqY
 mbi2RC0YoxLDb6eUfQjfw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mrQVI29ArUE=;4V5m59bymhROUMBd47xtMXCMefd
 jPCnFzlViVoz6TEaVMA6cY7ReMt9CNaON6AsiXuSYbwbK0eK/4IFjPljteh0OuOyPPdx1LdmG
 RFUeHnzM2T6KIUViAtSyrvhJtZLiCwCpbmxCE8biVe3CkcZFFKRSkwo3k2uExOaW+JZPrlu7C
 bhXeT1g93vk/kMnC+9nSt3n7YCBGSbXPNjRZSJgadNjf7yo3mERKn9yrxBTpQPiCJyECetby+
 qac/59hyrQkqRYFbW6Gpfh2Sna+Hncqgu9UlbWZc8EaOgG6b6m7A1Vmf0etBwB123DE2WWI8k
 UFJ7zdZ120PEuBRfRmsy52bD3NLeW50BA/FLeJyhZtIjRPFt9VPTx6cFbv2+pDZmcrxu6uU4D
 oOmiVWdfrfUZb458wSMeAGQiW0+6DYNsY0OmS8yx/OjXVa1961jYHUr2UBpG/kQGxle/sdGJ8
 AK6JZA//ktRuOdXeNIK5+jAK+uK1/5EivpaSOZRMyN2nz9RyuNShODqEhsHST67A2MMN1wPu/
 42RKnA9DPsg/cYz/tLyUi95znIrXojHD4X3VDbTxfH0wyt6aM2VJMki6I07qrm52GSCjQkD/a
 CI6aqNnue/fU1ODfvbaYHMlJYjkgClVG+JirjrutWlgg94shvK8+n6EN2SAS6YW6SjfgIkllw
 ctMpoH7MDd0i/AQGy1xOtjOWEaDr1cJ692Hlc1G6qgueGf66dCOdoSqoXpkUm+Ur21uCj2lTi
 zJuu9gsWWE+6LgTHHRgVOt03k8OYATz5jI9eSPC6HmzObsunL1k2jAX5wK0ujD/BUCTDefQtd
 pBUwZql2fI7gvITpe+BktznVEYpd3TuPW+8Lw7BOBfq9mijfhc8OcZIdZdqzbG9RNz4wyNMGu
 J/piqEGOz6L8eoeuw/QsOtNu+UqFOOF8XDQJSq4LKm/5a4U+RDFMdM0jz8kzzBmchtWOYv07w
 2CQGYrvHrnUsdoaMXAD/SZrEBQ5nv9JUuugnp3rWqSBQhRLdv4X2rErWKpdCZ7vxAv4pm5lNJ
 j7eeKHKxK9dphlfLLMN+iDZnoGZf4eVJfWsDVwKEwX6X90nJN5upKezI9SvGE1gVAri1i7q7c
 jPkn3Cx0OXGFzRVSztTp7Y/NnL00pfCALXCEVz2lpT1KHgpxvvt3ULGsFGtevDV7/SYFGWozK
 UwCiFDCQ1isWsVsZXRU1+7c8Umz2dL1AmB/wKkcGF6oD/ayMrqG563VwPUSqxfL8Akit/D9rX
 fVp7PnmT1MDxDA5l+s3AfnooO0n8jtmY2y9OtEIYTGcZWdc7ZnXngvaQhBLenG3mmargorldU
 CgiWr9mW8jqM2e/YgrGSWU4B+WgrEcahhJwKYX3RKidE26RFcy0vD6P3wtHmCdYZCv89H8zBh
 UG1qtjnwdybw1TfAPB4Mc09ae2Z5YqJm7UDCIi6PaqBK8ZZxPyny2lzrt8NOgEQz31vFhCd2k
 979452dYUsXndcvVFsGwXcFzkrPs=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSBlcnJvcnM6CgogIEVSUk9SOiAiZm9vICogYmFyIiBz
aG91bGQgYmUgImZvbyAqYmFyIgogICM5Nzc6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjk3NzoK
ICArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciBfX3VzZXIgKiB1c2Vy
X2J1ZmZlciwgc2l6ZV90IGNvdW50LAoKICBFUlJPUjogImZvbyAqIGJhciIgc2hvdWxkIGJlICJm
b28gKmJhciIKICAjOTc4OiBGSUxFOiBuZXQvY29yZS9wa3RnZW4uYzo5Nzg6CiAgKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGxvZmZfdCAqIG9mZnNldCkKCiAgRVJST1I6ICJmb28gKiBi
YXIiIHNob3VsZCBiZSAiZm9vICpiYXIiCiAgIzE5MTI6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5j
OjE5MTI6CiAgKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyIF9f
dXNlciAqIHVzZXJfYnVmZmVyLAoKICBFUlJPUjogImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28g
KmJhciIKICAjMTkxMzogRklMRTogbmV0L2NvcmUvcGt0Z2VuLmM6MTkxMzoKICArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBjb3VudCwgbG9mZl90ICogb2Zmc2V0KQoK
U2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIG5l
dC9jb3JlL3BrdGdlbi5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25l
dC9jb3JlL3BrdGdlbi5jCmluZGV4IGZlN2ZkZWZhYjk5NC4uZmU4OTM4NGQ1NmQwIDEwMDY0NAot
LS0gYS9uZXQvY29yZS9wa3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtOTc0LDgg
Kzk3NCw4IEBAIHN0YXRpYyBfX3UzMiBwa3RnZW5fcmVhZF9mbGFnKGNvbnN0IGNoYXIgKmYsIGJv
b2wgKmRpc2FibGUpCiB9CiAKIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl9pZl93cml0ZShzdHJ1Y3Qg
ZmlsZSAqZmlsZSwKLQkJCSAgICAgICBjb25zdCBjaGFyIF9fdXNlciAqIHVzZXJfYnVmZmVyLCBz
aXplX3QgY291bnQsCi0JCQkgICAgICAgbG9mZl90ICogb2Zmc2V0KQorCQkJICAgICAgIGNvbnN0
IGNoYXIgX191c2VyICp1c2VyX2J1ZmZlciwgc2l6ZV90IGNvdW50LAorCQkJICAgICAgIGxvZmZf
dCAqb2Zmc2V0KQogewogCXN0cnVjdCBzZXFfZmlsZSAqc2VxID0gZmlsZS0+cHJpdmF0ZV9kYXRh
OwogCXN0cnVjdCBwa3RnZW5fZGV2ICpwa3RfZGV2ID0gc2VxLT5wcml2YXRlOwpAQCAtMTkwOSw4
ICsxOTA5LDggQEAgc3RhdGljIGludCBwa3RnZW5fdGhyZWFkX3Nob3coc3RydWN0IHNlcV9maWxl
ICpzZXEsIHZvaWQgKnYpCiB9CiAKIHN0YXRpYyBzc2l6ZV90IHBrdGdlbl90aHJlYWRfd3JpdGUo
c3RydWN0IGZpbGUgKmZpbGUsCi0JCQkJICAgY29uc3QgY2hhciBfX3VzZXIgKiB1c2VyX2J1ZmZl
ciwKLQkJCQkgICBzaXplX3QgY291bnQsIGxvZmZfdCAqIG9mZnNldCkKKwkJCQkgICBjb25zdCBj
aGFyIF9fdXNlciAqdXNlcl9idWZmZXIsCisJCQkJICAgc2l6ZV90IGNvdW50LCBsb2ZmX3QgKm9m
ZnNldCkKIHsKIAlzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSA9IGZpbGUtPnByaXZhdGVfZGF0YTsKIAlz
dHJ1Y3QgcGt0Z2VuX3RocmVhZCAqdCA9IHNlcS0+cHJpdmF0ZTsKLS0gCjIuNDkuMAoK

