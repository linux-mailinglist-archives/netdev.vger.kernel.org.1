Return-Path: <netdev+bounces-13959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0BE73E312
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD6E31C20D4F
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 15:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF1BA45;
	Mon, 26 Jun 2023 15:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87164BE57
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 15:19:17 +0000 (UTC)
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEE1818D;
	Mon, 26 Jun 2023 08:19:16 -0700 (PDT)
Date: Mon, 26 Jun 2023 17:19:13 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Patrick McHardy <kaber@trash.net>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"coreteam@netfilter.org" <coreteam@netfilter.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	Simon Horman <simon.horman@corigine.com>
Subject: Re: [PATCH net] netfilter: nf_conntrack_sip: fix the
 ct_sip_parse_numerical_param() return value.
Message-ID: <ZJmscRFjubRPUgiw@calendula>
References: <20230623112247.1468836-1-Ilia.Gavrilov@infotecs.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623112247.1468836-1-Ilia.Gavrilov@infotecs.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 11:23:46AM +0000, Gavrilov Ilia wrote:
> From: "Ilia.Gavrilov" <Ilia.Gavrilov@infotecs.ru>
> 
> ct_sip_parse_numerical_param() returns only 0 or 1 now.
> But process_register_request() and process_register_response() imply
> checking for a negative value if parsing of a numerical header parameter
> failed.
> The invocation in nf_nat_sip() looks correct:
>  	if (ct_sip_parse_numerical_param(...) > 0 &&
>  	    ...) { ... }
> 
> Make the return value of the function ct_sip_parse_numerical_param()
> a tristate to fix all the cases
> a) return 1 if value is found; *val is set
> b) return 0 if value is not found; *val is unchanged
> c) return -1 on error; *val is undefined

Applied to nf.git

