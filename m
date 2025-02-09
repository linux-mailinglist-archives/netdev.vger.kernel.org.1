Return-Path: <netdev+bounces-164444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430D2A2DD25
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 12:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F8D3A6437
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 11:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43001199223;
	Sun,  9 Feb 2025 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="lS9RmhUB"
X-Original-To: netdev@vger.kernel.org
Received: from wp175.webpack.hosteurope.de (wp175.webpack.hosteurope.de [80.237.132.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441156F06A
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 11:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.132.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739101580; cv=none; b=odLb42c7cM3UA/IIHFLp6b5+Xlq473J4VDDizNHWp6YGPTU70x43qu5jxuz2IMXZ44Fq/bUgidUvOLkoY2+0UJ+LosrM4DeHJyZSkGvAmXEeoBIBePlWgCg18EuZK+c5DKip0biR8wEdQ38FAFLaQcDqTwqqd/5zqOuuJEbJuAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739101580; c=relaxed/simple;
	bh=2YQ0Z9VJRJAuDcCknQnD0bYtE2SEQba1+QDHYWf9uFA=;
	h=Message-ID:Date:MIME-Version:Subject:From:Cc:To:Content-Type; b=lz9pZKo1ZGlCgYga6v9b75cv2sO6gmoSo4K3yLGAaawaXf8dgi5vL19ZGR5bqHKzO9YXclg4m3Gyj0EXftdyXgqUCiIXRtQCKcwWnv8XjTtYS2SwxaacnIfQqGI4xoT0QAkcAhyCRBKZooxSr4idtYf0OFeojBbVRh+TB2CS20A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=lS9RmhUB; arc=none smtp.client-ip=80.237.132.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=birger-koblitz.de; s=he134867; h=Content-Transfer-Encoding:Content-Type:To:
	Cc:From:Subject:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=bQsJzyreAf1xYtSS4iP8u6nedAT9p660D2bLSRPz32U=; t=1739101578; x=1739533578; 
	b=lS9RmhUBhDRJUpogqpyInlM3rMDm6scV6f5Uolf64xOS8so+2b+MnjbyCjI6aoqX2Vj1adCOi55
	hQ9Xy6uPJOaUfBthWFbIeE0a/DtPYEWlYOaFmGF8qNSMWir0LpfSc4NH1Pi/xx6w1DrnSYT8Y/zSA
	O3opawZxHHTsOb2o+Jn/m0yks/OJiupDDiw69Qadsxuyc8VgGDP23OxUdDmN6b/98kgH2kUJFRIHX
	DDwKNqkGJovYCKHsWajspWC/F+5z150pjLF35jwFMEVF5YEUxCRhRw7CqN61rZ42HZl2gS9R91Wl9
	dJfvAmHXzt2VXKDewYTJdYM4Wpq/RG6q2QuA==;
Received: from [2a00:6020:47a3:e800:73c:e5f5:d827:2240]; authenticated
	by wp175.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1th54i-00BBP6-05;
	Sun, 09 Feb 2025 12:02:08 +0100
Message-ID: <96223803-95a8-4879-8a26-bc13b66a6e6b@birger-koblitz.de>
Date: Sun, 9 Feb 2025 12:01:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next] net: sfp: add quirk for 2.5G OEM BX SFP
Content-Language: en-US
From: Birger Koblitz <mail@birger-koblitz.de>
Cc: Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;mail@birger-koblitz.de;1739101578;a067bad3;
X-HE-SMSGID: 1th54i-00BBP6-05

The OEM SFP-2.5G-BX10-D/U SFP module pair is meant to operate with
2500Base-X. However, in their EEPROM they incorrectly specify:
Transceiver codes   : 0x00 0x12 0x00 0x00 0x12 0x00 0x01 0x05 0x00
BR, Nominal         : 2500MBd

Use sfp_quirk_2500basex for this module to allow 2500Base-X mode anyway.
Run-tested on BananaPi R3.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
---
  drivers/net/phy/sfp.c | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 7dbcbf0a4ee2..9369f5297769 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -515,6 +515,8 @@ static const struct sfp_quirk sfp_quirks[] = {
   	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
  	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
+	SFP_QUIRK_M("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
  	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
  	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
  	SFP_QUIRK_F("Turris", "RTSFP-2.5G", sfp_fixup_rollball),
-- 
2.39.5

