Return-Path: <netdev+bounces-302145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DTvACLVaPmq3EQkAu9opvQ
	(envelope-from <netdev+bounces-302145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:55:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741C26CC38C
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 12:55:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=diFhm5fv;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302145-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302145-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF13D300A747
	for <lists+netdev@lfdr.de>; Fri, 26 Jun 2026 10:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCB93ED122;
	Fri, 26 Jun 2026 10:55:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3091A3160
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 10:55:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782471307; cv=none; b=clWerSODeH7uwVhIfrk63Rhu6FDzKJP+plNwmyaOSeh+GdFSU75nzpKXwoyb2ap6ziyS6HGCzYlt0B1lOxj8ybTu7csMzLOezyld/QfyYsbnFXavM9/HY2RjBEWZFuqD+SUHSbCFB/w2HpV5CvnJqsFkl9LwG/4+0EHToEXbdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782471307; c=relaxed/simple;
	bh=rZ08VcXOIrjOKCf/cAe0dTUIbyeOhQ4FOfMIPhkaGBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cnk0ZdTc9zvFxQzWR6X6fwJ4eq9sF4dlVUK0YYd5ejcO2mq1Ln7+uVd594Nm71Hd62PmqVSbeG3/tTjZQt6eBGoTNBQaiz0PpGvrqgoC7QPKcMKa7yfO8EOX9tWx2Talqet0tQPtY0EtI2sY/8k/bZLKmOnbHFYb0/i45Tj58KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=diFhm5fv; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782471304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDoLmRFdjTWaJPTg5Rz1/wyvQlw0NWoNDIzgPbuVeHs=;
	b=diFhm5fvyMBRVrUTxbctVhb//hrSXyn4I63NKxt5O2mrXolIgrvYN0XAlzYABV1Dfb/B1U
	Z+gnMLFRZbRacxkPwQH9g4hCfP23Zj1FX8Rsqxd1HW0GOfde9gFfLk293p8S9izBt6A2Ly
	dFO19ax1x1xF29CwL51zvRRheud6xdQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-QwSM5qfePAyDVLZIptudnw-1; Fri,
 26 Jun 2026 06:55:00 -0400
X-MC-Unique: QwSM5qfePAyDVLZIptudnw-1
X-Mimecast-MFC-AGG-ID: QwSM5qfePAyDVLZIptudnw_1782471298
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B72E1955F26;
	Fri, 26 Jun 2026 10:54:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.38])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 919EB1800361;
	Fri, 26 Jun 2026 10:54:54 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: aleksandr.loktionov@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	intel-wired-lan@lists.osuosl.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net v7 3/4] iavf: send MAC change request synchronously
Date: Fri, 26 Jun 2026 12:54:53 +0200
Message-ID: <20260626105453.215716-1-jtornosm@redhat.com>
In-Reply-To: <20260624163148.1146093-2-horms@kernel.org>
References: <20260624163148.1146093-2-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:aleksandr.loktionov@intel.com,m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:intel-wired-lan@lists.osuosl.org,m:jacob.e.keller@intel.com,m:jtornosm@redhat.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:przemyslaw.kitszel@intel.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jtornosm@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 741C26CC38C

>>       if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>>               return -EACCES;

> [Severity: High]
> Will this cause a persistent state mismatch if a timeout is followed by a
> retry?
>
> If iavf_set_mac_sync() times out, it returns -EAGAIN and bypasses this
> rollback, leaving adapter->hw.mac.addr updated but netdev->dev_addr at the
> old MAC.
>
> If the user then retries before the PF asynchronously completes the original
> request, iavf_add_ether_addrs() returns -EBUSY. Since -EBUSY != -EAGAIN,
> the rollback runs, forcibly reverting adapter->hw.mac.addr to the old MAC.
> 
> When the PF's delayed success response finally arrives,
> iavf_virtchnl_completion() sees the old MAC in both hw.mac.addr and
> netdev->dev_addr, bypassing the netdev MAC update. The PF hardware is now
> programmed with the new MAC, but the kernel retains the old MAC, dropping
> traffic.

This scenario requires an extremely narrow timing window: a 2.5s PF timeout
(rare in normal operation, PF typically responds much faster), followed by an
immediate retry before adminq_task clears current_op (microsecond window).

Even if this race occurs, it's recoverable - the retry fails with -EBUSY
and the user retries again successfully. This is a transient failure, not
permanent state corruption.

>>       if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>>               /* bail because we already have a command pending */
>>               dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
>>                      adapter->current_op);
>> -             return;
>> +             return -EBUSY;
>>       }
>
> [Severity: High]
> Could routine background tasks cause MAC changes to frequently fail?
>
> The watchdog task routinely sets adapter->current_op for background commands
> like VIRTCHNL_OP_GET_STATS. If iavf_set_mac() is called during this window,
> iavf_set_mac_sync() will hit this check and immediately fail the MAC change
> with -EBUSY.
>
> Because there is no retry logic in iavf_set_mac(), this error propagates
> directly to userspace, making MAC address configuration randomly fail based
> on watchdog timing.

Background virtchnl operations (like GET_STATS) complete quickly, typically
within milliseconds. The collision window is very small.

Fail-fast with -EBUSY is semantically correct and allows user-space retry.
If a collision occurs, it's spurious and recoverable immediately on retry.
This is acceptable compared to the complexity and deadlock risks of queuing
or waiting for background operations to complete while holding netdev_lock.

>> -static void iavf_mac_add_reject(struct iavf_adapter *adapter)
>> + */
>> +void iavf_mac_add_reject(struct iavf_adapter *adapter)
>>  {
>>       struct net_device *netdev = adapter->netdev;
>>       struct iavf_mac_filter *f, *ftmp;
>
> [Severity: Medium]
> Does exporting and reusing iavf_mac_add_reject() for local rollback cause
> unintended background MAC changes?
>
> When the user requests a MAC address that is already in the filter list
> (e.g., a secondary MAC), iavf_add_filter() sets f->is_new_mac = false and
> f->add = true, and flags IAVF_FLAG_AQ_ADD_MAC_FILTER.
>
> If the synchronous operation fails locally (like the -EBUSY return above),
> iavf_set_mac() calls this function. However, iavf_mac_add_reject() only
> clears the pending state and removes the filter if f->is_new_mac is true:
>
>    if (f->is_new_mac) {
>        list_del(&f->list);
>        kfree(f);
>    }
>
> Reused filters are ignored, leaving f->add = true and the
> IAVF_FLAG_AQ_ADD_MAC_FILTER flag active. The background watchdog task will
> eventually process this flag and blindly send the MAC configuration to the
> PF, even though the VF already aborted the operation locally.

This scenario only occurs when setting the primary MAC to an address that
already exists as a secondary MAC in the filter list - an extremely rare
configuration.

Even if this occurs and the watchdog later sends the MAC to the PF, it is
harmless: the MAC is already configured on the PF (as a secondary), so the
redundant ADD_ETH_ADDR message has no adverse effect.

The common case - changing primary MAC to a new address - uses is_new_mac =
true and is handled correctly by the rollback logic.



These concerns represent theoretical edge cases that are extremely unlikely
in practice. The synchronous approach fixes a reproducible deadlock affecting
all users in production, allowing the user to retry and complete the
operation. The trade-off is justified.


