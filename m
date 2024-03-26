Return-Path: <netdev+bounces-81914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50A88BA88
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8511C312AB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE5C12AADB;
	Tue, 26 Mar 2024 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsHqWSkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA1054BFF
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711435061; cv=none; b=rF8B4Nrh+CoAOel/z5psb6JeLi1TpZ6X3yc7xwQqOoZRQ/ldJ2eXd29u+dLG22U0BKUjfo1LHGtLyqgjmAqFhlKwrAr/AQGNHz5vUU853BYd8m5zmc2uBnMHt2N31Igc7jU6T978g7MSUeRsaR4bjK4DmwaERzllwziDR/zN/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711435061; c=relaxed/simple;
	bh=ZS4xBqmFCxVf1AW8A39WV3+o9L4Bg8IXhKFfbpjwZ/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=daQhS3FFSldz3FFv3gCLe1hHoxhVemlLbpk5ltUvKmSKZgo2b++Ar13saP8Ibt9bNRHBl+EOw3/AW0ct20TZ9gwzjsRBghIuP6g/4bzMcSz7Nd3vjWyV6cRluKq9fZR0L4LI1riYts2xvv+We82VVc3iDnyf9TGQdil86b8rXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsHqWSkk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e0fa980d55so32115ad.3
        for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 23:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711435059; x=1712039859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOkVm7nVj5h/aXy/o/w1kBDmTHOaxBI5l6LYwjmBjbY=;
        b=IsHqWSkkurMdfApJNsbqBF4fhISKKmI/lz3OVuONyPd0m1Q5TMh891Jiju9qfofM7u
         wkEdr7ndN4TDX2ikvjs8kYDoUKoGNaf8aOmfpGA6pp2fK3CuQkmZJfFtrzCSMP+No0Zn
         AeLYI6paINF03LRRDklPs/Rc3lEZcfyti0n14ntNN1DiUjZQKMYRJraZh3FQMdqlkD0+
         H6/+tUvUhihgQFds8vXpu6Uatm2pQV+DibNQa6kwtLPjdMHRSF6HdvKn9WQ5PYLeR7cx
         P3xY4uaFFqiK+tkwzyC+v1chKOrSVckU5erySV3ZL8X/DtA/tuOpxOiAcfLacdY1Dd8i
         Yd7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711435059; x=1712039859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mOkVm7nVj5h/aXy/o/w1kBDmTHOaxBI5l6LYwjmBjbY=;
        b=U17KvPxZ5SZ+d+EBnh3qtqFNFC8ZK4yHEphl5FMSg3lWzbP/4ATCvpDeHoDuynAi0u
         Qd9oW9zf61he62kJwxgWEZK2IrOj+TaWOSyVRuFGOEqZ+6jMf7XyDsEUi4R+Y+QxG4gR
         xxIUv2FNufBy7xD4vboCdpiOG1Lc8IlLjNJJYCWDq/P5jusI8bs9jTz3RK5A7AsJPvjB
         QaIisxHQ4hgSRd2gk7eFD/RFnd5YuWL3WjrC5d0C2u2zBA5mm6LoFCnTSVrLZ5erQEbx
         3QIV1+R3vAJVegJ3zENSprwaGikS/xFS2D98B5PhWA6tmvvPc3gLaqnHsvRDLYIMUKSb
         U75g==
X-Gm-Message-State: AOJu0YzURexW6irqINVw1gMnlW3K+xjdEHpAtYdU9zGeokknX8aUsbDs
	2Pjy+UyWRXO077rC4QlCd5Jn3X7EcP7HVJOgj462qCN4HGCI8uu3G6xWg1veMNwCmWBY
X-Google-Smtp-Source: AGHT+IHqNkE0DxV61UUhsRiYJaFGUp4ckNquBNuImPs1BrweFKTODTiYHVyKsAYNA2Rh0FjE7iaRfg==
X-Received: by 2002:a17:903:2407:b0:1e0:e282:bc04 with SMTP id e7-20020a170903240700b001e0e282bc04mr198915plo.38.1711435058629;
        Mon, 25 Mar 2024 23:37:38 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id n6-20020a170902e54600b001def0897284sm5893458plf.76.2024.03.25.23.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 23:37:38 -0700 (PDT)
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
Subject: [PATCH net-next 0/2] ynl: rename array-nest to indexed-array
Date: Tue, 26 Mar 2024 14:37:26 +0800
Message-ID: <20240326063728.2369353-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rename array-nest to indexed-array and add un-nest sub-type support

Hangbin Liu (2):
  ynl: rename array-nest to indexed-array
  ynl: support un-nest sub-type for indexed-array

 Documentation/netlink/genetlink-c.yaml      |  2 +-
 Documentation/netlink/genetlink-legacy.yaml |  2 +-
 Documentation/netlink/genetlink.yaml        |  2 +-
 Documentation/netlink/netlink-raw.yaml      |  2 +-
 Documentation/netlink/specs/nlctrl.yaml     |  6 ++++--
 Documentation/netlink/specs/rt_link.yaml    |  3 ++-
 Documentation/netlink/specs/tc.yaml         | 21 +++++++++++++-------
 tools/net/ynl/lib/ynl.py                    | 22 +++++++++++++++++++--
 tools/net/ynl/ynl-gen-c.py                  | 17 +++++++++-------
 9 files changed, 54 insertions(+), 23 deletions(-)

-- 
2.43.0


