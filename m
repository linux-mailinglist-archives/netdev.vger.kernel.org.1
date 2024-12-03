Return-Path: <netdev+bounces-148315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F179E1197
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 04:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C58163FD5
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 03:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03E13B59B;
	Tue,  3 Dec 2024 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhtLhXVR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1337F13AA27;
	Tue,  3 Dec 2024 03:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733195314; cv=none; b=uOjXQ2+wlnvDcSRWdi470wl3w+zdQTCm7NhnzUEtAGPYehp0jPbyeSrrr0HrenHkq9sqTqV3ZwOlvaDze5BK720xkRgnGfKOsuhXRXRaqTEKYgZAl9m5TC64wdc8lKLneL0wmzuH84WsAy5+RjrLOgOp3Qo8rilQdtrU2yOKst4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733195314; c=relaxed/simple;
	bh=I9HdeuwzGQExOhA5rCI3cMyGGCW8Hc/BPNELSeD+d9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e7gKeYVIsJDbTVknZKUb6UZVDZA++tg0nJaYKbbDdpOy6K2WJrPr4UwkMsgorAuO6p1HZ78VsD6iofNZDhnahwG7NQdYoT0Nt7t4uZFOaSlQYdPkyu8Z8mC9Y45TAYXGTRuNdl9YeurWe/ayVDAfFxo9cKQskXrzxvogJx2tS5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhtLhXVR; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4adde94b285so149138137.2;
        Mon, 02 Dec 2024 19:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733195312; x=1733800112; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ku0oUpkXwkR73AMLIaDw2wq8wpaRHnOk8BrRUC2FgOo=;
        b=fhtLhXVR5z+MN5CHqVd3Qxb8kl7z1ZhtQVff0/fflIqwcvuGzs7zhfEcvbQUZ0c2Y0
         /KkeSaT7ODyE9zkldmbWp36Sx01KNYI42/14BLOjqkqmbU+WRJmM36kmUfccyYy8Ncxr
         i22aAxmuGEw22TiJuy4O5vsCE5dmxPzq7MtizrPYMcZ1vvaUas2vz8nNwEdHZjsL3KpE
         uRstztF9FRS4VocO32mglOab347xS0F8+b2YN/ruFo8wIunhISWdacykGBeMaPvehi9P
         jpG8EyYnUbDlqmT5DnZKr6jDHjmBkcYdlF1ojebVvPEtOn+fAJG8B0+7xSNuUXUucuKq
         BZ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733195312; x=1733800112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ku0oUpkXwkR73AMLIaDw2wq8wpaRHnOk8BrRUC2FgOo=;
        b=WSqu/Rs6dnqu/8S2TPNFaw8jeFfu7zYimBlAfA0GVIelG0V/2PYnk0uktw25shvUF0
         1NmhsWIvoeNb48IEz7/7yBGqqJeJGy6l4oZQjFCjkKnHRxEqmPfCrnOXU+UgmUgbPsnp
         +nbezYmBg9qY4D9wCy/Y//Xb3hI2WAt5ZLH2qoTBLk9hAXv5G4oRMEi9pOJqqYyhosLw
         yXeS8n2sMiGRcZ/yZslpr3MpngNEADIiNhkqClTYD9Ox5VH6+luo25WkiU86aF9AmTEn
         o+2YW0aUY7HJksq45uy6+JQMbUNNvPIJEZd1hXzMVu5BzjJCt2IVoOmJ94ihjRALmnzq
         YQvA==
X-Forwarded-Encrypted: i=1; AJvYcCUNXWG/UzcrmR/1Rom3UVD9HeOFw/BhvSrkZ2NSpaO9MIDCESp4lWLDxqO0e6FsmgapRj91wBaj@vger.kernel.org, AJvYcCUYEpNTDBQMt/uZvM8V4RWATbAtx6JCWkZiPnMgJpQTCV2NBV6A5BPgfJ+P1n6mcugaUb4znCI9h7hJGQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXHGZw7n8X+OVCrgDCRA+i1T1PItQs8Qal871EvMgFFYmXZIs
	FdTKFb6v1e6hFZCDVdCSzkdTkD/jPRcYvu6I3e5qHBslD9NVlEEoRDGg9biVSxhmdkNACC9k7Lz
	bH+EF1YAA0it2ptdnGe0ZAENVdbo=
X-Gm-Gg: ASbGncsUaDB+xIBPLvx6yWTuQ1kolBIDvGLaEexZNhrYiytIEhZZZDazl/r2jhPvpN5
	SB+/p+WZXoThm8L7uS//IHLwoZ8WCYLImLA==
X-Google-Smtp-Source: AGHT+IH8v5uDc6en35PwSRLhhU/ZrGuKdouVMRWWkSXQNnKi5ZS5eFaQ7PnObMtJZleYaXGc6KvIEz6/Pl1V5L0U3QU=
X-Received: by 2002:a05:6102:291f:b0:4af:47c9:8827 with SMTP id
 ada2fe7eead31-4af9981a313mr298244137.1.1733195311950; Mon, 02 Dec 2024
 19:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202195029.2045633-1-kmlinuxm@gmail.com> <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
In-Reply-To: <690e556f-a486-41e3-99ef-c29cb0a26d83@lunn.ch>
From: =?UTF-8?B?5LiH6Ie06L+c?= <kmlinuxm@gmail.com>
Date: Tue, 3 Dec 2024 11:08:22 +0800
Message-ID: <CAHwZ4N3dn+jWG0Hbz2ptPRyA3i1SwCq1F7ipgMdwBaahntqkjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] net: phy: realtek: add combo mode support for RTL8211FS
To: Andrew Lunn <andrew@lunn.ch>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	willy.liu@realtek.com, Yuki Lee <febrieac@outlook.com>
Content-Type: text/plain; charset="UTF-8"

On 2024/12/3 7:52, Andrew Lunn wrote:
>> +static int rtl8211f_config_aneg(struct phy_device *phydev)
>> +{
>> +    int ret;
>> +
>> +    struct rtl821x_priv *priv = phydev->priv;
>> +
>> +    ret = genphy_read_abilities(phydev);
>> +    if (ret < 0)
>> +            return ret;
>> +
>> +    linkmode_copy(phydev->advertising, phydev->supported);
>
> This is all very unusual for config_aneg(). genphy_read_abilities()
> will have been done very early on during phy_probe(). So why do it
> now? And why overwrite how the user might of configured what is to be
> advertised?
>

These codes are migrated from Rockchip SDK and I'm not familiar with this part.

I will use `linkmode_and` instead of `linkmode_copy` in my next
version of patch like Marvell does.

>> +static int rtl8211f_read_status(struct phy_device *phydev)
>> +{
>> +    int ret;
>> +    struct rtl821x_priv *priv = phydev->priv;
>> +    bool changed = false;
>> +
>> +    if (rtl8211f_mode(phydev) != priv->lastmode) {
>> +            changed = true;
>> +            ret = rtl8211f_config_aneg(phydev);
>> +            if (ret < 0)
>> +                    return ret;
>> +
>> +            ret = genphy_restart_aneg(phydev);
>> +            if (ret < 0)
>> +                    return ret;
>> +    }
>> +
>> +    return genphy_c37_read_status(phydev, &changed);
>> +}
>
> So you are assuming read_status() is called once per second? But what
> about when interrupts are used?
>
> You might want to look at how the marvell driver does this. It is not
> great, but better than this.

I'm not familiar with that either, could you please tell me how to do
it properly to automatically switch between copper and fiber mode?

>
>     Andrew
>
> ---
> pw-bot: cr
Sincerely,

Zhiyuan Wan

