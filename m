Return-Path: <netdev+bounces-256663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIx5D8Meg2nWhwMAu9opvQ
	(envelope-from <netdev+bounces-256663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:26:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD53EE4768
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 11:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01AF73032042
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06073D9034;
	Wed,  4 Feb 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hUNKuB4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357163D9045
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200741; cv=none; b=H/o4pJUCT3KTOb7qttX6P3aprocE87QU7XLJ03AR/NZDmUNRq27jwfbQgLR+eIzDoXcrqtw2w5zVfFlD4MNHPw2IpqPClf94HXgTjsX6WqewWeSwZT+2LxvudMGPGoJdAM7u7QBEAvOE1oThTKDQsjQCWpFoDj7q0eEXzK4tFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200741; c=relaxed/simple;
	bh=vIAYbL49p25ExRg+QYdlbw0Imd7iQ0xScAHgx9IcBvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIoqXhHAV8pAVIokG/3UjtQsEc2HShxeCo7kP0UDcDMRWEad2291wgDi9K2vnpjdZFhI7uOPHv9wtv14PIfP3yKZn24z3+cLApD6RQImFSi/75osm4J4Qu7apqNARvOWnmUdgmj1+kVLA3VM+PFH3SsrnfVMKncdgeTMt2m23C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hUNKuB4y; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-435903c4040so4454465f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770200739; x=1770805539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z5cfc484zykYZ0mPb5c+zfv5UtgQ5YWzwUO/DNgxgU4=;
        b=hUNKuB4yLA0YxtgxmXpwTDxq+j6kZEcU9LYJ2l4XzbwnKX/xbMyS29rBk+FFTo3ncc
         Z6WRACxBdoFXfvqMc2fEgH4qYxesEDF2UGjrz2G/+kH+WBiS0kutrlkGeZRPBdZ2JnJ4
         Z3Bvg7osVwUfBB4zENtNkEU8AisK6TWCvRO2PUFFDfRT7d9zBQUQlRpFLWOstS7LN6eG
         c3yUDjBhjg1aeqU/7DgW4IDPTlaUlV0TIV55ISYDJOCtifasiliPPq3PNt+6OmcuWNUG
         rug7tBR/x0T7tiBOn/yanl3olcbOs+ILUyiOnyrgGwEzFRHAz2uu5CRzrtVE/QFHCaqI
         PqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200739; x=1770805539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5cfc484zykYZ0mPb5c+zfv5UtgQ5YWzwUO/DNgxgU4=;
        b=ggcI7Bz7+EVADLqvS/hirExRQx7WbzLItALWcC8ptEAM2AHWfHGZzTKnfnOpPOpkk1
         mUaGNgBFj+VY4i2JQ6jSKHPgtZI7GBJWdVloU61Hsi7pFyfERuKZj6x4xi58GWN+2/L/
         1nKOeSXAliBV66J6XVhwzTyj7I50YQcoe4BsuJwXpY04+aaVP7BmzFgzrY1oirjLJgg6
         Hw1az8wvKs5n7vnhaK2Qu4LR29lrB2v9zHK8+fHmGRzm3lM3dF6oAGJxljs2pROFuvmX
         QbEJxaQ+QAc/lrgvAcaL/58xCUCU0WwI9EOGhDnpjglpMEkxKeOUqOKXYUvT6hsC/6kw
         ARtg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOO4+YFwmWWaQ8zQhshgHhEwVALicNqkXM97KmIFeittNx1yCh4e19vyiDAXX5w7vNP6fusI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoN2iSJ8gzGJ3SW9psfg0Aab93EJTrIhnKf7iv5/sl6t6oV8Oz
	PpEf6NxSkR+T7jNJQYs+nM5HH9ZbyTBm6Fzc1lEmYBAgioIj3wNY44nGbzoiZpB9YA==
X-Gm-Gg: AZuq6aILayqWOKBezLvexXyPwrLWf/OOJXHr70f+tvFQsGQHci+wIoT5keepkPM3vXu
	qqvn8F3UJECj56CuUFwDn8oifk/ye4HWNTEVptyPSPPL0adnNJoYkVG82eUgZ/AU+IQ1ibXDNar
	kPEoIsn9sg6Jzz22aC9Zw7bj6kLEWo3P3NSqulO4wik9Zi3rd4F8ckQUal/0bIiSmq6K2VWKxn+
	kEcVphcWFBIsorDhbVITQJXZqU9PAmZJb0cvHtP+wlbZjEeaaPU5xJ9fAANja7lB+t3y7P3eUMV
	TSDnsZahdRe9nUDHZhnhg0Ldb+vLWWsiKdX3IDCOVi5ywaL6MOM0Lk9CP6MOfFaxR+Hw1O3uOvz
	l9aVGWOX2c/X84/bHDTaQccW3JnX98yHaedmaphAg0jusDgZzdYtOA/xhBet5dllm4WC9WUcmUd
	WI0Uyw1+0SRMFV6fh4nSNr0NkWyyAi6gl97fOuayAdmA==
X-Received: by 2002:a05:6000:2211:b0:435:db95:c2ce with SMTP id ffacd0b85a97d-43618061c60mr2812656f8f.55.1770200739223;
        Wed, 04 Feb 2026 02:25:39 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:dc18:ae3c:a190:c516])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e3a3bbsm5405366f8f.15.2026.02.04.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:25:38 -0800 (PST)
Date: Wed, 4 Feb 2026 11:25:33 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 1/5] lsm: Add hook security_unix_find
Message-ID: <aYMenaSmBkAsFowd@google.com>
References: <20260119203457.97676-2-gnoack3000@gmail.com>
 <20260119203457.97676-4-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260119203457.97676-4-gnoack3000@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[digikod.net,namei.org,hallyn.com,gmail.com,vger.kernel.org,oracle.com,buffet.re,huawei-partners.com,huawei.com,alyssa.is,google.com,kernel.org,zeniv.linux.org.uk];
	TAGGED_FROM(0.00)[bounces-256663-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,paul-moore.com,canonical.com,maowtm.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gnoack@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD53EE4768
X-Rspamd-Action: no action

Hello!


John:

Friendly ping; as Paul said in [1], we would appreciate a look from
the AppArmor side whether this path-based LSM hook makes sense for
you.


Everyone:

In [2], we are currently discussing how the UNIX restriction feature
would work in the bigger scheme in Landlock, and the current plan is
that long-term we would like to support semantics where a UNIX
connection attempt is allowed if EITHER:

 (a) the path is allow-listed in the policy, OR
 (b) the server side we connect to is part of the same Landlock
     sandbox ("domain")


With the currently proposed hook, (a) can be checked in the
security_unix_find() hook, and (b) can be checked in the
security_hook_socket_connect() hook.  Unfortunately, it also would
mean that if the (a) check fails, we would have to store that
information on the side (struct sock LSM blob?), return 0 from (a) and
then later use that information in hook (b), so that we can check
whether maybe the second possible condition is met.

Q: The passing of information across multiple LSM hooks is slightly
more complicated than I had hoped; is this an approach that is
recommended?

Therefore, in [2], Tingmao is suggesting that we change the
security_unix_find() hook and pass the "other" struct sock instead of
the type.

There is obviously a balance between hooks that are very generic and
usable across multiple LSMs and hooks that are convenient to use for
every LSM.  

Paul:

You have previously said that you would like hooks to be generic and
ideally reflect the arguments of the same function that they are
called from [3].

Q: Would it be acceptable to change the hook arguments, if we can then
avoid passing additional data between hooks through that side-storage?
You can see Tingmao's proposal for that in [2].  TL;DR: It moves the
call to security_unix_find() just after the place where the sk
variable ("other"-side socket) is looked up and then calls the hook
with the sk as argument instead of with the type.  That way, we can do
both check (a) and (b) from above in the same hook and do not need to
store data on the side.  Is that an acceptable trade-off for the LSM
interface?

Thanks,
—Günther

[1] https://lore.kernel.org/all/CAHC9VhQZ_J9316Us0squV_f-MjYXPcex34BnJ14vEBxS9Jyjbg@mail.gmail.com/
[2] https://lore.kernel.org/all/e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org/
[3] https://lore.kernel.org/all/CAHC9VhQ234xihpndTs4e5ToNJ3tGCsP7AVtXuz8GajG-_jn3Ow@mail.gmail.com/

