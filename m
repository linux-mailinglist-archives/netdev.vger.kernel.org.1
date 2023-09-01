Return-Path: <netdev+bounces-31693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA7A78F9BE
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 10:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77B272817B8
	for <lists+netdev@lfdr.de>; Fri,  1 Sep 2023 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639078C10;
	Fri,  1 Sep 2023 08:15:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574976ABC
	for <netdev@vger.kernel.org>; Fri,  1 Sep 2023 08:15:17 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6048F;
	Fri,  1 Sep 2023 01:15:16 -0700 (PDT)
Received: from [78.30.34.192] (port=39840 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1qbzJ5-00AEiB-H4; Fri, 01 Sep 2023 10:15:10 +0200
Date: Fri, 1 Sep 2023 10:15:06 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: joao@overdrivepizza.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	rkannoth@marvell.com, wojciech.drewek@intel.com,
	steen.hegenlund@microhip.com, keescook@chromium.org,
	Joao Moreira <joao.moreira@intel.com>
Subject: Re: [PATCH 0/2] Prevent potential write out of bounds
Message-ID: <ZPGdihJLKXOj7rDI@calendula>
References: <20230901010437.126631-1-joao@overdrivepizza.com>
 <20230831182800.25e5d4d9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831182800.25e5d4d9@kernel.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 06:28:00PM -0700, Jakub Kicinski wrote:
> On Thu, 31 Aug 2023 18:04:35 -0700 joao@overdrivepizza.com wrote:
> > The function flow_rule_alloc in net/core/flow_offload.c [2] gets an
> > unsigned int num_actions (line 10) and later traverses the actions in
> > the rule (line 24) setting hw.stats to FLOW_ACTION_HW_STATS_DONT_CARE.
> > 
> > Within the same file, the loop in the line 24 compares a signed int
> > (i) to an unsigned int (num_actions), and then uses i as an array
> > index. If an integer overflow happens, then the array within the loop
> > is wrongly indexed, causing a write out of bounds.
> > 
> > After checking with maintainers, it seems that the front-end caps the
> > maximum value of num_action, thus it is not possible to reach the given
> > write out of bounds, yet, still, to prevent disasters it is better to
> > fix the signedness here.
> 
> How did you find this? The commit messages should include info
> about how the issue was discovered.

This is net-next material IMO, none of the existing interfaces uses
such a large number of actions for this to be an issue.

