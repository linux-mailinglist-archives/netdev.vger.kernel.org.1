Return-Path: <netdev+bounces-254672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SN4wMLUke2nXBgIAu9opvQ
	(envelope-from <netdev+bounces-254672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:13:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 88003AE02B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 10:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DCAF330039BF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6895737F117;
	Thu, 29 Jan 2026 09:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QvWaYswT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B952337C0E9
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 09:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769678001; cv=none; b=o9IEoq2SFMGkaLN3pCvdRxmmqzME09S05/BCBxJ1oNXaka007+NeGIwAj8n1UoF/HdN/YUg09iqPkAnLhowTdihJUUoBqF+cyJ1tZo8xbxM10JbSvQvpeFpSK1oGJ34kBg62rc3LVuncqddnVPifVOQKVVzKzl/npTDU/DXzqHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769678001; c=relaxed/simple;
	bh=l99yxqZIboguKDDCrWkpSaxxioKc9GMV4/P57XETTqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWanw3o7BLN1/u7l9OsyOxFL66JeUPTqb5nQubNvH2KYxMuRNDXyjd82ozm2M4vVUitImAwrjq1dy2bFoB/i68sxqNS+g3N+a6UCt3+NKC710QGOZeEPyMp0boOTrSkAliRxb/nYU5R9zgooOtIc07rneY6md3xKEoKh+BaQoX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QvWaYswT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso5178875e9.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 01:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769677996; x=1770282796; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kroNWMSWVNZ37wng02iR6TciONLQlLOgGJ/E4Sbo+U=;
        b=QvWaYswTZQ0WhgcDx8fxpRfaMhbG5MLuLb975ZSK/S8ln0Tt3rMUx+SudjDw/wjSSG
         7wWIUM5hvy+nNGobMPl7dMN3HXChvivyaLs/RmWtXE2/DccpYsgr8sobTvqTpLc8ey40
         B88Xnh5972vhZujdXzaHNSllFRqg6Yq30weHJYs+4OVBZIj08mJyY1gQh4ke3B/SS2/+
         irIYJb+BNuYgIHvAkflmYw4VcqvrDTSGR4N+0wro9Ia8ud5Wy0dKopcReUSUsPd7wbPd
         RkOTSD41iCfAQaHvcpACawBmXczrPDze9VYe7yOvEswys0fvAAzquh1zyniTb6Uw4LdL
         XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769677996; x=1770282796;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kroNWMSWVNZ37wng02iR6TciONLQlLOgGJ/E4Sbo+U=;
        b=EQNTAzJzgayxGMyEdVYWzcVJnAa2kw9lmnFW24p+GYhplyUjHyU/5khfa12m6XIvIg
         NJLBVLzQcOLxdJaJodHvTKv43fqxHCvvgFstlkyfsaR9kI67wXyKLIcOih9lWPCDtClL
         UtuoILrVu/qxG4DP5gTPq7s0dg4zAeSU+/JM4rGBNwmiEl3OLFU3YA+l/YTydLwo5n0W
         SdYNVqTnOoWNSuOxzOR2EcKkH3/6mPaAJK6tIT+ol4T2serDwbaH4XjFpGQfhcOrrP1V
         ZUmyQHNNkwnXE5O0jNzBmD08UWH9u2nOT5NW3S7mIKoTHSz+OARo8qvFTbDTUkd+Wd0u
         4NOg==
X-Gm-Message-State: AOJu0Yw2Ho2KARZ+PN2FGreKgMs1SqkxvjpzlXPat+elokKmHmoB96ji
	uXRm15xEN0wvFGjOpygPl6OREitvUYDTC0jHEcOsCHxb/Kfy6YylY4NJ4+7z/T0UB/g=
X-Gm-Gg: AZuq6aIQObbXHOgtTIRfhtn0HWbY2cP5Kr6yzOl9Mi0ILlSxHa20u3GtXoJuqtJljMc
	DgV403pAJA+wrh+g8TM+dvcS+rf0zvgD1kT6fLLuxxNEYyE+K53dCXpxNejNwGTIHm5pXUZHe3a
	Ke76ZSa4i0sS9ZK7yBf63c9hOM/70P30jI9d1hR20N1fInZPabTnQUDVe5UfOwqiZANoOogZimN
	iqMK9CpPZQiW6I5H6u7xINTyX4iZ80Bdavz052C5Eh8PVZQnbyO0LDlCx3eH45u6nJM12sFI4H6
	O9q1lC6vODUy0vkA8zGeLO2ogVSR669aNOYFnMdBQh7LKBlz2TggPBZZ90oxe0Ydaeb/dblsoyC
	kd6xIOiFQfRoCp46tjACS4h64PxcLgeb2t+QePNMW0oVYkOY3L3WVKHschy0Amaf0XfoaHl1Gyz
	qJqU+O+OXSfd84dLhIJHnbUHuu7heoHfg8p4Kn0Td8OCLYHkOliFZZ
X-Received: by 2002:a05:600c:6812:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-48069c54e53mr80043065e9.26.1769677996116;
        Thu, 29 Jan 2026 01:13:16 -0800 (PST)
Received: from ?IPV6:2001:a61:131f:a501:f9a9:449f:1718:4cc? ([2001:a61:131f:a501:f9a9:449f:1718:4cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48066aaf235sm175648485e9.0.2026.01.29.01.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jan 2026 01:13:15 -0800 (PST)
Message-ID: <5ff5f454-020e-4476-982d-de611e93c1e6@suse.com>
Date: Thu, 29 Jan 2026 10:13:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] net: usb: kaweth: remove eth_addr_t typedef
 and bcast_addr definition
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-4-enelsonmoore@gmail.com>
 <9239ddef-c197-4fbd-8e88-691766bda3e2@suse.com>
 <CADkSEUjgRrC9eAQYOkaErd7wyXKkUs7+dG+Q1jz7VbqF+zxwuw@mail.gmail.com>
 <314effcc-5bf2-47c5-9757-aafd5b47fe65@suse.com>
 <CADkSEUjk3uE+vMOPw0u7MOc4+AN__LWsriWA9fVhm2C35gJ6MA@mail.gmail.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <CADkSEUjk3uE+vMOPw0u7MOc4+AN__LWsriWA9fVhm2C35gJ6MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-254672-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 88003AE02B
X-Rspamd-Action: no action



On 29.01.26 04:41, Ethan Nelson-Moore wrote:
> On Tue, Jan 27, 2026 at 1:23 AM Oliver Neukum <oneukum@suse.com> wrote:
>> yes I am aware of this. Yet there is no point in breaking
>> existing setups. I would prefer this driver to get only
>> clear fixes and adaptions to changes in API that are absolutely
>> necessary.
> 
> Hi, Oliver,
> 
> That is exactly the point I was trying to make with those statistics -
> I realized cleaning up kaweth was not worthwhile due to the lack of
> users.
> I wasn't proposing removing it; it is simple enough that it doesn't
> really cause any maintenance workload.

Hi Ethan,

good that we agree. If you want to clean up an exemplary driver
I'd suggest the class drivers, that is the CDC drivers.

	Regards
		Oliver


