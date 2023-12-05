Return-Path: <netdev+bounces-54118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6EC80608A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 22:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAFF1C20ED9
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CF66E592;
	Tue,  5 Dec 2023 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="hoYISi/N"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68670A5
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Ao/3T3oZaH/yfx45Od3ihF5vQDRGfrE7XkXzJKC+8yo=; b=hoYISi/NdobW40Y8VA8G1hyRuB
	EZ2/GYMalwGHpcVzXPkaqRo+d5yF313lat60NT7ZKPXZ6axWeebnDmsIvAKZSJ5Cm2woS4pioysAm
	8s2aDzsppVqAzVu5BVNfj2EkxIB+7owC45NLPR0OqJS5J8mPtk+L8HOCD87RIdwEBKLZLWlcB67AU
	ZG6U9fufZqD7hp0Jbt4awcLOyTF+H0vxbOj5uLEqyRXbB0AazU4uSoca/we1+2K8YnrJgZR0Tw3Kl
	LYQXQJNtJGpxekEuZ9wLtbZnr9pr3HG/xdDqybiPmEoA6BQshyRVG+YoF3iN6aN/ymGVapOi5I+U+
	Q5Qt+9/Q==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAcn3-000HZA-Ct; Tue, 05 Dec 2023 22:17:13 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rAcn2-000CSj-NN; Tue, 05 Dec 2023 22:17:12 +0100
Subject: Re: [PATCH net-next v3 1/3] net: sched: Move drop_reason to struct
 tc_skb_cb
To: Victor Nogueira <victor@mojatatu.com>, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: dcaratti@redhat.com, netdev@vger.kernel.org, kernel@mojatatu.com
References: <20231205205030.3119672-1-victor@mojatatu.com>
 <20231205205030.3119672-2-victor@mojatatu.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <33b611b1-e374-df7a-5cf8-e63970f02abc@iogearbox.net>
Date: Tue, 5 Dec 2023 22:17:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231205205030.3119672-2-victor@mojatatu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)

On 12/5/23 9:50 PM, Victor Nogueira wrote:
> Move drop_reason from struct tcf_result to skb cb - more specifically to
> struct tc_skb_cb. With that, we'll be able to also set the drop reason for
> the remaining qdiscs (aside from clsact) that do not have access to
> tcf_result when time comes to set the skb drop reason.
> 
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

