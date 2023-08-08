Return-Path: <netdev+bounces-25430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 951B5773F1B
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 18:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E16B281677
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F88C14A97;
	Tue,  8 Aug 2023 16:40:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5559E1B7F0
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 16:40:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75C5272
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691512816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bl1NQzAqikA85rFjZZWD7wj3owtQnW+JDUMEKTz758w=;
	b=IDm1hJXVF7kpQvLXZwH2aN+eByESp51jqfs1oak1PCrbbIJ5gVH19wyTh0UGSlbXvbkyno
	CctlOBLVc4kHfvwNqAWwqMMb0+6OV41Z5e8qTkP/GVP1hu+MupMB30GSweYm/PWuuQJa5Y
	e4PZE24vSxFLWMY23RnVkR+AVQ7KQqU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-QDQeZv81Pce_-rYSglw6ww-1; Tue, 08 Aug 2023 10:37:20 -0400
X-MC-Unique: QDQeZv81Pce_-rYSglw6ww-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D259E1C060CA;
	Tue,  8 Aug 2023 14:37:19 +0000 (UTC)
Received: from RHTPC1VM0NT (unknown [10.22.8.251])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E289140E962;
	Tue,  8 Aug 2023 14:37:19 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  i.maximets@ovn.org,  eric@garver.life,
  dev@openvswitch.org
Subject: Re: [net-next v3 2/7] net: openvswitch: add action error drop reason
References: <20230807164551.553365-1-amorenoz@redhat.com>
	<20230807164551.553365-3-amorenoz@redhat.com>
Date: Tue, 08 Aug 2023 10:37:19 -0400
In-Reply-To: <20230807164551.553365-3-amorenoz@redhat.com> (Adrian Moreno's
	message of "Mon, 7 Aug 2023 18:45:43 +0200")
Message-ID: <f7tfs4t4n34.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Adrian Moreno <amorenoz@redhat.com> writes:

> Add a drop reason for packets that are dropped because an action
> returns a non-zero error code.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


