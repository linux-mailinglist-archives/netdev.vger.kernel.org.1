Return-Path: <netdev+bounces-209117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5BAB0E616
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 00:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5E8AA495E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 22:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2F286412;
	Tue, 22 Jul 2025 22:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lftwuYPI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10027F171;
	Tue, 22 Jul 2025 22:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753222157; cv=none; b=ocmJFf6RfQzg0r4ITPcFZz0Oyu/Wru51YkfS5ZDHo17xHIsC4xHoXZ4v832VJMpUVSYo7U/mkkrgZB1MNPZjf90FQ/p/FVSUmEkXOi26zBNkz2lImFxAcsEjHHqmU/UY6BVZGtik2bEcaXtKHUfTiFIxd8GK7zg2n6mXHhwwXHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753222157; c=relaxed/simple;
	bh=nHTU6jYP+/Ymxk9AlhaWNGaTkVAqEI2BNLqznpv0Gk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ot+jhGVxZojnBeNcRIdPUmLhMDiqZkaLh0tTZMtclzvMM6VwIt5Uq0eWsQbiFoW4IEBbtmr6LBPAqIrRSN0BIrq5OdjR/Rqi+t5cpvuhEtBBotf/fxTSfLhT73l0dJW1sQJ4RAFylGCZifdIEByu+oNO8zlSaA+45k5WCgUmics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lftwuYPI; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e33d36491dso831441585a.3;
        Tue, 22 Jul 2025 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753222153; x=1753826953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlwaFP6QDWNsfkNbopzaeorjHFvSmoNCjvK/76l81X4=;
        b=lftwuYPIALe9sT7WKZvRd8lq0IlpXrK8DSuWnDdIuDO+4PfkPARAoQBNW+QOUKUWIn
         4Y0xkXxZ50h5O0+Us94VWxmPh+EzieyCTLF4IxcJGuT6vkky+Gl2/F3fP3QqCrhMdN+P
         cho3sBEoerRVko2Ox3UfiUYIaVbsuLf2/TmlUpdeVGS8SThe3awpyExivZFlesG525I8
         f8GJjhiJBuIQ0/HLgaOEd+Jv8XKy1MFFaggDPTsmc2iZIRGs6O1t5byGEv+cGQmesoN5
         B3sz/LoKtaacycOt5P+LA2PhFj/wQGEJu+YsHdOJbwAfLoCcFcbDloV3L2KHntXtjKQc
         imGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753222153; x=1753826953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FlwaFP6QDWNsfkNbopzaeorjHFvSmoNCjvK/76l81X4=;
        b=OZ5SY31TmkBR0ixfrs8x88LnPiDBOQch58m3YcbCdOOoQ2G13VDirNb10t+qzf9eJD
         IkORBm+/X2YcOSUIn26TUXgxty/2Bm+94JWG3380IK9e23MuyKLt29RRNHqdsoEQNx1+
         JLdsBk3NFIpqtJqNO9nvwbBWpibNY4TcVNBpYAgwe7UZ7/N6ZwJlXjsZHFS1khLMX0tK
         ovPvp/FiQpIFtWXdZIS0n5lMKcRQVXD8IWVm/3bFxhRLfjD922VX3VG5QhMS/E1HRyVo
         zfQS0kKHcpXAoYFyMFL+s081w9wNmPfg0bJUOdm3zEBAySi+KWzGinJFtjOw5vd2Lz+3
         MujQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwdqbeSbdvBd2eZhK5n7xapKkmAuH8ZlIxUQ4ll8zjIEcte9SM96MAszmprKkBJANuydrIrfiq@vger.kernel.org, AJvYcCXgVr83/s34wWJYgIh565KJPe1YS0KIk7hWKFtAgDTXR8uU4DjGIDDKN/3J9y2jCwGaniEkcfSOw0J9FKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+XH3aoPg8lhvKx+sFi7hpJxIPVDVTotHP96v28uAwbau9xKys
	1pKEumpnOyInWMkmUi2JosBNrRG7c9uLsxvSo2DbbdpUrqFNlKdwbgSl
X-Gm-Gg: ASbGncs9YdIp5a+9J3MExxkPEHEu2/FIoZmADY8NuzWF6Inkuv/C5WqnlvJp+LGGesM
	LrE95wh4loDloMMwR2nWJbuuCNkz3i2QyZKTDxvkNovDvV/b/5gehx26q/8AJShO07iliNyCMDt
	Jiys/8eJEChicsR9dFH+ruEsSUbyn02SLEPkOTIobMy3rd8NVxxeHkXdwOb9NWT2NIQjNnoJDH/
	6vzxNEFMjDJ4wf1lvmE7fGkUIwfVZgic/oFWs6mFHkY7FcMLC+c9bN9ddLMVcpRMrs1YhO8zgbG
	FpjGX+KRUYn4B+Ni8WWoTqtYFJPPbnsT14eQet2cwa42Owpd6EgZmXVGTPQkyoMei0FOqNpeJ1K
	LkiWToQewQpyDm6nwinrKOujdUQLti4U=
X-Google-Smtp-Source: AGHT+IGbc8UgtbK5rERh0PUben8sHnQTMf578VRiBv+51gSIE10iKAJKX4YcquDSNNe6vY53PtDigA==
X-Received: by 2002:a05:620a:4052:b0:7d5:ca37:79a0 with SMTP id af79cd13be357-7e62a0b2cc6mr110534885a.18.1753222152946;
        Tue, 22 Jul 2025 15:09:12 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b2b19bsm592945785a.7.2025.07.22.15.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:09:12 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] samples:pktgen: This file was missing shebang line, so added it
Date: Wed, 23 Jul 2025 03:35:31 +0530
Message-ID: <20250722220629.24753-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 samples/pktgen/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/pktgen/functions.sh b/samples/pktgen/functions.sh
index c08cefb8eb1f..2578e97e46ff 100644
--- a/samples/pktgen/functions.sh
+++ b/samples/pktgen/functions.sh
@@ -1,4 +1,4 @@
-#
+#!/bin/sh
 # Common functions used by pktgen scripts
 #  - Depending on bash 3 (or higher) syntax
 #
--
2.49.1


