Return-Path: <netdev+bounces-17048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B374FEA5
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 07:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D97D1C20F53
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD661C2F;
	Wed, 12 Jul 2023 05:17:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18C57FD
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 05:17:27 +0000 (UTC)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F4DA6
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 22:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689139044; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QD64gpALGU1Wq0sGwP0BCeAYTG89ecYrOBmgdFI10GRLsdESIrVIkZeJ6tE8xpW0AzdcBLKr0usd4dz7mtF2N8c3KSTcMDXFnNuylKt+dSqWufKrk8DzkOxSlvz0fT4W4DuCwxNsjn4OTJwxqv4SXVcHTPA2kxr/PwaqyTLaxPQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1689139044; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=XepVY5CFoXAYk1tYyCcHO848gbrIm+AXaNj1/bahi1w=; 
	b=cYKf2kBtVWNCBsO7Bbuc/dk5QPim5k0F6wj6hXy8I0gkzCuT0wIoRYFupdPYB2CdSphXKJdQJhQSr1LCN84dmmUL7fAx4VU6P7P7DxvE0nofUxmJJTTqKOnWOw/EfKrwfRcr87rcrfAuVOpVxGbLSBj7MXeKYkNuzzgVQF2PBhQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=chandergovind.org;
	spf=pass  smtp.mailfrom=mail@chandergovind.org;
	dmarc=pass header.from=<mail@chandergovind.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1689139044;
	s=zoho; d=chandergovind.org; i=mail@chandergovind.org;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=XepVY5CFoXAYk1tYyCcHO848gbrIm+AXaNj1/bahi1w=;
	b=jPL/qlOASSfj2480XjDKhuX7l5iPoNaNavcyHwU4ec2XOcyAnLj1LXsZPmP48PDF
	jf3iIXA/g/v33MdbYlRzwDif5YGlWImeGKcys550H7gJKuTp/09fB9qeDAIhYqagn4B
	VvlMqgCS9u1rdShJXbDged/D+ugYh73FMA6ZhChk=
Received: from [192.168.1.43] (101.0.62.3 [101.0.62.3]) by mx.zohomail.com
	with SMTPS id 168913904284729.468870344164998; Tue, 11 Jul 2023 22:17:22 -0700 (PDT)
Message-ID: <ce6074bd-2e72-25ef-5827-6336c081b66c@chandergovind.org>
Date: Wed, 12 Jul 2023 10:47:18 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: netdev@vger.kernel.org
From: Chander Govindarajan <mail@chandergovind.org>
Subject: [PATCH iproute2] misc/ifstat: fix incorrect output data in json mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Due to this bug, in json mode (with the -j flag), the output was
always in absolute mode (as if passing in the -a flag) and not in
relative mode.

Signed-off-by: ChanderG <mail@chandergovind.org>
---
  misc/ifstat.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index f6f9ba50..6c76fa15 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -569,7 +569,7 @@ static void dump_incr_db(FILE *fp)
  			continue;

  		if (jw)
-			print_one_json(jw, n, n->val);
+			print_one_json(jw, n, vals);
  		else
  			print_one_if(fp, n, vals);
  	}
-- 
2.36.1.299.gab336e8f1c

