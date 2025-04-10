Return-Path: <netdev+bounces-181099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D5AA83AE8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2CA8A4F28
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6320B207;
	Thu, 10 Apr 2025 07:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="enjcfm23"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E20205E0F;
	Thu, 10 Apr 2025 07:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269488; cv=none; b=FHk51ViC4rX+680q5QFXS/WkCa2njgrC8EC8702T8gtt8Ryj0paP8SUaSqJGQYYEKhvGFHDKmzOjHP8ikUcg43gKdMm2xgXR1CDNAPT0AlLGHrNOU8OJ3hnyDyDXPi6WDKsUC1Za6UxC+DKOkuJU/e6I/wD2HCSuSUTxy1Im/u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269488; c=relaxed/simple;
	bh=Hgq5oFqXjkRbkUlIbSDqwNERy8+yX/nYxw/Zqsyei50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IxwWxIJdDz5Y7xZA+F1bRpZZqgIEt/OggR6WpUExUhi0kgrgy/10kBwg+IeXgykVSgxqOEqMxQ6LsyjCYpRzOJ0i1Ay6qeuwHRLc83IDkiBV1IofF+8jv7bFfFUhcdYOfcAEhpb7FH9Z+oAaDpvu9AgSO3qlH4Bkp8UuaCmM1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=enjcfm23; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269482; x=1744874282; i=ps.report@gmx.net;
	bh=Hgq5oFqXjkRbkUlIbSDqwNERy8+yX/nYxw/Zqsyei50=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=enjcfm235AM9EF971EepM0WAxN0kVRivPMFJMCQWMSwDG/DbTm2kwWRbKITDtevK
	 /jjPVdsmwYzfxHQijsOTJ76l0w2B3tRnAnocJx2mrTOUUyr7r93CGPvqffVLgWLWD
	 mmD2z5RIxdV1IX5o1RuXfohNBEtrghdEVUPVcTyHeX8+0SGDqLn5sn0q/Gx5aOrGH
	 gRx6SvxOmCieFr+pTPHfobdUgoKVBlEQLLY9A2YuqEvq09hRSoGJeKLnf/FygQx5e
	 IfYIyjAEF93hvYoDbyAVULO0i4Dz+gT3j3Ifvsqgr1ENdG4Pm1UaWM190fZJ63xH0
	 KTWw9QeqkZOlfR2BHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEFzx-1tsZYd1Ve1-00AQBD; Thu, 10
 Apr 2025 09:18:02 +0200
From: Peter Seiderer <ps.report@gmx.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter Seiderer <ps.report@gmx.net>
Subject: [PATCH net-next v1 04/11] net: pktgen: fix code style (WARNING: please, no space before tabs)
Date: Thu, 10 Apr 2025 09:17:41 +0200
Message-ID: <20250410071749.30505-5-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:ND2vOrofi8JmxmlRXSCn9zJC6mlcvE4uh29qu8HYLH2KSAM2WfC
 xI1w7r/cOOlUNR3kRyYXc8gXNYAiERBFobE1kzdKtydluUFGlLkYS0R6/TcyPN8vXFnqpEs
 +RE8HzwzIPF6KGHKBM4BhILw3LBYHUy7tfh9w6oxecyyQftEFwrp/fYqZqS2+KWSHFj9CWr
 c6kKk8wsj+pZ/sct2wcWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cnMXTjEx9CE=;hNhQB8Y7G/NO14hk/TsM2lwlRom
 uH07s/E4DBFZBnQKV7bJqn3oRe8CtQWdtIaHtGSfSoMyRwl1O3Ely3a/LF8arXVXUHMRIQ8D/
 Gi8W3FC/wPeims8HzcVOLV3PAlMR93K8/XQ6DHtm8UyK2bPipYUR0qUYJ4OfNmvXYiEIdRyTi
 02u+Nm+c5/fcyXj4+5f4RYRdUKctSjOXWJ/5b1RQDP6MeTR4Q9YPayna4e1ZtsifF1HbiDSGv
 kdmG9PEqa2yniPmJ+8KNiqtuKpKBQfIxXg7AxtTOuaO2K1hs33J4s6fysuipm+93gTfzSzDvZ
 tMUCh0DPXPiIS5l69MltvlqTNIHEqG9OlyLZpyVoce5H+ox2OW7tbDL7p0gDpiKvavKOh2z4r
 I/I0ITQxD1OZbGawUb8RvcTwjREkXINnBT48UZveQV0Tqa9Uuj7RfP4Nt+bDzPDuGoBHXgavg
 JO/GbvCmvxzoh6oGZt3eOa2Aqqp2yW5NS99ZFtB86YZAjP9inw7TgkuiSwEkhbBo0Rj2iXLIT
 alg4tyc2w8DuuDZv6zdu6UldGbLnXM5LQ0VdlM9Gmtfi4o73Wx61D4grYwXOFkkX2KJDkqqN4
 6Qe0EM/CGb8Pb71ZqCjvpeYjuo25AcylQdUK24mk/oCfC+0Pq5Bo9R+ec4et4kIV6svTMwPFO
 r/tnyur7wqRUS0rzUmAmr0/817sGHQCsgLNYVIl2N9/2oUtPzDMtzzOC1xBP/HFfhHJXvsteT
 FPuC7G16GyURJOhMdieDzOc1/DUkOy+eANnGhRJkA5f1xjBWCd2AZRig78qwHLIwccaUOymf0
 oBLinW4Ot++hpScmLsEJA94ZiCTuxeHa8XSYPTg/Frk6IYTh8SvaR4AgCQGwpcliTqwnRmY6y
 D0R4w+Hsmq7LVCEIBncOjOicuKkqrWuJi6nJol8LO3KH7L9re5sUnnc9GBQC5AgoDBXKa7mQl
 1PgWn6YHtrNYneOKNpL+C0444L7uLktC0v/wuGo4datgVTQDMrIm2Xq4v+HRl3yODsBgoYYef
 Y7fp4ndSytH0Uo2YVsAdcbp5HXqyzFxIYxGdGK2Jq+WzFqya9kga0KPr6waDnyJ04sDQJK4Vp
 JfmgzZ+mzm5NM6zAtB0yEXdcHftNFlquZFJce+2V6ekapvhEZg2mnGBkFwFAJJzqkCJVF+yMR
 8w3mbCGLiTvVMxkC8+5CZE5xZplgLHWrxIUe/odz4wkf1Dqlg97upLQqy1XvN9fnOvNFa8kdF
 /But9SOhzlrCdWzuNHbhKI5pJ7Ewe9xvSphDgoTOa1mbFfLgngqWtOAUHi4fveunfcM4PYHLR
 5cUjhMSTftSir3vH35ZfGwz9k7dbEgYKCPkhIr8ChW/rRuuTb5ohpQF/oqkRPq+Eg4UG1itlD
 OhhG1tziFeyVCPlfFeo+1bh/FCm/HxU1+ZSL2092mf9Z7vNhvrAfpuL9fkTWkyOKCeBbr+ul9
 LTpRoUCo7kcZWHRqL9fm1sl+qbaE=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogcGxlYXNlLCBu
byBzcGFjZSBiZWZvcmUgdGFicwogICMyMzA6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjIzMDoK
ICArI2RlZmluZSBNX05FVElGX1JFQ0VJVkUgXkkxXkkvKiBJbmplY3QgcGFja2V0cyBpbnRvIHN0
YWNrICovJAoKU2lnbmVkLW9mZi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0
PgotLS0KIG5ldC9jb3JlL3BrdGdlbi5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvcGt0Z2Vu
LmMgYi9uZXQvY29yZS9wa3RnZW4uYwppbmRleCA1MGVkNGViNzkyYTguLjc2NmM0YTE1MTVmNCAx
MDA2NDQKLS0tIGEvbmV0L2NvcmUvcGt0Z2VuLmMKKysrIGIvbmV0L2NvcmUvcGt0Z2VuLmMKQEAg
LTIyNiw5ICsyMjYsOSBAQCBzdGF0aWMgY2hhciAqcGt0X2ZsYWdfbmFtZXNbXSA9IHsKICNkZWZp
bmUgVF9SRU1ERVYgICAgICAoMTw8MykJLyogUmVtb3ZlIG9uZSBkZXYgKi8KIAogLyogWG1pdCBt
b2RlcyAqLwotI2RlZmluZSBNX1NUQVJUX1hNSVQJCTAJLyogRGVmYXVsdCBub3JtYWwgVFggKi8K
LSNkZWZpbmUgTV9ORVRJRl9SRUNFSVZFIAkxCS8qIEluamVjdCBwYWNrZXRzIGludG8gc3RhY2sg
Ki8KLSNkZWZpbmUgTV9RVUVVRV9YTUlUCQkyCS8qIEluamVjdCBwYWNrZXQgaW50byBxZGlzYyAq
LworI2RlZmluZSBNX1NUQVJUX1hNSVQgICAgICAwCS8qIERlZmF1bHQgbm9ybWFsIFRYICovCisj
ZGVmaW5lIE1fTkVUSUZfUkVDRUlWRSAgIDEJLyogSW5qZWN0IHBhY2tldHMgaW50byBzdGFjayAq
LworI2RlZmluZSBNX1FVRVVFX1hNSVQgICAgICAyCS8qIEluamVjdCBwYWNrZXQgaW50byBxZGlz
YyAqLwogCiAvKiBJZiBsb2NrIC0tIHByb3RlY3RzIHVwZGF0aW5nIG9mIGlmX2xpc3QgKi8KICNk
ZWZpbmUgICBpZl9sb2NrKHQpICAgICAgICAgICBtdXRleF9sb2NrKCYodC0+aWZfbG9jaykpOwot
LSAKMi40OS4wCgo=

