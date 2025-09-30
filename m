Return-Path: <netdev+bounces-227351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B65D0BACE1D
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 14:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4BF3ABE0D
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B022561AA;
	Tue, 30 Sep 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yTwiMOzn"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085E34BA29;
	Tue, 30 Sep 2025 12:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235983; cv=none; b=gftNY2TmFmmV/+4IQKji4sz6ytqOnh5PxZDMZ44+0rIPz3C6EqGNfINwN69Y2QqrWDxSSF/aibIVZT29r/MA7KTSmTmRoUbCU9Z0MI8J94WoWXWJlFlkMab+REnompE1a//Z7E+FOE2pCF/SDsLrF8Zzk0OSL5wtyFMturqZgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235983; c=relaxed/simple;
	bh=6eKCQ/B33c43ONnZ+/Nb2tdS++4lzEi7VV/6tLsTwrw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Kx2/9CyfSAi29u/2T8EAQZBj09neU3X2xjkdjbhZvknBMsmBvHhrrEnv4BTLs1T8RF3taMBmm+kjFAmrZdbYeBou4embj/d0WgINPCwUGCudpe2HeVGdEkV9iYVef8SYu9hPLZnkYG6gcYkg67nnnNWQ4s5ZWMtU3A9x/5oWWhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yTwiMOzn; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1759235975; bh=zX1yud5rWsehKArldd3NcJNTyIjFnt+V8odHkAI+Jok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yTwiMOzn4ZftmVFh/3id5HKUp8zPF/XiklWzW6vB7flAiD+aAHE2/SXhCL5dGg7p3
	 SYik5yJDacXaFvDnPkhzcpnhsOufYYGwyuz3E41O5HZNR9R8tfvMHu5NR76vQ8LRQ5
	 Xf9divyPNNR3sdjP6F/QJ50YAbsEdiezw7XpXq6o=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszb42-0.qq.com (NewEsmtp) with SMTP
	id 9E1280EF; Tue, 30 Sep 2025 20:39:33 +0800
X-QQ-mid: xmsmtpt1759235973toy47nfyy
Message-ID: <tencent_88053624249C81B35E3F59FCF6F53DEA4007@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb52VHQQjs75muKszaAy9Ea3JvZ1AFrhbMAFXRqZ42zraUhhKbsmF
	 gj7nbfiV/WBVAKwdsx7F8JABhkqiFFFWnUSpCBa/qUXlwTsOpC0C/tPRQ6Bwoohlc6slDS0kmQNf
	 2UgyrbaCZqnoOXRM//P52JACbEHZRVcGLxPQhKv/7CmqkUVXr+K/q7dtUJXM9AO4nrXuz1okbOx4
	 +0gjFIwKBeklSkpjw+r2c8qObcXfGz0oc1GHowP87eJlyLwpP//a6FoQst+YJS7GG0gbWKK5s3Ig
	 QT6/5VRtpGpCQYwzTvdQRWQUhNcJmwQ1Z1C95mBUB2aZFMwa59JSndcf0q5VJv3+p6CXUTZ1lwhe
	 Tcwr5UU621SIeAJeazpewvk/23Hw5fbrhHOhzQNHgUKr4rvkbtwnfImhWwqQpFStsivqNrJXuQbe
	 Z35qn0PLU328fxV0cD0f3LAz2RmYj5GWJZrxBtosfYB01FD/I37IrIFGL+kypoL+oahddr4a+6sD
	 tu0Aj7O/boP++C8ERTYtZNeHqOJJOuzyd0UkYe5JOIsRCsfYMzeC4GN/pIfjcPUSuCNYq3qpkbFZ
	 Kmcji+LCqGUivk2pj1kP5nlj/VwX1+78y7c/htYay52UaqrWHSRrbblzWtCsNuJSr2pTeyHCVqy/
	 YHzL7uFquD9mC3m9nSNYzuoTU5Lgo2HCdCmIsnHwzfoPLmAJxYflI/IOzDf02S63l+8QltvLK1zW
	 QzroxDunBiCKYvWhnZiau8u6c1MISEq4lEtcY5t3BfbiOF4q2f76+pK3tqex9N0h4p7Jx8BiAeC6
	 zY6YEPPROiwNmlavW5wTuOi/hYvF7UjHBuXNuTEs5p7Kko+Ph48e/6dCNq5XObm7cNI90O2Bj9fj
	 rcsvf3KF1eTcf4ma/79mMV33gmDep1HuZ9Bcn9fC1baf6dU4z8qZZd4dDQyXiJC3nV9T0XRTcdDR
	 V37NmDMVLX9bXHxOxyKG2s4/4VD4GT5gMjdUBW0gFXwuRzw4lmLr89vS5l+Ne6PhPhZeiytew1UX
	 pRQB4JJgQx9/V3Dm0sySqogq3Hp9QujgLurlk2dCL/ikLsFOtl
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Haofeng Li <920484857@qq.com>
To: kuba@kernel.org
Cc: 13266079573@163.com,
	920484857@qq.com,
	donald.hunter@gmail.com,
	lihaofeng@kylinos.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH WITHDRAWN] net: ynl: return actual error code in ynl_exec_dump()
Date: Tue, 30 Sep 2025 20:39:33 +0800
X-OQ-MSGID: <20250930123933.22034-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926112406.1d92c89d@kernel.org>
References: <20250926112406.1d92c89d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is not kernel code the error is always -1, and the details are in errno.

Thank you for the feedback and for pointing that out.

You are absolutely right. I now understand that in the context of this 
userspace code, the error handling convention relies on errno for 
details when the return value is -1. My patch was attempting to align 
the return value with a specific internal error code, which, as you clarified,
 is not the established practice here and doesn't provide the intended 
benefit in this case.

I appreciate you taking the time to explain this.


