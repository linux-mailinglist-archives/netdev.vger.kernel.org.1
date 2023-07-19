Return-Path: <netdev+bounces-19095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC580759A78
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4CA1C21098
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 16:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441AD3D3A9;
	Wed, 19 Jul 2023 16:08:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390C411C93
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 16:08:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C214D10F3
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 09:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689782911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7/82hxOWYMwQd1IMPDVxeYFXOdlufmLKO6oLmwWprQo=;
	b=TNK1z/38++mn6LjfsO9JC1M3kybkPfjF0SVpYa4kR5w/GIYsCptw4JADHtSCbauPFtMIvh
	KdpUp/bixQ0zqfM1UQvlafUKTkRmDKfQah4eeahxkdELzXt/fcM7kycU2jjJXxjQGurkca
	iEWeis5B+aJxyk469zqVzl6uuz/ekGk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-C7mMsEmuOSqcEG2lJRk0QQ-1; Wed, 19 Jul 2023 12:08:28 -0400
X-MC-Unique: C7mMsEmuOSqcEG2lJRk0QQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B91EE186E128;
	Wed, 19 Jul 2023 16:08:12 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.58])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FBAB1121314;
	Wed, 19 Jul 2023 16:08:11 +0000 (UTC)
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
Subject: Re: [PATCH net-next 3/3] openvswitch: set IPS_CONFIRMED in tmpl
 status only when commit is set in conntrack
References: <cover.1689541664.git.lucien.xin@gmail.com>
	<cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
Date: Wed, 19 Jul 2023 12:08:10 -0400
In-Reply-To: <cf477f4a26579e752465a5951c1d28ba109346e3.1689541664.git.lucien.xin@gmail.com>
	(Xin Long's message of "Sun, 16 Jul 2023 17:09:19 -0400")
Message-ID: <f7tzg3r6g0l.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Xin Long <lucien.xin@gmail.com> writes:

> By not setting IPS_CONFIRMED in tmpl that allows the exp not to be removed
> from the hashtable when lookup, we can simplify the exp processing code a
> lot in openvswitch conntrack.
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


