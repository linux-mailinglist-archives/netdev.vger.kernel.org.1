Return-Path: <netdev+bounces-105424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB69111AC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EF31C21260
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA4AB657;
	Thu, 20 Jun 2024 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHvfGAi6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022FE364AE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910021; cv=none; b=EhbKeXLD2PeOErTos8TjLF818jvhx+L5MIJdf55j5duN/yTtx39QIoifQOX7gsD5pCSVKeet5b+5B321Ze36SORAUBMjLpVIsksrH6loAGvSt3XgqQEl7MehCxQAfdZPJxArME+NZx8wnVS6YBovn0mTScqXCFe4yaLODx8Y9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910021; c=relaxed/simple;
	bh=Thu837Y+SNjoczEYg0AWjk8mET3ACjuGVHtA3Fr4pkk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GvafN3eDssG9xCnKtf124Pho8zq/Ny+Tm5QLA7lOcfk+cAkLSeU1sk6vD4re+oyDn3Xq57xC1PF/Io7tV1+I+1NaovY0YcYETngD4douN4QaLahQIrzwo2nLeYQp/zeD3AyCj3CDxTBsVsEnyhml3qLNe65IztAzkMLOMF/2S5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHvfGAi6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718910011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Thu837Y+SNjoczEYg0AWjk8mET3ACjuGVHtA3Fr4pkk=;
	b=QHvfGAi6vl/IyjMAwfeJowZp0sIgqK3SWG7x4JhvRqPNQyrw+p0+SL6Ue91KX5X8gxl0ae
	ebigVQ9htU94EEmAZfw5r9xild8hH7VWcngzIaNi1VAHIKSp9dRiKMHnyuIs+XZFc6f7zY
	VY52D6sWH42fGqt19Qy4niEHIqq5zqU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-5vrccJz-Oaer4YaWgsx7tQ-1; Thu,
 20 Jun 2024 15:00:08 -0400
X-MC-Unique: 5vrccJz-Oaer4YaWgsx7tQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8D3019560BE;
	Thu, 20 Jun 2024 19:00:06 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.9.58])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20B4B1956052;
	Thu, 20 Jun 2024 19:00:03 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>,  dev@openvswitch.org,  Marcelo
 Ricardo Leitner <marcelo.leitner@gmail.com>,  Florian Westphal
 <fw@strlen.de>,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  kuba@kernel.org,  Paolo Abeni <pabeni@redhat.com>,
  davem@davemloft.net
Subject: Re: [ovs-dev] [PATCH net] openvswitch: get related ct labels from
 its master if it is not confirmed
In-Reply-To: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
	(Xin Long's message of "Wed, 19 Jun 2024 18:08:56 -0400")
References: <48a6cd8c4f9c6bf6f0314d992d61c65b43cb3983.1718834936.git.lucien.xin@gmail.com>
Date: Thu, 20 Jun 2024 15:00:02 -0400
Message-ID: <f7ted8rignh.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Xin Long <lucien.xin@gmail.com> writes:

> Ilya found a failure in running check-kernel tests with at_groups=144
> (144: conntrack - FTP SNAT orig tuple) in OVS repo. After his further
> investigation, the root cause is that the labels sent to userspace
> for related ct are incorrect.
>
> The labels for unconfirmed related ct should use its master's labels.
> However, the changes made in commit 8c8b73320805 ("openvswitch: set
> IPS_CONFIRMED in tmpl status only when commit is set in conntrack")
> led to getting labels from this related ct.
>
> So fix it in ovs_ct_get_labels() by changing to copy labels from its
> master ct if it is a unconfirmed related ct. Note that there is no
> fix needed for ct->mark, as it was already copied from its master
> ct for related ct in init_conntrack().
>
> Fixes: 8c8b73320805 ("openvswitch: set IPS_CONFIRMED in tmpl status
> only when commit is set in conntrack")
> Reported-by: Ilya Maximets <i.maximets@ovn.org>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


