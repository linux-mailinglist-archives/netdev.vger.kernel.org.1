Return-Path: <netdev+bounces-279852-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCBMM85c5mmtvAEAu9opvQ
	(envelope-from <netdev+bounces-279852-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:05:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F7D430831
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F7E531E9013
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ABB3382DC;
	Mon, 20 Apr 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b="kZtsaVTz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HMl/DKAp"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F19333439
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699117; cv=none; b=RE7o/0cbEB+DkGYmxHLhp+/hIXWdfey2lRfmrXzoyxcJF9iQcOJIR1hheL+L8w/CVegHveEfpZeIy5WoxFwkFzecqq1HX8CcYEgPAoCQRLNtxrhR3Ci6+IUSHDfP3mWOt09TEXQwm0wopjn6Cx5Wz7GOy9nHCvIVLGxmAyxhBjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699117; c=relaxed/simple;
	bh=Aw50v2OacGqCLnn9c0bXE2NQavt3GCguqKhcX160PXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZzsPR0aryDIFj3v31LVW05hyOY/r/xJJXK3bDXcJuEzasrObve3gB5EEGo5daOWJ8DXAix0Gp5nSCj5dBMM8RpeYq6xhO2eTOEYbH6tbZOnszzpuTDS6JMqJvT83LZJlJ5ltqe1/E99AH6B+ONmzcswldtMHfIC6q8i2JRhBDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com; spf=pass smtp.mailfrom=animalcreek.com; dkim=pass (2048-bit key) header.d=animalcreek.com header.i=@animalcreek.com header.b=kZtsaVTz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HMl/DKAp; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=animalcreek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=animalcreek.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CAF31D000A4;
	Mon, 20 Apr 2026 11:31:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 20 Apr 2026 11:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=animalcreek.com;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1776699114; x=1776785514; bh=cbclFDjEh0+xZ8RsOX5grsGolKeQxd7u
	YIt9WzBXa+c=; b=kZtsaVTzz0B9ukLmHvt8rcEJmFdYNrHV+KMRBF+MEWmFu3IZ
	xP2y4WYXaMsx3V9Ob8OY3OAUygOCWmUuhhaOTi0OqGqz2RNTNo/hMLaJHTvdwND1
	gwbdhUIQFM1IGE2/QTsHSs2buzhd8JNWZdypKcGpmoSIj7nwXLXUu5cCqwP8bI3v
	ZQie3RBbuaLgO66WB3UQH8FkMy56ihZTEDt6HvMA8p3bYCezGPYFQXSvcrA9QBqR
	56rNUw1d1uLH3QwCxc9uyXidoWT4iuc8W45lORTeLjEFw+C0YoNvOdMxdf6YLF4r
	Qx1eNwpNIxFMmU1lvLDufFKszj7ftnn9hd4n3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776699114; x=
	1776785514; bh=cbclFDjEh0+xZ8RsOX5grsGolKeQxd7uYIt9WzBXa+c=; b=H
	Ml/DKApoBcFuwpAAKGDTjLII0ScT9X3nmpfymYS6SMz0AAqsj5BRNrUBventfd5g
	WqV7J/7x7GtbCZRDajPF9ybI4XKH1wNeNzMr/IriGX/hFwMM4UubEJc/JnR6z3gw
	HJQTYO2mQewT6IUtSNFOg2ieeWCjWuVRDgosgcMDfQWrP3ZnwRCiHj1xQqn1lO6P
	zXIvyb3S+u6HI+DOHo/v5zaxvNXUZvO+i7sHiKV0SptwzSUtYVC4RzojgpO79xnV
	KriIM9AhviDLqefu5u4Tzd1Met+fsvvtHcEUshyJXI0dA50HfuDMXXTBs8409Fwo
	Zh70Js0cCb3NaAE6kvQIA==
X-ME-Sender: <xms:6UbmaU7IFH1YfmOtNdvOFJSp-bNSeESQrHNRBYul7Q1brKSo5q7irw>
    <xme:6UbmaYc9a2z6sVx1Ag6XtfA6dZa_xljUa7I8q_26bEESck0qaUrJjgsC9pa64NgBW
    JWBDCciRTztp2GDXOwz8A5mkQ8M1ALz6bTosseFUbszfk2jmeiBNjQ>
X-ME-Received: <xmr:6UbmaXFRgtTjaIQxCO_tz9Svw4xITRsNJC_s5bb5BGHvy2zxZm2F2jsFEV3osVBUhkKwtOOJF-aR9RK-LThd-m-gCTiY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhohgjtgfgsehtkeertddtvdejnecuhfhrohhmpeforghrkhcu
    ifhrvggvrhcuoehmghhrvggvrhesrghnihhmrghltghrvggvkhdrtghomheqnecuggftrf
    grthhtvghrnhepgfduueeiffdtveejteetueeutdefhfdttdeuuefhleeiueefvdegvdeh
    ieeukedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmghhrvggvrhesrghnihhmrghltghr
    vggvkhdrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhgsrgeskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhdrthhhrghlmhgvihgvrheshh
    grlhgvrdgrthdprhgtphhtthhopehrrgihmhhonhguhhgrtghklhgvhiesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhesfigrlhhlvgdrtggtpdhrtg
    hpthhtohepsghonhhgshhurdhjvghonhesshgrmhhsuhhnghdrtghomhdprhgtphhtthho
    pegurghvihgusehigihithdrtgiipdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhgrhgvvghrsegrnhhimhgrlhgtrhgvvghk
    rdgtohhm
X-ME-Proxy: <xmx:6UbmaZToYLBGVNw52aZQ9ZHgGevRg5Ee8PuDHoFESjcxBPltF_Snhg>
    <xmx:6UbmadYuKGzldB4MjnFm19GPVwwbKNA68_fVBPSR7fmI1XHPLVlMYQ>
    <xmx:6UbmaU3rGfrTuog1T8DgFm5I8vdQfQS8HiSnhZPwH3kVt3E3b5bc8w>
    <xmx:6UbmaQpac0Bh4_EBidAKuqjtb2j2JGpoH0JiIcHjqVM12n4C3g1XXA>
    <xmx:6kbmaQ7AldniaFi_BQAjmAMNk4QW_Z_u10MwkZNsCi9aElN9iweue5lt>
Feedback-ID: i9cc843c7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 11:31:52 -0400 (EDT)
Message-ID: <8491d513-7475-44a9-9262-7260cf52bc18@animalcreek.com>
Date: Mon, 20 Apr 2026 08:31:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Path forward for NFC in the kernel
To: Krzysztof Kozlowski <krzk@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Michael Thalmeier <michael.thalmeier@hale.at>,
 Raymond Hackley <raymondhackley@protonmail.com>,
 Michael Walle <michael@walle.cc>, Bongsu Jeon <bongsu.jeon@samsung.com>,
 David Heidelberg <david@ixit.cz>
Cc: netdev@vger.kernel.org
References: <20260416101041.4c533306@kernel.org>
 <9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
Content-Language: en-US
From: Mark Greer <mgreer@animalcreek.com>
Organization: Animal Creek Technologies, Inc.
In-Reply-To: <9c4a4acf-b4f1-4e84-93bf-cdf080cb9970@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[animalcreek.com:s=fm3,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279852-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[animalcreek.com];
	FREEMAIL_TO(0.00)[kernel.org,hale.at,protonmail.com,walle.cc,samsung.com,ixit.cz];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[animalcreek.com:+,messagingengine.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgreer@animalcreek.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95F7D430831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[Trying this again hopefully without HTML.]

On 4/17/26 12:18 AM, Krzysztof Kozlowski wrote:
> On 16/04/2026 19:10, Jakub Kicinski wrote:
>> Hi folks! We are struggling to keep up with the number of security 
>> reports and AI generated patches in the kernel. NFC is infamous for 
>> being a huge CVE magnet. We need someone to step up as a maintainer, 
>> create an NFC tree and handle all the incoming submissions. Send us 
>> (or Linus if you prefer) periodic PRs, like WiFi, Bluetooth etc. do. 
>> If that does not happen I'm afraid we'll have to move the NFC code 
>> out of the tree, put it up on GH or some such, and let it accumulate 
>> CVEs there.. I'm planning to send a PR to Linus to shed the 
>> unmaintained code early next week. We need to have a maintainer 
>> established by then. 
> +Cc David Heidelberg recently trying to use Linux NFC stack, Just 
> "collecting" patches is not a big deal, I could do this, but actually 
> reviewing the patches with necessary due diligence is the effort I 
> could not provide in a reasonable time frame. And picking up patches 
> without proper review feels risky... NFC has a long history of issues, 
> first mostly pointed out by syzbot but now apparently by AI tools. The 
> code base is quite old, with no major improvements or testings 
> happening but not in a way "oh, it's stable and working like 'cp' 
> command" but rather "no one knows how many bugs are on top of each 
> other and if it actually still works". Syzbot and AI reported bugs 
> encourage random drive-by fixes by people not testing the code, thus 
> particular bug report might be fixed, but for example NFC stops 
> working and no one knows that. Does anyone knows if the NFC 
> stack/drivers actually works fine? Did anyone test actual devices? If 
> not, then moving to Github would be even more reasonable. Another 
> point is that AFAIU, most of real world devices, like Android-based 
> phones, don't use the Linux NFC stack but their custom HAL/user-space 
> based libraries and drivers. Some other non-Android projects use 
> libnfc userspace, which seems to be maintained only as bugfix 
> (https://github.com/nfc-tools/libnfc/commits/master/). Best regards, 
> Krzysztof 

That is my understanding too.

I would love to take this on but I've been swamped for years with my 
"day job" and I'm pretty burned out.
Taking on something like this isn't possible for me. I also didn't 
realize it was creating so many CVEs so,
yeah, sounds like it should be removed then. Thanks for all of the work 
you did on this, Krzysztof.

Mark
-- 



