Return-Path: <netdev+bounces-112683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F6293A925
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 00:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 248001F23739
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 22:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52714900E;
	Tue, 23 Jul 2024 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="dwqTJkXh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPbjtLqD"
X-Original-To: netdev@vger.kernel.org
Received: from flow2-smtp.messagingengine.com (flow2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFABC1422AB;
	Tue, 23 Jul 2024 22:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773364; cv=none; b=YQsh5ZD3mtN6XtLlwsoScMFZZDNX6VNCYUPuimwGutWWVZblk07YDtcHShUnB9GVdczgBd4AKjHwei9bovdSDhePbLHuDX2syJq8WZPGh6ZBLno80Q0d9ciF7FId3LqPhsuCDhpr09Gc4hGyQX9ziPfr/rsmAiUgY+tCCpm6dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773364; c=relaxed/simple;
	bh=CUbFEEQNexa5j6PfToI17rtWPKGHQUYtitLXl+IZJwQ=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=BC9XIEMRrJTs7K1+xEiZ4mUwwZkefaBgDxCmXUcAsyni/8OaIL2XIUWtJupeaqUmACtM8fpcUhxRq3qNH3UO8+4ZMTvf16u8KReCGSRL4Rvote0D5jl9OmgmQ43XDwByqHvJ7gHURrs4k3C8d2gRqXJXEXIMB2ejFjcskgg8pZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=dwqTJkXh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPbjtLqD; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id 4B74B200299;
	Tue, 23 Jul 2024 18:22:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 23 Jul 2024 18:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-type:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1721773360; x=1721776960; bh=pBssfTXCdW
	NGri+8CtESggRY11zn0Ji+Qo/wUQwWq/g=; b=dwqTJkXhg3baPcC56nR4+QvRyS
	GLdlQJl8JZ3zndavQ9fuoRnOr9TPN13vBatz3DZMGozKFaq0VgMeaEvm5796NyUq
	lySAg1yfs31xiAgIJSMQ8K7i0U0l32Th87qRtOk3pzPZRvrEMQT9hJy/o8mN7477
	afme3YF54V4aupd9C9617YxgWlXVTS2pgClWqr6YvbCFDP+1vBZViJIFk0RW14k3
	9dWPALSIDUvw2QIx2FAiLb1MVVCN0xEWyaeaPkEx8R5RWbaJjyPWm29WkrpzdYV8
	6jR4wIaO0A79kQ93kPJUz0q3PKoKZyFA6s7ufTHnwYA9SiE9fChDpBozWxbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721773360; x=1721776960; bh=pBssfTXCdWNGri+8CtESggRY11zn
	0Ji+Qo/wUQwWq/g=; b=qPbjtLqDF4EMn8kmxIrQB3KI66bTE6GYaMq2wpvUSQVJ
	mum/Zx0a7ov+4Ym3dERkWmk5MyAtNF9CNviEEw26Nl+VKSClZ2FMku+Z8Nfedq57
	9AX5iCy/KKcFKZhzxU8OR7GQ3fXiXPib2kS2gBP5XTyJX2JD8BK+ZrtxZ/cpGk+3
	0kFlXRadu7W6ZW/OWf2d0+AGkVI50Scb1rzswe3lrEAlWHYIartX7Aq2T7XgK4iN
	q/iymeV3/QhRoPsHPYudcK6CG9doFkEILUUWUstmxXceWImQRKckD3zIQbwJZRNB
	hTKA3DRjVvGBoVHl9u3KTbhhnKQAkqf5+ug7IeMC9w==
X-ME-Sender: <xms:MC2gZgGZWR_jv2Rgf1tT-FT46WHkHXClQXqg409s1Lmm4KinmnanIw>
    <xme:MC2gZpUnfwsz4l2u0aWVqE8FADC2N517ZRmK_wLikMPbGb6knKRVsqkhXyAiJNw19
    l-xkmnuBzkVUqsXntk>
X-ME-Received: <xmr:MC2gZqIQcM0f3y9dRLqaLTfP27VAmrCEHMiw0mQVkg5tOT5IHMgN3MqHwj04T9YBhskeiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedtgddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmdenuc
    fjughrpefhvfevuffogggtfffksehttdertdertddvnecuhfhrohhmpeflrgihucggohhs
    sghurhhghhcuoehjvhesjhhvohhssghurhhghhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epieehfeeludeugeekgfdtkeekjeelgfeiudeuieffkeffgeefuefhieeffedtffdunecu
    ffhomhgrihhnpehsohhurhgtvghfohhrghgvrdhnvghtnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhvsehjvhhoshgsuhhrghhhrdhnvght
    pdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:MC2gZiEN5D2DRnrAD3xd3JEi0L_0PZ34jCDVWVyfl70HFsBSGJpJcw>
    <xmx:MC2gZmUBlTJJv8n3qlUynLILsbsvC866xTXxSqamKotPrSOyj8sJvQ>
    <xmx:MC2gZlPytMhD9HVz8fQiRIrEjLwE6OG3B4yHElyfWspx_3YXrWJkTQ>
    <xmx:MC2gZt1Q49cyWWWhSv3KHRN2WkVZuBsRGeNigQ5zneN2BMNJI5EmMQ>
    <xmx:MC2gZvXI3GCrATpZpA2c4G33bVCx_kEIm6DCQOXYGteRwAJEgVMxyWvY>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 18:22:39 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id B76D09FC9E; Tue, 23 Jul 2024 15:22:36 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id B46A59FB9E;
	Tue, 23 Jul 2024 15:22:36 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Update bonding entry
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2800113.1721773356.1@famine>
Date: Tue, 23 Jul 2024 15:22:36 -0700
Message-ID: <2800114.1721773356@famine>

	Update my email address, clarify support status, and delete the
web site that hasn't been used in a long time.

Signed-off-by: Jay Vosburgh <j.vosburgh@gmail.com>

---

v2: resend from email that (hopefully) won't eat white space

 MAINTAINERS | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0f28278e504..bad94cfb7e70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3810,11 +3810,10 @@ F:	include/net/bluetooth/
 F:	net/bluetooth/
 
 BONDING DRIVER
-M:	Jay Vosburgh <j.vosburgh@gmail.com>
+M:	Jay Vosburgh <jv@jvosburgh.net>
 M:	Andy Gospodarek <andy@greyhouse.net>
 L:	netdev@vger.kernel.org
-S:	Supported
-W:	http://sourceforge.net/projects/bonding/
+S:	Maintained
 F:	Documentation/networking/bonding.rst
 F:	drivers/net/bonding/
 F:	include/net/bond*
-- 
2.25.1


