Return-Path: <netdev+bounces-196446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 902E8AD4DEC
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 10:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCA61766C3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1970F235348;
	Wed, 11 Jun 2025 08:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZAU1CAs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA32126BF1;
	Wed, 11 Jun 2025 08:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749629302; cv=none; b=tIVXMDPqJ+JUnTe2AL//aSMtJ1rYtrRfRDmTZWm9JPjgYY3lcuDjpsphf5sIwG76I8tcvsAYEDO6Oqn96+G4r3Q+an0byD46pq8MX52BeNM3PHjZqyCSiScK5miiH75R7JyaWyya1GeuU4RejZFjrEn4HT3UqnSq1OkrQxv3Ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749629302; c=relaxed/simple;
	bh=lGJb69/tpdP5rkGcIoY5vtL9R3Bj7q0/QtkMrLQ3hYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DDN3FYnmUejoCclKDhsSVskelzRLTrNdPlDaDNNrwPxpPVts/bPC+vv0xLoHeYHNHXXFyFx2cyVguSntwZly+IBbcYGr9HLx9INQCUguKuBauqaAbjv3sWggCp1nLZHe3Jgh+OZRyQ3gd/ZfIDOpjnB+rjhQFRbdp9G8Qu4kxX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZAU1CAs; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6facf4d8ea8so66468666d6.0;
        Wed, 11 Jun 2025 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749629299; x=1750234099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NyvR/aWRBWqhSTIVuqpj6xfB7efefHvQ55Ys34H+rzc=;
        b=AZAU1CAsWAPSYhX82C+syvWl9zzOkBqREUYWgXnfS81hhPwnmZ6+B9HxoRQzdlwHVw
         cdEWoQEZLPEW54ZPbhd9cIQBDj5Dy/LrPk4z9sADg8/m4GerlzNfyOeiYcAz6BLE4gtI
         g9VyN86YDUjbk1EOJRE7/HlBZw5qySbT1nAvrzQtAz6Pmc4a8Rvl7nO1+GDvt2hahH7f
         WXZ6xE7lRXwTQ859t47KyyPvVTLFI+pYsF+j1m2Els7woZDl1KOz9ZRY3P8bAc23d/0j
         ikprwq5o/PR2YrcczrP1fRF3uY0D+NNiv0+OEJT+lIWDk0oijdWXnFSXhyLiibY9jrjA
         N80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749629299; x=1750234099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NyvR/aWRBWqhSTIVuqpj6xfB7efefHvQ55Ys34H+rzc=;
        b=XrWk70guhtNg6VxSFCFEr0PDgA454h2xjcwTJLtAWATCdek+jP5m4bLu+0iPtEkaZD
         TUjUKqg9EvJqzl/40lvOwTGxEdwvPUp8aYC1SF7RUZsXUimMYeCIkohj9tjFYjrrw3G3
         23WrgfW1/EUzThyKA4xCm6HyUhhKuDrGlUU57JvnjiRIRf5GZsR20HvpZidklm71qu4c
         KFb8Q/dKSSA5K2xQtMyv0WnTUSd9Sk99bv0tSSMP3fzho6napICfo8OW8AIxbj108b86
         RvwRqIwu9cCAMBgjZJ+n2kt5fVEtZeaPkNhOUGuo54mFCU/0gys1QsuxrTugi635xOhC
         SiEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4v7HXq+835RBH+ifeV03ENqnkycOXrjG8Qcd6kSiISg9MOQBSE/veni9RRdUd3zemF9Wg7cqToh5E@vger.kernel.org, AJvYcCUpHXm5J32cVtpUM58LcOR/Z5naEL6RlnygEjQb3qvAvww//uEMryk/+Ea6C0u4XjE2tkpplXW8l1pwKimo@vger.kernel.org
X-Gm-Message-State: AOJu0YyKR/A4DSw+5YP8h/u0XBCDYQOZbJIrqN8W06+lUMoX0S4Z/JQC
	dbG/CSQkUv6V8R6CbbKwtjlZB2Jb+7rgFP6yohjg+j3lf2ntYMCbagYx
X-Gm-Gg: ASbGncujrxj2iBnlHhlaq74XJNux87XVNp/3Lvqmpma5V5zT7eyrHx6eGJ/hJyagBQg
	IYSeblWkunLvmKx97XLSl6tLaIKEGxPVWM/+3MUDf2TUPECTSOQynxUsr7tirNdNF6kjGmtbiGL
	qZjaBHV1uz1JaucTdOh6zYWqfukDQgnds/fZMvux1eXLxdRi4h7d8atqfHrIK51I0fCiT95AW55
	XOrFl8E7RovUYsnEquZ1AHNYhjXaLhQxR2LVrR9PUsDBn6R+2/J7AzeRsK76p3pe8BiFKbCumo0
	Ut7EhOSKISMzlQbknbzR4CXGbqNpEb8GxV+Qsg==
X-Google-Smtp-Source: AGHT+IEa9ijPv2yRUgWb1+JJ15oOCUsNs6QvCIjqmIyulbMV9Myzdnt3+CF5kf5GH60kSH/1rsm0dQ==
X-Received: by 2002:a05:6214:c83:b0:6fa:ff79:2cfe with SMTP id 6a1803df08f44-6fb2c3272a3mr32641426d6.12.1749629299545;
        Wed, 11 Jun 2025 01:08:19 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fb09ab9595sm79183636d6.6.2025.06.11.01.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 01:08:19 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Yixun Lan <dlan@gentoo.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH net-next RFC 0/3] riscv: dts: sophgo: Add ethernet support for cv18xx
Date: Wed, 11 Jun 2025 16:07:05 +0800
Message-ID: <20250611080709.1182183-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device binding and dts for CV18XX series SoC, this dts change series
require both the mdio patch [1] and the reset patch [2].

[1] https://lore.kernel.org/all/20250611080228.1166090-1-inochiama@gmail.com
[2] https://lore.kernel.org/all/20250611075321.1160973-1-inochiama@gmail.com

Inochi Amaoto (3):
  dt-bindings: net: Add support for Sophgo CV1800 dwmac
  riscv: dts: sophgo: Add ethernet device for cv18xx
  riscv: dts: sophgo: Add mdio multiplexer device for cv18xx

 .../bindings/net/sophgo,cv1800b-dwmac.yaml    | 113 ++++++++++++++++++
 arch/riscv/boot/dts/sophgo/cv180x.dtsi        |  70 +++++++++++
 2 files changed, 183 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/sophgo,cv1800b-dwmac.yaml


base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
prerequisite-patch-id: d5162144180458b11587ebd4ad24e5e3f62b0caf
prerequisite-patch-id: 9e1992d2ec3c81fbcc463ff7397168fc2acbbf1b
prerequisite-patch-id: ab3ca8c9cda888f429945fb0283145122975b734
prerequisite-patch-id: bd94f8bd3d4ce4f3b153cbb36a3896c5dc143c17
prerequisite-patch-id: 1b73196566058718471def62bc215d2f319513c3
prerequisite-patch-id: 54157303203826ccf91e985458c4ae7bcdd9b2ba
--
2.49.0


