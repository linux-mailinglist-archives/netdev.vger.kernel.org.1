Return-Path: <netdev+bounces-70745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63108850399
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912621C2252B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A5333CE6;
	Sat, 10 Feb 2024 09:08:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C423DB
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556139; cv=none; b=fdfJ54ZI96bM+xfZJIVIZFq+Ap89qSSDVTGEb/ine+TB/UFmPIdVNam4SNPoo8dJRT4CCYzBuqh7MQuNvpAJfCQtylpbvQCvNaeqmxRapTYzFezEw/va6/OSrL2VqJx2ORUQigQKlANVEMrjbee3TudS1OnABCSU8pN0SakdTM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556139; c=relaxed/simple;
	bh=w2Ss0+vbduPy4TfsVmfXKbz9NclyiDlNvslirlxfvXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=I8U/QYY78ARPvvVtnkStb802BqQmnHdnbV11wakGz4t9sPmdsTrebIqlYKOMXoz+INB6XKCyffeQanHjW6DDpjn0xt7ovM5axUZRz6lwZk9Mchk1PwxWycdJq9z8w3TgCEyJWiMrvtdIDUyk0Gfp8U2w+tK7Vq3esbEPHAZbxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-rXH3KQfWNfCFITKUHgz5VA-1; Sat, 10 Feb 2024 04:08:52 -0500
X-MC-Unique: rXH3KQfWNfCFITKUHgz5VA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C7FB83DDE2;
	Sat, 10 Feb 2024 09:08:51 +0000 (UTC)
Received: from hog (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C1132026D06;
	Sat, 10 Feb 2024 09:08:50 +0000 (UTC)
Date: Sat, 10 Feb 2024 10:08:49 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev, borisp@nvidia.com,
	john.fastabend@gmail.com
Subject: Re: [PATCH net 1/7] net: tls: factor out tls_*crypt_async_wait()
Message-ID: <Zcc9IShET__-G1ec@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207011824.2609030-2-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-06, 17:18:18 -0800, Jakub Kicinski wrote:
> Factor out waiting for async encrypt and decrypt to finish.
> There are already multiple copies and a subsequent fix will
> need more. No functional changes.
>=20
> Note that crypto_wait_req() returns wait->err
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


