Return-Path: <netdev+bounces-127703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6313976203
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 08:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34941B215C7
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 06:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2201898EA;
	Thu, 12 Sep 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b="kUtO357X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.emenem.pl (cmyk.emenem.pl [217.79.154.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384002F3E
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.79.154.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726124333; cv=none; b=n+GCJ+GUmfxUrbs4PN4XluKPrhURXJs6YR+vKj9dET0VSBdamyiI6/w6aayNOhiY7sTZTie3oDcwcza5RJz9Kky/j18dvWg/h8RqK5c/ivmKuGTmTMRBgqIXwiRrFq4M64A/Kz7aCSZlWFJ7iEzmDAvZxr2hEraZL4XJ/1GkezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726124333; c=relaxed/simple;
	bh=Zq0KYLfCj3KEXz7MuKtQrOPmulVRTkaftgQzc4/hyKU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=I3IrL1yQeELsU9/OsHY7nSlKkwlIaXeozqVXHDuH1qeF8Kbi+3xorpfj8sZ7t1FMMhlHfEO/2XNdZ+ef0Sa43k48QX2nuDvDzKAIXB1NVTJonXu/cv+ONHNAcCxjwjLLRDaJiMqxDCSl/Sog/sU4XMLEWGf67BxQDJYM+HKL8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl; spf=none smtp.mailfrom=ans.pl; dkim=pass (1024-bit key) header.d=ans.pl header.i=@ans.pl header.b=kUtO357X; arc=none smtp.client-ip=217.79.154.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ans.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ans.pl
X-Virus-Scanned: amavisd-new at emenem.pl
Received: from [192.168.1.10] (c-98-45-176-131.hsd1.ca.comcast.net [98.45.176.131])
	(authenticated bits=0)
	by cmyk.emenem.pl (8.17.1.9/8.17.1.9) with ESMTPSA id 48C6whak020289
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 12 Sep 2024 08:58:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ans.pl; s=20190507;
	t=1726124326; bh=qzsoOLVeaNZANsqcfOgNnDlHJOqPsL1hvmi6pjtRk/4=;
	h=Date:From:To:Cc:Subject;
	b=kUtO357Xu340IEGdy7+pn+uQGoco9WSa18sqZ6rqZtxJbKFVzn1emXDWU8BlD0hmT
	 vYV2ilLP/jyZuH6nrV06+huklsqykQI/awPqvjz5RCGousiCY6NN8chIcKgYHC0AjU
	 XewnHR20w2fbVcq2aM2CFeJQ71YmVHr/rcQZMwyw=
Message-ID: <54419258-fa69-447b-9e3f-35accf891d43@ans.pl>
Date: Wed, 11 Sep 2024 23:58:42 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Krzysztof_Ol=C4=99dzki?= <ole@ans.pl>
To: Ido Schimmel <idosch@nvidia.com>, Andrew Lunn <andrew@lunn.ch>,
        Michal Kubecek <mkubecek@suse.cz>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [PATCH ethtool 2/2] qsf: Better handling of Page A2h netlink read
 failure
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Print "Failed to read Page A2h." error message to provide more context
for "netlink error: (...)" info.

Signed-off-by: Krzysztof Piotr Oledzki <ole@ans.pl>
---
 sfpid.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sfpid.c b/sfpid.c
index 1bc45c1..d9bda70 100644
--- a/sfpid.c
+++ b/sfpid.c
@@ -494,8 +494,10 @@ int sff8079_show_all_nl(struct cmd_context *ctx)
 	/* Read A2h page */
 	ret = sff8079_get_eeprom_page(ctx, SFF8079_I2C_ADDRESS_HIGH,
 				      buf + ETH_MODULE_SFF_8079_LEN);
-	if (ret)
+	if (ret) {
+		fprintf(stderr, "Failed to read Page A2h.\n");
 		goto out;
+	}
 
 	sff8472_show_all(buf);
 out:
-- 
2.46.0

