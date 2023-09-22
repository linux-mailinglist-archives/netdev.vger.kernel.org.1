Return-Path: <netdev+bounces-35857-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6807AB626
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 0AAF81C209C8
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0A441769;
	Fri, 22 Sep 2023 16:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421E3D986
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 16:38:08 +0000 (UTC)
Received: from mail-vs1-xe64.google.com (mail-vs1-xe64.google.com [IPv6:2607:f8b0:4864:20::e64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B67A194
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:38:06 -0700 (PDT)
Received: by mail-vs1-xe64.google.com with SMTP id ada2fe7eead31-4529d1238a9so1151114137.3
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695400685; x=1696005485;
        h=from:message-id:content-transfer-encoding:user-agent:cc:subject:to
         :date:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD16L7bzKZHGImef/xBf1dFAV1vQpWiuIcQ1e7o+p+U=;
        b=RmP47Y3UyObfdPPnFk5iztlc2PZN350Q41qTaEV5sudgwfhgU30gG31sOF0K6CkMP0
         VVbc04kjJKpP1f73LOzHmmmxcbOh7a/VaMxXX9QU0oLCIHm7z2GuaBn+q9FPc9wICJLE
         m7/lhDExCQm/vjlGyluqKRMDr/TVDZ6iYRs547tObMn6Gc+Y1oDfE1Y+/vs9ggz5etcG
         od/G4TsmcI9xweDwVNEs22jAzCgWgSOpZUmG1+DXQAgU6Ky1LYK5ETcI8gNbFI5lrhOU
         j9jkqbsLyv7vzAqDutwE/c1cUfwmEtiOPVmlNCkEAYRL2X+wkhiZDaskwLC4fBVSif7e
         lvdA==
X-Gm-Message-State: AOJu0YznOZwOcX9ZnKifbPM/2ndSLD0HuN6zzZaiE376xFdJF6p80k2M
	iHCXYuodvnNo+r/POwZ5gcYq39oMuifTyELJzlxWqCuvrlIS
X-Google-Smtp-Source: AGHT+IHFZ12Ok0odf7n7xvLFvliRtfNcU0J6F/mX6xY8/rd40WkKYnJp3VobEZFPd3IRcjUakvZUYy7rTgEo
X-Received: by 2002:a67:fb18:0:b0:44e:8ef9:3371 with SMTP id d24-20020a67fb18000000b0044e8ef93371mr129528vsr.8.1695400685509;
        Fri, 22 Sep 2023 09:38:05 -0700 (PDT)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id w20-20020ab055d4000000b0079de0a4af6fsm222139uaa.11.2023.09.22.09.38.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Sep 2023 09:38:05 -0700 (PDT)
X-Relaying-Domain: arista.com
Received: from us122.sjc.aristanetworks.com (us122.sjc.aristanetworks.com [10.242.248.9])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 8E29B40188E;
	Fri, 22 Sep 2023 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1695400684;
	bh=pD16L7bzKZHGImef/xBf1dFAV1vQpWiuIcQ1e7o+p+U=;
	h=Date:To:Subject:Cc:From:From;
	b=w0JOCtsUqRr9L2yiSMUUh4U0gHzYGhfZiLxPm16WujaERSVmv7pPKtqDh2jHjHqaI
	 yMe+FMU9FsWBedV75VKZ/hneECmmr1MCAQHeUndMXB4oI1tykIoock00DIaHvHP7u7
	 0mTDwP3Vjnt8Ii2CYYB/paPpC6s/E34c4yh/bfQ3ZdeYeAvGUhxL4ksutaqAuAtznL
	 00R1px9OPe0u0S4cxwh7bzpNd/p5VuNzsTE9/xjIViOGBON7jeD+JIkIjN4FekwvOA
	 Lizga9KIhIZ1AQmzxlbSngTiLUUuccaYoN0eGWFGemOAEElyku8vldYpqcS6xjyBRb
	 3ureBhcvVd4LA==
Received: by us122.sjc.aristanetworks.com (Postfix, from userid 10181)
	id 7DDBA2440449; Fri, 22 Sep 2023 09:38:04 -0700 (PDT)
Date: Fri, 22 Sep 2023 09:38:04 -0700
To: intel-wired-lan@lists.osuosl.org
Subject: [PATCH] [iwl-net] Revert "igc: set TP bit in 'supported' and
 'advertising' fields of ethtool_link_ksettings"
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 dumazet@google.com, jesse.brandeburg@intel.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 sasha.neftin@intel.com, prasad@arista.com
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20230922163804.7DDBA2440449@us122.sjc.aristanetworks.com>
From: prasad@arista.com (Prasad Koya)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This reverts commit 9ac3fc2f42e5ffa1e927dcbffb71b15fa81459e2.

After the command "ethtool -s enps0 speed 100 duplex full autoneg on",
i.e., advertise only 100Mbps speed to the peer, "ethtool enps0" shows
advertised speeds as 100Mbps and 2500Mbps. Same behavior is seen
when changing the speed to 10Mbps or 1000Mbps.

This applies to I225/226 parts, which only supports copper mode.
Reverting to original till the ambiguity is resolved.

Fixes: 9ac3fc2f42e5 ("igc: set TP bit in 'supported' and 
'advertising' fields of ethtool_link_ksettings")
Signed-off-by: Prasad Koya <prasad@arista.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 93bce729be76..0e2cb00622d1 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -1708,8 +1708,6 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
 	/* twisted pair */
 	cmd->base.port = PORT_TP;
 	cmd->base.phy_address = hw->phy.addr;
-	ethtool_link_ksettings_add_link_mode(cmd, supported, TP);
-	ethtool_link_ksettings_add_link_mode(cmd, advertising, TP);
 
 	/* advertising link modes */
 	if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
-- 
2.41.0


