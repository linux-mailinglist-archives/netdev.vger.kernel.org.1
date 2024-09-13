Return-Path: <netdev+bounces-128108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC5D9780CB
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 15:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3E71C21529
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DE01DA607;
	Fri, 13 Sep 2024 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JS63M9A8"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD8A1DA602;
	Fri, 13 Sep 2024 13:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726233221; cv=none; b=dAD4ZukO01jlcmMnwPjqV6E1d2Hicaqds6HTr57qO1KF9UX/ZLBsnwSznys27mihh/1Z1J9qVO8lOGt3AfvDySRXjqn+ZnQuEh2O8r4ox6rToAwS8TGZy3dvIGmdBnLaNr9ueRofyr2HFIR0nJGAezOFP9ZR6TPQpy93XWhHlxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726233221; c=relaxed/simple;
	bh=xrQxWJkRuQITyDr76K4MZDp0akfB+vWjXpwZU1GkS8w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SS5a13+Fi1hIhinTbwcHjtQSMJs85Lk+GI9bsjTZAMYM9ESdLHZlKKBt1rkpCh5Xm0lAzKep/Y5P9jyKHdiOg7+2V/XSRe8fT/GCc02SRP1p9Kdr7yMjjZqjDS8RYQq4Y7QVKTZYoF1x0oRMIxGORzxDKVAC48QZDtv6uJwW1Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JS63M9A8; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=uzFI0flTBpzz34Oi82eILZJHz97Z0LJ9TxmCYI0Kj0E=;
	b=JS63M9A8R5p0WESrSOGPp+e2LmqdE0HGBLyHO6QCcqQK2Bk88mauwq0/mAoTgW
	BwNCXYHg7EUYPs81Xg9AyzcRmOOGfqfqRof7FNeVnlTU0tJq4ZWD4l99Lh0lWxr7
	qn7Vy40rL4alS+SUhuXyw3ITlp7g7BAumgShCqVxH3vTg=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-2 (Coremail) with SMTP id _____wD3vwtoOuRmVyplHA--.24763S2;
	Fri, 13 Sep 2024 21:13:13 +0800 (CST)
Date: Fri, 13 Sep 2024 21:13:12 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: junfeng.guo@intel.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Is this an out-of-bounds issue?
Message-ID: <ZuQ6aCn7QlVymj62@iZbp1asjb3cy8ks0srf007Z>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID:_____wD3vwtoOuRmVyplHA--.24763S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKF4DGFyrKF45Jr47ZF1UZFb_yoW3CFc_X3
	4Y9a4fWrWUuFn3Ka15Kr4ava95AF47X3Z5XFykW393C34UJw4UJFn7WrZ7t3yDGF4akF9x
	CryrKa12yasxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUepWlPUUUUU==
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiYAxZamV4JOcNYwAAsv

The code in drivers/net/ethernet/intel/ice/ice_parser_rt.c:

114 static void ice_bst_key_init(struct ice_parser_rt *rt,
115                              struct ice_imem_item *imem)
116 {
117         u8 tsr = (u8)rt->gpr[ICE_GPR_TSR_IDX];
118         u16 ho = rt->gpr[ICE_GPR_HO_IDX];
119         u8 *key = rt->bst_key;
120         int idd, i;
121
122         idd = ICE_BST_TCAM_KEY_SIZE - 1;
123         if (imem->b_kb.tsr_ctrl)
124                 key[idd] = tsr;
125         else
126                 key[idd] = imem->b_kb.prio;

The "ICE_BST_TCAM_KEY_SIZE" macro is 20, so "idd" is 20 - 1 = 19.
"key" equals "rt->bst_key" which is an array, and the size of the
array is ICE_BST_KEY_SIZE which is 10.
Is it possible that 'key[idd]' might access invalid memory?
Should the "idd" be "ICE_BST_KEY_SIZE"?

-	idd = ICE_BST_TCAM_KEY_SIZE - 1;
+	idd = ICE_BST_KEY_SIZE - 1;

-- 
Best,
Qianqiang Liu


