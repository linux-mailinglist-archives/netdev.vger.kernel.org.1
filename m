Return-Path: <netdev+bounces-179742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A72A7E6B3
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0EA44614C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A939A20E6F8;
	Mon,  7 Apr 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ChmOi1sz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF008209F50
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042913; cv=none; b=IUqIcQfb4ydzZmU2X0iqyyS91L1ngyv+1xHRcx/oVD0HDWLnJnLc3roxsBS6XoEjLuoy0uK0PzWvRy7yiTosZRqR2DXbtTcinV2wYrkDtFORifyQ8csVPJxOGDRKdMqKeHpwcytRDj/Zw0RmWX5cNkX7hvkWImohzRUYfDsNpug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042913; c=relaxed/simple;
	bh=zmJAQkrReTzw9Rja/ZkdJyHOJm3OjtPUHZhpo5Zp5cw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=V78ezM8PGUfW/qrDiN4W16NpsdWC4bP4tYX2vySTQQ4IrgyBhRdSrnfp/K8ixbAUR8LVWECQNYHoKANrPsoWUeM/GaKnWTUAxYXoSYBwnY8MOT0E+BXNeo72M0KH9Z0CxoPoc8R8XzY4TQdVLOibJ52UM57FPoMs0YsRvraHnm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ChmOi1sz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744042910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OCNXBsMl8e9MqCq6tvl63EXz/2Zgney6pBqg4qpe7Pg=;
	b=ChmOi1szYZLFttSqXDK5Sr5aR22pK4cjiCzBo2tWUTmYj8JxWNiqh1HAZMsdeLWw2uABXD
	3I/JyRQAXo93a2CXtMNQdYq9P3FDKZ1Ng/1OU/jAlMSYAfrYjz/ItTOmfwBlSsmO1hQH1u
	EU5xgQxXlu5YtiMPWrpWgvNrIsFWAzg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-5Bedl0x_Pym0nqYna0Wb4Q-1; Mon,
 07 Apr 2025 12:21:49 -0400
X-MC-Unique: 5Bedl0x_Pym0nqYna0Wb4Q-1
X-Mimecast-MFC-AGG-ID: 5Bedl0x_Pym0nqYna0Wb4Q_1744042906
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A2A0195608F;
	Mon,  7 Apr 2025 16:21:46 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 78B531809B63;
	Mon,  7 Apr 2025 16:21:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250407161225.GQ395307@horms.kernel.org>
References: <20250407161225.GQ395307@horms.kernel.org> <20250407091451.1174056-1-dhowells@redhat.com> <20250407091451.1174056-11-dhowells@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: dhowells@redhat.com, netdev@vger.kernel.org,
    Marc Dionne <marc.dionne@auristor.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>,
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
    Christian Brauner <brauner@kernel.org>,
    Chuck Lever <chuck.lever@oracle.com>, linux-afs@lists.infradead.org,
    openafs-devel@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] afs: Use rxgk RESPONSE to pass token for callback channel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Apr 2025 17:21:42 +0100
Message-ID: <1349701.1744042902@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Simon Horman <horms@kernel.org> wrote:

> warning: format =E2=80=98%zx=E2=80=99 expects argument of type =E2=80=98s=
ize_t=E2=80=99, but argument 2 has type =E2=80=98long unsigned int=E2=80=99=
 [-Wformat=3D]

I've fixed that and posted a v2.  I've also dealt with a bunch of kdoc
warnings.

David


