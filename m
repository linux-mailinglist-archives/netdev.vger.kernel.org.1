Return-Path: <netdev+bounces-198891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27388ADE2E2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 07:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC541682D6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 05:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6251E0E14;
	Wed, 18 Jun 2025 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8z84Amt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8637DA6D
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 05:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750223257; cv=none; b=ICqNy8tzjZd8ogkNNwlIKczD1Mk73e+gYdXDcpsWmnojTE1Fpxl9zNjpZPvJNQBNHp0RPUyx1i9kELt4IV3SpNXDOg5y7hSmEC2abNM1zbP17LQlSqBG6VzrsbrPh0fCBaJ+2cy7MFbpdeLGp+NtjiYYPZFC9dNo3XeBajg/jQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750223257; c=relaxed/simple;
	bh=ZcrT/NMTdzQCwql9I9sxaDY56OIiaj78AJ6el1dNzcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s3FGlq/pVecXJ46E98NST9hrXpyYKXP5DgzIeOFz01hT/2MUMfrd0IfVc5lmcm3LFz4jJTAExnJ9niu7ndTQZ+YtlUwK09MPOVs3IrVap7a51ctMvsHN+a/OicR+OjNA79565CqojnFCQrNrpHEpCmSHOrYpOKwos2xm95YJpyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e8z84Amt; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2f62bbb5d6so5270002a12.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 22:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750223256; x=1750828056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=997KzBDAcTz3SF3NlgBOghJG+ZicsuDF43q43w1p0OM=;
        b=e8z84AmtlLhCvxJBVyYNS0fyNe1sxswQitkQqYx2ZfGFx0q0z0HXL86zcAWyvF96rs
         1WFo5DNp58BX+BOy+wqJFQiaKrb08qV+dyM7Sz7HKaCT81bM90W3cZluLg+kVrMMtFN0
         HGGsXc9c4kNYFonbSjx+UAdJaAH2oPYtE+lLwUEorI+RiUQknBg+d07CBzHsYLqNTT2V
         CiywGYTV4dZtC+4PPxxfy4k+yFoXBH41aAt/kQDUrZnxZxlf1XCA4jkEWm/nl74tq+Vj
         iXMPNbIcMLSx9u+RXGXhsAJB6jec3cyE4aO8WDWxuauLyFi5QxM4VzB1rmyWTEbsBcuN
         PFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750223256; x=1750828056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=997KzBDAcTz3SF3NlgBOghJG+ZicsuDF43q43w1p0OM=;
        b=AuJJVVODW7Uzcfd8AZykTvxkT8RSy0FEmHg97FLPoMJsqEFnezSQyfr7qc7jspdp9j
         Nzlt4EnayTANJTq6NVGm01zoe04oa3LuUhZy1T+yDxXtVhf40wJB0emoCcpH+Ci5A+z2
         6ak4QKOdf3zAgmZ5RTfXsLgtw2IKddaZ94VGPh0Z7i9tSmDdVxUdWX/WCTsI/QURp6co
         o8ub9W8R/jd7AxzKap0JbkNCXYtmTFilI/6fl2K/RqGX9xaBKStQIHfRaCTHirTkqpHH
         B1aFDNJsXjx9MrRDnhooPzJpD0Djqe4+vN+t0nWWK2cxrYrjvpqW2QDpM1BUcjzl5W2s
         Fkpg==
X-Forwarded-Encrypted: i=1; AJvYcCXKC7tk+EwSrSmIftBITnwFk9xLwfg7YwB+t5x7kszhvBSffbXYuiDQvyYEosJjT43BZLCUBrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmw0vBPORpjc+a2Jf9pSo6QdGoDC3WGFFPz+rz/cruKnaZAiy
	RFWicX4XR48C9qrO1rI0FeSSkg9xz2NChxvxuSZYZfKIdbpA4fye4InH
X-Gm-Gg: ASbGnctyZbVpaEBjEmC2LTC8xLROCcAXlUq+TSF47y/OEYfvtgfiGY1pq3MIPyrs/ez
	VFw3f7+b+khCIsTPINLbs0rf9mhw6YwANPJu3+fd/OxEs9MKzArbFcu7iitYhgMnqQu+QuDYtso
	+NFafpgIyhes21fGsNwCqIDEoUK2k3T0n3trEHveOO6jUXqdTYlJ2OcRPm18WrRwvhcEufAsK5c
	VSF/3wW8JWO9Ghex+pWRKIsTvH4BEIorYpYlkCaVASVIHWRkCFJa7wT/nuky8+wzE+JqaemTh0c
	0SdiHzd64ato/4TAVrdSZq3Id3XJGIwf6dfi5HmOlO7Ob21Cm8D2qFfJcsaRpbTw4SDI8kK4KXJ
	Y2CKYyg==
X-Google-Smtp-Source: AGHT+IHaCjIRwtRj5JGqpvuGcDRsv+elf7kOn9MIpk9sTGP7exHLEkZfK2s+oHArLvMiwMd3NcCuzw==
X-Received: by 2002:a17:90b:35c9:b0:313:5d2f:54fc with SMTP id 98e67ed59e1d1-313f1ca7fefmr26738890a91.10.1750223255600;
        Tue, 17 Jun 2025 22:07:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c19d1122sm11761993a91.13.2025.06.17.22.07.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 22:07:34 -0700 (PDT)
Date: Tue, 17 Jun 2025 22:07:32 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>, Tristram.Ha@microchip.com,
	Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
References: <20250616172501.00ea80c4@wsk>
 <aFD8VDUgRaZ3OZZd@pengutronix.de>
 <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>

On Tue, Jun 17, 2025 at 05:10:11PM +0100, Vadim Fedorenko wrote:
> On 17/06/2025 06:25, Oleksij Rempel wrote:
> > No, this will not work correctly. Both sides must use the same timestamping
> > mode: either both "one step" or both "two step".
> 
> I'm not quite sure this statement is fully correct. I don't have a
> hardware on hands to make this setup, but reading through the code in
> linuxptp - the two-step fsm kicks off based on the message type bit. In case
> when linuxptp receives 1-step sync, it does all the calculations.

Correct.

> For delay response packets on GM side it doesn't matter as GM doesn't do
> any calculations. I don't see any requirements here from the perspective
> of protocol itself.

Running on a PTP client, ptp4l will happily use either one or two step
Sync messages from the server.

Thanks,
Richard

