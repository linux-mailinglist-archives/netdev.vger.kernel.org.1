Return-Path: <netdev+bounces-44097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3238A7D61D6
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1E18B20DE1
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 06:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A498A11C82;
	Wed, 25 Oct 2023 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="l8E/fR1m"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4580F846F
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 06:51:08 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1750AE5
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 23:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Zb87ibpJbvTG1QFCpXV5iwpqdR6Ekh9ApLvUQ4iUR7o=; b=l8E/fR1mrUfS+0RXiTZhpeGUsJ
	npUDjxVAZub1PL6P2gpYP8VURI1MkphKUeNex0ik4XNoPHM9KGMQCpQwe7vl6pdAaUTF/tFnqQYZ0
	LkqI3Huklw6RXsgLDf1vCbCTBjPocl8L3LO232q679EBJpJFMIQZexZKNKTlpK6DtJonimB91ZAa0
	mCIy2TSBj5rSPdKQJXsY5eWAkXP7+1apTmk7IaKM4GKBReiBrrcI/pHVgPkS2AYAKdCrOrJjFBIUc
	+nN16iIldYNr2EHqKu+3A/IxyoDtXHerUERZIV4Gh6XHmgEY1ZKZ1eiQCMiFo60GeVDbeACS3bZsj
	rGVDXLkQ==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvXjF-0004tH-2H; Wed, 25 Oct 2023 08:50:57 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvXjE-000EoM-KA; Wed, 25 Oct 2023 08:50:56 +0200
Subject: Re: [PATCH v3 net-next 2/6] cache: enforce cache groups
To: Coco Li <lixiaoyan@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Mubashir Adnan Qureshi <mubashirq@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, Chao Wu <wwchao@google.com>,
 Wei Wang <weiwan@google.com>, Pradeep Nemavat <pnemavat@google.com>
References: <20231025012411.2096053-1-lixiaoyan@google.com>
 <20231025012411.2096053-3-lixiaoyan@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ed6f7335-a99f-65f2-1057-79a246c9cdcb@iogearbox.net>
Date: Wed, 25 Oct 2023 08:50:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231025012411.2096053-3-lixiaoyan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/25/23 3:24 AM, Coco Li wrote:
> Set up build time warnings to safegaurd against future header changes of
> organized structs.
> 
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Daniel Borkmann <daniel@iogearbox.net>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

