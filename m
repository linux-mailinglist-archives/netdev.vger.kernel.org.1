Return-Path: <netdev+bounces-18696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A163D758521
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA0E11C20B1C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA115499;
	Tue, 18 Jul 2023 18:54:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC35F46A1
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 18:54:21 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899D132
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:54:07 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52165886aa3so6884594a12.3
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689706446; x=1692298446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u//A+GlhAlttSgwEt3gkumyAtdqzMVpBDzjR8GDGYAA=;
        b=E1wLf8L6/nbq8aJQ//pWBjId0ztDeKMPvJHWR0fIfH1VudG2o0yfado1tfuN5ez38G
         La8OCLd2zvzmH5Kny3W0JmyjVw81V1WTjRaKe2iGpBYjNH0kd6ui2JJESG1OeC4dUkAz
         jtmdMFHeG33b8CxIKyfHcaObV0ECbnmaKi/VfZuj3g3+/vIKodcHsdF4iGvRlxEW0Oes
         Yn0F1/kcO8+hTpM8wvi9FgmnWmz1mbjtmNhfboEAewnbn0jQsw0zQgIiHf2hpirB+DWW
         W0JU0YpMbkeYpMBmxYDSTZean9Sl00XVSq5+Tuz3/L5aVS89MgzR35LCEY/ko0zEy2hL
         BxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689706446; x=1692298446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u//A+GlhAlttSgwEt3gkumyAtdqzMVpBDzjR8GDGYAA=;
        b=hIT6xcf/uDMk2HrtT6oP4VHaqcEFm47Bf2cO2bJzVGhVWBhexaKBv7T6LQYs0iJSyz
         fYov4jiv+E2FQfffAgMJY8y91iKPsqBERr8pgxcJesY4eR0FcHeUhBt+HvWQgpT8NLwa
         qofWXLdYRMKSkkj23pAps/IVN5+Ufh7fKzVT9UgCZcMztuOXyntgKmUaYgpYwsU7O8RZ
         EpDS3VMEk2JkDp6EsUfFDlSt20FJc6pFVFwSC88T5bIZld62dPpWAevS6goaV2vn5ys5
         hk9lCpMCZe/anL2iwHfrDPrUhDQzKpPiEgisuryWhVjwceoPElNCup6JHM/H9CaXGc8i
         ds9Q==
X-Gm-Message-State: ABy/qLYA1u05gN2x8sDh+JhGgySYcz5n5c6eaQHsPJb7AKot6L7uJM/k
	fm7HetbT2zTc8TAdOZ9m+k2/Kw==
X-Google-Smtp-Source: APBJJlGXFOM+q8PW+p7H7DQdXaQwtsgl2vlU/eN/+0hkask5hluI60Ev0R+CAPak/xBgH7zgN5YpYA==
X-Received: by 2002:aa7:d991:0:b0:51d:e7b5:547d with SMTP id u17-20020aa7d991000000b0051de7b5547dmr655552eds.34.1689706446085;
        Tue, 18 Jul 2023 11:54:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id z11-20020aa7cf8b000000b0051df13f1d8fsm1608611edx.71.2023.07.18.11.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:54:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Cercueil <paul@crapouillou.net>,
	Marek Vasut <marex@denx.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/3] dt-bindings: net: davicom,dm9000: convert to DT schema
Date: Tue, 18 Jul 2023 20:53:54 +0200
Message-Id: <168970643389.118933.12401444775795846915.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
References: <20230713152848.82752-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On Thu, 13 Jul 2023 17:28:45 +0200, Krzysztof Kozlowski wrote:
> Memory controller bindings have to be updated before we can convert
> davicom,dm9000 to DT schema.
> 
> Please take it via net-next.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: memory-controllers: ingenic,nemc: reference peripheral properties
      https://git.kernel.org/krzk/linux-mem-ctrl/c/00e20f9ecde2c3131553de44ab832b486e8720a8
[2/3] dt-bindings: memory-controllers: reference TI GPMC peripheral properties
      https://git.kernel.org/krzk/linux-mem-ctrl/c/d9711707dc781ea6a397c5aa986ba3c05d1b875f
[3/3] dt-bindings: net: davicom,dm9000: convert to DT schema
      https://git.kernel.org/krzk/linux-mem-ctrl/c/b71da9105a81066f3a911beeb307751f904e00ce

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

