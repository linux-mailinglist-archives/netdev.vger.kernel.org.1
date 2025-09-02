Return-Path: <netdev+bounces-219369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45861B410CF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0734A3B8D40
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED81ADC97;
	Tue,  2 Sep 2025 23:35:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E99327F006;
	Tue,  2 Sep 2025 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756856143; cv=none; b=GFRaZPWrK76Kp4CpO7GNXx6Nrn4jitS1I//+n2KnIWT/Wjtnd0VfRuZTVIRq+b5A34ZnH43Hd/LwmndonEXnUyXbD/Wr77gzfayUuVRxCuN3bc9sQKLELyxPqh0kEuksR/++/Brf9VTbGEupOpaIjjX0Z9Bt4y4vUydLstGH7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756856143; c=relaxed/simple;
	bh=QB3RSNIy+ncxYBl0Goee+lHvvnxDu9oxlhQwRzFjG5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ApssvI5bO+oPEYTrm5EUWxMGhLEJ0DcSG5TEkST4KQ7iqJyvIRa1GZ6Hv135cuF0hKnWZJUVcCKZjLsBwq1+a12JqpLbQIFw1A83u68AsZ0h1EtXaatOf6Qqbub7BXxhn1fdKWmaHh3TwAetMJG7hdBYaK1+TmX/d1LrLuyfJTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1utaX5-000000001Gz-3aQO;
	Tue, 02 Sep 2025 23:35:23 +0000
Date: Wed, 3 Sep 2025 00:35:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: [RFC PATCH net-next 0/6] net: dsa: lantiq_gswip: convert to use
 regmap
Message-ID: <cover.1756855069.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Prepare the lantiq_gswip DSA driver to use transports other than MMIO to
access the switch registers by using regmap.

In order to ease future maintainance and get rid of unneeded indirection
replace the existing accessor functions in favour of using the regmap
API directly.

The biggest part of that conversion is done using easy-to-review
semantic patches (coccinelle), leaving only a few corner cases and some
optimization to be done manually.

Register writes could be further reduced in future by using
regmap_update_bits() instead of regmap_write_bits() in cases which allow
that.

Also note that, just like the current code, there is no error handling
in case register access fails, however, an error message is printed in
such cases at least.

This series is meant to be merged after series

"net: dsa: lantiq_gswip: prepare for supporting MaxLinear GSW1xx"[1]

and also after the series with fixes Vladimir Oltean is currently
preparing; applying a bunch of semantic patches is easy even after code
changes, while on the other hand applying his code changes after the
conversion to regmap would require a rework of all his work).

Hence this is posted as RFC to potentially get some feedback before
both other series mentioned above have been merged.

DSA selftests have been run with this series applied, the results are
unchanged (ie. the expected result).

[1]: https://patchwork.kernel.org/project/netdevbpf/list/?series=997105

Daniel Golle (6):
  net: dsa: lantiq_gswip: convert to use regmap
  net: dsa: lantiq_gswip: convert trivial accessor uses to regmap
  net: dsa: lantiq_gswip: manually convert remaining uses of read
    accessors
  net: dsa: lantiq_gswip: replace *_mask() functions with regmap API
  net: dsa: lantiq_gswip: optimize regmap_write_bits() statements
  net: dsa: lantiq_gswip: harmonize gswip_mii_mask_*() parameters

 drivers/net/dsa/lantiq/Kconfig        |   1 +
 drivers/net/dsa/lantiq/lantiq_gswip.c | 443 +++++++++++++-------------
 drivers/net/dsa/lantiq/lantiq_gswip.h |   6 +-
 3 files changed, 228 insertions(+), 222 deletions(-)

-- 
2.51.0

