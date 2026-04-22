Return-Path: <netdev+bounces-280357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC+GDpCM6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:53:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87614443ABB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22721300B9EA
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7D4376BCC;
	Wed, 22 Apr 2026 08:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JngPhmSr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E10D2EA754
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847978; cv=none; b=kg0PxpfU8SRvJZLao8yU3XXj09zkSSOufIJTLGcCHWuhbaFV/pDFeP9OHTuHNuXqiOfPw5LkFQsKzF+4QwMLaYjZMGR2H3ibOeWw09RNRol4pwm56yvaWXi29VzWmWXcrDskvhh1y3nqt+nM0Zf+JSlypKxogPXN1ewMLoOryW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847978; c=relaxed/simple;
	bh=ZP0zLOUYPCz6XY3n+DrjlGKzVp2SHC+G7wTWKDUfoGM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ng0lIgQDaBZOKv9rxhtSuWOHPHa/qv71r/yO52zsD/yITWu2EYywVEF697iNq2F60qyJ71bCLa3CjsIwOqSXf7lK7wRgKJjc2EqXCWVutsr7wEdzcProTvBVDf5bOGIcgP1g8/zpbXSAkKWy+NpTzp6erjh541GS+RkCbDix2ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JngPhmSr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776847976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZP0zLOUYPCz6XY3n+DrjlGKzVp2SHC+G7wTWKDUfoGM=;
	b=JngPhmSrzzirXOCv9+bU8N95JhlIoN8QC+buDsdNrLC3n4sGv2Vf93VqNDG5nnZ/ocmEmB
	8kGh1sAI7CgGyQColVhDr0gRTVTe+H+0by3HMK//y8B8drZTOPepMjoBU0zyfBcsnlMj9I
	zFcIhYdUyQbmBC82Pvq/p35JJc5WESE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-KAfABAXVPC2VY7LAeMqU0Q-1; Wed,
 22 Apr 2026 04:52:52 -0400
X-MC-Unique: KAfABAXVPC2VY7LAeMqU0Q-1
X-Mimecast-MFC-AGG-ID: KAfABAXVPC2VY7LAeMqU0Q_1776847971
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C1071800473;
	Wed, 22 Apr 2026 08:52:50 +0000 (UTC)
Received: from griffin (unknown [10.44.48.93])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A2AA19560AB;
	Wed, 22 Apr 2026 08:52:44 +0000 (UTC)
Date: Wed, 22 Apr 2026 10:52:42 +0200
From: Jiri Benc <jbenc@redhat.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuantan098@gmail.com,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, bird@lzu.edu.cn,
 lx24@stu.ynu.edu.cn, caoruide123@gmail.com
Subject: Re: [PATCH net 1/1] net: nsh: handle nested NSH headers during GSO
Message-ID: <20260422105242.7b28f72c@griffin>
In-Reply-To: <6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com>
References: <cover.1776597597.git.caoruide123@gmail.com>
	<6112cce99b4e3571444a616d0fb19e91e2fcca72.1776597598.git.caoruide123@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280357-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lzu.edu.cn,stu.ynu.edu.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbenc@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87614443ABB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026 11:31:32 +0800, Ren Wei wrote:
> Handle nested NSH headers iteratively in a single nsh_gso_segment()
> invocation. Unwrap consecutive NSH headers until the first non-NSH payload
> is reached, including the case where the next redispatch target is reached
> through ETH_P_TEB, segment that payload once, and then restore the full
> outer encapsulation on each output segment.

This looks fragile. If there's ever another protocol with similar logic
added, we'll be in the same situation. (And obviously, unrolling the
recursion for any combination of protocols doesn't scale well.)

What about using a mechanism similar to dev_xmit_recursion to limit the
depth and returning EINVAL if we exceed the limit? I think it's fine to
drop the packet in this pathological case.

We might even just use dev_xmit_recursion directly, since it can be
argued that such nested NSH headers are in fact nested tunnels.

 Jiri


