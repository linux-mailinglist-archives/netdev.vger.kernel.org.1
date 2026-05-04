Return-Path: <netdev+bounces-284037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBxWNo0A+Wmp4AIAu9opvQ
	(envelope-from <netdev+bounces-284037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:24:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE794C3896
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 22:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAF1301FD77
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B85D3CFF4D;
	Mon,  4 May 2026 20:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QiO58DQN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42A338947E
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 20:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926283; cv=none; b=N1ivyd3FXEVyT7fDMWoq4MVEpugV7zMLThGqKZbad0bdd9XlrLJe2WGJ1P5FD9Zledc5iThX9GhBidliStBLwfOtLkkhflnK5qbzzdBH6FTaTng1v9X4cqLeF4VCn0P/rpndcd9tuTpNAF1ptDutOQ8M0yE82ztEaNwI30b0wQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926283; c=relaxed/simple;
	bh=zOav8ZaMYbNbj6qwrovxDSOR8ggG40qxMC3t7Ts9gW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GktvjIpQoe3IhFqq2c+V7VbpeV0RrTrzWaLABmF6nyrPYKxpQu00rJ5zDBL3DbwAbjzRsnpFtTA1V4uYzzph4XD/OBCAmK72x0vrkcOq5lHVEcGOKikyEN6qppC2qNTcrhf7QvI81F7HIPvZeO/ECWZ6uN3awgQ5ARU+WW+jMw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QiO58DQN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777926281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QeDkXbPaUg0Eyt+G1glq5ihHly+Yq7goyY5wJc9DJbk=;
	b=QiO58DQN88MayH07tykgCkiYTR3hkY4LCCUs9rk66+CWEOiX1Tku8d/fDdW1SYul73Ina5
	rS2F5IOFCFfIhO5OYogXT5fr9Uf/Axeyzm6DdZyRsmEujci+DDkNhIcpO9wD5YQNVErSY8
	ozCAdx+Y69vLMOQArTvMn7AxtbCEqCA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-KDKkanG2O7yw5l9qCc4jRA-1; Mon,
 04 May 2026 16:24:38 -0400
X-MC-Unique: KDKkanG2O7yw5l9qCc4jRA-1
X-Mimecast-MFC-AGG-ID: KDKkanG2O7yw5l9qCc4jRA_1777926277
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B316B1956088;
	Mon,  4 May 2026 20:24:36 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.157])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1D781800480;
	Mon,  4 May 2026 20:24:32 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Yuan
 Tan <tanyuan98@outlook.com>,  Yang Yang <n05ec@lzu.edu.cn>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] openvswitch: fix self-deadlock on release of
 tunnel vports
In-Reply-To: <d9a9fcf7-07e2-4e26-afde-f1bec6108c40@ovn.org> (Ilya Maximets's
	message of "Mon, 4 May 2026 13:43:53 +0200")
References: <20260430233848.440994-1-i.maximets@ovn.org>
	<d9a9fcf7-07e2-4e26-afde-f1bec6108c40@ovn.org>
Date: Mon, 04 May 2026 16:24:30 -0400
Message-ID: <f7t8q9yylc1.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 3DE794C3896
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	URIBL_MULTI_FAIL(0.00)[ovn.org:server fail,dpctl.py:server fail,sea.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284037-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ovn.org:email]

Ilya Maximets <i.maximets@ovn.org> writes:

> On 5/1/26 1:38 AM, Ilya Maximets wrote:
>> Two patches - the fix for the actual bug and the selftest that reproduces it.
>> 
>> I missed the self-deadlock in the original patch that introduced the issue,
>> because testing required code modification in the ovs-vswitchd to force it to
>> use legacy tunnel ports.  I thought I made the change correctly, but apparently
>> something went wrong and the tests were run with the standard LWT infra instead.
>> The selftest added in this patch set will at least prevent this kind of mistakes
>> in the future.
>> 
>> I mentioned, however, that these tunnel vports are legacy and not actually used
>> by ovs-vswitchd.  RTM_NEWLINK + COLLECT_METADATA is used in conjunction with the
>> standard OVS_VPORT_TYPE_NETDEV instead since 2017.  The code to use the legacy
>> tunnels still exists in ovs-vswitchd however, but only as a fallback for older
>> kernels and we're planning to remove it in the next release.  I'll be sending an
>> RFC to remove support for these legacy tunnel types from the kernel, as they
>> serve no real purpose today and only increase the uAPI surface for CVEs, but
>> we need to fix the known bugs for stable versions.
>> 
>> 
>> Version 2:
>>   - Added Ack from Eelco to the first patch (not to the second as it
>>     changed a little).
>>   - Removed now unused import socket in the dpctl.py [pylint/ruff].
>> 
>>   - Regarding comments from both Sashiko instances on the selftest patch:
>> 
>>     * The background process is not waited for / not killed.
>>       If it hangs it will not be killable anyway, so it's not a problem.
>
> Both sashiko instances still flag this.  Looks like the cover letter is not
> included in the prompt.
>
> If someone thinks I should add the suggested kill on exit, I can, but it will
> not be effective in case the process hangs.

One option is to put a comment in the test itself documenting this kind
of behavior.  At least, then the model might not flag it.  I don't feel
strongly about that, however.

> Best regards, Ilya Maximets.


