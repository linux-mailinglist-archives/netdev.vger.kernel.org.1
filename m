Return-Path: <netdev+bounces-283932-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qI+pKMHC+Gky0gIAu9opvQ
	(envelope-from <netdev+bounces-283932-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:01:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6AF4C1142
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C4843029E50
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A9D3E123F;
	Mon,  4 May 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jhp5Z9CL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA91B3E1220
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777910259; cv=none; b=PjHwq7uPnSh4NAV4+1Xok321fqONFVZ9d0ta+REt31Pg8T8R+X2sUE/cLt5EwYQXYYwcEROv1bFEEu3Ura2bhlU55dKwhSkVjG4naLyG2q52DAkcz53uQ8LFtOGfAKzKznge+wFCbEZXgS8z9HNsXuD9czg6nqZIKXbSTZQUeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777910259; c=relaxed/simple;
	bh=VM7CLDf7gt/5gwNO4SFdO7Ms7+Fxp86y/fpbqcqeOBo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hd0e9aeuogmkGbGgz2cP7kw4B7CCBFBOkoPQ3Wu5sWF5Un9AnHSPIU2mk7Sx55YCpMUIuSLs6KI2Ht8lK4TZYK85yOKbNSYzO9meD2rEk73Z68aDth44HS5KANCX2CWSL6xhZBEw8zRe+JEIcL2uv41PsQn3mR6F/1dB6th61zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jhp5Z9CL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777910255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZxPmQxvTEONKQ/yJAF3QaY1PN3IxKy5PehOvGtp/ALI=;
	b=Jhp5Z9CL1cmijZRjEwUGUSag8LPqv/HQ85x7eJiMobsF0E0nKGGIXlN+Jono81DGW2Axpl
	Sq4tKApSNEUyia4KlBW6+jfYFnZWzTGD69Bc1N5Jk41RpaQK7Upg9hclwaA6ej2qxEfIa6
	kzEIZ0IdbDAFnyMqtJO/RgV0BjChjRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-hMavPzwmNn6B3v5jio5rxA-1; Mon,
 04 May 2026 11:57:30 -0400
X-MC-Unique: hMavPzwmNn6B3v5jio5rxA-1
X-Mimecast-MFC-AGG-ID: hMavPzwmNn6B3v5jio5rxA_1777910248
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52BD918002C5;
	Mon,  4 May 2026 15:57:28 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.157])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E455630001A1;
	Mon,  4 May 2026 15:57:24 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  Simon Horman <horms@kernel.org>,  Shuah Khan <shuah@kernel.org>,  Yuan
 Tan <tanyuan98@outlook.com>,  Yang Yang <n05ec@lzu.edu.cn>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] selftests: openvswitch: add tests for tunnel
 vport refcounting
In-Reply-To: <20260430233848.440994-3-i.maximets@ovn.org> (Ilya Maximets's
	message of "Fri, 1 May 2026 01:38:38 +0200")
References: <20260430233848.440994-1-i.maximets@ovn.org>
	<20260430233848.440994-3-i.maximets@ovn.org>
Date: Mon, 04 May 2026 11:57:23 -0400
Message-ID: <f7th5onxj4s.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 4F6AF4C1142
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-283932-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovn.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Ilya Maximets <i.maximets@ovn.org> writes:

> There were a few issues found with the tunnel vport types around the
> vport destruction code.  Add some basic tests, so at least we know that
> they can be properly added and removed without obvious issues.
>
> The test creates OVS datapath, adds a non-LWT tunnel port, makes sure
> they are created, and then removes the datapath and waits for all the
> ports to be gone.
>
> The dpctl script had a few bugs in the none-lwt tunnel creation code,
> so fixing them as well to make the testing possible:
> - The type of the --lwt option changed in order to properly disable it.
> - Removed byte order conversion for the port numbers, as the value
>   supposed to be in the host order.
> - Added missing 'gre' choice for the tunnel type.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Looks good to me.  Thanks for the test.

Acked-by: Aaron Conole <aconole@redhat.com>


