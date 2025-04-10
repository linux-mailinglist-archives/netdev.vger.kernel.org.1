Return-Path: <netdev+bounces-181104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CBDA83ACE
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 09:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAE7B16B562
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD320E700;
	Thu, 10 Apr 2025 07:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b="oe6ErT8p"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE39207E17;
	Thu, 10 Apr 2025 07:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269499; cv=none; b=QLnPg2yK1ttfl/dXrr9LndS5YpUdm1aIh3Vnzf+HJnSt9Hzrl2n5Rcke8b8sIgYQ2vd2RIyor7vs0fAELaUNJN3fIlPM/bo3YgXiG+oPWe2bqsywm6W8tF75MJ1mfUp8XBP4RESAP/zAjX82n3/4PiHUljQmrCiRbeH/g3zSmcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269499; c=relaxed/simple;
	bh=654WS9Anirx/zCI0C0fiytG5Li7a1695HnpYwZUGJAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jy0B3gyr0aRJa2gCDvszj/O1C11b/hb99bTk/P0sx7JZkY4a0SilOB6plhkAvgBOkLjK6+gcakDv1Sr7qc7mUAbTxmKGosXgNVVu6WSxqRrGLQB4xko2i9CyHkeOTqDhgzRjPqwt4D43Ia0PaehrqBM4GRDzsG2xZEbAcRBd4Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=ps.report@gmx.net header.b=oe6ErT8p; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744269483; x=1744874283; i=ps.report@gmx.net;
	bh=654WS9Anirx/zCI0C0fiytG5Li7a1695HnpYwZUGJAg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oe6ErT8pMfudNrU6tuPJg1fRiilaDRkBFxI9YUvBp2vLk5jTKyw8r5uqrZpuz3CS
	 Ay4h7/8WyDXd3I+95umcy3i64fdGlsT2a/PZalupwCeAoNLHYEqjBBI5/nIaoxcsg
	 yfV/Gg06drwVcuKIyBwHBjJLmr8WrKULdqfVujvrg1fm/Fl+HPguTAT14w0JKWVuy
	 BLvG6UeeaHfPnj1/vekClhdefzPlM6r572qjkzs9mzn9ralrFY2JlX1exIuStdnrA
	 6tctqmBx1ZUkp6qt1DKUzvgLvrvzWbGam4SpVCsWRiKOfhtQl/3gxhTHYjEfzoZ/x
	 36d7rwi9aw839sFhdQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.fritz.box ([82.135.81.74]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O2Q-1u3LCX1zbi-0044Oa; Thu, 10
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
Subject: [PATCH net-next v1 08/11] net: pktgen: fix code style (WARNING: macros should not use a trailing semicolon)
Date: Thu, 10 Apr 2025 09:17:45 +0200
Message-ID: <20250410071749.30505-9-ps.report@gmx.net>
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
X-Provags-ID: V03:K1:hWjbZCNQv5uqVklpaIo/DrtDXyvjsW52QBLHbHukE+gLC14LeQh
 MJYcQ513szJFt/iodZTGwy4jbaOca+DwyUTu/k1vj7HvmkCReylQxwZ9Zwo/GrAiPlxJmPS
 mTaA49sWpz6ds4qrMNZFxUKFYmQsLoxuH/tS5pBdI4Rz9DGereKAuX8QNbey0Ya6kmmj1fb
 F2WzBPPHj2a3png6OEaGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BTWyb3gJdzs=;Inka7+cAO8Vd/gaxRgou7vzP/R+
 E+U89vjvvwj8LNop29SDDM05doV1IGgE+hFOZiAhKLB4/cr/tAy+k0kY7UPuTlDwLTGGV9GsP
 IEOFdjmTRGk0a0us2nf+aiFyBCdfGhswgfvbIDsk+hvFIPHV2aJWxjqRGTzzE6Tb6/q3Qbft+
 DxIbuT15MUYpy9hVWzhcZ3lUCuba1Xtf2QutXAlWbXFLTNgzYIkMY567fVj+O+sty6pLlNFmf
 qTSFXh5USib+OpPHMz9Xo6ENJ7BAuM893KQLn9kSYRA0+t2eVHvR5QfeafCXhw+pqkUlq4L3A
 gf0iPbZmuHwUecaGwNFRuNuL16mmYY/2jzjPjxD6ScrZ9Y2tcLH84uo2lYnYDxxiXDseXLmMA
 dwHQoI46MHh4WoxrmChQJ6Ir56yjXho42BOms17NDdqnJp0q2rcWExkmH3uXrkWD1G5X0/iD/
 TPude3dKniUfQCtqLXI+YtZaKjS71/bAwyGv1ywBd6FKZ4MCtANxdBnWHPX7acrw9KPLhH8xk
 mb74rQ94x4NYWIZxcYXf/3Zvsucen5glQ/Uo1wHRTQ1ZZcbVVb1Z0WixK3E/MX1ayHV21aQPN
 I3rJFaq6hsA9HIhJ3k8rFZlNMJ6Dv7IujkzSzC2AMnnRW5VDOsCmhmWRYVsy4bP/1w3wlXdpS
 sZXpyED1oLVXPRDw6QIJNXWtf5dDSAXd+5dkLlmkBafIWOxICvCHjCNrgydMhK8dYVwvlhUlH
 wJBYFozwi/Zja2gBQCTURSM+CsR4zrb94SR8zgBzjcxTY35M9NSbAmPphwn+nX57vFj9pLSo1
 9bdW4Ye2dCtN7e36ugmtT3tarHEzGlL3RVunIYUXQsYCThqOh7+hjtIS7mxEQj2ZKU0h+DEjX
 u1CJ1bFzmZ+pOzmOClWJA3ZhKaffDYR1vS0HNUB2cRZiHZie0yJ6TsDca3RRzU3pzUAQ/lvtH
 onXndFU9pIOa6Mr4EZr538Objqhc0DQaC7KKb8501secIjZXFyNC48H0TtGUJOD4TSwgND5Yq
 h4ntYEjAi4PgfeaGVOWANfU8Oo9fUPUl5Xn5ZQ9FgJ4rHnWLgVGv0b8wCvl5OBH0rwuxVuvgM
 mkyLwzeFCgT+216wtGSKreJ1DjwYBo+wvD5fKwV/55M0JUlYs2nGvwF0wYkCARUtmBwauWrtW
 r2U25gv46zDyeH68mx2/Mkq9N3+aBX0pHCbij7pK54VuoizWtaxkiTXsTR8YlOmwhK/6o20er
 3Y9MZx5IX2+f/SVC60l9IJ3qd8R1dSX/vzDjud7zCMHy9DGOOgfqe70LEQcTc9oBxknk3HPXn
 ueAevr/ciY3rtlKyTdlWAETF6rFWHAmz2YpOJfL1RtNWPmysLnK0ZCP6npxpWxHKODtHLHOdc
 u3ayhzor8bBF9f8EkayKih5vIF/J6FaZhVSL1Hoy90HVfRdh2EejUTmMmNgmpgLa6bnj5n4u/
 JAhk8U/vYwVNuOtP7SFZY+zoCe88=

Rml4IGNoZWNrcGF0Y2ggY29kZSBzdHlsZSB3YXJuaW5nczoKCiAgV0FSTklORzogbWFjcm9zIHNo
b3VsZCBub3QgdXNlIGEgdHJhaWxpbmcgc2VtaWNvbG9uCiAgIzE4MDogRklMRTogbmV0L2NvcmUv
cGt0Z2VuLmM6MTgwOgogICsjZGVmaW5lIGZ1bmNfZW50ZXIoKSBwcl9kZWJ1ZygiZW50ZXJpbmcg
JXNcbiIsIF9fZnVuY19fKTsKCiAgV0FSTklORzogbWFjcm9zIHNob3VsZCBub3QgdXNlIGEgdHJh
aWxpbmcgc2VtaWNvbG9uCiAgIzIzNDogRklMRTogbmV0L2NvcmUvcGt0Z2VuLmM6MjM0OgogICsj
ZGVmaW5lICAgaWZfbG9jayh0KSAgICAgICAgICAgbXV0ZXhfbG9jaygmKHQtPmlmX2xvY2spKTsK
CiAgQ0hFQ0s6IFVubmVjZXNzYXJ5IHBhcmVudGhlc2VzIGFyb3VuZCB0LT5pZl9sb2NrCiAgIzIz
NTogRklMRTogbmV0L2NvcmUvcGt0Z2VuLmM6MjM1OgogICsjZGVmaW5lICAgaWZfdW5sb2NrKHQp
ICAgICAgICAgICBtdXRleF91bmxvY2soJih0LT5pZl9sb2NrKSk7CgpTaWduZWQtb2ZmLWJ5OiBQ
ZXRlciBTZWlkZXJlciA8cHMucmVwb3J0QGdteC5uZXQ+Ci0tLQogbmV0L2NvcmUvcGt0Z2VuLmMg
fCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9uZXQvY29yZS9wa3RnZW4uYyBiL25ldC9jb3JlL3BrdGdlbi5jCmlu
ZGV4IDcyMDYzZjNmOGM2MS4uYTEyNjhiZTFlZGM2IDEwMDY0NAotLS0gYS9uZXQvY29yZS9wa3Rn
ZW4uYworKysgYi9uZXQvY29yZS9wa3RnZW4uYwpAQCAtMTc3LDcgKzE3Nyw3IEBACiAjZGVmaW5l
IE1BWF9JTUlYX0VOVFJJRVMgMjAKICNkZWZpbmUgSU1JWF9QUkVDSVNJT04gMTAwIC8qIFByZWNp
c2lvbiBvZiBJTUlYIGRpc3RyaWJ1dGlvbiAqLwogCi0jZGVmaW5lIGZ1bmNfZW50ZXIoKSBwcl9k
ZWJ1ZygiZW50ZXJpbmcgJXNcbiIsIF9fZnVuY19fKTsKKyNkZWZpbmUgZnVuY19lbnRlcigpIHBy
X2RlYnVnKCJlbnRlcmluZyAlc1xuIiwgX19mdW5jX18pCiAKICNkZWZpbmUgUEtUX0ZMQUdTCQkJ
CQkJCVwKIAlwZihJUFY2KQkJLyogSW50ZXJmYWNlIGluIElQVjYgTW9kZSAqLwkJXApAQCAtMjMx
LDggKzIzMSw4IEBAIHN0YXRpYyBjaGFyICpwa3RfZmxhZ19uYW1lc1tdID0gewogI2RlZmluZSBN
X1FVRVVFX1hNSVQgICAgICAyCS8qIEluamVjdCBwYWNrZXQgaW50byBxZGlzYyAqLwogCiAvKiBJ
ZiBsb2NrIC0tIHByb3RlY3RzIHVwZGF0aW5nIG9mIGlmX2xpc3QgKi8KLSNkZWZpbmUgICBpZl9s
b2NrKHQpICAgICAgICAgICBtdXRleF9sb2NrKCYodC0+aWZfbG9jaykpOwotI2RlZmluZSAgIGlm
X3VubG9jayh0KSAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCYodC0+aWZfbG9jaykpOworI2RlZmlu
ZSAgIGlmX2xvY2sodCkgICAgICBtdXRleF9sb2NrKCYodC0+aWZfbG9jaykpCisjZGVmaW5lICAg
aWZfdW5sb2NrKHQpICAgIG11dGV4X3VubG9jaygmKHQtPmlmX2xvY2spKQogCiAvKiBVc2VkIHRv
IGhlbHAgd2l0aCBkZXRlcm1pbmluZyB0aGUgcGt0cyBvbiByZWNlaXZlICovCiAjZGVmaW5lIFBL
VEdFTl9NQUdJQyAweGJlOWJlOTU1Ci0tIAoyLjQ5LjAKCg==

