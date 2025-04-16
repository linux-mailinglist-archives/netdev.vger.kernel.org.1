Return-Path: <netdev+bounces-183108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F792A8AE45
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 04:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4448A17E73A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784D7482EF;
	Wed, 16 Apr 2025 02:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA81624C2
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744771519; cv=none; b=pmCzozzDKvdcBomDPzjQ+V+SSxiqKVvIhG5GTnP7kZDz0/CmXO+okbie//+BbUPK70YnOk6re/vtxCgR3K/qHblqUqZpO5w+0yxHo36rhZyJ4P01eos7BiF8xIU6k6fku3hILTn3SNRGjlEca/oGyfhubQyHmMmYRhBZs3gkwYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744771519; c=relaxed/simple;
	bh=jGCETIjtf5pJJS4mA3WzvUDvfKVBDSoZgm9UJWUD1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+cBILX+GcG0Il2yuqerOaifhFfkDfdDBDPL9BdenowSCcrbGpKgtIkqgizfS3gALXN1f4j0ytMXZRvEK7yOZfLRLJqt0EdyVFlJfYRlj4kHL0hTUpcDDESJfdHHtJIC+st6kjAmKK0s+X9CRbGZfVGS9qTZcWnyrF+2RmenCrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-05 (Coremail) with SMTP id zQCowAC39g6wGf9nHvdECQ--.22403S2;
	Wed, 16 Apr 2025 10:45:06 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: kuba@kernel.org
Cc: chenyufeng@iie.ac.cn,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	krzk@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH]nfc: replace improper check device_is_registered() in nfc_se_io()
Date: Wed, 16 Apr 2025 10:44:54 +0800
Message-ID: <20250416024454.319-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250415173826.6b264206@kernel.org>
References: <20250415173826.6b264206@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowAC39g6wGf9nHvdECQ--.22403S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryDWr18tw1fur1DCw4xXrb_yoW8GF1Upr
	n8Kas0kFs8KF10grZrXa18tFy09FZ2k34rX3W5Gr1UKF47uF97trWIkrW5Xa43Zr1rCa4j
	vFyUGw4fur4DC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
	W8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
	McIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS
	14v26r126r1DMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUm4EiUUUUU=
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAUOEmf-A3RRDwABsl

> On Tue, 15 Apr 2025 10:54:36 +0800 Chen Yufeng wrote:=0D
> > > On 14/04/2025 16:11, Chen Yufeng wrote:  =0D
> > > > A patch similar to commit da5c0f119203 ("nfc: replace improper chec=
k device_is_registered() in netlink related functions")  =0D
> > =0D
> > > Please wrap commit message according to Linux coding style / submissi=
on=0D
> > > process (neither too early nor over the limit):=0D
> > > https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/proces=
s/submitting-patches.rst#L597  =0D
> > =0D
> > Thanks for your reply!=0D
> > I have reorganized commit message as follows.=0D
> > =0D
> > A patch similar to commit da5c0f119203 ("nfc: replace improper check =0D
> > device_is_registered() in netlink related functions").=0D
> > =0D
> > The nfc_se_io() function in the NFC subsystem suffers from a race =0D
> > condition similar to previously reported issues in other netlink-relate=
d =0D
> > functions. The function checks device status using device_is_registered=
(),=0D
> > but this check can race with device unregistration despite being protec=
ted=0D
> > by device_lock.=0D
> > =0D
> > This patch also uses bool variable dev->shutting_down instead of=0D
> > device_is_registered() to judge whether the nfc device is registered,=0D
> > which is well synchronized.=0D
> =0D
> You're also missing a Fixes tag=0D
=0D
Thanks for your reply. I have added the Fixes tag.=0D
Fixes: cd96db6fd0ac ("NFC: Add se_io NFC operand")=0D
--=0D
Thanks, =0D
=0D
Chen Yufeng=


