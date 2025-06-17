Return-Path: <netdev+bounces-198724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED0DADD53D
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A35A406CBC
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C222EF2A5;
	Tue, 17 Jun 2025 16:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="SMO5DGUh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cwlo93Qy"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49E2EF286
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750176399; cv=none; b=iqGnMB39Nazl9J54nay+Ijr56km9gAKGEorKCBNqQ1iOZtU4lAQ/MpSgvVjBPle9ER8In0ZRUpoBTU9aPSswyWQXbylJLcpzVzZYAyyKR52n0I6jUcReQ+IrV2HkA0jt6S5D30EQefD3VRssjA7gBEiVWQj4XLSKlXNx69Jf3kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750176399; c=relaxed/simple;
	bh=o1XHPxZy63aJwpoBVbLCl3BWxUFqib33BiLjtEyywdY=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=EqJPKILACOI7C98IbYTffB7rVKY6FG1EOCX/DrFFfS+0kZsOUWXUz6tXO7MDj56AHIhngQSBrrCxjHQHdiG45fJo9oUaIvL2sz+wjAt5RV62pAkvrNwyzNmqR/jcw6sKuCO5XHCMSoiEcAEZbYOqCe/SerzQcqQ/1CvROsCFDTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=SMO5DGUh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cwlo93Qy; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E8DF1140088;
	Tue, 17 Jun 2025 12:06:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 17 Jun 2025 12:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1750176395; x=1750262795; bh=mLlK6eOejIG/AZal9j/RE
	8F4XrUr5J5ycIWdVy/MU2I=; b=SMO5DGUhflUkjxXYFnNvxwp1azjiqUpGH6xB9
	ChgKQcMV85y/ar6UW40ArpEnM6wHFGaYcsh1YQxQxq0EHiwv31lUnHqwlJe74/7f
	jl/CC/kgS/XO1Belidqy6Rl6moTHoG97oSizw/o+sTQpc8nfN0hLl7puFzFngctW
	GNEDu489ShIj8ynTjrF2Mq7ozfh+QWNATSu3ZeohoSQpNJ0hU3vmva16sVcH30if
	X5voEFMkSeoenoTHrkAqp5WuPRkwdqrjjcqS7xdg9HIietOvMd9RkoggoDyePTSt
	KLD1s1Ns4Hg+cxKE5Vhu9bnu1Za/xxQPTA2Nsvt9tfgelXs1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750176395; x=1750262795; bh=mLlK6eOejIG/AZal9j/RE8F4XrUr5J5ycIW
	dVy/MU2I=; b=Cwlo93Qy5s5B4L8PIOf8lgwQfRmo1eQjr2zrgrFv7IQAiBq2cXG
	7x9RUKk6HFEuixQFke3KCzoNmWfsETplguqNoWthBLMnZwmUIp1M/V8JbkgzF0Ii
	2RtUuvjozK/yIG9qY+UlscAivwQJO3Xoy5oCn+w8updb/qaMOV3S861vQ3t3COJE
	fwdoUEASlo7FoL+5WAeyinjSr3tufPc6NhJeCqkRDDZYhnDhYYu0Fh1JWgg+yi3l
	1KJvWLIBPRdiawc0EJ38SYxmHDl4ah5fcYVxp7dvOscjzGs0ZXJOwgG2CkaO1jBj
	S1Khe3r9SAQ+8E8EH19krgDc7VTk4fwWBTA==
X-ME-Sender: <xms:i5JRaMhNDiLuxkcalistpNiM61qLCjlZZe_mi_7CBSW46uINt_NA1Q>
    <xme:i5JRaFDqTsboXryVksjNvGyTbeL0H4K2Al750H2P1Z4jMaSY8KCX0ebFjsZsIU_GH
    CDrXsUPGQFMVRrJ_hk>
X-ME-Received: <xmr:i5JRaEH8Pa8ZxmovbxqCoYH061uecRvfgq98RNRZnhizvtCRk7LZcGmxWLCrPAz35dyMKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvden
    ucfhrhhomheplfgrhicugghoshgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvg
    htqeenucggtffrrghtthgvrhhnpeeifedvleefleejveethfefieduueeivdefieevleff
    uddvveeftdehffffteefffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjvhesjhhvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohep
    jedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhrrgguvggvphhssehlihhnuh
    igrdhvnhgvthdrihgsmhdrtghomhdprhgtphhtthhopehirdhmrgigihhmvghtshesohhv
    nhdrohhrghdprhgtphhtthhopegrmhhorhgvnhhoiiesrhgvughhrghtrdgtohhmpdhrtg
    hpthhtohephhgrlhhiuhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepphhrrgguvggv
    phesuhhsrdhisghmrdgtohhmpdhrtghpthhtohepfihilhguvghrsehushdrihgsmhdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:i5JRaNQ51nz0Sgrjhgw-BLFS3Y8yUh81aYpqlzxbR8OuTrlegE0_2Q>
    <xmx:i5JRaJzb3gJObqxuViiVS16KdZOJgxHJ-YfmW892Vu2nXDRuNep56A>
    <xmx:i5JRaL5F6K5dxaF3Pm0CEGryUlqlMY-2kxwlEZ1_t4CwJbdD2hVyuA>
    <xmx:i5JRaGz3U6n4fbA0lhD19CckoXs-UUNGo2v_LGfhtL_CGvU8VYiGZQ>
    <xmx:i5JRaNJEhxOke2ICgEeNx_xPinI7lor5S-Vx5vNCOwrc5Ml6vfJ8TRuw>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jun 2025 12:06:34 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id A591B9FCA8; Tue, 17 Jun 2025 09:06:33 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id A44599FC65;
	Tue, 17 Jun 2025 09:06:33 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: David Wilder <wilder@us.ibm.com>
cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
    "pradeeps@linux.vnet.ibm.com" <pradeeps@linux.vnet.ibm.com>,
    Pradeep Satyanarayana <pradeep@us.ibm.com>,
    "i.maximets@ovn.org" <i.maximets@ovn.org>,
    Adrian Moreno Zapata <amorenoz@redhat.com>,
    Hangbin Liu <haliu@redhat.com>
Subject: Re: [PATCH net-next v3 2/4] bonding: Extend arp_ip_target format to
 allow for a list of vlan tags.
In-reply-to: 
 <MW3PR15MB3913A782BBBCFEC112E1A662FA73A@MW3PR15MB3913.namprd15.prod.outlook.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
 <20250614014900.226472-3-wilder@us.ibm.com> <1928187.1750115758@famine>
 <MW3PR15MB3913A782BBBCFEC112E1A662FA73A@MW3PR15MB3913.namprd15.prod.outlook.com>
Comments: In-reply-to David Wilder <wilder@us.ibm.com>
   message dated "Tue, 17 Jun 2025 15:45:57 -0000."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1969717.1750176393.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Jun 2025 09:06:33 -0700
Message-ID: <1969718.1750176393@famine>

David Wilder <wilder@us.ibm.com> wrote:

>
>
>>        Here, and further down in bond_arp_ip_target_opt_parse(),
>>there's a lot of string handling that seems out place.  Why isn't the
>>string parsing done in user space (iproute, et al), and the tags passed
>>to the kernel in IFLA_BOND_ARP_IP_TARGET as an optional nested
>>attribute?
>
>>>+              }
>
>>        There is no expectation that sysfs should support new bonding
>>API elements; only netlink / iproute2 support matters.  If sysfs is the
>>reason to do the string parsing in the kernel, then I imagine this could
>>all move into userspace.
>>
>>     -J
>
>Module parameter support also requires string parsing in the kernel. Can =
that be dropped as well?

	Yes.  New bonding functionality need not be supported by sysfs
or module parameters.

	-J

---
	-Jay Vosburgh, jv@jvosburgh.net

