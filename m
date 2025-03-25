Return-Path: <netdev+bounces-177632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4603CA70C49
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3152B3A4142
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC561EFFBE;
	Tue, 25 Mar 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=insidepacket-com.20230601.gappssmtp.com header.i=@insidepacket-com.20230601.gappssmtp.com header.b="GUG9JGI3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E42676E2
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938732; cv=none; b=BGrHv+CQxtfAmDm9AvOm0c4ob0ANhQIyCOYBFysJTJ6K8Jcs78LOqRO0/+NhmA6zW61C2fcLsKnK7s858g3d/BJkt56r0IG/ksg1L8yK3PSsfSn0dWmshsW+AsDBTEEP+ERDoxP9dnEYwHh4ENE7rKm+Rwrw5SQDVQXH68INrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938732; c=relaxed/simple;
	bh=tUh2op8VPcxbP4QP4tXTpXyAsE+6Z9MFq8jy9W6Kn2E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pxxd0T74LhGJGhdBLG615v2jRgr7Sd2/kzb3QQx7pysQQ6EBm84kuZYAJz9w2MHKARbiNM8CEeN0wfV9WRa+ZUFmSUmMl14XF536YmSTW9zU/tAVb1WEtls3GNAMMB7VK6eLbzSBy2q2UqW/YpXZ0ZCphjz/kxWLo4k4s9pseEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=insidepacket.com; spf=pass smtp.mailfrom=insidepacket.com; dkim=pass (2048-bit key) header.d=insidepacket-com.20230601.gappssmtp.com header.i=@insidepacket-com.20230601.gappssmtp.com header.b=GUG9JGI3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=insidepacket.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=insidepacket.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso47008275e9.2
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=insidepacket-com.20230601.gappssmtp.com; s=20230601; t=1742938728; x=1743543528; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNxcvZeJFyq7U57HTA0yTTcBYzE7dkBrIr1nHZ0OYOQ=;
        b=GUG9JGI3GM7ggX2QsOzAXmDJ/Rmugo2R04jjRpKp8ZmaI2eR38tqe60MUouOtVJqJj
         muPQUb3QpgDQ4r9XC/j07rEErMEb0DQQtgwZkO+/+AXqJegpBgKAGuF8bAi+7hL1vP9S
         LyJ/hFLov0yrNBYXUqkR40ncjNZV3gScU9mpFg7yjAvGTNWex10taqvjAz2w/zYS0pHx
         1TEeGy5qogpQ5J019bVxpLQz9+cG6ZbtmBksJcjEn++Tv8A/5hcxlOncRvYIYge9nM0Z
         nOwnzxxwEdHBZBdlOo6c7KU35gCjK8IDrIlDHMxhLQbbKFh/QZU+GGygeVDwh86AmTzD
         fvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938728; x=1743543528;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNxcvZeJFyq7U57HTA0yTTcBYzE7dkBrIr1nHZ0OYOQ=;
        b=uWA/dPUAUQFwROlSzv7wfUfFryNfN3BeO/cqOFGUu3jf3e7hoeZNV3M38dDygBDQcv
         qJPKACcWxVRk6wuUi5+D9GVqHN1XYIY/6pjS1SanhJUdv8pJPkpnRt/QDnE5uIgVcr+B
         F8qjXd+G64IWT5oARsyNreqmuOQ+hyR0/5OblUoQa2SE2c1co4px5juFBDgp77VrERL/
         L8CLjGyvVXsErprRyRHr+uRcWbg4QuNElBBBZA4F1vnmMLfIXEeEvALZK8heQBd2wDk7
         7GGGkH02bMcden2uLCNvx7AFPKfDqCfwrSlqBUOfFIG4nUW7PNPTpWE8VeaYQqrHv/+2
         BbXA==
X-Forwarded-Encrypted: i=1; AJvYcCU46/s7tZV1o5t1AGNcQO8IBuXg0ANvapaZRmv7HppYzj68sS321smne2ZVOhrLxfjZ5AHgZwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNw/gCAv+3n9vwpaviaKDpqLPOfysfC0CfvfzUGpuD2rgQOIMU
	nMIccLUAjnIZS11SbJWHfwFMqQEFqZNG/H3GPseDPRy0UVpjCmvyD/NaIRIS3Dg=
X-Gm-Gg: ASbGncsTkRPm3d6CMiMG50LydyvKq1/aPn/oHhF9h9902HvM+0KbG2PoQLxqQqjWr7o
	9YEJY5QFxpPSfo62P/ZpiNo0u5zE6Y/X1QY1oFnvd1wVjNYeZnw8ERzx3fDnliDhQk8HD2Lm6C/
	Zo7CZV01w6YJRRT3WIjYRpvIJZ3iuw8rafQV3bL2P2Wuybb/lWQY/6WqorhvAjRVnxW/k6Zkf0W
	SVx710PZm+A6Ft3afPglzMvTAMZF5F0o0llxlfK3Ft6eeHBgFHM70KpqxcNrWBUP/UbgrDEOZlk
	rl+HVm+KhuFCJmBfeCycOPZ5xrGlnTEL+wWW6H/jlQYsiYXCOcPYhsn+MV0pR29BmQ==
X-Google-Smtp-Source: AGHT+IHMYXt4vz7ufgHG365y+6LFS1dWL0AnJGHWVllat4Gqsa+h1U+54p82QAEZN1EgnKacCj7AZw==
X-Received: by 2002:a05:600c:5488:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-43d50a219a4mr190492835e9.23.1742938728363;
        Tue, 25 Mar 2025 14:38:48 -0700 (PDT)
Received: from smtpclient.apple ([212.199.9.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d440ed4cbsm215279405e9.34.2025.03.25.14.38.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Mar 2025 14:38:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: ethtool read EEPROM
From: Eliyah Havemann <eliyah@insidepacket.com>
In-Reply-To: <7e3eb464-054d-404e-91aa-eb50d5640099@lunn.ch>
Date: Tue, 25 Mar 2025 23:38:36 +0200
Cc: Michal Kubecek <mkubecek@suse.cz>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DA0926BD-F48B-4A1E-9C88-E56F9F1FEBC7@insidepacket.com>
References: <505D824D-406F-453D-AE69-7B8499A8FF0C@insidepacket.com>
 <b5dflgmqztzjmt42rw3x5ccrdth7qkc2kicr6jtofkkrmyo2cy@utly225o6zn3>
 <7e3eb464-054d-404e-91aa-eb50d5640099@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King <rmk+kernel@armlinux.org.uk>
X-Mailer: Apple Mail (2.3826.400.131.1.6)

Andrew, thanks a lot!
Russell, do you have such a collection or even a version of ethtool that =
can read EEPROM dumps and report their content?

Thanks all!
Eliyah

> On 25 Mar 2025, at 20:00, Andrew Lunn <andrew@lunn.ch> wrote:
>=20
> On Tue, Mar 25, 2025 at 06:03:42PM +0100, Michal Kubecek wrote:
>> On Tue, Mar 25, 2025 at 05:16:52PM +0200, Eliyah Havemann wrote:
>>> Hi Michael,
>>>=20
>>> You seem to be the current maintainer and top contributor to the
>>> ethtool project. First of all: Thank you for your contribution to =
OSS!
>>>=20
>>> I ran into an issue with a whitebox switch with 100G and 400G QSFP
>>> slots, that I was hoping ethtool could solve and I want to ask you =
for
>>> assistance. It=E2=80=99s pretty simple: I need to read EEPROM binary =
data from
>>> these QSFP transceivers, but they are not associated with any linux
>>> interface. This is because vpp is controlling them directly. The
>>> ethtool has a function to output the EEPROM of an interface, but I
>>> can=E2=80=99t feed it the file back to it to read it. The file it =
outputs has
>>> the exact same format of the file the whitebox switch provides. I
>>> created a small python script to read the file and it gives =
reasonable
>>> output, but I don=E2=80=99t have a way to test this against a big =
collection
>>> of SFPs and I know that this work was already done in ethtool.
>>>=20
>>> My questions:
>>> 1. Do you know of a tool that can read these files that ethtool
>>> outputs? Maybe it exists, and I just didn=E2=80=99t find it=E2=80=A6
>=20
> Russell King has a collection of SFP dumps from various devices. You
> could ask him for his collection. He might also have an extended
> version of ethtool which can read from a file.
>=20
> 	Andrew


