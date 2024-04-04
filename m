Return-Path: <netdev+bounces-84704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA17A89817A
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 08:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2844B223F5
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 06:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06424C80;
	Thu,  4 Apr 2024 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVh+Z7o8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C52F32
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212287; cv=none; b=iaNPj4o8u7nH1Dyrhl7NQkitbT4UuwgYIiV4Pe+RkH2q5VAOz99MqLUVIuDYUiPYbQfT2D84QWjOKNF50AvwneKYF1sBClS0gWOoEFRaspflXvNw6nwmotaI1MTGpcV1lBxQ2jICxJbg9vYr1wsdwdlpslwd9C9Igm6UuVXzuiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212287; c=relaxed/simple;
	bh=rmgyDzf1faEj7U9u27iFsEtFCfO4LZOt0OxSn2Jk9qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fPAn1W+jRzgLL+dm9Xb8glk9MrnBqYcb0v8x1EmxcQT99sWR8Oc0nFP/XqQG81DbQWKQZhBh2Ah5+xM95VyOGvox5VwZgP45FAackf+BIwNlY3sFG39S7eUXZFt5BZXO+utbMIfh3rZYEuLttomzNnW+GbPb34ALqwv7SGaEDKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVh+Z7o8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e2987e9d06so5203855ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212285; x=1712817085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/OmqG/LErBIaeUxGc4T9d1FCRSC528zBRrEE42dHuAc=;
        b=gVh+Z7o8jwD6B/AdppxLGtYkF2bbTgMMeSs/FhEVubAIuzzPkdeUFZwe05irKUvyR4
         fJaJthQdPu4peeQJHaSqLjXrIuGI9X3f3c36IMtwnfFwXyfbfban5bi+qHcAMadM93r9
         Ad0m8VWlBn6bA6dyoGikAnOStcqrw3MvNVgoPP2LF+YU7fEtxLwMXNhmmNKhm1SGcDa6
         RDKFGCtExNesmm3qBHZwYIYyZulwYhQAZCXd00hpvulmnhdyN/OeTKNefxEmnicYFZM+
         5M9gEjbEoJFi86iYNFj+HGeAn0DbkvTuEDWjeZwLR3mARmP4BcJfTZ2phwZjI0y0DmkX
         26UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212285; x=1712817085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OmqG/LErBIaeUxGc4T9d1FCRSC528zBRrEE42dHuAc=;
        b=rHKmACLnODiVsgfug/yKvWwvcQu/1RdBOrLidtIwEA3wqSWTLYiTDwtTuqeyNFDnpI
         HgCWfahjt6RY/JR34xj3p9DTyp/gQ23ANZ1n/uKjmfRiw22rNfn2L+AESlHQLba3YYop
         W+Cp3cdgFVKqRQ7P/CHB2VioeOto1/aLJ0l8PdwK3PLVCNBzD8M3LNIbmEvXwqS26Qj9
         69blDuDoSEc5Ha6NX5cFiDUGMpaV2Ksp8sEyoBxRZSfa59mP3KqkR/W34j60DEw4AbUC
         JqKBF47jhzQ9l5LyNd1B3hlre/M9uluOyIQsEenh3pUrjoGrJYbnRt53QfBsy9CdZE4V
         FRGg==
X-Gm-Message-State: AOJu0YynqlzjoHmUDTwke3+dj7nLy3GHcHuAjk6JA95AWslJvbIwJf8h
	MKSZOFWcUUbzDNTrsWdMr/REfOaCRGiRysGZe7VlRsOgqGjcmk8F/kPZDSRFVXmCaO9Y
X-Google-Smtp-Source: AGHT+IF4roPzKpF5mOdLPD8yUomO7aafgqG00Tg3I9vWZodZOR0nKDb2qD6SPXbjgVJdLOGWXEijcQ==
X-Received: by 2002:a17:903:a8d:b0:1e2:1db5:dbbd with SMTP id mo13-20020a1709030a8d00b001e21db5dbbdmr1102082plb.28.1712212285423;
        Wed, 03 Apr 2024 23:31:25 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902ec8700b001ddddc8c41fsm14429558plg.157.2024.04.03.23.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 23:31:24 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv4 net-next 0/2] ynl: rename array-nest to indexed-array
Date: Thu,  4 Apr 2024 14:31:11 +0800
Message-ID: <20240404063114.1221532-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rename array-nest to indexed-array and add un-nest sub-type support

v4:
1. Separate binary and integer handling (Jakub Kicinski)
2. Update sub-type example in doc (Jakub Kicinski)

v3:
1. fix doc title underline too short issue (Jakub Kicinski)

v2:
1. raise exception for unsupported sub-type
2. merge all sub-type handler in _decode_array_attr
3. remove index shown in indexed-array as some implementations are
   non-contiguous.

Hangbin Liu (2):
  ynl: rename array-nest to indexed-array
  ynl: support binary and integer sub-type for indexed-array

 Documentation/netlink/genetlink-c.yaml        |  2 +-
 Documentation/netlink/genetlink-legacy.yaml   |  2 +-
 Documentation/netlink/genetlink.yaml          |  2 +-
 Documentation/netlink/netlink-raw.yaml        |  2 +-
 Documentation/netlink/specs/nlctrl.yaml       |  6 +++--
 Documentation/netlink/specs/rt_link.yaml      |  3 ++-
 Documentation/netlink/specs/tc.yaml           | 21 +++++++++++------
 .../netlink/genetlink-legacy.rst              | 22 +++++++++++++-----
 tools/net/ynl/lib/ynl.py                      | 23 +++++++++++++++----
 tools/net/ynl/ynl-gen-c.py                    | 18 ++++++++++-----
 10 files changed, 70 insertions(+), 31 deletions(-)

-- 
2.43.0


