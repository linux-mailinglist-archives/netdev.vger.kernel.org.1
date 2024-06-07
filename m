Return-Path: <netdev+bounces-101875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C5A9005AF
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF491F23F1F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BE11953B1;
	Fri,  7 Jun 2024 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UM1Q0bZx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF918732D;
	Fri,  7 Jun 2024 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768494; cv=none; b=UnIG0yQwdWp1zitIMt6gq6KuH1vanM5kWVBQnjo/azxgpr7dWYdQa1YW1CGlU4DFTw7uue6MB3hXWjJ0FMiFJgzZZpwAGfk5JZe9n9tjx6j1itLTUtpocTDvMymL61YFi6rVBhkZzd5gHHb13sLaIS66I0y3maL6GIkdilqMxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768494; c=relaxed/simple;
	bh=ahHtkg+qk05aKYuCR7dfIOgxn3IU1b9SBi4Pr9qJWak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MS5v1QEVMXxvi7TQpahfPSlgYKi7gQO9MrNMae7wGHvbLDEKpMIZ3mel5/jL6QGPHgVyDcGPosXXZztIAe8bUpETe60tER9V6cMOqDd6jPeSFnNfOhKKV0Mo+1iXqxnUSKhkxWRO7DvqHI8wXnw/2Sl8xGm4yD7kTgED+M1fkoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UM1Q0bZx; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a68ca4d6545so389213566b.0;
        Fri, 07 Jun 2024 06:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717768491; x=1718373291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uxmkXdaceaVXHGTvjtukBaV+9c/l2ACxZmA7DgPjK8=;
        b=UM1Q0bZxVJOIxqZjA7PBmhwpQNxNJrgqzXYQvZeWKIduJk7qzPoVSwLicrOg6NyDqa
         /eFq7fJMCTzsX5Si5rwGf5khblpwbrq+e/a6bS4hg/0l56nytHMPU5jMqIIibw3cpynQ
         l+8aeB3KNGEiszu5F5vDpbFUM3YW2SJHbYC64erNxSQjngQSwk5ER4PEOZCMXilcAIjK
         gfCHsuAqavw0ilrGIPA+GFcOs13AdjgCj33wbc3+r4bZhRHBa/6uSevy4l0xvDES4wx/
         dsYLnmylK7Yd1LU9Ee+pEzebBLFrkA7H1FrPOktzjgMgy06UpRv7Q0pqBA5ghmNu8KOi
         +SLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768491; x=1718373291;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uxmkXdaceaVXHGTvjtukBaV+9c/l2ACxZmA7DgPjK8=;
        b=awhC25Svz9uaWcb2eAfBT1oRnmdaTr1yXwrfkXmdhlhOtf4mtNKIIqe5D9qEJFpmBr
         PXIM/nCp8945DkCrUa0LPkHlpiDo3Fq6o8TZtp7MLA5BjwyjAUThLKLGivGXvfG6MnSv
         inQgr76bu7WaFC6bRDH4SBzC39sHOymqFm9ZMnSfsVEYCIY01b4pkX0Pa+qiUTL8SP8j
         V4mmjHMkE5xmcBeJ/Ym5Lx+5p1VdSGMz3riIP6coDBMILBvLjP6Mo2VkryYJkzQmOLDV
         qnXhShsHQFmEBDtC+mm9CQmJ/XWBsFj4HA72RujfFvMUU5SZKaKpkhVTf4sVQ+2rUbzx
         KfBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE040OxwEeZr+SlyX80KPdUQVnQrpznU5G95rvhZyieY9bvmo5F8F/mDyJuOfaSKaLsvWyK89EvQNt48Xn+fLjuviqbe+MQgaQ+/ARxNZ6uurNFhV3dbJKLdpgTEpUI99S1T01xReNZ1226XGepYSjGDKgmj8tA3bLv9wcAMCtKQ==
X-Gm-Message-State: AOJu0YwQv50NKUu3fz1S/kMJ2ICjd8l4QEPfHtba1rORArJvd+fVwyms
	QvILHLx+WWTd8DsWmVALi9qEVOpq+4c2/Fu8EO1ZrYlZNL8wwZfk
X-Google-Smtp-Source: AGHT+IEjA/lSOj6z1LyCBjr+wlap7sF6nGRxnT4WjnsQuszgsdnd/+CEqpG2Filpeqhtv6sv9YA1HQ==
X-Received: by 2002:a17:906:79c8:b0:a62:e450:b147 with SMTP id a640c23a62f3a-a6c7650aa95mr402831966b.29.1717768490526;
        Fri, 07 Jun 2024 06:54:50 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c8070e839sm252011966b.176.2024.06.07.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:53:29 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:53:20 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 13/13] net: dsa: lantiq_gswip: Improve error
 message in gswip_port_fdb()
Message-ID: <20240607135320.rzi7a6kackk66z5q@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-14-ms@dev.tdt.de>
 <20240607114144.knza5aapic2j5txu@skbuf>
 <57e896de3b23929dde870316f999c821@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57e896de3b23929dde870316f999c821@dev.tdt.de>

On Fri, Jun 07, 2024 at 03:51:19PM +0200, Martin Schiller wrote:
> On 2024-06-07 13:41, Vladimir Oltean wrote:
> > On Thu, Jun 06, 2024 at 10:52:34AM +0200, Martin Schiller wrote:
> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > 
> > > Print the port which is not found to be part of a bridge so it's
> > > easier
> > > to investigate the underlying issue.
> > 
> > Was there an actual issue which was investigated here? More details?
> 
> Well, there are probably still several problems with this driver. Martin
> Blumenstingl is probably referring to the problem discussed in [1] and [2].
> 
> [1] https://github.com/openwrt/openwrt/pull/13200
> [2] https://github.com/openwrt/openwrt/pull/13638

Ok, but that doesn't technically exercise this error path.

