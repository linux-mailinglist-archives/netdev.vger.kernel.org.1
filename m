Return-Path: <netdev+bounces-225770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16142B980C1
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95D407B0E7A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DB1224B05;
	Wed, 24 Sep 2025 02:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iiJlzNFd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBA222127E
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758679607; cv=none; b=e9JWHl1+KnDsFS0/M7VJ40/PuwCxB8hueql8QBevXOH6mPRpXl8iGTQs31fJnNJzjwaYvBWm8xO9z2Hzh1avd98pjU9a6uZI4Zu0lP5pL+d2ZN/VtBPtqtuL150PhI98KsEjkUCB0CpVBa7mQwG6pT+8eDNRQHXG1y1ijOyJuaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758679607; c=relaxed/simple;
	bh=SJbHWlbvJA/01zIZ7Y6v2IHBI9WiHdTgUa7T2tMLDKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ft4FitmEwU+8kyC9t/Ebcan4BoWOKN/g00k2R5NnRR0fA3Az7z7Tenb1hVUm6Djhn+I7tdnFxqKkftouj4zTmS3+gxC0+/qk8aVb6h2Fq3mfacMAkWpzTreGogjDWRtv7Z9ucUEsats1l2FS/b43ntFfdKPEnM4H5FxCPZ7bDpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iiJlzNFd; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77716518125so3341624b3a.3
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758679605; x=1759284405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwTsINYgLAubnrIc+zvaDxzMOPdaYgdoD6PMu3OyE78=;
        b=iiJlzNFd2QsQmb/jor3WwzljFOU87pfqPEsmInV/maWE06nzxORVxnpD/tKKE8cj8T
         2azvzeax6Z/E+r6Le8SvUF51WznvOTSXPKAtxXX5rdGfIw5zfeSmIjqf+iJ4NyfEu8sk
         OUqTJa0fv2UxK0PFNGcqdNM8dZpg9F/nSdYJscQrPbXAfswyhjiCeOyf2OIJpTe+M4Om
         hrK31jY55ejDqgnimzMJZVfNlj6i+Toz5OO5Nwm54pmo17I1LZ3GEWiPLAUDlG0Yth16
         CGYxiJVuRMSK5jlBjw1BL6qeqBo7duJgpaNJRCatrRkmk7ueyVfhVSuFapNfxUkoUw2Z
         1L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758679605; x=1759284405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwTsINYgLAubnrIc+zvaDxzMOPdaYgdoD6PMu3OyE78=;
        b=KuUvZaUM7Yv3STPlALZ/Y5ic5sI4dPQSLBiKhp/3cIUuqOAnxAHt9PRqrxSdgTw89/
         b89XbpQ3YogaybFqmP15QG74mgt/WGHx4iNcjlkjyReL5wZiTcNUkTA7lLzIyZ6w76Qd
         MDsoIrvSL1OhHyndjOzJkdqvmRyqVnq02RQ+wVrYjgN4gqy0+BAqtzuvcFaW+HnoMvIv
         olAtqf8z1vbbbAOB8un8YXfkE4YA+dS9D9mHFAmdl54zjGrMBb3+Vp3jD8F36AlmQSNl
         Pw85Rv1psPVpzPbFob3YphdppzgKZ8NBEJoUTdqj5zIAgOV9ujZPhZiERPbPg1vk7TlA
         +LAA==
X-Forwarded-Encrypted: i=1; AJvYcCVdd02slt3ryPOYgCrSd32L2K/rpkh2YUpDMCz1hc7ZvHRJf1m1pe2DSQ5mlwDqprwLrWjvSr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQDzGVSxngNDDcL2BC3QnYT8nCz6mDCHpr15UINgY31Qc9BTh
	qX/boAUvipNHo83YppYBDw+ZQ9EwBhhHfXAtCTili8gYrBkxoXA7NGP8
X-Gm-Gg: ASbGncv7LllwhaPJINhlsOfgCgsNqXB1sRhVFVEzQldZythSccErjg/77aCSdAneaP6
	MzkHMTls5s9CmLepy+Wso85ld0o+4l4YidHh6B0l/dpz+wXs7Zu9G6Z+S4o97inwORYdd/E+wJb
	uWwAseTxtojitx+gMQjnI74XeOhbC0/YPqQYz8lAflVBd//OIRe+gFJWGXtZFPiKH6Wr0JVF0IQ
	0UAFQuFzmAvEKqCXGIZMdAbsLCykYAtu2B6dap04xgInmsnTR0PnbX4t2xYosNjydQVm/Kr3bSS
	I9i+rlHKUXoqJZa580b+DGoDuG0FaI3ap8/CZli7ihSfYv/Av+vxMt/xa4/aDhJ85L9nCjj7TU1
	AsyGQV/hNoql0dw1nzTnaAu5k+gybVYlf
X-Google-Smtp-Source: AGHT+IGkf78YC2sKEM7cbsmrqX1hFpvzRBYNzQq7EPVRv+Rq2UBgzLYX+YUWp3EP4vlgaXWZwiW4JQ==
X-Received: by 2002:a05:6a20:3c90:b0:23d:ab68:1b7c with SMTP id adf61e73a8af0-2cff9a39f41mr6933117637.46.1758679605150;
        Tue, 23 Sep 2025 19:06:45 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77dbc8e7cc4sm15316561b3a.29.2025.09.23.19.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 19:06:41 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7AD49424C03C; Wed, 24 Sep 2025 09:06:39 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2 1/3] net: dns_resolver: Use reST bullet list for features list
Date: Wed, 24 Sep 2025 09:06:23 +0700
Message-ID: <20250924020626.17073-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924020626.17073-1-bagasdotme@gmail.com>
References: <20250924020626.17073-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=bagasdotme@gmail.com; h=from:subject; bh=SJbHWlbvJA/01zIZ7Y6v2IHBI9WiHdTgUa7T2tMLDKg=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmXA9N6vq/JfJ2+ySTG72ZEsG6Q87+q2xOCluT8TX5nc eMiq7BLRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACby/xvDf8+9L7eVcr/33af5 TGhFt+LhmKVCCvtSrnu/erI2ff7huD+MDLf2rblYmXD1TNSJVTK7H31rWuMmlHZli9q7N6L7F/k KmzEBAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Features overview list uses an asterisk in parentheses (``(*)``)
as bullet list marker, which isn't supported by Sphinx as proper
bullet. Replace it with just asterisk.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/dns_resolver.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/dns_resolver.rst b/Documentation/networking/dns_resolver.rst
index c0364f7070af84..5cec37bedf9950 100644
--- a/Documentation/networking/dns_resolver.rst
+++ b/Documentation/networking/dns_resolver.rst
@@ -25,11 +25,11 @@ These routines must be supported by userspace tools dns.upcall, cifs.upcall and
 request-key.  It is under development and does not yet provide the full feature
 set.  The features it does support include:
 
- (*) Implements the dns_resolver key_type to contact userspace.
+ * Implements the dns_resolver key_type to contact userspace.
 
 It does not yet support the following AFS features:
 
- (*) Dns query support for AFSDB resource record.
+ * DNS query support for AFSDB resource record.
 
 This code is extracted from the CIFS filesystem.
 
-- 
An old man doll... just what I always wanted! - Clara


