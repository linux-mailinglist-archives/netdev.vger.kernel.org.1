Return-Path: <netdev+bounces-265653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAlKN1j+rmkxLQIAu9opvQ
	(envelope-from <netdev+bounces-265653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:07:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E332423D5B1
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7AB7303006A
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC83299943;
	Mon,  9 Mar 2026 17:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhOsN7Tj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C66B299937
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773075681; cv=none; b=uJPkBs2XSpWIM8VCa2IFrFZKzNvf64D4aciDbOOoFu2rl7numaOciquwg4nd8eIyvmVlUifQv3udmQNhoBAEdPR1ZHMHyStiHOGcCNZ8C2LvTnljBW+n3lQa5Zd0/ZX7jux7HGj7snTS9tu8lGNSsXvDQWPs0ElsIHcVKnMX+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773075681; c=relaxed/simple;
	bh=H5DiuJdCeJiJ1Q0vNDzciFaELOrpulAYrj4LL2milhY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=gjVfhQJDQbDQkFlETFVpNG8eHO1NaEhL9S8p46g1ZFJ/DeC4f4DVr9k6bZ0kBDhNJXgkpXigkU/LTyJvFvnyeAaOK+hxthKzCruShGSIK8Nb37JcOxIu4LDm+wkxRgoqozfzfJz3lbxtfJgU09XdURvPkdbbQ7qrZBOHfoPh1tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhOsN7Tj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48538c5956bso14958515e9.0
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773075678; x=1773680478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bGjAJZg3kAEKg3RqCoiUO430+IHfGMI5W87dJSgovE=;
        b=nhOsN7TjpV79V5MADIDStxPeRFSJN1/EMX38hLYh7+wqPJENHrOJckMKhwwlKbGy9Y
         fkK8Kp+TepE0AypuwPipKGrJBPm8lAaEA+1ANcP4o55qVw/JhEvsagkrVDTGdXNZ5DOS
         iNQzgud8TuPFumAa5w7AkrJLDWYyqEoC7nqYpPPTLgXPSOMzyVTQ2z6CJObJX0++OKnu
         A4z4qoOhree9VMgH8KWOLbI10l6snp1eD0mskvbrp208wdrBC7S+mpC7Q02Qw3MSyCYD
         RjbPGvENu54qFxKE91+Av3hF+HaIWMwYLlv1T6oeMZjWk1XestB/RNqfJt0BcRrU51QG
         dAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773075678; x=1773680478;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bGjAJZg3kAEKg3RqCoiUO430+IHfGMI5W87dJSgovE=;
        b=NARo0DPchJ8uB6KY/pRi3KO3Fq/2o7kFGAswakDff5EcWpVshfvYRkg3Qx/cLV7dyw
         UUkL0eczOmqiRcZc+z4eP4ANC1H2OUwIfRujqDOVoOxdkQ5eer/z3mFju4GkgE9kRrmC
         OwXB/Wf/rlV9tJ81xttwVR6grGZVLzK5CcC7KqfuiZIK9679plA0rZIJfv5GH04Zm8Wr
         Mw8lBVDjIrdXyvX2vYM7AF+o6ZURzflcUoVqPuA2C7QnS4Pf4vYEZROZDHFp/PAr1O9s
         4aBcesdY5WsnPfqiwVu7E9BTZ5zwCiQEN2QOkzzK1ToMDDrrpB7LQML2LSYi0rK8zF4g
         hIWw==
X-Gm-Message-State: AOJu0Yxm+085HV+TPI9JmdG6e1x4MsLFtsiaC5ipR24pH7oAkzBbn248
	CSuBwDuz2f/rLQWAuHNz2NcXrqewEwhRzQvpxTx3CvtVJU28nwG6+DaU
X-Gm-Gg: ATEYQzwREQXumxCzJNyrdBktdnt+Rb/4dBff1VFpP+3cZ8wu/r1RQHClXWmT9r/crNq
	pYgW/nVmJp4fzFync67rOwszGRvSmohpxcE6t+RckP7MUVFsWQubHGl7g0pjmfDv+ue9BKc4a5P
	MNYFPyO5i/0g7EdwT0ZRJnmDFzYvx5cDP3QpzSyiQzZjmqUpBBCWXd4uaAxwAUiwiuByUvzYwY2
	vdnErNJmx7ULXZSiZO2xPgNYO8cGjMkSVwdTyV7K3Uj93T/vwBZaHcjASU815YAR93Rjy5iomCR
	X5rSz8rCu0N2ErbP5xuE6z6SUsZfM/jYGDQP4Npe44Rp9wBxV38x+EA+dUbiVFVpClxmW4Q0+Dw
	8Vh+ePT++ZtYPFBYPTpBiTHOuaQpOpegzrW73zgKCd4gFykq7z62gSRWcaF0FwWSICYY/j94IZX
	Bex+tOmQH4OMo5dcI7JoT6SN5V2pB08mIn9QOP03O3vgA25PYBrSgd8FvJS02PqlbuiRS5lXNwe
	t7kCs9gW7lbCBAiyDRF0HW6mNBWm+4WIPHmnV5tMSKUycW5YBWFTp3Na/b0Sgw=
X-Received: by 2002:a05:600c:5894:b0:47e:e48f:43b5 with SMTP id 5b1f17b1804b1-48541a7f3f5mr3310265e9.18.1773075678161;
        Mon, 09 Mar 2026 10:01:18 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d? (p200300ea8f46ce0005f97f3c5f9a2a3d.dip0.t-ipconnect.de. [2003:ea:8f46:ce00:5f9:7f3c:5f9a:2a3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae3d98asm31393267f8f.30.2026.03.09.10.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 10:01:17 -0700 (PDT)
Message-ID: <9d5724bc-e525-4f8f-b3f8-b16dd5a1164e@gmail.com>
Date: Mon, 9 Mar 2026 18:01:16 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 net-next 0/5] net: phy: further decouple provider from
 consumer part
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, linux-clk@vger.kernel.org,
 linux-phy@lists.infradead.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E332423D5B1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-265653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.866];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

This series aims at further decoupling the provider and consumer part
in phylib.

v2:
- patch 2: add needed Kconfig dependency changes
- patch 5: explain false positive checkpatch error

Heiner Kallweit (5):
  net: phy: move mdio_device reset handling functions in the code
  net: phy: make mdio_device.c part of libphy
  net: phy: move (of_)mdio_find_bus to mdio_bus_provider.c
  net: phy: move registering mdio_bus_class and mdio_bus_type to libphy
  net: phy: move remaining provider code to mdio_bus_provider.c

 drivers/clk/qcom/Kconfig            |   2 +-
 drivers/net/phy/Makefile            |   6 +-
 drivers/net/phy/mdio-private.h      |  11 -
 drivers/net/phy/mdio_bus.c          | 385 ----------------------------
 drivers/net/phy/mdio_bus_provider.c | 319 +++++++++++++++++++++++
 drivers/net/phy/mdio_device.c       | 165 +++++++-----
 drivers/net/phy/phy_device.c        |  13 +
 drivers/net/phy/phylib-internal.h   |   7 +
 drivers/phy/broadcom/Kconfig        |   4 +-
 include/linux/mdio.h                |   2 -
 include/linux/phy.h                 |   3 -
 11 files changed, 444 insertions(+), 473 deletions(-)
 delete mode 100644 drivers/net/phy/mdio-private.h

-- 
2.53.0


