Return-Path: <netdev+bounces-215143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F0B2D2FA
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 06:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AACB116B0A7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714FB78F26;
	Wed, 20 Aug 2025 04:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TouYaUaR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC958245014
	for <netdev@vger.kernel.org>; Wed, 20 Aug 2025 04:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664204; cv=none; b=gg8xxseq577PASCTmPsdxsTuwdxxYtqcUzkBuJ/V4wDoGNFFr2iLHvQELpHj8xLfTyN+zxs1W2FH/0EqrV86SgCJEbDQZwCdAsZZguxYHhoIGAypI3MegQTRpI7gzkknnyehUgWu3J89Mln4a/na/+9TocmHfy8pXmtv7sKfbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664204; c=relaxed/simple;
	bh=j7GdqpbRQnKiL+YA5c1CqZDhaW9qk+RTqb/XOZKLv+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXGJKN83BXimG8IOnYNtz9ecwXLHpP2Yew5PnUTW743S2TjmMSgkfzc1aafuG4taTciGt7PfTiikHUa4okNa1pxLmD9aIV7oRDtYKbEd2RSUj7k825i/PMvcoJn8GHnQfgK7f1NqMskeAdzX4QmkeIJzbMzOQT9fuAKZ8ZiOH0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TouYaUaR; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb6ce24so5268838b3a.3
        for <netdev@vger.kernel.org>; Tue, 19 Aug 2025 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1755664201; x=1756269001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O/XhOpQfSquhT6qAiE/Hm7UDJfbQoL+JBQv5VOGD3m8=;
        b=TouYaUaRQw2+IQv4ajv2cwG1X+qf6fNruB0BJ0QmQlxONp5/E6oEqE8GmxdKxetHWC
         TtFZcaqEPWZ6kNKw6lKS7w73Qm6XslRnbpkWNRUVsab3p46ViCI1BIhiSDUd8IYbfrDc
         NDyBDvJyFaef7S3W0FfPEIxDnURmG9iqCgnrtPI6TbJ889rlnUM6+KRRfaRW2Yj6Dt3A
         SSzqhyDTEK4L+HCGEicI0epA0QJD4RBJmq6jAF22VWI01DB3kQyWM1C+vr4nWIlFVsQR
         xdiJ0tX08L/DdigYhwGBVgvfi8Gbuy2x7tA9KVve3MyuY4DRMO3rxaRBTN8WNC5bj8Vk
         RK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664201; x=1756269001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O/XhOpQfSquhT6qAiE/Hm7UDJfbQoL+JBQv5VOGD3m8=;
        b=lm1sEcZhU6J+dtqRarVLP//Rlks6JIj14IHTPfv+bJ8Vvx4JQFvcp3eqYcBvDl1RtY
         2AUhxXVG/ol9msfvmZd6Df7lHR1tNunNr4bmkgPxWxCNSf8+okuB6wQrXnEZ+xgYqJWr
         AfVOJ9aimVuSuH756XfoYlTHBtqKQDt1yDW4VVZgKInBpBiicYgWqZ8qsvQnV5dQqjjA
         IO6o9MJqWdG+iv9SnoxCOlfypSqqXE7R3KaerCT3hpgD0iU9V/KFwH0QzrXB66nixL1J
         qNOzor+wSORU5iKDRZ/zjpe/DYmQl1GJOPAa+hu3UBbXFe7qbXWTM3cB6A93eMXfImf7
         PKDA==
X-Gm-Message-State: AOJu0YzQnra72XsA/OokA1gBO227g8qIFSLK6/DAqMSDNQyQSVwLAB/V
	/nRoQaPoXq5ePqk6VkMlZ0QRN8DDxt9kh6UCXni24RX2mapLqnbCWlFOEhHXmjv+W9W2W76Q83y
	RrjxWWXo=
X-Gm-Gg: ASbGncvnonYI1Lten20HP14TAMu8gNNHGR6GaaB5wma33moY+3r8zWrcsaqYw0Ft7bc
	CagCAEKl3DK1waAh2N31Xh623lEM/mIQPmwJbsLwxl5VFf0WoYAXa/36gq5TypLcXMavMgJY+lg
	FzJh8I/7xZ8L2L5G4VJlNdAIG7Rn/1oHGUNZciffojy1ZP108qrtMamLYJ9cZ9hQMnnoTxDrtSG
	DTcvlAjuemWw1xA/y41f+fp683+vFhgdQZgrfS7b+3JM5T17Pc+9g0mW6oGMgMGvkzLtZ967bmu
	V5sXiprxu4JNIrxdoP3yqoi+kEEiLSNLc0Mi0L/gtF0vEF03ycipODhruZvv9PGoerpZ5/r6Z7H
	rEWw7Kqlz0vd5t7UARSf4dvBF
X-Google-Smtp-Source: AGHT+IGZr4nlgpLI+auV0iC4Ha3LGY7jX80Pp8ALkEHgYHjKKLQHDtDDxmFwBV4EzhFfQNMUpADqwA==
X-Received: by 2002:a05:6a20:9144:b0:243:78a:82b8 with SMTP id adf61e73a8af0-2431b941d4dmr2365720637.50.1755664201106;
        Tue, 19 Aug 2025 21:30:01 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fe8aaesm1133488a12.19.2025.08.19.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:30:00 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Ivan Vecera <ivecera@redhat.com>,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] i40e: Prevent unwanted interface name changes
Date: Tue, 19 Aug 2025 21:29:01 -0700
Message-ID: <94d7d5c0bb4fc171154ccff36e85261a9f186923.1755661118.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The same naming regression which was reported in ixgbe and fixed in
commit e67a0bc3ed4f ("ixgbe: prevent from unwanted interface name
changes") still exists in i40e.

Fix i40e by setting the same flag, added in commit c5ec7f49b480
("devlink: let driver opt out of automatic phys_port_name generation").

Fixes: 9e479d64dc58 ("i40e: Add initial devlink support")
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/net/ethernet/intel/i40e/i40e_devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index cc4e9e2addb7..40f81e798151 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -212,6 +212,7 @@ int i40e_devlink_create_port(struct i40e_pf *pf)
 
 	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
 	attrs.phys.port_number = pf->hw.pf_id;
+	attrs.no_phys_port_name = 1;
 	i40e_devlink_set_switch_id(pf, &attrs.switch_id);
 	devlink_port_attrs_set(&pf->devlink_port, &attrs);
 	err = devlink_port_register(devlink, &pf->devlink_port, pf->hw.pf_id);
-- 
2.47.2


