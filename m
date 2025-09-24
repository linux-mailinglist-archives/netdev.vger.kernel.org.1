Return-Path: <netdev+bounces-225929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A302B9973F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 12:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF1E4A80CB
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 10:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90B82DF718;
	Wed, 24 Sep 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTJFJBDD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DC22DFA2B
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758710389; cv=none; b=o8M2e9aGrmP8ZuLX8t9k+Eox3/H0HMrCx1a1dxvpZ7iL3ZgLLdg3KqaXnUCYsXXIFpOZyQfaZYLc9OOmbgDM0IhcXMyOV2qOmAH+HxmHAmyTT1HiH3kvbB5Y7KQgPp7tgyzUJZ4BjTsn8pyo2Dfon/cxXyVl+zIy0iOLWD2CJh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758710389; c=relaxed/simple;
	bh=RD2bDCnokvBr2io7nj34I0+bX53THU9utJYuo/5mwBU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eNMA0zyfT7/KfCQTUQ83NomUZ5GHlhYZ47PWBF8xpnfuO27H7lWymNASibaZEstQqEIRFbm8l1EAUiSMh3Bg2tISEYXOwVrLCTrNuEw3JaAb0ef1iZiOxpGvwDVR4uciaTE13vAW0RMsdiM7YZI7vIW7qltkPQ+t3/+nAVk3WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTJFJBDD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758710383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hF4kiLf7HaqY1/LkvQINP3t8+3I60jrbQmSIFL8i6mM=;
	b=jTJFJBDDmyyW/SLfPm9FG2f9l1flp9QbVGuAN1TODAI6Jx6g0hlJzYRd0NT8VogXzXrwRF
	NOB19vqRswVXP5qzXVdQZ3ZYkNOxMt2tskpM4kp4uZyJLrVFgFux1KGH5/VtsWAi5FZqxp
	iSe0EwN90JRK7bOpZMaUxiAoZMOzEzM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-8jgRHihsNYSXYhc0c7zGRA-1; Wed,
 24 Sep 2025 06:39:39 -0400
X-MC-Unique: 8jgRHihsNYSXYhc0c7zGRA-1
X-Mimecast-MFC-AGG-ID: 8jgRHihsNYSXYhc0c7zGRA_1758710378
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 962B31800366;
	Wed, 24 Sep 2025 10:39:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7862419560B1;
	Wed, 24 Sep 2025 10:39:30 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250922124137.5266-1-bagasdotme@gmail.com>
References: <20250922124137.5266-1-bagasdotme@gmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: dhowells@redhat.com,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Linux Documentation <linux-doc@vger.kernel.org>,
    Linux Networking <netdev@vger.kernel.org>,
    Linux AFS <linux-afs@lists.infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
    Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next RESEND] Documentation: rxrpc: Demote three sections
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <721546.1758710369.1@warthog.procyon.org.uk>
Date: Wed, 24 Sep 2025 11:39:29 +0100
Message-ID: <721547.1758710369@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Three sections ("Socket Options", "Security", and "Example Client Usage")
> use title headings, which increase number of entries in the networking
> docs toctree by three, and also make the rest of sections headed under
> "Example Client Usage".
> 
> Demote these sections back to section headings.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Acked-by: David Howells <dhowells@redhat.com>


