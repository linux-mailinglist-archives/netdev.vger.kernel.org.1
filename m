Return-Path: <netdev+bounces-211016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5CB1630D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 16:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53051AA1674
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCAA298CA6;
	Wed, 30 Jul 2025 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6/98hR3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869B182D0
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753886734; cv=none; b=KsXCEY1rsMF6IdH4wnhklPc8ji3pDJMqkVc1cE1cb0+h/p2iYUrcDeAGCKwfLCoj2uP4mMS92IQpCtCIssU1xRb4nZt9yRETEl5g/LmVJzAykwywJO/ovT9w9vqAxxbGDdfWZbYirraK3bViZpMjm2/143S1UA2phuMyyquGbRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753886734; c=relaxed/simple;
	bh=j7nDqxHyZYTkqB1KwFxAlexFgL1tW3GFt1tSPav6KnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMBhLfiE7W/HBA8bcoSryq33PUpx1WHwgdgqlHpYz6/sZTqozj8jqkFtyRaU/XHHfTnpq4R2biSUqVktN6NVYmPhVdmFpVCZyMpzhSob4soh9t2rw0J20U9PqO6dpHtYrV4Ec7TNVH7kGTM4cAer1VJIH2NocsPnTFJAtpuqoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6/98hR3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753886732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B5Jm1I5ZVNzFM2GbtPesvTUdsdvn+BhVHySRQ8Ex2NI=;
	b=T6/98hR3JkjboiF95SNV142dfLpMoF4xy+y854bDu5kx9V5d57yzOB2tuXqt+mdg4d9Mjv
	qbBlOC8kx+kuM61diyOopIFutD4E1aeW/BIBWeZkSb4+Ii5j0PqY05LdXKiK9JsnEOiaxX
	+a1VV0fPLm8f7biHv8y3MZwJDYUng0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-ECXW_u5hO_emNiKKbEKfPw-1; Wed,
 30 Jul 2025 10:45:28 -0400
X-MC-Unique: ECXW_u5hO_emNiKKbEKfPw-1
X-Mimecast-MFC-AGG-ID: ECXW_u5hO_emNiKKbEKfPw_1753886726
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9624D1800873;
	Wed, 30 Jul 2025 14:45:25 +0000 (UTC)
Received: from [10.45.226.74] (unknown [10.45.226.74])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5131C1800D88;
	Wed, 30 Jul 2025 14:45:19 +0000 (UTC)
Message-ID: <6b8281b3-a438-4b3e-a8e7-d5043416d421@redhat.com>
Date: Wed, 30 Jul 2025 16:45:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [RFC PATCH] net: add net-device TX clock source
 selection framework
To: Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me,
 almasrymina@google.com, asml.silence@gmail.com, leitao@debian.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
References: <20250729104528.1984928-1-arkadiusz.kubalewski@intel.com>
 <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <p4tnkuf3zh7ja45d4y2pas6fj6epbqdqdqtfai2vmyul3n43lf@v3e5dvvbphiv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 30. 07. 25 2:26 odp., Jiri Pirko wrote:
> Tue, Jul 29, 2025 at 12:45:28PM +0200, arkadiusz.kubalewski@intel.com wrote:
> 
> [...]
> 
>> User interface:
>> - Read /sys/class/net/<device>/tx_clk/<clock_name> to get status (0/1)
>> - Write "1" to switch to that clock source
> 
> I wonder, if someone invented a time machine and sent me back to 2005...
> 
> [...]
> 
+1
why do we have netlink based interfaces for configuration...?

Wouldn't be better to implement such thing to be configurable via ip
link or ethtool??

E.g.
ip link set eth0 tx-clk <clock_name>

--or--
ethtool --set-tx-clk/--show-tx-clk eth0 <clock_name>

Ivan


