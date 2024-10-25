Return-Path: <netdev+bounces-139242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FEF9B11CF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 23:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC69F1C20CAB
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767D1FB8BF;
	Fri, 25 Oct 2024 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="1NWNSKP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F9C1D270A
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729892439; cv=none; b=UFfrrtRxHYby6cvI+YXexqV+Y6wcjbVWT0Kt5Lkq7VdE7dB0QG0XKWY80dBoSGPayshchpzmowy/CR+Z7QAgv7PEXdnIdM55IJDPfVtA+gVD1V9CbxDj7wasVC1Udm4HnUAcZbiqzF0p9EZFeo0mmu5U6LrzKCKcgLRyIM5FVQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729892439; c=relaxed/simple;
	bh=ZfSprE6S/qx8uNh51Ty5DiKvqz02Uuu6nbs7z4ELefQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmp/mcd1s5detCliSxJRfYtibyK6upw5+okhMH6XET0a0na3ttMN6y+YPAzsOpcKzj8bLRnygImXdBxe7kfiMobq40drhQLbFMMJGabClKZDf33rJjZoGlSgF87pqxk0SFB/rm+zPseV6yXle4+hwpUwyZi5AcoZwur4lkRK5Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=1NWNSKP+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso35412781fa.2
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1729892435; x=1730497235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TXoeUuI66gqAogIMvPXYo0rIm69ljvaQPvu49a/ToUQ=;
        b=1NWNSKP+YebTGdaGGL/bP4hA+/4qJsilD3qZi4cAINU3PmcVsGNx+H8oD+RILkm7Du
         vq0S0cnX9cTzCDZnesgmRU9Am46mYcc1HiNiFe0p2i3VyQSO5EUBw7t7I1qYwoxccRWH
         BTqP9x+TrPRS6/GeVSu0HrXqBQUXAID7xXTb7U7uiZLAapkq5hUtiBJXunePV6iTlIsr
         TtoBCBniE+BxHnOX0gbQmjXw8WCxgfJa1ROEC4OmQMJAZ8wWR5oD4/+7dzVR6VzmOauF
         YSBykyXj+suO9bmvVQJeFJt68wsP+Vihavv5/zXUNQ7Y28W26ZcYQGKMfdn6baH7Ai7i
         KkRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729892435; x=1730497235;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXoeUuI66gqAogIMvPXYo0rIm69ljvaQPvu49a/ToUQ=;
        b=TQbrrqsUDKV4ZcYZ0Ba1Sjp+V3cDBTKEwIcwNmAvjkTSCCuxmvnSTIdiExWWTmebrL
         I00/SY9DDVfSLc5lhnKdd2S3vHWh9SFsOJFiHacSZdRuY5xta/l//zLOMsfNFF+D8eyD
         2XEdIDilkDRrY3/Q086FaWuiaupeTAokp03tlSCdvfzs8wsrEA0WwDo52lTk8gwZJ8LV
         u29yKeb4QPPxM5g6yfDVrHwIpEuA9PBSb89/ZRdcUHqhR87U3B980S44YKmjD8aeh2Pi
         4f1S+/USBrzaJ7doRTuoIKpLnM5uqJF1TCk7QQD+mSK3X3GRj1t078MwNDbcAy+IIpee
         nGlQ==
X-Gm-Message-State: AOJu0YwVEI3PW5pJWGIZgDHSJxpUOM5FVx/Ox7w3K/ZZa0w2fX7SDKYq
	b7xklxUSt2PS9FMbp71agwjTsHx5OpbGlU+8Rqz6UHlsfyHeY/8OcDmt31jpO6c=
X-Google-Smtp-Source: AGHT+IH+yAkgSLWy+DS/u8g2MEc6W2INVhSys6nUDiiGMV+teDrNN50bFyvov5oQr881y6ZWMD+/hA==
X-Received: by 2002:a2e:a541:0:b0:2fc:9869:2e0b with SMTP id 38308e7fff4ca-2fcbdfc70abmr4868821fa.20.1729892434463;
        Fri, 25 Oct 2024 14:40:34 -0700 (PDT)
Received: from wkz-x13 (h-176-10-147-6.NA.cust.bahnhof.se. [176.10.147.6])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb45d1e56sm3176051fa.89.2024.10.25.14.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 14:40:32 -0700 (PDT)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: =?utf-8?Q?Herv=C3=A9?= Gourmelon <herve.gourmelon@ekinops.com>, Andrew
 Lunn
 <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Vivien Didelot
 <vivien.didelot@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
 <vladimir.oltean@nxp.com>
Subject: RE: [PATCH 1/1] net: dsa: fix tag_dsa.c for untagged VLANs
In-Reply-To: <MR1P264MB368139E2B561ADA6ABC86534F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
References: <MR1P264MB3681CCB3C20AD95E1B20C878F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
 <87msis9qgy.fsf@waldekranz.com>
 <MR1P264MB368139E2B561ADA6ABC86534F84F2@MR1P264MB3681.FRAP264.PROD.OUTLOOK.COM>
Date: Fri, 25 Oct 2024 23:40:29 +0200
Message-ID: <87jzdvamk2.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On fre, okt 25, 2024 at 16:07, Herv=C3=A9 Gourmelon <herve.gourmelon@ekinop=
s.com> wrote:
> On fri, oct 25, 2024 at 17:01, Tobias Waldekranz <tobias@waldekranz.com> =
wrote:
>>Hi,
>
>>Could you provide the iproute2/bridge commands used to create this
>>bridge?
>
> Sure.
>
> I'm creating a VLAN-filtering bridge:
>
>             ip link add name br2 type bridge vlan_filtering 1 vlan_defaul=
t_pvid 0
>
> then adding a number of ports to it (with $itemPort being my variable nam=
e for the new ports):
>
>             ip link set $itemPort master br2
>             ip link set $itemPort up
>
> then setting up the VLAN on the bridge (with VID =3D $index_vlan):
>
>             bridge vlan add dev br2 vid $index_vlan self
>             bridge vlan global set dev br2 vid $index_vlan
>             bridge vlan add dev $itemPort vid $index_vlan pvid untagged
>

Alright, nothing out of the ordinary there.

You say that you are "trying to egress untagged traffic on Port0/meth10"
- could you explain how you do that? br2 is a tagged member of the VLAN
in question, so I guess you have stacked a vlan device on top of it?

In your response to Vladimir, you said that you "occasionally" see
packets egress with unexpected tags. Could you give some examples of
flows that work as expected, and flows that have the errant tags?

