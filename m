Return-Path: <netdev+bounces-279159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yB+3JOhD4WlErAAAu9opvQ
	(envelope-from <netdev+bounces-279159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:17:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD43414857
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 581F73032750
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02D63ED5DD;
	Thu, 16 Apr 2026 20:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b="MJJuG/z6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ygw6tFlu"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694F436EAB2;
	Thu, 16 Apr 2026 20:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776370326; cv=none; b=H3ytYR9oUrQeGy4ZjBfGss29WxhGCPxhve214sYEINO9SZFKlN7osLevOnrP/FRDtn/VQFy971LRVKhXvoeiZr7MMY/6NHsp6jGaTZwI1nJpIalEceGhtlMCyLmPUzpR7eC5FF4yKgshTIHYFwlUkfTQWuiiKSli5LomWKQVC24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776370326; c=relaxed/simple;
	bh=L+TQPUEqXk6q+CHjxofqPSLdFhHt0fFNBd9YXgQf4kA=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=pc29vM2seQxplM2EuGr22LWT7Ng0UPw49kAuTmfacTuZ5JY8dPKDOZKeNb0uLU2qH+XBiYBul9R2rcTg8dOq7DQL28Qm9nn4TUTlgtOGna3Nv0iht/p+OIOigqxZD0qc+gmTnb7/ube7eJyK3MVaTFbteb6cg1mqUszSvqSwDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net; spf=pass smtp.mailfrom=jvosburgh.net; dkim=pass (2048-bit key) header.d=jvosburgh.net header.i=@jvosburgh.net header.b=MJJuG/z6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ygw6tFlu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jvosburgh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvosburgh.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D7748EC004E;
	Thu, 16 Apr 2026 16:11:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 16 Apr 2026 16:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvosburgh.net;
	 h=cc:cc:content-id:content-transfer-encoding:content-type
	:content-type:date:date:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to; s=fm3; t=1776370316; x=1776456716; bh=7QwwJQElEWF97WU4fng9x
	1lkKwLataMrHDRU3MK1aso=; b=MJJuG/z6NC2zcvdKWbxVGdoKJdtfvZ46KLjHF
	N/L/vz5Ip/GiMfmhvT6nF6nlF1wWxnAuu277DDjG2m1WMN1p2T2jnoIMXmB32daL
	VTqDEYlNlKoSJZ2/HB+6bB7FfDuVWJ1SkXJVLEp1wX2NbN9CFFt5i61pUYxy/De3
	r5EQ71ZYdncmfTZTbWGONrRcnh9NQjve7L8IRyaN6n4HP1yKxfLR4ArOm9ofH6Qc
	RBxuJKCn/dJmCLxK0xeAZiQugfGAQe07EnlSOM8HQuzLgC0+GsSCmmgmFxLXz06x
	QxIVUxnkggE+G87cHbCkztp5CnKI+2ndThsSRdJ8Gup3+M6vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-id
	:content-transfer-encoding:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776370316; x=1776456716; bh=7QwwJQElEWF97WU4fng9x1lkKwLataMrHDR
	U3MK1aso=; b=Ygw6tFluYhpjpxfU0WF+2erd+p7ypMzI/sEHVAFAeXEXQPhnl25
	egd0q0TiwmA1BTDhLhGwO8+xmztO0i+raDZeyiORMNVU7fZMnIsmZugho/+96W60
	A0C98focxY/g7ajqAGstiVI8K5HkCkkEMO/cpkMcm+ALrU9Vk6DzUEYPkFVQ1SnM
	5nn2tqIznT0JU3rld/OibJV3/GI2TqmnZgL2WpD2MeqWQ/CjN8SEf/+Em7ajnRnA
	hajsfbJXMqGKVQbz6jJ1EjJ9VhZM+Ldk1/B4Hl1/KIKNY2yCai0unIuXKQnLDJBp
	cLWDjEgLl/6q6YeUAgBGnoufZwg4k/kS+Ow==
X-ME-Sender: <xms:jELhaU1qF5sFWI7H4xyD3aLetFsLubLyfxVxIWzt7Sf8t1uf6i7azQ>
    <xme:jELhaXNCdALCxz0NzVjxJQ4e4JE0Irf6_r6WuB8HnNo0xnS2eVa3vn9cB4bImHBWl
    Eg-faHkxl8Wol9iqPxdMbRdB5rUFo8eXTLXvUzSxPvmt60ET_dLCEo>
X-ME-Received: <xmr:jELhacaq0ER8DHStwWd4udr15XGJIunyUoZmag9Ng96wMW0bJKEmL2qsD4iDLfSokqA8Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhfogggtgfffkfesthhqredtredtvdenucfhrhhomheplfgrhicuggho
    shgsuhhrghhhuceojhhvsehjvhhoshgsuhhrghhhrdhnvghtqeenucggtffrrghtthgvrh
    hnpeeifedvleefleejveethfefieduueeivdefieevleffuddvveeftdehffffteefffen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjvhesjh
    hvohhssghurhhghhdrnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htoheptghhrghkrhgrsghorhhthihshhhusghhrghmieeisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuh
    hnihihuhesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hskhhhrghnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptgho
    rhgsvghtsehlfihnrdhnvghtpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtg
    homh
X-ME-Proxy: <xmx:jELhadwYOTsk5SaJv-2YfIHlQhxP1JXTkhKol_2ITbJ2zqkCnQzd-Q>
    <xmx:jELhaTNfZbOJ10IWWa0F0tbrTUmOMDxrxPDLJqhRfYc5ku5q98gDww>
    <xmx:jELhaUf6Itjz_m5jHG6wBFjCkL-OKGIkYam6IxL-khb57ePMfP1-tA>
    <xmx:jELhaQRlHliBYurUAcFV2d8CmgJ5u-dub1doh-6D94phoAq22ExPNg>
    <xmx:jELhaSRCPxP-WNfrY3IkD-p4Gu6mHfWLrJFoIeQJqqBOXlEgq4_Tjeqm>
Feedback-ID: i53714940:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 16:11:56 -0400 (EDT)
Received: by famine.localdomain (Postfix, from userid 1000)
	id 54FF89FB64; Thu, 16 Apr 2026 13:11:55 -0700 (PDT)
Received: from famine (localhost [127.0.0.1])
	by famine.localdomain (Postfix) with ESMTP id 523919FB3D;
	Thu, 16 Apr 2026 13:11:55 -0700 (PDT)
From: Jay Vosburgh <jv@jvosburgh.net>
To: Simon Horman <horms@kernel.org>
cc: Shubham Chakraborty <chakrabortyshubham66@gmail.com>,
    netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
    kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
    corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: sysctl: document net core sysctls
In-reply-to: <20260413164707.GT469338@kernel.org>
References: <20260407083213.27045-1-chakrabortyshubham66@gmail.com>
 <20260409174859.11854-1-chakrabortyshubham66@gmail.com>
 <20260413164707.GT469338@kernel.org>
Comments: In-reply-to Simon Horman <horms@kernel.org>
   message dated "Mon, 13 Apr 2026 17:47:07 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; Emacs 29.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <874686.1776370315.1@famine>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 13:11:55 -0700
Message-ID: <874687.1776370315@famine>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvosburgh.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[jvosburgh.net:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279159-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jv@jvosburgh.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[jvosburgh.net:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: DAD43414857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simon Horman <horms@kernel.org> wrote:

>On Thu, Apr 09, 2026 at 11:18:59PM +0530, Shubham Chakraborty wrote:

[...]

>>  netdev_budget_usecs
>>  ---------------------
>>  =

>
>The lines above the following hunk are:
>
>netdev_budget_usecs
>---------------------
>
>Maximum number of microseconds in one NAPI polling cycle. Polling
>
>> @@ -297,12 +332,16 @@ Maximum number of microseconds in one NAPI pollin=
g cycle. Polling
>>  will exit when either netdev_budget_usecs have elapsed during the
>>  poll cycle or the number of packets processed reaches netdev_budget.
>>  =

>> +Default: ``2 * USEC_PER_SEC / HZ`` (2000 when ``HZ`` is 1000)
>> +
>
>Well, that is awkward.
>
>Looking at git history, it seems that this sysctl was added by 7acf8a1e8a=
28
>("Replace 2 jiffies with sysctl netdev_budget_usecs to enable softirq
>tuning") in 2017. And at that time the unic was us, and the default was 2=
000 us.
>
>But that was changed by a fix for that commit, a4837980fd9f ("net: revert
>default NAPI poll timeout to 2 jiffies"), in 2020. As a side-effect of
>that commit, the default was changed to what you have documented above,
>and the unit changed to jiffies.
>
>So while what you have is correct it seems nonsensical to me for the unit
>to be jiffies. Because that's not a meaningful unit for users. And becaus=
e
>the name of the sysctl ends in usecs.

	I don't think the units for netdev_budget_usecs are actually
jiffies, even after a4837980fd9f.  The default value, for example, is
2000 if HZ is 1000.  However, the granularity of the measurement is in
jiffies, via:

static __latent_entropy void net_rx_action(void)
{
        struct softnet_data *sd =3D this_cpu_ptr(&softnet_data);
        unsigned long time_limit =3D jiffies +
                usecs_to_jiffies(READ_ONCE(net_hotdata.netdev_budget_usecs=
));


	I'm not sure offhand if usecs_to_jiffies rounds up or down, but
the netdev_budget_usecs looks to be interpreted as usecs.

	-J

>But I'm unsure what to do about it. Since changing the unit this would
>represent (another) KABI break.
>
>* Add another knob that shadows this one (But what to call it?)
>* Simply remove this one (KAPI break)
>* Change the unit of this knob (KAPI break)
>
>If the code is left as is, then I think it should be documented that the
>unit is jiffies.
>
>...
>

---
	-Jay Vosburgh, jv@jvosburgh.net

