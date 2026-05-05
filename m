Return-Path: <netdev+bounces-284335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAFLHojL+Wn3EAMAu9opvQ
	(envelope-from <netdev+bounces-284335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB83F4CBD8E
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FF2D30F22D3
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CE240B6C1;
	Tue,  5 May 2026 10:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL7KwgJi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48FE3242BC
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977750; cv=none; b=NupsM06DI6ysQjamWUDyzJ2DMl3Ujvi/T++YmpxxUcejtCQ71VCoyXo8x/Aluwv7nfs7IskzK1gFCk2epG1fO+axHN3CB5hoNFallF4uM/Cx2jotKv5ttV4MVFxAROYZk/w6NnJWRrHiAl7yXTbGYIroF+NAUOEL7xCJRhqGBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977750; c=relaxed/simple;
	bh=hrwnQjibpj+Gvrxg7H38spBNIlmQIG6bHPm0PcK5eRw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Gmrxn5wrGTvy16UtYml1egbKF3X0TB4rfO1fmJdrktuy0vxRVjkJLiJ11427OV5BR9rp+IPTfREmFbXjuNgS/UaicYKy7TEeXK4fNgPJjsW2+jppyx7LL71sQTRIeLdWJuc1StDWt4q+GYLKI1ejlXb/5LtZDgdwiaXG0PXiznc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL7KwgJi; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6966d16b978so1803696eaf.3
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777977747; x=1778582547; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap9MrTI17gF1EQQMix+Pb5fYRN3jWL2MaECpfpplGfQ=;
        b=LL7KwgJi9RCRCJsNIOZ+QtzekBPzQFVTNuNGDRWAK0d16tF7dnjaASOEbqvINN95Y+
         0iwtExarladUPj8adgeGYFnH5Q4VnH0k84o3ltYwkzql9yJpdOXunHrjKPrK3dVPaadG
         jg/B/pFYUIJUvWcfA39nZkbfj7PODAre7G02Fh8iN2tMSm1JAIwv+pWTsiIbsro3hYEX
         UdVFPxXxokIu9LNAkCuMeTCQk0QbUlBrWyQLwAQwZfVb+5ig7aXRPc9Qw5iRxcl52Tce
         Qy/suWIKgOpfiny9m04gC0CKKeom1FV/6nG4icP3s78K9lss8rxiDqSNIFpN6ciqxI0x
         /XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777977747; x=1778582547;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ap9MrTI17gF1EQQMix+Pb5fYRN3jWL2MaECpfpplGfQ=;
        b=W4CznTf9usYXWGZ+Qq8cOETYQUepkIxQZBI0MNVn5VFqC0vHkZ+baLxvlt5H3dckJl
         fg24MLv03TAVW64qy+i2kOOCz6e9RIQL0gLqo9mmjO3xrEAMy64yRYNGJM/17UxIlbuE
         kxuW7Pj99DSTzt8mEdTzNATOXgaErIoxIYYy4QbASzK8jxx1JU8AibRv3SP9b97hS50U
         Vya9jKrhaInq2ZVV1wEKPPS/hrQQwUGV5PWxw1pjB8ABISCxxrTAfpoBlI+2lZKaGuhX
         UwASdfepX5vtcIAKE4IDHUv7YLit05zTWVcKbA0OtckRfkdPeVIRl8suZFsPAP4oHbSL
         vjQA==
X-Gm-Message-State: AOJu0Yx6soVRx395GVFW0Vx6PrW1y9hRaqP1rL6njHMEL1ZwcYCWdkBd
	TWq1kyxU7fqiQLxgJVQB/BZN39m2KpHdNwZ0/a9kEsSASWBb5uy2fhM6
X-Gm-Gg: AeBDiethCbfCQzEANghDLOzyy8khel71R9fhNKX0krNot3bAXgqNQn8Ym4avJFxGten
	k5zF7Mcaj6BahWpItp+BO2aU2Y1dH+1ZQ56jZGxGEXCb6ZxlLLwxEEXbRFzqzQ40/UX7p1TFWkU
	5aChdERwft0CIm9SMN2cXUI5xGu1D8Yb8Rg2YTBPs3tbOLn0/9SNQwAe408Y+s8HrkDGWPoZs9+
	Plz8EFjrnPJ46+0wYYdqtbUc5RmBqt1OtML7l7H6C2ycgurB2e3xOQHIZCr6I/f37bmacGzzyqr
	WM4MwvaNeCp4H0kIrsD+zLzMl661pu0mZScbNpTRxyDbxyOhCtaBHNiMvx+ZMzqKkuuL2XCy+Iy
	ZWjpu0+m58OVxXTdhxizlEPnaXKXHsVU2LsU2X9mxn5qb/iioMQ7XGivnBZcHeLAta2WXF/Ux5L
	nAZUoduJOBnup6lmMf+oMvTLL8zaIYtmlwNDlGW3Bf8FrizOZDsa6/6MCwbtOVdQ==
X-Received: by 2002:a05:6820:20c:b0:685:ecd2:40e9 with SMTP id 006d021491bc7-69697e1b6a2mr6917324eaf.59.1777977746667;
        Tue, 05 May 2026 03:42:26 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69689479359sm8233497eaf.7.2026.05.05.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 03:42:25 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
Subject: [PATCH net 0/3] netdevsim: psp: fix init and uninit bugs
Date: Tue, 05 May 2026 03:42:22 -0700
Message-Id: <20260505-psd-rcu-v1-0-a8f69ec1ab96@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI7J+WkC/x3MQQqAIBRF0a3EHyeoWERbiQair/oTE60IxL0nD
 Q9cbqGMxMg0d4USHs58hgbVd+QOG3YI9s2kpR7lII2I2YvkbmFh9QQJ7ZShVseEjd//tFDARWu
 tH//gDQJeAAAA
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: CB83F4CBD8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284335-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danielzahka@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

This series has three fixes. The first is a straightforward NULL
pointer dereference that is reachable by creating and destroying some
vfs on a kernel with INET_PSP enabled.

The last two patches deal with nsim_psp_rereg_write(), which is a
debugfs handler that reregisters netdevsim's psp_dev without
aquiescing and disabling tx/rx processing. This was added to enable
some tests in psp.py where a psp device is unregistered while it still
referenced by tcp socket state.

There are two issues with this code:
1. Calls to nsim_psp_uninit() are not properly serialized
2. netdevsim's psp_dev refcount can be released while nsim_do_psp() is
   reading from it.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
Daniel Zahka (3):
      netdevsim: psp: only call nsim_psp_uninit() on PFs
      netdevsim: psp: serialize calls to nsim_psp_uninit()
      netdevsim: psp: rcu protect psp_dev reference

 drivers/net/netdevsim/netdev.c    |  3 +-
 drivers/net/netdevsim/netdevsim.h |  4 ++-
 drivers/net/netdevsim/psp.c       | 65 +++++++++++++++++++++++++++------------
 3 files changed, 51 insertions(+), 21 deletions(-)
---
base-commit: 07d99587396024932e02474c3a5bede71d108454
change-id: 20260504-psd-rcu-aea28e0e2c14

Best regards,
-- 
Daniel Zahka <daniel.zahka@gmail.com>


