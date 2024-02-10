Return-Path: <netdev+bounces-70744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 722AB850398
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1010F1F23A49
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71A21E4BE;
	Sat, 10 Feb 2024 09:05:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690023DB
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707555944; cv=none; b=JADVm5k1GerJKxjHhaTkUvQBn2cgl2HE/Com0JMDTnzvJrDC+raBKb8XIjL8NcXFXN8N7P7yc+ofhXWmnec/ANK8PqwZCNeFHYzG/YfDkKMxN4Th787TVTJU/2xbZROJB9pryzu6plbKOkoGNMS2a6Ny/EeR361VuEiubAN1iH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707555944; c=relaxed/simple;
	bh=5xt1hYMBC5U2THKZadjx5L/lzy65PCDpdxJAluaSGTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Z+QSiCezVrTP5fEv1Ql67LDA1AJu1FMVHdoYwnREA739v4kk8IKVSGres9+xEdW0qDg46n74Hqi0N28BYXQ2YJtVPH5sNFcdCx1rfZe9uCkVSk1X2YSSK3RNbXiL2V+jbmCll6nVrj7Ew922VbAbPPBNPNjD+uNBv0dIvPJ5JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-hz_6Mhf6MBaBy8kJFVNznA-1; Sat, 10 Feb 2024 04:05:35 -0500
X-MC-Unique: hz_6Mhf6MBaBy8kJFVNznA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A655828CE2;
	Sat, 10 Feb 2024 09:05:35 +0000 (UTC)
Received: from hog (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 60F7F2026D06;
	Sat, 10 Feb 2024 09:05:34 +0000 (UTC)
Date: Sat, 10 Feb 2024 10:05:33 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 0/7] net: tls: fix some issues with async encryption
Message-ID: <Zcc8Xc1SMJJptq7Z@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-06, 17:18:17 -0800, Jakub Kicinski wrote:
> Hi!
>=20
> valis was reporting a race on socket close so I sat down to try to fix it=
.
> I used Sabrina's async crypto debug patch to test... and in the process
> run into some of the same issues, and created very similar fixes :(
> I didn't realize how many of those patches weren't applied. Once I found
> Sabrina's code [1] it turned out to be so similar in fact that I added
> her S-o-b's and Co-develop'eds in a semi-haphazard way.
>=20
> With this series in place all expected tests pass with async crypto.
> Sabrina had a few more fixes, but I'll leave those to her, things are
> not crashing anymore.

Sorry :(
I got stuck trying to fix a race condition (probably one of those
you're fixing in this series, I tried something similar to patch 3 but
that wasn't enough), and then got distracted. I had a v2 ready and
never posted it :/

Thanks for taking over, and sorry for the duplicate effort. I'll go
back to my old series and see if anything is still relevant on top of
this.

--=20
Sabrina


