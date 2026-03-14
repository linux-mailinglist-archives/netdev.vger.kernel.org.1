Return-Path: <netdev+bounces-267729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LAXGYRPtWm8zAAAu9opvQ
	(envelope-from <netdev+bounces-267729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:07:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0B328D01B
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 13:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D98030215B9
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9AF92D239B;
	Sat, 14 Mar 2026 12:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ofEjNCko"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF80C54654;
	Sat, 14 Mar 2026 12:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773490047; cv=none; b=Frq7rKaFPhV3JKyIpaWIDU8DUmug4gHVMUWpmYI79n0hSjvkKxVa+2VWEZZ+7Djo0KJ8MOJyrtXd2qrL5JU2YMVDFIFtz57kcZEWlyX+T6g3sSpKrcOVuBUaRKU+7i7/JPRhWFFpc5SK2x0Qhbt3QVXzChK/+2TFexK8kYHpLZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773490047; c=relaxed/simple;
	bh=bvfzV8Sre4mFmTho24ttj3Jy1kwnBsRATL+DN4YjfTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0b4rZFI48FE2Pzyp9hIYZlrGHDNFKhq4pmuBbNGpAj8HXV6OGFTquvge8V8Cqzb3I4ztDKeUOwXr8bz7GR9aRSJenxHkbtg0llMH1aMaqEjkXHrBxFcCwblM7p6TdzvAoNcH/CPu8FkWS3tlNZsGzRcjr/W6OpCTdnLZA/nCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ofEjNCko; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=wz13B4P0oxOnE5PgYFJx/1A66vFD0+GUuQo6f3vlveo=;
	b=ofEjNCkoUeQnVw2ckIORDhW2/TVkWonQvx92QWvBHoBaab583E/UOJs8VXgwHk
	RNIyjYl6ZlW3KzXCkAdyuVQdQn4iKuPnib+1wuox6ELGTd9fkQjfc6fxN9bk1pjR
	7yZxohsZnpu1TPe1AkL28utF8tcPuRO31YQlLk8gaARqs=
Received: from [10.54.29.130] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wDnTagBT7VpzzbdAg--.57S2;
	Sat, 14 Mar 2026 20:05:24 +0800 (CST)
Message-ID: <2ea3873a-c06a-4049-9be8-e3dc487871bc@163.com>
Date: Sat, 14 Mar 2026 20:05:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] team: fix header_ops type confusion with
 non-Ethernet ports
To: Eric Dumazet <edumazet@google.com>, Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+3d8bc31c45e11450f24c@syzkaller.appspotmail.com,
 Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260314062306.212765-1-jiayuan.chen@linux.dev>
 <CANn89iJR9bjtoZGsybdpX6T4rg1+kzXL0qV00Bs_Fiduf_+2zw@mail.gmail.com>
 <CANn89iJwZfWtGrQw+hA9DumTuYKZm5MLh8O7nkz9mPCHHazUWw@mail.gmail.com>
 <bacc7c58-b6d5-4566-bd6a-b83a2a25c596@linux.dev>
 <CANn89iLp8eaAj4Qtu4dvGeh9zEw+aQFe=n2dMd-zs4n-cjV4QQ@mail.gmail.com>
 <d2f9bd52-f570-441b-b3aa-570cc7f37d0c@linux.dev>
 <CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com>
From: Jiayuan Chen <mrpre@163.com>
In-Reply-To: <CANn89iK2EURqsjtd=OVP4awYTJHGcR-UU-V9WovpWR1Z3f03oQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTagBT7VpzzbdAg--.57S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2eMNUUUUU
X-CM-SenderInfo: xpus2vi6rwjhhfrp/xtbC7AScRGm1TwQzEgAA3G
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267729-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrpre@163.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[163.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,3d8bc31c45e11450f24c];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[163.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email]
X-Rspamd-Queue-Id: BE0B328D01B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/14/26 7:53 PM, Eric Dumazet wrote:
> On Sat, Mar 14, 2026 at 12:51 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>> Thanks for the quick patch.
>>
>> I also verified it fixes the recursion issue after modifying all signatures.
> Could you turn your test in an official patch for  tools/testing/selftests ?
>
> Thanks !


I will send a selftest for this to the net tree if this patch hasn't 
been merged to net-next yet.


