Return-Path: <netdev+bounces-119398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75895570B
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53D49B20E94
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65E414883C;
	Sat, 17 Aug 2024 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="bZFfWWfD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Imv3ZnYa"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416512AF17;
	Sat, 17 Aug 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723888643; cv=none; b=rXq4KAVn4+YA9P86Yde6yVpo1S3S7Rsk1j4+jlhZudxBBQVrye4MvWx4wdo/zhvRrdFnNFAaOrmFWpot1yKTGwy6Wq0HRJwPoQnTUMPIL5ki2O0lza220ur/4LtXka8LtVlKRMK5kvKNp6o5dFqOCHsBNncINorai3fGIVlVkFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723888643; c=relaxed/simple;
	bh=Gq5IKdEPeh2TkTrhizWAKJgB3fUPwD2pK/WZv+zSG2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3H9x+UoWFq71BLdhChcxYz52R5dvUdRg377mfFtdwRAXoOQezA3qNbdnOguZfaom5SV7PGSfKhcL+TrPLx+E8icnA9WIhDGZYKHg0SftPlN91X2XQ79sbbrnR1+zqEPiH5x4i0wHdSL6m/T25UrSLArs5pUb0Cu4jQ4uGy/EVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=bZFfWWfD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Imv3ZnYa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C39C1151C0F;
	Sat, 17 Aug 2024 05:57:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Sat, 17 Aug 2024 05:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723888640; x=
	1723975040; bh=OKF032Y5YaEJsYf98SzFHHnezNjRg1rIhihP93Nchj8=; b=b
	ZFfWWfDcBnv5lombjA1IJl0GfO4aEGdh62AvRsPn+F5NhzB4SV/DwAevomPXhK3m
	wMpA7Ki3Rhrj3eHZ9e7DSz8HnyyYz72MocfNHY53RcElAyhZ720nhE9g94COi7sm
	JXVWxjpC9Db62bpLvsmU1b5j/UHMg0X5j/pR3Xz+hvcdHPhnX4eK4IYSWI3MWc2D
	LTj0t3F1rxMjXAmJNS5y6A+MZxeluYHtfG+SilC7tPI/9HIldaw1gKmpmymPE42Q
	8ucr+cOdGECZ4wQqyeU3HorPmwJ7IqKQhQ8GlyF7j1GPxDKeXl2oFsAqw6rvrw/B
	fsAYt2dQl+g3eEQVBE7Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723888640; x=1723975040; bh=OKF032Y5YaEJsYf98SzFHHnezNjR
	g1rIhihP93Nchj8=; b=Imv3ZnYaDANISjgAya4YvgZuWKfUAe8QJaDXtI+i7+ZR
	9Ppha54V1JuAj0NsALq4HzQDDMixpECNZou7toTx/13imzTCBZt+mMt0khkmPjyP
	zLBDmU8vJJiXSuBetGmlssats7CjY/qiGkTK4Z6ght3qzacDgs9VFPlHS1hKvnpM
	yfeCjRPqT3dsJYsLbSokcfLhayzxNMtpYaaE47o4DTvaHyLOzNeDHYhLRTks6uhX
	HdM8lSsA4tLSO6jzj8hIj6WHPyLn4NTFA8Z7xz1J/I9mvjBLa6JGLNhdX6D7bh2v
	FZELGc8UJiy8VAvxZ6tjZbPNQuPd4p36yphhU6pdXQ==
X-ME-Sender: <xms:_3PAZiQGiNzsBM-RkpaP63lz4084ytyOcE-u_NPdV4mRdsAAjw-LZg>
    <xme:_3PAZnwRlUS990lxBydQsWK0IqIf-cVeok88fSmsICdxC27jpLLJX1Iii_PkOD3IO
    BrF5QTZianhuL5-Ra4>
X-ME-Received: <xmr:_3PAZv0x3r5FCBjkPrS9HRevmwZ4DsPX-KdGT-HTdwaltXPLBQYo97XZbvzWFU-gGL18BkOvmm55bLbwQNRzTcnILaF8qa-_d0s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddutddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeu
    ffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhho
    tggthhhirdhjphdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopeiiihhjuhhnpghhuhesihgtlhhouhgurdgtohhmpdhrtghpthhtohepghhr
    vghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhgrfh
    grvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvgesshhtghholhgrsghs
    rdhnvghtpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvih
    drtghomhdprhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgt
    phhtthhopegrlhhishhonhdrshgthhhofhhivghlugesihhnthgvlhdrtghomhdprhgtph
    htthhopehvihhshhgrlhdrlhdrvhgvrhhmrgesihhnthgvlhdrtghomhdprhgtphhtthho
    pehirhgrrdifvghinhihsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:_3PAZuACpKWfoPblqQ01MJwp1wo3RAjdkFtoQhwuozkDny11StiGAw>
    <xmx:_3PAZrg9LgTGT-P_8toKbxgS4Gxes-orU44HjnGanrDnqXIicqHrkQ>
    <xmx:_3PAZqozqkkjP3kNoKc5NbNV819yG-3WpolZQHS1Pysxv5kW1msxpA>
    <xmx:_3PAZuhMOMeMZAodihfKvYg-LBLoKJ8cKzklDa5KAQwA6JdF6oirYA>
    <xmx:AHTAZuhMZ1CbAhPLeNvxNJ295fso3-68ZRztUQXgPS1VIkxzq3rNbGAz>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Aug 2024 05:57:15 -0400 (EDT)
Date: Sat, 17 Aug 2024 18:57:13 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
Subject: Re: [PATCH v2 3/4] firewire: core: Prevent device_find_child() from
 modifying caller's match data
Message-ID: <20240817095713.GA182612@workstation.local>
Mail-Followup-To: Zijun Hu <zijun_hu@icloud.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Timur Tabi <timur@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, netdev@vger.kernel.org,
	Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240815-const_dfc_prepare-v2-0-8316b87b8ff9@quicinc.com>
 <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815-const_dfc_prepare-v2-3-8316b87b8ff9@quicinc.com>

Hi,

On Thu, Aug 15, 2024 at 10:58:04PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> To prepare for constifying the following old driver core API:
> 
> struct device *device_find_child(struct device *dev, void *data,
> 		int (*match)(struct device *dev, void *data));
> to new:
> struct device *device_find_child(struct device *dev, const void *data,
> 		int (*match)(struct device *dev, const void *data));
> 
> The new API does not allow its match function (*match)() to modify
> caller's match data @*data, but lookup_existing_device() as the old
> API's match function indeed modifies relevant match data, so it is not
> suitable for the new API any more, fixed by implementing a equivalent
> fw_device_find_child() instead of the old API usage.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/firewire/core-device.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)

Thanks for the patch.

> Why to constify the API ?
> 
> (1) It normally does not make sense, also does not need to, for
> such device finding operation to modify caller's match data which
> is mainly used for comparison.
> 
> (2) It will make the API's match function and match data parameter
> have the same type as all other APIs (bus|class|driver)_find_device().
> 
> (3) It will give driver author hints about choice between this API and
> the following one:
> int device_for_each_child(struct device *dev, void *data,
>                 int (*fn)(struct device *dev, void *data));

I have found another issue in respect to this subsystem.

The whole procedure in 'lookup_existing_device()' in the call of
'device_find_child()' is a bit superfluous, since it includes not only
finding but also updating. The helper function passed to
'device_find_child()' should do quick finding only.

I think we can change the relevant codes like the following patch. It
would solve your concern, too. If you prefer the change, I'm going to
evaluate it.

======== 8< --------

From ceaa8a986ae07865eb3fec810de330e96b6d56e2 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Sat, 17 Aug 2024 17:52:53 +0900
Subject: [PATCH] firewire: core: update fw_device outside of
 device_find_child()

When detecting updates of bus topology, the data of fw_device is newly
allocated and caches the content of configuration ROM from the
corresponding node. Then, the tree of device is sought to find the
previous data of fw_device corresponding to the node, since in IEEE 1394
specification numeric node identifier could be changed dynamically every
generation of bus topology. If it is found, the previous data is updated
and reused, then the newly allocated data is going to be released.

The above procedure is done in the call of device_find_child(), however it
is a bit abusing against the intention of the helper function, since the
call would not only find but also update.

This commit splits the update outside of the call.
---
 drivers/firewire/core-device.c | 109 ++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 55 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index bc4c9e5a..62e8d839 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -928,56 +928,6 @@ static void fw_device_update(struct work_struct *work)
 	device_for_each_child(&device->device, NULL, update_unit);
 }
 
-/*
- * If a device was pending for deletion because its node went away but its
- * bus info block and root directory header matches that of a newly discovered
- * device, revive the existing fw_device.
- * The newly allocated fw_device becomes obsolete instead.
- */
-static int lookup_existing_device(struct device *dev, void *data)
-{
-	struct fw_device *old = fw_device(dev);
-	struct fw_device *new = data;
-	struct fw_card *card = new->card;
-	int match = 0;
-
-	if (!is_fw_device(dev))
-		return 0;
-
-	guard(rwsem_read)(&fw_device_rwsem); // serialize config_rom access
-	guard(spinlock_irq)(&card->lock); // serialize node access
-
-	if (memcmp(old->config_rom, new->config_rom, 6 * 4) == 0 &&
-	    atomic_cmpxchg(&old->state,
-			   FW_DEVICE_GONE,
-			   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
-		struct fw_node *current_node = new->node;
-		struct fw_node *obsolete_node = old->node;
-
-		new->node = obsolete_node;
-		new->node->data = new;
-		old->node = current_node;
-		old->node->data = old;
-
-		old->max_speed = new->max_speed;
-		old->node_id = current_node->node_id;
-		smp_wmb();  /* update node_id before generation */
-		old->generation = card->generation;
-		old->config_rom_retries = 0;
-		fw_notice(card, "rediscovered device %s\n", dev_name(dev));
-
-		old->workfn = fw_device_update;
-		fw_schedule_device_work(old, 0);
-
-		if (current_node == card->root_node)
-			fw_schedule_bm_work(card, 0);
-
-		match = 1;
-	}
-
-	return match;
-}
-
 enum { BC_UNKNOWN = 0, BC_UNIMPLEMENTED, BC_IMPLEMENTED, };
 
 static void set_broadcast_channel(struct fw_device *device, int generation)
@@ -1038,6 +988,17 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
 	return 0;
 }
 
+static int compare_configuration_rom(struct device *dev, void *data)
+{
+	const struct fw_device *old = fw_device(dev);
+	const u32 *config_rom = data;
+
+	if (!is_fw_device(dev))
+		return 0;
+
+	return !!memcmp(old->config_rom, config_rom, 6 * 4);
+}
+
 static void fw_device_init(struct work_struct *work)
 {
 	struct fw_device *device =
@@ -1071,13 +1032,51 @@ static void fw_device_init(struct work_struct *work)
 		return;
 	}
 
-	revived_dev = device_find_child(card->device,
-					device, lookup_existing_device);
+	// If a device was pending for deletion because its node went away but its bus info block
+	// and root directory header matches that of a newly discovered device, revive the
+	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
+	//
+	// serialize config_rom access.
+	scoped_guard(rwsem_read, &fw_device_rwsem) {
+		// TODO: The cast to 'void *' could be removed if Zijun Hu's work goes well.
+		revived_dev = device_find_child(card->device, (void *)device->config_rom,
+						compare_configuration_rom);
+	}
 	if (revived_dev) {
-		put_device(revived_dev);
-		fw_device_release(&device->device);
+		struct fw_device *found = fw_device(revived_dev);
 
-		return;
+		// serialize node access
+		guard(spinlock_irq)(&card->lock);
+
+		if (atomic_cmpxchg(&found->state,
+				   FW_DEVICE_GONE,
+				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
+			struct fw_node *current_node = device->node;
+			struct fw_node *obsolete_node = found->node;
+
+			device->node = obsolete_node;
+			device->node->data = device;
+			found->node = current_node;
+			found->node->data = found;
+
+			found->max_speed = device->max_speed;
+			found->node_id = current_node->node_id;
+			smp_wmb();  /* update node_id before generation */
+			found->generation = card->generation;
+			found->config_rom_retries = 0;
+			fw_notice(card, "rediscovered device %s\n", dev_name(revived_dev));
+
+			found->workfn = fw_device_update;
+			fw_schedule_device_work(found, 0);
+
+			if (current_node == card->root_node)
+				fw_schedule_bm_work(card, 0);
+
+			put_device(revived_dev);
+			fw_device_release(&device->device);
+
+			return;
+		}
 	}
 
 	device_initialize(&device->device);
-- 
2.43.0



Regards

Takashi Sakamoto

