Return-Path: <netdev+bounces-227067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13976BA7C17
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A883A7B85
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8635C1E7C38;
	Mon, 29 Sep 2025 01:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PPo2Qs1y"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644312110;
	Mon, 29 Sep 2025 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759109337; cv=none; b=Dw1b8kfMuJ8B5j29LoCQc25x9cXp5hm7m6Rl3exwLIOjrZ7Go4ILLO7XumRq3sBFoLnxh5btGWR6Jg9Ccaqp8QN2V3ca5sgnG9YaK7si9bE++HNTwAl6RS0gFRb5QCeJpOz+BnRWgjmdipmx6hdZ6KO7UtodJHAEIsuNUZ+maeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759109337; c=relaxed/simple;
	bh=EmrVUjt1B7D3/886Y65cqPufs0zQ3UHheF0eHCWdCF8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsbiIl5M6OrkFdQ2ccZW66BhWYfXaA4SYG2fDEfwrL9b+7lDqUnMoRoFKaV/yLISFrL3c3WNLqZMRdpMa3CSjFPIbUVnUhF45PkqGmdECQaGcGhz6Sj8vc/VAtQmNNwC5krcPDnatSEOg2tbfqx9EF/YwXhGHwfKbWHQ+OwEQ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PPo2Qs1y; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759109330; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=295nRhO9MYqzL4GtE97bjEtpjgYaFIkVbxp0RokEeP0=;
	b=PPo2Qs1y20JQG6bUGvr5Vt87YI+06Tcp3cDnFrJ4GVLOSmo0g7ImKnTNv0b1tKxBqHOeIrjlT/Z/Oq4HXK32mnoIEAEjNUSH0MlHHniR/0U8OVjGBTI7uS5Y1DTGhnE534PhrmQOvp5fwPkQI4nXKwfx1c0jo8d6iWK3/rXHfPk=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WozpMtJ_1759109329 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Sep 2025 09:28:50 +0800
Date: Mon, 29 Sep 2025 09:28:49 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Halil Pasic <pasic@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] net/smc: make wr buffer count
 configurable
Message-ID: <aNng0d1YGP7K0C6z@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250929000001.1752206-1-pasic@linux.ibm.com>
 <20250929000001.1752206-2-pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929000001.1752206-2-pasic@linux.ibm.com>

On 2025-09-29 02:00:00, Halil Pasic wrote:
>Think SMC_WR_BUF_CNT_SEND := SMC_WR_BUF_CNT used in send context and
>SMC_WR_BUF_CNT_RECV := 3 * SMC_WR_BUF_CNT used in recv context. Those
>get replaced with lgr->max_send_wr and lgr->max_recv_wr respective.
>
>Please note that although with the default sysctl values
>qp_attr.cap.max_send_wr ==  qp_attr.cap.max_recv_wr is maintained but
>can not be assumed to be generally true any more. I see no downside to
>that, but my confidence level is rather modest.
>
>Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust


