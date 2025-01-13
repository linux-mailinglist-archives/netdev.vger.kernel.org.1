Return-Path: <netdev+bounces-157678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1DDA0B2ED
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CB61882DE4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691D8284A62;
	Mon, 13 Jan 2025 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GoN9780j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD42500C5
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760683; cv=none; b=CKWBqpKIkgawYPqnwVeaDleph30JjY1RSWvrSwlKkwOXtwcApvWekZoElNmICZFQBAnfRec76fiQBgh66FCS3rFReEwikvu0XfERFu9fkU6n9ry6J/vYGJCC6OdHUgA9IdQubovb0jKtt76rL45fTurm/oVWdQs93PJgzc0JIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760683; c=relaxed/simple;
	bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jcV/ucEA9Lybjtp23wYvb8bdbN3KZsg8X6a7sz+vSA6nBahN/vDX0gHa5JCg75a+ZXDWJAfJ/Aq6DBzgGlOMsZkujNZmz8/37QGVcHddJU2PlW0vrzdRFhtSHz47ZNMfHp+J6bb592J/aBIN01z8Kl98QvLHecIRJweSNN1j+XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GoN9780j; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4363dc916ceso30702885e9.0
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 01:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1736760678; x=1737365478; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=GoN9780jfStbLnGjLhiMDMjwWU7JxCr9doKo0ud5aGt6xV2oLqxEVkbw8wrZHguXmr
         ZP9fAu+R418WD9RyK2jYojqJ7bdyZN4HsKNTfUbOzUfhy7RGT071JHLJZkQ1pog9xvED
         mrQqgtpglJZkZ/Pc9lZUXSfp1NB2dJ1SniPrkg6A7pdFf4JPRELY82MBSKXZ5xRpuQcV
         64NaGRaQvuw393k8CNJeO9ROpd7stbOA+ZS0rMa+Upzn/3I9U/8UrqJQc0tMwvcaa7kn
         0KS/OkViwZg+DeuQHWL0kJRJw+h947IbiNPeZE57M+SsC0jWg62VWijjD3SY4/cQNJQ4
         jXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760678; x=1737365478;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=ftMHMD7XOxd0K/1ktycGb93NWcSmbwEaSMJjY9aAkUUuwUWN2KtyHJ0BQi8bTDK7Ov
         PnKZqupK9fSyqhLa/F+Vijs6M+Ec5obXWsOYlSTbSsrTMWlPEqTaYF3JvRL15SXo3e4L
         xxAomvLY7hzr/JUFO3FXqPxKuRBl/khtqAl0Ehva9E7cxEwHD99vKVtAuRRDgIWcfaaB
         DpaZa48CzpC3HNGPZwwr1QN0sSf34pGXg50vj3FWP+oFQT1vCGrhzJ+4PdlC0h3cfbzr
         TvvKBfunw08ljypqOvHX18jUsXHalvNYmT+KAXHIJHLWBr5Z3HLUOv8VFRPHXgcd7LTx
         nI7g==
X-Gm-Message-State: AOJu0YzXYhqW1Strpe/3O7iMyxoUFjQnKZgpDb8sr5uhgv7T+dwq33av
	iJ9VX9wA4Mj3bYzvH0d+02Sb8nWGW3xoq5ztSM/XCu4XS4PmBogrtldrWgX5kfo=
X-Gm-Gg: ASbGncuaiqTt1nAs3jliYU4Supanf1IYQPxUrsjxk/73UiCsxCJ2gXdOv1mxoo6+Jcs
	chSC/aUI6FbDoXr7A3JD87iIikdSr6TlYBPwfBXBhp6ngFTutGFUdl2ZdaVsTP3dqK4CPXqufxl
	YVU8dHTjnCJHjG1cltGs6hPnBVnW9+ZuBRyTEckh4Z6cAKSI/EKEsXVy5oHYBWh6bhBx9ljRVzj
	u6pNmbkWKZ55omBiTGi1GX1p4L8kWlSIZHDTELcco8JNs+3Tto0dvGQ98sKSiGKnjz7
X-Google-Smtp-Source: AGHT+IHLfsuv5kA8w4aH4Pr0dqk2MfNF8U19HKuDPKYd2jqVlC2oE1par9I8Y2kJwPLOpspVsid6Hw==
X-Received: by 2002:a05:6000:2a9:b0:385:e90a:b7de with SMTP id ffacd0b85a97d-38a8b0c79edmr13132038f8f.5.1736760677935;
        Mon, 13 Jan 2025 01:31:17 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:8305:bf37:3bbd:ed1d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8124sm11528446f8f.81.2025.01.13.01.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:31:17 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Mon, 13 Jan 2025 10:31:30 +0100
Subject: [PATCH net-next v18 11/25] ipv6: export inet6_stream_ops via
 EXPORT_SYMBOL_GPL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-b4-ovpn-v18-11-1f00db9c2bd6@openvpn.net>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
In-Reply-To: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 David Ahern <dsahern@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnhN2HpkTrI/e6/gMysMoM2vVIrn0gupbvd6NNH
 qMhAk2srOWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ4TdhwAKCRALcOU6oDjV
 h1DJB/9mlhzno8z3tsn8B7rAHaqaqF/BP28ZTZOUmK3cKMstQvT2s1NxM4L55CXaTmiG9pCS3w3
 vscqsHXcOF2CfhnL1oVDsocrFtQyynxFzZ5l0I5KccwbPVXdB2OtLmYenD6SAW5ttfzQSDFc6on
 nSFudEBU+tvglabI7sQdxEgCD0WVFnUi6f4lxTSdIlctNoqYqdcN9iCho7RgHSZAXRFQG8BpHrL
 J1Wcn6avBq7hka7obiCiXjl0flzsgd4VoX/UWBRXLrQ5XLJjSNuEbEeK20/d9GEpQlbCY9q7RNZ
 J6OZL0NiBVmfqYyOr5AnAEeP1g+X4RC4WrsD9SunTiQSdDeE
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

inet6_stream_ops is currently non-static and also declared in
include/net/ipv6.h, however, it is not exported for usage in
non-builtin modules.

Export inet6_stream_ops via EXPORT_SYMBOL_GPL in order to make
it available to non-builtin modules.

Cc: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/ipv6/af_inet6.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index f60ec8b0f8ea40b2d635d802a3bc4f9b9d844417..3e812187e125cec7deac88413b85a35dd5b22a2d 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -715,6 +715,7 @@ const struct proto_ops inet6_stream_ops = {
 #endif
 	.set_rcvlowat	   = tcp_set_rcvlowat,
 };
+EXPORT_SYMBOL_GPL(inet6_stream_ops);
 
 const struct proto_ops inet6_dgram_ops = {
 	.family		   = PF_INET6,

-- 
2.45.2


