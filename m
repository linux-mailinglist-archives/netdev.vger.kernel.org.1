Return-Path: <netdev+bounces-117082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35AC94C967
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 06:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26215B21D24
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 04:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6170516631C;
	Fri,  9 Aug 2024 04:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b="VKA84KU1"
X-Original-To: netdev@vger.kernel.org
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76CE747F;
	Fri,  9 Aug 2024 04:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.61.200.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723179047; cv=none; b=Dh0ak833NVKcvJaGgJoPNn+ExZW+xW0U461ElMgw9LJc2rm1QKLfe5zq7qpp4l1uwxrGoOdqni2AU9ZbXDYLp+rxaKWMpURVu8LZUOfQ9gFQxF2HOQzVB8/ieYFoYzHg694aT2GDp+6D2htiZYSy0WOe7dEV9HVtN+oGmnTwUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723179047; c=relaxed/simple;
	bh=bugJFlr5qOdWb5nm42v3w20M4o7unIcV2116RZSa5VE=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=XKeacRuYyOXDad9MKGFaGvT241hvQ5OF4I7QtMdfu/n8vIfuAHpxznQSHu8E+1Xgf2ey6O5DoFMSaXQ2Af/SUlo3qZRLYD8sxpGTsqfMHYM0Y7AYnWernSnyDgafKdqPaKc1in+B9aEWCSrZCLk3NR0HvMErGm6a+fOzJd/3NEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info; spf=pass smtp.mailfrom=soulik.info; dkim=pass (1024-bit key) header.d=soulik.info header.i=@soulik.info header.b=VKA84KU1; arc=none smtp.client-ip=108.61.200.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulik.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulik.info
Received: from smtpclient.apple (unknown [199.33.119.15])
	by kozue.soulik.info (Postfix) with ESMTPSA id ADEA92FE4ED;
	Fri,  9 Aug 2024 13:51:20 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 kozue.soulik.info ADEA92FE4ED
Authentication-Results: kozue.soulik.info; dmarc=fail (p=reject dis=none) header.from=soulik.info
Authentication-Results: kozue.soulik.info; spf=fail smtp.mailfrom=soulik.info
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info ADEA92FE4ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
	t=1723179080; bh=krt+Vl+YkrzxJSaYFZHjanrtZYNGcVulMlBUawPyqr0=;
	h=From:Subject:Date:Cc:To:From;
	b=VKA84KU1RPhqlITCXQjQvYxgZmGEtZWAa90qPkc90AY/IwNKI1ePLh+A6/9kRxVaX
	 DdaPwj/muVS6bm9O1h2IjVrd4GI+ap4XA87bjZjWbkT6rn1lkHbSsSrjGNWnq/i2nq
	 ruMDSkOALdAsucxCy6GW7zI0VknH00DgJe24MAQc=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: ayaka <ayaka@soulik.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [PATCH] net: tuntap: add ioctl() TUNGETQUEUEINDX to fetch queue index
Message-Id: <638F310E-3FDA-4388-9950-1F3A56C6DEFB@soulik.info>
Date: Fri, 9 Aug 2024 12:50:31 +0800
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
X-Mailer: iPad Mail (21A351)

=EF=BB=BF
Sent from my iPad

> On Aug 9, 2024, at 2:49=E2=80=AFAM, Willem de Bruijn <willemdebruijn.kerne=
l@gmail.com> wrote:
>=20
> =EF=BB=BF
>>> So I guess an application that owns all the queues could keep track of
>>> the queue-id to FD mapping. But it is not trivial, nor defined ABI
>>> behavior.
>>> Querying the queue_id as in the proposed patch might not solve the
>>> challenge, though. Since an FD's queue-id may change simply because
>> Yes, when I asked about those eBPF thing, I thought I don=E2=80=99t need t=
he queue id in those ebpf. It turns out a misunderstanding.
>> Do we all agree that no matter which filter or steering method we used he=
re, we need a method to query queue index assigned with a fd?
>=20
> That depends how you intend to use it. And in particular how to work
> around the issue of IDs not being stable. Without solving that, it
> seems like an impractical and even dangerous -because easy to misuse-
> interface.
First of all, I need to figure out when the steering action happens.
When I use multiq qdisc with skbedit, does it happens after the net_device_o=
ps->ndo_select_queue() ?
If it did, that will still generate unused rxhash and txhash and flow tracki=
ng. It sounds a big overhead.
Is it the same path for tc-bpf solution ?

I would reply with my concern about violating IDs in your last question.
>>> another queue was detached. So this would have to be queried on each
>>> detach.
>> Thank you Jason. That is why I mentioned I may need to submit another pat=
ch to bind the queue index with a flow.
>> I think here is a good chance to discuss about this.
>> I think from the design, the number of queue was a fixed number in those h=
ardware devices? Also for those remote processor type wireless device(I thin=
k those are the modem devices).
>> The way invoked with hash in every packet could consume lots of CPU times=
. And it is not necessary to track every packet.
>=20
> rxhash based steering is common. There needs to be a strong(er) reason
> to implement an alternative.
I have a few questions about this hash steering, which didn=E2=80=99t reques=
t any future filter invoked:
1. If a flow happens before wrote to the tun, how to filter it?
2. Does such a hash operation happen to every packet passing through?
3. Is rxhash based on the flow tracking record in the tun driver?
Those CPU overhead may demolish the benefit of the multiple queues and filte=
rs in the kernel solution.
Also the flow tracking has a limited to 4096 or 1024, for a IPv4 /24 subnet,=
 if everyone opened 16 websites, are we run out of memory before some entrie=
s expired?

I want to  seek there is a modern way to implement VPN in Linux after so man=
y features has been introduced to Linux. So far, I don=E2=80=99t find a prop=
er way to make any advantage here than other platforms.
>> Could I add another property in struct tun_file and steering program retu=
rn wanted value. Then it is application=E2=80=99s work to keep this new prop=
erty unique.
>=20
> I don't entirely follow this suggestion?
>=20
>>> I suppose one underlying question is how important is the mapping of
>>> flows to specific queue-id's? Is it a problem if the destination queue
>>> for a flow changes mid-stream?
>> Yes, it matters. Or why I want to use this feature. =46rom all the open s=
ource VPN I know, neither enabled this multiqueu feature nor create more tha=
n one queue for it.
>> And virtual machine would use the tap at the most time(they want to emula=
te a real nic).
>> So basically this multiple queue feature was kind of useless for the VPN u=
sage.
>> If the filter can=E2=80=99t work atomically here, which would lead to unw=
anted packets transmitted to the wrong thread.
>=20
> What exactly is the issue if a flow migrates from one queue to
> another? There may be some OOO arrival. But these configuration
> changes are rare events.
I don=E2=80=99t know what the OOO means here.
If a flow would migrate from its supposed queue to another, that was against=
 the pretension to use the multiple queues here.
A queue presents a VPN node here. It means it would leak one=E2=80=99s data t=
o the other.
Also those data could be just garbage fragments costs bandwidth sending to a=
 peer that can=E2=80=99t handle it.=

