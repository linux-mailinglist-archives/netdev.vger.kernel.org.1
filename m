Return-Path: <netdev+bounces-67614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0908444B7
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 17:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE2A01C21559
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001BE12BEA3;
	Wed, 31 Jan 2024 16:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eMVo4ZdW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB7137702
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719478; cv=none; b=ozl8slimBYi+Hhr/7huYW99xEZVWEPJTH9Yt43J+k1YV0Q/mXgkwskY1dbx+h97WT/QzexmekkYiaLSNSxzrhaUYQldP+/ch8wrQfoB232+bAnmEWTShBsXQAiFxQ3Olq9rNvbnXdjzg4wBFt4UjebvlfDYCDk68d1BZvkp1OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719478; c=relaxed/simple;
	bh=Cvu0DIhuYA+aigtB5vEn9L4WmipBClGZCuLKOygUPsM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=MXrRMSGCZ4c6fmVvS/vkuos9/0xCbe2DmymseRpUhsACFN/9SIBNsZcE/qIDKuLG7r4VfleTlXsNuQIkSINJinijDq8qR0BK1WxBP20kvh3KuFge8Xq+yCowiHrslPW3i2ClSeAEnCXutbnwW4IaMuXK4h34uHLvv2opMD+d564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eMVo4ZdW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706719475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cfsQIbJAPyfrnawYlf3IhHhMNM/4DIn/icL/D01AzJc=;
	b=eMVo4ZdWUY9ldjeAYzxxvz6FSWOJW9EVtMDiewuQj1s0/gonGjoejNjulma28lyTGYzUJq
	Bqk8m4W3e+J6NqH8JQh7NP3Y5zhKguCPKF2I/cfB195x3oP1qzzlZYOtc5uoYVrkYa8Ewt
	4MVRgd7ny8B30n+wgPDmG9RKMnnozas=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-PlsAS4AvMESnmbmO1I-a9A-1; Wed, 31 Jan 2024 11:44:31 -0500
X-MC-Unique: PlsAS4AvMESnmbmO1I-a9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA275185A787;
	Wed, 31 Jan 2024 16:44:30 +0000 (UTC)
Received: from RHTPC1VM0NT (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C504D1121306;
	Wed, 31 Jan 2024 16:44:29 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Brad Cowie <brad@faucet.nz>
Cc: netdev@vger.kernel.org,  pshelar@ovn.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  shuah@kernel.org,  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: openvswitch: Test ICMP related
 matches work with SNAT
References: <20240131040822.835867-1-brad@faucet.nz>
Date: Wed, 31 Jan 2024 11:44:29 -0500
In-Reply-To: <20240131040822.835867-1-brad@faucet.nz> (Brad Cowie's message of
	"Wed, 31 Jan 2024 17:08:22 +1300")
Message-ID: <f7tcythmp02.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Brad Cowie <brad@faucet.nz> writes:

> Add a test case for regression in openvswitch nat that was fixed by
> commit e6345d2824a3 ("netfilter: nf_nat: fix action not being set for
> all ct states").
>
> Link: https://lore.kernel.org/netdev/20231221224311.130319-1-brad@faucet.nz/
> Link: https://mail.openvswitch.org/pipermail/ovs-dev/2024-January/410476.html
> Suggested-by: Aaron Conole <aconole@redhat.com>
> Signed-off-by: Brad Cowie <brad@faucet.nz>
> ---

I tested this on a patched kernel and as well as an unpatched kernel and
got the following:

6.5.5-200: TEST: ip4-nat-related: ICMP related matches work with SNAT          [FAIL]
6.7.0    : TEST: ip4-nat-related: ICMP related matches work with SNAT          [ OK ]

Thanks for adding the test case!

Tested-by: Aaron Conole <aconole@redhat.com>
Acked-by: Aaron Conole <aconole@redhat.com>


