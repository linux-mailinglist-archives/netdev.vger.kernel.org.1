Return-Path: <netdev+bounces-61619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AC8824683
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D93284F0E
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265B425105;
	Thu,  4 Jan 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="O8YMaXNj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F84250E9
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-50e7af5f618so737301e87.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1704386584; x=1704991384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sxzyhzf3fzWhSMS87FfBxI7NvIT406Ww72fPP+52L5U=;
        b=O8YMaXNjeqSsCWIh+qjOEkevIjYUhPVML5WScoO1Cx6Xt3VJ/OloVVfrYQn0ceZDps
         Ngg4o7nF4WwudRRWbl0PY+N1qONAwSD9P7KWdDiy/KrUoGCzmKDi203fpuRf5gDgO1df
         5hXT6fq6U+jLNpuYgKh+fy8voVC+ObRmVYoK8UnDsis42QGdVFGmehWQm7GOW0Dxc3FP
         APehmD08bEgpvYUBR6SbX0T6BcIZP84jx/DxpCg2sV+ZcJl0uC83ESP+FSr0b0HYGI9a
         q3BpVR90kH/gHiyTwKXF/bIYkhl7QiagM568TJd2il2IJErQJBHa97/sR6QTGi2P5pyF
         /1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704386584; x=1704991384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sxzyhzf3fzWhSMS87FfBxI7NvIT406Ww72fPP+52L5U=;
        b=TT4HhWxTjqG+Gffkm+xB9E41F558Zw4R8VaHU8GHkQ95Qv8GzkjhCJqYTSp6B2hiQQ
         8/NeHd7hqFFaHc0aGn5WAKuKrcgS2S4KQl+Ll2gLzgHwauE/wYotRohcfIDdcP5IHxBV
         RpnxpC5u+64pXEyQSpi5rcgFoFwTlXoeTV4hQPtjNoH9L8/eJDX9I9jsBc6UsQOm+5yO
         IhpSysa9rrzAHolVyt+JEao7S80TAl+CUIktsCDm7t/ieXy3ATv6mqebmH9QxA9XqQba
         NV87CAYAzTK0pB6edcfNN8bNRXLg0CC8buSFO/Pm35tKdCsufNCvlKZZCPC40XQ/+Qwi
         5Wng==
X-Gm-Message-State: AOJu0Yy8wSnClZXJ+iAU8OTrcZiXkZMlLGpaMed7IUMvykZcBRwISlfl
	p0WV4bTN3jatkKzd6nKfCnyVrYEMj2UAqF1qLlZXAlqhZrBMSip4nLOIYg==
X-Google-Smtp-Source: AGHT+IFO1S8uO1XdG0TzEZLwy4FAMfkS+xniViwRzXdZt5wHLtbEb0CmI8qgGEKqlDbWs9/u/UTKK0b7F75Y
X-Received: by 2002:a05:6512:31d4:b0:50e:7de4:8626 with SMTP id j20-20020a05651231d400b0050e7de48626mr526052lfe.108.1704386583635;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id z4-20020ac25de4000000b0050e754dc1e8sm1015335lfq.38.2024.01.04.08.43.03;
        Thu, 04 Jan 2024 08:43:03 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 18284600F0;
	Thu,  4 Jan 2024 17:43:03 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1rLQoA-00GEpe-Pc; Thu, 04 Jan 2024 17:43:02 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH net v3 0/2] rtnetlink: allow to enslave with one msg an up interface
Date: Thu,  4 Jan 2024 17:42:58 +0100
Message-Id: <20240104164300.3870209-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch fixes a regression introduced in linux v6.1. The second
patch adds some tests to verify this API.

v2 -> v3:
 - reword a failure message in patch #2

v1 -> v2:
 - add the #2 patch

 net/core/rtnetlink.c                     |  8 +++++++
 tools/testing/selftests/net/rtnetlink.sh | 39 ++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

Regards,
Nicolas


