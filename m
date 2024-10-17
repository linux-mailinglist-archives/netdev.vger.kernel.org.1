Return-Path: <netdev+bounces-136418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A459A1B35
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A1A1C21868
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75EB8194A4B;
	Thu, 17 Oct 2024 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fp1IMxDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470C116BE0D
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 07:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729148490; cv=none; b=skJ6QybAfT6R2rS2xL/i1OS7HrOjXM0BwO6CQyvMi80IzKP2x0nU+2vybphaS2gBKXGXWJ+2zWt07m9lSSyiQAozUhsyDsVCsPyO/Ik9/olpCa1lt1lAnXjIPsjN2SwP9JlptVhfS0spK0KvhRKJxYTLalV3lSQxHVi6hXG7sSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729148490; c=relaxed/simple;
	bh=cfQ4W8dtUneEdTlcTtzoSfvOaCx7qGxML9QIQhTOKgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6fwW4GfPWaoD6hKLDwHcx6i/DhxtsxaRlXDphAiuc9wM2NrVfMDrBXpa2geWq7dYp7zMILkd+7RVewOiYnrYpGh3+BgaCEDDXm4U4SqvvUCgne70fpgUCapZwuECrv15wl7gK7tUZw8Hf3EwpPYq+6IZ3qnzofQQhqbSZ0NW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fp1IMxDx; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a017a382bso5230066b.3
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 00:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729148484; x=1729753284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zpgrnm+I9LZ5aZj31pOguEXqFs5ziTHQVrfacJtVg9o=;
        b=fp1IMxDx+19ev8F+8Oj8ZPn5nXwiMP1xbiupsZdwwkjbn19bZOeUTkw8XOtpis6KB+
         jqG/m0GN3Dv0SeOEU3VTBgW1fw069RSAn7C6rMtBkcw0Q8IUdEuwvHpqvzUa978DTQzJ
         uHnjdu3UFTwXHRsx5X8jEof1PMLDsoFJEhsA6SV6zhOV4/eseAb8vw31rnLFMWOjPRBr
         3AtVJEkgW/SrFFG1UGXU3dhQ1yDOO8quONsk9K7pxnpkVOj9R0FPqEbtTkxd6mCeuZr8
         eDJAESRRIPp0SvJwIGwsF+0XknSLuxAhRDEV+2hqwTOUT1Eb4NnvixnKt5tQN2B5iizT
         ZSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729148484; x=1729753284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zpgrnm+I9LZ5aZj31pOguEXqFs5ziTHQVrfacJtVg9o=;
        b=jSQv9Ix4flKiGM3IYKVoS/UkxDmHK2a2M4CbO6Aiz2Gl3JqRxdvdQcxA8mRRY1xUKv
         Zep2sfFC16imk9jxr6RQIva9DBleqmMi+u089BRA9/MgB3MdX6aBVdrCbKTejX/QFKHl
         IZ2VhO20Po2MZ4Aa/aVoK7gX+Zv43iRVdIk8t3076AxokXNKusjugu4TOW0goPw1D6Sq
         qsDNiE4I5SjuQL73ED5MM6aM/OyIcasKcXrD1Uq9S5+bFvLg1YYozj8wFE/9v1roTajH
         /LfR6cA6dWr7iVJytsKSl4c7RNoMJbMpG6+vUZCr0c4MTXB3yt/PsOpVNqf0L5Bo9kJf
         7Pig==
X-Forwarded-Encrypted: i=1; AJvYcCVU5R/T3pbdcFOO2AaobMGWCuKfYKhDCCc9LRkqYeiA1d4412UF6HfELPQrxiYgiApa9L6C44I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTfLhNX79/B7IkOzxyiGv83JQbH+elI1IR5VLuIzUA6EtY2+MU
	ki7IlAx+L91KC2tdPPGw3s95Fif/h7l/56Wy/L7URsnF2Am54mAi
X-Google-Smtp-Source: AGHT+IFb9aDFX+3gvskmB5HfDGS9vFGWyHXgvcCjfyBzllETw2Xve/KzW+AVpDYcRM9LRUf4huUAKQ==
X-Received: by 2002:a17:906:19ce:b0:a9a:522a:ba3a with SMTP id a640c23a62f3a-a9a522abb9bmr57714266b.2.1729148484137;
        Thu, 17 Oct 2024 00:01:24 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2971ab1fsm255950666b.39.2024.10.17.00.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 00:01:23 -0700 (PDT)
Date: Thu, 17 Oct 2024 10:01:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2 4/5] net: phylink: remove use of pl->pcs in
 phylink_validate_mac_and_pcs()
Message-ID: <20241017070121.soahbrrhgp7bpdjk@skbuf>
References: <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
 <Zw-OCSv7SldjB7iU@shell.armlinux.org.uk>
 <E1t10nf-000AWi-PR@rmk-PC.armlinux.org.uk>
 <E1t10nf-000AWi-PR@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1t10nf-000AWi-PR@rmk-PC.armlinux.org.uk>
 <E1t10nf-000AWi-PR@rmk-PC.armlinux.org.uk>

On Wed, Oct 16, 2024 at 10:58:39AM +0100, Russell King (Oracle) wrote:
> When the mac_select_pcs() method is not implemented, there is no way
> for pl->pcs to be set to a non-NULL value. This was here to support
> the old phylink_set_pcs() method which has been removed a few years
> ago. Simplify the code in phylink_validate_mac_and_pcs().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

