Return-Path: <netdev+bounces-163160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9221AA29712
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 18:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6EB7A2E2B
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 17:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72AD1FC7E7;
	Wed,  5 Feb 2025 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SincgL1f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2841FC7E4;
	Wed,  5 Feb 2025 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738775820; cv=none; b=pTIlf7lWhrrKBSQqE9elyzDEQdGalaGZVT/Ac9Zp2s3fa8yi03B8E9aMYEueezRxm3ittwRnNhFCJfS3IO8nJd00qpKBEw4hg9aQJgcEVrcoN4tmFuCD+ySi3OVzWBmi0quRLh06OIXV648ZA06kKpvc3/YAb6Q6thBkB56B/nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738775820; c=relaxed/simple;
	bh=HGkAqnHPOKtmMRSfsOuCAQLa4bQPzE6IJGRPUNgKpxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSJQ0AdTmi60NOA72Ro2PFp9t/pJ1vUsFU5repXX4w+QufAF9Shfux9aeG0x1p2l6bU16q89upwR8KmtiKu/8wpotzFfa0mVw2Rs97Wi3wgbPWU/3nXkxfkUBg4Fhuu421aQKXZEORQ2uRJUln1gRhGW7gdUOYDg6T3S8xjVaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SincgL1f; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38db570a639so594528f8f.1;
        Wed, 05 Feb 2025 09:16:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738775817; x=1739380617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQMXDsJ+SXzMDP2QUH2Jb8GTtmEVlRcsfi8K0BJi/fA=;
        b=SincgL1f2s5o0THeKpu/mg7lx8hXT3OYa+Ck3+ZeGroR5WPj3eh4/YFfGXn01bLzpZ
         LVEkHi2JVXwv05BUfSZoVTySNbuuRC0wTm1t6YHHxeAaUrcb53KZIYcNzxwFUdY1f4MM
         g/NNL4p8G4Uqm1EzcbLuQCQh4PcAVmPN/hC2XIA4FB8s2qEYxaJ/jLWmF4PgQM5DdRMN
         AQ89tv+FTJUpP5ly4kAdQoaqz0XZe8yWmOyoN2UcKi2K5SKUWCi+KEA6ftoEqcE4CB53
         v507dQkuVxzOyBGarbKhzHKO8kr3DHyG4u5AHHXMu8WRAVvWoQNjG3GF3N8RtUPrfZyA
         QwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738775817; x=1739380617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kQMXDsJ+SXzMDP2QUH2Jb8GTtmEVlRcsfi8K0BJi/fA=;
        b=M/9QBNcGFDwzttxxtoxAloeH+sw0Kdex5KOWnXWok43pfvLg633IU6RrAkODfGi6Ky
         dUqM4cK9dFzaSpRqTkHR9SAUW0lTwXD+OJ/ZCNQew4+Ftg6CPZAq9GvRq/Mx+7sMBxTV
         Z8eMHnNSzQFckZmKsBFBk1tJHnu7X29YDpKCSTu9PadHUwInWXGCLdI9IOquNgsfNsfF
         2Nkm//ACLUSFidKXW7GHEmWAp9RECUK+mrmMo/lGlxbXuqkI/NkZAeeD71qaJtzYDOId
         uNYosSjR/w1yBg0Wx4OmfG84yTgXfubYOXrnP18UUBzo5bi6qJeMoHw85WuraIWVDqK1
         JJJA==
X-Forwarded-Encrypted: i=1; AJvYcCU5ea3PjAUdFpcA4kTUIF1DQgNCRGkDY3Ttzms7qajoEgsVUEmPSFClH+weEH03bYcEdUvFr5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxHOgp/YZAIoLPeZqKmnv4jY6r7vLo3/fITSTGaMex0FXnbCEk
	P/IzovOuOJPvh1c9TDxyOuXIv/92RwFFwa+iK1cPW1RbTHJQi6KJ
X-Gm-Gg: ASbGncu1DpagQrY1uccam523xdRapudmWRflf9Kv4yooVJMj6ZJtJm0D06wL2zqxf7y
	IZJxwtMTg/5aiBcBZx50vAYeKdfBRh0NW+39XwBDmNvI7BPqgOJDLgPPaMYE801hWDvCOWKdk4s
	05UnmMyln7Bvy+o+Iuc+QXozpKsCil3CSEBCqY45avrfs+PCRqHO09wKQkJ0NHJevq96nuC5VD/
	YZGQ7v1JzAb5w7+jU07e6TQtfslPzmgL7UjW1qeui0xaK2J6rbsjabtO+Wjq8wipJ179WcP4Vo2
	gf3TU+eoN/ddL3qZaCxcClqVjJ269DGtYkqTOQJCHt3bwA==
X-Google-Smtp-Source: AGHT+IEiRZdKEQzz104CB7vDS3KpP+uAHK8+sp7Adp/Kw0nnMVg/0Q2w/YJFq2KrnuiDcd2sFW87YA==
X-Received: by 2002:a5d:64ac:0:b0:386:374b:e8bc with SMTP id ffacd0b85a97d-38dbb270a4cmr97344f8f.15.1738775816997;
        Wed, 05 Feb 2025 09:16:56 -0800 (PST)
Received: from labdl-itc-sw06.tmt.telital.com ([2a01:7d0:4800:a:8eec:4bff:febd:98b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390daf4480sm27185705e9.27.2025.02.05.09.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 09:16:56 -0800 (PST)
From: Fabio Porcedda <fabio.porcedda@gmail.com>
To: Oliver Neukum <oliver@neukum.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Daniele Palmas <dnlplm@gmail.com>
Subject: [PATCH 4/5] net: usb: qmi_wwan: fix Telit Cinterion FN990A name
Date: Wed,  5 Feb 2025 18:16:48 +0100
Message-ID: <20250205171649.618162-5-fabio.porcedda@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205171649.618162-1-fabio.porcedda@gmail.com>
References: <20250205171649.618162-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The correct name for FN990 is FN990A so use it in order to avoid
confusion with FN990B.

Signed-off-by: Fabio Porcedda <fabio.porcedda@gmail.com>
---
 drivers/net/usb/qmi_wwan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 7548ac187c26..14d1c85c8000 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1360,7 +1360,7 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1050, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1057, 2)},	/* Telit FN980 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1060, 2)},	/* Telit LN920 */
-	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990 */
+	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1070, 2)},	/* Telit FN990A */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1080, 2)}, /* Telit FE990 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a0, 0)}, /* Telit FN920C04 */
 	{QMI_QUIRK_SET_DTR(0x1bc7, 0x10a4, 0)}, /* Telit FN920C04 */
-- 
2.48.1


