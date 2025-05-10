Return-Path: <netdev+bounces-189466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9D8AB2395
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 13:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF941BA2791
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 11:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA2A213237;
	Sat, 10 May 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBGzGf98"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA4A4964E;
	Sat, 10 May 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746876658; cv=none; b=RmDH9HXLju1t9i3sHD+lZuDpjoazYCapSZisE5U0p778G+rkxKY0DPBSG561EjJbsEvBjYUxY6lcQK225CT0JMbv7olfYHoERjFhqxGTdCEKJ5gg7LDesY9QYPnjCgwu/BLA9Hwz3apbnx67e8TJihHbEsTS3aSKaMOESDogT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746876658; c=relaxed/simple;
	bh=wtF0XmfpIZsYhXntBNZdxm6xbutzlBfTd2eRlOjlwjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qAWHB4MsH6w6dKbf9dFHH5uUH/3TLnZbaF64o1UXVg9YJpvkUnjvTexsdYi5XMqPArgal51mbo/gQ3jJ7wU7LURnpZ586TJUTtrwKn8Hz9XQgtqVOWO6ceA2h/GgHR/Korqmp477qMVVFfhp87ZMOw+nsr4e7up+d1gW8qYYEHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBGzGf98; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so2580918e87.2;
        Sat, 10 May 2025 04:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746876655; x=1747481455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8GxR6GVWb5cKv70sBOhXjs+3/VmP8J+IwZswGAdE4C8=;
        b=kBGzGf98Md01e1Nq2bBYYL5BcaAcNWEgWNoSAi5JeOu5uxD7WQlo52BUuy1tL2qg1j
         93eHJH6LDUXCpsYuhsCHuJzNMvH7lLczJfPRyQ1dkphuDrAjL7yZjlsBQGia+uV2rY5G
         Xw6SdxSyvWiCIFHYJfrl36kQWovdw5rzez6mVw3zir9HmjI9/IWCn/6aCkoEht2dquiZ
         GBL2hE9T5rPKbK68HhRn55mlhaH2Jh9IXbvg0zZNQTJd78qVBlPb9RMITxHKUG9H/F6l
         KEaPU3UEOmzFFmCfJGGOCrVHcusqVqC6FDGskdiWnJ8LZQAmm/PqCnu/p+zPdQNazLaP
         ymEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746876655; x=1747481455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8GxR6GVWb5cKv70sBOhXjs+3/VmP8J+IwZswGAdE4C8=;
        b=g6yiJuvLn/JCkqXUfam7a4ja0BSqm04cI9+ryVXnj3GWsuWtkJrgA3PNSc5XRkJF9F
         P0gAdgg//EiSK1k3I4avsWH0Fl6R1GERaJsjzPuCnblXcvinLftWe6i11i7mswQ9klXF
         5DwtmtC66AjliCP0pK/5sSqLsVQVdvx4wg7ZM5kyDIeP044HNFV1HIso1oBzSIz6H4DD
         rc+Jrd2McHZvgGFe4thHKcX7uIqjNzTjmKzy65LTw5CVvvOTWQV5jpbJS1IVF3DD1j0V
         Rsj760pdFjh1JIs/Pg9nbIoIeRQpRZnqDm0u9CVoPptN1OPPiHoBOSCSh8g3uk87zF9D
         Fo2w==
X-Forwarded-Encrypted: i=1; AJvYcCV6hfHcwOq9ZNrhuIrF9QPi3zuNRTmZZtfxhpce6zotHunMxYsgqqBOvDtIJDXFSCt9ZzDFOHqEgWDQrjUx@vger.kernel.org, AJvYcCVrzghjJjSELi3JhEFqgl062qQUkMjYpIk7iJDfSuwyo9D2KUrI3CctoqK/qfGhARM69YnfVYTPWU4=@vger.kernel.org, AJvYcCWt/DP2+fjTScjeJHBgkWrYqmORObvPW5b0iUlTPFL+tE3ILdSq52rC+QygPVriia+FU/bpFPiJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzU4B7ZqUeQr2bdx9zQ+nMKOzolmd7jqfOY/PrSlO0/K3sgp9U
	x2DUvRbYt1J7jGRpgBYB2WL+R6NWXaKwPyGj/ZS30hEzqTaKyrCi
X-Gm-Gg: ASbGncvdDi+TRz6UJELYF8AuZ2381Yz1PeeEcZkQx2q8KxshtCTW5IxDrwqUKYW8Er/
	gKao1xEtkp2tiQZeWg4mGRuRjcbXALEzUhqOyKgjPZJ/k4IiL9tfM96lOKRbWKO0Eb2tZh+84IM
	ErTBXXSGXWD9oufoLmThoeA4dGBeeZBbt3xOPvXf6AB3JSfknl4An9NVdqAyBW4DEpzcu2HE4n+
	CIPaZ4iYXFOOW19IlCc79lIGnp+tDASrnlGLmBd/PrSXbKcBoLglH1DgL3R7NGbe44WN48+FtNW
	OxRDORVyQFGMa2lcA/rZuVrHhgijx7wd0zIgqT+zICfc3aK7g2dnTDtrLqS6wMSp1k+w
X-Google-Smtp-Source: AGHT+IHQdCGJnmSWYsagh05FKuxNnIpg0RTlPCRclIZFNeEKVUygXIEzoVS5fzZRm1GR6Qa9fBlTRw==
X-Received: by 2002:a05:6512:6612:b0:54c:a7c:cbd4 with SMTP id 2adb3069b0e04-54fc67c9992mr2341916e87.24.1746876654578;
        Sat, 10 May 2025 04:30:54 -0700 (PDT)
Received: from localhost.localdomain ([176.33.65.121])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cf27sm635318e87.88.2025.05.10.04.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 04:30:52 -0700 (PDT)
From: alperak <alperyasinak1@gmail.com>
To: kuba@kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alperyasinak1@gmail.com
Subject: [PATCH] documentation: networking: devlink: Fix a typo in devlink-trap.rst
Date: Sat, 10 May 2025 14:30:46 +0300
Message-ID: <20250510113046.76227-1-alperyasinak1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the documentation: "errorrs" -> "errors".

Signed-off-by: alperak <alperyasinak1@gmail.com>
---
 Documentation/networking/devlink/devlink-trap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/devlink/devlink-trap.rst b/Documentation/networking/devlink/devlink-trap.rst
index 2c14dfe69b3a..5885e21e2212 100644
--- a/Documentation/networking/devlink/devlink-trap.rst
+++ b/Documentation/networking/devlink/devlink-trap.rst
@@ -451,7 +451,7 @@ be added to the following table:
    * - ``udp_parsing``
      - ``drop``
      - Traps packets dropped due to an error in the UDP header parsing.
-       This packet trap could include checksum errorrs, an improper UDP
+       This packet trap could include checksum errors, an improper UDP
        length detected (smaller than 8 bytes) or detection of header
        truncation.
    * - ``tcp_parsing``
-- 
2.43.0


