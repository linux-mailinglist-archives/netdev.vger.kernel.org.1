Return-Path: <netdev+bounces-189277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8ADAB1757
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 16:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 809A71745DD
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04D218AC8;
	Fri,  9 May 2025 14:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Zt8ebXQ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746C0214213
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746800858; cv=none; b=p2CkPOlJ5o3aasoWCOhwAAe6cn9DbfGCbliRMwmQBlK3keD1+2ALMzBNCQvhWpYgO1IQMkGQ7Yi5QJx8hLOzl0GICZJDvk7ETjPzF5gmv72Wmp8Ov28iv/cZFraNYNcLzzRKbqK2fTnPjD4JGVg2zrXVUlbOWnpy2X9s9y9Rwj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746800858; c=relaxed/simple;
	bh=2g058fYJyqIF23/EfOu5EW8y2dgIYxrQQrleH42K5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hy/2VCAVpygWtrdAbShcB1oCGUsII0hNavXKnpLrDxpkQlokgy/XJlwZIgWr/KsPtndSLh6T2FDf42uW91dLp8g2BdXEwB9YCoOm69uTk/7rJmeox8P66YxVddcuxXbEhIT55g9dTVch97joMk/8QvX65Vx8ODkDpgNbctMf8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Zt8ebXQ0; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ede096d73so15230745e9.2
        for <netdev@vger.kernel.org>; Fri, 09 May 2025 07:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1746800854; x=1747405654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGZ+cv7gTLUc84IP7586oBmCpqzjR21BlorbhZ11QA4=;
        b=Zt8ebXQ0ZG8L9AxOhyw412rw5AUBP8zcvNLeb7WRakWOhVmzkhMnEPOAxJz4u9+BL5
         BlAqREkoZ4M+pUSDSDqeI2HXX6dVh0cx/403et1T+i9ttph5feU45uy1WiqhVz9okPyb
         94GLWhPD3wOZsR0YjuHCAOQLAJ5ftfFgxs8i0PofM5QFAzs4pV9ffQXPtRd05OCPyK2Z
         9WTTreXPhBDU/Y+bkDO+zGeZ2hg8udyWQ6pB/igNDZs1yC+53iVEcbctCH9Lb3ErseJ0
         TT64IHUCrapO6I3OWExkmf9W0rzAlVZehXdBdplHiD68Cw0UOln5W1ga3IMqpUTIhHB0
         YL5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746800854; x=1747405654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zGZ+cv7gTLUc84IP7586oBmCpqzjR21BlorbhZ11QA4=;
        b=WKHwmThLsGGoq0+kq+7v4MVSiv0oaYgjqSQ6LvnVwPhW+uvlosbN+bbt8EzW0+pgUm
         7GLAqPzCF6TyNbbom5DJORaTc56Op20+MUc0GuFmv5MkOKrTojIxrLnhXejCCIioM47m
         2SYToDhWuqBTlNq2ekK1eb5GtnBzSseQXhBFsm6X1xBx04butWQZcADuEgMaU1ytoMXX
         qMGWmJ6Kc0Lik133Pk2/w5mnrUkRbzBD89iqhATl46Wu2GZ/bz2gmxgOQqWo4B1PV7EA
         kibHRDg0CjmRUt7OWM0ayOgRLLBPB2vkz/gVSG8VnzLEXLKNL5Qi9+QKO8WuZi+s9xQd
         1b2Q==
X-Gm-Message-State: AOJu0Yx/YYDT1QH8v78usfDEpXFIPiwAbQ7UQWuGcVqG+G8cYA/+3/d5
	2nWmid5GDpbvPdclw0eWv4oGhJvRZwjtfc2LGIBa5fqSKJMYl8De414bR84s/sluyrYH3a7Eed4
	r4HjxNHdmWgP2kjVue5Rur5iiY/OZAV9AoyGWVfZjjikb9UMaulCmPGfifyOM
X-Gm-Gg: ASbGncvL1OVR3ZcunWOhiQhf6Y4DHg1x7rUw6aPnOYo5XyHyGnWwfO0FMqGfdDtiREw
	heQJD8NVmBTugOSAR6yLgOOnnj552MFF15bVdVMqXeIOYh3/zwub8EkvjT3yFrhszH0PT+MEjyV
	NPL5phoF8aB6wz5dyQmE3kW/SF5UFUMpIoEzGRcEKUgCQRTMUJR+be7sKOiF4Kv/llYUOxMfUJe
	bdYB0B5sQaZxD8fJd87FsxgyFrFWUBHLJx7xIiWCD7PE2XOz2XDQnvjA+8WCG3hxQkbuSJ+GnwA
	HzcxySpzW3FlFBvctPkN9C9H3dDX3ohajM2vcaDBA+6DxoJ/Fq+Py1XRZiWcxFs=
X-Google-Smtp-Source: AGHT+IEz6g6PfThmYS3QFdoWRsphIPdhmByOtMvRUybeXn98ZJiNgE7G8SDOKLdeJqHYCH6lmuexWg==
X-Received: by 2002:a05:600c:1c8f:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-442d6d18a76mr30009015e9.7.1746800854293;
        Fri, 09 May 2025 07:27:34 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4ed9:2b6:f314:5109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687bdd6sm30905025e9.38.2025.05.09.07.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:27:33 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 01/10] MAINTAINERS: add Sabrina as official reviewer for ovpn
Date: Fri,  9 May 2025 16:26:11 +0200
Message-ID: <20250509142630.6947-2-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509142630.6947-1-antonio@openvpn.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sabrina put quite some effort in reviewing the ovpn module
during its official submission to netdev.
For this reason she obtain extensive knowledge of the module
architecture and implementation.

Make her an official reviewer, so that I can be supported
in reviewing and acking new patches.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5c31814c9687..f107479f1af1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18196,6 +18196,7 @@ F:	drivers/irqchip/irq-or1k-*
 
 OPENVPN DATA CHANNEL OFFLOAD
 M:	Antonio Quartulli <antonio@openvpn.net>
+R:	Sabrina Dubroca <sd@queasysnail.net>
 L:	openvpn-devel@lists.sourceforge.net (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.49.0


