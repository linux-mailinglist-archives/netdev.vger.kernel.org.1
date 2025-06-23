Return-Path: <netdev+bounces-200148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29047AE3683
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 09:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87101891160
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 07:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52581EEA5F;
	Mon, 23 Jun 2025 07:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="AlrAVq/x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nu636Izx"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052B1E261F;
	Mon, 23 Jun 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750662801; cv=none; b=Iw5BV2PBWLYVmwJRQ5jiC5j3s0mTu5b/vY+nG/LyfkjQ8lE2Bzg1dSY2jY9DikfM2v80Uno/VJloKYJaI1v9vzx6dMUAuxyTnP1RFVYigTtCkcgxJal0vHRDxbbASNNB+URHc2K3R08hPuUoNWb/F6+ZDWfnp6HF7jqMkp3+5Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750662801; c=relaxed/simple;
	bh=bgEvEeAfORU0Th4A/1fgubP+7228HNZqE/tltb9W/Ds=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lSV778bWbRynsLy21cB9DIkdt+u9btfndftIDQ37uD4LL+g5SnGPMUiqiiddf3JVVCYrpLFxlzQ3D//9o3Dc3VfjIoo4hCbPcMDERy8JcN8aXHl8Gy0TjIAeI2XLl7aeOpQ/hWRpRS+VBjQdBaObmQZRDP8yr/Fc0WkRV+I5vZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=AlrAVq/x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nu636Izx; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F4381140120;
	Mon, 23 Jun 2025 03:13:14 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 03:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750662794;
	 x=1750749194; bh=wRU4tnjCSrivCdo6KM718G+AxOSn0D7TJ5cJleWWd2g=; b=
	AlrAVq/xiwZ3y6NYCSfUOZ8QmIsL92BkfIDfEXoi8L83V/1d1jOZDG7F+sgqMvqF
	KSzl700Kn+pFtz3wqx+XZ4ukGdXwoUR8Up0VR94vZJofkB5/HCh6Yog3e8AMzAnN
	vj4Ub3Oup9T6+wBtAoWyfYgI/3mF77/e/4bDk9QXt7BmDeocVJO4FLSYpwJ6KEmI
	SYjyTAoICSip9JdDTgAtyp3xSsms33Ksr+SbJx5onOLvQRKInMikFQ2+qsMCWXES
	JPkWWGKAxhLXRPuBeRVgjWGIwkmCKIy20qaymUKMafX//7MSsgE5g6ZnAuR0Hk13
	EyIW6pqRs1FjtzGGwJiBbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750662794; x=
	1750749194; bh=wRU4tnjCSrivCdo6KM718G+AxOSn0D7TJ5cJleWWd2g=; b=N
	u636Izx2bEKIisS2iUJtrcoey2RMo70Jw7qloaEJqjk1Lojdy/CUxBzv+6Eoka9d
	yZY2aS7CVM4Pm8Tv/jfcn5foO+trAtZbJjcGMroL1jY0udgEGPw1FtV5TxNJ7RoW
	/j1bYQe3/bJiIHSBTAY9GOrv7Qgmwvlu/9mmFVItdf66mHK2xH/vr20yrtoZ+SKH
	mftjsW/EoSVjdz+SsU5Fftfo+1vHmSLkkxHpHBqXoAmJc8UD77GyksfKkTu4FZpw
	VnPvmHT2NOlTgzVFadKefDmvZPfxeUlfB+FJF4pUGhAzDNXP9ugFAhScXcpvd4Vc
	VcSQCf0H2fOxppT/mpYWQ==
X-ME-Sender: <xms:iv5YaG-iNrVrrmcr2YW1NPU1UD10o-9r3LYU0y_FzOGeoyrnC7Xsjg>
    <xme:iv5YaGv_fIa_gCJlC5IdPTle-2IM4NAE6bXTYW34GdOcpZd3G5p7c9fazLSO3nSlb
    NJsz7fcym1uxQvituQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    hnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehjuhhsth
    hinhhsthhithhtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmohhrsghosehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehlrghnhhgroheshhhurgifvghirdgtohhmpdhrtg
    hpthhtohepshgrlhhilhdrmhgvhhhtrgeshhhurgifvghirdgtohhmpdhrtghpthhtohep
    shhhrghojhhijhhivgeshhhurgifvghirdgtohhmpdhrtghpthhtohepshhhvghnjhhirg
    hnudehsehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:iv5YaMA6t8g4SGm64E0PCsOWnJSEUcekZATTWg7r2CKYU43JWihFLQ>
    <xmx:iv5YaOfvrwLBfJsvRHxWh7vCoFX9S-hZPunkDVjb9pWMq1BHAlb9Yg>
    <xmx:iv5YaLNzqu0ry9v5tzebwDP91J3P6Pc-J-BOIH7MjC9oG7rbMOml0Q>
    <xmx:iv5YaImxcLnZa-AyXWMGY9Xu_XqTuzGEEx6G3RpduavjPGnLsAPNyg>
    <xmx:iv5YaNauLMksNlVrfuouQCE8Q-5KYR-EL0AEMnWrY_7Qzt-EIcFAXmVU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E8FDD700062; Mon, 23 Jun 2025 03:13:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0988381ff57d4bb7
Date: Mon, 23 Jun 2025 09:12:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jijie Shao" <shaojijie@huawei.com>, "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jian Shen" <shenjian15@huawei.com>,
 "Salil Mehta" <salil.mehta@huawei.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Hao Lan" <lanhao@huawei.com>, "Guangwei Zhang" <zhangwangwei6@huawei.com>,
 Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Message-Id: <4019926a-6d2a-48e8-aad3-bc0d0b6e28eb@app.fastmail.com>
In-Reply-To: <791a8e4e-8bcf-4638-8bd7-d9e8785a9320@huawei.com>
References: <20250610092113.2639248-1-arnd@kernel.org>
 <41f14b66-f301-45cb-bdfd-0192afe588ec@huawei.com>
 <a029763b-6a5c-48ed-b135-daf1d359ac24@app.fastmail.com>
 <34d9d8f7-384e-4447-90e2-7c6694ecbb05@huawei.com>
 <20250612083309.7402a42e@kernel.org>
 <02b6bd18-6178-420b-90ab-54308c7504f7@huawei.com>
 <cb286135-466f-40b2-aaa5-a2b336d3a87c@huawei.com>
 <13cf4327-f04f-455e-9a3a-1c74b22f42d0@app.fastmail.com>
 <791a8e4e-8bcf-4638-8bd7-d9e8785a9320@huawei.com>
Subject: Re: [PATCH] hns3: work around stack size warning
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025, at 08:21, Jijie Shao wrote:
> on 2025/6/23 13:56, Arnd Bergmann wrote:
>>
>>> -    sprintf(result[j++], "%u", index);
>>> -    sprintf(result[j++], "%u", readl_relaxed(ring->tqp->io_base +
>>> -        HNS3_RING_TX_RING_BD_NUM_REG));
>>> +    seq_printf(s, "%-4u%6s", index, " ");
>>> +    seq_printf(s, "%-5u%3s",
>>> +           readl_relaxed(base + HNS3_RING_TX_RING_BD_NUM_REG), " ");
>> I'm not sure I understand the format string changes here, I did
>> not think they were necessary.
>>
>> Are you doing this to keep the output the same as before, or are
>> you reformatting the contents for readability?
>
> yeah, just to keep the output the same as before

Ok.=20

>>> +static int hns3_dbg_common_init_t1(struct hnae3_handle *handle, u32
>>> cmd)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct device *dev =3D &handle->pdev->dev;
>>> +=C2=A0=C2=A0=C2=A0 struct dentry *entry_dir;
>>> +=C2=A0=C2=A0=C2=A0 read_func func =3D NULL;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 switch (hns3_dbg_cmd[cmd].cmd) {
>>> +=C2=A0=C2=A0=C2=A0 case HNAE3_DBG_CMD_TX_QUEUE_INFO:
>>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 func =3D hns3_dbg_tx_queue_in=
fo;
>>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 break;
>>> +=C2=A0=C2=A0=C2=A0 default:
>>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0 entry_dir =3D hns3_dbg_dentry[hns3_dbg_cmd[cmd].=
dentry].dentry;
>>> +=C2=A0=C2=A0=C2=A0 debugfs_create_devm_seqfile(dev, hns3_dbg_cmd[cm=
d].name, entry_dir,
>>> +=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=
=C2=A0 =C2=A0=C2=A0=C2=A0 func);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>> This will work fine as well, but I think you can do slightly better
>> by having your own file_operations with a read function based
>> on single_open() and your current hns3_dbg_read_cmd().
>>
>> I don't think you gain anything from using debugfs_create_devm_seqfil=
e()
>> since you use debugfs_remove_recursive() for cleaning it up anyway.
>
> Using debugfs_create_devm_seqfile() is just to simplify the code.
> We only need to focus on the implementation of .read() function.

What I meant is that it doesn't seem simpler to me, as it adds one
level of indirection to both the file creation and the read()
function compared to having a single_open() helpe with that
switch()/case or the corresponding hns3_dbg_cmd_func[] array.

Either way, I'm not worried about it, there is no actual problem
that I see with your version.

     Arnd

