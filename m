Return-Path: <netdev+bounces-76644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C788986E6F6
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 18:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AA1F294F9
	for <lists+netdev@lfdr.de>; Fri,  1 Mar 2024 17:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04985C9A;
	Fri,  1 Mar 2024 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQnKebzk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF04E5C9C
	for <netdev@vger.kernel.org>; Fri,  1 Mar 2024 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313281; cv=none; b=JTqcGO/Y6Oj/M2l7LzvHWDUPyDV1jXmnlLptohYsu6ml71BykqYvJi5rNupTVfh5J/BMqgamyyh7YVkkKRuP5BLLvoeDtrWE+OJaBXEzcl7LE1o4VVpUxLJ+UAcePjymQJU5dJaenbiz4DATajkxu1+5HTvZxohyuo7XajRB1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313281; c=relaxed/simple;
	bh=YuLPydQtCElMetLMWZZ4qUKF1CmgeIslvxXemBSPPNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uBqmRW/XxV8G0z0ciRTvcngUNzGEDl8XU+kh/l8Inmc9orRWwqemgvTVJ3Bc90/U4WuIb0oXh4nVUTsFtte0hUJLPHU2FLqKrb+2JXogtTZQAdlKqx5aj2SeoQhKsFJIeBi005liGaLIEtuzaqd/I6qC+QtsUWcFTZ6xA5sfvGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQnKebzk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-412c37a8001so9754855e9.2
        for <netdev@vger.kernel.org>; Fri, 01 Mar 2024 09:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709313278; x=1709918078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HmJlRXXwfk2LOBgqkJdQMI1jnsbzPLtQfj7RACZyv+o=;
        b=HQnKebzk0CROAFfD8TFhd23wnESgSpAMd9bIIhiB36AL8BwTPWr+uWKdy9REcbeS6J
         nppp0ll7EFS0eylyz+rnHhiN/TTcK2JUfnf6Ue53Hkq6HuvSymlE8nu4V0+qZ2wsHs9f
         FaC50/P2IqfYNOOpb3HzwCrauHMbU+unHd1QvjxCnseq2W5hcZB+/7D7SFjwJ3Czp7E4
         qK5Cdzq/XfV395nRd3eF4jRnHt6wQUiKT2hD/bEkKN0O8svhwnaaJ2pI/iB3f/5vtx8Z
         q0uVcvrLq5ssGIFWVoETvrnILNAgckqRvjv78+uepfnwbjaQca917wMpajuKnWjV+e9p
         zrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709313278; x=1709918078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HmJlRXXwfk2LOBgqkJdQMI1jnsbzPLtQfj7RACZyv+o=;
        b=kR9AQbugUchJQRMTMoYabh46UrzEW8rh1hQkDpBTXMB6OLPxBrFxpur3lPisUVZjpC
         D/fVgwYX7lp17w+aBsOs9EziuHzIrKMbAhI9w6UlJ8GzVfMb3c9Dk7gEEQ8cXPevcHEj
         ol9LxNmu+auqBQ55f0bNIOHQICzda/QSyXXbADecOrFFBth4VIn8+veUO6ADax7rCUlI
         Zht21Ej1OAQe9izKg0m31dtMqgrTJ3mAgy+Xq9vjhXObbM0bIQ6OvoFouTWwXUanp4eA
         udvBaLXFY/VqU51ZOb+ql+2xYq8ZfZ3fiXjf4Qc/TQTCWRGcNPVZTf7Km2tDvQ0ZPpNN
         4XIA==
X-Gm-Message-State: AOJu0Yx0YnAxvtmqYk0Dg1B2cYARNdU1hA6ztldP9DkCGHpY+U9Ok/jj
	uGCklHHqdjtyVqybwUR6DZvP5Xlv9137ZzUfTHu7AqHF9kdJuAKIVhwtpkSm+pY=
X-Google-Smtp-Source: AGHT+IFbRTeXX+3A4m/KoVXqMjx2p535+333eHCtILuPZZDfN8Qz2mT1BL8F0FKMzDKxiFl4vjLDoA==
X-Received: by 2002:adf:e902:0:b0:33d:f1e5:7b5b with SMTP id f2-20020adfe902000000b0033df1e57b5bmr1714484wrm.59.1709313277621;
        Fri, 01 Mar 2024 09:14:37 -0800 (PST)
Received: from imac.fritz.box ([2a02:8010:60a0:0:c06e:e547:41d1:e2b2])
        by smtp.gmail.com with ESMTPSA id b8-20020a05600003c800b0033e17ff60e4sm3387556wrg.7.2024.03.01.09.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:14:37 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Stanislav Fomichev <sdf@google.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v1 0/4] tools/net/ynl: Add support for nlctrl netlink family
Date: Fri,  1 Mar 2024 17:14:27 +0000
Message-ID: <20240301171431.65892-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a new YNL spec for the nlctrl family, plus some fixes
and enhancements for ynl.

Patch 1 fixes an extack decoding bug
Patch 2 gives cleaner netlink error reporting
Patch 3 adds multi-level array-nest for nlctrl
Patch 4 contains the nlctrl spec

Donald Hunter (4):
  tools/net/ynl: Fix extack decoding for netlink-raw
  tools/net/ynl: Report netlink errors without stacktrace
  tools/net/ynl: Extend array-nest for multi level nesting
  doc/netlink/specs: Add spec for nlctrl netlink family

 Documentation/netlink/genetlink-legacy.yaml |   3 +
 Documentation/netlink/specs/nlctrl.yaml     | 191 ++++++++++++++++++++
 tools/net/ynl/cli.py                        |  18 +-
 tools/net/ynl/lib/__init__.py               |   4 +-
 tools/net/ynl/lib/nlspec.py                 |   2 +
 tools/net/ynl/lib/ynl.py                    |  16 +-
 6 files changed, 221 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/netlink/specs/nlctrl.yaml

-- 
2.42.0


