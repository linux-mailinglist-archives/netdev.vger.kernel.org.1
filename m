Return-Path: <netdev+bounces-119625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0199295662D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D617B20A73
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFA15B560;
	Mon, 19 Aug 2024 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Z2U0Ww6t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WvT87wpI"
X-Original-To: netdev@vger.kernel.org
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FF15B11D;
	Mon, 19 Aug 2024 08:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724057938; cv=none; b=chzYglj4HE9NSs2zIEy83JYI12OjT4m10XQsx27eCghacQmfFHTmie43lXQUPUiTYFo3o7N4TYgsERXyOFjg6LsQcJWRkgESow3dcUCGR+LFam8JfKVGVjzdVg0C8wHJKnRN6ymXsOnygh4IRIv595qUW4tCnpjviLnqwAnfTbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724057938; c=relaxed/simple;
	bh=zU2J2dqhsvH8PWWZN4z3ts2gJVdnAVQhuxN+wIZczEI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CvsC3U3TiE675PpzsCxTFl+542JI7UWdr/E1hCZaJvOfGsti+9cH3LBOIbY75fJFBl6x9krZUz9I7+vFPQlFQiZQ/4zTSrMdzUnmufkqvSWdhbDAvookwq3ImqRlCpq1Pq0IczlQt29FOR4jM5w5Loo8EQi+AGua5cnMpf8+40k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Z2U0Ww6t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WvT87wpI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 62D22138FF81;
	Mon, 19 Aug 2024 04:58:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 19 Aug 2024 04:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1724057935; x=1724144335; bh=3S
	fA1zlL4vLdzjjWrDWy1o8HPyKxln0uS41Tw0AZeCk=; b=Z2U0Ww6tp+TQ5Yl1+8
	IbJsmHRvIu6PB+dgoQBp0nArvMEFF8iJ2wTN7a1iqqkqH+oRFKfvnERFFJwlme8k
	g8/ILAbv+ryr51sj97fZkhymCo2sp67Ick0SjoUuUFUW9T0bibaKeXeY5D9d+kOm
	W3PBn+/w2SypRiTH3LZp6sbCOltcftsO70LsIUgtkyVgd2yl9YAhW9ZOdbkIlLdB
	74eItPXzaaGdMYUlJVrwQmLhgL1eEMr0iZoNT/4skzj0UXSLdbLUcGT7E6mQqlUe
	aV7RXmVT84axLvKQikeYO1AEUjfUyeoqjCcxZN3e2kgNWR/ItAVEwmmK/ZIYjZNQ
	82YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724057935; x=1724144335; bh=3SfA1zlL4vLdzjjWrDWy1o8HPyKx
	ln0uS41Tw0AZeCk=; b=WvT87wpIS251yaWoRlhu7NOZy2Q0oaoS0mn8A2Y4GEMe
	wyfUfDItzMTQdtnGvjcJdPzvenGx9H93TBmEVa626q1bvhT3/sKEyPXbEHA7EBcI
	UGkXgVTMECtDsYaGDNP5Fs6uj0RJCB8olBNQKWUkxb6BNBGGfxGAyZyvDvDR7v4y
	ojFxQjAU4CLJCww9HgIFpKN8CS5fJV4F2EFAh/jrsNQ0CicKYRH0MBEXaKIAOVS5
	VwYLPHdynbdUEkNjchE2shN8dGYtgDjkl8G6zTMgN6FYqI/jBXXylhq3RrBugCtc
	1ToHPZBJ5c6r/aMFoURVQJs4pKiBooNBylMeeu7DQQ==
X-ME-Sender: <xms:TgnDZtwysB5Y8xGGcTlZ7AJ3fASKpHn7vwLO51cyWT2JR3T3Nb4GwA>
    <xme:TgnDZtRrfVETGkUk0wT_0vjhWPWPSzDm1P25aUggNt-45X9UMBG7ovBeJ8tgPlxBK
    npANy-JO0JglOn4C20>
X-ME-Received: <xmr:TgnDZnW5F5iOCaoHOLJqJ8aq5PJ27FbC4p84mEyF70Q27ykYySOCthpJhMEcYxnVuv4elAfxukHaVPSSuSEskCaACf77v3CGXAo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkgggtuggjsehttdertddttddvnecu
    hfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeuieffveeggfefjeeufeet
    veejuddtkedtgedtjeekgedufffhhfegkeekteetgeenucffohhmrghinhepkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoh
    epvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiiihhjuhhnpghhuhesihgt
    lhhouhgurdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrth
    hiohhnrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegurghvvgesshhtghholhgrsghsrdhnvghtpdhrtghpthhtohepjhhonhgrth
    hhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtghomhdprhgtphhtthhopegurghvvgdr
    jhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhopegrlhhishhonhdrshgthhhofh
    hivghlugesihhnthgvlhdrtghomhdprhgtphhtthhopehvihhshhgrlhdrlhdrvhgvrhhm
    rgesihhnthgvlhdrtghomhdprhgtphhtthhopehirhgrrdifvghinhihsehinhhtvghlrd
    gtohhm
X-ME-Proxy: <xmx:TgnDZviAeMXf575MHbI8MNpYsKoRDZQd2weYdVQ6IEB8k5gjqo5eBw>
    <xmx:TgnDZvB9EYl8c3P9goXP5Xpvi60iTp6j3NeJ7zlFlWLOUmzKUvT52A>
    <xmx:TgnDZoLbvs1AG_j7ACAPuyAm-LRGZuYSJgxaoP6TWCwirVpRMpSwjQ>
    <xmx:TgnDZuDT752UmhaOsOWtgjFxDM9eN8Pqz5hKUoOHNi8gf1hIZoRUTg>
    <xmx:TwnDZuAoExcbOBgQtrMWLkJhY9btYizEiKWgpMU256ING_8efvIAxPdb>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 04:58:50 -0400 (EDT)
Date: Mon, 19 Aug 2024 17:58:47 +0900
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
Message-ID: <20240819085847.GA252819@workstation.local>
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
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11efcbb2-f69a-49b4-a593-34fce42d49ea@icloud.com>


Hi,

On 2024/8/18 22:34, Zijun Hu wrote:
>On 2024/8/17 17:57, Takashi Sakamoto wrote:
>> ======== 8< --------
>> 
>> From ceaa8a986ae07865eb3fec810de330e96b6d56e2 Mon Sep 17 00:00:00 2001
>> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
>> Date: Sat, 17 Aug 2024 17:52:53 +0900
>> Subject: [PATCH] firewire: core: update fw_device outside of
>>  device_find_child()
>> 
>> When detecting updates of bus topology, the data of fw_device is newly
>> allocated and caches the content of configuration ROM from the
>> corresponding node. Then, the tree of device is sought to find the
>> previous data of fw_device corresponding to the node, since in IEEE 1394
>> specification numeric node identifier could be changed dynamically every
>> generation of bus topology. If it is found, the previous data is updated
>> and reused, then the newly allocated data is going to be released.
>> 
>> The above procedure is done in the call of device_find_child(), however it
>> is a bit abusing against the intention of the helper function, since the
>> call would not only find but also update.
>> 
>> This commit splits the update outside of the call.
>> ---
>>  drivers/firewire/core-device.c | 109 ++++++++++++++++-----------------
>>  1 file changed, 54 insertions(+), 55 deletions(-)
>> 
>> diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
>> index bc4c9e5a..62e8d839 100644
>> --- a/drivers/firewire/core-device.c
>> +++ b/drivers/firewire/core-device.c
>> ...
>> @@ -1038,6 +988,17 @@ int fw_device_set_broadcast_channel(struct device *dev, void *gen)
>>  	return 0;
>>  }
>>  
>> +static int compare_configuration_rom(struct device *dev, void *data)
>> +{
>> +	const struct fw_device *old = fw_device(dev);
>> +	const u32 *config_rom = data;
>> +
>> +	if (!is_fw_device(dev))
>> +		return 0;
>> +
>> +	return !!memcmp(old->config_rom, config_rom, 6 * 4);
>
>!memcmp(old->config_rom, config_rom, 6 * 4) ?

Indeed.

>is this extra condition old->state == FW_DEVICE_GONE required ?
>
>namely, is it okay for  below return ?
>return  !memcmp(old->config_rom, config_rom, 6 * 4) && old->state ==
>FW_DEVICE_GONE

If so, atomic_read() should be used, however I avoid it since the access
to state member happens twice in in the path to reuse the instance.

>> +}
>> +
>>  static void fw_device_init(struct work_struct *work)
>>  {
>>  	struct fw_device *device =
>> @@ -1071,13 +1032,51 @@ static void fw_device_init(struct work_struct *work)
>>  		return;
>>  	}
>>  
>> -	revived_dev = device_find_child(card->device,
>> -					device, lookup_existing_device);
>> +	// If a device was pending for deletion because its node went away but its bus info block
>> +	// and root directory header matches that of a newly discovered device, revive the
>> +	// existing fw_device. The newly allocated fw_device becomes obsolete instead.
>> +	//
>> +	// serialize config_rom access.
>> +	scoped_guard(rwsem_read, &fw_device_rwsem) {
>> +		// TODO: The cast to 'void *' could be removed if Zijun Hu's work goes well.
>
>may remove this TODO line since i will simply remove the cast with the
>other patch series as shown below:
>https://lore.kernel.org/all/20240811-const_dfc_done-v1-0-9d85e3f943cb@quicinc.com/

Of course, I won't apply this patch as is. It is just a mark to hold
your attention.

>> +		revived_dev = device_find_child(card->device, (void *)device->config_rom,
>> +						compare_configuration_rom);
>> +	}
>>  	if (revived_dev) {
>> -		put_device(revived_dev);
>> -		fw_device_release(&device->device);
>> +		struct fw_device *found = fw_device(revived_dev);
>>  
>> -		return;
>> +		// serialize node access
>> +		guard(spinlock_irq)(&card->lock);
>> +
>> +		if (atomic_cmpxchg(&found->state,
>> +				   FW_DEVICE_GONE,
>> +				   FW_DEVICE_RUNNING) == FW_DEVICE_GONE) {
>> +			struct fw_node *current_node = device->node;
>> +			struct fw_node *obsolete_node = found->node;
>> +
>> +			device->node = obsolete_node;
>> +			device->node->data = device;
>> +			found->node = current_node;
>> +			found->node->data = found;
>> +
>> +			found->max_speed = device->max_speed;
>> +			found->node_id = current_node->node_id;
>> +			smp_wmb();  /* update node_id before generation */
>> +			found->generation = card->generation;
>> +			found->config_rom_retries = 0;
>> +			fw_notice(card, "rediscovered device %s\n", dev_name(revived_dev));
>> +
>> +			found->workfn = fw_device_update;
>> +			fw_schedule_device_work(found, 0);
>> +
>> +			if (current_node == card->root_node)
>> +				fw_schedule_bm_work(card, 0);
>> +
>> +			put_device(revived_dev);
>> +			fw_device_release(&device->device);
>> +
>> +			return;
>> +		}
>
>is it okay to put_device() here as well ?
>put_device(revived_dev);

Exactly. The call of put_device() should be done when the call of
device_find_child() returns non-NULL value.

Additionally, I realize that the call of fw_device_release() under
acquiring card->lock causes dead lock.

>>  	}
>>  
>>  	device_initialize(&device->device);

Anyway, I'll post take 2 and work for its evaluation.


Thanks

Takashi Sakamoto

