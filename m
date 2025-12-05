Return-Path: <netdev+bounces-243858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 953CBCA89E4
	for <lists+netdev@lfdr.de>; Fri, 05 Dec 2025 18:32:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B686A3027A00
	for <lists+netdev@lfdr.de>; Fri,  5 Dec 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142133590A7;
	Fri,  5 Dec 2025 17:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/clH3w3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED83328638
	for <netdev@vger.kernel.org>; Fri,  5 Dec 2025 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764955316; cv=none; b=bgznD6MnyPvrOkimlp4SpROPUWq08HybSGlfWEypyR7kRW8eJZzGe+XL9sU0BLX9LpjwJkMfgaxkjm0nEjpw0hshSP/V4QXfw6kVsuuJawwQs5LpuVCma17f0As2hZddUmVPKYBEd7DeHmSN5aZmUILzwhb+g8xDIdFl82IrEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764955316; c=relaxed/simple;
	bh=B8PSi9jHUdjPhrF+sm3gt+m9lDpiWvOtpnckqkhHugE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=AFt3X6rSpfxuu/22HUwdVYAKa2vCI7o/vLxqf3wvrv0DehFju4XLH3ygU+cUqr9vPcT9RNau1Az2kOIG7wLnAQyQYjO/1EodZEXSuQsNXpVtYglxuYLXjI8LM4OMAXdCwVePRWTo9NJLDpUfwnWeoI8YnbCNHek6cD3ZTmOX6dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/clH3w3; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779a637712so18336715e9.1
        for <netdev@vger.kernel.org>; Fri, 05 Dec 2025 09:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764955313; x=1765560113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZCQZm4mibD//j04osocVMx/xPMdekYmVSEU/NvjAMg=;
        b=V/clH3w3uIOTGYGkb7an3O4+cwMS075qK/1+f10rOjALptRySopfAxwcmWGgRVNE7g
         x4ddAgKHGSQkkJGZM0vepxmZs7AUjCq/MQ5wZr11/HbovE4jjHlmloTa7ZzMYX+IpZJO
         P+ZhLH8T/ToOrqd2cprNFVWE14y7uB3aEMx19rHFkrzUO2mJAvWjriRRZp+o2RB06j28
         SWmXobJsm/iTSZrBuTogdjpxbIoyUPRpDD84HzTncN2Dt2w7oXpWlatzExRdU/1I9WRX
         l8p5scPsugA6Ex5oj0f17roF1QYygJ3ZmSaQs8FfSgrTdqSTs6IZcdUE7YxJbo9bVdAv
         D5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764955313; x=1765560113;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZCQZm4mibD//j04osocVMx/xPMdekYmVSEU/NvjAMg=;
        b=BuWY9BcX/qS5g+W9g3orYxl1DkJsZfDGKANnq3gXDe9Ok/zXJTtt6rLNWT1VPtWmpB
         Ph4WMBSFAjjEIp3I+Zd9eDLzJmi1Pm5p1/G3Fs8aFWJKeUu1svOT/XzD4VhJKiv1MhxF
         ZU3Li18bhO/ri0F005H1M0lWDjge+tiLT9bWdfs7g3F9pM1qFrSfod95CLkGyTQBsYx9
         NHDLbmoIcEEEK67BpF87Vb4aqNnHsshmEBc+ShLkKisAyZjk+AzVf/ScKc/bUR7aOlDe
         xA1KnqH+otNYRpxmL0/tvEfurh89XTAO3nwkEzcMOny0gyLUHs4PnbdEgXyi16qeOnQm
         HjGg==
X-Forwarded-Encrypted: i=1; AJvYcCW5dkJBt7mmgYem8O4hLKg6LTZAfJ/KuuiC/Pybo65beZJic8Q+UlUDbvLQk7eOWEMBgHgVepY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxACKgM963Ad6xx26nqMVmzy9jPllc7RVQjLmzHrTvJulXlDpxU
	RrmNzopBV45RYS7EVWf0CjvGq7dAufoVYcysqlGRj419EFwGySnpYUTh
X-Gm-Gg: ASbGncuo0r50YviuPCepoZOavUYq+pgqEPptMIHMJHDQT3CSJtPiH4u1y+LVnjoDAvC
	ulmsxwtMYGvz7xURASoLKyyaLTGh6FQMMTiAMCovupzv612Cn0dnb+rNFu4josNFqKhKJk7etrh
	P+Za0IfQB+xnJCX4q2As3CZiT4g9KUcb7IVQcn4NJMBjeL3BisqhXe0xNY5Q31ISgrdOOp8s4nn
	fBPWm5jHdA7htl6RWMmzOUYpJxqN9eZ3QK+J76rlbMWHZVuIK5+tEeANbOE41gBrbah26iIK9Hf
	IKVk8xdHGxHvzTg2PTuHcaaY6NyqObbAHNyOGBCG4XSeUcQCSqNe4Ai7nsLdybgmqySXeMztPHu
	Wmazqma2GlZ1qZdGC36wvB3JuDILyAaJwzivBCBkCc37CX+ckzyLrfVmzxAFD0KrD0UV2GE2IcD
	92Bz3ru5Hj12bebXwJgHHrfVsx+W4TsTQx6GiTsoAegW0VAXlmA9vIMPBnBhTZYm31vUbzUduFq
	PveLgghYyznRxq7CiaPaHJFNQHer1zE6Yb4lrp1qAWAhiakZmtXGQ==
X-Google-Smtp-Source: AGHT+IEm4o0h8b1j4bpARx7YuKAwXXTAp9EAESCVyno/gJt9JehnaUTIUnUp8aaB5eTEW+OITqbHfQ==
X-Received: by 2002:a05:600c:1e8f:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47939dfa53cmr462435e9.11.1764955312576;
        Fri, 05 Dec 2025 09:21:52 -0800 (PST)
Received: from ?IPV6:2003:ea:8f47:b600:41b3:37ed:a502:9002? (p200300ea8f47b60041b337eda5029002.dip0.t-ipconnect.de. [2003:ea:8f47:b600:41b3:37ed:a502:9002])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b156604sm61127675e9.16.2025.12.05.09.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 09:21:52 -0800 (PST)
Message-ID: <64533952-1299-4ae2-860d-b34b97a24d98@gmail.com>
Date: Fri, 5 Dec 2025 18:21:50 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH RFC] powerpc: switch two fixed phy links to full duplex
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Pantelis Antoniou <pantelis.antoniou@gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These two fixed links are the only ones in-kernel specifying half duplex.
If these could be switched to full duplex, then half duplex handling
could be removed from phylib fixed phy, phylink, swphy.

The SoC MAC's are capable of full duplex, fs_enet MAC driver is as well.
Anything that would keep us from switching to full duplex?

Whilst at it, replace the deprecated old fixed-link binding.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/powerpc/boot/dts/mgcoge.dts | 6 +++++-
 arch/powerpc/boot/dts/tqm8xx.dts | 6 +++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/mgcoge.dts b/arch/powerpc/boot/dts/mgcoge.dts
index 9cefed20723..cea9bdc65dc 100644
--- a/arch/powerpc/boot/dts/mgcoge.dts
+++ b/arch/powerpc/boot/dts/mgcoge.dts
@@ -153,7 +153,11 @@ eth0: ethernet@11a60 {
 				interrupt-parent = <&PIC>;
 				linux,network-index = <0>;
 				fsl,cpm-command = <0xce00000>;
-				fixed-link = <0 0 10 0 0>;
+
+				fixed-link {
+					speed = <10>;
+					full-duplex;
+				};
 			};
 
 			i2c@11860 {
diff --git a/arch/powerpc/boot/dts/tqm8xx.dts b/arch/powerpc/boot/dts/tqm8xx.dts
index d16cdfd8120..e582487d5a3 100644
--- a/arch/powerpc/boot/dts/tqm8xx.dts
+++ b/arch/powerpc/boot/dts/tqm8xx.dts
@@ -185,7 +185,11 @@ eth0: ethernet@a00 {
 				interrupt-parent = <&CPM_PIC>;
 				fsl,cpm-command = <0000>;
 				linux,network-index = <0>;
-				fixed-link = <0 0 10 0 0>;
+
+				fixed-link {
+					speed = <10>;
+					full-duplex;
+				};
 			};
 		};
 	};
-- 
2.52.0


