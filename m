Return-Path: <netdev+bounces-183474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7605A90C7C
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E125D17C3D0
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1A4224B1C;
	Wed, 16 Apr 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ozgmyhX0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E74224894;
	Wed, 16 Apr 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744832606; cv=none; b=cUpeqtQVuRhNZua7qzPKueSXmo5R+oogIBZn6oyBzLCQGCtVVmLZTEyXzPrkwvZO9G+MyBaXU70tEB8m7TVHJFG5NgBxdvd9TilYjX/eEn0e63a2Cxmo/A00hUGsXuaEhuICde33NQYj+o4SaruoULbGaakV/4zyMEjmDoi74YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744832606; c=relaxed/simple;
	bh=h/YQPt96ldtM0GI91vMsRvpC2gHexbBHENKvtSaNHwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUaH4tpHG+tC2Y1r6C3CZt99I6cRBeHmXRG0q82Js5nXwLyyieAZAjATSjYF/BZB7fbDBwYtFmcZxNtTQYeNQ/vmhd+mszqYvdoONUo0zQUkYiDirKGL4CbYE4ytGDXiUpbL5EtaFHe+2ZyRkBaetlL6xEBzDQW5AEn2r1KjJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ozgmyhX0; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744832605; x=1776368605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x1KJVxF9JTmZ/SSSPkIaDeoAc3zZc8qAxjyG0a03KBg=;
  b=ozgmyhX08stN7FcFFCh9WV1xM6P4VBo9vjlzuwvRCF65NkB2TjLtGTfz
   zKjyXUDUfXZ75YwjRp9HsoKXTmel9e22Xj1db2FiOQnAK7F1ZbOAn6ApZ
   dYtHV1+vk4ndNLl7xK/MEq3zoe+SZPT1ArJFXS8e7flhS2OM6nfypSrts
   0=;
X-IronPort-AV: E=Sophos;i="6.15,217,1739836800"; 
   d="scan'208";a="481028738"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:43:23 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:59547]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.123:2525] with esmtp (Farcaster)
 id afe8ed0e-d2ee-4efa-9e84-d43d4eacefef; Wed, 16 Apr 2025 19:43:21 +0000 (UTC)
X-Farcaster-Flow-ID: afe8ed0e-d2ee-4efa-9e84-d43d4eacefef
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:43:21 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:43:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <zijun_hu@icloud.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <quic_zijuhu@quicinc.com>,
	<willemb@google.com>
Subject: Re: [PATCH net-next] net: Delete the outer () duplicated of macro SOCK_SKB_CB_OFFSET definition
Date: Wed, 16 Apr 2025 12:43:06 -0700
Message-ID: <20250416194307.28613-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416-fix_net-v1-1-d544c9f3f169@quicinc.com>
References: <20250416-fix_net-v1-1-d544c9f3f169@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Zijun Hu <zijun_hu@icloud.com>
Date: Wed, 16 Apr 2025 19:56:23 +0800
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> For macro SOCK_SKB_CB_OFFSET definition, Delete the outer () duplicated.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

