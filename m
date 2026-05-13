Return-Path: <netdev+bounces-287564-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNmrDIJpBGpVIAIAu9opvQ
	(envelope-from <netdev+bounces-287564-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:07:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7776E532C2E
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E7FE3129662
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB64385D77;
	Wed, 13 May 2026 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXaLuH0d"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D93FE641
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673740; cv=none; b=t39z0Z118RSXjRA8W7n+Yyrq2uJHZhXYA5bzq4BdIk+Xc5o9PlMPxLm+TL7niKGAqBgDDYo5y0eep42n+MuMHIlC17Qd96qjePmZdalBV7krPVg5sFCUxHhGTmEtGDlTjVrHv0CUqyqtlmOuZo/MgbzXEBCe0O5FSAeAcG0aMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673740; c=relaxed/simple;
	bh=ldKVJmG40KXFJimYWc1fK+rVyU9zld7I48l94jeR2hA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZRoQTXip9DndxC9lBqHfx2/H2VmCedxwDHhCqOiI+4tH34L3toeFT3Y+OEbXrJa53V3oJGdIZRC2ME2lgwTA5aaB14KS3JWExycTRHGsmRctCJJaum4ioHqBTMU5IlBZAs7ORYh6pvg1iHMHVbMttc48x03oXXFFikzAbDVvb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXaLuH0d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778673738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k3nGypYil5YIom5WdMeaxdpuq3CUBk2aFDJabzT/4uc=;
	b=LXaLuH0d/9B0u/f28nWsrWwys3ikqIbl1r0K3fTO+dlTBMn1e/Vtxv+2+E7A2POAvOw+JK
	kaz2riBjmoLt/5UaK8JsrP8pQfC3kCqA2Pf43PgVQc9wP23lD5gFs2nYHG1UqqtWuaWS1M
	hqQ4ZlxRHoviqBIMucB4u2fyPtPchi4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-546-f0VhyuuqOtKhCvV5FsKodA-1; Wed,
 13 May 2026 08:02:13 -0400
X-MC-Unique: f0VhyuuqOtKhCvV5FsKodA-1
X-Mimecast-MFC-AGG-ID: f0VhyuuqOtKhCvV5FsKodA_1778673731
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 68ADB180035D;
	Wed, 13 May 2026 12:02:11 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.218])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52ED0180058F;
	Wed, 13 May 2026 12:02:08 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] openvswitch: vport: fix race between linking and
 the device notifier
In-Reply-To: <20260513095541.2010516-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Wed, 13 May 2026 11:54:56 +0200")
References: <20260513095541.2010516-1-i.maximets@ovn.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 13 May 2026 08:02:05 -0400
Message-ID: <f7tse7vo6v6.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 7776E532C2E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-287564-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:email]
X-Rspamd-Action: no action

Hi Ilya,

Ilya Maximets <i.maximets@ovn.org> writes:

> Sashiko reports that it is technically possible that we got the device
> reference, but by the time we're linking it to the OVS datapath, it
> may be already in the process of being deleted.  In this case if the
> notifier wins the race for RTNL, it will see that the device is not
> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
> will take the RTNL and link the unregistering device to OVS datapath.
>
> Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
> the device will be properly detached, but it will take at least a
> second before that happens, so it's not something we should rely on.
>
> Let's avoid linking the non-registered device in the first place.
>
> Note: As per documentation, RTNL doesn't protect the reg_state, but
> it actually does for all the state transitions we care about here,
> so it should not be necessary to use READ_ONCE or taking the instance
> lock.  We can still do that, but we have a few more places even in
> this file where the reg_state is accessed without those while under
> RTNL, and many more places like this across the kernel code, so it
> might make more sense to change all of them in a more centralized
> fashion in the future, if necessary.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/vport-netdev.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
> index c42642075685d..de90d0541e172 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -83,6 +83,11 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
>  	}
>  
>  	rtnl_lock();

As noted in your commit, this shouldn't cause any kind of issues, since
the next netdev_wait_allrefs_any() will make sure things look correct to
the users again.

That said, I agree this is good to do to prevent some confusion going to
the users.  I wonder if it makes sense to add a comment here noting
that.  Otherwise, if I were just freshly reading through the code it
wouldn't follow (all the places where ovs_netdev_link get called are in
the 'create' path).

WDYT?

> +	if (vport->dev->reg_state != NETREG_REGISTERED) {
> +		err = -ENODEV;
> +		goto error_put_unlock;
> +	}
> +
>  	err = netdev_master_upper_dev_link(vport->dev,
>  					   get_dpdev(vport->dp),
>  					   NULL, NULL, NULL);


