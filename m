Return-Path: <netdev+bounces-70748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A4D85039C
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 10:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517151F2224B
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 09:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586A133CE7;
	Sat, 10 Feb 2024 09:12:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD62A33CF1
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707556348; cv=none; b=r30kMBol3lozBJDnpzeP6Z82kz7aVh7gVnSXEmYEpPDltYvg1NckUypehQKcgb0pdaT3o/U0bf0UjY5X8Ex6or8gpoojv+Opk+kG/iU6swYPTLS4VuzPmu/HI3lMeDE9roaFYoFeKwtuGQ4aLeOvfllXEqiQXekbtezb534BYtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707556348; c=relaxed/simple;
	bh=HYGP5mjbpYFgrr/oSZdGq+kO3RfBNMDnvPVKkGsEils=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C/bfpaiWzYgwvL1FVyhWO0OSl5aIMpifUmrzLX/NtAecZPVRzde4sA3fhSNt3ryCFmYYuCUftk7rZfeAp4Edc1LZJIbROX8QgAgbbkZpjRewy8kYfMkVT+M7pjhWhAq4tEUoE0qzOnSDi9/eYM/NMR+WqtKBuSQ3cOnqVB8/ZF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-534-XESgFBExNpuMOIBlnRVDHw-1; Sat,
 10 Feb 2024 04:12:19 -0500
X-MC-Unique: XESgFBExNpuMOIBlnRVDHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6C9329AA2D5;
	Sat, 10 Feb 2024 09:12:18 +0000 (UTC)
Received: from hog (unknown [10.39.192.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5DED7112131D;
	Sat, 10 Feb 2024 09:12:17 +0000 (UTC)
Date: Sat, 10 Feb 2024 10:12:16 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, vadim.fedorenko@linux.dev,
	valis <sec@valis.email>, borisp@nvidia.com,
	john.fastabend@gmail.com, vakul.garg@nxp.com
Subject: Re: [PATCH net 3/7] tls: fix race between tx work scheduling and
 socket close
Message-ID: <Zcc98OzR1YIwZJfY@hog>
References: <20240207011824.2609030-1-kuba@kernel.org>
 <20240207011824.2609030-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240207011824.2609030-4-kuba@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-02-06, 17:18:20 -0800, Jakub Kicinski wrote:
> Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
> may exit as soon as the async crypto handler calls complete().
> Reorder scheduling the work before calling complete().
> This seems more logical in the first place, as it's
> the inverse order of what the submitting thread will do.
>=20
> Reported-by: valis <sec@valis.email>
> Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of record=
s for performance")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

--=20
Sabrina


