Return-Path: <netdev+bounces-35333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5567A8EAE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 23:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A805B208A8
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 21:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C86405D4;
	Wed, 20 Sep 2023 21:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDAA1A5B6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 21:47:41 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE36A3
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 14:47:40 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qj52n-0001jp-Jv; Wed, 20 Sep 2023 23:47:37 +0200
Date: Wed, 20 Sep 2023 23:47:37 +0200
From: Florian Westphal <fw@strlen.de>
To: Eugene Crosser <crosser@average.org>
Cc: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Yi-Hung Wei <yihung.wei@gmail.com>,
	Martin Bene <martin.bene@icomedias.com>
Subject: Re: conntrack: TCP CLOSE and TIME_WAIT are not counted towards
 per-zone limit, and can overflow global table
Message-ID: <20230920214737.GB25778@breakpoint.cc>
References: <8c7e44d2-e78f-4f8d-9016-2a4b8429e14d@average.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c7e44d2-e78f-4f8d-9016-2a4b8429e14d@average.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Eugene Crosser <crosser@average.org> wrote:
> we are running a virtualization platform, and assign different conntrack
> zones, with per-zone limits, to different users. The goal is to prevent
> situation when one user exhaust the whole conntrack table on the host,
> e.g. if the user is under some DDoS scenario.
> 
> We noticed that under some flooding scenarios, the number of entries in
> the zone assigned to the user goes way above the per-zone limit, and
> reaches the global host limit. In our test, almost all of those entries
> were in "CLOSE" state.
> 
> It looks like this function in net/filter/nf_conncount.c:71
> 
> static inline bool already_closed(const struct nf_conn *conn)
> {
> 	if (nf_ct_protonum(conn) == IPPROTO_TCP)
> 		return conn->proto.tcp.state == TCP_CONNTRACK_TIME_WAIT ||
> 		       conn->proto.tcp.state == TCP_CONNTRACK_CLOSE;
> 	else
> 		return false;
> }
> 
> is used to explicitly exclude such entries from counting.
> 
> As I understand, this creates a situation when an attacker can inflict a
> DoS situation on the host, by opening _and immediately closing_ a large
> number of TCP connections. That is to say, per-zone limits, as currently
> implemented, _do not_ allow to prevent overflow of the host-wide
> conntrack table.
> 
> What was the reason to exclude such entries from counting?

I'd wager only intent was to limit *active* connections, not conntrack
entries.

This code originates from a time when zones did not exist, hence
conntrack upperlimit was sufficient, no partitioning needed.

> Should this exception be removed, and _all_ entries in the zone counted
> towards the limit?

I suppose so.

