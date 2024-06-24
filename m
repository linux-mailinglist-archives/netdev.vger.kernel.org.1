Return-Path: <netdev+bounces-106111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BF2914DFA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 15:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 112341F2312A
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AA913DBA4;
	Mon, 24 Jun 2024 13:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="X/Lr8VjB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D630A13D639
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 13:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719234546; cv=none; b=bQfyNFCkTxQYcRgyjgYsEd1EmkE25i8/4OL9OsChDNfm0fjWBb7CS25Hg0Ts7uwtyIV0VCLRHEU4rnBngJNaZ7SuXVNIgN1fktC1yDkN8P3AyyQgKC17z23ykmtI2hUjhLlmzfxaCadTsU891VHpY196+xVB4wntP2ylZwp/kUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719234546; c=relaxed/simple;
	bh=+scdV5kPV77tUYywUxlKRVVYgvVP6R7eocuxKRTOoN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E86DYxvq93ji6nZeJjZlNVjSiAi7ayyg48TgQ/ZoBlxR8SmIblPSmEaYe+82lgWyrH+pyhKXk5y/uwxYIh+R1/1JQ0r3yS4o8pY4ZrNLG3diBmDDIEVtcERgsd6tkujQEDrUNBq3F96T/38W1t3q0owxWNejUSSQdJljSvbXma8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=X/Lr8VjB; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-a724b3a32d2so141747966b.2
        for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 06:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1719234543; x=1719839343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PKys0/vh6T5QmnRI1fhrCHdf+nQHmL0vs6iM5TJwqkU=;
        b=X/Lr8VjB2YFbadzr8LVCnNl9uPhMU23PXanLEdSAYMphs04tSNfTk/JKo5OBrnUxLb
         7pZYsfMYZyCLu7+t4IQni4+i0Vaf/rzWeLCDz9hbEFqGLhRo8dajpYcu7ns6vn7vOA4n
         hsmv42YDMxeVP4xK6aSs2opBv1wf/W2HUjNdMpGzqEqVXx2UsIevxXk+RLLy05miyZ98
         nSWGgGSOF8oHfUR9GS61CUkJCrrPdkrnKSg9CAJtLK4p4qm9K2HqzNkCvbJoLAUpa3TP
         muG8l9IsDKSUYi/G3YU5moTR6p55aP2isgfGH95MUV2AU5aBDO1zhY+19J4FxUHwSYiD
         BGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719234543; x=1719839343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PKys0/vh6T5QmnRI1fhrCHdf+nQHmL0vs6iM5TJwqkU=;
        b=qx+6z1oJg6xNoxbNxF2HgzGonHcVIp/OcXP3XkZ5PMJKCcSNC8CcyNibuYnJ+UBSnW
         UgayRZOlXDMulZVZd/gl3IXThPwJsCrGMMK5sNO3t4CEvpw0vzSdXxHekVptpkFl2sdJ
         w2A5oXOC8bAk5FOr/3R84QqlbzxOstrHMBrGpjTN5WT+e2tLXslv7R1E6efh7vbdS/4K
         RE/Uhi/TKLp5v4pS7wc15QuR2fPH69NUPod2PlszifAwTAnaCaSVT+YzwD8JkYtw5QhY
         +vRf79AxhtWwNHIKQtriA2+7ilwQE+CSS0I2qI4NqYC1iCnLRwSi7B3w49D+f5SkgkJF
         hAEg==
X-Forwarded-Encrypted: i=1; AJvYcCX/S9Pdq5ofcgXK7x8ts72FEXN/wUSirJGDeeyZqMjXgYbMGR+TMqhR7VA6yfXRO7CntoyhpITyyRlozh0X0G1rwymTqI4E
X-Gm-Message-State: AOJu0Yxghbr5mtDSlvP9dRA6a9IukyngbUgvyC9/+f+r3GCw6ZuLiLv9
	JMRp5z5Gqjubgpt38uaV0WAwP5TPnYk/M1sLwKC9bZj3PR0dgOhUPUAZ/0GzWc3PaFdwaZpVdqS
	zpyHXiZuDf539jUibvohX0kUM7tkwZh9W
X-Google-Smtp-Source: AGHT+IFee5H2uItC4HpBL/nkSjQqVI9s7XiwYATHxQdAM5BE1RcupnCYYW0nkJf0PzBSPhHKWwrN5zt1koJ6
X-Received: by 2002:a17:906:2710:b0:a6f:d7a:d650 with SMTP id a640c23a62f3a-a7245c483c3mr292274866b.50.1719234543149;
        Mon, 24 Jun 2024 06:09:03 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-a6fcf5493b5sm12292266b.164.2024.06.24.06.09.02;
        Mon, 24 Jun 2024 06:09:03 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 4626760310;
	Mon, 24 Jun 2024 15:09:02 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sLjRN-004065-Va; Mon, 24 Jun 2024 15:09:01 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net 0/4] vrf: fix source address selection with route leak
Date: Mon, 24 Jun 2024 15:07:52 +0200
Message-ID: <20240624130859.953608-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For patch 1 and 2, I didn't find the exact commit that introduced this bug, but
I suspect it has been here since the first version. I arbitrarily choose one.

 include/net/ip6_route.h                          | 19 +++++++-----
 net/ipv4/fib_semantics.c                         | 11 +++++--
 net/ipv6/addrconf.c                              |  3 +-
 net/ipv6/ip6_output.c                            |  1 +
 net/ipv6/route.c                                 |  2 +-
 tools/testing/selftests/net/vrf_route_leaking.sh | 38 ++++++++++++++++++++++--
 6 files changed, 61 insertions(+), 13 deletions(-)

Comments are welcome.

Regards,
Nicolas


