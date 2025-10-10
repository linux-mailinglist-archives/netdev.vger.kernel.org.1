Return-Path: <netdev+bounces-228533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2390BBCD802
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 16:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C0214FF985
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1222F745E;
	Fri, 10 Oct 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Wgvuotc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f100.google.com (mail-wm1-f100.google.com [209.85.128.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424A2F5324
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 14:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760105953; cv=none; b=bRBOAxTpGdcn+pb2yCoyGImrIp4J3l5ljy9BMDIePZvYPzvgzSU1WmIOnkN0SeUHIxQzGedhrpXwGmB3y/fvgcIHU0/WfyYXf7kR3RD7zHF5x+kd0fuiQUe0UoKV8hemJ4+JBw/Qul3YRG/fN+H4HazRWBmaeK7zJKAhsxA8wyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760105953; c=relaxed/simple;
	bh=SPOylD0UaKBQHbCUfCQBcubUCMyJuC+tLQSqqrzYCcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmHi+EtzO7FAw8d+XwPbFomn+GoTE+IkIF5EdaIW5IUNb5twrmmB38qlU9b9NFqzbCwxTN5YADrCLnEk+pKTh4UAyjpyFfW+JM50GX2x2LOZnAyacBCH68cFciAt/lcnoLvw59tuEC4lyTzj1/LEtZjmncH1dtePnJkQ2dHSVog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Wgvuotc1; arc=none smtp.client-ip=209.85.128.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f100.google.com with SMTP id 5b1f17b1804b1-46e509368caso4573175e9.1
        for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1760105950; x=1760710750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tlWb4+txxu6x/nhjmhQpYHjb0oHA17miMwJw2TwxCuk=;
        b=Wgvuotc15Dz5yUNfqyyPgV3yi/zz3l6XIPB8g2bhzMPTp/Rbq54YEoBbs005vIM5VI
         gJ6tfpgN5EHQCJ5OZiTA1zjnVlNNQJu9YWxsmIX/+RlgaFvz6TzKZq4KiO+D0AmpAVlO
         uMr8fMWFOVPcwits6q4WJB2n41tl970bXP+9i7yYzsvyhyrojzvyERabES5aUfKLB5u/
         LoJu26pDqe4S3zaLeiEdcpck12DLiqCBCXNHH2U+WlsenxcJ+CYNgWu9Av5Qg3V88z89
         S5mySEic40xjcDpxA8AaepByEHmWemt0FxIScNemgowHxjiacYoGhhK8jbfeWKhmHhaz
         HN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760105950; x=1760710750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlWb4+txxu6x/nhjmhQpYHjb0oHA17miMwJw2TwxCuk=;
        b=v9H6duwE5jhqf2rMkHlG+snvLNS0HlFk6w9vJtXZd1L57/ujKpkypMXoDLSt0qxtGd
         mUGChCxvTL2Q5E+BnoQ2A4JxnBUhUOmLt0bDRH84ML8AJ6piube6rCFMECJfAf9RdwDa
         YyCCtCOSSbkIlumv0PzpYcDfEuht2kJRnEHyYyN99B5Bn/aGNz8jYeRKFOrrC2tRrS/X
         /FPnWW5IMiSoGd2tq6dweCuyNtgaHiEJChqMEFaKWJlCgmVvTtHh83NyAQgq/pQRfY+J
         1eYry4+HgFQAcEDWGtoyJKJ0q9vAhPBxkUqxjvC+FRIS4ry432SpR2OjyaMl7AT6WIRf
         5uIw==
X-Gm-Message-State: AOJu0YwocmshgqNBiJZdrYBMHtB9xYOTAPOJsA3OMl2hGZmNdS4NnPt0
	T7BW8FJH755F8Y3rNc/bVVkiToW7LRgTSa+LY90tDKM44ha8mzb7eavOMrLMnxKNSS2yDCnB65W
	w1YrIYU/kPmRRV0mLCmxDG9sWBP9YLw5PO6QE
X-Gm-Gg: ASbGncv3IhFe5oU58zNc8boim8Ab5NB+paC5oOSSHD4ec9Ye4Tlee276+L7JEdotChw
	eaQKg18Yk/vkyg/nAmL/HtGOKdxYWyT18tLYIJNTGll7g1UMJEtsroSMHd5Hlk05urwUxAePn+N
	5X5KlwGZhcBc+j230frmGLu0nkxEBEUudiojDXiAjjVhaVLLqJrFtcHYvVvqJlyNyZiFRqVvrlI
	5wXOX+H2FaFpOnWVY5TSfb2xXdgQKKjVxqsFnuS1mrl+UNiyfw+NbjjmjSgfgZeWjXDHNInOzdF
	iRaIBIq84v7kAXBw5wR3yA7PM3fodaydynCnv46uD5TrNCubT6t2J0fJSeetzr4i0ILl23yhqV1
	e38l802swSGAgmGRPnKc=
X-Google-Smtp-Source: AGHT+IHFkN/mvg6HC0PK3GEKH0ek9Vxj+iNl6q/UUX0WE9TzVDELhe6EQ0mza6QcbGYKUX3sZEPDBOMPW+i1
X-Received: by 2002:a05:600c:4745:b0:46e:36f9:c57e with SMTP id 5b1f17b1804b1-46fa9b07766mr45525825e9.5.1760105949909;
        Fri, 10 Oct 2025 07:19:09 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id ffacd0b85a97d-426ce5c9bb2sm169351f8f.26.2025.10.10.07.19.09;
        Fri, 10 Oct 2025 07:19:09 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id ABE5A13EBF;
	Fri, 10 Oct 2025 16:19:09 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1v7Dxd-00Fhou-EK; Fri, 10 Oct 2025 16:19:09 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Philippe Guibert <philippe.guibert@6wind.com>
Subject: [PATCH net] doc: fix seg6_flowlabel path
Date: Fri, 10 Oct 2025 16:18:59 +0200
Message-ID: <20251010141859.3743353-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This sysctl is not per interface; it's global per netns.

Fixes: 292ecd9f5a94 ("doc: move seg6_flowlabel to seg6-sysctl.rst")
Reported-by: Philippe Guibert <philippe.guibert@6wind.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---
 Documentation/networking/seg6-sysctl.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/networking/seg6-sysctl.rst b/Documentation/networking/seg6-sysctl.rst
index 07c20e470baf..1b6af4779be1 100644
--- a/Documentation/networking/seg6-sysctl.rst
+++ b/Documentation/networking/seg6-sysctl.rst
@@ -25,6 +25,9 @@ seg6_require_hmac - INTEGER
 
 	Default is 0.
 
+/proc/sys/net/ipv6/seg6_* variables:
+====================================
+
 seg6_flowlabel - INTEGER
 	Controls the behaviour of computing the flowlabel of outer
 	IPv6 header in case of SR T.encaps
-- 
2.47.1


