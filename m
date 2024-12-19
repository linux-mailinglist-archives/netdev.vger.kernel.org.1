Return-Path: <netdev+bounces-153176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FD89F720A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A861894A2C
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC181A0732;
	Thu, 19 Dec 2024 01:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eIr6wwXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ABC19F40B
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572542; cv=none; b=HZJlHa0ysBbfNkKG6s0Eyz1FkNvEk+6KDonk2pFTvxL8RkBDj7zLXMx4SvL5gXDFbbvhcX5KKMxRHZn3loEHgaUsaC2vDtvoL+5A1TRhdfdH9QEGBZE+UUqRb4A0MXkeQMCLS+VeKVURTtXVhMmE2zC4yO/82esALnGN9ye8krY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572542; c=relaxed/simple;
	bh=xVfdmalsIUFdZaZj3wkp00YkTZ7DNsXUfUlkMeI4mck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ut6hyyBbzae5EHS8ddDyEJosTwDYnT13SaYnBd4rRIyTwV0dFWwgFq/PZoLmCZCC/326aNVkbsy/k5U7DzyKM+p27TP2KRqAe7ctzJU79ceTVU8m/TkxSbb6aWDOCwQDNYe8hkz2kx5RXLwrxVhB4nuJcSjfPwtKuEP5TP92N8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eIr6wwXK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361f65ca01so2581875e9.1
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572539; x=1735177339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=eIr6wwXKbRxSG9Z1+tIFKxcTL+lnFPwKkvp7Eyyw87Prq79rsQ5Sc2Jyjv03DUshk0
         HwIPY+VDyqlTLmMQqSk8Na2jN/gQw0aOnAFIfskMMW4EAXebN3RRYgRr1ll7g6fngZKp
         3l1fB7CvZlcDIrTb9GXP6HTfYOQcwgKJ5Ep/uEqsNTSh0Zj4MEDXBC1sleCzpqwLS05M
         Ub/prIoWVGvpYEEWOwbmdTs58xhoSb2yWyaOY1c5cRXHDQrmaur4KhkiFxFisiLnF7wO
         0js0/7sI+O1kg3MpUpVIkgr2CSRGivwuFdmw8uSenX8dmKK6wLz/uieIrg7hG8UScBX0
         qVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572539; x=1735177339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtJVavG/GcMgpuSCqo0A8YspwTl4lu/lWPyS3Thy+Vg=;
        b=RV+ymhb+F4qZpRevaOoyrgE6dfNmj6gX55ovtyh2JbrSOyskHZlwz1PXYPmjAYFWeb
         m7l5+SKoYueyhg8ciGbv9GgGZ97HsIMaYB4BPh1Xs3WTDiD+0pV0afOo1Fc6feEvvW1+
         KWcLyoZP6iik4EEjh4FgiZbbU8WkSB4juGgkZjEpM+J5aosyHXU8h8uTLRiAwQJinZx2
         9ap24kcdil+7r4KhQVx5nsMxmqaAfiCbW0sLqq0IyehLhk/nxeDVC12mzNoxnINah6Qw
         niQ516GqA22Wtkj0C5pWVaFngafU4NGJXP7P336tQSgqO5rXWwNUPcqf46Uqn3ijEcEK
         5d/w==
X-Gm-Message-State: AOJu0YxQ73/9JpWp6tj7W+rhluS8n28nKxOc5SnqtuHocbAEMI1hAMFX
	wAk5SIErO9OzMBJ4uahU1JqrHAoan2q2SbnqBx54gkWlWqQeavp9lqrgS41bJqo=
X-Gm-Gg: ASbGnculzNhIJZlSiwFtSfpnMNCXMHuGQTCiJG7/skgIxNkI5svJe7cIv5cJd+Xch/l
	cgOtuLaw5AraQowX2pZewVR/JGRW+9EbNAulZQiGnwh6qI8yM/Uf396o8FTcH6jqdEHBFwnhEjj
	z5REjk2/DTzdx1VxwMtLCC525TsFqzs8u2rgwkqlFnJXwLUW61YpPVXd5cBTTbQaYm4zEuRVqQO
	xRdnQDfs0Sagiaox5snXO5M6QN4OsI2wC09wYrnKE74/F8X84cmaAQLt9/n3QKTA1bt
X-Google-Smtp-Source: AGHT+IES1iXSDmvSRtMbi6ThFhw120yxO0lzW3Hg6aD82ecOAXbKX6Yv0j46g+w+0qqIg9/MLf5PKA==
X-Received: by 2002:a05:600c:3106:b0:431:12a8:7f1a with SMTP id 5b1f17b1804b1-4365536801amr46854065e9.16.1734572539241;
        Wed, 18 Dec 2024 17:42:19 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:18 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:06 +0100
Subject: [PATCH net-next v16 12/26] ipv6: export inet6_stream_ops via
 EXPORT_SYMBOL_GPL
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-12-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
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
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oVCcgi7AoSdQOjNM4EimcsGxYoYh+dn9aqe
 pCq2W4eq3OJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FQAKCRALcOU6oDjV
 h/phB/9W4sqKWQFFCDuNSkQkv231SVMZT09jfSKtzlpg9vPnv8dPfeJhN1xqaNai73noURjlXXZ
 ojh/9JGGbXbV2t7BvUvlEX+dryi2lq3mrH1KvTocEIoY/bOpCW714lcvYxP4Dgv5mRYiY9DQfCf
 NLha7Qu8SImZzONXsSl0ReJ0D2QrdHHEsCu9kxyaZwZDpabZ0SsPspcTdUwC/mz9uThgiz3ld3E
 RbGaBMoP9nl6hTaGj4IkI/j8uiMy4wP2V7+1ita9n8U8t9VR29RYtZkzSqyFnLr3H+42VpwSC26
 cPNuNawlSWxe0Z5M3MJC+s8Cgq39rl3b5RlrNq+34XB9oUUP
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


