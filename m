Return-Path: <netdev+bounces-259776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDcwE4jSmGlrNAMAu9opvQ
	(envelope-from <netdev+bounces-259776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:30:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C61E16AFFD
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 22:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D2803039C87
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E89E2F3636;
	Fri, 20 Feb 2026 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgE+bovu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247F01DFD8B
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771623041; cv=none; b=l6Oa4mRCb0OITukUjf/bf6OmgpwqL/HCFRlFHN8bLUZ5Of+zOaWZjM+QuHmSNwDoErRHbQq8VIAy1Ka5//reaWxhQezOXnPJd5H84ubj1XQOl6Dhbb4uAlfSmOhSsFe9WhAAuGAKYJJHhGbR32cKehlRYg1nzZLAgMBDcAk/pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771623041; c=relaxed/simple;
	bh=69Sipbh5Spx1yQ69g/dESBm9HLQ6W5FNae1q+NPGfh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cOTvWJdPuOpHsUixQwQ2Q3egfmlpL4Si8d63PIo/UjG9jK8HHrKLL57L+yHK2LND4FGOnABqLmki2hjKHfBA6/2kN/0h8XXunyvVL4Nnzpzf7ew9oMh2fbBjzzcd2np0RKMHqrsL6WUF5ak/YuF5meW+CH5h8OLyOnUL+zlJrZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hgE+bovu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4836f363d0dso21417965e9.3
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 13:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771623038; x=1772227838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xfrKAmNK56jvp1fjZjOMgUnctvXGt+xW5UCdr2CBhHE=;
        b=hgE+bovuoGjB/0A/nM1UaDZDtaBTFIjEoVOUxtpH0UL6NLgkWRODqFbeYyfJoLFWBG
         TJ2qCF7vlLHPFijUEnQdBhC9vazxGhaSlPDqJdD5a/eKFpcq+1vLUJUala5qwHMg3/rF
         Zj1rDUVGkzfo98tQv2bYf9ICOrt/v3SLMltOMqQM4Spn6pqq8Eingdn3mt2wji2BnL9G
         +oCD9wMsy6S18d0dY8dswpM3OVHDvJ3OgJC9Ba47qQYkBj7ElUUChliZ/PY52bIoOym+
         YgVi0gjpGquBvJ77IP2Jo8QuB9g5B8Qz5KvKYQcrCQGOtNuYRqwHdw5MjOVujnDEpYG2
         LnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771623038; x=1772227838;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfrKAmNK56jvp1fjZjOMgUnctvXGt+xW5UCdr2CBhHE=;
        b=asdH7qSay2nJvsVag3oNLt49cOi5LiUChkwGX1AA4HpIWy3Odt/x1xK/5vB7QXeeq4
         FO2Su84DciaDiMC7/v+IxnZdzktXGYIxAQ83pu0iLfsDAElmRt9wgT/J/1NXw9wnefXk
         J1Am0BNrcwDBHZlJjM4yu92vXmhBPSjB7EFsIh0BAvSbf3CdHnF2/+j8Qi4K8YA4sl7N
         9ObuK1u0h1I/qOXbb+NhuqQOXJIg1wis1PK8jdwYJxeEKoMiUNkLbtsZSayy4KI8Hgn7
         VkbcRKJUqqklzwyvQXlkGleWiBECYIjZOU+uTiya1sAvm1Uj62LpPAoQwS/Oat6gYg6U
         /Obw==
X-Forwarded-Encrypted: i=1; AJvYcCWHDZO9vRyLANJipTyM0HSJ+fUNj5tEQ4BkG7yV4+CxWUmuY/sMBVdNDhYh2wn9pZGduPWxeJk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXkMPbHJ+doi+2hFkVVmpGaoMjaw64w2NKS3Vh8f00dp4DKTsJ
	1pBaewMabthT1bnGR9fFo2Fhlc+UD/Uv5OBe5HI7gIT3oKR/EGj4j6xP
X-Gm-Gg: AZuq6aKD7HuqUVdwN5j4N0qGf4mllmjUFAT08ESKnX8yuyxVZxT/WejoTUzsCwK2kJy
	CXa+7sNN17CSYfZU7oY++9mH8PpqFd+GlgevPUWih4b/cPPFm33STfFtOfynY22QEX758JwPDv7
	osHQoX7THciS6WSHJpxuhe45VarAosAhLn/+mIkkqtxXqVt/nTu3fqW/GGrhmi958UkKX0cj7Tp
	JnIQtw0QK6nUOGNjqbWB4/6ALcFe4EpRvRsq5IZjeyVoLFZ6vrsrO2ExJFCOcj/0Zu3v0VrcF+z
	6Ko5hMvdeLyQ9wmrj1D1N4TmO8xAAVvIdDYlZfduR8AUoIIMVnmnPWxxNu6QPDkFZQYwyeY0RtQ
	vtACQWk/22C2Zej7iea1r26EZRATskFRT6lqvvOntitAf6XVaMp9BaxxJbuNGRv0HDzEmUKLtlg
	k9R6XCCo5b3fVOdYG+K5924v4HpRxYayizSOvSFsL0Etg8rKiihvbYaSfCoG/CHY6NPEGeVpAnb
	WIX9GvzMoiN6+3Mbtu9OEFCxKwaKiNwaEuDg1tR6sKRj6/FGh9PS8ALk+jpkztMdA==
X-Received: by 2002:a05:600c:5020:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-483a95fc1d3mr16230505e9.12.1771623038237;
        Fri, 20 Feb 2026 13:30:38 -0800 (PST)
Received: from ?IPV6:2003:ea:8f1e:3800:1889:225f:1b5b:4b37? (p200300ea8f1e38001889225f1b5b4b37.dip0.t-ipconnect.de. [2003:ea:8f1e:3800:1889:225f:1b5b:4b37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54754sm644661f8f.36.2026.02.20.13.30.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Feb 2026 13:30:37 -0800 (PST)
Message-ID: <4674c965-f4d1-4ba9-9e36-9d3bbbb37f64@gmail.com>
Date: Fri, 20 Feb 2026 22:30:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: micrel: Add support for lan9645x
 internal phy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Horatiu Vultur <horatiu.vultur@microchip.com>, o.rempel@pengutronix.de,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260130-phy_micrel_add_support_for_lan9645x_internal_phy-v2-1-202ac31cf9c4@microchip.com>
 <92ba22ee64b2670448295b44d663d8ae7e8fe9c4.camel@microchip.com>
 <641d92a2-93fb-4ffe-89d8-77bf10edecf8@gmail.com>
 <1b14f42944d21fff1cb45132fe6dc9e5c18289a1.camel@microchip.com>
 <00f03a3f-fc12-4875-b4b5-7470e7f0452d@gmail.com>
 <aZjN48iisYaJ4xeg@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <aZjN48iisYaJ4xeg@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C61E16AFFD
X-Rspamd-Action: no action

On 20.02.2026 22:10, Russell King (Oracle) wrote:
> On Fri, Feb 20, 2026 at 09:50:44PM +0100, Heiner Kallweit wrote:
>> No, BMCR_RESET usually doesn't reset configuration registers. That's why the
>> function is called genphy_*soft*_reset. In case your PHY behaves different,
>> which configuration registers does it change?
> 
> I don't think your statement is correct.
> 
> Looking at AR8035 for example, the WoL interrupt enable is doumented as
> being cleared on soft reset. Smart Speed configuration also gets reset.
> 
> 802.3 22.2.4.1.1 states that setting 0.15 results in the status and
> control registers shall be set to their default states.
> 
> So, we should not assume that setting 0.15 will retain configuration in
> the PHY - at least phylib should not assume that a call to
> genphy_soft_reset will not clear the configuration registers. If we
> have code in phylib that makes that assumption, phylib is buggy to
> 802.3.
> 

Indeed I was wondering why c22 states "reset control registers"
whilst the PHY's I'm dealing with don't do this. At least for the
Marvell PHY's I used the spec says "resets PHY state machine".
For Realtek the spec statement was "resets BMCR and BMSR".
And often config bits are described as "becomes effective after
reset". But yes, there may be PHY's implementing exactly the c22
behavior, so we shouldn't rely on "soft" in general.


