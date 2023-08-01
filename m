Return-Path: <netdev+bounces-23222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CCD76B5A4
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 15:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36AA2280638
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 13:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047C92151C;
	Tue,  1 Aug 2023 13:19:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B848120F9D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5D6C433C8;
	Tue,  1 Aug 2023 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690895975;
	bh=jgDvo59fKoODFk8V6StawFdECwLkKl8S5v/X9XKIeMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gTJGL+u5VaV9ozdmsiTBfhduAGxUOQXSSYgo4ON6dUAO13ulgkusUZzlGqvwaPMPk
	 oU9WmgFa9binj7YJnuXdo6owpdeSSixomqQiL6Zjk6j6+0f4MSJgX2ouWx0QsbMdkc
	 R3gl5WlzaN/oSZl2DwOjKv8kJiTk7RQjw+CutsnZaW4wGsi+ihYjwTAQmCEBK97ur1
	 lySALjfMpbUmh+eFkN1lwCS2Sxpon68kHxXkHz/cXapYwG5SJ9ozaYXuA025dzDbD1
	 Co1T2bwotNneVIrCUekgU8OaFVxkwMbhjhWwvSu8etsvBPZCjw9NG4YqF7z7A8q5ck
	 ho2SjqyIIoBOQ==
Message-ID: <0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org>
Date: Tue, 1 Aug 2023 16:19:30 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Content-Language: en-US
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230725072338.20789-1-rogerq@kernel.org>
 <20230801131418.bhcjtflj3iu77mmc@skbuf>
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801131418.bhcjtflj3iu77mmc@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 01/08/2023 16:14, Vladimir Oltean wrote:
> On Tue, Jul 25, 2023 at 10:23:38AM +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
> 
> Also:
> 
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:6: warning: no previous prototype for function 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
>      ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> ^
> static
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:6: warning: no previous prototype for function 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
>      ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> ^
> static
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:699:33: error: redefinition of 'taprio'
>         struct tc_taprio_qopt_offload *taprio = type_data;
>                                        ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:697:33: note: previous definition is here
>         struct tc_taprio_qopt_offload *taprio = type_data;
>                                        ^
> 2 warnings and 1 error generated.
> make[7]: *** [../scripts/Makefile.build:243: drivers/net/ethernet/ti/am65-cpsw-qos.o] Error 1
> make[7]: *** Waiting for unfinished jobs....

I'm pretty sure there weren't any build errors for me.
Did you have and resolve conflicts when applying this patch?

-- 
cheers,
-roger

