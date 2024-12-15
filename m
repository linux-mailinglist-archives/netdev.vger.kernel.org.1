Return-Path: <netdev+bounces-152045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC709F2760
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 00:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 349647A0369
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 23:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392241BE854;
	Sun, 15 Dec 2024 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="PqSlJ2sN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E156E1B412A
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 23:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734304385; cv=none; b=nQN2xWp0LDAKtMTRK4X60lAP1TBwDk6Goe2vSjTsjDk6L8pUbHrSIxssTi1DkJ53FLM2Blx1iDRzIbmUdlBCNpftCdbrzg3XjIn8h04GT4ZZVag/Ye5IHXDAE70m6WQXD7LwSw0vfjk77QXx0t9RPXMwoMXnoDWGHVLGxYcabF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734304385; c=relaxed/simple;
	bh=gsxp0tCgirV/667CdngjbUAgx9+RrPYW0og/CX13bZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tWFSHBqY01gKot+KMBobuVCmK44pU216UoMpwtTCBOOlhBbNP9J0IRjvSJVcm1GSGPbejHLbY4kWBthoPqKgyqqVyJ5qAqZ0b/nIRgpjxK98hrkOrxQtuCUdvuhLsIXmsvsx9BPLrRUfKQPOSjN/H7Vq1TMnuAWqx2XRu4bFHa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=PqSlJ2sN; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401bd6ccadso3574469e87.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 15:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1734304381; x=1734909181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pt5kMeZvC3W/u8ruvVEfuMJ9XzIxaqdT28GDq9fVNjw=;
        b=PqSlJ2sNhZQYui8M6T7/DqW4mJf6/XEUBZky8LQRa0HTnhANllHlWwgXD6CjCyh9P3
         f03yXDWepOpKp0S4x72MnM3V7Z5mXOFCOYgFThzogqgdFKX9YaqXGSvndRXM3biZW9NW
         TypiNapBBpjmYkUozkyg0HDLU8akaDMqVqlJQtqL1geJou/NAeKMvOCr/2Ob/SqLz6Ac
         AjQ+0L8pxm6qnBhV2sgwROXmzarpTgH+yZXnuHP4MDcXbb4p1W6cZZxQATUTdJpyrDHH
         ocHcdekQYNj3NeArYcRjb99yz/wvweO+/RUvjUiOKkpjmamqXYw4mtidwEb+PzNSteYg
         vVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734304381; x=1734909181;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pt5kMeZvC3W/u8ruvVEfuMJ9XzIxaqdT28GDq9fVNjw=;
        b=XQ6/8KrZEQ4dqNUomKZ+Br+AC1XMuGb9dgGeFwh/lpyC3H89st2v2xsBWzEayY20Vo
         uFzfK/5FUMy1xSV5HEWClXL092AHpDwrBIMphQipL+qHIa/BbvsY78aItncMNtd2cPQF
         NoMdvJQl/Wbjj3yy2W8Bu0GWd/iTYGoGQMRWxWkQUrH1JywiQtDL414/sXoTjVXOKluQ
         8rSdwZnKhLT8QYa0XVIUO/MEw9Rmf6Rg9Wa5Q8MlmY6Vjn3nLHTCHiA0znlhNs6ZG7vS
         IN65AxxzcZlI0lEtiG4w+QgIsBILI/OfUzyXiVdX7KtQNk7Z5hdQgUos5sk9oc4P6/gS
         VENw==
X-Forwarded-Encrypted: i=1; AJvYcCU3pvdLtD+UEkzxB1sNLYAmCFhnH1lXhIBc+wu13IadNyxO1jTC0CL9rGcazW3YYT/2aoO8g1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeYdoi/cJCZ13ZokAGw0dCvafQ8GOrGi81Gk7xd5Uhr4r8tqzK
	I4cij7K5o27CYdhJwJC6uqTpKINl+gYy9iZf2xnKhMiFOoT5/BhybHpoiP59VU0=
X-Gm-Gg: ASbGncuCOWnUCCHL6WWTOvkZa0mtZdYNGrlJIsoPNagiSl+qcB1KT7M7LCPxeZWIi56
	N7pY1tHCW8arL74iomVLowpQHnWfn7jJl3lLFL24MAju02rmzwDX4vzmQbRpuCZxOuTrqz72nGF
	Jp0Z/TGh62A7eoJuvy1M2wwDaKbormbxcWU3vjjXaIsW3ov4pPlgO8vkFam5jGv0fctH2tk1ZrB
	+RqHCRTipVfsfIr1DLPuvLVBzqIuNJ7jiT4CBtg2GXrBt+G11a4eiQgmdmP5CEPuVSMCBKXYaqm
	KqjScAUfga/G/g==
X-Google-Smtp-Source: AGHT+IELKMzcL26Xbr0eSdJcEmaPb24GEFIZVIriI2UtHVJBcM672VpE9paXWzJ9YJ6A5p9Abez4qg==
X-Received: by 2002:a05:6512:158e:b0:53e:3740:4a86 with SMTP id 2adb3069b0e04-5409055551emr3138954e87.18.1734304380582;
        Sun, 15 Dec 2024 15:13:00 -0800 (PST)
Received: from wkz-x13 (h-176-10-159-15.NA.cust.bahnhof.se. [176.10.159.15])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120c13b55sm627631e87.191.2024.12.15.15.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 15:12:58 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, kuba@kernel.org, f.fainelli@gmail.com,
 olteanv@gmail.com, netdev@vger.kernel.org, linux@armlinux.org.uk,
 chris.packham@alliedtelesis.co.nz
Subject: Re: [PATCH net 2/4] net: dsa: mv88e6xxx: Give chips more time to
 activate their PPUs
In-Reply-To: <87ikrt98d2.fsf@waldekranz.com>
References: <20241206130824.3784213-1-tobias@waldekranz.com>
 <20241206130824.3784213-3-tobias@waldekranz.com>
 <518b8e8c-aa84-4e8e-9780-a672915443e7@lunn.ch>
 <87ldwt7wxe.fsf@waldekranz.com>
 <9ba73b5b-1b76-48b2-9b37-fd8246ef577a@lunn.ch>
 <87ikrt98d2.fsf@waldekranz.com>
Date: Mon, 16 Dec 2024 00:12:55 +0100
Message-ID: <878qsg8rrc.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On s=C3=B6n, dec 08, 2024 at 22:23, Tobias Waldekranz <tobias@waldekranz.co=
m> wrote:
> On l=C3=B6r, dec 07, 2024 at 16:38, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Fri, Dec 06, 2024 at 02:39:25PM +0100, Tobias Waldekranz wrote:
>>> On fre, dec 06, 2024 at 14:18, Andrew Lunn <andrew@lunn.ch> wrote:
>>> > On Fri, Dec 06, 2024 at 02:07:34PM +0100, Tobias Waldekranz wrote:
>>> >> In a daisy-chain of three 6393X devices, delays of up to 750ms are
>>> >> sometimes observed before completion of PPU initialization (Global 1,
>>> >> register 0, bit 15) is signaled. Therefore, allow chips more time
>>> >> before giving up.
>>> >>  static int mv88e6352_g1_wait_ppu_polling(struct mv88e6xxx_chip *chi=
p)
>>> >>  {
>>> >>  	int bit =3D __bf_shf(MV88E6352_G1_STS_PPU_STATE);
>>> >> +	int err, i;
>>> >>=20=20
>>> >> -	return mv88e6xxx_g1_wait_bit(chip, MV88E6XXX_G1_STS, bit, 1);
>>> >> +	for (i =3D 0; i < 20; i++) {
>>> >> +		err =3D _mv88e6xxx_wait_bit(chip, chip->info->global1_addr,
>>> >> +					  MV88E6XXX_G1_STS, bit, 1, NULL);
>>> >> +		if (err !=3D -ETIMEDOUT)
>>> >> +			break;
>>> >> +	}
>>> >
>>> > The commit message does not indicate why it is necessary to swap to
>>> > _mv88e6xxx_wait_bit().
>>>=20
>>> It is not strictly necessary, I just wanted to avoid flooding the logs
>>> with spurious timeout errors. Do you want me to update the message?
>>
>> Ah, the previous patch.
>>
>> I wounder if the simpler fix is just to increase the timeout? I don't
>
> It would certainly be simpler. To me, it just felt a bit dangerous to
> have a static 1s timeout buried that deep in the stack.
>
>> think we have any code specifically wanting a timeout, so changing the
>> timeout should have no real effect.
>
> I imagine some teardown scenario, in which we typically ignore return
> values. In that case, if we're trying to remove lots of objects from
> hardware that require waiting on busy bits (ATU/VTU), we could end up
> blocking for minutes rather than seconds.
>
> But it is definitely more of a gut feeling - I don't have a concrete
> example.

Andrew, have you had a chance to mull this over?

If you want to go with a global timeout then let's do that, but either
way I would really like to move this series forward.

