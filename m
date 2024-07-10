Return-Path: <netdev+bounces-110534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6892992CE5F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0334FB26300
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178F718FA04;
	Wed, 10 Jul 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="J77iF5lc"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B3127B56
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604481; cv=none; b=RIomGI3K0UXMlNg/RrCE+GYA2pGZOylQ+r53vGkSXevorNkaELZk9qTH7i37qoBuYQSwr2YJ+7L+uhqpjo2HZ6wM4wGS66pJQflKKRtZsY+sE76SIZeSRgf3xC5InaCv+O4USw7T9voIslScTGki4VHBOTRf/6zaWOyOVwuJxKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604481; c=relaxed/simple;
	bh=eUE6Ovjo+J3YBbxTCCz3RUWZwwvuP7N5wzKphVKzjo0=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=NBVPe3O+YbLUSoNBGmxvMwC8sE7c0iqT6NhxeX/yRrocp0V1BnPYkRSOh5TEeEClct83E0VB2MJItJber0BF6uHOaKlbWhFnmV4vM07kwTmauMXexKVmxrLA0vpkCta0u+Voy15FJEjxD3MMou8x4yCozMQk4ZhOR3VVil412ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=J77iF5lc; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from smtpclient.apple (unknown [124.74.246.114])
	by kozue.soulik.info (Postfix) with ESMTPSA id 9F2302FE41D
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 18:41:22 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 kozue.soulik.info 9F2302FE41D
Authentication-Results: kozue.soulik.info; dmarc=fail (p=reject dis=none) header.from=soulik.info
Authentication-Results: kozue.soulik.info; spf=fail smtp.mailfrom=soulik.info
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 9F2302FE41D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1720604485; bh=eUE6Ovjo+J3YBbxTCCz3RUWZwwvuP7N5wzKphVKzjo0=;
	h=From:Date:Subject:To:From;
	b=J77iF5lclfuCZYW1JbZoLiH2YBGsq26t/EzVUQkrwUQ+srHZX6YuWlv+brZp0MEvd
	 TedbCFQkXifcC+g3G6MtCIkcOrW6qNgo/byzuvd9sAbrL/I8paBDDzDB2QPzH5cmdQ
	 PuPVxiwJcMa44ieTD6GfEf1zR/aLk0kgMSAzziro=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: ayaka <ayaka@soulik.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Wed, 10 Jul 2024 17:40:46 +0800
Subject: tun: need an ioctl() cmd to get multi_queue index?
Message-Id: <FABA3A61-3062-4AC6-94D8-7DF602E09EC3@soulik.info>
To: netdev@vger.kernel.org
X-Mailer: iPad Mail (21A351)

Hello All

I have read some example that filter packet with tc qdisc. It could a very u=
seful feature for dispatcher in a VPN program.
But I didn=E2=80=99t find an ioctl() to fetch the queue index, which I belie=
ve is the queue number used in tc qdisc.
There is an ioctl() which set the ifindex which would affect the queue_index=
 storing in the same union. But I don=E2=80=99t think there is an ioctl() to=
 fetch it.

If I was right, could I add a new ioctl() cmd for that?

Sincerely
Randy=

