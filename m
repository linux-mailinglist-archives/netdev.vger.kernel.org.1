Return-Path: <netdev+bounces-233753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9C0C17F6D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 03:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E6F94EDF72
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AC82E2DFB;
	Wed, 29 Oct 2025 02:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYEqokpC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3942D7392
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761703201; cv=none; b=Qda7BytdeIAVNBEw/8FIw+Ve5lEq8Ilv7t6Q1os5P+ABKl4li7XzFtwDYWLdn5IxZSzC48Gb2ikgLPaqTa00m+u6Fz1Pi3RCyuq8jeTQ/LTUSMdviMfL2nCzLG6n7LaB8HsiCXgJjirthMX47BoOaO1JegZyA5WOBbbEIx6iZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761703201; c=relaxed/simple;
	bh=hP8eF0K4Fnew1ZKu7xTTUKH7Tg+SmdBmlL5J3VUiePw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jdC/Ei2qqscjcyPtMU19jXKWrdzgdUc1YV0VJl0xRQmPmWqHEn/Ds1OSRFEe/0oij9lw6EK0P2o04tRebOMLe33+mfON7U04e4YrUlVEyKThOzH05GNyxNTcXcDaXgvAd0Hs3+Yo6qC7vvh6OBiYmThUdAKqwkZAp08UWOUylDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BYEqokpC; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b55517e74e3so6109728a12.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761703199; x=1762307999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfqaQ+uC7bdG4ILE549OVeYT25uPWQdC6S7HhQE7unI=;
        b=BYEqokpCBsHmtejJeGUUev3w4G2PKT4TwDvORE6nxjSHaAIbyTLgVNkyBuNEZxQo1g
         y8Zgzg82TE7OOepAHXgTHjAEdOa4ypPcM+jYW4Zc/qmhP6Rtwr/J7q774IOMYYe7lJjD
         389zWAtpNb4n/ioo1xgK0liZMwMMHCYzfM+C6qVdPokRientoMBCQqqR5ErpxKAvgBSK
         Fpfbi4AocSyGTjr94ukXQvhZzM+AIm1ok+HrpYg3Skq8RcizUCCiqtCiTDqWQL9iByxj
         mXyM8sOUJiC4EHHhX983FH/176GdiP96W60sIZN9GbpmNFyoG9woVf89bCmoJlUHIoE+
         lZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761703199; x=1762307999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gfqaQ+uC7bdG4ILE549OVeYT25uPWQdC6S7HhQE7unI=;
        b=VC49nyHM12V+JZi/R9jVDv3uuMTKhMnCXLtifOaXhE0UQh5+uHveA4Rh21pIjXmKTZ
         ZLDx3UD7oKW71P8+VvrdqQDDlJTgifq3qg38t5TKe4u3dFb3uTLcUkT5RSvgp76Ab1PI
         oyINsYr18y9B7kZdcrUMqy2tXXIC9uEScpi4En8oKcQvcmNyOaqlEb/y6R4FlRAKGYHP
         5tntC/hYCj77n9rcW38FaQQM9n3Wq1riF0mqisdQmPrEBQn6bTTyhA82ZJB+2bGLqBLB
         TXVv8fyozJx1VYPBdSYRm8Z/nrAfyMpDGQlXrphMZRppxWavkkv19P/RLyIoQ1dGhI+G
         YnTw==
X-Forwarded-Encrypted: i=1; AJvYcCWFOZmayQsxvPF6gII1TH5josJMKTVaZ4iy+L5oXijMgKeFc6qEVEJDO7QboTAskDCSI6a6CTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBv9n8pbhmam8yiNemJDhMOW0eJoX3/SK3y5EOtoNAjyXejR+Z
	9bdlmiBrNtmr+q2ttr+26LVbSur8zI/RzTojeCDEqoEuo5uEr/gMR0m5
X-Gm-Gg: ASbGncvo3dcvf/+iCi/IkWufXKvvq2h/eOFacW6FOxkDW9MQ3wcyCQ4D7nBpHcEQkd+
	DoJd3vJsVosmSMV+K7WIPGR5/723Y/tJdmE1Gi1JNvCi3l142kw28Vd8zaqe3RCWNlzo6if03ro
	65dL7zwLV8mVyFIhir6MfChZUIqIgfv/LYuSpqm7IRc/maHp456d6rrUeV/ZMgpDYFNW3MCBGD+
	pfMJL4VKzl0Okp6SblE2viOC7t+GrtH7zDPzrTeVh4e5Yzbu3KttexYhtJuoQm/kI945OyLo6Iz
	s3gYiI0mMqBdQ2ocMhFZ/NTp7FsLVmHpXMUls85CaS89XVqIsXvI61gjnOdkOKfB/baiI/PPOiR
	Zk7u9sV5NlxhJTS/NvNMm2NN+ySX4hkdZBjs/cwI5/ITrU3WkNGe+k02WiZXyWbB7KcqZSF48cs
	qFDTJYtnFewZM=
X-Google-Smtp-Source: AGHT+IFlhaFEy5i7fb+WJyyvynWY8Siu4ggFFXY3WiOcoLFv8mNx7LPXoJr5hXn1kPXaKhQcEU3+vQ==
X-Received: by 2002:a17:902:dac8:b0:290:c94b:8381 with SMTP id d9443c01a7336-294dedd419emr16660645ad.7.1761703198547;
        Tue, 28 Oct 2025 18:59:58 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41403fa75sm13177538b3a.28.2025.10.28.18.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 18:59:57 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CED3F4206925; Wed, 29 Oct 2025 08:59:47 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next] Doucmentation: netconsole: Separate literal code blocks for full netcat command name versions
Date: Wed, 29 Oct 2025 08:59:40 +0700
Message-ID: <20251029015940.10350-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=bagasdotme@gmail.com; h=from:subject; bh=hP8eF0K4Fnew1ZKu7xTTUKH7Tg+SmdBmlL5J3VUiePw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmMJVKXNp3r85oX7K8e5aYyNynwSkWpxenE3JLd3R5fN ryO13LoKGVhEONikBVTZJmUyNd0epeRyIX2tY4wc1iZQIYwcHEKwEQkORgZHnKHpSvqlLE9y83a 8WfdhcUsXgFb+ptNtvq4bli0qqjLn5FhWa54mShDdGOaW7fsfJOs4jAWu22fdU8+s5ojnf/pphM TAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Both full and short (abbreviated) command name versions of netcat
example are combined in single literal code block due to 'or::'
paragraph being indented. Unindent it to separate the versions.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/netconsole.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..0816ce64dcfd68 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -91,7 +91,7 @@ for example:
 
 	nc -u -l -p <port>' / 'nc -u -l <port>
 
-    or::
+   or::
 
 	netcat -u -l -p <port>' / 'netcat -u -l <port>
 

base-commit: 61958b33ef0bab1c1874c933cd3910f495526782
-- 
An old man doll... just what I always wanted! - Clara


