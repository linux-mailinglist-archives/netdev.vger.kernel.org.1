Return-Path: <netdev+bounces-307669-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id my7+MDMhV2q/FgEAu9opvQ
	(envelope-from <netdev+bounces-307669-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:57:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E35A75AC89
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 07:57:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0sec.ai header.s=google header.b=T5zrB1p9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307669-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-307669-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1532D300BB88
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 05:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D053B8BCC;
	Wed, 15 Jul 2026 05:56:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D03B7B79
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:56:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095019; cv=none; b=ZkxWnswGDzPevu1fETQ7NCefxF/z2Vzvq8czfwIuaIcb3i5iXpePBa9I+3r9J4vyiGJHuHUIE5tIsBysPVJg/BiS3lJ4sVwZZQlJN+ZscyfaVhaJUk7VnuSJwtbU5KquKtGXtHEf4JsUBbwfJkIYWweJ12xQ0+RruEddu7eyzxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095019; c=relaxed/simple;
	bh=mOnwR/pIE5XzBsYGILop0yuiJAAjA0tbnoT2QDJFZ1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJqxcq004deMj9naMkB1HsLjoJHsH5rAhxb1RPSDz0GNSA5gxbL+69r5RgUqjl5iwfeH8w3MiFoUTqm0e6DgjNwxsOwrQ1YUEIqqmJVQy67P1/IlEcaA95p7zGMd2n0bRhmj574c2hy4SzM4aaxO1fuOP2AkfAMtt283amV9mTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=T5zrB1p9; arc=none smtp.client-ip=209.85.221.47
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4720d22c94aso1713557f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 22:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784095012; x=1784699812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAOalb6etao4htQR6eohIIXgH1RFAxhgVjEFqDvisp4=;
        b=T5zrB1p9pSYg+XFfJLafCx2fFJHA3XWy+nVqPanzh+7SZpeZ1g2Lor7bUtUXp+8bk6
         uT5IAAziQJwUND2o0ilr1l/A+rI4Nh+F2tnbFO/os1hdR6FsBbcKbAL75cAb0NpSA7u5
         HbozE0ZGCBmtf84OzKBBjIJqpvoT9ZaiQ78Uv5wg21pEgmbQloVm90ysZpZv0Wl5Bl7I
         U5Li44VPWMEmmJMokJbicgk9e3mTeDoZ2T2zTBLOXtObgOaeMY/npLdW4wWj41kt1q5y
         W4JnMMtvt4pcLJxm5HtFouO/8RPbXz4hd9DOevIECH6z0Nn8ehQrG8ITC8FCr5uGufCN
         7w7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784095012; x=1784699812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAOalb6etao4htQR6eohIIXgH1RFAxhgVjEFqDvisp4=;
        b=PBre9War2S31sKl5aSsNiDyEI2BhEV4WMP/nfyZ3CLYOMHsPDdh7Mejw0BmiV9huMP
         Qgg30kFQeDiyf9OhR55HYlbQu9jkZr6ZjzYDifc0W3jq5V2evLumdpxLZ726ETgbaED9
         vEoUO50ZrUSb2KTNDk3Cav6LZZn4m4E0wA9cZDcNslTzojcctmbAYj0hX4l49tV+HzvE
         L+yEB+W1oRSnXb1VuTv3x5Z9OnVCtfGzq4r25tMB57p+UolNgPV0rDZLiP2tcjxNhBh9
         9QFPabNimNTu8LFsWXapjCrtbbh5lk0qNLLHu2AxT2nkpXNynEbYvgIsnLRn1Jui7L96
         Lipg==
X-Forwarded-Encrypted: i=1; AHgh+RqYHciBiJR8vu9UVVez6Hqh2k68sBUSYJTxicjCZgx4dH1k1TEpCKptRYydhhTP2X77I4+k0vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYteKU7xq5yE056bGonDS5YhXos/soVEMg79GmRlonrCgTmow
	uLU5rRXVrnDqJ/X8oE7M2rs5CCsf2ZQP/oki4csGi9NPAwGOgnMN9J0AaLgBQCpy0oiz
X-Gm-Gg: AfdE7cmo0DYzHlptYXtLLc1OVQp31FI91PoQZauy3hGBh5TUQiOB8/owANlAu/CUBnv
	h/+ls2PL99bJlnYzdoZW3eEELSRyRSnoiiB8t9UA9kn6Kw2E/HNmtNWLoeTBnQY6oIn2bRfs67T
	cedP3LW/7ExnjjuEpP8uFJ0++/hC1QxSpTWXY2mpqjg+eQ4fVm0vJ8QmHrxUmvPauvkEjoYJsYo
	U/N0vUVwaDybthMb5y9D2y1+Rmm9WHFt400EwTbKNR3VVd7+G9u0LnehbmCcDZwa+rmjNrf9JB5
	WSSbnx2nTn0iM7j2zeJc/nuE4hzZrDOW9EQeMrlva9CZy9FF+ScyKi2XPOGsqI1E4aGBSMdxA3Z
	XVEVCTDwpdmFrUq03f31chObzf6Xf4H7r9tkk1NFmfViiCTWuFlNUpmNyOtHSFLlpZeVgbleJDx
	Xbx3VobawHYe8eAjABR67PqDv8GeKPv9QfR7eCtKV9Q6vZ7k4N5azTIBsv2ELTX+O6tLqRRpMHP
	m/SgFNXJyn+lzbVs2FnehHTTZMmai6imVs=
X-Received: by 2002:a5d:5d12:0:b0:472:4861:5d4d with SMTP id ffacd0b85a97d-47f2dcc35e6mr17464772f8f.23.1784095012002;
        Tue, 14 Jul 2026 22:56:52 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635082csm14220369f8f.7.2026.07.14.22.56.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 22:56:51 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 15 Jul 2026 07:56:47 +0200
Message-ID: <20260715055648.33060-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715055648.33060-1-doruk@0sec.ai>
References: <20260715055648.33060-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[0sec.ai:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:sd@queasysnail.net,m:linville@tuxdriver.com,m:mschiffer@universe-factory.net,m:maoyixie.tju@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:andrew@lunn.ch,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307669-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[0sec.ai];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E35A75AC89

A tunnel changelink() operates on at most two netns, dev_net(dev) and
the sticky underlay netns vxlan->net. They differ once the device is
created in or moved to a netns other than the one the request runs in.
The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
so a caller privileged there but not in vxlan->net can rewrite a vxlan
device whose underlay lives in vxlan->net.

vxlan_changelink() validates and applies the new configuration against
vxlan->net (vxlan_config_validate(vxlan->net, ...)) and can reopen the
underlay socket in that netns, so the same reasoning as the tunnel
changelink series applies here.

Gate vxlan_changelink() with rtnl_dev_link_net_capable(), at the top of
the op before any attribute is parsed, matching ipgre_changelink() and
the rest of the "require CAP_NET_ADMIN in the device netns for
changelink" series.

Found by 0sec automated security-research tooling (https://0sec.ai).

Fixes: 889ce937c98f ("vxlan: correctly set vxlan->net when creating the device in a netns")
Cc: stable@vger.kernel.org
Assisted-by: 0sec:multi-model
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/net/vxlan/vxlan_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 67c367cc5662..d834a4865aec 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4421,6 +4421,9 @@ static int vxlan_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct vxlan_rdst *dst;
 	int err;
 
+	if (!rtnl_dev_link_net_capable(dev, vxlan->net))
+		return -EPERM;
+
 	dst = &vxlan->default_dst;
 	err = vxlan_nl2conf(tb, data, dev, &conf, true, extack);
 	if (err)
-- 
2.43.0


