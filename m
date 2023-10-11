Return-Path: <netdev+bounces-39999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9417C55A8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58EF4282217
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 13:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11261F956;
	Wed, 11 Oct 2023 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUReXCfO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADD2CA6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 13:41:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C21D90
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697031679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+KucV+wEcu2y8oFyKIRnTqpLdCzMuJipkHE1kZ1uuE=;
	b=MUReXCfOCxCk/LMp7dpR3QDm6H+s2NePt6div1L2XITIU8onYtnRQXDAITfJagbRfhhEJC
	ky8htg7qWUXoesrcleFSLnBfgNa20RvCOFoQKfGM3DPxNIYpIULvjinYyz6vnZcekxODOe
	g32G0544ivTLxp3iqj687urEfo42iok=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-558-poPM7PFXNouZSzxpmcbA_Q-1; Wed, 11 Oct 2023 09:41:16 -0400
X-MC-Unique: poPM7PFXNouZSzxpmcbA_Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7935185A795;
	Wed, 11 Oct 2023 13:41:15 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.34.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 58AED158;
	Wed, 11 Oct 2023 13:41:15 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org,  Pravin B
 Shelar <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Adrian
 Moreno <amorenoz@redhat.com>,  Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net 4/4] selftests: openvswitch: Fix the ct_tuple for v4
References: <20231006151258.983906-1-aconole@redhat.com>
	<20231006151258.983906-5-aconole@redhat.com>
	<417e00407c64ccc39fce35bdb41b6765363d9fb1.camel@redhat.com>
Date: Wed, 11 Oct 2023 09:41:09 -0400
In-Reply-To: <417e00407c64ccc39fce35bdb41b6765363d9fb1.camel@redhat.com>
	(Paolo Abeni's message of "Tue, 10 Oct 2023 12:31:05 +0200")
Message-ID: <f7t5y3dcm4q.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Paolo Abeni <pabeni@redhat.com> writes:

> On Fri, 2023-10-06 at 11:12 -0400, Aaron Conole wrote:
>> Caught during code review.
>
> Since there are a few other small things, please additionally expand
> this changelog briefly describing the addressed problem and it's
> consequences.

ACK.  will fix in v2.  Thanks Paolo!

> Thanks,
>
> Paolo


