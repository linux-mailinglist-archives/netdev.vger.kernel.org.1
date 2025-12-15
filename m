Return-Path: <netdev+bounces-244750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2EBCBDF82
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE9C300D168
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52472C21FC;
	Mon, 15 Dec 2025 13:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aSGCbnsf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66E2C234C
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765804459; cv=none; b=dG7VGLMnIwju4FAxeQqv97e7XN1YMPfujmMhIOMOjAJXM2ChngzpT31B7VOSbSJjHrTT1Jt7zEVdvFm/2aDH+kC7veJwi5CTlL2U3mEKjd+tum48SrWEpYSwbK1h0s+c9WNZ/vxqI5HxLdYlhmk/PoRlpSfM3FWCePVuv/Pr6Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765804459; c=relaxed/simple;
	bh=4yBilBIOFB+XSPspX7KZlrIC4ZqVUB3Ii3u4NYeLtCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lu9S4RSe2q026q/hsX9QwevYcq0GjxJhT00RxsAsvFQtVEp/FqytPvF7Ca7QXkQQ+wqFZUg44t+ey8RAWhiJFIVj9TS2P+ZoJHD4+8xR6yrlTEE4RyrR+aRAyOjy0/R5/S+6eDhFa6lypY42f/Ntw7vNEkxijrjy8AA9KWM1tWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aSGCbnsf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765804456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yBilBIOFB+XSPspX7KZlrIC4ZqVUB3Ii3u4NYeLtCs=;
	b=aSGCbnsfAnqSpjsGLye+EDHpPfKHUodqTP1SoLksJ+ULw5hvQk5jNqoFAlfxivEvNz/dQu
	vZ6A7UbmitZdtrg6yaw9UFJrigFYSPWmDijJiKOACUvmM10XiABVHC/Mz4uXqzIkjUBSDh
	sXnC9rltEHVGX+VxKYRXCG0El5kKwy0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-39YAVIdXObmGb2zRfw7BGg-1; Mon,
 15 Dec 2025 08:14:13 -0500
X-MC-Unique: 39YAVIdXObmGb2zRfw7BGg-1
X-Mimecast-MFC-AGG-ID: 39YAVIdXObmGb2zRfw7BGg_1765804452
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B1ED6195605B;
	Mon, 15 Dec 2025 13:14:11 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.86])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F25FD1955F21;
	Mon, 15 Dec 2025 13:14:08 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>,  Ilya Maximets
 <i.maximets@ovn.org>,  Alexei Starovoitov <ast@kernel.org>,  Jesse Gross
 <jesse@nicira.com>,  Adrian Moreno <amorenoz@redhat.com>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  netdev@vger.kernel.org,  dev@openvswitch.org
Subject: Re: [PATCH v2] net: openvswitch: Avoid needlessly taking the RTNL
 on vport destroy
In-Reply-To: <20251211115006.228876-1-toke@redhat.com> ("Toke
	=?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen=22's?= message of "Thu, 11 Dec 2025
 12:50:05 +0100")
References: <20251211115006.228876-1-toke@redhat.com>
Date: Mon, 15 Dec 2025 08:14:07 -0500
Message-ID: <f7t5xa7anvk.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> The openvswitch teardown code will immediately call
> ovs_netdev_detach_dev() in response to a NETDEV_UNREGISTER notification.
> It will then start the dp_notify_work workqueue, which will later end up
> calling the vport destroy() callback. This callback takes the RTNL to do
> another ovs_netdev_detach_port(), which in this case is unnecessary.
> This causes extra pressure on the RTNL, in some cases leading to
> "unregister_netdevice: waiting for XX to become free" warnings on
> teardown.
>
> We can straight-forwardly avoid the extra RTNL lock acquisition by
> checking the device flags before taking the lock, and skip the locking
> altogether if the IFF_OVS_DATAPATH flag has already been unset.
>
> Fixes: b07c26511e94 ("openvswitch: fix vport-netdev unregister")
> Tested-by: Adrian Moreno <amorenoz@redhat.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---

LGTM,

Acked-by: Aaron Conole <aconole@redhat.com>


