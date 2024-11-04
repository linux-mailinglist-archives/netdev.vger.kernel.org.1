Return-Path: <netdev+bounces-141560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD959BB655
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 14:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4E71F2118E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C444779D;
	Mon,  4 Nov 2024 13:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GTkk0+LH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34A28BEE;
	Mon,  4 Nov 2024 13:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730727473; cv=none; b=nXm9pMau/pmCKydDJotwn/f4uJsZasI+RyWjNpMTGdjLDjvZmcB+upRVWmrW+Rbx0JZ1qgciHRzHIwg/NzwDKPrFeVi5Z7hLCRM3qg2/bs5KN+PFAl+qYtxdFBhjjEHp3/MFwDjJmmVR+jGSUmnMhEHtQ302iWQ8lOfDnrCyp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730727473; c=relaxed/simple;
	bh=XqHPSSbjlVSr5o3nmtt71jsZSoju6OmFBUuMeyyg8yw=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=DsbL02nyIokr8jEB+en5E+GrgMBls0/cLN4hBpmJk1sJCJMURo7cjWVSE6jA4Omz1g3CGCd9Y7fqwvDKAqV2d9YVcqZMdtszC+bv7cw823eyOaJKzBKaoxrxxF9qQq2GowAzRYDMsvlWQhC+WeXJXabp+SXIMa8LN7q726FOdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=GTkk0+LH; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730727471; x=1762263471;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=xpNadl6MH9rA1wgJy9p1R38XdPiS+2d+5payMiDbDdM=;
  b=GTkk0+LHYhfXynhDd2EJhKp8L00MQPy60bdZE/anNMJboGfJyayTVAph
   kfjOeSTym1VYKaG1VoV3ToPaGQ6MOY2DhhQY3DtYJ10H1Hh19JoerIZpI
   8KPaR6T4aWCFOQceCZy47pRI7mIYySznWMyMZm/IGFwPVuTjaIb2/+/2Q
   c=;
X-IronPort-AV: E=Sophos;i="6.11,257,1725321600"; 
   d="scan'208";a="144225970"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 13:36:50 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.17.79:42631]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.40.73:2525] with esmtp (Farcaster)
 id 44357325-e725-41b2-a10a-143d4fe3f393; Mon, 4 Nov 2024 13:36:49 +0000 (UTC)
X-Farcaster-Flow-ID: 44357325-e725-41b2-a10a-143d4fe3f393
Received: from EX19D028EUB003.ant.amazon.com (10.252.61.31) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:36:49 +0000
Received: from u95c7fd9b18a35b.ant.amazon.com.amazon.com (10.13.248.51) by
 EX19D028EUB003.ant.amazon.com (10.252.61.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:36:42 +0000
References: <20241101214828.289752-1-rosenp@gmail.com>
 <20241101214828.289752-2-rosenp@gmail.com>
User-agent: mu4e 1.10.3; emacs 29.3
From: Shay Agroskin <shayagr@amazon.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, Arthur Kiyanovski <akiyano@amazon.com>, "David
 Arinzon" <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>, "Saeed
 Bishara" <saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jian Shen
	<shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
	<shaojijie@huawei.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/2] net: ena: remove devm from ethtool
Date: Mon, 4 Nov 2024 15:35:39 +0200
In-Reply-To: <20241101214828.289752-2-rosenp@gmail.com>
Message-ID: <pj41zl4j4nm87y.fsf@u95c7fd9b18a35b.ant.amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D028EUB003.ant.amazon.com (10.252.61.31)


Rosen Penev <rosenp@gmail.com> writes:

> There's no need for devm bloat here. In addition, these are 
> freed right
> before the function exits.
>
> Also swapped kcalloc order for consistency.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 14 
>  +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c 
> b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> index e1c622b40a27..fa9d7b8ec00d 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
> @@ -1128,22 +1128,18 @@ static void ena_dump_stats_ex(struct 
> ena_adapter *adapter, u8 *buf)
>  		return;

lgtm. thanks you for submitting this patch

Reviewed-by: Shay Agroskin <shayagr@amazon.com>

