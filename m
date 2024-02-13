Return-Path: <netdev+bounces-71523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBB4853CF8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 22:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB391F22464
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 21:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A1063132;
	Tue, 13 Feb 2024 21:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="CbxZ+vHg"
X-Original-To: netdev@vger.kernel.org
Received: from mr85p00im-zteg06023901.me.com (mr85p00im-zteg06023901.me.com [17.58.23.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB3263121
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 21:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858462; cv=none; b=dEF50xYH0I5hIAKkFxgEBUuWv+IELfze5yrI9MOFGv06vYfKbMPtkIqhuHUjVhy5tByUOHf2CIziqZdqkRcixqg1YfYZ2AgYDWmj+MHqTheT3uZgQfO6Mxo2rbTsRbOS25SUU2zG+Smdr5SsXPWt6YDHUSXMu4I6OAsL66HCj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858462; c=relaxed/simple;
	bh=deVzXIJKdyN53MlMdCN5lx2hReopwLKeGvTDyDYnMcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CGqIgLM7JUcgbhhpCYVKePzRaQBNyJp3MvecObJsWiqScF3qS8IJGAxgMM31SOPoHM8EErFpWslpjrBI9lru0GClTg+MFvrhBH3WLhX+pVK+cuz5/l8grDHRyUb87ytWz+KXQ+cB/COmzPC+d3KVodONNESkanLAkyyeoX4ITz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=CbxZ+vHg; arc=none smtp.client-ip=17.58.23.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1707858460; bh=deVzXIJKdyN53MlMdCN5lx2hReopwLKeGvTDyDYnMcE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CbxZ+vHgxNxQ3yNQvKbf1wuk29+XQDIt+xd8nIQAI/wKl7ldy0SquBR7HbArapSyT
	 R2ZjgQcXvQqfXE1cf59gvJYdv8msPfk2lIlq+G9hiTQWDf97odtB5zhau2Kfjt3cln
	 DaYDYrP6GeBtxDSp4Dxd7b1sqjN/+akaDdd2jfWHriahFR0WLq8ouNXf1W3J+GPA54
	 USFqosneR/p8ZiEHEYhr/i2op9vMFkFXIF970F7ad/I9+ntIwf5ZO7b6WVp/whv2Fm
	 YXvC8MnBgSx9j9/xbgmlONlnM2YBUq37HYNr733fiK/oEf45LBOipe8QfcaBz0S8Ng
	 eBz/nbl8M0jVQ==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06023901.me.com (Postfix) with ESMTPSA id A86246E035C;
	Tue, 13 Feb 2024 21:07:38 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: dsahern@kernel.org
Cc: alexhenrie24@gmail.com,
	bagasdotme@gmail.com,
	dan@danm.net,
	davem@davemloft.net,
	edumazet@google.com,
	jikos@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next 3/3] net: ipv6/addrconf: clamp preferred_lft to the minimum required
Date: Tue, 13 Feb 2024 14:07:36 -0700
Message-ID: <20240213210736.9371-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <89281fb2-fb5d-416a-aff9-31cf6a0d4525@kernel.org>
References: <89281fb2-fb5d-416a-aff9-31cf6a0d4525@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7z8anG7fRHjwsZNKJF-UPIH2AH9SfbTE
X-Proofpoint-ORIG-GUID: 7z8anG7fRHjwsZNKJF-UPIH2AH9SfbTE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_13,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=244 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2402130167

> I went through the set this past weekend along with the earlier thread
> with the problem Dan mentioned. I think the logic is ok. Dan: did you
> get a chance to test this set?

I just applied it on top of v6.7.4 and I do not see any issues. It
handled the router advertisements and prefix deprecation just fine,
AFAICT (it generated just one temporary address as I would have
expected, instead of thousands of temporary addresses with very short
lifetimes).

Cheers,

-- Dan

