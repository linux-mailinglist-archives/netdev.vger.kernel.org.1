Return-Path: <netdev+bounces-165677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D45CA32FD1
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0937F3A630C
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4C1FF1B7;
	Wed, 12 Feb 2025 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqXb5nei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB811F8BCA;
	Wed, 12 Feb 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388898; cv=none; b=lsZa/ceZCDbxZU41jlo43eOcDi23+yMhflj5hDnFYDooz/jAq+cnDig8yDRckn5fb0zfaKkZ3sJJTtinnX4RdK+Rip0IW1pYsq61u3Mhs6wsM5BACcgMQPRsJsH0nb8ZIvFDm6In605D1vomDvz3GcghR6mfyjC9Ao6cp3TAWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388898; c=relaxed/simple;
	bh=3x0zjp3yhA78sPaYfA/GN6J5m/5z4oSOdJsdFwD8T6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pfqH1aBCwol189aRrdhvrc1MIQ5tCQgjk0JTS6SkXtTDSIu0Bu3e42YNmX7IZy8zoydzOYwfpwyzF+Z7h65ZlpF6X9EJziObFz6s98MDhUxDEJpsUR/PzQ6WXi8tRZrGcdVVd0I0bJvDOnEjw9D3M7BsAq95muBsmVrpCXw2tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqXb5nei; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5de4f4b0e31so79864a12.0;
        Wed, 12 Feb 2025 11:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388895; x=1739993695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhg1/YiAdneTW9IjZaTM2kXAuUSuXXT3JDL8+Pv291Q=;
        b=OqXb5neiizCV5NleAueXyZ6eT4zpaCqKcFC5jnMLuOWN2GLkseN6jFC+A7euFAwgMq
         H3f6vvOkFnQPg6BzeEoffODungKc/HOUcVUDuz7QrEUAduEp/m/htHnpSzw7peO/Rzzw
         5DAWBUM9JsIcBbM3CcfVVB+azpZ0rtqR0FWCNJgqVjzgTJ3FUF74ioh4E7wUEDSaRwuY
         dfJfFSZbpL1uK32RpoOFPv2Bu1Iymdbe9t/5wtcuNEDwWeRSyV+EpHQuy2l6z6sAvpxl
         QsNhrJobabKfz8fEoZJCUwhnyDjS9nX5VtJ8G4Q/qOfgNvskrddKApI3BkvGLB+D8Pj0
         xh+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388895; x=1739993695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhg1/YiAdneTW9IjZaTM2kXAuUSuXXT3JDL8+Pv291Q=;
        b=tBGHdodS7Bpl79Iyprabs3dSfXxdjgqBlurP8szfopAI8Y4yE0jmIywPKsl/Ayb8mh
         kIX+PdUnPql6Cb6NygVEJABw68S7drwYBfdn3xIa71YZ11+d/FiQHq0VIS3U4fuEEupF
         HKP6vxkqTCIUqxGb/V9baMVrsANzbJRa6a+h7Jr2tWGzY9DzAb9DhNDPBsBXtMDsKRRs
         I5QeSsbtRpE8cnlbB3Yq9C80/VUj74FDsfTV9252JtfKOLth7hhX90Kt6my1N034omnb
         9PpXLKIwybJ6S1MMZhlYZmE6YCMpRmVdksJRWGCxG6Exv/pOxpCdy0UglkPYf4nWqqXv
         xpXg==
X-Forwarded-Encrypted: i=1; AJvYcCVW5BkgiCUtFifMGCKQGGypLGX/+HIZS/xkJY+p9VJMu4tI529eLduIysjwlheGT4Kyhz6cvZ5Knk1R@vger.kernel.org, AJvYcCVsS74uSk0YS4OLLFEFHQY1NSi30t7p/+mBVpxPxwMqIFKW6HPWlnaOsyT0GLVrnsFjfsSeDIgM@vger.kernel.org, AJvYcCXZNt7DCBlhe67HK9OiarAc19Lr2sFfjbTJCImORAtJt98yzoYknzpb228DhA1Sg5ruz7c2mS9cy7DPPDJu@vger.kernel.org
X-Gm-Message-State: AOJu0YwMfsjMC1jJSYdZuJMox0ffWySsbb9COMY/rljTXXlBei9Ox5SU
	AJAcNFpVd96qcfrf6M9+4bDZpFbGaiPZah5SQ3jjht4Ujh2U6rWU
X-Gm-Gg: ASbGnctS6iICelE1KJ6Df2kP1CEqJ2WEdbpgfDpquQCwN6AwPBepUP0Q6pHeAJX39zW
	rbtdFmMfsIazGA3KjOLbaSH4fZnsepSBZ/WMM/HM3eBXe0m/RNXdy0lTRDA8Dj1++V5di+zcUWj
	TB6NLbY8inTyyzMosuOVI1UHEFmf6KdI+H/hBI/pUX5eDdHdSCzTQAaXJ+XNdhWpGbK5Ndk+PgP
	o8T6tvo9Grc/xK5HvwAzwW2B8WN57slXZzMywKITmq8x8qjmEf59UWjUciJ+C6oUnm1bXXTu+7/
	tBEJhoLdWIgx
X-Google-Smtp-Source: AGHT+IHfDxi6z7VgKIVIjJ/zEidYPkptsjFrjNKRB7F0oAojG8122AqxFTv89wqX+c5HUk+E+blBdA==
X-Received: by 2002:a17:906:c105:b0:ab7:b484:73b1 with SMTP id a640c23a62f3a-ab7f3381278mr335868266b.18.1739388894852;
        Wed, 12 Feb 2025 11:34:54 -0800 (PST)
Received: from debian ([2a00:79c0:659:fd00:45fb:7d1a:5e4d:9727])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b9281eb4sm750261766b.103.2025.02.12.11.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:34:54 -0800 (PST)
Date: Wed, 12 Feb 2025 20:34:52 +0100
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: dimitri.fedrau@liebherr.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <20250212193452.GB4383@debian>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
 <Z6ykRRBXo4tac6XQ@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6ykRRBXo4tac6XQ@shell.armlinux.org.uk>

Am Wed, Feb 12, 2025 at 01:38:13PM +0000 schrieb Russell King (Oracle):
> On Tue, Feb 11, 2025 at 09:33:47AM +0100, Dimitri Fedrau via B4 Relay wrote:
> > @@ -232,6 +232,12 @@ properties:
> >        PHY's that have configurable TX internal delays. If this property is
> >        present then the PHY applies the TX delay.
> >  
> > +  tx-amplitude-100base-tx-percent:
> > +    description:
> > +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
> > +      default will be left as is.
> > +    default: 100
> > +
> 
> This should mention what the reference is - so 100% is 100% of what (it
> would be the 802.3 specified 100BASE-TX level, but it should make that
> clear.)
>
Yes, will add that to the description. 100% should match 2V peak to
peak.

> I'm having a hard time trying to find its specification in 802.3, so
> maybe a reference to where it can be found would be useful, otherwise
> it's unclear what one gets for "100%".
>
Compliance testing was done as described in:
https://download.tek.com/document/61W_17381_3.pdf

Didn't find the specification regarding the amplitude in 802.3, but
according to the document above it should then be part of ANSI X3.263.
Unfortunately I don't have access to ANSI X3.263, so I have to rely on
the information in the document above.

Best regards,
Dimitri Fedrau

