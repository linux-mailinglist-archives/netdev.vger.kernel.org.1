Return-Path: <netdev+bounces-238840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4FAC60088
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 07:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A90EE35FE30
	for <lists+netdev@lfdr.de>; Sat, 15 Nov 2025 06:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547081B0439;
	Sat, 15 Nov 2025 06:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j094hZ1q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA970814
	for <netdev@vger.kernel.org>; Sat, 15 Nov 2025 06:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763187551; cv=none; b=gN8LQn5cTJrMrFgWUtiNvq1HRBIJQb+Aw0qcl/rkzOaDw4pqyXxP0EABZ9e6PVPURwlN4u4Ty8ZU+0yauSsXNrApJusyfDhqFCvR/PINtJ4y4CTQ4B8kbdoqL4VMm0zFsRx3pZACBq2+YXheX6s6jhAX0yBp29VN4wXzijda9lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763187551; c=relaxed/simple;
	bh=T5JnLJO7ZiL2KDY4QUdV27phVZ668Cgm5xcsNh9svn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaIwX/bghF1nnXcEPWx6iTrBflrudiIqKTonr9mS2cCuuJ0tJkcKeP0zHLrejF+k3kUElaLTNRnpscppCnx+TDwRsWhnUWjc3VJwvdFkV0B3GHWCzB4PA1C0UgSltiZjcwccgxDEE2wXK7/ctleFG4+Ya5a83pfrrkkVD8nIMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j094hZ1q; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429ce7e79f8so2019033f8f.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 22:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763187547; x=1763792347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3mbPgaryrxeNqtX+QZzwKqYuiwR5t4mAID+C3myv2o=;
        b=j094hZ1qOXoG/28yz2AzOChxUL/hzoL4U4QK7ozM3y0nXlkFj4kd0io9MUQdrdE+WH
         /glT23UNPcKXsxLZZh4rH1MqKvXHajCnTrnrcOarpG61CtMY4CwlZi84llFTARtLTk6g
         cd5EE8IqocXk8PiiYTKmGV/PlF4/B56B/soIyZXzLiq7XdurXxjtSvEnRC3KmhSqV94C
         DgWHBBzDgAW9pAb0ctP0OQR1nUsNZs5DLpoSFHxWEXB1VRJpxvD7ahvunTOMUaza5R6J
         G+G+PbmWbrcqjuCs9ZlW5dDk1StsPuFQwY83fXib6QDmlAXFBNPYSx291IzhffRAU7wL
         OQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763187547; x=1763792347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3mbPgaryrxeNqtX+QZzwKqYuiwR5t4mAID+C3myv2o=;
        b=h8VVoiK97mWxW5PZ6ynee5W+DJ4Bq0gxGOdFdwlCw7XqVS/PM4hAKk1fvE8neOX41v
         F6bEPpNUlPSJhrQPNc3gynJEOih/H3pFemrsVSZCj+qUSOVL3054JNDE7drQxpa31/JE
         GVkw5iLCUEL5gfhqK6tEGMJxF4lxm3+PUguF9tJF9sg1725ML7+7vach0ZOInMdx6Tfj
         kC1rSaWm7faRHW9m9Y5Gv1G5HF5kaiJchKVS/1ts5ALI0eafjdTX+YreMVX8EaQIVXQG
         cUE3I8ci4csZ2U29CnQzzQRVOxoxVBvUrLchIglTg7ni9RA+9gGYn1EtC36AKBXffaQQ
         fq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWqaH+s4Q634eo32EBlTsIYowwRJy0jTD7SAnaFgqNSTUN8wJ7NTW0Q5sif+PHm30pqi3LlJ9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZf4k5Mp68uTLdtgM72ycfkrfXzGoTnNk5AhlgrZFmWaz+atIs
	B4WDCm9g/1tB4GE9l28ZMQePjvAl+QvrG5ij/n4X3hJ23br+IhBpP84oNVkIlZM5GJIQDQSIcvG
	QZIYOSS613FlgHxvryMQcSSObrCnlONk=
X-Gm-Gg: ASbGncu1C4NGCuOnCPSpTrADzE6k2jYcWKJd1Q+WXPnvV9eWdokjv4PQanG25ZstO+N
	6RiWak4VR7Ao+13mNzcQ+qS9Ak8xmVVTH96Et9pd+QlhFg8rsU6ySUBkc+xSX74mGvarmgT0c5M
	SPFhSc4zSfwWu5+7cL/OTSAT1xK9O4HE6K8um9RfuNheq7IqtahTEjzuyUGFL0iC5WbWL7HFpBb
	pE7aOhgYFXV6eTV60qfm5XhYuNsQIRxFMKjWxQesZdfNpLEN4mGGmxaAzi6wyRScZecTFjXRJ72
	MslgBHYDbZdKiQl/
X-Google-Smtp-Source: AGHT+IGgbhBNt76q0a21kqRU/jA2zxiMhImDf+L2zCuJZ3aYlwFcVIl5jXYXcUXtUYa0efMWoxr/yX75BoMpdYNX+2s=
X-Received: by 2002:a05:6000:2405:b0:42b:32c3:3949 with SMTP id
 ffacd0b85a97d-42b593821f8mr4741547f8f.31.1763187546656; Fri, 14 Nov 2025
 22:19:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdo=cNAy4kTrJ7KxEf2CQ_kiuR5sMD6jG3mJSFeSwqD6RdUtw@mail.gmail.com>
 <843c25c6-dd49-4710-b449-b03303c7cf45@bootlin.com> <eca707a6-7161-4efc-9831-69fbfa56eb93@lunn.ch>
 <52e1917a-2030-4019-bb9f-a836dc47bda9@trager.us> <401e9d39-2c28-480e-b1c4-d3601131c1fb@lunn.ch>
 <62469297-d873-46cb-9c44-0467fd49b732@bootlin.com>
In-Reply-To: <62469297-d873-46cb-9c44-0467fd49b732@bootlin.com>
From: Susheela Doddagoudar <susheelavin@gmail.com>
Date: Sat, 15 Nov 2025 11:48:54 +0530
X-Gm-Features: AWmQ_bkRrB-5eH3o9KXk8c_u27kaL7tiHcaM9SwrFtMgLUHQYUMbQMUo5ZC4tcE
Message-ID: <CAOdo=cPFTR+1OWPNwo0E8LsyoMWo3BoAMDQhe9YfPZ=jN3aUNw@mail.gmail.com>
Subject: Re: Ethtool: advance phy debug support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Lee Trager <lee@trager.us>, netdev@vger.kernel.org, 
	mkubecek@suse.cz, Hariprasad Kelam <hkelam@marvell.com>, 
	Alexander Duyck <alexanderduyck@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,
A big thank you to the community, especially Maxime ,  Andrew and Lee,
for the excellent support with my recent query.
Thanks again for the valuable assistance. The information you provided
will certainly help my team better. I'm grateful for the time you set
aside despite your busy schedule to help me with this.

I anticipate receiving responses from others regarding the inquiries posted=
.

We'll work on the recommendations and propose a solution.

Thanks,
Susheela



On Fri, Nov 14, 2025 at 9:48=E2=80=AFPM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> > Linux's understanding of a PHY is a device which takes the bitstream
> > from the MAC and turns it into analogue signals on twisted pairs,
> > mostly for an RJ45 connector, but automotive uses other
> > connectors. Its copper, and 802.3 C22 and parts of C45 define how such
> > a PHY should work. There is a second use case, where a PHY converts
> > between say RGMII and SGMII, but it basically uses the same registers.
> >
> > fbnic is not copper. It has an SFP cage. Linux has a different
> > architecture for that, MAC, PCS and SFP driver. Alex abused the design
> > and put a PHY into it as a shortcut. It not surprising there was push
> > back.
> >
> > So, i still think ethtool is the correct API. In general, that
> > connects to the MAC driver, although it can shortcut to a PHY
> > connected to a MAC. But such a short cut has caused issues in the
> > past. So i would probably not do that. Add an API to phylink, which
> > the MAC can use. And an API to the PCS driver, which phylink can
> > use. And for when the PHY implements PRBS, add an API to phylib and
> > get phylib to call the PHY driver.
>
> I also think ethtool is the right spot. In the above explanation, there
> may be one more bridge to make between the net world (i.e. the MAC
> driver) and the Generic PHY subsystem (drivers/phy). The Comphy driver
> for Marvell devices for example is implemented there, for the really low
> level, Serdes configuration operations.
>
> If PRBS is implemented there, we may end-up in a situation where ethtool
> asks the netdev for PRBS (either directly, or through phylink), which
> will in turn ask the generic phy framework for that.
>
> Maxime

