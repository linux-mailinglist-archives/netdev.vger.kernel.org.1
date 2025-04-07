Return-Path: <netdev+bounces-179951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 278ABA7EFCE
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 23:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37893ABC9E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E36218AC7;
	Mon,  7 Apr 2025 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="Q4rpE27g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uwvqIeDl"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA98185B4C;
	Mon,  7 Apr 2025 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744062293; cv=none; b=JZ4hLB/sIMfuIzznotcCPnZ+ST3LZyKf1fe6EzuN8bKWcATJQyz9jq+NT0rLtD/pVAN4mKdCzF2247QrTwIH8Fz9VNNRdGY3339V57BiFC4O2U97Vn03OcsiciunqBXFzdCsThkIEJ7kzXtyAq9Hgp4CoEP4vfAhD1FbS1Xn44s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744062293; c=relaxed/simple;
	bh=oLE3a68tg1T+APCnXENVj5fyycXXAzOcqEdLbtqwwkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hp4nMQnumvFUEENiWOMDnRCgNdfnBiS+/AeIEh5KJrFj79VY4EVKnG0mwbL5VyYGNSBqwKES4TNzTPb866NEorjbVNbaKIBVxv/jP7FiGx13plcUCF2eyZQWRJUzWBXBsPRL3YZHmzfzR0kFWqeJN8GIT7qGCaoWXvJgHZygcUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mendozajonas.com; spf=pass smtp.mailfrom=mendozajonas.com; dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b=Q4rpE27g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uwvqIeDl; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mendozajonas.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5DF51140205;
	Mon,  7 Apr 2025 17:44:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Apr 2025 17:44:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	mendozajonas.com; h=cc:cc:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm1; t=1744062289; x=1744148689; bh=7WP3x2DtyJDu+LxZWfrmF
	kvKczFkweLQTdTa6KFrXA4=; b=Q4rpE27g/LY0IBFUJ6Po8TN07DZ7pCoUgy5Ks
	yev61qfrcCWrxcoWNy95+jcnvDZ/dDqx6WBJ4P67K+sTv9ITjicjQddYT0YALHAc
	MyNZmpLvMQXdnDtnDET7nKjLl2cJUJZlmbYYgPD0mNNsIXB+pOS5eebvUvOkljha
	WN6CuGJu43DAlhh0ToDfqvr+ZVuIIKgAdvPypxXcsF4BRIggj9RnrWP5rLpVLokQ
	efHbM8iouSurAStC2vPbBDnFWvzRCKFcXNeSl+ugG3fvk6e8tf9Q8f1oU3Y2xNUm
	FX3tssTrpUKIC2VYRMeFPO6q1mrWytCnJ+UTg2VrX1iK0mmDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744062289; x=
	1744148689; bh=7WP3x2DtyJDu+LxZWfrmFkvKczFkweLQTdTa6KFrXA4=; b=u
	wvqIeDltYM3cRKSoGHRAw809CE7GCjAYwEVfxAYOisrC7t8Wpm9uip03sInAH8Zl
	ZeYPah3Uv60OYVSilbqluCtGeSlogrcsNIDd5t8Uv/QT6A+GXgB/sU/TDyXUe8ww
	7iEDch7Zzy3BRxSXAghYlURbPPSwywrjNd9u9xhqQPS9mxygkGyjgZI78RT1gMQH
	B1Fd8ZnXWwXVB3Njbewm7BFsyJecZF8sxDNgZJWTzJJqfyUQUiY//SkHl7fhl6B3
	7wdot1TfVUM1GgcmvJCfiGs06SDK6dzph6o4JqrwuaWBrkh2SBKlDDL8w54THCBf
	qae1FsNEU69zjyIFzVwxw==
X-ME-Sender: <xms:UUf0Z3-cQGFi91vbXdnORAcIOp28Q58xuqQU9fw8rxyvitDRrymLjA>
    <xme:UUf0ZzvYJiRVt-A1nsK5fhzlDIhs_Hq_F1n8wW6yIbiutIfAdwUbHQynDemYtuOv5
    NK01X2QLZ_Z6_7vEw>
X-ME-Received: <xmr:UUf0Z1Brk8LgPJXHW1A27yha9UNz80KUXmGaVqH8T9hncUsab_bcPr0FliY_FzVErII>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddufeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepufgrmhcuofgvnhguohii
    rgdqlfhonhgrshcuoehsrghmsehmvghnughoiigrjhhonhgrshdrtghomheqnecuggftrf
    grthhtvghrnhepvdejffdttdeuieehvdegvdekhfejtdettdevvedvveevvdelueetiedt
    ledukeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhesmhgvnhguohiirghjohhnrghsrdgtohhmpdhnsggprhgtphhtthhopeduuddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrlhgrvhgrkhhunhhtrgdrhhgrrh
    hirdhprhgrshgrugesghhmrghilhdrtghomhdprhgtphhtthhopehfvghrtggvrhhprghv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnh
    gvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UUf0Zzf90d3fgOQnYQeyCElO9t2Q0hbW1NE3FkWV3YRT6Lio3S9HUA>
    <xmx:UUf0Z8P-33jFZFgXurEaCV20U_B4nw-4myNbQU2APDVeI9vAx141Dw>
    <xmx:UUf0Z1lH7Sye8sutbsctQK2ZrGSDPB3nAv0ij5XEFo8qEUeKFVC4mA>
    <xmx:UUf0Z2voyrVada3MLqyMSGeby_W6d5d6nBa9NaQRjVpZpqisO0R6tQ>
    <xmx:UUf0Zy6_pcqbbfIY5ZhyGemU44XCf0fk3Le8Luy_T4F__XiYAG4pIHeA>
Feedback-ID: iab794258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 17:44:44 -0400 (EDT)
Message-ID: <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
Date: Tue, 8 Apr 2025 07:44:37 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
To: kalavakunta.hari.prasad@gmail.com, fercerpav@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: npeacock@meta.com, akozlov@meta.com
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
Content-Language: en-US
From: Sam Mendoza-Jonas <sam@mendozajonas.com>
In-Reply-To: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/04/2025 4:19 am, kalavakunta.hari.prasad@gmail.com wrote:
> From: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
>
> Make Get Controller Packet Statistics (GCPS) 64-bit member variables
> spec-compliant, as per DSP0222 v1.0.0 and forward specs
>
> Hari Kalavakunta (2):
>    net: ncsi: Format structure for longer names
>    net: ncsi: Fix GCPS 64-bit member variables
>
>   net/ncsi/internal.h | 21 +++++-----
>   net/ncsi/ncsi-pkt.h | 95 +++++++++++++++++++++++++--------------------
>   net/ncsi/ncsi-rsp.c | 31 +++++++++------
>   3 files changed, 82 insertions(+), 65 deletions(-)

Looking at e.g. DSP0222 1.2.0a, you're right about the field widths, but 
it's not particularly explicit about whether the full 64 bits is used. 
I'd assume so, but do you see the upper bits of e.g. the packet counters 
return expected data? Otherwise looks good.

Acked-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>




