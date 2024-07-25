Return-Path: <netdev+bounces-112918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B0693BD45
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1A61C21503
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F95016F8EF;
	Thu, 25 Jul 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="3SobZUtl"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25B615FA72
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893467; cv=none; b=VwV1kVLnnzv3LNJ+vSqFrXXswto63bhL86awper4vB7LoEZ7ZG7zwZ0lW14YB45Fx7+JHULjNCMXl3an3ckOYqBBgETpRRq6D1FwdZBBGWda8wuCQ9T+xblFsLmB6dMz7Qmp3QLlyOo5FgJXVpqtDP/PHQWv8nBlob4DGMDvYt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893467; c=relaxed/simple;
	bh=ghUE9jxQtyL6a4bP38s7WHXwYlKVG8wVw6pfkCIyOJM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=SghoYV0LqoX4X8HTIuNIcQ3dxw3VgVxvdpc9gqho1/qn4tvMi6GcJdB+CBkMdL7h/cfPzlxb2UQ24BnbZCtLZ/PrDEpN4UixRDNq6INzVdzjNPnVViMbqEjKhbIfyoRjlgzf8gJwG71YA5E14RNW0f8soz53Im77XynYxp4XgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=3SobZUtl; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from [IPV6:2a02:8010:6359:2:e181:9992:7c46:d034] (unknown [IPv6:2a02:8010:6359:2:e181:9992:7c46:d034])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 8208C7DA34;
	Thu, 25 Jul 2024 08:44:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721893458; bh=ghUE9jxQtyL6a4bP38s7WHXwYlKVG8wVw6pfkCIyOJM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:From;
	z=Message-ID:=20<dd7fd63c-3d7d-1c47-d8ae-1ff4d6f65221@katalix.com>|
	 Date:=20Thu,=2025=20Jul=202024=2008:44:18=20+0100|MIME-Version:=20
	 1.0|To:=20Simon=20Horman=20<horms@kernel.org>|Cc:=20netdev@vger.ke
	 rnel.org,=20davem@davemloft.net,=20edumazet@google.com,=0D=0A=20ku
	 ba@kernel.org,=20pabeni@redhat.com,=20dsahern@kernel.org,=20tparki
	 n@katalix.com|References:=20<cover.1721733730.git.jchapman@katalix
	 .com>=0D=0A=20<be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.1721733730
	 .git.jchapman@katalix.com>=0D=0A=20<20240724163316.GC97837@kernel.
	 org>|From:=20James=20Chapman=20<jchapman@katalix.com>|Subject:=20R
	 e:=20[RFC=20PATCH=2001/15]=20l2tp:=20lookup=20tunnel=20from=20sock
	 et=20without=20using=0D=0A=20sk_user_data|In-Reply-To:=20<20240724
	 163316.GC97837@kernel.org>;
	b=3SobZUtlZYmF1XDAGzg2oZRbVSXDJEsq+tQQjuX3XK5yCqt8oJB8EhUK41+da8Hjc
	 SfIgeq+0BPUEP/zyJPQUhcZBow9wdSbhYfA5477gVdi5MEUO9ndKr5LiJ6NOKrCp1S
	 LNmxavzeOrdUg0bfrtoASprKY4VIYsEM5GGsnXP3emizhoI5tcGlDdQ5iiofYFdo0t
	 EX86o1RvUR/3l21XX88cZH053c64Y052Hs1z4RwTk7K3RMW26er1iRm0AQXbFxGdGd
	 D8VSXDE/ovwO57MwMZ5mddW1rkXEYti0OciaWvVYtVJhU/l9cxED67HjgOQZc6xAuT
	 7xLFktCk1ug2A==
Message-ID: <dd7fd63c-3d7d-1c47-d8ae-1ff4d6f65221@katalix.com>
Date: Thu, 25 Jul 2024 08:44:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, tparkin@katalix.com
References: <cover.1721733730.git.jchapman@katalix.com>
 <be825ed1ae6e5756e85dbae8ac0afc6c48ce86fb.1721733730.git.jchapman@katalix.com>
 <20240724163316.GC97837@kernel.org>
Content-Language: en-US
From: James Chapman <jchapman@katalix.com>
Organization: Katalix Systems Ltd
Subject: Re: [RFC PATCH 01/15] l2tp: lookup tunnel from socket without using
 sk_user_data
In-Reply-To: <20240724163316.GC97837@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2024 17:33, Simon Horman wrote:
> On Tue, Jul 23, 2024 at 02:51:29PM +0100, James Chapman wrote:
>> l2tp_sk_to_tunnel derives the tunnel from sk_user_data. Instead,
>> lookup the tunnel by walking the tunnel IDR for a tunnel using the
>> indicated sock. This is slow but l2tp_sk_to_tunnel is not used in
>> the datapath so performance isn't critical.
>>
>> l2tp_tunnel_destruct needs a variant of l2tp_sk_to_tunnel which does
>> not bump the tunnel refcount since the tunnel refcount is already 0.
>>
>> Change l2tp_sk_to_tunnel sk arg to const since it does not modify sk.
> 
> nit: This needs a Signed-off-by line

I thought Signed-off-by tags weren't necessary for RFC patches. I'll add 
them when I resubmit the series when netdev reopens.

Thanks for looking at the patches.


