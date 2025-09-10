Return-Path: <netdev+bounces-221582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9CB510AA
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034B81B264B5
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7353F312827;
	Wed, 10 Sep 2025 08:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="f0pf2R4c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E704311C05
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757491677; cv=none; b=uEbXngI73QCw0z2HriTgggb0tWZw48zf2bD0gqNfuzjkQ3pjAIUHZMUPBW0h5R/wy47JWsXdc0FfTxY/hv6EPNNH7LD26wKuVzUJhStuGUn5KDiKf2c/uLFFpBOW2c9Y0yhDzv/7+vtWUk2Wd5eQ8DFbm77LSZfbVOPGHf7GyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757491677; c=relaxed/simple;
	bh=fwsfkO/edNU0K9G/U0ffbwq3ATl5oZ4mal9F1JcWMmk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O337fY6hbAhfBjjtZxnUdllHWqrLpgeJpvhC8RVrVdMyViRz/n1CiLwhd/9jaXqxQ5cKUPSh10X814hu1nk/edOMFralxA1WbNmU57F8OssKKUU+U+z/eLIdDE2Q+/yiWVNMOIqadDUniZdUFyN+YT3/z/fla+azvHC8RhiY00U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=f0pf2R4c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so61006595e9.1
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1757491673; x=1758096473; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG70VB/2THcHEf1bbNlRsLCEdjUZ295qJspYMOYZW5c=;
        b=f0pf2R4cDjwGxM7o7+PN8nqd6iXaga0AC5gG25lOvNf5ENNCenTKpn1eykQqTNg0Kg
         BSaHyDd7NnEw8YfB+H3Nu4uv5NQ1XV/d3Zj0TT4RpqODF1JaewX6K8R5OnxtLUO/b9u7
         r/VbE6BVvF73dKJcXraFSnHi+/0YFOpHz5nYCuCbKpU+nFITKI4+Qrw1yxmy0reX4+S5
         Ia+3DSmubWWzxck+DfcF08v1Z4uESaIiRqFqLkrQtRvtvW98ufrqc7g0zSIiWV1qngwS
         ZEFnmYmLspnKAvDrURBXP2QPzjz8z1l8TW0MaKBXeCzkIf+qrhRfzkVAtmHmXk4vFcej
         xYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757491673; x=1758096473;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pG70VB/2THcHEf1bbNlRsLCEdjUZ295qJspYMOYZW5c=;
        b=ZztjcFy0aMw/l4wmjqRcdcHu7gH19+1c+jnbLrxHZHjQDQ7Ps4mGP7HrbAhX2GSIqX
         rYFp5Go8TC5dYa50mUetC4odr1DN78RxIdM6Ra6jduFfV/UnNq3N8csfuNDotRxxxqav
         SMRu+l6cJmzSeR0JmaYGDWVgknaWSrTDCNc9N6T/s1ENN4ItVaOXky2kg+i466/Js/Kr
         g1taVnPblnrMTNvcx/O8N6HMyKph83Whtpq2H9heig9M0+WAHO9oNBf6Tvix29Bpg2gO
         kX24Gc1MJT2yohWPNE8ZicQXc4iFmWiLe91pSEhf+Nur13v+oscLKmaVM6uIw66u4j0L
         t6+A==
X-Forwarded-Encrypted: i=1; AJvYcCW+DR8TvFqRoEVPnjP6K1pd4QANJAG5eDgHrGpVXR4alhsvg8229aFWBIukWqUJbBvy/4mQ/zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQbcQRfmVieIGVD2COl4tkTirlqaWmNvVhV2DccOjFEBC8wX5H
	c+rxlG82el6mRKag+Vp3pYlsP03L5WP8crx3KrXmh1FxbFMhKQbljHtAqo4P+BYG9pU=
X-Gm-Gg: ASbGncvBdib1+PbIeExwdd1zmUGE2vbr5fIN86NfaqEK7BzkLAoxJ+T/gqA04UEkshA
	8HB7FqdypsFPVprVtm+1iTKbhpTtO52uTWnkxhzeEr/rWZgZMzSRWL4/OsiVLTM3zZPhRmZHj1I
	zurJK554rPoLEl1D4/NbM3n8pT2iqV9eRWzHqvggTbGUC8rRwB1fKwXR4tvyVv8rRPvlPG4MgjM
	y6GXSqR/AfSavkkjP8Gc040OYkq/pQAAadPHZOJW9duehvjRO6SOe5jJK7LVSeec8OktYIWUVIM
	VVz+7QsYEtoRbOrK5iIEdA7sLcMqyN4vbT2gi5WmHhr4rRFdFQCw/dhJnM5YVuycHSl2Gjfw24w
	9tO2wj/XU07S6nKDFQU3I2TJn2bbN
X-Google-Smtp-Source: AGHT+IFjyHooIgPzsIu5mjEBNXpXbM4EqzCxFwgK0R45SY2NiW1XrpvBRtE5XdvWfXqw4HoOsFUisQ==
X-Received: by 2002:a05:600c:6305:b0:45d:5c71:76a9 with SMTP id 5b1f17b1804b1-45ddded7652mr141100805e9.24.1757491673453;
        Wed, 10 Sep 2025 01:07:53 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3936:709a:82c4:3e38])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df8247cc6sm17813605e9.12.2025.09.10.01.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 01:07:52 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 10 Sep 2025 10:07:41 +0200
Subject: [PATCH 4/9] net: stmmac: qcom-ethqos: improve typing in devres
 callback
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-qcom-sa8255p-emac-v1-4-32a79cf1e668@linaro.org>
References: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
In-Reply-To: <20250910-qcom-sa8255p-emac-v1-0-32a79cf1e668@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Vinod Koul <vkoul@kernel.org>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=XKd4Dvzw0ejsOil4omJOz8oD8d0/SZudynnYpUwSWG4=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBowTHNFd6+XtHbiUlr0CBiyUr3sDo3TcopvUbxA
 Cez11/GZEiJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaMExzQAKCRARpy6gFHHX
 crSCD/sHgzl01Xm7vNRAaVRSRvpCpLopzb9hsEChofm4FjfDYUIcvTtJaJuDjU3XhHdNDwZV9Zu
 Jvj61hgts5CXRzx2EblTpQ/3DuiqYeDUlYoRNrKZ+bFnX5AXAVq/TA2zOzyXsWrNbUAaV1gNLOz
 VTz+PAVZGKpiWFDBpYusQE8juIR6bh0tEB17WWbbhZV6l0uK2fFCvllZG1nNk3SqJ5qG36efTPj
 /6VjOG1kimbc6GRwk5dLbYporMJimuedb5ycfMKxPqv+u3sJ1GTEbnxQDx9BxF/u562rsqfxazv
 mXGxtvtw56tQ3NaUCvLlWl5uxCMVhqV+jt0c8yiUxhssWPP6jK9r06eAybsTAVxChagDzakxs01
 n65RPiOgqoEuSqlYQpchL/l6Vjst4EKT/9xb/qi3pqlJTpBqcSyxiri6drcKDGaxihhe8w8gmMs
 sYLzxlL/oqpOYFfhL0aeFEA1WTGBYIeYQwsezafFr0CpNawRbrT5V8AuBRhSVZkNelEuFmYE9SI
 oAXG5zUxUzYb6LOW9qQ/LhFF6/plZCYbBsZP4cWXfzas3rXBaTecTfEcRctYXDXFmc596Gy3CTw
 eDYk7Xqxz1uDVEZOr5HoOdY/3M6E7CBtmpvBdIIMuVmWW43k8aLvjHK8ZWqdpWkIQ7ijqwOkMFM
 DCJTB/f1x5kcYUw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

It's bad practice to just directly pass void pointers to functions which
expect concrete types. Make it more clear what type ethqos_clks_config()
expects.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
index aa4715bc0b3e7ebb8534f6456c29991d2ab3f917..0381026af0fd8baaefa767f7e0ef33efe41b0aa4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
@@ -742,7 +742,9 @@ static int ethqos_clks_config(void *priv, bool enabled)
 
 static void ethqos_clks_disable(void *data)
 {
-	ethqos_clks_config(data, false);
+	struct qcom_ethqos *ethqos = data;
+
+	ethqos_clks_config(ethqos, false);
 }
 
 static void ethqos_ptp_clk_freq_config(struct stmmac_priv *priv)

-- 
2.48.1


