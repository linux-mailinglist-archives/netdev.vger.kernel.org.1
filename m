Return-Path: <netdev+bounces-230324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B39BE6951
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CE5B4F9BC6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 06:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B633195E2;
	Fri, 17 Oct 2025 06:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoxFuiqz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C54D314B7C
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 06:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681468; cv=none; b=MIJPMBkKjXM0mRGZ7CnHoTF4YZ3rQsGVNGSw8JkVAchGv+Vtj/iUSDWWMLO5VXe98k/GcbxYFvQpz29KncnyorrFzCeupfeer+kj8M6rRWrffc6JNGUBhIK6pN8n209xFsYLMjlKJc3s0MWl7/HnqdUcFrGjAv5VRw7A3D5wsNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681468; c=relaxed/simple;
	bh=pCrMlpjFzN/XrjcWfs3YB+fSeVkmexAvaoC91gKso/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bF9jN+FSEr7+XjIhJOl9fJ65Zwv1hLrCBuU+xHfzFeZbw3Kb3fhts1OYNjOBw1WVvgIoe1rKGiYwgqft4MrDEe3PU68OWyt2nRvzmqzzWCdg/Kz9OpcljU89p4Gl6TFQ8kiLEunxq7PeZAY1U2np/PpjvsLbgadmDMJVvqp4gnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoxFuiqz; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27d3540a43fso16689025ad.3
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 23:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760681464; x=1761286264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4jV3SckoWHX2zGnHC+rYU8Ui0+E0D3XKDL6jcUcIDA=;
        b=VoxFuiqzPS2WN95byxDpAHHFuGK3A15yl3clLQgoImTK8+v/0M6fgtDzoPpUppIMEi
         Zger2TJmeNiLNj6XtNeZJY31ZP+oed9qFKOM3XsAy4/ehnA8dYmAPKBrC2mWcPzoiCps
         lF0VYLPBiWUT3uexc+agBjwS6IXT+tdysYQ8vj498JX2jQyDdD4MhHf5+uiAOXoFfPpz
         LaHt1syjxUxzpZtGmpzawp8nBYDiDmZAWMX/BggTQqM+HO+4OJ8HxULU9NNrdr46R/QE
         PMB8s30WLiZAd0ylucVjjxY+nasjbqt/ZYinPA6sKq9bA0ODboU01ngYN6gC5qUQV7dI
         zbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760681464; x=1761286264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4jV3SckoWHX2zGnHC+rYU8Ui0+E0D3XKDL6jcUcIDA=;
        b=YRNscUsATVutjUrgmvqzHRRosK8beKFrLMDR8UrmxrIYy8t+0eVllY6QaM6sd8lJj7
         U5W11Zp+X/JjtcbSOLDWGACkd/XqkYb07b6iiNmUx/kkME/g9zw9Z9/iEXSktxl5ey7R
         kXmq51QPE2cpo7Jbk1+tpuBfk2JD+0aKXXLsSU25LtlT6hpmxOjnwuaMQMJ8UbS8dLzR
         MrOiqJyHY4fn+HLfsO/aiPY4Bh/q3smUOo8LcIin1OdJ5Uy8jm4CiKYwrXkNAznlgwfj
         JfFb2Xr18pKUQlH381NrjTHUA0YSTg/EbLS47FmEoU8fShEtRJjx25qDqNNoDidgNReE
         TQcw==
X-Gm-Message-State: AOJu0Yz0ibpePCBu/tVnbplaWLeYolOr6+FZxex3kHWE/Xjcjnra3yXN
	vAKN7DVPkBpHUFJpbTICZwB5F9/RfoiElu5AeXKso4sY/SRm1zn29St8Kph89rW5YOCerg==
X-Gm-Gg: ASbGnctvVtJFPQSZLnRjDLUyhCyOCn7Oh9izKtGa65x2ukgWYIc5Try80uUk4b9hJ2T
	Nu6hnI74jWNTmjuc9VnRFMKTd5KgRnPgZCRrIdWmBD1sRG8/Q7Jauvdg6UnlJtXo7kgR9GgSV83
	Kwq7IQgIgHNxIyTgFJmi5XtmLFE2gbJ/lBD2a7/oDAp9jJJYib0Kc1Bw4uUwnVKKJp4vlYLREpP
	O77I5JsL7+ZjZYOt+J7J062FLT7+lepJDqe5mEIYQB3eCm8e/aqNWuz2IP3j8j/WLbTqD06+gNK
	Rozn0HhTl8x7ASv0GbooF75vOrTRaLugHYeU8MrCeHy2d/zVudeWoHqFkDJMTzh5qj4gDxU6cft
	2iFV8Km4/h0pSKjoetGA2LTZKekmJWrkTMSaQqQLhs8GOWCzvCfR71X0xBaHE7DPSQigzolet87
	w6TqQmQ0f/zbzFFJb/O+bsMFDgCRJz
X-Google-Smtp-Source: AGHT+IH5ImymZLKDALz+oetlYqaue91LhCFN2bDDJh6sQMmR3UMcGoG20bbqt1QrYkz1S4wAj3MGrA==
X-Received: by 2002:a17:903:3d0c:b0:27f:1c1a:ee43 with SMTP id d9443c01a7336-290caf83123mr30401595ad.29.1760681464290;
        Thu, 16 Oct 2025 23:11:04 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909938759dsm51315475ad.49.2025.10.16.23.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 23:11:04 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v14 4/4] MAINTAINERS: add entry for Motorcomm YT921x ethernet switch driver
Date: Fri, 17 Oct 2025 14:08:56 +0800
Message-ID: <20251017060859.326450-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017060859.326450-1-mmyangfl@gmail.com>
References: <20251017060859.326450-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Motorcomm YT921x ethernet switch driver
and its DT binding.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4faa7719bf86..ea72b3bd2248 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17435,6 +17435,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/motorcomm,yt8xxx.yaml
 F:	drivers/net/phy/motorcomm.c
 
+MOTORCOMM YT921X ETHERNET SWITCH DRIVER
+M:	David Yang <mmyangfl@gmail.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
+F:	drivers/net/dsa/yt921x.*
+F:	net/dsa/tag_yt921x.c
+
 MOXA SMARTIO/INDUSTIO/INTELLIO SERIAL CARD
 M:	Jiri Slaby <jirislaby@kernel.org>
 S:	Maintained
-- 
2.51.0


