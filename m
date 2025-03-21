Return-Path: <netdev+bounces-176739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114BCA6BCB2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 15:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 177C03AB490
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 14:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C28198E8C;
	Fri, 21 Mar 2025 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKT3kc+1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B277158DD8
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742566516; cv=none; b=IW01Tltu6ygXHG45cfVWWKF3RObwLzEmCkc5LRQuL8rIiycCGEBCGxXrHAhejtZxTcHcsFQha61crjTVj/3Yhu14QjHJvKCItnsy1nVFLXWxOyVhld6ju/QErJfwb5dyD/4MXSiRX+HFRalfcp8SFzNVIK2HrmrT6cHbJuJwIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742566516; c=relaxed/simple;
	bh=z18fggC1AT+OqkUpeXzyr7bC3BcfvEZXdNx5Aew/SnU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iX0xlpfxeN1svgOJq9GMHPJRLtrjsKaf+t72UaYL4QdA4vBdGSBiUqHJ/a8Q1qSdKlc0TSkro83+cQiJmbNMPnmgj1/xcNu30x9o6Mm4D4oWI2/4pS/5qeUZg+JiDeTqbcPcw7cgl7dxq4DFxSbqhuAzFqcPDgwv5grc6xSx14w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKT3kc+1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742566514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B94vvoxG/EXTJQEwrJJTrcHrrpq9ebvbA5mjkWRhaZM=;
	b=UKT3kc+10HmOipgagxNObLa2ir4GzlnZtfseswgPxVed3ZHCnfcp0p2HXZEYfKRMkKFZNz
	OCx05GEWW4zYVzmk3JmwJ8Eb9+6KIeQgSUI9ORkg6jzAgBVzQ6VWmoAFBwMxYMJBSs1io/
	gZiHIYfms6gdD+7fMd7Czf6IyA2U8Rw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-451-lUpplgm9OM6cYXfiFMU4pA-1; Fri,
 21 Mar 2025 10:12:56 -0400
X-MC-Unique: lUpplgm9OM6cYXfiFMU4pA-1
X-Mimecast-MFC-AGG-ID: lUpplgm9OM6cYXfiFMU4pA_1742566374
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64E27196D2CC;
	Fri, 21 Mar 2025 14:12:54 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.65.176])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B90519560AF;
	Fri, 21 Mar 2025 14:12:51 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  dev@openvswitch.org,  linux-kernel@vger.kernel.org,  Pravin B Shelar
 <pshelar@ovn.org>,  Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: fix kernel-doc warnings in
 internal headers
In-Reply-To: <20250320224431.252489-1-i.maximets@ovn.org> (Ilya Maximets's
	message of "Thu, 20 Mar 2025 23:42:07 +0100")
References: <20250320224431.252489-1-i.maximets@ovn.org>
Date: Fri, 21 Mar 2025 10:12:49 -0400
Message-ID: <f7ttt7mv5em.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Ilya Maximets <i.maximets@ovn.org> writes:

> Some field descriptions were missing, some were not very accurate.
> Not touching the uAPI header or .c files for now.
>
> Formatting of those comments isn't great in general, but at least
> they are not missing anything now.
>
> Before:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   16
>
> After:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   0
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


