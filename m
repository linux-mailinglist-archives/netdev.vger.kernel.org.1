Return-Path: <netdev+bounces-101817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B98369002F5
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 14:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63011C20CE7
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 12:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A626618735F;
	Fri,  7 Jun 2024 12:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WH37pSnV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD461847;
	Fri,  7 Jun 2024 12:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717761853; cv=none; b=uakrVCxC/GZv9LzvQxKLpzn9Sf0t/Php3DTkXq8APqdNrsvDq/KS3xAwNEp4+w59FDQV+FEQ8KDsRRyNA6ryO/Rif3/dOtbMrXN41hZzyKerBJjw3vwU9WeV3NcDeG3zJReJDCe+eSvueHPQHjz180xjksxHdUBymdxr4Orrus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717761853; c=relaxed/simple;
	bh=uzqPo3uX/uPKB0puXr+jSuRD830u4tgbdtzpw6nxbHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAniawdie1eP38iDVLxvRezjAt3UqhEb4LvRsghFYm94cygbPWv/LER7jve7p1Vmwz4WWn6F7nwKGCJSfLAHvJlvjvA4uKC4MVYnXssWfzTVLkbg6n8rtvUejaljlkhQkWqDLxTp2RwlrGPofao0ljpu95MY7yCG+kO3xvuHL1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WH37pSnV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a68c5524086so234363266b.3;
        Fri, 07 Jun 2024 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717761850; x=1718366650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7yDPdh1hB7ZRbMcjAAQr7F6VbwKd5JcFkqyU5OREcZk=;
        b=WH37pSnV9WeXmUNpXgnJUmJUyJ+PCSYsbc6DzTzIq/hpivj7LvqGWzGJA+s5HhA7W4
         s5Gm/3UzLnI+mhjNWw65Xo0QBU7mhOIl5KcXoXo+PusS4YQiOR/Cv5YXpgNqygMpn55S
         6i8Sk033u/1E/ZmMCChDUUlqG0dQjqwtaiHy8n6Ivubggay50QFe1L8BqYrSapDIDwT3
         RUyfbbajEcLt07CobDPRX97v3zZaXBmSqgNM6z3jbtlKbdHhMfTaXEkORCnCuGN2U+ir
         lZ//QmSFoM8Jkfucop6/hl7TANED3dmmxQYloNEGv/jADbQfy139J9ydZdCb17sXx38u
         AiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717761850; x=1718366650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yDPdh1hB7ZRbMcjAAQr7F6VbwKd5JcFkqyU5OREcZk=;
        b=kfY0g266BkxnZzij/VUTWX0lLapOQsKJ1gCUn1Kqu/NsNT/yDf2Arw9qzX9/YRGh2e
         wIZnceOLUjCuCsdeytX4Z+zpZDMOOGgdhESGvoH+NswWja1DB+H9v+pgHVX2kFOaS7Of
         5rRLeBNzRL0TPL/cKHx03G14BJhpClqoPd43gxBVFyqy9gtTfvtvUdmbfOIPjdN6mI6C
         Z14U4cTK21nek0cgLNezku3F+WdNu3LtV6iRxPK1K6DfNvD0cP89N3Lr7w4u5phm34KZ
         +cuXBPgJkUEyzYnh2aN2x32XRJh2a7u1hWjUGq2WEjhfcRJUW8PUfyz/s7fvwqZs1pSr
         aKUw==
X-Forwarded-Encrypted: i=1; AJvYcCVrM0GUp0kZtXiIHdxuzwHQkTqnLNnZ9PcT6r/78QlW9IFFhlIQqI7CbVXVPe3cBJllvs2kac0QkJrWbRYIuZAO13Ed63PI6KDLnY69AKab/KxwF6TqcYIU2ZZN1pdjlli71NCAqaJenrjuSj5gbsvSroe2o4K9QU4TNojSwbL1Rw==
X-Gm-Message-State: AOJu0YyVTqhUgzvHzZ3Qdr5LIQ9cJfIadrc3e6zLVZf/J8MI2hzDMRE5
	3qEEvURJXMkJUVuIEjB9bJ+V8j8y7mIERwD1aM96DU1sU1wXCJlW
X-Google-Smtp-Source: AGHT+IFDvLmbmEo8twcHfW7gQQaHvdhzEY0fA1Pqz3fcVUYOHyVjktM+pdWmeQe7BL7diQ3dkZ0VgA==
X-Received: by 2002:a17:906:3289:b0:a69:1a11:d396 with SMTP id a640c23a62f3a-a6cdc0e252amr154780866b.71.1717761850068;
        Fri, 07 Jun 2024 05:04:10 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805ccf21sm234748766b.70.2024.06.07.05.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 05:04:09 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:04:06 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/13] net: dsa: lantiq_gswip: Only allow
 phy-mode = "internal" on the CPU port
Message-ID: <20240607120406.dksbevig2k6vj6uu@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-3-ms@dev.tdt.de>
 <20240607110318.jujco3liryl7om3v@skbuf>
 <bc660eb043143926ef267d1b96dee939@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc660eb043143926ef267d1b96dee939@dev.tdt.de>

On Fri, Jun 07, 2024 at 02:01:57PM +0200, Martin Schiller wrote:
> On 2024-06-07 13:03, Vladimir Oltean wrote:
> > On Thu, Jun 06, 2024 at 10:52:23AM +0200, Martin Schiller wrote:
> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > 
> > > Add the CPU port to gswip_xrx200_phylink_get_caps() and
> > > gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal
> > > bus,
> > > so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.
> > > 
> > > Signed-off-by: Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com>
> > > ---
> > 
> > This is for the case where those CPU port device tree properties are
> > present, right? In the device trees in current circulation they are not,
> > and DSA skips phylink registration.
> 
> Yes, as far as I know, this driver is mainly, if not exclusively, used in
> the
> openWrt environment. These functions were already added here in Oct. 2022
> [1].
> 
> [1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=commitdiff;h=2683cca5927844594f7835aa983e2690d1e343c6

Ok. You can add my

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

