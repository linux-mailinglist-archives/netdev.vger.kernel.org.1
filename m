Return-Path: <netdev+bounces-135631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5F99E9E3
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 906701C2337A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 12:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714F82204D6;
	Tue, 15 Oct 2024 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h5XEe8Mq"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D873D21F424;
	Tue, 15 Oct 2024 12:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995505; cv=none; b=igWk/TPlnDwAQvMTjLgYJTvoAGj2fWkVrCmYGAM94B0e6E/rxUrhkbJhbUaCFHILZzk95DG6ZqYluVG8sj6f4NX562GSVlkkPZVxIp2FMxBV5g8VtQ2Fs9SAV7x29u4fKD+naesXofarH0I2A2BzSsRxsjZEhNdiCW7wdmq/AMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995505; c=relaxed/simple;
	bh=aq/3IIAj/YhHcE2+js3vpMddLUnK8UeitAV+k4Hf5xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKv8PI12nRglCcUIgBuhR87QYeai2dWa53AHgYb9Hw2k46Ty1TboDxnMTEz0E3/FbPBwNIx6F7yd4IiSWISPQ2knHw7kzSGju76ZNaqgdSsCkmZ/sA/bWkyKU9C3NzEnwqxZ5E52HDShZynm8IAvgVRh20g0ldtnjCCm4ZFIVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h5XEe8Mq; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id BA3CC13801D7;
	Tue, 15 Oct 2024 08:31:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 15 Oct 2024 08:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728995502; x=1729081902; bh=YuaLlqT81l1YoNG4/tsuRi1kfz+P
	DAhqeW5NxgJdXMY=; b=h5XEe8Mqwudy6YNCMuMsrvFgFpvCZG1kbN5w9IPFtWU+
	YorE+db97PRcRK/vFaLkIg4ev7GpdbtvPBgXrMuIytjH2cG4IkpWVmL69EWENb5y
	yh6hm042J1uM78KmjF7uYckMJ5HJYigai/si/t95+IFylhe83mn5RGXxkSwyN4P5
	obJpye5dYQOTp8W49hs0SGr5UeEx6s2FRBCEPk/l7Ffj8HP0ZGs4LyOGs8xW120w
	jbmjyJF+Y0pZrH2JiWSJHuU1UgF9Rok2wad8yNiIap7uEgaQTj9Ep+PDGwIarWhj
	FStEP52T527z/FFd+lCMLHq/jjmzXHrgzb+GAQMTJQ==
X-ME-Sender: <xms:rmAOZ7PuaWkUM_KE_Rcq7Zhrm7LhUz2HudXMBkzXWtaFcHa8DR-HaA>
    <xme:rmAOZ1-QiZ36FSNNJT6jKPN6z71QVxVcd7mQO6X2ifysljkCK4YVUD9k8KoTf79Mf
    GyZuAftCeR7240>
X-ME-Received: <xmr:rmAOZ6QqPByqlcZQpltdQPdF_f7PdR_Pela4ZJQ0KI-xuXu5W8QKRm3eTBH3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdroh
    hrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieef
    gfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthht
    ohepudegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvghnghhlohhnghekrd
    guohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehiughoshgthhesnhhvihguihgr
    rdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtph
    htthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhusggr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtoh
    hmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepugho
    nhhgmhhlvdestghhihhnrghtvghlvggtohhmrdgtnhdprhgtphhtthhopehgnhgruhhlth
    esrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:rmAOZ_vrAOCYMCYILfCQpL2SEMbpj-rUinVYdk-9bPdwFMcaYbFM0Q>
    <xmx:rmAOZzfAD6ZLEZiyXtuwFMSt5yn9D7dtPaFDWXWEmDCojap3qlqvhg>
    <xmx:rmAOZ73dAEEeOk2dwoc-nmHs-XFkJf4O_jb3Db7CKsnZf2YFagdaFA>
    <xmx:rmAOZ__IbzcPfmZijCRnL3jlFslFZ5f4wyukfSK5UoP4pkMADUpUPA>
    <xmx:rmAOZ--QQIkG1jZp9rz_IWkdw_pVeFxTiC_c4ubYD4NoPOJyawrMCtX5>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 08:31:41 -0400 (EDT)
Date: Tue, 15 Oct 2024 15:31:39 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dongml2@chinatelecom.cn, gnault@redhat.com,
	aleksander.lobakin@intel.com, b.galvani@gmail.com,
	alce@lafranque.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: vxlan: update the document for
 vxlan_snoop()
Message-ID: <Zw5gqxvYVYkzVkex@shredder.mtl.com>
References: <20241015090244.36697-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015090244.36697-1-dongml2@chinatelecom.cn>

On Tue, Oct 15, 2024 at 05:02:44PM +0800, Menglong Dong wrote:
> The function vxlan_snoop() returns drop reasons now, so update the
> document of it too.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

