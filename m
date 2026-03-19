Return-Path: <netdev+bounces-269327-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO37Np6gu2kLmAIAu9opvQ
	(envelope-from <netdev+bounces-269327-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA5F2C714C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 08:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597C730151EA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214834CFCA;
	Thu, 19 Mar 2026 07:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5G/2Jdo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587C8238C03
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773904027; cv=none; b=ItUh6BlFKXcTHPbh2w+eHZTQRk0Oib4BO3ka395YAj7r2AdgIUkw9P5yH8wio8mr1Sb5DrP+c3XCKLtJMUo9XPahZ1uPixy8j/Vtk/CK09n09BNeX9UWP4RL0cqi2iO2zp+6wUOLXuRrb2hlgLE6k6aHiKMG1N0mo4zW65eh0LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773904027; c=relaxed/simple;
	bh=FUvX8ECzFfxYtqPQhu3PpDPugdXoRG6qyzyFEeiQjH0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=a8sEW13DnG8+CzmTTyW0i5RbHE8EvfPRAd9EtZDDe32EEw7AzBNydIlxnML8lGRdowz0dDyelE2+Xr4lQM7BPa824awfu2CdHdkZ2BVd9gWbYH0wguFEVnW6gTD45Og1SJDJMWfg7QkD7u5HZySD14SEoaWPXZs6TnhNbZcwxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5G/2Jdo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486fb14227cso3515575e9.3
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 00:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773904025; x=1774508825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=msryOGvr4NC55DltH+ndeevRjDMkTOjiTqGi0cNMcpI=;
        b=C5G/2JdolDu+5P9vuuvS/20JkP56w9ye1iCWycQxnQiUFEDZnX3CexYMl6qVpadsOG
         +b5CvE9u1UFx2MFOO1G+DPhg0yWvTRrz1UzjoVK/etaguaQUuiMn9TgvqKKrQszUECWA
         r2nM78WV7lqu19izxCYjBkcM269wEPKcWakmoJh3SBpK1l1RLua97d3ZgIQnbp4M/Y20
         uN+yu2mN1qTa20Lucxoen5MjRsCx4q+5fRTczV+PQG4uLHL5nVQjxdAZvx5H2qEk5MPh
         GGfIIdfS0niEFx0KNwJH2IkTG8W9l5WVw+mfZjmhSFdgX1IaaHP4nvlr2rXoGQhSNCZe
         OWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773904025; x=1774508825;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msryOGvr4NC55DltH+ndeevRjDMkTOjiTqGi0cNMcpI=;
        b=JcJ8+J5Tj407HWGovY+7D6/nUh3iPKa2rBZuFFyaqyXWBjAMpa/9eG58R32Y0iJ5R0
         6zK9PygnM3WOasH9xvoO2VERI9GQmiTpAAmDYI2FkGKjn8QAWN6Ixupv0/OqYw8dkXaH
         ugSUgAw3ZYQQJ0k0OvoJDo3OBwnVVJDswLkI8EQHiKYy063yoE7mrucbfkPVJl/Ie7n9
         8/98QMyb19I3iNroX3P1wPZwIRpjEmBXU1jtTZwTkoEUGq/mY89ByPCtI9nj18rSJo0t
         OYrUp0HmPDGid/plzzK2yDHU0I8eQu9pZSjPhX+AWOv3z+ADqUM3hKSrc4uyQ8gntLVY
         ATrA==
X-Forwarded-Encrypted: i=1; AJvYcCXNjdNvXnL7yQiW30hUyqt16lrJnIFf79xBRR1Rzd0+Rp1fqDIZE+vzIWFmtbE4VveZZ9y00/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBCCtfEQXdctfPIcqmDDceNxuLiz+WTQf1MsIyB1TmfY+PN3zr
	V2cLq3Bsqw5VdgI6/l41yxyzd37kpj2+z9+Q9Bpz7cwqpd3D36lv48Ar
X-Gm-Gg: ATEYQzyhh374+Xt2ufTTeGjm7qAON5uyUiyUebea1JiepXMIok2zvsK7q+KRNt95ibG
	spMkovtIc7wNZYCgIuibl/IlYWb5CM3YIMtB5eQq3IQRuTgUggVOb/ZvPoi9sjriSLCFodHrt9f
	pSVGHKSjkZJkdNq4eCy50+yFH+Ocpa9+t2zjkJoma+/WTl0y0w+Z7ivkjT//lXWP/fSqHFS39Ov
	EMfge9A56FBikjghsn5zixF6IQEQDuEw/PchNsPWTVeP7cj4FR10TiKlgPjimgwgr5Nv8etfE42
	tjhCiCnzcDPgmX8nzpRZOh/ZQDU2s0KCyKXtzRzZalSJBbx6RrUUp1rIiDYAWk8YDgN3hgrTWoK
	0Lo594TSWs/quj13BXX9E9jwywcnPC/8f4ta4kpMzreno3yVlpj9p9PLbJebbC9cwOLKskIpTc0
	YxyvQh7i6TNSzaFZ6mN56U5DILVhQ3ib/qvYQ=
X-Received: by 2002:a05:600c:4fc4:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-486f441bc46mr98293895e9.2.1773904024279;
        Thu, 19 Mar 2026 00:07:04 -0700 (PDT)
Received: from ehlo.thunderbird.net ([80.244.29.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba7499sm41370235e9.21.2026.03.19.00.07.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 00:07:03 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:07:00 +0200
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org
CC: Johannes Berg <johannes.berg@intel.com>, loic.poulain@oss.qualcomm.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net_1/2=5D_rtnetlink=3A_count_IFLA=5F?=
 =?US-ASCII?Q?PARENT=5FDEV=5F=7BNAME=2CBUS=5FNAME=7D_in_if=5Fnlmsg=5Fsize?=
User-Agent: K-9 Mail for Android
In-Reply-To: <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
References: <cover.1773829376.git.sd@queasysnail.net> <c8acbb1f4f3651f50fc4f5ddee234f1ea6769588.1773829376.git.sd@queasysnail.net>
Message-ID: <062C3C0F-A121-43D5-9E17-E44F94888E04@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269327-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryazanovsa@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.877];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:email]
X-Rspamd-Queue-Id: 3FA5F2C714C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On March 18, 2026 12:45:52 PM, Sabrina Dubroca <sd@queasysnail=2Enet> wrote=
:
>Commit 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
>added those attributes to rtnl_fill_ifinfo, but forgot to extend
>if_nlmsg_size=2E

Nice catch! Please find an implementation question below=2E

>Fixes: 00e77ed8e64d ("rtnetlink: add IFLA_PARENT_[DEV|DEV_BUS]_NAME")
>Signed-off-by: Sabrina Dubroca <sd@queasysnail=2Enet>
>---
> net/core/rtnetlink=2Ec | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)
>
>diff --git a/net/core/rtnetlink=2Ec b/net/core/rtnetlink=2Ec
>index dad4b1054955=2E=2Ea116362f5f32 100644
>--- a/net/core/rtnetlink=2Ec
>+++ b/net/core/rtnetlink=2Ec
>@@ -1267,6 +1267,21 @@ static size_t rtnl_dpll_pin_size(const struct net_=
device *dev)
> 	return size;
> }
>=20
>+static size_t rtnl_dev_parent_size(const struct net_device *dev)
>+{
>+	size_t size =3D 0;
>+
>+	/* IFLA_PARENT_DEV_NAME */
>+	if (dev->dev=2Eparent)
>+		size +=3D strlen(dev_name(dev->dev=2Eparent)) + 1;

Shall we use nla_total_size() to account alignment?

>+	/* IFLA_PARENT_DEV_BUS_NAME */
>+	if (dev->dev=2Eparent && dev->dev=2Eparent->bus)
>+		size +=3D strlen(dev->dev=2Eparent->bus->name) + 1;
>+
>+	return size;
>+}
>+
> static noinline size_t if_nlmsg_size(const struct net_device *dev,
> 				     u32 ext_filter_mask)
> {
>@@ -1328,6 +1343,7 @@ static noinline size_t if_nlmsg_size(const struct n=
et_device *dev,
> 	       + nla_total_size(8)  /* IFLA_MAX_PACING_OFFLOAD_HORIZON */
> 	       + nla_total_size(2)  /* IFLA_HEADROOM */
> 	       + nla_total_size(2)  /* IFLA_TAILROOM */
>+	       + rtnl_dev_parent_size(dev)
> 	       + 0;
>=20
> 	if (!(ext_filter_mask & RTEXT_FILTER_SKIP_STATS))

--
Sergey
Hi Sabrina,

