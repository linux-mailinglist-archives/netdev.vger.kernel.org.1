Return-Path: <netdev+bounces-106957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A570918445
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAA3286CE4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D7D18734F;
	Wed, 26 Jun 2024 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlE9DOCw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0DD18A933
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412290; cv=none; b=c32mQheGQUU3Jc/se+spEcP7VV3HQxGvEq3fn/8K8gcUbhiRAQhfojqk6qGZCE0Q9wYSrPt40MCwRXDTwUvt9JoGg/ijs95rEQZ9EpGQgmspoRVj8w6szGX4ZjPHHVa6ee7Durbyj9WYKlJbND6EFq4vpGvzI8sCqRg+wChd3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412290; c=relaxed/simple;
	bh=JeS0VLtIHqHzguAD+J/WuRa62ph6abcgqSsalttRgOo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aFFGOtnOUjODjVah6dfK8DaJ/AOyeVAsfRQvpjPknJWLdg+fIoM9RRi9x/17Ujs5L/Ry4NkxVfU+3fj/oRRzZY+h0/J4/tEadqHdB/jfS02pJoLrYDpb5upgTxaNa5343GTqZ1tHnYQlAJiePdmCcwJV68SciJOEsGq0sdF3d8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlE9DOCw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719412287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JeS0VLtIHqHzguAD+J/WuRa62ph6abcgqSsalttRgOo=;
	b=DlE9DOCwmcbBMVAW33SEhKyJXsV7O78THXVvAn4q16OpNsek8jWWuNrtw4rKYt23p22JyK
	xwHeoFT7DdLdZ3j1X5ZLceL6d1hUcFkeGsAGFI6gqpD3QtW4nOuE9YpHAmisoT0dHfmU6t
	SB64m/Hk5PhToEyMBqLKI1x/bG8O4cQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-475-WcCNtfL_Mh27LDvmAy3dMA-1; Wed,
 26 Jun 2024 10:31:21 -0400
X-MC-Unique: WcCNtfL_Mh27LDvmAy3dMA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ADFF1955F16;
	Wed, 26 Jun 2024 14:31:18 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D59F1956050;
	Wed, 26 Jun 2024 14:31:15 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org,  echaudro@redhat.com,  horms@kernel.org,
  i.maximets@ovn.org,  dev@openvswitch.org,  Pravin B Shelar
 <pshelar@ovn.org>,  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Shuah Khan <shuah@kernel.org>,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 07/10] selftests: openvswitch: add
 emit_sample action
In-Reply-To: <20240625205204.3199050-8-amorenoz@redhat.com> (Adrian Moreno's
	message of "Tue, 25 Jun 2024 22:51:50 +0200")
References: <20240625205204.3199050-1-amorenoz@redhat.com>
	<20240625205204.3199050-8-amorenoz@redhat.com>
Date: Wed, 26 Jun 2024 10:31:14 -0400
Message-ID: <f7tfrszg4i5.fsf@redhat.com>
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

> Add sample and emit_sample action support to ovs-dpctl.py.
>
> Refactor common attribute parsing logic into an external function.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


