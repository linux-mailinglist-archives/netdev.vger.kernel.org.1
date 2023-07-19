Return-Path: <netdev+bounces-19094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38904759A72
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E680C2810B6
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DE3D3A7;
	Wed, 19 Jul 2023 16:07:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038E11C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:07:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB60119
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689782872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vlXy4E8mRNLkk5fezYJB6K3OcT7F21mNm0gl9Jn0PB0=;
	b=QeFrm4rBjulgp3QCQhRNX2ORwCvgcl0o8vR0z8oXg2p0TK+BuEk3svCDu9w0DSpqpFeV6O
	Ars/sX8uyaBVNTCzwIcyej25HOamPGNmHFNwSPLDbfSNkD0XQWjzHwla6V8ABbVkYQuxct
	rYCjhCpi2DGDswajrvmqNYYKEMcLFLA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-gDTRo-WWOpeE_gdFy5yWWg-1; Wed, 19 Jul 2023 12:07:48 -0400
X-MC-Unique: gDTRo-WWOpeE_gdFy5yWWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9BD856F67;
	Wed, 19 Jul 2023 16:07:48 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A94E40C206F;
	Wed, 19 Jul 2023 16:07:47 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,
  davem@davemloft.net,  kuba@kernel.org,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Pravin B Shelar
 <pshelar@ovn.org>,  Jamal Hadi Salim <jhs@mojatatu.com>,  Cong Wang
 <xiyou.wangcong@gmail.com>,  Jiri Pirko <jiri@resnulli.us>,  Pablo Neira
 Ayuso <pablo@netfilter.org>,  Florian Westphal <fw@strlen.de>,  Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>,  Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 2/3] net: sched: set IPS_CONFIRMED in tmpl
 status only when commit is set in act_ct
References: <cover.1689541664.git.lucien.xin@gmail.com>
	<4ffd82b3acc34ebd09855a26eb148fcd59fa872c.1689541664.git.lucien.xin@gmail.com>
Date: Wed, 19 Jul 2023 12:07:46 -0400
In-Reply-To: <4ffd82b3acc34ebd09855a26eb148fcd59fa872c.1689541664.git.lucien.xin@gmail.com>
	(Xin Long's message of "Sun, 16 Jul 2023 17:09:18 -0400")
Message-ID: <f7t4jlz7ulp.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> writes:

> With the following flows, the packets will be dropped if OVS TC offload is
> enabled.
>
>   'ip,ct_state=-trk,in_port=1 actions=ct(zone=1)'
>   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=1)'
>   'ip,ct_state=+trk+new+rel,in_port=1 actions=ct(commit,zone=2),normal'
>
> In the 1st flow, it finds the exp from the hashtable and removes it then
> creates the ct with this exp in act_ct. However, in the 2nd flow it goes
> to the OVS upcall at the 1st time. When the skb comes back from userspace,
> it has to create the ct again without exp(the exp was removed last time).
> With no 'rel' set in the ct, the 3rd flow can never get matched.
>
> In OVS conntrack, it works around it by adding its own exp lookup function
> ovs_ct_expect_find() where it doesn't remove the exp. Instead of creating
> a real ct, it only updates its keys with the exp and its master info. So
> when the skb comes back, the exp is still in the hashtable.
>
> However, we can't do this trick in act_ct, as tc flower match is using a
> real ct, and passing the exp and its master info to flower parsing via
> tc_skb_cb is also not possible (tc_skb_cb size is not big enough).
>
> The simple and clear fix is to not remove the exp at the 1st flow, namely,
> not set IPS_CONFIRMED in tmpl when commit is not set in act_ct.
>
> Reported-by: Shuang Li <shuali@redhat.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


