Return-Path: <netdev+bounces-287968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHIjCdLRBWpUbwIAu9opvQ
	(envelope-from <netdev+bounces-287968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:44:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7590C542744
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64BC4307BA8E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577A3E51C8;
	Thu, 14 May 2026 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iz/SWvI/"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EF3DD520
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 13:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766220; cv=none; b=PW6kBBa3Cu1uD06sb0h4dykg4aMlCC+rJgcO8mk1/9wfunWnuAL4+l/MctGE6uYL6fW8uvS2vKowDX1we+Nd6Adu067h+z9hcOCNRQ4hQ13b0urW/Aqhdvr8seRFmvyWfpdKRV/aqQ7kd5uhka73By9L6MS0BYTozfCTUinXYoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766220; c=relaxed/simple;
	bh=zZtI0ZXu5zXxmqc4HkSEJtdZZmhetRNgoFu5b/5CM2A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tn6+hqZ8ysggdONyguwQYqBy+ftZCeYNH/WssCB2D84KK6nJOSRgmXlF7te0taQZCKPGJAAK1cfk269s4ksjMuRk40ETNDVRMaNcdxRe1+ji8j7pmKhV3hYFZ3J/D9Lms+80e+4McPWxlJcj9JHqeTOHkzdL6LtP3aLwKQrytp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iz/SWvI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778766217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EsSLZ72S4plY7gS2Kwo+BjnmY+NmQb+ux/pQP/iNZzg=;
	b=Iz/SWvI/geDvxN1jNDELqt+J91aWCw3mbzpSZj5JN7xPSAt4A3olt21R9YC56uMdmRjOab
	UE5L1WtuyBjEYow5olYTRVKPxGFkBaXXSb4fbZNDkvdDDauJLKYkxX/6yNGYYmF7XHCAQy
	GXAszaMndCwWzPJs2EuETW2kkDKFQpo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-uhy8r_8sO_eowJiV9dAeYQ-1; Thu,
 14 May 2026 09:43:33 -0400
X-MC-Unique: uhy8r_8sO_eowJiV9dAeYQ-1
X-Mimecast-MFC-AGG-ID: uhy8r_8sO_eowJiV9dAeYQ_1778766211
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D3461956068;
	Thu, 14 May 2026 13:43:31 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.81.221])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A173319560A6;
	Thu, 14 May 2026 13:43:28 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  dev@openvswitch.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] openvswitch: vport: fix race between linking and
 the device notifier
In-Reply-To: <41104c02-efb9-4f23-8e11-95afa6eef442@ovn.org> (Ilya Maximets's
	message of "Wed, 13 May 2026 18:55:59 +0200")
References: <20260513095541.2010516-1-i.maximets@ovn.org>
	<f7tse7vo6v6.fsf@redhat.com>
	<41104c02-efb9-4f23-8e11-95afa6eef442@ovn.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Thu, 14 May 2026 09:43:26 -0400
Message-ID: <f7tik8qqf7l.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Queue-Id: 7590C542744
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
	TAGGED_FROM(0.00)[bounces-287968-lists,netdev=lfdr.de];
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

Ilya Maximets <i.maximets@ovn.org> writes:

> On 5/13/26 2:02 PM, Aaron Conole wrote:
>> Hi Ilya,
>> 
>> Ilya Maximets <i.maximets@ovn.org> writes:
>> 
>>> Sashiko reports that it is technically possible that we got the device
>>> reference, but by the time we're linking it to the OVS datapath, it
>>> may be already in the process of being deleted.  In this case if the
>>> notifier wins the race for RTNL, it will see that the device is not
>>> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
>>> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
>>> will take the RTNL and link the unregistering device to OVS datapath.
>>>
>>> Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
>>> the device will be properly detached, but it will take at least a
>>> second before that happens, so it's not something we should rely on.
>>>
>>> Let's avoid linking the non-registered device in the first place.
>>>
>>> Note: As per documentation, RTNL doesn't protect the reg_state, but
>>> it actually does for all the state transitions we care about here,
>>> so it should not be necessary to use READ_ONCE or taking the instance
>>> lock.  We can still do that, but we have a few more places even in
>>> this file where the reg_state is accessed without those while under
>>> RTNL, and many more places like this across the kernel code, so it
>>> might make more sense to change all of them in a more centralized
>>> fashion in the future, if necessary.
>>>
>>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>>> ---
>>>  net/openvswitch/vport-netdev.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
>>> index c42642075685d..de90d0541e172 100644
>>> --- a/net/openvswitch/vport-netdev.c
>>> +++ b/net/openvswitch/vport-netdev.c
>>> @@ -83,6 +83,11 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
>>>  	}
>>>  
>>>  	rtnl_lock();
>> 
>> As noted in your commit, this shouldn't cause any kind of issues, since
>> the next netdev_wait_allrefs_any() will make sure things look correct to
>> the users again.
>> 
>> That said, I agree this is good to do to prevent some confusion going to
>> the users.  I wonder if it makes sense to add a comment here noting
>> that.  Otherwise, if I were just freshly reading through the code it
>> wouldn't follow (all the places where ovs_netdev_link get called are in
>> the 'create' path).
>> 
>> WDYT?
>
> I'm not sure if the comment is necessary.  We're not creating a device here
> and it seems clear enough that we shouldn't be linking devices that are not
> registered, even if there are no races.  But I could add something like:
>
> /* Do not link devices that are not registered to avoid a potential
>  * race with the NETDEV_UNREGISTER notification in dp_device_event().
>  */
>
> WDYT?

That comment makes sense to me.

> Best regards, Ilya Maximets.


