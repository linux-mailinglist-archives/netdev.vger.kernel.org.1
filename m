Return-Path: <netdev+bounces-268897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEyYHOFTumm8UQIAu9opvQ
	(envelope-from <netdev+bounces-268897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:27:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D842B6ECA
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 08:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E9C13141DD0
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060C9369988;
	Wed, 18 Mar 2026 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a54kadWw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC030648C
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 07:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773818497; cv=none; b=PwgkE7N0MWuGUKC48t48D3jfLWQYbu818rxBxKpKS5zaZ2yNEdM/hPogJQvDh1bbe48S9LRVeIdZjYWOft8MHoD3wsgQTJ77sE28kdj5ElSDCAj6bpLn1bOrdw7wopgLm/qjpEs9LehF605TWqukOdIyVc6wIIeML/yw4i6sxus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773818497; c=relaxed/simple;
	bh=Ig6C5egLRJUQtKxAu5g7tCS9dio7mrkL9BFpeVBIFXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuvNx4j2O7+1LXw4hckxVtTwHmGp/sFOHWfQCLjQUB1SgsDjlCZacq4h+yv2U4m9RRX1Kk0Oi/6LfaxTGliNaspMfoM/eg/qC3FBo1dkkTSGAwNd/2vmVgJ2xje79ESxdreIrq+5Vo+bLV8XZd1muk8v7CFmJuiKuM/rgWsptBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a54kadWw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773818495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vvBkUzuC+9rvZuPZ6i9/puIA0EUoD+LmtfF1yKBGrg=;
	b=a54kadWwndywUqD71euDsPkyir7xog0rHerDxpcksjUfT4jN8BQVz4l56XsQnzLYmnW7zg
	JkXtEXVlsryqrk2Va+EPzNCjSe5xDXSAzYFQ7D+jl5c2ysHaSaCAVhhbwNWIMUef0zlHBn
	a8/M6SA6rQZfnWmCc0Nte87NjyZsSSE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-JFBv0kdqMcmN3Su822nKig-1; Wed,
 18 Mar 2026 03:21:32 -0400
X-MC-Unique: JFBv0kdqMcmN3Su822nKig-1
X-Mimecast-MFC-AGG-ID: JFBv0kdqMcmN3Su822nKig_1773818491
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F24DF1800561;
	Wed, 18 Mar 2026 07:21:30 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CE55F180075C;
	Wed, 18 Mar 2026 07:21:28 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: ouster@cs.stanford.edu
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: Re: [net-next,v17,07/14] net: homa: create homa_interest.h and homa_interest.c
Date: Wed, 18 Mar 2026 08:21:24 +0100
Message-ID: <20260318072124.268931-1-pabeni@redhat.com>
In-Reply-To: <20260316223228.2611-8-ouster@cs.stanford.edu>
References: <20260316223228.2611-8-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268897-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: D0D842B6ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: homa: create homa_interest.h and homa_interest.c

These files implement the homa_interest struct, which is used to wait for
incoming messages.

> diff --git a/net/homa/homa_interest.c b/net/homa/homa_interest.c
> new file mode 100644
> index 000000000000..6daeedd21309
> --- /dev/null
> +++ b/net/homa/homa_interest.c

[ ... ]

> diff --git a/net/homa/homa_interest.h b/net/homa/homa_interest.h
> new file mode 100644
> index 000000000000..d9f932960fd8
> --- /dev/null
> +++ b/net/homa/homa_interest.h
> @@ -0,0 +1,93 @@

[ ... ]

> +/**
> + * homa_interest_unlink_shared() - Remove an interest from the list for a
> + * socket. Note: this can race with homa_rpc_handoff, so on return it's
> + * possible that the interest is ready.
> + * @interest:    Interest to remove. Must have been initialized with
> + *               homa_interest_init_shared.
> + */
> +static inline void homa_interest_unlink_shared(struct homa_interest *interest)
> +	__must_hold(hsk->lock)
> +{
> +	list_del_init(&interest->links);
> +}

The __must_hold annotation references 'hsk->lock' but 'hsk' is not in scope.
This will cause sparse to report an error when checking with 'make C=1'.
Should this be '__must_hold(interest->hsk->lock)' to match the pattern used
in homa_interest_unlink_private?


