Return-Path: <netdev+bounces-42919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD967D0A3F
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B582823D8
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C5010783;
	Fri, 20 Oct 2023 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB1101FB
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 08:07:53 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA06E8
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 01:07:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A16E02087C;
	Fri, 20 Oct 2023 10:07:51 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ghCLB6m_zElE; Fri, 20 Oct 2023 10:07:51 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3C85320820;
	Fri, 20 Oct 2023 10:07:51 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3737180004A;
	Fri, 20 Oct 2023 10:07:51 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 10:07:50 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 20 Oct
 2023 10:07:50 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 2E0A63183E94; Fri, 20 Oct 2023 10:07:50 +0200 (CEST)
Date: Fri, 20 Oct 2023 10:07:50 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [net-next 01/15] xfrm: generalize xdo_dev_state_update_curlft to
 allow statistics update
Message-ID: <ZTI1VpRSUPILRAm5@gauss3.secunet.de>
References: <20231020030422.67049-1-saeed@kernel.org>
 <20231020030422.67049-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231020030422.67049-2-saeed@kernel.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Thu, Oct 19, 2023 at 08:04:08PM -0700, Saeed Mahameed wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> In order to allow drivers to fill all statistics, change the name
> of xdo_dev_state_update_curlft to be xdo_dev_state_update_stats.
> 
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Acked-by: Steffen Klassert <steffen.klassert@secunet.com>

