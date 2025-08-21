Return-Path: <netdev+bounces-215542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBA9B2F258
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 10:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0557DAA7415
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E6928642D;
	Thu, 21 Aug 2025 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yi/Edbnf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C90A1DDC08
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765049; cv=none; b=kTe58qsVQusyAv8clEZpq+Y0hwytGdwP+d+9cm/2a8KugCXBcsWn3eZQtakvM47JiVzzvMiVY1m+qfCK4ixo7hYDUe0CqDoquWxR8VtmKvwd16t+xskqzueOgnXpdRlsV6ROsT7BjNyBEbgenv33gKf4L3p4/E+8YRRu8//lJTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765049; c=relaxed/simple;
	bh=RdLu58rkPGTY+tqQQir2QJXnP+/DeGGspDArj5JBTe0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oVx1x3AuHbvvHepmpoHM2DCEU9i1hkcW43ZdMHtUkfGrQ1dK98PVcptM3aNmNeJdw/RytUX2Yb5fWeXznzuyPVOAkZcvKYWY7Yx1r+wV2bWtu0ka0h/KNybKbYWcjxh2J8AQC/30OpbbOTW/YzdsOJw2CMJj6dOCJu7/QyjE/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yi/Edbnf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78d1695so7738166b.1
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 01:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755765045; x=1756369845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2FaWlk1kC6493AlFCDPSJ1E6vlEnlmY+oKGnlHwhgQ=;
        b=yi/Edbnfi9gwAWQXPP965YPVXdvQdv2zZUSr7Gh603Ftc8hMGPTrg8HfOu3ilsSJ6v
         35DNykMWx0wF7fCbCD1HJtZO4Dg4gGsBORSA3ekSfiOaKRbREI7XI29iWP3+voAz+xDs
         W3IxjUF+LQ8b1vooteT7p/SmLX+SzuLe3VSat5Dp1h5ltoNN4Qiier8pOg6Zfl2TiHXD
         oJuG0mE4rEUWkbwQZnwYldmZJS7ANv6dEjFhHh7ONOI9MAcoMFmW7NbkLi7RJY02iGt7
         D2j/7gj6vky7vyaQFKhxQ+xJOREhO6UaXTaBPa5D0pd5lQG//eGnj5IIFk6UoweA0Hrs
         BjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755765045; x=1756369845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2FaWlk1kC6493AlFCDPSJ1E6vlEnlmY+oKGnlHwhgQ=;
        b=OX8c9m4MWoERVN1Z3ZdzHaovsOuVl6SJWindX89mvPM18s3p2QpvaLRSs3Ty68jcVk
         HO8NsM9YakpDZFammuRmyGWHtJXGU7icIWp0oXyj6n27dkjbv7/T2WkIkl31Ff7XFPxu
         Nh3P+kYi0JMkOQ5rLZczAdahHpmzEYsx4FK9TddYIByFkkoA9yBn3YxhXzybmpo5pZ7R
         uIiVk9mHOqJbVyP5ppug+LqLxj89Kr1CUAc11/EG3T7leNp2WOkDg1/TwA68xSwdu3mc
         ao8B+C6hEYpjF+blh/28MZyF4VsnBzFOo7IwxwEHGkBGW+WheBEOg9xaJV/07m89YA4K
         glEA==
X-Forwarded-Encrypted: i=1; AJvYcCW+AEsA4KHJ0AiBcDUnQ3VAAu45ozDF2VEv5h7REAsFmbrDxsEZhcO1mEsxf/CD6Xj87VD0BRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZm7VnzDTL9D4+WSHtwahHDlUv7r1ESPUM196hFsZIENmtr01c
	IaP47PyBkQvJd35c3XdBu4MXJ2AEJk0usNxrmVUrH1ORMZpS/gzS/zu0PntuPMGCfKc=
X-Gm-Gg: ASbGncvFO/98W7h/ApaMErlm4sJsqpsf+x+86ZjPdDhVpsJ4tISZah+8PLC/seQUXp0
	MQqITEJrLdhAzPxuof99WeEiKpvUX2skw5J/ulTgsbZGADV9i4ru2CntVymSNa0Fyh+5QVoI8iy
	QCj3Qtz4cn9RVxkTb6M5RgYBNbjJHduwHDgYhRPoc5YfBnC04nwIR6OwL4gYZP/cw001O6sUV9+
	+zbgmXPbsDQmgQfepSXzcPTJwujDZxlrSzCSGHQJrwRelxpwmfxLGD6FOzoxy0lp/YkYf0TU/u/
	9XGNOjv5lYv+mJCf+DKYcdh0xiszWixIxEK0ILtijMHKNkstnrMTkWu0lqBUHDWMSPKiyg92qF1
	1Euh+UQgnbsnTtVYEsXN5lUWhqBzeMtfGHg==
X-Google-Smtp-Source: AGHT+IFrQfhYYLDcOcklIphmk3LaaAGy6ccvp2arV3OESofIoJWROkko8fN5kaaORXuIhpFwjj8X+g==
X-Received: by 2002:a17:907:2d90:b0:ae3:5d47:634 with SMTP id a640c23a62f3a-afe07e9d221mr67370866b.9.1755765045354;
        Thu, 21 Aug 2025 01:30:45 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded355489sm349014166b.51.2025.08.21.01.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:30:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: net: litex,liteeth: Correct example indentation
Date: Thu, 21 Aug 2025 10:30:39 +0200
Message-ID: <20250821083038.46274-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=RdLu58rkPGTY+tqQQir2QJXnP+/DeGGspDArj5JBTe0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoptkuPMnNZ8sg+hDdzh8QNFHnrn66BLYb23tUK
 StbaIlzrfiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKbZLgAKCRDBN2bmhouD
 17ZoEACLruAmBdVUQYdVGgf1ypibO7dLkXwjS6A52XCstq0B5vvYHZFF9C6I4i37mIonNLCvPQk
 oiTkDLHLd0XBA7acOAqIcEY2h1mGX2WU9nHLfGb0OAVIMqbFebxb7VKjl3IRK5svFpW/uf38ZbO
 e3Dv2qQMBVYTt0V80Ol8Br9a/jYtF5lwvL7/yXUqE88ZywKyzjHkv4FdsEHCrDksQgcHXErMbgM
 qFJbSP3aGTp8T2AJvujm6/RXD9sSN9x1dK5gMfNRmuzUCjbgfsopMcbt8y1vBswO/4ecv8y9v9n
 MleVR/L+aGMImotfDAQ5zud5pMjLOo69PHj2wGa+iygdWZetlkOl599zSRVC+0sCwV/1EJ5IAAU
 NeUyBF61YrWcs7FC1A8JwJsedDhdWVfZn5HeFiiOyNzpxW+DUEok2BX/mulXmtG4wu0649roP8e
 c2w7PlrzZO9Lamxh4mj8O2N+ck5uzqyosNnjK3yjTn9zcjX/Ij/F8MvP1kLzLwsi8aj6vRj1BlV
 mfmV3ycskX3b9RSwroFGIW+Z7YX8cRyfuEDvApCwyjuR/Sv8Ap9Yb11Yl8aIxJrseQJQN63tW7r
 FkNWwqkdsHTckcUWNrM7M1lTFy8sx4gwvpHrpfC+JBNgwMVh4u8Lg83VzBEtnLcMo5Xbp5iA4qZ ewZrZKm8AbE7WEg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces, so
correct a mixture of different styles to keep consistent 4-spaces.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/litex,liteeth.yaml         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/litex,liteeth.yaml b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
index ebf4e360f8dd..bbb71556ec9e 100644
--- a/Documentation/devicetree/bindings/net/litex,liteeth.yaml
+++ b/Documentation/devicetree/bindings/net/litex,liteeth.yaml
@@ -86,12 +86,12 @@ examples:
         phy-handle = <&eth_phy>;
 
         mdio {
-          #address-cells = <1>;
-          #size-cells = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-          eth_phy: ethernet-phy@0 {
-            reg = <0>;
-          };
+            eth_phy: ethernet-phy@0 {
+                reg = <0>;
+            };
         };
     };
 ...
-- 
2.48.1


