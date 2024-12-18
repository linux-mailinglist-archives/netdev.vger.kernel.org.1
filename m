Return-Path: <netdev+bounces-153066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CAC9F6B40
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 17:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC4C1898561
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041C1F76A2;
	Wed, 18 Dec 2024 16:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="MRB6uKCw"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215C1F7577;
	Wed, 18 Dec 2024 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734539643; cv=none; b=QnnFkUMKDx6h7uFKUSYkEW4oSShqz3LrzKjv+Wv6gnGsgeg8iO7XMWjN5iF1pNKZXGkQxT7NhMg4CMMqw/HdnnRuB1xObGf5tqAfiwiHPV0Itg6T7N+PCMvKlk+oTo7ggzKS1WjFHnztX4EMlDUe/uuqhKL61h52YOv3sEysf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734539643; c=relaxed/simple;
	bh=8QbnrVVb4oToyUSLFXtgfuho+CaABor57AOP4DzyrOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtFq791hcC2QP/otFrj31bDNdathz5+o4Yw0KjaGdFukl3HBzl9EGc6V8SjjhEWSheWRZ6R/89NsNpJq2U7CfcVMZfXfbECu+NXyNlVi6wbJD2LAqrnYB7GGOaAVqLrnBqrPC3BLhO+QSOR5mbTFSswPXvczGcSoVFnEeUisBHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=MRB6uKCw; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=3LP0J3V0iR3hdlBo95qr6BcILn0uI1nmzpekPrak8i8=; b=MRB6uKCwAHVyYCrv
	eLZVHdOMLZZK0ziV/ve2HEL7uDFjgnJP+nw0/N6qq3PoaEMlAWbSL2vgELQIufMaewsfUg62sq/CR
	CKZXw1cXvPLrvDXdrmhdRkQkfC0iB8CfmW96s+naO0o5ccR0xgNYfhEtPlKhnO7mK7nVyG4aut8WY
	EugXk3Njnr/kUiJNgPpp4fCLME/L2pBYUj92iXhbiVm/uJ8LrvzjTrTB7zLCFF8Xg1ItC/p5t0xPi
	fm+j3xAfgikId715rx9p87fqPd9oeYEeizgMzBnrXKndeB8cikhKEmIwIre4h5I/a408XLRrI99Zf
	HOuI2Xbk+I7neUWr9A==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNwzW-0068f8-2u;
	Wed, 18 Dec 2024 16:33:43 +0000
From: linux@treblig.org
To: salil.mehta@huawei.com,
	shenjian15@huawei.com,
	shaojijie@huawei.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next v2 0/4] hisilicon hns deadcoding
Date: Wed, 18 Dec 2024 16:33:37 +0000
Message-ID: <20241218163341.40297-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

Hi,
  A small set of deadcoding for functions that are not
called, and a couple of function pointers that they
called.

Build tested only; I don't have the hardware.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

v2
  Add a patch to remove unused enums as recommended
  by Jijie's review

Dr. David Alan Gilbert (4):
  net: hisilicon: hns: Remove unused hns_dsaf_roce_reset
  net: hisilicon: hns: Remove unused hns_rcb_start
  net: hisilicon: hns: Remove reset helpers
  net: hisilicon: hns: Remove unused enums

 .../ethernet/hisilicon/hns/hns_dsaf_main.c    | 109 ------------------
 .../ethernet/hisilicon/hns/hns_dsaf_main.h    |  28 -----
 .../ethernet/hisilicon/hns/hns_dsaf_misc.c    |  67 -----------
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.c |   5 -
 .../net/ethernet/hisilicon/hns/hns_dsaf_rcb.h |   1 -
 5 files changed, 210 deletions(-)

-- 
2.47.1


