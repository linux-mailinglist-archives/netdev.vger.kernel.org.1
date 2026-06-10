Return-Path: <netdev+bounces-297356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FvFmBPaqKGo2HwMAu9opvQ
	(envelope-from <netdev+bounces-297356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:08:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B21664E5F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=iuQ8spfK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297356-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DFEA300A13D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6753A883F;
	Wed, 10 Jun 2026 00:06:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3E2110E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 00:06:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781049976; cv=none; b=qHEQaCWMc79iw60D5US3Uz1XHhRjhgPk9pmmjiuGsYSRE8BSjG6vUkke44Esn6KXs7gMv51xNN8l0X53AePu/vtJvQCpKC24yHhJ/3aWLj4hgKmIAYiq43Ld4PxOYKuCqyepCrfcauY3R918icTTZBdrYITsCYNuERlP08VWLP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781049976; c=relaxed/simple;
	bh=r1vbyfeCtYG6OGx7YM1c8slsjLM5GVhJMK4JM/LtzFE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Y4tNrYoN0OUHgZY/ck6So3UdbFKNPiUeO3aOGwjuGZErHeBEXHEpaPpXBkJHkNJAGEeJ1eZPhmLVOPjpZwnXUbOtbNfEU9ZtpnUS/5ThLRNKgATPolp3/s1Ismay4fW1KuHi05eta4F2Y08UiqZ7A6odSBRG3jUI2621RKDzOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=iuQ8spfK; arc=none smtp.client-ip=74.125.82.172
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304d7f31215so5476635eec.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 17:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1781049965; x=1781654765; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kj983b4aP9iTymCXxslRDVIMvDkVOBbHTYZp1bhw+6s=;
        b=iuQ8spfK1Iat4dw7kvDF3eT0iRlrgXea8KgeclovNgqmuidX8lMZtX30UsXf7EZkZB
         w6p4NrXwy92qPMAekQNDEWW/W6I/zuY0H/u/Sc/7A2Upk0I5t95ph6JNR65U2rLgtpdm
         NLI+M/o5675+3eoCVCzu6KBAnDFu2j8IC5DkOpQS5QGGUzATHxtzSFz188Sn4xCaSvP2
         sMY1/xCgDzwXzGzjdOG7yadGOhxkINQD6zEkTUg+u+A7PgJ33Qj+Ygg6PHf5P9nm9d7T
         u5+csh++zvP4PGTg1HzekkkDhVcU8tj0yJMXLjkgZleg5fGuiMGk6ExeLimeEN2iPixR
         CtsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781049965; x=1781654765;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kj983b4aP9iTymCXxslRDVIMvDkVOBbHTYZp1bhw+6s=;
        b=P199y3fJwJwgHdIoD8K6VLi4eZwrOME1gTFISyGWyh8WETL6Q2SvLSxy3f5lVSNPms
         DGcjGJbe/aAt0YKBYty3adU8kW+aY7bihhbt/ZiVAj+LRg/FQHUxw82crrs1sG00iemV
         rLGHXOXTMB/FRkL4J4LHVITSmVgcRgRjfO9E4ngrj09WFdHoymWcanrN6asyUaQbuR/k
         aPgyDZudyMU+/GsS2QMN2CFqu17HMqH++v/uxlHiLQ1UCui06ANXJ3HryVkDmRl2o1T0
         0npFfAMgSHRsdV4Mq9kap0zxhQP9/KYablg5fLjDt74bkBQIqQf4HtvzOgq/pXAzG+jF
         bA9w==
X-Forwarded-Encrypted: i=1; AFNElJ/lBZA0nibu3+os1c4u7yQBYj6/e8oDfhIQ14LON8EoVoxZkvTaIRiCDfR6wBmiALq0DmJLrBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHKyBLu0bjvCWSJRzmINGdubHA2lh7d2h214F+ihTDQOTyUwBR
	7m8mrPfShwU4VTEsYH2YltGObLZ/l2DEPOdxoW80+orKck7+eZoX2qcGhLLQNDT94TE=
X-Gm-Gg: Acq92OEnp5QpwdLsXZtPa6ajObw9ONdMvC/wpcX2DtdyHhHpnnS0f+Il/zDBJua/U4Y
	/nknu7G1qgHhd4hheWBbli6gCX2+b4/3LJ2Dh5u+xjO63XYX96Ysj/i8gAl3IN14Ifwsyfuf/FM
	KpAIM4MZq4SQJS1mPQ55goCc9n+0VbctGxmWkjexO1Hkkv2ZcBySo7yiIeimcM0CE3re/81CThB
	sJqZwhKFQ0ItOxb40FZfbnE4TYp7YQbBf55CdcIKtyaOrFvqnKWj1bHcHoWfW6rCSqC9WeBJEkz
	DOA/qjXGp1Q0ltcqUWvwzuUYt4xIYQGr9whTUhPFkPQNmvMnXqwn5AeAy8gv4I1g10A5fiVpiiL
	UEeXRjmxkPEHwsAAlM3o1xnT+A+8RfhF3S9J+TLJQRzEGhK8BL1SnEPzVW6HNwhtxVnKclzEdwa
	ci0SI5dtoVRX/4u6E=
X-Received: by 2002:a05:7300:d70d:b0:304:c520:4e14 with SMTP id 5a478bee46e88-3077b32888bmr15659364eec.11.1781049964814;
        Tue, 09 Jun 2026 17:06:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::3297])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm28979462eec.8.2026.06.09.17.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 17:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jun 2026 20:06:01 -0400
Message-Id: <DJ4XIOT2RVMT.28I5LA2UOZVUI@etsalapatis.com>
Subject: Re: [PATCH] bpf: Unshare cloned skb before devmap egress XDP
 program
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Menglong Dong" <menglong.dong@linux.dev>, "Sun Jian"
 <sun.jian.kdev@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <davem@davemloft.net>, <kuba@kernel.org>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <shuah@kernel.org>, <liuhangbin@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609100214.337538-1-sun.jian.kdev@gmail.com>
 <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
In-Reply-To: <L0cwr1-KRSKR7-dJdjDmJA@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:menglong.dong@linux.dev,m:sun.jian.kdev@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:liuhangbin@gmail.com,m:sunjiankdev@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[linux.dev,gmail.com];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297356-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,linux.dev,davemloft.net,gmail.com,fomichev.me];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,etsalapatis-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,etsalapatis.com:mid,etsalapatis.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56B21664E5F

On Tue Jun 9, 2026 at 7:06 AM EDT, Menglong Dong wrote:
> On 2026/6/9 18:02 Sun Jian <sun.jian.kdev@gmail.com> write:
>> dev_map_redirect_clone() uses skb_clone() when redirecting a generic XDP
>> skb to multiple devmap destinations. The cloned skb can share packet dat=
a
>> with other clones.
>>=20
>> If the destination devmap entry has an egress XDP program, that program
>> can modify packet data. Such modifications can then be observed by other
>> clones sharing the same packet data.
>>=20
>> This can be reproduced by strengthening xdp_veth_egress to configure a
>> different source MAC for each egress device and checking that store_mac_=
1/2
>> observe the MAC configured for their own egress devices. Without the fix=
,
>> the SKB_MODE subtest observes store_mac_1 receiving the MAC configured f=
or
>> the next egress device.
>>=20
>> Fix this by unsharing the cloned skb before running the devmap egress XD=
P
>> program. Limit the extra copy to destinations with an attached egress
>> program.
>
> Hi, Jian.
>
> This sounds like a good idea in this case. When I have a look at bpf_clon=
e_redirect(),
> I found that it use skb_clone() too, which means it has the same problem.=
 The
> data can be modified by other xdp prog in the destination NIC if we use
> bpf_clone_redirect().
>
> So maybe this is the default logic, and I'm not sure if this patch can br=
eak the
> existing users :/

I think for use cases where we are using bpf_clone_redirect() to use
one clone for inspection this would add an unnecessary copy. Maybe
adding *_copy() variants instead of changing the *_clone() would be
better? That way we wouldn't be changing the behavior for existing
consumers and the naming would be consistent with the skb_* methods.

But more importantly, is there an actual use case for the kind of API
that the modified selftest requires? Nobody until now has considered
the existing behavior to be a problem.

>
> Thanks!
> Menglong Dong
>
>>=20
>> Tested with:
>>   ./test_progs -t xdp_veth_egress
>>   ./test_progs -t xdp_veth
>>   ./test_progs -t xdp
> [...]
>> =20
>>  destroy_xdp_redirect_map:
>> --=20
>> 2.43.0
>>=20
>>=20
>>=20


