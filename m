Return-Path: <netdev+bounces-150635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159B9EB084
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4C4B168F17
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696F41A0BFB;
	Tue, 10 Dec 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWzv0jrW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A541A254E;
	Tue, 10 Dec 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832654; cv=none; b=qFfs5mCXqnYhn4AHJwxhMmPsvU7ArMOU9Thjy5QR6IdFiD8fnqSROyxUc3BKxnX4m4EBGv8hjXycMJNsUQMAIhvkvGKp2LMlfn9dsQfvtSOEbnx/ufyem4tliDgHL0KEudItfplPAc5WyZ6eJJwpwDQySNlhYQD5Bd4MwEkCykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832654; c=relaxed/simple;
	bh=7iaiJHcabJsZWGYUOvU3ry+AH7YdXrI8KxaJ2hWVsz8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A92xaEc7jbFZj5q9FG9bHbOBNUkF7jGebqRZi4oo5z377Vj0pHly9C/C0GmQHEIYDD7foab60SSsvmd2+sQdhdkfNYFgx8CRJ8jVTNgVAI4MzcuewSDKdehXsIHjUmUApk8YY5G+bJi0/ztgKq8ceH28CRid8BOK6UhPf7dgp5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWzv0jrW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so55801215e9.2;
        Tue, 10 Dec 2024 04:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733832651; x=1734437451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f/tm/wcnr6fTaffyLAXSgHwJaQbGmdxPhc9rTLVd32w=;
        b=fWzv0jrWhUzwOrGsPYVZb1znOSti+xkY1cJlU1Ce0WNf30yjl0ttoZ3oCgOTOIyjIO
         1GVxBR1qAIFS2ZUGrQWyXAm0w7WKESOZCtIFF7VPOsmPwDtVZOCz1YZr6cNbMP4tQjZg
         fZ5G/0EXEdHGUkq6IZtPEQ0XrMt46AOQXWrUbEPc58egiHZB6lEUU7bflnNXoNtS2t9U
         Sg3IKfNt+ibSe0ebjjWVCaRGT3/uKLHu7lsQnU6gV+CEngd91WH0vigxWanUFWkbBwDd
         ATFHPYY9OnJ/qX+xXAWEtU22URnGaCcQ778iMmqGMnISF6pwiIv3zB18zhr+z5ICFq/n
         V7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733832651; x=1734437451;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/tm/wcnr6fTaffyLAXSgHwJaQbGmdxPhc9rTLVd32w=;
        b=BqUHOP4Cnguq9INBPbpLf6aHM2Fs3xbzWfcGFZgNw7pQyOW3bj3BvgEqYyQ13zih4u
         nII+FPKPv1xFEZqk4/kN/MDBPIUx0QuIqxXDv94d1sCzMrY0D+LyUVLM4Vv22irFbOkr
         +ubYaGS4LZ8PevcrHY1T4HuRpiHYiqemBZ+hRSLlhm194LlHX7rjyC9oyfMBYyCwpJna
         /dmp76gfl410tDgY7GLBrzt5DV2dAPfAAtgI65qt/Gec7C3a99PF3JIPNYiTCcbnZ2bu
         9BTW4oT2WqXKyzImYII15Ub6RIUzuY3MJIb/w6VXV0iPTHEvJMfBVlKR09XGUGfUt+jK
         6SLg==
X-Forwarded-Encrypted: i=1; AJvYcCVwpS5N7V8GbrdxqFB0angriICaGozTNTfKwGDKYwb/PWEZ4WL6V+JYqaBo0XPecL9WR7klzYO+@vger.kernel.org, AJvYcCXMLkoDWRxDmJRS/kgp15SzKXC3KhmIM6rqDAC+aMh23+iD/A1/cWvXXpese5lhJwDaFeKCe9XUf1H5@vger.kernel.org, AJvYcCXxoIOFPxG0cbrXTBN7RWv9QRpFofjXN0+O6tt0bmHGFWplJvBCv7J2EGb2ROXJvg7J5RwOQpK7yF18UzoD@vger.kernel.org
X-Gm-Message-State: AOJu0YxV0urprrfk0MRU9o7BZfKTV6HH9S2EdpAqYP6OGjE76YUefxik
	Zj0IHXlcVslDGLclyatGR/FcO2MVSGrrG7nY+W4PcmenygG0Tv4f
X-Gm-Gg: ASbGncscRmLWbXLmADntmPQ06z6FGchR6r9S0eKjwHkmCVV19v5nh9got7yWhG4pKLX
	CLEw1hV+u5UNJ0fz5gUKADJJUZ9oeOCSEgXdWmfCl/AyhyyZh6TQwPZ3w0HGI+o9LCRuDtu9au7
	9wm1+RZbB3CtQnpplxDdrwYVrq9ElCSVViN/Fa3b0Ks3Np2MWcWY7WYl6NF8hOx+Vx2V8xbT40b
	Jwxmq5rJvh+AE9QzL4opNQP4BfZgOyOv6+Q1z0kbhABKr7IjVyQWXyqlrL9mbjpq31JB2Cxmu1z
	IrtFvTV+CQ==
X-Google-Smtp-Source: AGHT+IELqnqj7Lv40ZEePpA0AiZtjlj0HSeZm+v8CN5Y+7SYlmGGorQ4+fRTjI1MBtElPDrqJtCp+A==
X-Received: by 2002:a05:600c:3b03:b0:435:14d:f61a with SMTP id 5b1f17b1804b1-435014dfa8emr28638915e9.25.1733832650610;
        Tue, 10 Dec 2024 04:10:50 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f1125e69sm107925285e9.32.2024.12.10.04.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 04:10:50 -0800 (PST)
Message-ID: <67582fca.050a0220.2d187a.9e01@mx.google.com>
X-Google-Original-Message-ID: <Z1gvxWn-xvCByaUb@Ansuel-XPS.>
Date: Tue, 10 Dec 2024 13:10:45 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 9/9] net: phy: Add Airoha AN8855 Internal
 Switch Gigabit PHY
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-10-ansuelsmth@gmail.com>
 <b3b79c80-ac7c-456b-a3b5-eee61f671694@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b79c80-ac7c-456b-a3b5-eee61f671694@lunn.ch>

On Tue, Dec 10, 2024 at 02:36:29AM +0100, Andrew Lunn wrote:
> > +config AIR_AN8855_PHY
> > +	tristate "Airoha AN8855 Internal Gigabit PHY"
> > +	help
> > +	  Currently supports the internal Airoha AN8855 Switch PHY.
> > +
> >  config AIR_EN8811H_PHY
> >  	tristate "Airoha EN8811H 2.5 Gigabit PHY"
> >  	help
> 
> Do you have any idea why the new one is AN, and previous one is EN?  I
> just like consistent naming, or an explanation why it is not
> consistent.
>

EN EcoNet that was then absorbed by Airoha (AN). Hence it's the same
thing. Airoha is suggesting to use AN for new submission. So it's just
about timing.

> > +#define AN8855_PHY_ID				0xc0ff0410
> > +static struct phy_driver an8855_driver[] = {
> > +{
> > +	PHY_ID_MATCH_EXACT(AN8855_PHY_ID),
> 
> Is there any documentation about the ID, and the lower nibble. Given
> it is 0, i'm wondering if PHY_ID_MATCH_EXACT() is correct.
>

I will check this but I doubt there is any explaination. These are internal
to the switch so my theory is that no exact logic was applied.

-- 
	Ansuel

