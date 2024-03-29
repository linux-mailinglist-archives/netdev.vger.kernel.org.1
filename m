Return-Path: <netdev+bounces-83338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E36891FA5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 16:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D998A28A096
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 15:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6E139D05;
	Fri, 29 Mar 2024 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcJmCGCH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A613139598
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720230; cv=none; b=WCCOzP23BRF7n7ZhbPbniGg2iS7DQ6CkBzbhWOOXE2pwhJnJzEnEmOxXdsQT30YD3xVW2+9ywJZXYWRToGvL2PBvHFdyWheQM1i3L4PMK6r4wp2H9e3rx3VlD/ueIYyGlvfeyM0/GjuBpteE70WE59edGUopjkjOaAWq1H2OcWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720230; c=relaxed/simple;
	bh=KpzKotwZsVUuQ4wSFNl74KszCvgJl5oPoAtJIVWJQho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IU/iA7ADpOylK6yTC9w82h6wTsHYgYuxuIt7xEzx0zS6OuXAezv/+pPln+YF9Ep14XSI0qnTsUROj5811Vmyh/XN+0LNcJ07ulXXWenv7zjln8yQirDVjFdTNyA6fFfhMIJKiI/VRZs5WA9m6YUIjk7ljNjrjKUN1YZ2paYJzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcJmCGCH; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so26030431fa.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 06:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711720226; x=1712325026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CO8bs4lP8g1tEVp1DO/E4W8+6sUjEnFUWxM7JrttqRU=;
        b=QcJmCGCH8dq0kUX69T4zDpm+Xw8rKyDVlqt9IxUkBInORw/97dc+7ZvPgA9eWvraCX
         Btxu3cJnOlq1UEMImSfQlJMHQDzzy+AEUurt8P3BGc7565oxCxRgLSH7zom2+puLIHQ4
         exO/lm8HOqRzNoxkgsF3C8y45Ukw2+52C3y5W5u+QRMuCeH6y9EBVh3AoE2uAWxsjwK3
         F6JiqGOEFWT9HrJ7QZ9kl1D+uDUtud0AxTdYWbZIQMJxrYEAg7wSIpFne9W+Si7vYs8i
         QTPLucl8F5ND+O9r+XA0KovNwa6TpAnHi/fhBEpkhQ4OxJjohhXjVR2pgt1ERixc9M1p
         Q30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711720226; x=1712325026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CO8bs4lP8g1tEVp1DO/E4W8+6sUjEnFUWxM7JrttqRU=;
        b=UNEGAqGjtnJC+MgabvKL6MNQ2qudAZihz0swT+LoiwxUZzsyfdEljdp6f0Ui7i29Ip
         +QjkhwShUh23ln6sSPrbg8IfBCgz0tn+Jo85LLw1Kaj9ZCnzdqPVcbCofbNi/x3l9ljn
         /luCv3ELewP65ITd1aPGdTAfhPTFl3JjeIvUmvRqN1+FBvBBgZ468EY3KlS/I++6ro2q
         MlZSCNLi37MU9L6JTW54ypy24K0jatxFjJ6UdbqRl3X53HMAGLpnXN4D6BeNTRwHzzd6
         sVteLognfCnk5A+UrkNIPycEnp0CzRhwFzNDBXrPLLh0ei49ATojqso8CRMEKVCOgl/5
         GP0A==
X-Gm-Message-State: AOJu0Yylx+t4wAX4LphCJxQ7Ga46DZlK3O3DFewN8CNzNPb48cn2lVF7
	2Ogq9Hd5n6TdL9cSzdf9Euq/UBsGEeXPQYPj782A4aB8ysVfrYA/wBqFDfEOMg0=
X-Google-Smtp-Source: AGHT+IFfIWvjhT2Jzd6ksFrzevNwb/fU0x5uv01EdCiPD46koCDK/mIXIKGI4dtYkh2g2hbJtkXvQA==
X-Received: by 2002:a2e:aa27:0:b0:2d7:1805:1079 with SMTP id bf39-20020a2eaa27000000b002d718051079mr1146532ljb.7.1711720226281;
        Fri, 29 Mar 2024 06:50:26 -0700 (PDT)
Received: from imac.fritz.box ([2a02:8010:60a0:0:3c9d:7a51:4242:88e2])
        by smtp.gmail.com with ESMTPSA id s21-20020a05600c45d500b0041487f70d9fsm8590633wmo.21.2024.03.29.06.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:50:25 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Breno Leitao <leitao@debian.org>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Cc: donald.hunter@redhat.com,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH net-next v2 0/3] doc: netlink: Add hyperlinks to generated docs
Date: Fri, 29 Mar 2024 13:50:18 +0000
Message-ID: <20240329135021.52534-1-donald.hunter@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend ynl-gen-rst to generate hyperlinks to definitions, attribute sets
and sub-messages from all the places that reference them.

v1 -> v2
 - Eliminate 'family' global variable
 - Fix whitespace between functions

Donald Hunter (3):
  doc: netlink: Change generated docs to limit TOC to depth 3
  doc: netlink: Add hyperlinks to generated Netlink docs
  doc: netlink: Update tc spec with missing definitions

 Documentation/netlink/specs/tc.yaml | 51 ++++++++++++++++++++++++
 tools/net/ynl/ynl-gen-rst.py        | 62 ++++++++++++++++++++---------
 2 files changed, 94 insertions(+), 19 deletions(-)

-- 
2.44.0


