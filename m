Return-Path: <netdev+bounces-12485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 244B3737B03
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 08:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D483F2814FC
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 06:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFF1882A;
	Wed, 21 Jun 2023 06:09:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05BA8F42
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 06:09:57 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1811728
	for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:09:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-982a88ca610so663418066b.2
        for <netdev@vger.kernel.org>; Tue, 20 Jun 2023 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687327793; x=1689919793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5KQyTonkUooBZsCr5w5RfeTc4RupKUs9CBjpkXfe2Zk=;
        b=ZO7zbGSnjCubhNA1aJxOIocol/slpspgaFBAu8h+g0kOo+kkW1gC1geXWAhvpJdqgP
         fIm7mM239zNKuVAAab7maoqlMR82pr3JLqsCBNEg37JsM6oOwB5XDBZqLDHPVn/rHVSu
         U7zOz2IzamWLBM7jeuDa5YYnjcnccPnMkETFmO/pXVqAxYp/IIVKCJWj9FuRfJKqtgkR
         Z760a/ZsctTmvN7IJHN/rOklNWIghh18ThTV2frxr4YtUMWv9w/l0vStw0znN7UG57H2
         pIlUaYrlvco4xsp2Gw40UOS9xJxeDGMCfDYJjGJZsPkj4d5/PLK9AOslTCV0kZkUG40G
         T4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327793; x=1689919793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KQyTonkUooBZsCr5w5RfeTc4RupKUs9CBjpkXfe2Zk=;
        b=LkWa8eG6uXNIIqW1uTqr9ewmNEl1WWUzHHXPnijDiSZUyJ9ZrfItXzwYSiURJQia29
         fIIg21bFGKCgXURl8z0grOiwKOnacnbig0lnpFZxSu4M3pmcd5Ub7mW8z0HimzNg1RV1
         R+7a84SQ8D4e4ahJ/idtVERc+BJIBONQbdVqwKy150EBrBsVXAuNPAafX8ftO6z5fsnZ
         DlJJUlFRAXw+vb3LEglBmX9j+LhZ/rMhNbFFg9EyrOSoNGcBlaL/1McNtcwvxOIRMZnB
         /P47YI2f4Qamxgu9JWHnTAPpKOzLLL9VqgP0u2EbakB+YIHEt8rLK/OgGFbYyByT07us
         VEGg==
X-Gm-Message-State: AC+VfDzJdpxU45QslYXCDLvO4E/StRKvGvO8mnCmKhQ+7gieir5HXfcO
	EIAmv7t+v+wR8cXioKJnQQVZ/A==
X-Google-Smtp-Source: ACHHUZ73bgT3/h24wRR46mzrJ4jW1YcuFSwCdWXXjZ+Pi4NbX0uCX3RQQ5dOf848Fn01ctCLdRnUog==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr3288108ejy.53.1687327793394;
        Tue, 20 Jun 2023 23:09:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906698a00b00988dbbd1f7esm2509815ejr.213.2023.06.20.23.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 23:09:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] Bluetooth: MAINTAINERS: add Devicetree bindings to Bluetooth drivers
Date: Wed, 21 Jun 2023 08:09:49 +0200
Message-Id: <20230621060949.5760-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The Devicetree bindings should be picked up by subsystem maintainers,
but respective pattern for Bluetooth drivers was missing.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea9d87f39345..3d5e378b3f13 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3637,6 +3637,7 @@ S:	Supported
 W:	http://www.bluez.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git
+F:	Documentation/devicetree/bindings/net/bluetooth/
 F:	drivers/bluetooth/
 
 BLUETOOTH SUBSYSTEM
-- 
2.34.1


