Return-Path: <netdev+bounces-12791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37CC738F14
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 20:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A4728164D
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 18:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECE918C3E;
	Wed, 21 Jun 2023 18:47:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA4D2595;
	Wed, 21 Jun 2023 18:47:54 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7079B;
	Wed, 21 Jun 2023 11:47:52 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qC2ri-0001Xx-27; Wed, 21 Jun 2023 20:47:38 +0200
Date: Wed, 21 Jun 2023 20:47:38 +0200
From: Florian Westphal <fw@strlen.de>
To: Florent Revest <revest@chromium.org>
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	lirongqing@baidu.com, daniel@iogearbox.net, ast@kernel.org,
	kpsingh@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses
 after free
Message-ID: <20230621184738.GG24035@breakpoint.cc>
References: <20230615152918.3484699-1-revest@chromium.org>
 <ZJFIy+oJS+vTGJer@calendula>
 <CABRcYmJjv-JoadtzZwU5A+SZwbmbgnzWb27UNZ-UC+9r+JnVxg@mail.gmail.com>
 <20230621111454.GB24035@breakpoint.cc>
 <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABRcYmKeo6A+3dmZd9bRp8W3tO9M5cHDpQ13b8aeMkhYr4L64Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Florent Revest <revest@chromium.org> wrote:
> > in this case an initcall is failing and I think panic is preferrable
> > to a kernel that behaves like NF_CONNTRACK_FTP=n.
> 
> In that case, it seems like what you'd want is
> nf_conntrack_standalone_init() to BUG() instead of returning an error
> then ? (so you'd never get to NF_CONNTRACK_FTP or any other if
> nf_conntrack failed to initialize) If this is the prefered behavior,
> then sure, why not.
> 
> > AFAICS this problem is specific to NF_CONNTRACK_FTP=y
> > (or any other helper module, for that matter).
> 
> Even with NF_CONNTRACK_FTP=m, the initialization failure in
> nf_conntrack_standalone_init() still happens. Therefore, the helper
> hashtable gets freed and when the nf_conntrack_ftp.ko module gets
> insmod-ed, it calls nf_conntrack_helpers_register() and this still
> causes a use-after-free.

Can you send a v2 with a slightly reworded changelog?

It should mention that one needs NF_CONNTRACK=y, so that when
the failure happens during the initcall (as oposed to module insertion),
nf_conntrack_helpers_register() can fail cleanly without followup splat?

Thanks.

