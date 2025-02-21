Return-Path: <netdev+bounces-168467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9CA3F192
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 11:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7A93BC7E3
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8741204F6B;
	Fri, 21 Feb 2025 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LH5iw/sQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D824204596
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132865; cv=none; b=cDqwbtzxlHlGJr4IMKE2Gda5n6jbyG7CTkVm2rvEkc8c2ZEUuJ0zq2sBsyuwzl8yteXG2au5rD5qN8lrHC3pnBc01yE0emPyIiPC+Oh2DrUGBWyaAfe6lvuFrYgxJZBVH61oKtwdOLV4sxUwXXliL9q3ixyF58wJQ4ffXPJSVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132865; c=relaxed/simple;
	bh=Eu/x4XndsveWMgImNw4I38vkpeo92azgy642kuC5mBY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=LnREPOe9x+8YH04E67TY5VMpBGJMdVWH4oKISguPT2vgXj7LywIGmz0o8oAtXjJTjF4Z7Qs4Bju9nazxbWVKYzHzbrFwMuy2zQ2S+c5tHkSBdxrN7YDW9D2A4/7uQJiBIA2oH8gR6/FtBGKKU+cSHJb8i6VFRV2HPfpRoZR1R2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LH5iw/sQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740132863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h8pwT7itBDINz07ZIoG1R3aQGPqT12o5jQdj8aDxwjQ=;
	b=LH5iw/sQ08KVba/zUovEvU6QyhuPK5tH16Vs+LgIh3D9QGfnxO2aeFDQZpO3rLx0LgXwx8
	rlrrHjUFsVP1hrg0OAAbh6fBpVQumqbLHKftwxqNYLCPK/HedEno63EqkGkNNa4ivt8Z/Q
	+idZErwMdQRExM5YrFtIuVqsqDb4jAk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-gJ4eZLWAOFqJfZPm2A2l_w-1; Fri,
 21 Feb 2025 05:14:19 -0500
X-MC-Unique: gJ4eZLWAOFqJfZPm2A2l_w-1
X-Mimecast-MFC-AGG-ID: gJ4eZLWAOFqJfZPm2A2l_w_1740132858
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C5EE19039C1;
	Fri, 21 Feb 2025 10:14:18 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.32.29])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0A7D819412A3;
	Fri, 21 Feb 2025 10:14:14 +0000 (UTC)
Date: Fri, 21 Feb 2025 11:14:11 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
    "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
In-Reply-To: <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
Message-ID: <d433a173-27cc-5ee9-4d00-133153dd44ef@redhat.com>
References: <bd55c0d5a90b35f7eeee6d132e950ca338ea1d67.1739895412.git.pablmart@redhat.com> <20250220165401.6d9bfc8c@kernel.org> <c36c6de0-fc01-4d8c-81e5-cbdf14936106@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Fri, 21 Feb 2025, Paolo Abeni wrote:
> On 2/21/25 1:54 AM, Jakub Kicinski wrote:
>> Why not increase the test duration then?
>
> I gave this guidance, as with arbitrary slow machines we would need very
> long runtime. Similarly to the packetdril tests, instead of increasing
> the allowed time, simply allow xfail on KSFT_MACHINE_SLOW.

I have resubmitted a properly versioned and tagged patch (and with the 
right title as indeed it does not increase the netperf session duration) at:

https://lore.kernel.org/netdev/23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com/

In that patch the Fixes: commit, found by Paolo, was when the duration 
moved from the netperf default (10 seconds) to 1 second. As he mentions 
even with 10 seconds it is not guaranteed that in slow systems and/or 
under load the test will not fail, hence the skip/xfail


