Return-Path: <netdev+bounces-90991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D568B8B0D72
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133A61C24237
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA21615EFCD;
	Wed, 24 Apr 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5hZ9wdM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ADC15ECFE
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970748; cv=none; b=K9Ldimgftsk38h7wgXIeAOCki4guuvm9hg3QNxFbvI78i0SzjhlKZcYKgM1KHPjUPNpBgdoFi+FyFQUT7lCM+1XpytNWZI/O7LP6M8TXxAUZv8S1R00m7MOTGL3KtcwIp28fJdU401nnwuqpILSoa/kp77m+5n6uzrxnCtIKWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970748; c=relaxed/simple;
	bh=G7piFHKChIDsrl+KfaWGN3algGuVHAHGdrOPI0U52NY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HG7nW1dpD3iEcZqq4HRmJ8pNeTbi99U9o26dnb8gUELYg2N0CVuvdqAx2OHUxiVyiFw2DYcBUZkCHh58pLwoCWLOyBr5AcKE2SaV9rtaGxm8Xlj2OgDUTBXy455knczmbsN5vEaUoqNKYhfYA4lzTHjNefRof9ejpwYwasHkL0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5hZ9wdM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713970746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G7piFHKChIDsrl+KfaWGN3algGuVHAHGdrOPI0U52NY=;
	b=C5hZ9wdM1KtdMpgSDLYs2lp+SiRuiBlUe8MiHm8spcmclGj0mlFQQuaYEhY3SgVnJoDvEx
	iClvSwsKTOAVFPtHUaxM2BMhfXQ1fq11QQ53vd3eIZj8sJIbem80DqDj3CruDPErtu/Q/z
	nalaiZo8p+Rg4NGd/zhSSK2yM+Q/lNM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-ef7SASU5Pei9YNBwwIM6Pg-1; Wed, 24 Apr 2024 10:59:01 -0400
X-MC-Unique: ef7SASU5Pei9YNBwwIM6Pg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75DEE80021A;
	Wed, 24 Apr 2024 14:59:00 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16F0AC01595;
	Wed, 24 Apr 2024 14:59:00 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: pshelar@ovn.org,  edumazet@google.com,  dev@openvswitch.org,
  netdev@vger.kernel.org,  imv4bel@gmail.com,  kuba@kernel.org,
  pabeni@redhat.com,  davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH] net: openvswitch: Fix Use-After-Free in
 ovs_ct_exit
In-Reply-To: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX> (Hyunwoo Kim's
	message of "Mon, 22 Apr 2024 05:37:17 -0400")
References: <ZiYvzQN/Ry5oeFQW@v4bel-B760M-AORUS-ELITE-AX>
Date: Wed, 24 Apr 2024 10:58:59 -0400
Message-ID: <f7tfrvabydo.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hyunwoo Kim <v4bel@theori.io> writes:

> Since kfree_rcu, which is called in the hlist_for_each_entry_rcu traversal
> of ovs_ct_limit_exit, is not part of the RCU read critical section, it
> is possible that the RCU grace period will pass during the traversal and
> the key will be free.
>
> To prevent this, it should be changed to hlist_for_each_entry_safe.
>
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


