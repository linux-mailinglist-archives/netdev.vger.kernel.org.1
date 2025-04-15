Return-Path: <netdev+bounces-182734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF3A89C89
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28676189D00B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE8E29A3F3;
	Tue, 15 Apr 2025 11:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="aCLJYOQg"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4F29A3EB;
	Tue, 15 Apr 2025 11:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716579; cv=none; b=t3Eq0CedFK7buWhyC6tz9Fgk0qexi2/1mq6Q2m5BNLNF72LzrKViIB+IXtjS2jTwz6LWvhOTWQGrZZGTlM/4yaOJm0C7/mSazWNeJ55uoh2m+Oix5atQISNoUi0d6+HPNXFiHGakgVkzTUeGpSgiBe/iG2Y6CQtBMCjHbUKrIOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716579; c=relaxed/simple;
	bh=IFlG2H8poFQ+/G0rjtVMAbzUPiCSrZsEYZjQKj9PU/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CWLWKCnCuCbQvGG00TfMuxYI6QftPjYtZXNc8iTqyqC54CgnExFLCatMCP/gO7J3sxVTjhFdw+rhxctMzt7b/o95ss2cee0GpbviSmWqefLwbvhrhCsdn8fdMcbWTBUnE0pRtrqYqdycLpT9Iwk7xflqOYM5lj79+5sewnnoQnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=aCLJYOQg; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744716570; x=1745321370; i=ps.report@gmx.net;
	bh=IFlG2H8poFQ+/G0rjtVMAbzUPiCSrZsEYZjQKj9PU/A=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aCLJYOQgrJ6zMxnyt1JGoLdsXF2Zc3/oX+ddVamRkiwknemdLtxLmqcdyNWmrUbE
	 PotOcGnrZyf1YT6xok5O8sXnQgno7jzqE12IV30GgOjGc9WkGwKSgoz/hOQ9ZOV+f
	 gDQNTywDyBmbi1PYyJjBlpJT6BcRCXOVo4YXQHbG+mYYnx8dbEnN44x8ruB6kblkI
	 dfDyTxyDLkd/7JSjSB3b1IaCkWEe3Vq0d0jEaGfxs+RZ6fRFhVWFSfvwhyJGtqn/k
	 twQfHjq4/BioWK+0zGeMVS8N6adb1WS/xDmR4uttjBN6ta26B9r9MOWG5koZ7YuY7
	 5fOUiQwuQ+JtkPT2fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLzFr-1tnG5T1nEX-00XUX9; Tue, 15
 Apr 2025 13:29:30 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v2 2/3] net: pktgen: fix code style (WARNING: please, no space before tabs)
Date: Tue, 15 Apr 2025 13:29:15 +0200
Message-ID: <20250415112916.113455-3-ps.report@gmx.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415112916.113455-1-ps.report@gmx.net>
References: <20250415112916.113455-1-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:QpDcqAQgWSc8AXIYHjAAJCCR76D/6csHeeU/ARO7/34K15E94v4
 1eteRSG53bQOtEoj945yQj7iTsL1CYdxIloe85dQh46g+c5+pEdUYVFkzqL5VYShGIQGyb7
 UAvDWe74gstpEUMQLaD6nMJ5aXGDNOLApRn0ng7kFC9QhwpdUXe65J9c6jaPiKNFJ0/9I5c
 rsyhoxA/TkcipH/koSJ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5jOzgypVDoI=;FHfQJzHX6wcgems/1ErKbBvjkJi
 cOyxPRDJH2MhsHk7J3bcaHiBHPPdnSaRwmOdA4GO7gPJUb/r3kej8/y/hAVVCkBB0GVMd6yo2
 mmTaenIHQS9WVlABeiVailjqW/72NbzlDuU1a601fZMCXol3Ni8hEZme+LlqG9fPqfV07vVc4
 szfmhGFUlYw3f2Zfjj/NJ3AQ+PcFvQJfJG8Zy4xqLtNvmnU6jECyXXEvP5T5NXJYRPxcgCYOV
 8HY1ykn3Dvi/IinEeUJx8TGFv9mjLTR9Mm/0wqpS4dJsngZpAwSo/LHq80UmUCmNTuJIBweIz
 8z1MaIdnuw1nr5UBWujKOcv1kNwDAH0mMdkCsS4zjK2hrN6clUE8DOQocDY73xowCHSu3iEjl
 VrT5LCrce6XX4HRiBxZtobxNMC7eoWDTy7rWLc1qfjuu34iN1X2m6KJUo5/J9V8tFuy3twMJ9
 gCwSUV5wdMjB1ZB2/jvGmJXyY1pnWMUibDrl3se7KZIraimkVZIpoIrpU/UStcCVVjHJl7cHI
 IEA/IgHCeZDtd79OEqRSFslRLpopA2wPyqwzsNAXUiiBNf7gUrcCWiRPzKn0jUCxI3n4Hn53+
 /3oBMQ/ZutXFV73fBNGJ4M1xSlDwMVYZNJZafrZ5OEz/RuQyebNRBotTdO8aV1NLvDS5p9r6a
 NX6PySlTXuCXDuK6SJLreZYiES1p9N16c/+QgfpJVRXl00/aEkOZZ7DLm3roiN2T32QkEm/qU
 rD18pvJT8wd7HXemG/AyTg8g6kKOpGsLmIxy/3g4pIDOiQ0zpCPCKwcP6dPROn9yqjVAVcJDH
 9bI04O/R0N4HmRpOqNn+dDr5DdtSNNYCitWfksFilRhSRmSlAadDZsCCd7Hl0/rcbQF9IP5aH
 DhbfyM4rg72PU5f7ZdK7GNiSdt0omDzZ7h0gC0Skiklko2xqTpEmAoto9yY797LueuffY/DYp
 nweo6Xi18FwQA1Q2Ux9m2I8mtjFqBKt7oKt8N9l+vn+9LMJHswNkZzXR9T5IaO9qvtEweUzGZ
 TwiqKc0df7ZK8sTBRALVPjiFPK9QUtt2F7SQRh/e7BDpJF5K8BLM5d8nM+wNDj9szfiBLtsPF
 YUmtsSg021+BUuP/M5pfCXG8qWokZGL+SSY70GT5x/2B8zCgn9zYcFQT0QOBCJnN9ENRiJi3l
 sNenkCvQC4JWUPquzY2p0eg3k56XyUiIJCQrhtIVkY/1KxuX4FKxmpV3gxa53lTuE6nWAUa+Y
 EYTyIom+yOEbFHmqlWbysZLJW2h6krD4LTU2M0tSg/xvglJixjl4CiPGYygFaNvNTOXJCzFeq
 VEIDCoNQ1OLUvMPFW9knpCI9JqHkiGJua6ffNGv8CPykjsgb856VYAXJfg8Wl+rcXEOk1Z3F3
 2hrQGyD5mYuv/rjRuYsm8ECuhagsR7EoQxIwz6oZzZOO2i6vTSgQu84apxdSMDlp675bO+Fgr
 UY/YDwC7zvIbTHJ8EWSrA4wC3AxM=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogcGxlYXNlLCBu
byBzcGFjZSBiZWZvcmUgdGFicwogICMyMzA6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjIzMDoK
ICArI2RlZmluZSBNX05FVElGX1JFQ0VJVkUgXkkxXkkvKiBJbmplY3QgcGFja2V0cyBpbnRvIHN0
YWNrICovJAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0
PgotLS0KQ2hhbmdlcyB2MSAtPiB2MjoKICAtIGNoYW5nZSBmcm9tIHNwYWNlcyB0byB0YWIgZm9y
IGluZGVudCAoc3VnZ2VzdGVkIGJ5IEpha3ViIEtpY2luc2tpKQotLS0KIG5ldC9jb3JlL3BrdGdl
bi5jIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2VuLmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRl
eCAyMTIwNmE1Njc4NDMuLjlkNTZmOTc2NTQxMSAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2Vu
LmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAgLTIyNyw3ICsyMjcsNyBAQCBzdGF0aWMgY2hh
ciAqcGt0X2ZsYWdfbmFtZXNbXSA9IHsKIAogLyogWG1pdCBtb2RlcyAqLwogI2RlZmluZSBNX1NU
QVJUX1hNSVQJCTAJLyogRGVmYXVsdCBub3JtYWwgVFggKi8KLSNkZWZpbmUgTV9ORVRJRl9SRUNF
SVZFIAkxCS8qIEluamVjdCBwYWNrZXRzIGludG8gc3RhY2sgKi8KKyNkZWZpbmUgTV9ORVRJRl9S
RUNFSVZFCQkxCS8qIEluamVjdCBwYWNrZXRzIGludG8gc3RhY2sgKi8KICNkZWZpbmUgTV9RVUVV
RV9YTUlUCQkyCS8qIEluamVjdCBwYWNrZXQgaW50byBxZGlzYyAqLwogCiAvKiBJZiBsb2NrIC0t
IHByb3RlY3RzIHVwZGF0aW5nIG9mIGlmX2xpc3QgKi8KLS0gCjIuNDkuMAoK

