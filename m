Return-Path: <netdev+bounces-109714-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEA0929B20
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 05:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 600FD1C20DB6
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 03:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA028F5A;
	Mon,  8 Jul 2024 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="eVAAIkhF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4B43FC2
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 03:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720410170; cv=none; b=UtI0SWrB4Di2+cvrYNWaaSZ88tqcjU8Sm495FqI3hkFilh9YX8Zx971lkLjfjU/Jp/ewf8NNCfVl6MKJepbf90Ri8P1OYHUvnP439NHlYNp2zdRsgMgZpddkpV8D39aomfJzzVqiWWLWcFC5aSFkfICj7JB6h5s5q1OZbGcwZq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720410170; c=relaxed/simple;
	bh=d9YNVuE6Py3TD5M4crRxlgz816Yf6LFaxjrd+07F5FM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txKCIolm1FTLeu53GQrxMCuzF/OpDPEnuqEQa9SM1GTiU72tBgRZmj0hogbtx1jMruWDrmnsAHVtbrVgsoyJ/C5Z+FSz7Zavys8D49IyuZ08HXANH2FOOtfBx4cDV6yOu9VJbk2ztbvip+SaShA687wwPVEnnfwwQLFb2rIOSI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=eVAAIkhF; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 4683fVKm008132
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Jul 2024 05:42:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1720410131; bh=Zm5bZpV8waaisVfUEIZpMVuciIDjlbJIFSBNKhd9woY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eVAAIkhFXas9PMEcthIapOwrd5gIT4j9eI8LHFB2CMdmADdEUQvn87G4MPM/Qe1AD
	 48qm4jiGwsFq7I5TZ5Z92rVKXdw3s6LV8Swv3ZPGFHtSq7JjgreDXGXCRqDSbBkDcp
	 df5rsihBmKv8cXNNecfOXwu8VbYb90LRnkHErgxk=
Message-ID: <56384f82-6ce7-49c8-a20e-ffdf119804ae@ans.pl>
Date: Sun, 7 Jul 2024 20:41:38 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] qsfp: Better handling of Page 03h netlink read failure
To: Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>
Cc: Moshe Shemesh <moshe@nvidia.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>, tariqt@nvidia.com,
        Dan Merillat <git@dan.merillat.org>
References: <9e757616-0396-4573-9ea9-3cb5ef5c901a@ans.pl>
 <apfg6yonp66gp4z6sdzrfin7tdyctfomhahhitqmcipuxkewpw@gmr5xlybvfsf>
 <31f6f39b-f7f3-46cc-8c0d-1dbcc69c3254@ans.pl>
 <7nz6fvq6aaclh3xoazgqzw3kzc7vgmsufzyu4slsqhjht7dlpl@qyu63otcswga>
 <3d6364f3-a5c6-4c96-b958-0036da349754@ans.pl>
 <0d65385b-a59d-4dd0-a351-2c66a11068f8@lunn.ch>
 <c3726cb7-6eff-43c6-a7d4-1e931d48151f@ans.pl> <Zk2vfmI7qnBMxABo@shredder>
 <f9cec087-d3e1-4d06-b645-47429316feb7@lunn.ch>
 <1bee73de-d4c3-456d-8cee-f76eee7194b0@ans.pl>
 <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
Content-Language: en-US
In-Reply-To: <de8f9536-7a00-43b2-8020-44d5370b722c@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Page 03h may not be available due to a bug in a driver.
This is a non-fatal error and sff8636_dom_parse() handles this
correctly, allowing it to provide the remaining information.

Also, add an error message to clarify otherwise cryptic
"netlink error: Invalid argument" message.
---
 qsfp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/qsfp.c b/qsfp.c
index a2921fb..208eddc 100644
--- a/qsfp.c
+++ b/qsfp.c
@@ -1038,8 +1038,16 @@ sff8636_memory_map_init_pages(struct cmd_context *ctx,
 
 	sff8636_request_init(&request, 0x3, SFF8636_PAGE_SIZE);
 	ret = nl_get_eeprom_page(ctx, &request);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		/* Page 03h is not available due to a bug in the driver.
+		 * This is a non-fatal error and sff8636_dom_parse()
+		 * handles this correctly.
+		 */
+
+		fprintf(stderr, "Failed to read Upper Page 03h, driver error?\n");
+		return 0;
+	}
+
 	map->page_03h = request.data - SFF8636_PAGE_SIZE;
 
 	return 0;
-- 
2.45.2


