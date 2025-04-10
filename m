Return-Path: <netdev+bounces-181107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80280A83AFD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08A3C8A555B
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E104620E6E2;
	Thu, 10 Apr 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="IaB1NQTd"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963E820E309;
	Thu, 10 Apr 2025 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269499; cv=none; b=ICbvWLWaR7y4BnhNSR68Kjf+xTEnZloQfdRdo7TquXonBEJ1w80+lggGQVBtZq/MCpIvHVc49g20OomOWO1M1WEOJwKekW3NpePfdoGxUD+f6/KccWBKM5ODbVlSv587qm4+dXjPMbH0KETmGCzkx7585PAujssWtbv2vA3Zws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269499; c=relaxed/simple;
	bh=5snIeQHYhrmxrByOJHCnvEq6FwIapMi+d6Of6zeuQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivEOhXHXUwiPSFLGullT0nrB9pylvC1hV9LQhF7ti/NuafG1BGGqNZ8So+r7UfTJeboOzGnOrtKY1VTl0gaHJIUjrKZVMrt5Wltf0zHsnX5H0ALVSl/LlQ7U2F5wc5gsIdH8UPj8l6NxFW28nc24Ag6lxmxGy8rwIRqrgwxCTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=IaB1NQTd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269484; x=1744874284; i=ps.report@gmx.net;
	bh=5snIeQHYhrmxrByOJHCnvEq6FwIapMi+d6Of6zeuQvc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IaB1NQTdfMV9ExVaHpEvFNRtVGp/EugHSDlFQOwUeaR2FHT55AGniPbNd21LyrFp
	 Zl7ITa5uTG7dYe0k3orrq0QPPYiKHQSFUc2wNEv/irc0I0KCyyLnGgnoMQRRun1w1
	 c9NSOvX0pN2hrYNji8DcPZyBtVJS6x+LJjEYWtIw4IZeEnFk/zNMh73OFLZy2EDaF
	 D/nk+8006aUW5EVLAq935kAH3EV90KHrZs76zOIOi06uWESnE/zAR5HlZWGDQ0K6z
	 9FgHmA2H2WZC4X4PXybhIUTHczfNs02iE0oSdZOVNgP/qogVNq+RUvJSs8l6afgIU
	 Im88zIF6pKhYi6wY+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M4Jqb-1u2VBt0QIz-000U1r; Thu, 10
 Apr 2025 09:18:04 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 10/11] net: pktgen: fix code style (WARNING: quoted string split across lines)
Date: Thu, 10 Apr 2025 09:17:47 +0200
Message-ID: <20250410071749.30505-11-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:cShGLuAELr5fW8iK2NyAiJ8p7G5Io6wMAFcctVfirXqUKO7xwpC
 DxHIUgM9OnpPDRAbRqDgL5HdfmqzxLPTwYdJ/hSG2M8BrGAXwwZA1jFHI0ascko3eofeQtm
 eRR7bjR6OR2ytOtXW1q7foiasn4QN36ZQL0YZIvzSOhaHaSD3VMlBe4+FK77IOhs+BvH5QG
 CsHcBFT1ADmqLTT2MNsdA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0gsCMVcZOzA=;zfdve+7nc45L0ygYqQ0PFQXWFsp
 qYb+NYAPvwAeKUrc74xO5t+jhkTfDtY6WGPe9AMkuolml8SnIVJMIQrZSKANw9XcwzCPVdeOV
 61xz9y6P/MkroxB6TEcWPuNXhVav8DooCPVBIvBEB3eFaYsxcz+1+YXuMO9gpuqF4dl6cRmFh
 bIeeQ6s2TjY5eY4tWwAIF8khOFg2TMsCNZ+HJWcNH+MSmoVwmSKfdBiI4zEPnjd5sIaya/Ozw
 EmUEJOd2ziyFZYPBc+dB63/c9khN6hh723x0O4F5+NtHij4xSxLkqNsRWOPUvYuYaA8rk0ERO
 iOII9LH2FFTcV6bhrZtPS91hO7wxa+SXbFwdrvEEpDy+94iMF5nFmpcj+ork6a1k3kF9aZO3B
 xWdhfdqjp3zmtDaS4P2lmEYjr2NVbNZj7JJNzaLVDWSWoTQ+Syo3pb66ASrIoBdlFf/7mM72e
 WEwYPoZqDmcUUW4+Q2iC1XVHtHLTNr7er7Bm1RrP6s3Ap6kJAehZ2gTPfPPixxeZSBEdnDBbm
 dRt86i0Jqf/T4JgxAt59P8e2kcovmb17aboHmzZAOVWL6St027ORU6KOZPxPjad5WGcVxXPs1
 BNFPV1RN5+mNv2MsrVpaRbJ+PUKBs/2BYWusSFBGZ096IKGT1vL58Y2un8NtuFcwgYIX459cf
 AvC9Us9JulwJaYMRkkpM5cBwVfTj8mpkouxJnZhm+V++xBk3bCB773BrgT0yGSZ3yK6xhoVZS
 HgSMj7HVX/Ymf+PZ6hYr5I7eGnatpmBXHrY9YLOKhWLz15sZyEjtCmdyiuwpCPX3RMg/KeU36
 lKdnKewf9zrdck5BWHTfrZmi6o2W9j/a5whkS9i5r3SAP4rGIjAnqFVHpCA6Noaqi1XvB+imt
 wbBE6z8NI+6lI4GX/3STW0E8qJZldD4/KGpMR9uk3oYz+PaeHGlZp2ew8AGnUQ70jvXRAc0CH
 Yld/HlhbOUzpzMrEEWmTXSZpgnp+SCTHbGsdtP5Kw5fswG2Y1lgXIf9XRZPeatLluxI0Opk0G
 6Kxy9pGHSydG1SOdZBN9U9outqc54KZVXLcQqcQO02Gv0HCMLYBVkSef/odNx0XHBdwpqX/57
 coiyMI2Yl488cUrnOIWC0NIzCwln8qrBWeRGTdHCN+ujBzCVRmdpyag4VgnkounLWJYvOksZo
 KJyNoVr7KFaXvGRBD3zus+M9evVnm8gmxDy0KLEaOeR2QPqgcq+gYye+hQ9zfSUXfpRKScpCm
 n4qN5eCK2R2VKfBxZmsP4xtpUuWcfUk2aWmfu2hczZnYxXMvUTwvP5doHdm+gTqC9m8a8ZFR8
 iCl9WRjty6Dc6b11NMXr4HnIIoVuFXPpg7CP0SrtA6Cd+ff2y14Fqw2xbqB7NhjCgcnnjB0zK
 rGHjxAQsi8ZTWUg7wHldzzY4635vcqoZC6nwR2lBOFJOE+Hz0jtrZU7T/TfEkbH2gNavBHwwO
 MdkrDonQohaMnLckp3jGUhRvhgDA=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogcXVvdGVkIHN0
cmluZyBzcGxpdCBhY3Jvc3MgbGluZXMKICAjNDgwOiBGSUxFOiBuZXQvY29yZS9wa3RnZW4uYzo0
ODA6CiAgKyAgICAgICAiUGFja2V0IEdlbmVyYXRvciBmb3IgcGFja2V0IHBlcmZvcm1hbmNlIHRl
c3RpbmcuICIKICArICAgICAgICJWZXJzaW9uOiAiIFZFUlNJT04gIlxuIjsKCiAgV0FSTklORzog
cXVvdGVkIHN0cmluZyBzcGxpdCBhY3Jvc3MgbGluZXMKICAjNjMyOiBGSUxFOiBuZXQvY29yZS9w
a3RnZW4uYzo2MzI6CiAgKyAgICAgICAgICAgICAgICAgICIgICAgIHVkcF9zcmNfbWluOiAlZCAg
dWRwX3NyY19tYXg6ICVkIgogICsgICAgICAgICAgICAgICAgICAiICB1ZHBfZHN0X21pbjogJWQg
IHVkcF9kc3RfbWF4OiAlZFxuIiwKClNpZ25lZC1vZmYtYnk6IFBldGVyIFNlaWRlcmVyIDxwcy5y
ZXBvcnRAZ214Lm5ldD4KLS0tCiBuZXQvY29yZS9wa3RnZW4uYyB8IDYgKystLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL25l
dC9jb3JlL3BrdGdlbi5jIGIvbmV0L2NvcmUvcGt0Z2VuLmMKaW5kZXggNTY0NzJkNTYzMTNjLi4w
ZDE4ZmQ5MzJlZDkgMTAwNjQ0Ci0tLSBhL25ldC9jb3JlL3BrdGdlbi5jCisrKyBiL25ldC9jb3Jl
L3BrdGdlbi5jCkBAIC00NzYsOCArNDc2LDcgQEAgc3RydWN0IHBrdGdlbl90aHJlYWQgewogI2Rl
ZmluZSBGSU5EICAgMAogCiBzdGF0aWMgY29uc3QgY2hhciB2ZXJzaW9uW10gPQotCSJQYWNrZXQg
R2VuZXJhdG9yIGZvciBwYWNrZXQgcGVyZm9ybWFuY2UgdGVzdGluZy4gIgotCSJWZXJzaW9uOiAi
IFZFUlNJT04gIlxuIjsKKwkiUGFja2V0IEdlbmVyYXRvciBmb3IgcGFja2V0IHBlcmZvcm1hbmNl
IHRlc3RpbmcuIFZlcnNpb246ICIgVkVSU0lPTiAiXG4iOwogCiBzdGF0aWMgaW50IHBrdGdlbl9y
ZW1vdmVfZGV2aWNlKHN0cnVjdCBwa3RnZW5fdGhyZWFkICp0LCBzdHJ1Y3QgcGt0Z2VuX2RldiAq
aSk7CiBzdGF0aWMgaW50IHBrdGdlbl9hZGRfZGV2aWNlKHN0cnVjdCBwa3RnZW5fdGhyZWFkICp0
LCBjb25zdCBjaGFyICppZm5hbWUpOwpAQCAtNjI4LDggKzYyNyw3IEBAIHN0YXRpYyBpbnQgcGt0
Z2VuX2lmX3Nob3coc3RydWN0IHNlcV9maWxlICpzZXEsIHZvaWQgKnYpCiAJc2VxX3ByaW50Zihz
ZXEsICIlcE1cbiIsIHBrdF9kZXYtPmRzdF9tYWMpOwogCiAJc2VxX3ByaW50ZihzZXEsCi0JCSAg
ICIgICAgIHVkcF9zcmNfbWluOiAlZCAgdWRwX3NyY19tYXg6ICVkIgotCQkgICAiICB1ZHBfZHN0
X21pbjogJWQgIHVkcF9kc3RfbWF4OiAlZFxuIiwKKwkJICAgIiAgICAgdWRwX3NyY19taW46ICVk
ICB1ZHBfc3JjX21heDogJWQgIHVkcF9kc3RfbWluOiAlZCAgdWRwX2RzdF9tYXg6ICVkXG4iLAog
CQkgICBwa3RfZGV2LT51ZHBfc3JjX21pbiwgcGt0X2Rldi0+dWRwX3NyY19tYXgsCiAJCSAgIHBr
dF9kZXYtPnVkcF9kc3RfbWluLCBwa3RfZGV2LT51ZHBfZHN0X21heCk7CiAKLS0gCjIuNDkuMAoK

