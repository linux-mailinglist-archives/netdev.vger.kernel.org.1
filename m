Return-Path: <netdev+bounces-43810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D7E7D4E18
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D576B20EC1
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 10:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA526286;
	Tue, 24 Oct 2023 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854126287
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 10:38:41 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5630E5;
	Tue, 24 Oct 2023 03:38:39 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 1830C20820;
	Tue, 24 Oct 2023 12:38:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4xwplae0baS; Tue, 24 Oct 2023 12:38:37 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id AB4F520743;
	Tue, 24 Oct 2023 12:38:37 +0200 (CEST)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout1.secunet.com (Postfix) with ESMTP id A881E80004A;
	Tue, 24 Oct 2023 12:38:37 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 24 Oct 2023 12:38:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 24 Oct
 2023 12:38:37 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 7A38D3182A2A; Tue, 24 Oct 2023 12:38:36 +0200 (CEST)
Date: Tue, 24 Oct 2023 12:38:36 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: <netdev@vger.kernel.org>
CC: Antony Antony <antony.antony@secunet.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH ipsec-next] xfrm Fix use after free in
 __xfrm6_udp_encap_rcv.
Message-ID: <ZTeerJZ6Js393ZEs@gauss3.secunet.de>
References: <ZTI0452CF5hoHRoA@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZTI0452CF5hoHRoA@gauss3.secunet.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, Oct 20, 2023 at 10:05:55AM +0200, Steffen Klassert wrote:
> A recent patch changed xfrm6_udp_encap_rcv to not
> free the skb itself anymore but fogot the case
> where xfrm4_udp_encap_rcv is called subsequently.
> 
> Fix this by moving the call to xfrm4_udp_encap_rcv
> from __xfrm6_udp_encap_rcv to xfrm6_udp_encap_rcv.
> 
> Fixes: 221ddb723d90 ("xfrm: Support GRO for IPv6 ESP in UDP encapsulation")
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Now applied to ipsec-next.

