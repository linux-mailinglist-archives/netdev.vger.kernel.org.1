Return-Path: <netdev+bounces-54125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B044C806098
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46A4B280402
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF66E59A;
	Tue,  5 Dec 2023 21:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JtdAcyaZ"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7044BA5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=U0nWIyEl8/21/VA4RkBhcm7lxKI3MarZ6NUK6TymaWE=; b=JtdAcyaZHvHshfv6tdXBP0/Mgx
	RDAFIC4A4ZCkLm2L+q6zHdEVFlmeA4ojn5GDuTyfSnsedUqY0H6Ao4x+SHU5BTfO6RVS5tW+Vg1ag
	J4/jHBZVCHzGU79VIE7bjATvGk/uUKqzYuv8IGJV/A71sA+ky/g9Ahr7D6KKr6I57stSdNZuCRdU8
	v0ukSaq7StTP2bavh3iHoWdCipwd30ykBNRJtSELM0pnu0EKKiS0G1ubAzRsEUQIJ96dhxnKvyPTi
	qoyQgXVzP1E+jXs1WcsZX9RSyEjI3YW8mmoG26Hvd0PF+FxE2y6l0FKLLEnP5jgy2Auh+hA7qx4u6
	qR15b2pw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAcq4-000Hmf-Tz; Tue, 05 Dec 2023 22:20:20 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAcq4-000WB3-92; Tue, 05 Dec 2023 22:20:20 +0100
Subject: Re: [PATCH net-next v3 2/3] net: sched: Make tc-related drop reason
 more flexible for remaining qdiscs
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-3-victor@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fb8e49e5-818c-12b9-c05b-36fc45ad2d63@iogearbox.net>
Date: Tue, 5 Dec 2023 22:20:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231205205030.3119672-3-victor@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

On 12/5/23 9:50 PM, Victor Nogueira wrote:
> Incrementing on Daniel's patch[1], make tc-related drop reason more
> flexible for remaining qdiscs - that is, all qdiscs aside from clsact.
> In essence, the drop reason will be set by cls_api and act_api in case
> any error occurred in the data path. With that, we can give the user more
> detailed information so that they can distinguish between a policy drop
> or an error drop.
> 
> [1] https://lore.kernel.org/all/20231009092655.22025-1-daniel@iogearbox.net
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

