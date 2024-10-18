Return-Path: <netdev+bounces-137114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246759A4688
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 964E8B21856
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646032040A8;
	Fri, 18 Oct 2024 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qjOeBQlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHxuVbDy"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE642040A5;
	Fri, 18 Oct 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729278575; cv=none; b=ARK80zLbM8XwRBmdB/BTmqrTBGDEXU/bvlUqHfcEw21DurTCfKv9lSE5pvXBkLoVr/wCvgEY1UEpH5HOFVdDX93IboglUH+Lzcsalxo+ntEmsAdkMVdCaLTIT38Nt5tN/a9dZ9W6b3ZKgIrd2sBAwqkUreRWdqopy64G3A2Krtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729278575; c=relaxed/simple;
	bh=xFO+xL5Ht2yDe+kUYFr9A1J+8iJb6w7Ml2SfdltszJQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s0MVLGv+IUd2l36BXO7HwQgcahnrT11XwcDdgBKa8kKSGZ/Sp9Lpl2eUu6ltGLUUhjPXkR3CXNBItBppMpQHBaNq7tOvNdUQtw4HiXbDqkoJo7IgdtLUKQ2QRvoMF/9ExG0fEO8OFYySQwq+0Kp/FiTNZVLjm6Ec7y1J1b8t0fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qjOeBQlZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHxuVbDy; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 55CE813803B0;
	Fri, 18 Oct 2024 15:09:32 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 18 Oct 2024 15:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729278572;
	 x=1729364972; bh=frwaSkezvHV5tmSPShTPgiPDW3lBR2mqZQtqKpeH0GM=; b=
	qjOeBQlZ8dXOFniyCz2j6qPBbXeVFmSiRV829V1C4RqCz794S3iospjedJVE3Rqd
	MK5CvSANvX+s/3Jzc2n/2xBVxwAoyg8nb97nGRgB5LHb4ARg47meSeNMu64hbQmE
	CGwhzAqMUdzAPu3IbxNzjmnNSCwOY9s98kUyFCFSmiX4wZtXx67XYxhBzZkSAZwd
	Z8Xbrdtz94UWk6uBAZMZJCvsyYwg+qvHnmiWuoX1M3/RqKghmdr9lp3FqWWq0aDM
	4JQ6tl3JTqO01fd+vS+uZ+gbW9/CFmNuFMle1RV+ZXaZZWwHcnrUarHc4UINYOtS
	r00GD6NKoaqHUvvnvoFMVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729278572; x=
	1729364972; bh=frwaSkezvHV5tmSPShTPgiPDW3lBR2mqZQtqKpeH0GM=; b=C
	HxuVbDyIE7bKe2P0mRkJ3C17YdlBWh/EGL9J8vvld81+R7RUdBO95SajqqRzCZ/J
	28vUe4J7NwhLyVAVdqpQXBf9QrSgySc4Wy9zbpY9wHM+G1BCZMPKzJmdoABPH+Aq
	1fj7Q8SnZKD2KQiJojgqH1GxYZUOhoGxeqSJ94/5EEBHRE6N6P5QZZJsRoiL8Uo/
	8MB6EagCLZYJG3AR1hddLJxIsa//AU+W3Z09GZkxepTXB1WIwAJgILY8hxbfSR1T
	qqJGx77eIWtQOOMefRTmthNQenZ0p8XDd8Dfso5ThDsT9k4jGyIPeVnkuf8KeEzr
	vg9jAAY1HoTLrCGYi6nLg==
X-ME-Sender: <xms:arISZxwEJKecQb-bTM7r7sWTdzEFjCKLZKTUXslTMtYREiChHwZh-Q>
    <xme:arISZxQEzd8QPuOFSM3Su2_f29q_WwVtm7PKhNcjVA-yVUS5GAzek791jIHhR_-Kx
    RlBg_OaZ8a2smjdASU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpeefhfehteffuddvgfeigefhjeetvdekteekjeef
    keekleffjeetvedvgefhhfeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvgdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepuggrvhgv
    mhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtoheplhhiiigvthgrohdusehhuhgrfigvihdrtghomhdp
    rhgtphhtthhopegrlhgvkhhsrghnuggvrhdrlhhosggrkhhinhesihhnthgvlhdrtghomh
    dprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghh
    vghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegthhgvnhhtrghosehkhihlihhnohhsrdgtnh
X-ME-Proxy: <xmx:arISZ7UMxY021cv6ge7h3dtvj5aX83pjpfTP-bXbqtUcjW6olKxG4w>
    <xmx:arISZzhzEFhsTEIo6NaWe4d4_32fUMt6ufqaOzkxfLWiv0w7D4WlEg>
    <xmx:arISZzAjaUq2s2w5_lOXCZ3sRut57oU56z8zNa2qbE_U2JBxx1RGzA>
    <xmx:arISZ8K3h7UM3MbrsXpBKsVCve8isugUO6pWHNUeFYfstUbxHQvn1g>
    <xmx:bLISZwI_Y2lyN5-xuWmgopPpk44WF8ouNT1XFy3iGQ-cOHCyKV_Jj9Ep>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BA4DD2220071; Fri, 18 Oct 2024 15:09:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 18 Oct 2024 19:09:10 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kuniyuki Iwashima" <kuniyu@amazon.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Alexander Lobakin" <aleksander.lobakin@intel.com>,
 "Kunwu Chan" <chentao@kylinos.cn>, "David S . Miller" <davem@davemloft.net>,
 "David Ahern" <dsahern@kernel.org>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, linux-kernel@vger.kernel.org,
 "Li Zetao" <lizetao1@huawei.com>, Netdev <netdev@vger.kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>
Message-Id: <95170855-21fc-45b4-a393-176883f7dd52@app.fastmail.com>
In-Reply-To: <20241018163100.88905-1-kuniyu@amazon.com>
References: <20241018151217.3558216-1-arnd@kernel.org>
 <20241018163100.88905-1-kuniyu@amazon.com>
Subject: Re: [PATCH] ipmr: Don't mark ip6mr_rtnl_msg_handlers as __initconst
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 18, 2024, at 16:31, Kuniyuki Iwashima wrote:
> From: Arnd Bergmann <arnd@kernel.org>
> Date: Fri, 18 Oct 2024 15:12:14 +0000
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> This gets referenced by the ip6_mr_cleanup function, so it must not be
>> discarded early:
>> 
>> WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .exit.text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
>> ERROR: modpost: Section mismatches detected.
>> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
>> 
>> Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Hi,
>
> I posted this yesterday.
> https://lore.kernel.org/netdev/20241017174732.39487-1-kuniyu@amazon.com/

Right, your may be better then. I was confused by the
function name suggesting that this would be called in the
module_exit path, but I now see that it is only called
at init time, so that works.

     Arnd

