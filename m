Return-Path: <netdev+bounces-217055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEB7B37357
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D77D464CEF
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4030CDA5;
	Tue, 26 Aug 2025 19:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhKI/9m7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849B030CD9E
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 19:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756237484; cv=none; b=fqVWEav6TQpk/RL74wk76iDoIAsmDulxVsRCbyFYKf6o0DkecaZHrhUUmgo7/wMUAvD6zgo0h44hrb7TG12xkGrQdfBSjd7FODo/RB7Mkl41A6uM1VFAJl+VPNhN09c20fEjlBT59hdV9BtrPl+9xY7VMm9ZA6YTXHT/JGH9gU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756237484; c=relaxed/simple;
	bh=rxv6SGSfoaM8DK1R4c075MN41q07lPHihYRx77RCBgA=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=MgHMSKLzI4oQZ9ksE+UWdBQoj2/mEOtzGtR2RtdOXt37GIRMQYxpYrzd/dDYpUW/E6NwcKNm11TrgJPIeFh+uipIS0WihS5seMJHKpO3vGitLLpsbDhCUD6jGWfOkhx0WsXHWp3ALhxGS4+DvJUMLhQapUXW2ivo/NzPdA6Bz+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhKI/9m7; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e2e88c6a6so5386645b3a.1
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756237483; x=1756842283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=uBCQcOF8/dkBYQETDVM8wn4O+4XlR+kOSO9NZybPkRw=;
        b=HhKI/9m73wuRbVCX9rPjAmsBZycL64epUH080XU0b4kpUWWAgxR25hqan+i8wKnv96
         DJixHLlDs+QlcTl3kXx9YANaWxDMs90MsbS9wH4kt/QkrG/rjyO9IDJxNxct1rFIPVf6
         jMvS+GJZOQLpHQXs6KHhH9eKpq5asEKOdA6+KDVriicrK7a6yTkhiu8JK/3HoN8lJR2E
         xPKU95YbH31AmO5LMXj/PeF2W+hs61fspNF0beW74C2ChtgMS9HIj9W+EoHaYHnw6gK4
         /+YBgrDVkwaJok7TK4mQdFtkR9R6sM5YQ0wkzfI3TTR8/MEOCmQ2Jsv9UXFShjatm+B3
         LGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756237483; x=1756842283;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :cc:to:from:subject:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBCQcOF8/dkBYQETDVM8wn4O+4XlR+kOSO9NZybPkRw=;
        b=ZVyAvQa83UcSRVaVq8JRp90XOvVnftLSgyoE9VP2rfKsODY8h2OoFmzGq7e9UZ5tt1
         R6cMzJVC+azyTcE1DmIqsZjXGgfyihVDZsjSbarEXHsI9W5L6yqZbQ984LEHokRT0qH8
         Wslp/7ng7niPu4Cc1kW3NmhpfLb8R4kQ6+9tFPQsEAOpVSCyoB+RjcHVccpDNd3nkJcs
         VHQUl8tXoWiO9aZx70xmU41tjrIglZ8bIw6TzC+Z+ogkK6nLxARB+F96oq2sd1dJfKpD
         vBr9Jrho2XZBaMFzk0vNg1HZZiwcncTuIhVjpmFWBA/KTvXUeNxyGqcU7HGfXUHuj6CV
         ugFQ==
X-Gm-Message-State: AOJu0Yx9yTx9wSsJLIUZWjl8THc8k5oRZiGTs7bierUHck12/63wPQwQ
	3IBO7JskEilX7tCzoAfknjDxewYdqTo76E2waRZWxgseSRzI3Y9rRkI1
X-Gm-Gg: ASbGnctYK9zAITFkjhSXsI2AhSIwcDJ0UcWWavkFlGsgEo+p3RRiRVes8VLFDV3V7c3
	XI4Cf5+e/dsD2/eJzNqWHNDPAlMqguMOwHFxbGl0kzvsI0ZWi78CRYekaOtOULQLrkR3a3LTg3j
	UM6mX/K54eYZAMRF9MUUb7iugDY4GcdBC3OP0WwCfG6PwYKy/5La3wSpbUwU89zprLD1XafkQ9x
	qwAwNr9i2NY0kY3zWh088urd35lKcO9ogG1iFlZPjv6K+fVT8JEKEl5KMUPxMDulr0paXitb2go
	VEM6P7zba8S8YqKmn4/J1S+8I/4FMk7466mmh0PlgSWhp+0VO0v5Vz97zEYCSwA/ffDTb2zdlQG
	4ON9knBcNs8MQq2MSxEqg5uf3xyMlCDnaq+FuyvqSu6TbEfN0bMAD2qSEoAZRc5hVZ3BTCUUgyN
	7qJw==
X-Google-Smtp-Source: AGHT+IFeOBrGz4aou90F4Kv+zAYxcH/ypImfF45vtw9rZTYk3oQ24Pvia6FClWWKsbiUt+tTUD2INg==
X-Received: by 2002:a05:6a00:3e27:b0:770:4d54:6234 with SMTP id d2e1a72fcca58-7704d546526mr13989657b3a.3.1756237482508;
        Tue, 26 Aug 2025 12:44:42 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771f7fe29b0sm3046107b3a.9.2025.08.26.12.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:44:42 -0700 (PDT)
Subject: [net-next PATCH 0/4] fbnic: Synchronize address handling with BMC
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 pabeni@redhat.com, davem@davemloft.net
Date: Tue, 26 Aug 2025 12:44:41 -0700
Message-ID: 
 <175623715978.2246365.7798520806218461199.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The fbnic driver needs to communicate with the BMC if it is operating on
the RMII-based transport (RBT) of the same port the host is on. To enable
this we need to add rules that will route BMC traffic to the RBT/BMC and
the BMC and firmware need to configure rules on the RBT side of the
interface to route traffic from the BMC to the host instead of the MAC.

To enable that this patch set addresses two issues. First it will cause the
TCAM to be reconfigured in the event that the BMC was not previously
present when the driver was loaded, but the FW sends a notification that
the FW capabilities have changed and a BMC w/ various MAC addresses is now
present. Second it adds support for sending a message to the firmware so
that if the host adds additional MAC addresses the FW can be made aware and
route traffic for those addresses from the RBT to the host instead of the
MAC.

---

Alexander Duyck (4):
      fbnic: Move promisc_sync out of netdev code and into RPC path
      fbnic: Pass fbnic_dev instead of netdev to __fbnic_set/clear_rx_mode
      fbnic: Add logic to repopulate RPC TCAM if BMC enables channel
      fbnic: Push local unicast MAC addresses to FW to populate TCAMs


 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 106 ++++++++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  23 +++-
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  60 ++--------
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |   4 +-
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   |   6 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c   |  86 ++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.h   |   4 +
 7 files changed, 225 insertions(+), 64 deletions(-)

--


