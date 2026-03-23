Return-Path: <netdev+bounces-270340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBO4NZWdwGnrJAQAu9opvQ
	(envelope-from <netdev+bounces-270340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA892EBAAC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 02:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5234A301AA6E
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 01:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C34C22157B;
	Mon, 23 Mar 2026 01:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NB11JN3D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A321521FF2A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 01:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774230882; cv=none; b=qwk2uo3Z5khAGpa/bTZ5tjfXhDBKx+5fH6a78Xza2mgGWIBUYYnGiI6JkC1Wf+wmflJ7UYgOYPLocGxHq5b16BFTd3Cx6zoFePlVosMTTghu4on7ZvCQ/ADUxbIkNS8YmDB/JquhXpalehfHT4bRcAmy8Vicb6N23qQtvqplwC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774230882; c=relaxed/simple;
	bh=xbnlmh3BuRwGW7Lqvh/ofqvfdIvaooTvMkXqmF1U+S8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipKknMjwOctS7CVOQWbwBP8ApxNXsswRJiMmDKhyuZso4u+7dyk6fYdt8aQOXBKHbDJF+OP0zmjA8ZFhwhwkxNHyQLPfLuvaKBK3AP0+b11grsNEQdzEzkx+r0EOxyCPyyhLhLxGZcvzTaVEqsXPwTTY2aH1ZtHkTkJGFXPH5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NB11JN3D; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b6b0500e06so4159774eec.1
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774230880; x=1774835680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnwwlSjzqxBbkaN2QOiq4ejjgo89iMENabtsUNWy5zQ=;
        b=NB11JN3DRmrEq/F1+ZU5+wKHjSa9j6UypHsCv0QhfvFaVO3Aylm7Nq3K0ZTxgZlfnQ
         lTDcXaei8GXF/Raj0P6phvzD7btSvi54sXWtuv8lAreghZ7c9SCohgCd4lS/UL4lmiT8
         W94uLTAwFL0MSCI/WW6WGBHG2QS+8C22oxgsHhX0uAnCJPW2BureWxUvPSMUEHI/mn57
         vwyv9kMmA4gaSgbWlRqsMYjIBxwjmYVg4TZXdHVWuMRxw3SaopdXg9nSsx0fetuIdJ8H
         I/RNR7hVt0vgvtvZ5B4bsA1yyddxWgzffR2h+GhiKn93cXxwI/8lwGNQukS8y5wcYEBs
         2/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774230880; x=1774835680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PnwwlSjzqxBbkaN2QOiq4ejjgo89iMENabtsUNWy5zQ=;
        b=nNp6B4nrIufAySHMlj4pxhKGyGSJ+HKY0N1i4YopWWSDZIkXnewta1RHP3uyiZm/2Z
         NBz1AMt/xRb+6/PVw12fm05JzCvguYeanuKggVuQFJ6t7zzElcIZwvj/qMQ6WwChRsSC
         GBn0U9hIRWWMu3ru4dZTIxc/3Jx27xTC9V+Mrc3KRhLnlJ2k8Tdjsog8rNa2Gm4jKLIP
         6I2lUMUm3HkUbzmMAoOLk/ESHtxe8qH+I4Ec8b/f/1MAEK6ahLd0o+V8aTgkoXlNH8mb
         HfmCiZ4ki0AO9rQ3W4yhLBvrca9orqPvFQqrN+RKNYHPDthRPT1pXXCOhYJcFMQ58g1D
         NBkg==
X-Gm-Message-State: AOJu0YxOfbgBbdnIFdfARoOkYyz7hz/6eneqM0ja9izYo45/z9X6z9yy
	uRLfFavyPau81Cc8nekzGm5aVTw4cMXP6Dtv7vRAYqR7JSbCvgiWjKX7
X-Gm-Gg: ATEYQzyCz3AlFhOakpCGSiW796+O1N+MD5+YKI8UUZYuAlYLJ98p3SNvc4TgojEYLV8
	cVAcdR2ASyUF6rW34eWBWMJdR143N1nbAiLmVgmh8mUEUyZSO4IB+57MnOO9SakNYR0iFIcByKS
	oHRATuIIK8JsXZ+rGYUyW5nb9J/9KfJyxiLYrmtt7TDviYW4ZpmTjzIwICUam2v8WCWW/e5bHlh
	hnxUZYWHlRElTa/nNzJtNPPJ/s04Kp1nEFk575iHnEAqWu+djcIKFzEi2hsI2JI0DST4MVIlR/Z
	pVFfEGrxQNFDndpssYRgkIzdf4uJbtN3UpiKtbHXHy6cJfNqGYwGeUliAou4N3+xr4AAkSGkBGN
	vr3oIP2Ar0aKZHoP91wMbTqftafkcFLNymM+z8nt3PxpICmIjHTZEXUf3+6/NK1VfXvoRjhekDX
	oolEk0bYhfJ44FdNazsLnVlTorh1l2OOkKBUdAMNGMHNyBnu59z3chxWkgXoICrRWZDvcMBGNDG
	a3p+dZuqZUlWHc=
X-Received: by 2002:a05:7301:4198:b0:2c0:c415:cfd0 with SMTP id 5a478bee46e88-2c109666ba0mr4196054eec.15.1774230879729;
        Sun, 22 Mar 2026 18:54:39 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:b768:22ed:3eba:aeb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b2cf068sm10976952eec.22.2026.03.22.18.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:54:39 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Peter Rosin <peda@axentia.se>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	driver-core@lists.linux.dev
Subject: [PATCH net-next 01/10] net: wan: framer: switch to using
 class_find_device_by_fwnode()
Date: Sun, 22 Mar 2026 18:54:19 -0700
Message-ID: <20260322-remove-device-find-by-of-node-v1-1-b72eb22a1215@gmail.com>
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
In-Reply-To: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
References: <20260322-remove-device-find-by-of-node-v1-0-b72eb22a1215@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6826
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270340-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linaro.org,gmail.com,axentia.se,armlinux.org.uk,intel.com,linuxfoundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3DA892EBAAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In preparation to class_find_device_by_of_node() going away switch to=0D
using class_find_device_by_fwnode().=0D
=0D
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>=0D
---=0D
 drivers/net/wan/framer/framer-core.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/net/wan/framer/framer-core.c b/drivers/net/wan/framer/=
framer-core.c=0D
index d779b03a9e1b..77ef1bfd476c 100644=0D
--- a/drivers/net/wan/framer/framer-core.c=0D
+++ b/drivers/net/wan/framer/framer-core.c=0D
@@ -745,7 +745,7 @@ struct framer *framer_provider_simple_of_xlate(struct d=
evice *dev,=0D
 {=0D
 	struct device *target_dev;=0D
 =0D
-	target_dev =3D class_find_device_by_of_node(&framer_class, args->np);=0D
+	target_dev =3D class_find_device_by_fwnode(&framer_class, of_fwnode_handl=
e(args->np));=0D
 	if (!target_dev)=0D
 		return ERR_PTR(-ENODEV);=0D
 =0D
=0D
-- =0D
2.53.0.959.g497ff81fa9-goog=0D
=0D

