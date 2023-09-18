Return-Path: <netdev+bounces-34506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 283F27A46DA
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B34281CB9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D024E1C69A;
	Mon, 18 Sep 2023 10:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94AE1C697
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:23:10 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F77121;
	Mon, 18 Sep 2023 03:22:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qiBOj-0005r4-FR; Mon, 18 Sep 2023 12:22:33 +0200
Date: Mon, 18 Sep 2023 12:22:33 +0200
From: Florian Westphal <fw@strlen.de>
To: George Guo <guodongtai@kylinos.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] tcp: enhancing timestamps random algo to address
 issues arising from NAT mapping
Message-ID: <20230918102233.GA9759@breakpoint.cc>
References: <20230918014752.1791518-1-guodongtai@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918014752.1791518-1-guodongtai@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

George Guo <guodongtai@kylinos.cn> wrote:
> Tsval=tsoffset+local_clock, here tsoffset is randomized with saddr and daddr parameters in func
> secure_tcp_ts_off. Most of time it is OK except for NAT mapping to the same port and daddr.
> Consider the following scenario:
> 	ns1:                ns2:
> 	+-----------+        +-----------+
> 	|           |        |           |
> 	|           |        |           |
> 	|           |        |           |
> 	| veth1     |        | vethb     |
> 	|192.168.1.1|        |192.168.1.2|
> 	+----+------+        +-----+-----+
> 	     |                     |
> 	     |                     |
> 	     | br0:192.168.1.254   |
> 	     +----------+----------+
> 	 veth0          |     vetha
> 	 192.168.1.3    |    192.168.1.4
> 	                |
> 	               nat(192.168.1.x -->172.30.60.199)
> 	                |
> 	                V
> 	               eth0
> 	         172.30.60.199
> 	               |
> 	               |
> 	               +----> ... ...    ---->server: 172.30.60.191
> 
> Let's say ns1 (192.168.1.1) generates a timestamp ts1, and ns2 (192.168.1.2) generates a timestamp
> ts2, with ts1 > ts2.
> 
> If ns1 initiates a connection to a server, and then the server actively closes the connection,
> entering the TIME_WAIT state, and ns2 attempts to connect to the server while port reuse is in
> progress, due to the presence of NAT, the server sees both connections as originating from the
> same IP address (e.g., 172.30.60.199) and port. However, since ts2 is smaller than ts1, the server
> will respond with the acknowledgment (ACK) for the fourth handshake.
> 
>        SERVER                                               	CLIENT
> 
>    1.  ESTABLISHED                                          	ESTABLISHED
> 
>        (Close)
>    2.  FIN-WAIT-1  --> <SEQ=100><ACK=300><TSval=20><CTL=FIN,ACK>  --> CLOSE-WAIT
> 
>    3.  FIN-WAIT-2  <-- <SEQ=300><ACK=101><TSval=40><CTL=ACK>      <-- CLOSE-WAIT
> 
>                                                             (Close)
>    4.  TIME-WAIT   <-- <SEQ=300><ACK=101><TSval=41><CTL=FIN,ACK>  <-- LAST-ACK
> 
>    5.  TIME-WAIT   --> <SEQ=101><ACK=301><TSval=25><CTL=ACK>      --> CLOSED
> 
>   - - - - - - - - - - - - - port reused - - - - - - - - - - - - - - -
> 
>    5.1. TIME-WAIT   <-- <SEQ=255><TSval=30><CTL=SYN>             <-- SYN-SENT
> 
>    5.2. TIME-WAIT   --> <SEQ=101><ACK=301><TSval=35><CTL=ACK>    --> SYN-SENT
> 
>    5.3. CLOSED      <-- <SEQ=301><CTL=RST>             		 <-- SYN-SENT
> 
>    6.  SYN-RECV    <-- <SEQ=255><TSval=34><CTL=SYN>              <-- SYN-SENT
> 
>    7.  SYN-RECV    --> <SEQ=400><ACK=301><TSval=40><CTL=SYN,ACK> --> ESTABLISHED
> 
>    1.  ESTABLISH   <-- <SEQ=301><ACK=401><TSval=55><CTL=ACK>     <-- ESTABLISHED
> 
> This enhancement uses sport and daddr rather than saddr and daddr, which keep the timestamp
> monotonically increasing in the situation described above. Then the port reuse is like this:

We used to have per-connection timestamps, i.e. hash used to include
port numbers as well.

Unfortunately there were problem reports, too many devices expect
monotonically increasing ts from the same address.

See 28ee1b746f49 ("secure_seq: downgrade to per-host timestamp offsets")

So, I don't think we can safely substitute saddr with sport.

