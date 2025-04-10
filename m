Return-Path: <netdev+bounces-181110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CCAA83AD8
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF58C7AA82E
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE2420AF7C;
	Thu, 10 Apr 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="rUsy3Vsx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64421CC51;
	Thu, 10 Apr 2025 07:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269507; cv=none; b=cdQZg75eafAwn5INyOF4fp/sLm6itQza9TpDHvCDNGePZTAnWk5ghsK3TaFaKNxWAfFbBnId+/xu/ytEZnI3mz1Pq3mUk0Xbdqnw1Mlg9DE98jOsCNfHLtRxkuInSAgjgEXhhvvMSD9GqN1wJLCidhR3OZ/Ns0G1FQYyE3NycOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269507; c=relaxed/simple;
	bh=jAPDXbbnOMui6iJert3qx26bwyEH/LXDawHVAmrL5/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X8a6Frw9bneNbmqAbZS7ZIXEIlCkhQr5B+84dOZ7yAJXLMc8THXAbFNaUZoTepkLhNOaFvqC2d14Bnoh6wAjlBL6tdQDCs04Cwx4Ak28aqegGXiM9WbMAEmxMKI1TGJowe7UJLaw3lQ3t9FY3bzpDet6AQ0KwuNghjBbn74lA5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=rUsy3Vsx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269482; x=1744874282; i=ps.report@gmx.net;
	bh=jAPDXbbnOMui6iJert3qx26bwyEH/LXDawHVAmrL5/I=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rUsy3VsxHuuVTKSNWf6+KTkTWZpaRylF5oXNg9uTP9W17LGD3135Nk8tajBSZHBF
	 UvVFPAXrWh23PPFPXgoAX5Qy+u8F3teWNDpXHTMxmSo8vWGomjybYch0gU12gOON+
	 teR68BaqhlaMC68cIjKGEs9dcjFiL1yv/sQuN5+roow4WGDmJjhzy5tAA3k5zc5dj
	 EnVrShb4zRv1WuJjxWImtyKmgbkM7wxccEGDzsEDu2NjHQSurtyQ5s3+u8/afiQW5
	 bQWoA0Cdtzrv3//d9sXsJUMgVV0Xt4dsp1ERsQWEDVqwNDMmebUXbgZH/RPv7be+m
	 rwL4EvBKLM8atH9ZBQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1u2ECu0Cmo-000l0i; Thu, 10
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
Subject: [PATCH net-next v1 03/11] net: pktgen: fix code style (ERROR: else should follow close brace '}')
Date: Thu, 10 Apr 2025 09:17:40 +0200
Message-ID: <20250410071749.30505-4-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:vOwXFYa22EWz3upkIUKaSb723sCTwGF96PpS7MMJVNzAL6wR+yc
 pyaombuj69YfnHsqW1czMoXxWW8mnMW3zNKIexpL9waxOSiiwSRzmEOK8fmMzzqCbF8kz7G
 OqXY6xpUfy47BkW/rI9l+bQPKvngW5ahvb/06vpNoa9bLaY7CaDuOZDkRE58+JOosuYEEqh
 TRZ7wpwyf7wXafDCZn7dg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:m5MDacci0P0=;DiafUh+Xgx8tM3fB+SEak5pNe1c
 uLSt7wm8giER5VK7doGQklC82/qjggo7XFJGHhDlD78w+qWp4x1SzGVfpEORzaVGrmdsvI4iO
 x/jboJilZiN+PXNiZOiYywCZn+K4W0xl5Zye5+JWweKabD5068gUfMkXZMdAbQM0R9V4jacsf
 EFezso+vyLtCTy7swuONRBHx12FvefUQ17vsHxNWZH+LeIhnm5CKYTWm6e+U3pn++DO2Qwy1y
 6tj+LzrLx941Mcyt73O0W7bqY732hYPmsvjAH2detzFAO4hFSvcS21YJpVxIZs6gh48Rqd08j
 /+AA3RaPApBiDx10rvmCb7dwdz7wifIwAsn9wjtajlnKlj7PRcW1+zlXFZuxgORFdmHmOOWx0
 Tl8xUuGqXyvtD/P03DCqyY/OnwlM0O0xJceXX4bkrPfIDptoaRALavUfk9EUSrzV1seDWfIpz
 lCEf49z9wy6pATs5SPSttx2NCh0yR693/iSxTfJGLqlFBC+x2fso5W+x/xNyNmLJFCavFOJcQ
 Aqat6Sg8aqr5+tYLBweFhtyrAi9oNqZhe49rnmtdkZgoe8ese8b9alYIhSM1m7iZz8gviTOee
 qh2gL6ttgt1ianc2MXTNu/xdi6Nw9DFmCZMU1bP3OOYFqItScvt6tR8EuOEbujfG4ytYLm2xO
 4PgUSjVX0aabx9KHBqFY74PwjpRbB0bFbg+7U60GJd2mf8LxWg7xh6N+qFO90Jg0Ksx/SGuLB
 0km9v7wKhBAFg01YLSQlULX6vJuo5jJwG0qJbz3KyyLpokezWp1j1gwPK9SahSqJP1SN5bLhi
 Tz7KXVHpgpi8P6iPQwMea7SNtBhsUn1b6ADKGcb+42WHjWgqCvQotYCrRwJ8YWdSATHzE0rI+
 1L8JEzkbCdPLixvc8d+pJsLB8CFRhnwsyBmocCBw2PGdDKGO3W5mdfvQrwsD9V2HSKZ0F7Nlu
 yMpX+8e6pYkozcFUvQkn3ww9gVV4X853YW3tU+9z/agGKAg/HEwabZ2bC3XFmK8PBf5P8ZMiy
 gZlBeH6goomOQpZu8FexC7XdQdwbwevpXS+A1K+bpUj9d+QxyjBd/hTQ1QVh5cHMumXx9URNn
 P87YSy9pWc1rNA0KPcJC9BXvZuGC8UxMUFNq9P2vCvpvePjGsq6kjzjjeA/9FJeQy6pRUU7c0
 40PbWu/1t/l3S2Vx2RCmRrFWpco+nzACMs74AaghRZgRbwZJjNG6ADdnd4PEgrjRSiexhYPvS
 KSULHGncLxrDjKjEauu0CdkEnq2LKq+SCa8SedrxaToWxE1NaPUAyhbB1jhPkK3ttHKh9Sfkq
 nMxUcR9RhtYrb5Fwhb5r1y7tIyn+EiHXKrEH8HTFcKFZka36vN532wyvvAje0m9IGJPloETtX
 D0gZ+yDpBDvfeFZMPH5kBwkqmCHSgmttho4qg5kxXIiTuOeC6e19WozFQxEjgprdPQI5HNwnk
 RLzkKeIo9+iGiKgulrI4fVpWWGKQ=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSBlcnJvcnM6CgogIEVSUk9SOiBlbHNlIHNob3VsZCBm
b2xsb3cgY2xvc2UgYnJhY2UgJ30nCiAgIzEzMTE6IEZJTEU6IG5ldC9jb3JlL3BrdGdlbi5jOjEz
MTE6CiAgKyAgICAgICAgICAgICAgIH0KICArICAgICAgICAgICAgICAgZWxzZQoKU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgU2VpZGVyZXIgPHBzLnJlcG9ydEBnbXgubmV0PgotLS0KIG5ldC9jb3JlL3Br
dGdlbi5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5j
CmluZGV4IGE1NDY4M2Q5ZDQ0YS4uNTBlZDRlYjc5MmE4IDEwMDY0NAotLS0gYS9uZXQvY29yZS9w
a3RnZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtMTMwNyw4ICsxMzA3LDcgQEAgc3Rh
dGljIHNzaXplX3QgcGt0Z2VuX2lmX3dyaXRlKHN0cnVjdCBmaWxlICpmaWxlLAogCQkJCXB1dF9w
YWdlKHBrdF9kZXYtPnBhZ2UpOwogCQkJCXBrdF9kZXYtPnBhZ2UgPSBOVUxMOwogCQkJfQotCQl9
Ci0JCWVsc2UKKwkJfSBlbHNlCiAJCQlzcHJpbnRmKHBnX3Jlc3VsdCwgIkVSUk9SOiBub2RlIG5v
dCBwb3NzaWJsZSIpOwogCQlyZXR1cm4gY291bnQ7CiAJfQotLSAKMi40OS4wCgo=

