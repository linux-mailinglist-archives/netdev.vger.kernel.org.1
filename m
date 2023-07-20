Return-Path: <netdev+bounces-19422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB275A998
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D1281D86
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE29361;
	Thu, 20 Jul 2023 08:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26D5156D7
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 08:50:58 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C22115
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 01:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689843056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NZM4iXPMRlIzB3VEwUhKMAJFTkLOTWrNj+AuF3fihYY=;
	b=QMsQIhO3X6s/KGN4sFPQnhXuvIlhxGlLNiME+d0MbMgo7ETFlcQpQy9KfSHZ1VoiJMf0P9
	UZDYLRQPTaCa3Dqhjg+p/gMy/Mh7MrGBSojjCBjK2Ex9Ac1x8Khe+3sPRt+Hqi4Ls3OC6G
	sj+KS93jYfXtkpiycQO2rUVdgIjY+vo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-489-62VV_1G9PPOsYu3rrhF2nw-1; Thu, 20 Jul 2023 04:50:50 -0400
X-MC-Unique: 62VV_1G9PPOsYu3rrhF2nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB2258F1842;
	Thu, 20 Jul 2023 08:50:49 +0000 (UTC)
Received: from griffin (unknown [10.45.226.9])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1AE192166B25;
	Thu, 20 Jul 2023 08:50:48 +0000 (UTC)
Date: Thu, 20 Jul 2023 10:50:47 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH net] vxlan: calculate correct header length for GPE
Message-ID: <20230720105047.18dcc5e2@griffin>
In-Reply-To: <CAHsH6GvCEusX1Uuy7tk7Do-V0xDQRB+Q45UCpCjOeUV0=GFfzQ@mail.gmail.com>
References: <0699747bc9bd7aaf7dc87efd33aa6b95de7d793e.1689677201.git.jbenc@redhat.com>
	<CAHsH6GvCEusX1Uuy7tk7Do-V0xDQRB+Q45UCpCjOeUV0=GFfzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, 20 Jul 2023 11:43:05 +0300, Eyal Birger wrote:
> From looking at the geneve code it appears geneve would also have this
> problem when inner_proto_inherit=true as GENEVE_IPV4_HLEN includes
> ETH_HLEN.
> 
> Would you consider adding a fix to it as part of a series?

I can look into that. I wouldn't call it a series, though :-) Let's do
both separately.

 Jiri


