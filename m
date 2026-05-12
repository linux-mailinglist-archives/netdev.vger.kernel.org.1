Return-Path: <netdev+bounces-287267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMhGBfdzA2rl5wEAu9opvQ
	(envelope-from <netdev+bounces-287267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:39:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D98D527EE3
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 20:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01CDA3009F3B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C6B308F03;
	Tue, 12 May 2026 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="w+APLFvZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B542DE6F8
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 18:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778610917; cv=none; b=e2YvQMrFzfPCNAMtCoN7YBxrjW1ddAV/PxzFgPBJtqX1k+z3SoyPpN+e6c9gAgmkCMSlxYyG0ZYOjGqYLeh88bM7759yXiNB56ymdmgePHeh036ab5HSb3pvpu1LTtf8oZn9W6yt0MOWAmHqWF8Y3c/IPCYhjhd43QbOnrtiByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778610917; c=relaxed/simple;
	bh=tpx/Mo33YZRPuGNo2ZG79570yOSTf76m9zQ3fljpeBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWIgYhZeyZn8MdcIKNpyvDrZYfPrHobXyvUlAKiGjstqU9iE4JRsEWQhIayUvhZGDx9ZYYzxEinbnJ6bOGIhWWLPN9CZsgl6K28rKMC7+kcCj6U57ytYrwSLDMIeoS3a3ete9Lnvz7S93/alTz9cvdE6Y/LXRy2i7TU6v6n8kPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=w+APLFvZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891b0786beso38037195e9.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 11:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778610914; x=1779215714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=448c9IXFWf3BzecYkP3HsCZJTYpIC1o7jRhCi9pch8w=;
        b=w+APLFvZXBkz+9eaCLuLAF2s7qu2uwT7EaiEA3Jc2pFzGocciws+4cxdOi7tJUoWyJ
         FLBku92a27xkhkMHmN6K98vSiFwnotvTxBu/kq4ll9ygGVlxk7Nnwb6UMdcTJW8giI0F
         yUUV2NdGZP6Bk0paRNpDyaPs7ukA1yMjdS/sBbWLoduNLcAMeazIKy7BHrh9Sxfes84I
         JVPO6ghXwGa7OC9pRJSI9CCGJ68tefBQpRch+M3j9dmmwY5kvdD8unYhr7MPI4afFZK+
         1PPw7CQnJ/kOWZZIEs7Djo9oRYYAvmTqwJEbPTeqbr2GPV7CX92Lhxb7SHKWxsQXevk0
         HKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778610914; x=1779215714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=448c9IXFWf3BzecYkP3HsCZJTYpIC1o7jRhCi9pch8w=;
        b=qdDAMtIcDaycBZcg/SnzFJWxsfyCwGReQqrCOZhxUOeBKH3EEIvndfjqdBR6Mudk57
         97cEPBNwzDCzfPSIYtkPPvV4u2KAQlprarYQOst0hqHhmJMc9eeESGJj0/zs4R7s2Pui
         a78TNex3WWJUxP0u/URcU34UmLYrFZGexYXkOH/I7hbvclfShKbP79rsoIrhLnZTOFsS
         vxm31pmHj8jjPLw/U1tSKZpd8J+pQsOwZcD3XaWej3jwOkEbU2lpXFD5+4C3VHvcCnNp
         GfB73Apl0HWS3L/TnSVBB77RGpUu/i6sVwk7NPWEVzJKciUErR9ABuLTbKjWIQK8P/Zu
         BYMg==
X-Forwarded-Encrypted: i=1; AFNElJ9vBu7+nI1vJC/ujyD6vIvp9snFMorkmzrUCm9rDwAZ/5ziQ/pwvy//DD6grbv512xn8tdWq1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgsiuhhm1Xd81P6QkkgmqMKwgL8YNR2wCTmlMKhQ1jtALxDqON
	MnRaX1eD7EkgbRTpl0WqZRyRDLWLtcGXSvtW0czvIe/zeNb9qY/rzlDE+3hRK6mKpJc=
X-Gm-Gg: Acq92OFR3/UnyCu7jUvQ9SZLuO6yJ0zgJ2Uqw+j9AuuohHQcKT/pU7lBiHFCbnmaA9D
	3Mr95jc8k7ZxyWieAPac8/6SlDkEkQIEMl13cAl5NuziS55w93rRroaNQ4HJO7MJrKHjaZRIkbG
	Cn2tzdXTz+k/6LFdPSHr88A36t4FT6TIYCfXOzNv+7J3bkBq9r4+w2Xqn8IIHPPR9kotiA32F+o
	XFgliknKYtw4M4DLWuFG6HtRJJSLBEsJ9ErKFC6Iiva5+qFy0av+ZxIev4pMbuI0LPIuYKWI5wj
	60MuCSAZfWDHrzRLmCKsXkKjjTWAUf64nGdzlLX8F40htSS5Ju2e3ZkbRKVrpFFx4r2stxinUSW
	Ah5fJA2STAs79tZy5Vx6rteE/86Dvnze54l4HygpRnOw/KQL0BumVGdxqXRB+jIhftoZrooZBeY
	xNhKtKP1/QEmqH2sn51OFaRUHyZ4e/D9Xctw==
X-Received: by 2002:a05:600c:8b41:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-48fc9a33179mr1144555e9.17.1778610914207;
        Tue, 12 May 2026 11:35:14 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.211.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fc8d21c72sm13265985e9.7.2026.05.12.11.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:35:13 -0700 (PDT)
Date: Tue, 12 May 2026 20:35:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Parav Pandit <parav@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Christian Brauner <brauner@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Eric Biggers <ebiggers@kernel.org>,
	"NBU-Contact-Li Rongqing (EXTERNAL)" <lirongqing@baidu.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <agNy3RF9WCHBPev5@FV6GYCPJ69>
References: <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
 <SJ0PR12MB68068C50EE9776A3D9060635DC382@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agLoeZtsSizR-R24@FV6GYCPJ69>
 <SJ0PR12MB68061C61AA2BF5D81005984FDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
 <agM0DsiaAH8-Ox7N@FV6GYCPJ69>
 <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB6806D8ADF943B30AD3B479CCDC392@SJ0PR12MB6806.namprd12.prod.outlook.com>
X-Rspamd-Queue-Id: 0D98D527EE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287267-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Tue, May 12, 2026 at 05:25:21PM CEST, parav@nvidia.com wrote:
>
>
>> From: Jiri Pirko <jiri@resnulli.us>
>> Sent: 12 May 2026 07:37 PM
>> 
>> Tue, May 12, 2026 at 03:48:32PM CEST, parav@nvidia.com wrote:
>> >
>> >> From: Jiri Pirko <jiri@resnulli.us>
>> >> Sent: 12 May 2026 02:16 PM
>> >>
>> >> Mon, May 11, 2026 at 08:21:37PM +0200, parav@nvidia.com wrote:
>> >> >
>> >> >> From: Mark Bloch <mbloch@nvidia.com>
>> >> >> Sent: 10 May 2026 06:02 PM
>> >> >>
>> >> >
>> >> >[..]
>> >> >
>> >> >> > I look at it from the perspective that from some CX generation,
>> >> >> > switchdev mode should be default. So that is a device-based decision.
>> >> >> > I believe as such it can optionally be permanenty configured (nv config)
>> >> >> > on older device. Why not?
>> >> >>
>> >> >Because sometimes switchdev_inactive is needed and sometimes not.
>> >> >Such knob is not device decision.
>> >>
>> >> That is what I would call corner case. In that, user can use userspace
>> >> configuration to change the mode in runtime.
>> >>
>> >Corner vs common depends on users one talks to. :)
>> >If fw has switchdev(active) as default, and then
>> >And user needs to run switchdev_inactive, it will actually break their switching applications.
>> 
>> Can you describe the actutal breakage please?
>> 
>Driver default was switchdev so all the traffic is forwarded to the switch,
>and user didn't have chance to setup the fdb rules.
>So packets are dropped but user didn't expect the traffic to be forwarded.

User may switch mode to switchdev_inactive early on, before any of the
representors are created. What's the issue then?


>
>With this RFC, the device would start in the switchdev_inactive.
>And user's goal is achieved.
>
>> >
>> >So, one needs to invent switchdev_inactive in the FW.
>> >
>> >Jakub's suggestion in this RFC is covering both the scenarios uniformly without above problems.
>> >Single uapi for all the cases, so looks good to me.
>> >
>> >Moreover, do not understand how alternative solves such problems.
>> >i.e. user is unable to configure the fw because driver is not yet loaded/up.
>> 
>> See my other reply in this thread. I don't think there is a need to
>> configure anything in FW. If we fix the behaviour in switchdev mode for
>> non-sriov user and change the default, no fw knob needed. What am I
>> missing?
>> 
>If I understood your suggestion right, is it the devlinkd based solution?

The suggestion is to use "switchdev" as default with user configuration
no matter if it is devlinkd or something else.


>
>If yes, then Mark explained that it has the issue of all drivers to be loaded, followed by user space to start.

