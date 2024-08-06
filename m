Return-Path: <netdev+bounces-116002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF796948C07
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 11:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A921C2300E
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 09:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10BF1BDA96;
	Tue,  6 Aug 2024 09:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irw3K1eS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D71607BD;
	Tue,  6 Aug 2024 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722935817; cv=none; b=UFgyf7nobKe4/1b6catUMRKdmlB5JbCloiD4a0QhEliABrHEaOjGhAAkCLPbDuqF+fdU90pL0U8z/Pl0BdztoLbGstYcsdvYyobheLVKFqSQ5xqQOepfUaP8tZqYk26gD9BX1vrzVEqKv147A5lUO8YDmWYc+eNsLnYQqJ5MeJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722935817; c=relaxed/simple;
	bh=6/MBzf7qMtFkXmI+Aj2neTJCFFRXZb2axQ6D3H52sj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1MaKf1jbh5frli77DKyqxisLZhLY9CG00YEjl1n0thSSrZ3lyBGoin43UrU7+ZfrD1+I0nhYEH2IVzTvvdfEQDa2JWITMM/iac5wFUpQByBpKhQ/tOhhirIjSm7orffcA5y230zzYneLQRQvGf14CvHNAMLg6ulOPYKKZPlCZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irw3K1eS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52f04150796so800171e87.3;
        Tue, 06 Aug 2024 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722935814; x=1723540614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sKgoqBj7LDgdK9cgXdjbVyK58ya9Wcnbj0gf678fdiY=;
        b=irw3K1eSXjln0vYgDcVyJjvM0o4Dgtw0nvByvOx0geN61O8W4/RtnbyxmjKAWgG38x
         xEZnRwx/PU8U63foZjgZLCebXKRNh1nepn8hSIaQx4P6wC6gp4WUtK/VK/dqH7sdzQze
         fkuJhQ8fEmXPuGNRdA4SIJBARcRNo2GZXYsVF251Y8bC3h92lHUlc7rrtWvog6MXDn4r
         +lBan0jAhsIJQHHPb7tWbqiVo8pOGJt4CeaON57AIeLj87AcxW9Gaj6fLF2K3gbNObyJ
         LeQhweSATP7X2RskzEKrYkpjx2zo35S2wAGGYyAkgBw9CtZOzQT5yWBL3djyIHXCnwfS
         f5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722935814; x=1723540614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKgoqBj7LDgdK9cgXdjbVyK58ya9Wcnbj0gf678fdiY=;
        b=WzRAViqQSnTstfRKkTaVh/C9/5uBJK1WbC6utxeSrvS2QgX4pWAXG7yOOEb+x1BAJt
         LlgrBzGh8xJR3XKRvb/gF9ZVPeHICFEoTB0PjgIgjNmXz+RwmVyreLotjCMdmnh6pL0E
         ou6rkAAatj5C1Rosi6lA5KrtEIUTfBIpBg3dnA4nhGJyL8YYkPGfvKDfnZHF0qu0DKDI
         2Y0vy9+Yf4pDyEmDD5eCeJCgLZ5lrY8kGv0lQ/O1wS8moq9+noDgbeWZ5JvilGiCkInl
         eHhqzu4XEh5mmkyfDxi9sE95PpbINCC1sMvHG2zfYa5VM7gCvllP+UQOYmQu8IuVPnZv
         VCpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbei6i2j4ftgDENTj9dIUQag8A45mNizWRrtiQuboGAx7AWpLBpYE59C1bf6Dd2WmUFSi4mO66pmgyTCDlm8/mTDgsQIX1b4R4QQDWHCIFqsqH7FeWuAZ0qQpUD3P0QCDKC8Mj
X-Gm-Message-State: AOJu0YwjN64cHkm0exNICitJ5Fq+Chrz7e6zqAX3b6UyZVR0y5LI4cFu
	KweFWo95SwJL+0edSEQJ4NXot/rhfLHaG8a2sMMj3iBIKNqBRPzz
X-Google-Smtp-Source: AGHT+IHTZo7Przl/rVclxgOrc8JseI2RXR0EukFrflIyILA4YgmaESP3m/Bp4UxISHcGTzEdBRVrDQ==
X-Received: by 2002:a05:6512:a8d:b0:52e:a68a:6076 with SMTP id 2adb3069b0e04-530bb3b42d7mr9535555e87.49.1722935813817;
        Tue, 06 Aug 2024 02:16:53 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba3527dsm1423441e87.185.2024.08.06.02.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:16:53 -0700 (PDT)
Date: Tue, 6 Aug 2024 12:16:50 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Furong Xu <0x1207@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Jose Abreu <joabreu@synopsys.com>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Joao Pinto <jpinto@synopsys.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, xfr@outlook.com, rock.xu@nio.com
Subject: Re: [PATCH net-next v1 0/5] net: stmmac: FPE via ethtool + tc
Message-ID: <v3iwxjoaitetkrwjlcvc7xbwzybpbcvvcikriym4krurb76p7r@2ekkibfy6cih>
References: <cover.1722421644.git.0x1207@gmail.com>
 <max7qd6eafatuse22ymmbfhumrctvf2lenwzhn6sxsm5ugebh6@udblqrtlblbf>
 <20240806125524.00005f51@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806125524.00005f51@gmail.com>

On Tue, Aug 06, 2024 at 12:55:24PM +0800, Furong Xu wrote:
> Hi Serge
> 
> On Mon, 5 Aug 2024 20:11:10 +0300, Serge Semin <fancer.lancer@gmail.com> wrote:
> > Hi Furong
> > 
> > Thank you very much for the series. I am not that much aware of the
> > FPE and ethtool MAC Merge guts. But I had a thoughtful glance to the
> > FPE-handshaking algo and got to a realization that all the FPE-related
> > data defined in the include/linux/stmmac.h weren't actually
> > platform-data. All of that are the run-time settings utilized during
> > the handshaking algo execution.
> > 
> > So could you please move the fpe_cfg field to the stmmac_priv data and
> > move the FPE-related declarations from the include/linux/stmmac.h
> > header file to the drivers/net/ethernet/stmicro/stmmac/stmmac.h file?
> > It's better to be done in a pre-requisite (preparation) patch of your
> > series.
> This will be included in V2 of this patchset.
> 
> > 
> > Another useful cleanup would be moving the entire FPE-implementation
> > from stmmac_main.c to a separate module. Thus the main
> > driver code would be simplified a bit. I guess it could be moved to
> > the stmmac_tc.c file since FPE is the TC-related feature. Right?
> 
> Thanks for your advice.
> 
> A few weeks ago, I sent a patchset to refactor FPE implementation:
> https://lore.kernel.org/all/cover.1720512888.git.0x1207@gmail.com/
> 
> Vladimir suggested me to move the FPE over to the new standard API,
> then this patchset comes.
> 
> I am working on V2 of this patchset, once this patchset get merged,
> a new FPE implementation will be sent to review.

If the new FPE-implementation includes the FPE-hanshaking stuff moved
out from the stmmac_main.c it will be just wonderful. Thanks!

-Serge(y)


