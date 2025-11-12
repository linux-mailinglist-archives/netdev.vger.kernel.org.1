Return-Path: <netdev+bounces-238132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E43EEC54820
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 21:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75C814E100F
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 20:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8B2D298CB7;
	Wed, 12 Nov 2025 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsFte/Vm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1528152A
	for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 20:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762980386; cv=none; b=DYHKNdovfZdLhnsp7CFCXqHFo/Zztcdr88P59bcNqyRTX0pTUMH9wynThUnzN5fXXBmpHE2rDGIjzrvvETqoEQVJWP8d9ofbR4RYa8i/GPusMsnjut7t9dSANW1rEiFxKVT6M1gZD84GojtciBapoyPudc6XAbEtDx3DRQaduOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762980386; c=relaxed/simple;
	bh=CKVxtr69x8HNtnzAKCfOKwXcSYjIVbehDsn0oy8VNCA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B3U/GaHVN33kzcrwcD0g4EQtbkeEsoibPDCM3XN9GkNxvEyKzCJiXaEPFyI8FbgPLyLOF/bzsStuMc46sDntlVU7RFngruyswGE+2e23LEiQjTZJQBpdcwWFDzgdb3yXx6dZeb1qB9PGaOUdG7j1P32+RewKUmc3VXa6GpsP6/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsFte/Vm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3ac40ae4so61243f8f.0
        for <netdev@vger.kernel.org>; Wed, 12 Nov 2025 12:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762980383; x=1763585183; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obxXDdEw0EEdoLr3oUVBzLf/mE93I+E6MyrIsx4I+x8=;
        b=DsFte/Vm+BfrKZQtoA+2lZW0dewD5T5ZW1xpg0+XUpKiA7px0p9Bp2iQFprOB5ESzJ
         FjjMHqpbO2H7HgbEYXq9Xc8B6QYuRfPutYhgDOWFBtoNbcu9dLH5qNbbhanmSMT+uuXD
         4equ/aanICKG5Qfes1Qa9MalLsDyrUsTcd8i7aLdjpgPpoYoNfg8gJTSDg6pCqqDmw2W
         VYpjN+XfuoPZpzxvsZ0yY4UxlmIe+uYGB+f6XOf54DEymrrgxUPgR3IntDPnMFqaG1VS
         XqPqQdF4R/Dgen8u7yVFJfdhdIbZzXHyr9MeIDy3twdCQyMgnisDJahb4YQThWwhAtG8
         Yxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762980383; x=1763585183;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=obxXDdEw0EEdoLr3oUVBzLf/mE93I+E6MyrIsx4I+x8=;
        b=LVmQDb3agiI4gI0XkpKEodkiSUpnGr52Eyo4uiLBlPEr19/Y6bbOwFne0nlDzqdBxL
         L+S4Slnv86U5StoeiuNaLeArKokvfSCb9CG1qVfAoU3/bH1zZxojFUZ5y1dHn2f83dUX
         AX0E6eX40HMehpFE1YCW99LIC2niCUafc5sP5860ABiCKq0uHdWsUhyhGaMG48binnXV
         a/XKplrcfl/gJy3D/LNKvisCEX9/NSUF79KcosL5aLTBUnXUq0t4I9mviw7t0NfLKiU4
         EfYXgmPAY8EWgOBWjluXLKjPhYak8TaSI/zbhOm7sI/qVnYjngnEA+Mztef+tov6UY0K
         FWug==
X-Gm-Message-State: AOJu0YyOo4FkECx6WFqQL2oGL1wqhieLG7W9042qmg11RsCgG2934Gh/
	Z/cVEfqAJpx/v1sVmD3/mqqblBsPBqZ8wBKPgWstQ/WxN32BLhGNjVxV
X-Gm-Gg: ASbGncvRutlaJW12vHIWwR8X3CbHbxF4OgaJUObF4rv9G0+0vjDuyQapeXs6vCgZ+hn
	qvNbVkB1LbTjD/oE/xBEPPtAW6n+eiTtYWL/qQqLcSwcgVVOLBsZfYpihena+wiJ9lQdWBWW+wR
	QvK6PihM9RPlDIr6C9/E9/BriAIFKGOuTPW8O11XROiw/hRm1pjeSkzMy6aNbNFd+7apnQzLF4d
	Z3Ff1pxnoHrHlUFo8ypkGJ0Isq6NnItsjMmKQ76Zv/vzrW3by/aPLNam9RN7zYo0TW112sS/eCQ
	fAHHkmd9IIbnRKpVlDgYZJ0ow20esmGd5zFz2QrpR51Q5GLvNxprOHywO83ZAy9IfHgfORPEBpy
	ECWk8/n9dZR7OxEYRCqRfiekUD75uuKPXrOI7bUcvY6W4FFh5UYnUBy3Y4Uz2e1shz9fBgGmaDw
	6WuX5Vn0kT8eDhiEcBBQJZZfQqFUHXzhKS7Bgi5WVvSY5BPZa5fjmG//xsZmK0I7I3M2AJVUHv7
	5NzPOXpj+ivG4vP/TAMC5Dadq3O1p4vDdBELlgV5aY=
X-Google-Smtp-Source: AGHT+IHTx0da48J00z7xJf3xHrUP7JJsuinGN6GpFozhG52Q2Ue0BhkNtSIPLs3qY49iYA4ImTloJQ==
X-Received: by 2002:a5d:5f87:0:b0:42b:3ab7:b8a3 with SMTP id ffacd0b85a97d-42b4bba597emr4085926f8f.27.1762980383124;
        Wed, 12 Nov 2025 12:46:23 -0800 (PST)
Received: from ?IPV6:2003:ea:8f26:f700:b18b:e3d1:83c0:fb24? (p200300ea8f26f700b18be3d183c0fb24.dip0.t-ipconnect.de. [2003:ea:8f26:f700:b18b:e3d1:83c0:fb24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b321a80c0sm25390533f8f.1.2025.11.12.12.46.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:46:22 -0800 (PST)
Message-ID: <4053a98f-052f-4dc1-a3d4-ed9b3d3cc7cb@gmail.com>
Date: Wed, 12 Nov 2025 21:46:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: dsa: remove definition of struct
 dsa_switch_driver
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Since 93e86b3bc842 ("net: dsa: Remove legacy probing support")
this struct has no user any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 include/net/dsa.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index 67762fdaf..d7845e83c 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -1312,11 +1312,6 @@ static inline int dsa_devlink_port_to_port(struct devlink_port *port)
 	return port->index;
 }
 
-struct dsa_switch_driver {
-	struct list_head	list;
-	const struct dsa_switch_ops *ops;
-};
-
 bool dsa_fdb_present_in_other_db(struct dsa_switch *ds, int port,
 				 const unsigned char *addr, u16 vid,
 				 struct dsa_db db);
-- 
2.51.2


