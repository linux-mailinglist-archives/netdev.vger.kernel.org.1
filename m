Return-Path: <netdev+bounces-31642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486E478F349
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 21:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02CE828168E
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DA519BB8;
	Thu, 31 Aug 2023 19:26:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47368F57
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 19:26:37 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC289E66
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=V+shiyl3L6Vu56ksNxktVVXQIfHGFAjPj3cWWl6lKN0=; b=lYyidfXt2fJP6JEM1vVcWxOt1o
	2aUh8+Xlgh65qbwkJkx8WjuaPB6sZRw4W/lhKusOVrEf3E3YruycjLIU2bEsN+vD5B+k292XEY6VZ
	8iQ8jwZ4YldeAAY91TZNHJ2KRm9nrwBYhV3QJQb4sc3YtT56g6dRxrNrGShrB3f5DCn24FQWqqgRY
	1VzkPwXaIeEs7l8gCIwZH93lVoIt26EdtGHOl5ZyQcl1z88/OiRs/cSNCqF2NahWVrvMeufSQnfvD
	Fa+QPmMk55W9FYeCxwHWFaOpD3f0JdH0O3mLHQs1cTEA4eJF5oaRiGQ7ScQ1fpIlvxqr/guKXfJ34
	Uq092wEg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbnJI-000Pnm-CM; Thu, 31 Aug 2023 21:26:32 +0200
Received: from [178.197.249.54] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qbnJI-000WWQ-GP; Thu, 31 Aug 2023 21:26:32 +0200
Subject: Re: Stable Backport: net: Avoid address overwrite in kernel_connect
To: Jordan Rife <jrife@google.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org
References: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7702c74e-482f-cd89-1d12-fb6869bd53f2@iogearbox.net>
Date: Thu, 31 Aug 2023 21:26:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADKFtnSPTQGLxfpn38cfwTPk=JY-=Ywne2DFoRkq03m-eKo17Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27017/Thu Aug 31 09:40:48 2023)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

[ Adding Greg to Cc ]

On 8/31/23 8:47 PM, Jordan Rife wrote:
> Upstream Commit ID: 0bdf399342c5acbd817c9098b6c7ed21f1974312
> Patchwork Link:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=0bdf399342c5
> Requested Kernel Versions: 4.19, 5.4, 5.10, 5.15, 6.1, 6.4, 6.5
> 
> This patch addresses an incompatibility between eBPF connect4/connect6
> programs and kernel space clients such as NFS. At present, the issue
> this patch fixes is a blocker for users that want to combine NFS with
> Cilium. The fix has been applied upstream but the same bug exists with
> older kernels.
> 
> -Jordan
> 


