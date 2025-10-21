Return-Path: <netdev+bounces-231381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF70BF844E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 21:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58F0E5457CC
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 19:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A44D25D540;
	Tue, 21 Oct 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSuXqKmb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11E9350A0D
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075210; cv=none; b=PVMCAWV5gEqEiO/wrImDfBKel9ftpSedr5626+f0yhShp44bobmuBGAXmss+/mykq5JdCffA8or1+qOm0PwWaLdFk+Ay2dPgL3Oy4tXk4aozqfyzyHTL+MqUjj9Xm2loiUJYmJWddU5NHM8VHLqZIxBbd/FXOWkTlpjQdhkjY2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075210; c=relaxed/simple;
	bh=2H049I89BxKd0KACb/ORIx1f6NaIgJoRwhXgD3m6n1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv5nQbGDiO7xNv7QqXtNFrwWxXmwnU/dRyOE9z2fUsSxzDdQ2KpEH2yK0wewJDPVw4IcvS6/Big7A3gmjuXwQVmZcFW6kYQERTiwBBE8VpCfPlJ4iIRrgNZywqBD2A37qTeNKQb/paQZjr2lme8mgdGPIfslbmjT9Mwa4FcatzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BSuXqKmb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so4371516f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 12:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761075206; x=1761680006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eceHFX0RmtQDMq4x5hNy8OnbHWKSwCTIDv7MpsAV2Jo=;
        b=BSuXqKmbhlWrR1eJ0jOAdn81p/OJpmfzRt/wdSwvcsrsfvShTTVIumDzCzpaQ6cmwh
         vLJo4eIUh2OGEegQn2nULP7KLfTYA7NIqGHPNFgmxqT/0OgX9ksb0YtSJl0X3SU2IKnR
         FhTHpVznJK1exGjANHJm8g/expuqCvSHKWHHGq9TH2EHg3iwTOsw4DAEL/1/zjyG5rLJ
         dlrvgScutxigc9S9V4Fsw52VzksfQN00AYb19Q/jXqspuA5kMNZMEnCUfsIBv8Ubce6X
         jK8QW77Dh3h4rE6/Qli+sAijFeNk3g1GDb7Gl/uc5JpIaFdhydivrUkgxNMSov9u1h8U
         OdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761075206; x=1761680006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eceHFX0RmtQDMq4x5hNy8OnbHWKSwCTIDv7MpsAV2Jo=;
        b=OO5gR9F3LBsU8QXqK2aph4d+Bt4TWLArBpOBsLkwVDOPwuthgud1XdNvqdbAiNdkqa
         VR2vDn/5u8xIJ0qvGLfiOthqXVaxJGtaBWjdtlkfJPHWG5TmOtAAbAFw9E/mvt6feezF
         dEuqMo9vPx8qh7mxLKuOajs8dpRK24ybwKIz87R89ESj5HBjeRpDfSkmJg9ggxozODTX
         wnaPSBudvCEmLtiSSgPguq801Lsa41PhmR+sgZAqp5HW2gOKgK8U7cOYfTnXU+wPRIcr
         rBCqFEU62qMCgIBGFfRYXteVW63tN/eRPr2LB51nj0S7IGeSCegHatKPB7EWhQafgJAK
         RpeA==
X-Forwarded-Encrypted: i=1; AJvYcCUNLKZeLue3hY1awzLQQf+jyreDkD29AG17UIbwWrVxwPqai5aSiOFs/0CKHB2S8dgAxaK5S7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya2sCOdu3/8KQQ3t43377GJCzEFdIjOqB2xgNXFE4+S7bSPBfJ
	8NBP4xTznk1f6siopV2pmHug6iUrg4JMUAGK2J7LmydFB0zi6Ey8/qht
X-Gm-Gg: ASbGnctFY0mMm6Um4I9YBsQrDGwMhmxngFo+LqslJpLaIUIOfOGfKp4vQtYAMheWUjW
	kOv2UsIe859ql+/nfCulQkliMu+BezuioL4jFY50GWeeTb+s9LA4BfSC4ccJMFk2/n3EGvC2E79
	sq6YY4CxDZqIsxWjqGEdQn9MTy/Ivje4agTKs9evPwgw6uKwtosBdZVMeVPlI3YyeTOi2pbCSmb
	V+vw14RUkGM9PPD6T5YNBUDsb1yYWW0vpOwKWEwYHdDtGlQF28wzQ2q+PokcB0hqm1dXALjFFX9
	DhaXzJ/nDoC1jYiWZ9GcBT16cd2y+XEeFoHaqv9TCMfrhINc39OxLLBGILOXrW3TOYyp8uuKplN
	2+B3lKqIt089Uol1N/gbq4J8EzuLleyQGYf+iVFTmxnXMiDzh7eswFFlKCZ0pV97zff3yY/YeDK
	wfQld4t02oj3ZNj9zQ3DP3KRLZkSsea94M4zfYk4dDSgc=
X-Google-Smtp-Source: AGHT+IHOYqls17257tkZfrI1j3S/rbxbkd3G5LS7Xa1V5wyrUo+IQJd6ypdrMXOGDYIilpkwXDnmEQ==
X-Received: by 2002:a05:6000:22c5:b0:427:492:79e5 with SMTP id ffacd0b85a97d-42704d7504emr10968810f8f.21.1761075205922;
        Tue, 21 Oct 2025 12:33:25 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-427f00b97f8sm21327187f8f.36.2025.10.21.12.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 12:33:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 0/2] net: airoha: initial phylink support
Date: Tue, 21 Oct 2025 21:33:10 +0200
Message-ID: <20251021193315.2192359-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This trivial patch adds the initial phylink support. It's expected
in the future to add the dedicated PCS for the other GDM port.

This is to give consistent data when running ethtool on the GDM1
port instead of the "No Data"

Christian Marangi (2):
  net: airoha: use device_set_node helper to setup GDM node
  net: airoha: add phylink support for GDM1

 drivers/net/ethernet/airoha/airoha_eth.c | 110 ++++++++++++++++++++---
 drivers/net/ethernet/airoha/airoha_eth.h |   3 +
 2 files changed, 100 insertions(+), 13 deletions(-)

-- 
2.51.0


