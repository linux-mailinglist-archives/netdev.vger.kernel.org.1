Return-Path: <netdev+bounces-253082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEbVE4HkdGnu+gAAu9opvQ
	(envelope-from <netdev+bounces-253082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:25:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF37E060
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 16:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7AA300D156
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BC621D3D6;
	Sat, 24 Jan 2026 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JT64rcv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BC720DD75
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769268348; cv=pass; b=BOTK1m7rcHOTdAKE9PvcE26/LKYpSR2qZCbUr6k6Ne1bRJE1EuyopgUMXwoBJfwuYL8iYWIA/3oi8RQZ+iNNLv/9N+28FEpoqIxvorxS13xK4f5F1zgCgOkeAoVz7LxJzdRy1iv/9CUcqvRIzxeT7tL9GV/FGqYD+4z+ZlKD3o8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769268348; c=relaxed/simple;
	bh=pcfU+4mnDH676iCM6nVMR4sNi6d040S7tQhpJL1WDW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XsVlyirn/46OuB2HTJKP+rmZ+9+C/zP4rLaVA7s0IbwOEqgQyLMaum1BI5lAvbg1Mj0uShkpJxZM+65QNZhO2gLtqWktmsSXPWsSrUV+02JbN4XU4qgdZ7Okvyg71tCXHgWRNOvsvcXb2vnDaJGBPX0x3VWzNcI7oOtRfLEc2u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JT64rcv7; arc=pass smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7cfe2a6bf81so1022827a34.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 07:25:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769268346; cv=none;
        d=google.com; s=arc-20240605;
        b=UM0h7OALRiEodwpdZ7QAHKpzgbSE/zl0kCp/BERVmTTWzPr6Ybedt/c92efc3zuTty
         bXbyrMxYxMhP0oQkLYrBtxNcATQongWngmttpjC8y/CQhemrBlLO92q86qFw7qyb43va
         cbYkswZewZB6ZUuDoRR2dBpmZfg50+/GFiuTFCsOT+Xmip9UaWdsAOiwVb2r1tQEdGDY
         ZUOqrM4lo2Hr+tHd4cmG4z/bbG7SXrfjt1U+VZRhKh6rjWAJ+9DB6E0H8bEa6tlQ0Wxo
         XweE5jvtZG/n0zvLOSi0Eu0y/FtwuZXHkL1Q0rmbqvlInC8Mnc9iTC6JF4ZxEJUEeWVo
         NWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pcfU+4mnDH676iCM6nVMR4sNi6d040S7tQhpJL1WDW4=;
        fh=CH0Tucwx7uCn7iLWRUxHa0Elo9sMmn1az94uhhghKYs=;
        b=SgxNlLzNvNspMsMLp4/Kr28cDMib9vKamLHnVrKub6xhUyGD4rx8WBMkm3ZW2Prbnx
         IVXnqqW2NzaxJjEzBd7d3cA2B1eB98GLOQXIAmUrzsJGrAUFnuRbz8YUQGIO0cQ8lst4
         fm9EU4lxR2STZ1Ejvw9xB0gLYpQOwHv3r9WxEXu0sKPrivlSIA+aSRY9+J6j5nkWE71e
         /wJssQCQ/dOPuOzxWh3tHXT1Ue8RYRFUfODJtk3iAiNr38ueVZtrSBUZw7rEHDpiBOL0
         m/rSuZQnoJRMA1CKwjiOlcV2My9Arvw1q6d67HoHsulxS7IvkT/vRg1IM91tbXT04ki4
         qbiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769268346; x=1769873146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pcfU+4mnDH676iCM6nVMR4sNi6d040S7tQhpJL1WDW4=;
        b=JT64rcv7sNeplUh/tnpU8KT1FksRB58d5I0R25SLHcYn5m4NRcqL6o03KL+jYfMqbB
         4c7ufXu/YPtpyYjMp6d9yYTFIsUvhA5SnWkxdv5e+39pffZdD2Nql5jYZ06jJmZlvcKE
         Oh1t/SRA2j1wk++g+VzLdxg91rFUGIfe5tQIH684ay3K91mgYfFoHh+hF23ZIr8GVIB/
         vrylV3i7snmmweTbjQpDx4gDaB4Y9xY7sVbbIGiWb7nzxBvt6GdFQVhlcQXrZ72kNcK4
         9/kyye0r+7I2fqXC1YTASsymqfOd28YZi4KFjhW8vKcOp7rx5CsIk79jUujnYJ1W9lSy
         xXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769268346; x=1769873146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pcfU+4mnDH676iCM6nVMR4sNi6d040S7tQhpJL1WDW4=;
        b=Nx5OCT5W4OoqS+k5J1KCkjSbPg4x05wHPUm/P/ze8zjummIkffPEBuganaHfvoyouV
         AGOtUmmdeMuOOU7lKienkHpF6QMtJp8eQNMRvRvSYl8bQFEmklEseN6lXbIEpqSz5OFG
         aH/BZIMhRmlbd9HB8MOllW99ceqMj3KSINcPxZT1fITzxM87NPPbsqBgQ2K1GI7+FJkL
         dDY7pza/U7o0U+Gm4dkEMjrkaIPcPk9tqOte9YLcTXZWSE9sYgiyegPOIwRiDtZYzWSp
         wmT24C0D0zKz3UJAoU9oKA2FYC49vC1inksVsVkv9PKrFFXy6rZZ3Lw5Lj9RpXyB8+7E
         iIJw==
X-Forwarded-Encrypted: i=1; AJvYcCUNXcafimKpby4L1TqQLcnPonGw5t4uG23fIE/CGvlLe2rgKcIepNYX7K4I7mu6znQ6YypBuU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwitVxzpU5ZTbqD5YloOZ4hN7Nca/19QG+u84ve49n4V/ZkW+FA
	QUQqfrzyzzaDljmrNNY96lbhxldsyD7pqaWOKXomfn+QejNo/fVMWqzHxrOzWHk+8jnX5QD7cTs
	eCFzCkyQ0zpJw4MOfuwxGwDXLqhCCXeU=
X-Gm-Gg: AZuq6aJNBfoaqPi706TtRhbHxDtG3uU2w2ZiZ7rMMV+QPrZmoEstnWhWzlpT89CwYbl
	kVHFusu0mbFiKfvxMxkYyE58VamVqRN/ghDFJOvTG5LuFG1h18elZlVzafaAWZD8aViUCmQH6eC
	OzlvidSma/nD0bVE9oPsYiS/jNLlXOII77piVWYhu2rmkPbvY4BfQVBpNfsUeho+LICFTLVIu4U
	hwri8qXGRJ36GW6VHf+YTTIcI4ZOlXRCG77/52wg2gyLTDNYcKUQkNoHwLCUIWZRyJF3Ts=
X-Received: by 2002:a05:6830:3695:b0:7cf:d822:37fb with SMTP id
 46e09a7af769-7d15a6772c6mr3176213a34.34.1769268346171; Sat, 24 Jan 2026
 07:25:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123071635.16976-1-suchitkarunakaran@gmail.com> <CANn89iL5jS8BP+eXe1HeOBNpzfmVgTAHROGBK0qCAKJxvxUnuw@mail.gmail.com>
In-Reply-To: <CANn89iL5jS8BP+eXe1HeOBNpzfmVgTAHROGBK0qCAKJxvxUnuw@mail.gmail.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Sat, 24 Jan 2026 20:55:35 +0530
X-Gm-Features: AZwV_QgO86ZqF-7AWmtIDBCAYwPvZv8yTFk5or4fxY8OOXTLlHlFA9ru4rr3Szg
Message-ID: <CAO9wTFhNijfEbmASx8rdStWSjvQicCvA5nSHqF4B4XpNxu0nGg@mail.gmail.com>
Subject: Re: [PATCH] ipv4: ipmr: add socket type checks to ipmr_ioctl()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253082-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suchitkarunakaran@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 93FF37E060
X-Rspamd-Action: no action

On Fri, 23 Jan 2026 at 14:57, Eric Dumazet <edumazet@google.com> wrote:
>
> On Fri, Jan 23, 2026 at 10:04=E2=80=AFAM Suchit Karunakaran
> <suchitkarunakaran@gmail.com> wrote:
> >
> > This is the IPv4 counterpart to commit ("ipv6: ip6mr: add socket type
> > checks to ip6mr_ioctl()") [1].
> >
> > Similar to the IPv6 issue, ipmr_ioctl() and ipmr_compat_ioctl() access
> > raw_sk(sk)->ipmr_table without first verifying that the socket is a raw
> > socket with IPPROTO_IGMP protocol.
> >
> > This allows a permission bypass where a user with CAP_NET_RAW can creat=
e
> > a non-IGMP raw socket (e.g., IPPROTO_UDP, IPPROTO_TCP, or any other
> > protocol) and use SIOCGETVIFCNT or SIOCGETSGCNT ioctls to query IPv4
> > multicast routing statistics. This bypasses the access control that
> > restricts mroute operations to IGMP sockets only.
>
> Where has this been documented? An RFC perhaps ?
>
> This change could break applications if they were unaware of such rules.
>
> I fail to see how querying statistics could be a risk.
>
> What about the RTNL_FAMILY_IPMR rtnetlink interface ? I am sure it is
> available to any user.

Hi Eric. The primary motivations for this patch are the IPv6
counterpart mentioned in the commit message and the commit 5e1859f.

