Return-Path: <netdev+bounces-190146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 105B2AB54A7
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 14:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECBA467C4F
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 12:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B361D28D8EE;
	Tue, 13 May 2025 12:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="mjEXS3eT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43ED228DF17;
	Tue, 13 May 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747139096; cv=none; b=fnTbEMZG5xLQEyneyZUdXTuJh583KL3tjGDx1U0tm0U+YwIr9IKwaRFKM+moZzcPRMekWFKldwqcslz2jCuO/UuLzSQVIjh1WDrjwwS9Hj1pCgW6s2FSMq3mraFpeoCmeGb7ZtHDZR1ZhfM78AK8kAfwqPWrm54FWxBhYfATn9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747139096; c=relaxed/simple;
	bh=FOMStABYI0X0GQeb9jgruByJBKPN5L8Kc6YrlUSIUdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tDHf5RYuHXiB4jBLXyp5jY+3p+OjhxSfgOHe+yes3iAABrLcbN62DcZHJ+AQXRgL7n8Czm8GPkElZhdTVE8tf9oAJBKJw7k0ZZnl/RVBzhzgVGn/MlPmY0aFSDukWBsNy0G+b75gKu6uOYZnOIrHbqHL3nQjitvk7AG6kE0VlwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=mjEXS3eT; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 14e302593;
	Tue, 13 May 2025 20:24:42 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dawid.osuchowski@linux.intel.com
Cc: andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jianhao.xu@seu.edu.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	zilin@seu.edu.cn
Subject: Re: [PATCH] ixgbe/ipsec: use memzero_explicit() for stack SA structs
Date: Tue, 13 May 2025 12:24:41 +0000
Message-Id: <20250513122441.4065314-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
References: <170f287e-23b1-468b-9b59-08680de1ecf1@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCSx5PVklDSEoaT05MSENMHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktJQkxNTFVKS0tVS1
	kG
X-HM-Tid: 0a96c99ab94303a1kunm14e302593
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ODY6SCo4AjE0NjoKPygULDEB
	GhlPCxdVSlVKTE9MSkhCS0NITU5PVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFJSE5NNwY+
DKIM-Signature:a=rsa-sha256;
	b=mjEXS3eTpXS+FDtgFSehxjOzXHe3QpO1wPmQbjgdlqYXAgB+cDCIENq9X4jYKK5VbN44pdMbV2TpRcLHMmnylKvRAkxrllmuj7nD5djWfCdFm/juAZQPW33OtTkAue0TPhCymzpFFChWcDEFwScErynzIv6GWxiwnBn4dd8UdUA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=6tUASdzJci1Yz0hXdfUtvYYXTCY4KP/E4lVG3TUYqMA=;
	h=date:mime-version:subject:message-id:from;

On Mon, May 12, 2025 at 02:53:12PM+0200, Dawid Osuchowski wrote:
> Thanks for your patch.
> 
> Please use the correct target iwl-net for fixes, iwl-next for features 
> and others.
> 
> Maybe add a tag? Fixes: 63a67fe229ea ("ixgbe: add ipsec offload add and 
> remove SA")
> 
> In the future when sending patches against Intel networking drivers 
> please send them directly To: intel-wired-lan@lists.osuosl.org and Cc: 
> netdev@vger.kernel.org.
> 
OK, I will resend the patch to the iwl-net branch and include the Fixes 
tag. Before I do that, I noticed that in ixgbe_ipsec_add_sa() we clear 
the Tx SA struct with memset 0 on key-parsing failure but do not clear 
the Rx SA struct in the corresponding error path:

617     /* get the key and salt */
618     ret = ixgbe_ipsec_parse_proto_keys(xs, rsa.key, &rsa.salt);
619     if (ret) {
620         NL_SET_ERR_MSG_MOD(extack,
                              "Failed to get key data for Rx SA table");
621         return ret;      /* <- no memzero_explicit() here */
622     }
...
728     if (ret) {
729         NL_SET_ERR_MSG_MOD(extack,
                              "Failed to get key data for Tx SA table");
730         memset(&tsa, 0, sizeof(tsa));
731         return ret;      /* <- clears tsa on error */
732     }

Both paths return immediately on key-parsing failure, should I add a 
memzero_explicit(&rsa, sizeof(rsa)) before Rx-SA's return or remove the 
memset(&tsa, ...) in the Tx-SA path to keep them consistent?

Best Regards,
Zilin Guan

