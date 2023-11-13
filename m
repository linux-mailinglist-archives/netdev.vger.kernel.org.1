Return-Path: <netdev+bounces-47292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 695E67E96FF
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 08:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB659280D2D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 07:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB3125DE;
	Mon, 13 Nov 2023 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73E2125C2
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 07:15:52 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A1BC7
	for <netdev@vger.kernel.org>; Sun, 12 Nov 2023 23:15:51 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 0DFA220758;
	Mon, 13 Nov 2023 08:15:49 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PNSIHwJVLjzV; Mon, 13 Nov 2023 08:15:48 +0100 (CET)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4A7C32053D;
	Mon, 13 Nov 2023 08:15:48 +0100 (CET)
Received: from cas-essen-02.secunet.de (unknown [10.53.40.202])
	by mailout2.secunet.com (Postfix) with ESMTP id 45A8B80004A;
	Mon, 13 Nov 2023 08:15:48 +0100 (CET)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 08:15:48 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 13 Nov
 2023 08:15:47 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 67FCB3182A21; Mon, 13 Nov 2023 08:15:47 +0100 (CET)
Date: Mon, 13 Nov 2023 08:15:47 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [RFC ipsec-next v2 0/8] Add IP-TFS mode to xfrm
Message-ID: <ZVHNI7NaK/KtABIL@gauss3.secunet.de>
References: <20231113035219.920136-1-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113035219.920136-1-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Nov 12, 2023 at 10:52:11PM -0500, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> This patchset adds a new xfrm mode implementing on-demand IP-TFS. IP-TFS
> (AggFrag encapsulation) has been standardized in RFC9347.
> 
> Link: https://www.rfc-editor.org/rfc/rfc9347.txt
> 
> This feature supports demand driven (i.e., non-constant send rate) IP-TFS to
> take advantage of the AGGFRAG ESP payload encapsulation. This payload type
> supports aggregation and fragmentation of the inner IP packet stream which in
> turn yields higher small-packet bandwidth as well as reducing MTU/PMTU issues.
> Congestion control is unimplementated as the send rate is demand driven rather
> than constant.
> 
> In order to allow loading this fucntionality as a module a set of callbacks
> xfrm_mode_cbs has been added to xfrm as well.

I did a multiple days peer review with Chris on this pachset. So my
concerns are already addressed.

Further reviews are welcome! This is a bigger change and it would
be nice if more people could look at it.

Thanks!

