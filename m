Return-Path: <netdev+bounces-82633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DDF88EE0D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53DB41C2BD28
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D39114D44A;
	Wed, 27 Mar 2024 18:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izXqfB6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720551304A6
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711563429; cv=none; b=FbYG57tfCbHKxaslz0pgeTr0aC4kAphC81hgq8QicGBRIgprIKEmd8k4J059Q/zV7myRY6veprO+wocW1HuAiELOOyKvQYOBi+v7R/mSlwQ0vA6Gsa985UNz4+Evc1rAUSRPgKn+tx/Y2Y6ecHNEcaOmy+1apWJi97ThugHEKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711563429; c=relaxed/simple;
	bh=1YoaMReJsz4r+DH5aEmrf1t3s5PMdvUxCG9lEoQu2wU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dIASFTcQiA7G0dvOptzUm+y6xlWQb7iiSS9tJLUi9KLI8+gzJsgi8a8JtyCVtpRiNEDhbBmI7ErnKlUPFNpj/1iFQ/YkXRnh6onCMIqTT3e3KNJYw+tJrTFYZKBDTymtvco+2p/ULf6m5RKP/rPKixQdxTnXykeiiRn2D+TyKGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izXqfB6E; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ddd1624beso105007f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711563425; x=1712168225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EN82nidJyk9JA0Z1sMJizxzenLmBPI27AH0iKQj7HM=;
        b=izXqfB6EEozbo9DXVuKKVUu/DQoKhzTHvBdhfIsRC9zqkboDOsy0nlECP32zjF3rBb
         L0rgr9HC9D33kVw0xQsXAHKaEpPswYK1BuDQp1QjLma5hBUjFOOQ2/dW01ZxJLnPkUzk
         ITBFWZ1WYouzWoqoCIuVt4Kj6DwQ0tMYxfCLLwySjJXVm3V3LUJBk89y8W1y+EEnJfag
         r0L2UHnrPTIgXIK0wW2FVI3S42GJx5dt0asMUUlZIoK9LG+54mg3+r9ijcO+jk8G0wqD
         b4DFj4QfFYN6g8ENj32ydSTbx23Jxgrl8RUUJ7A0XsIFzV66opJmsbruL+PBQ9GE8QMo
         CrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711563425; x=1712168225;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EN82nidJyk9JA0Z1sMJizxzenLmBPI27AH0iKQj7HM=;
        b=o4LSYdKCjLc4ENQ6xeLYdqk5Eemg+WIzbfTTTP32Ielb9s9UUsSMzx1hNZU2v0/Dly
         6kN4tI6wsDuYW3FVMHgrPLQvCJlsykOSqVHJL69YcgnKYD40snk4vCFkDYFzt9tGaJKs
         1X49FFxjBtiYgrzzb/t2OhyvDSC0IapwRCRw81mndrwcuVu9Ka+QKaeIrF4NltCMP1gH
         ut2D5QT/dKsqLVJPpLDh596GUR/tIn1hIeRy6TtkbwETbhSnlR2WXewXvniTUcdKXLBZ
         uGrBASTgL5FFS6LNMAuSSqI8QebC/wUwIm8RvvxK35N3CO2DK6ZaKM6ICSuGlaSe4fHE
         4Fag==
X-Gm-Message-State: AOJu0YxsFHXSbU7w/qKHWRusp84x1BZnaCE5Ap/lpFAfyJsAoCNIDrWa
	h59NcTBZvPtXfkSq3tDj1nXybprYLUSk18cevNgUhdB1xnHEM1a43OfnDFwe7Ao=
X-Google-Smtp-Source: AGHT+IH1KMeAHkNQRpShoG/JWG7M7fzUQti7grdWkVqAMzthKJiO9h+kLBPDuZLa3vpd290btzW2nQ==
X-Received: by 2002:adf:9b97:0:b0:341:c4cb:2131 with SMTP id d23-20020adf9b97000000b00341c4cb2131mr36954wrc.30.1711563424771;
        Wed, 27 Mar 2024 11:17:04 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:5876:f134:d112:62c7])
        by smtp.gmail.com with ESMTPSA id t14-20020a0560001a4e00b0033e96fe9479sm15467848wry.89.2024.03.27.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:17:04 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/2] netlink: Add nftables spec w/ multi messages
Date: Wed, 27 Mar 2024 18:16:58 +0000
Message-ID: <20240327181700.77940-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a ynl spec for nftables and extends ynl with a --multi
command line option that makes it possible to send transactional batches
for nftables.

An example of usage is:

./tools/net/ynl/cli.py \
 --spec Documentation/netlink/specs/nftables.yaml \
 --multi batch-begin '{"res-id": 10}' \
 --multi newtable '{"name": "test", "nfgen-family": 1}' \
 --multi newchain '{"name": "chain", "table": "test", "nfgen-family": 1}' \
 --multi batch-end '{"res-id": 10}'

Donald Hunter (2):
  doc/netlink/specs: Add draft nftables spec
  tools/net/ynl: Add multi message support to ynl

 Documentation/netlink/specs/nftables.yaml | 1264 +++++++++++++++++++++
 tools/net/ynl/cli.py                      |   22 +-
 tools/net/ynl/lib/ynl.py                  |   47 +-
 3 files changed, 1315 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/netlink/specs/nftables.yaml

-- 
2.44.0


