Return-Path: <netdev+bounces-287643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDkMIEecBGr3LwIAu9opvQ
	(envelope-from <netdev+bounces-287643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:44:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6361536618
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEE9633CC2F6
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CFB4779B1;
	Wed, 13 May 2026 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qj6ozmdT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3021145B11
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778684764; cv=none; b=h/9iw1iZFWe5xsXhqyFB4iOKYTCUkXrTOTtdMupclnC9Yq8VqpFJIePx0XRAC29XDN8wFmYVv94/IkYMoSAZ8yMsZZkVHbutpl+gUETCYdx6BAkESZX9fab86AUvmVJlut3F6Rz56lXTutmjeSLQjZqyhO0dlacW4WV43wl06UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778684764; c=relaxed/simple;
	bh=iEjF+R8iN9xUeWEEDZCMd+xTX+D7ZErPg3FJEx0Nbp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nk/tSStPNkDN0DionyF1uA0myNz4F2rAu++SY59jZGpudD+o2NCpU4JbBX1DpneL2Gp+Ea5BS0KA9wbQ5UlvXZm7j3qku2F1hxNdB5KkXZXASWNI6Escua5CHRvmSkWcN3iY9XK3g0vMPgNnOh78Bcc+RZY2T0vpD0WZEnAIzPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Qj6ozmdT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778684762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iEjF+R8iN9xUeWEEDZCMd+xTX+D7ZErPg3FJEx0Nbp0=;
	b=Qj6ozmdTzVRiAzBRiElv21CutK0sjYcTc1Xg3JTlc7P9ua6KYyc+Hvj5ZowOWjTHc9sXxx
	6G+M777BM2wD9tWZ7fE2ejWpcQFJxGeovy/yj/Xf9+ONLJTuoFnP/PPhiPn9Jdx2KNuNvv
	gkCr7Ni+9V89N1gi80TYuASZwnQ2EeQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-cxGh7gBGMVS0QXXJc8fzVw-1; Wed,
 13 May 2026 11:06:00 -0400
X-MC-Unique: cxGh7gBGMVS0QXXJc8fzVw-1
X-Mimecast-MFC-AGG-ID: cxGh7gBGMVS0QXXJc8fzVw_1778684759
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 804951800283;
	Wed, 13 May 2026 15:05:59 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.90.43])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDDC51800465;
	Wed, 13 May 2026 15:05:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  i.maximets@ovn.org,
  i.maximets@redhat.com
Subject: Re: [PATCH net-next 0/5] selftests: openvswitch: pylint cleanup for
 ovs-dpctl.py
In-Reply-To: <20260513124704.2610072-1-houminxi@gmail.com> (Minxi Hou's
	message of "Wed, 13 May 2026 20:47:04 +0800")
References: <20260513121240.2590767-1-houminxi@gmail.com>
	<20260513124704.2610072-1-houminxi@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Wed, 13 May 2026 11:05:55 -0400
Message-ID: <f7tlddnnycs.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: D6361536618
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287643-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aconole@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Minxi Hou <houminxi@gmail.com> writes:

> Hi Aaron,

Hi Minxi,

> This series depends on the v10 vlan/pop_vlan series (still in New state):
> https://patchwork.kernel.org/project/netdevbpf/list/?series=1093324
>
> Patchwork flagged apply failure because v10 isn't in the tree yet.
>
> Should I wait for v10 to land and resend, or is there a way to
> indicate the dependency so maintainers can apply them in order?

We should wait until all dependent series are merged; there isn't a way
to flog a series as depending on another as far as I'm aware.

I'll take a look at this series but please wait until the v10 is merged.

thanks!

> Thanks,
> Minxi


