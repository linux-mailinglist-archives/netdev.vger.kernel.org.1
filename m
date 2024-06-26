Return-Path: <netdev+bounces-106947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31499183D1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0ED1F23688
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49058185E46;
	Wed, 26 Jun 2024 14:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jBc/CaMl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70A21822C2
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411692; cv=none; b=kSRbDALA2QTdJHC5UqTviR15fzjjsdZJVQ00ZOU06LwO74tBYhLVveVxDfMYep0vCUyh1JEq04qkTYLF6Zp3X6eUuKemoxjCf+P+oPxpa5ROm7SOdOrQgOSxu+Fh4/NHLjd0z6v5H6BjlGyA5X68yg9fhTGHIX4lJY1IRWpaKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411692; c=relaxed/simple;
	bh=oR3F/W/MhqxgF6KdvLr27G1cva2slW9w0ZRA+4kSBko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Qxz62qgUNvjL7vwDnMHjsnv5nwX/g2GHtcV4HTjrJOPYuzT2yid/YVX17Bd+vQiRQ9X8FGvEZIDMSyiQvCauByKgLX7UUltfbbLfkqm/Fru72nZFBNvFtSqTuLgjPh2MLNJ7HCR5f9ulS/RLmOMxCaxzmAAZOJdq7M/FkyAj5Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jBc/CaMl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719411689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oR3F/W/MhqxgF6KdvLr27G1cva2slW9w0ZRA+4kSBko=;
	b=jBc/CaMlyg3tk4nhPuZNDcOFi4adLS7Lirvv1MnA83w9QW5uxBqG0U9ccAaWx8BuJIDmEE
	BWRViogyZezvF1hxd3i9q/cxfY8BtdsXgtJ8lwFW8SNf6T99qaScvdVhCD1vuzdtn0cMxG
	wM6g+xHpWa2oZo+1B9XsUzx1FllhWyk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613--HI60PISOwSDnuPHIuoz4Q-1; Wed,
 26 Jun 2024 10:21:26 -0400
X-MC-Unique: -HI60PISOwSDnuPHIuoz4Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 785DA19560BD;
	Wed, 26 Jun 2024 14:21:24 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B77D71956050;
	Wed, 26 Jun 2024 14:21:21 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/10] selftests: openvswitch: parse trunc
 action
In-Reply-To: <20240625205204.3199050-10-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 25 Jun 2024 22:51:52 +0200")
References: <20240625205204.3199050-1-amorenoz@redhat.com>
	<20240625205204.3199050-10-amorenoz@redhat.com>
Date: Wed, 26 Jun 2024 10:21:20 -0400
Message-ID: <f7tjzibg4yn.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Adrian Moreno <amorenoz@redhat.com> writes:

> The trunc action was supported decode-able but not parse-able. Add
> support for parsing the action string.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


