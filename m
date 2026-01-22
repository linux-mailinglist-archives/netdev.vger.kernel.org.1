Return-Path: <netdev+bounces-252516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPPmLIp8cmmklQAAu9opvQ
	(envelope-from <netdev+bounces-252516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:37:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A5D6D1B4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6382E30A123F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E163939B0;
	Thu, 22 Jan 2026 19:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEcS1L7F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7034D38B
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 19:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110361; cv=none; b=ttOX4hWhm8REv2q2TJhBJ5V6haH939cJkpMALDa1gRwAJQYGnPI+Q4LxrP3X8s/YeQBGHXCMjCVBR5Gx7rncb5nXFPEIykoccMwbhmbsWz7z2bPKB5PTVTdS9GTsY5rlTb/BBM2U7WyR8VjLRf1/EBRnLL1eoV5IKXw7OdV8cPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110361; c=relaxed/simple;
	bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Wo3WrVLyKSnySVrak5rIfSpzWx2aNONsN3ceTxo0z7z/Zx8FlI+/xnWD0chYxTHJ1jeyshhAJCSDsOPKnHUm85spq0+EqTq2TFLgfAcKDNmJic9Rhm16K4UWyYWipsjc/tKl+qR7V305o9hhX+aXEOr8cpI3475ziTtke33mlUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEcS1L7F; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6446c924f9eso1352556d50.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 11:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769110349; x=1769715149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
        b=SEcS1L7FWgZMUe9FzgdoVYxcINpEC5UHfV6oDFfg7Hg8sNAQfPCQP5wsnRQLlf4b/8
         We4cX0qVGWaE2tDYY8WdyNI2gzSxibbYLLbn5azrLslZRDeyDeXdP9HMPzOkuNqm1gKH
         xRGEwdwuYDePBofI4XrJB2hwuEbN9JHAGKra+7ErIXn/Vi3+oM9H8nRBnz5vG/NkDLjk
         w3H7uMCuwE3990STGghJbTI10IUA89osw2o34nlMnT1GPZssBEQtl+TdmHgrU9cHOq37
         14t/3dG5ra2WauCajmDvMQ5Bg68aZFUV4Z34b+uDqqNHOJ1U74P80E6i2jtP5kUyp+nE
         DjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769110349; x=1769715149;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KmTueWUjZn0G2ApEVq9bE5AxQTl6EyL16mGxBo3CtWQ=;
        b=ilGCFRENcGGg4juCPBiRcP6441CLgbSx4oTBzz7iTZWvzgsWnN/RdMbjwep9OFILHB
         FCNq7FgzUyqEuy7QqKr0kvO6hpRCfjiREZiLuZNHKEvz+JQevpxYYGYLUKGqoB/Kbmw8
         yCAVuQ/jOz8DcYE9FE724zAPW5Evz7ErOkR7CXPvxVvYkXLM0RiApn9FyQlwu31nQBxo
         u97uaMqVfGTGWXHExxdmYpdS1rNTyKPopX5k4krox8ceIC7T+RDqeqYumt2pwFJffLTH
         Z2ByyDRCYwEAnGuBMzG4zpPmHzLVuCpTVGLHeqOXrQy/ITo7ejw/bmmnbiuj105EpbG/
         rY5g==
X-Forwarded-Encrypted: i=1; AJvYcCXbCuCJ/pOX67DpdJPsMT5UA4COHUS41O9cTQwbZSENuum5nB9UvL8n6vZh5uj4LqdbI8VMaPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7DhS4l2etZl9VPwyiJCMEwbsh9/GyV2Rt+CP3u8kIJGPgdxI
	mec87eHHSvm2xQbz9LhjPyQlxrX4r3wSiFrUz9x+V3wegOCGcI+LyAIC
X-Gm-Gg: AZuq6aI9REYXv89QTtOytWAmwEHyLUyKHnnhiufnf0dUTozyA3oeHPvA56eGE57bSbP
	4KwrgsYSLgn98kQKKmCk95DPzNixYo6klVvuEK5niLKUrU9gWPxCkRCuXgiFlIuI7JM9p++cZRR
	n5NQCyChlkcTr4bHiq0b7akWtCLB7xgXug4anmPyOnLFK+u5xP6aSWcRdmZIdeN4eERbd1S2FtD
	yb9XK/QmbDRRY9tNLe/taak7UZauCbuKG1sieDwUelw6YNUb1EhZumaXVggu2VlDCMB8PD8auBX
	euHu/3yfWMuOnpwiWSO02DXkfMyIlkeUtXKQlawo5TrOIF0CgVNomD0ZEwwWm17u+xUhM69DBl+
	LRpPPnPkK0khWN/jQpvN1S/OY73lO1UY7YbS+YqUI3uKLXJJ0mkeuEodACdGMfPOOYoIsn6qVmG
	q2rI4vje8EoSWQDOkeIQN2SZBYXD3DEIoTK180qXfdH7tov4fHeXcUsWVuAds=
X-Received: by 2002:a05:690c:610f:b0:78f:f32c:39e with SMTP id 00721157ae682-79439a42de0mr6172907b3.67.1769110349495;
        Thu, 22 Jan 2026 11:32:29 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7943af149bfsm571447b3.5.2026.01.22.11.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 11:32:28 -0800 (PST)
Date: Thu, 22 Jan 2026 14:32:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 jasowang@redhat.com, 
 xuanzhuo@linux.alibaba.com, 
 eperezma@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 ndabilpuram@marvell.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <willemdebruijn.kernel.113a625cf37a9@gmail.com>
In-Reply-To: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
References: <20260122091527.339180-1-schalla@marvell.com>
 <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match
 NETDEV_RSS_KEY_LEN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252516-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[marvell.com,google.com,vger.kernel.org,lists.linux.dev,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 12A5D6D1B4
X-Rspamd-Action: no action

Eric Dumazet wrote:
> On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align w=
ith
> > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.=

> >
> > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > Most modern drivers can't use netdev_rss_key_fill() either because
> > core generates a tiny key. And the devices support hashing over two
> > layers of IPv6 for tunnels.
> =

> Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all know=
n NIC.

What is the purpose of extending?

The current length is sufficient for standard Toeplitz 4-tuple hashing.=

