Return-Path: <netdev+bounces-232959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C45AC0A5F4
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 11:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663931882F77
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 10:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEE817C21B;
	Sun, 26 Oct 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dxYPWv0/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4A2F4A
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 10:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761473781; cv=none; b=sdYUI6blIkUe6PGnvgykgAlJ94h7cB5JQb5xv3uHL6yOew2wquUfeW6H39sIStV2gduoKT1GmRLqVDkWmd+rSv8caO20Y73VODlkIYSzv6hpjY1YO9UQOEkHCHWZS6fqzLVSUnXYRyqVJUloJaAQH0BBhJD2YZ1TL8H00+I4lLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761473781; c=relaxed/simple;
	bh=4tuMvirqozF1BZtSSvcWbX/RxDhVVXyNJnnSGiyPbpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ek0EYz5jkOSIp1dKTn2e3JlgIjmC3xOmW3YOTa3XICcad192w3MfaW8tCvNhyJcQFFLGPglxNmN2sq5SEUCP0bBRaMh2CC4qhWLN/7t9QjqUGqLWGYYxn0KfHXk9/v/sohhA5DjcaeUBEoTcaVFOFeXLLQMWveE6zv0tRz02YOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dxYPWv0/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4270a072a0bso662236f8f.0
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 03:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761473778; x=1762078578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fa1MhKqzuPVYS2M1bInqrAbv70jc0zu2caVbAoAzEXU=;
        b=dxYPWv0/h6/N7AQzFL1Csy6BiE3m3R1oU5ZtfQa07iM/3SZjZVxyTcnseDjVPqSvO/
         MdL9QvLH0XObCJXsiUN+4zBRdVEWLc24WbbQJKWK92kwl4hTyTWU3AdyJ25EI27ZBQw9
         O6YI1ZSzVca/08syVX107PsX0CcHPSks2drP4xefrMt6WBk/FaVbpH0xXlsiqQ8yXxbZ
         L5mdXU0q/hpFJjeLfhjCFQ0dS4SaIcBkxsTUYG3pYVwZbi8PIGPQWn7oDCL16xgl5fm1
         f9n/KqzWqmlHVREf+79VbGZWUt5qjj6AVBP+FiRS8bGMXh6YSawRM2dVhqAVecMHZ+HZ
         oA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761473778; x=1762078578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fa1MhKqzuPVYS2M1bInqrAbv70jc0zu2caVbAoAzEXU=;
        b=IHTJIECgGZZ/MgAJX4sq4EKgGCqPwgP/VYxT0zQjFEYFibU3Dk2jcWeK0TPnGdh+9+
         6T82GIP6d2QPQvCuQDV3/xCIJ/kDX9buiMVH/Uxhng68+gkDwnNWHhww7cuG4gkNapJC
         QskUvyYhzkEf9VwIxKmUMyym5Bz55aVvRzpS9pLgu8W08ZJ7wmVf3gg8SVB85lhhdiFv
         6s3mP0CbUfvc3gwr2ZtwsshdXnFEbOYTbJDRHvxgxbUnVct4eDtAI2seXSNuIA581oip
         PrE+0saZL00+tAOl1jFlmPXkyvxDFJDiSUoLzaD3Fni2C33eZJAOXieWNYU486xCumdj
         qtog==
X-Forwarded-Encrypted: i=1; AJvYcCWv82qQ+52MfgCKxlQTZ8GUazYc46RE0Z8Ghsx458F9nviLgVzTGozZim3CO1nVm1gXikkPKUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE67TUMiHsKkpkT9Q08A0HIpMhPMhjUsj61L47QIfOHIXVzJiJ
	jQCXnmOF1cNIJ949Ct2n6QYxWeR5GS5VhaanSFyISBxT9TKf8o3dQepTP1I2G3HEZcU=
X-Gm-Gg: ASbGncszddWxNj8RVpFh/pxGmfNGvnN5raIW17vVngADZzMKQU8r/ZS0k+Z1B3V19k+
	YRI243lpGpINVM0DC6ex17p7o++By8IJHsOF/pfC6j+swCKbdeuxIOjbibr6Q98wx/AEHk70BrK
	SM+tM05r9AtHpHsJF/9V+AF+fRjzq5zzsPSqzzF0mjyVaLaZppgIYp3NLkP0fpVlDH7VKli5fVD
	FWiiUQOvyV027GAoToIGvuI8foShPfNH2J8Zwg86Ip9bmfCy13o8EOXf8u9+/5aGJAeo2vEAIhz
	vLgMEdxINxUZabvdVRxcSijcg+HjJQfa6olZmSI7WNXOVWBdi928TuYwMaQvbHXVCmZv+pUgRh5
	LAEukxE68w4CvBKCzrzue6+DoobJNSt2lVsTk77VS1pshLNRrVVDCJiiN7bDSMUQaO0QELP6S2b
	fpFWaWXhaI+yU=
X-Google-Smtp-Source: AGHT+IEi5uzHrsnrvxV6x6FdgS/nZMzufp+jHg+YI+JOzAvJ350q2EDyHwRDOj5mFEkpTFwuZkWAKA==
X-Received: by 2002:a05:6000:2408:b0:426:c349:eb1d with SMTP id ffacd0b85a97d-4284e4fa3c5mr7192681f8f.0.1761473777719;
        Sun, 26 Oct 2025 03:16:17 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df62dsm8423876f8f.45.2025.10.26.03.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 03:16:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Robert Marko <robert.marko@sartura.hr>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net] dt-bindings: net: sparx5: Narrow properly LAN969x register space windows
Date: Sun, 26 Oct 2025 11:16:15 +0100
Message-ID: <20251026101614.20271-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register
space windows") said that LAN969x has exactly two address spaces ("ref"
property) but implemented it as 2 or more.  Narrow the constraint to
properly express that only two items are allowed, which also matches
Linux driver.

Fixes: 267bca002c50 ("dt-bindings: net: sparx5: correct LAN969x register space windows")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

No in-kernel DTS using it.
---
 .../devicetree/bindings/net/microchip,sparx5-switch.yaml      | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5caa3779660d..5491d0775ede 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -180,9 +180,9 @@ allOf:
     then:
       properties:
         reg:
-          minItems: 2
+          maxItems: 2
         reg-names:
-          minItems: 2
+          maxItems: 2
     else:
       properties:
         reg:
-- 
2.48.1


