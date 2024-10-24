Return-Path: <netdev+bounces-138718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B41989AEA25
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79C14281787
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5591EBA13;
	Thu, 24 Oct 2024 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaPyaUJ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E301E3788
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782966; cv=none; b=Kp3Y4n3yXISrZWhPyJQrl9YWimMxmp9bG9NnflEvzz52FhNnl0DdT5rtg8mVPuwruS6pd2Zsy5nkGavnk7TmvXzBmuvQTDZoLnwBDg2NWZXSTlFlALSPR5SQ4bSWb/nRe5fmtqhjKKkTgLKDEpqHNg+sFUsTnKKKZ3h6OL7I6yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782966; c=relaxed/simple;
	bh=nGUp6o2G+DksTiOt6a7N/NXb1wzVqkw+H+jgul28Afo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ0aD4AdziPGpGNMn5H3ul6Oxgh0A3ll9reffsWQpmI991AJpCwKrSFJfFK9Fq+J3bxkCaUEpP3TXiSi58GCBtsoO3lCPsAcqfrBbxHeHJYIcgJvh/FxsfTOjxUsZUgpO0xP8m7rI3OVB2MKxxZ3J1SK5MpREsvJ3bS8TQhiA40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LaPyaUJ1; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e3cdbc25a0so13280137b3.2
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729782963; x=1730387763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaADn9URBFh1nd22KCHDRtEm08EBG4Yb+gFrTluN51A=;
        b=LaPyaUJ1wQeHbpyvkxwmQ31PjK7b9GjMv2p89oKWnBMBBloGnSlAw5f4vGRVTi25oo
         2ZyEG6ZAqsOaexlWWFdeYSFO4tYJ+Ef+2XbAS8b6BlBjbBamdw/c67wHf8ob6k1ONLXV
         aRg559KlDkxlRYl5AysPfBuOu+EB5ioY5AFO4X1xo9pTS4i6IjfmeMXkvt5Dwy3sQgJt
         5rPbqX3oMhhM5XbMxeMvwEqEeRqbddoI22/gsGdRUZV319OF9rlUA4ObMaQmhvx4cAaa
         wGFh2477dHYk73/gT6GMsy/fwu05Oyempx4HljjOBR3AbKLN8dKxj8sMmCTjBpC+EnD5
         xFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729782963; x=1730387763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaADn9URBFh1nd22KCHDRtEm08EBG4Yb+gFrTluN51A=;
        b=Mq/Heyq99ZEqYFXMBWG6X+ioa8uxd+nkZzpdWOBDZqyaKV+HZWyTmargArAxPrtTkC
         2wLu/gewgYFJutKbTEvbJRfWcP98YHTrs4vLXw18GmzLoF30Y29CFTn5ofnDpsuWQvay
         GhJTbHYTIUcUAPGzsQ3/0ZlQ8r18yu3AVq0w+cghQdE6VI1A102E4G3uHsc05lr04LrV
         6tGQyzOFErjX+HcDrVtCx41K6lqIsiWRJWgfH82M0kF2VXK5CH3zlJBUakEA6ZTlYPcQ
         ESqNja5dxasWj9oESL9qUeII/iRb4b36THHvnhSPbNFgjcqRQxasQF/3anQ4uQNjzRbk
         CUVA==
X-Gm-Message-State: AOJu0YyoYJRbFTMfOsCNUnxm8TDu6RXZW9uXFotGZQzXRPwiSMPVRdqS
	php0J4aaoOsfjBqhsax0H6BkLTeN5Y3JYEOp7WC1KnykIUv+gs9ihJQ1TCCImhhphMaDYVqxirD
	oHx1o9OjxhS78NrD3e48ySmaPX+1dmlNx
X-Google-Smtp-Source: AGHT+IHLVEVnP0myAwD6PK5m2f7Y5wOazd1hq62e4LO5ZnTfbops5Fy3wZt9OfhqfJ51XSBq/dQskJjEQhuU6mzViRk=
X-Received: by 2002:a05:690c:ecf:b0:6dd:d2c5:b2c with SMTP id
 00721157ae682-6e7f0df62d5mr70560667b3.4.1729782963627; Thu, 24 Oct 2024
 08:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEFUPH2npsz4XKna0KYjOeU_MfYN-bVTw25jn6m2dS+f32RuxQ@mail.gmail.com>
 <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch>
In-Reply-To: <630f1b99-fcf6-4097-888c-3e982c9ab8d0@lunn.ch>
From: SIMON BABY <simonkbaby@gmail.com>
Date: Thu, 24 Oct 2024 08:15:50 -0700
Message-ID: <CAEFUPH20oR-dmaAxvpbYw7ehYDRGoA1kiv5Z+Bkiz7H+0XvZeA@mail.gmail.com>
Subject: Re: query on VLAN with linux DSA ports
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you.

I have the below query specific to linux.

I read that there are two approaches for VLAN configuration in Linux.

The traditional way of creating a vlan interface and assigning an IP
address to the interface and the vlan aware bridge. Do you recommend a
better way from these two approaches? Any advantages of using vlan
aware bridges?

option 1:

ip link set dev eth0 up
ip link add link eth0 name eth0.10 up type vlan id 10
ip addr add dev eth0.10 192.0.2.2/24
ip route add default via 192.0.2.1 dev eth0.10

option 2:

ip link add name br0 type bridge vlan_filtering 1
ip link set dev eth0 master br0
ip link set br0 up
bridge vlan add vid 10 dev br0 pvid untagged self
bridge vlan add vid 10 dev eth0 pvid
ip addr add 192.0.2.2/24 dev br0
ip route add default via 192.0.2.1



Regards
Simon

On Thu, Oct 24, 2024 at 7:29=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Oct 24, 2024 at 07:14:28AM -0700, SIMON BABY wrote:
> > Hello Team,
> >
> > Can I know what is the best way of  implementing VLAN on linux DSA user=
 ports ?
>
> Ignore the fact these are ports on a switch. How would you do this if
> for any sort of linux interface?
>
>         Andrew

