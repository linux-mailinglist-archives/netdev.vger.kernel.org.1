Return-Path: <netdev+bounces-101870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A58C900586
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D860283F17
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAD2194AD6;
	Fri,  7 Jun 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuwDDmZ8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1840C194A66;
	Fri,  7 Jun 2024 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768182; cv=none; b=qPLGXdUz+NuvdqlGKPhzeSUKX8FPSuDa75LIcxj5Mh98bIQXx+ymB8BenjGyLQcL8U9wJtjn2HfXi7QSucnbALtWpmgkkVgj25jU6qDYnDPchDckGHqGQkt7QKMuWfwAlGg0sGPKLTjN5AM10zHqvUfRmSCoTzd/6jcz3egyo+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768182; c=relaxed/simple;
	bh=eRfiCS4lXI/9Sd/hQTfclFr+REQx+PxoR+f/dcqGGoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GR7HT2VicuGEv0xEsgBhc0hRQ+gyiV65+7Vz17dVyjb4cknnMMKO/gnQaJetDS+L5jEB+QRryNZJwi0qrguIy4zMTtP2o3PqhMH+KpkwvxV5GuDQhida7AkuAuMS1MqvOVc0mwkydLqp72bt4NnX7qO9YB0j7dlMN/8XSdYigSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IuwDDmZ8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-572c65cea55so2255649a12.0;
        Fri, 07 Jun 2024 06:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717768179; x=1718372979; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pTnve0OlkP/Svwep8TruSEF3Sh0+kENp9G4xdXwTQa4=;
        b=IuwDDmZ8kSvsCD+avgRTY9Uf9SEbJU41aCufgm9PLe2HhXH/Xz2bKkHuzjjLPOvKEw
         PG9G8gdg2XSB4g1fWHlPLcusGwv9SzYqs/qT4l6dXuIvMbvmgBzzX0d9jbygpfIvKnIe
         Dw+sUvtfVvDzMLE1XXuI5COTXRjPx0nTVbNQBcXfrPTFnNdon2uQo+eFJUV9+209gj2x
         tEeFJgaVr9+sUuWcO7ZtE2WD5GVPG/a35OuggTQq3HmHL1BthUaivDtNB12g15rJvn69
         KufY3w1xBtUjaPGQmY8orsVp+d8FzURGfNwuKSAnlgYKf8PL9wsJHxWfuIUReAGXMZo+
         3Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768179; x=1718372979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTnve0OlkP/Svwep8TruSEF3Sh0+kENp9G4xdXwTQa4=;
        b=CSnWk1iyikWGoXunmd6/MFAlNTBjeUsO70oa8hf++QNCqywWQcUwN79V3ohGtszWMq
         3FaUmDwURf26vYVIyL+D2Jz4sGTZkRf8NCJPaTwGQEwb1va9EvDGAaZ2CnJqjUeK7ZJY
         3pDxAeUQyaF2AhlXjX/ThcT32N2V8TlQfafKIb/3thUGiErhyo+ALZIX4FJ8whYD3Lor
         3tBuiNBm1m5UlPURpEMsk2DbBnT5iMt9IJ68V4/JSTiOeHnKHNnfE95efUwkoRXJg+bK
         iNPchrj/xwnFP+ajfYVI/1YEAH9atTZIQU25ix1Cauity8NjaOkWLzLBZfBVB1Pyei+H
         LF9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXc0RPqmvtnPyuai6PG+vFQ6IV8loY6gbiVKDEM8cFN+kMYmxhRsgXulRJRv5xwbLZRalyDjMJLu4+p8Elyz8kJB/bFpHL5VSlf7sVL6rZg5HWPv/JmYbV2zcOVg9sy6AGRv3hUavyacfjq7bDTFggiLIAqY28m8OuqbAydBr10lA==
X-Gm-Message-State: AOJu0YxH7GQHKHiKkGNLB742dF+Fq16BUIiaNqFoQvNGGXbruqH3g0mg
	zFDPHDfL5erMrGJUBFjMOf4/RmbtDSEIUs0fJXRcpNow0TV5eJSw
X-Google-Smtp-Source: AGHT+IFCyBqh8IuGn1reBr5k76M6n8/rufRVhsjoVDjCtnAMeTIGUiEDpR8iTOf0s0zDWzD3vLoCQw==
X-Received: by 2002:a50:cdc2:0:b0:574:ebf4:f786 with SMTP id 4fb4d7f45d1cf-57c4e3f5be7mr2329947a12.16.1717768179012;
        Fri, 07 Jun 2024 06:49:39 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c67432820sm89269a12.75.2024.06.07.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:49:38 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:49:35 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 09/13] net: dsa: lantiq_gswip: Forbid
 gswip_add_single_port_br on the CPU port
Message-ID: <20240607134935.k4lrierqlfwpic7n@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-10-ms@dev.tdt.de>
 <20240607112628.igcf6ytqe6wbmbq5@skbuf>
 <e2439e7d01c4484c59ce3df2707c2e00@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2439e7d01c4484c59ce3df2707c2e00@dev.tdt.de>

On Fri, Jun 07, 2024 at 03:31:57PM +0200, Martin Schiller wrote:
> On 2024-06-07 13:26, Vladimir Oltean wrote:
> > On Thu, Jun 06, 2024 at 10:52:30AM +0200, Martin Schiller wrote:
> > > From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > 
> > > Calling gswip_add_single_port_br() with the CPU port would be a bug
> > > because then only the CPU port could talk to itself. Add the CPU
> > > port to
> > > the validation at the beginning of gswip_add_single_port_br().
> > > 
> > > Signed-off-by: Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com>
> > > ---
> > >  drivers/net/dsa/lantiq_gswip.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/dsa/lantiq_gswip.c
> > > b/drivers/net/dsa/lantiq_gswip.c
> > > index ee8296d5b901..d2195271ffe9 100644
> > > --- a/drivers/net/dsa/lantiq_gswip.c
> > > +++ b/drivers/net/dsa/lantiq_gswip.c
> > > @@ -657,7 +657,7 @@ static int gswip_add_single_port_br(struct
> > > gswip_priv *priv, int port, bool add)
> > >  	unsigned int max_ports = priv->hw_info->max_ports;
> > >  	int err;
> > > 
> > > -	if (port >= max_ports) {
> > > +	if (port >= max_ports || dsa_is_cpu_port(priv->ds, port)) {
> > >  		dev_err(priv->dev, "single port for %i supported\n", port);
> > >  		return -EIO;
> > >  	}
> > > --
> > > 2.39.2
> > > 
> > 
> > Isn't the new check effectively dead code?
> 
> As long as the dsa_switch_ops .port_bridge_join and .port_bridge_leave are not
> executed for the cpu port, I agree with you.

They aren't. The primary trigger for dsa_port_bridge_join() is dsa_user_changeupper(),
along with other code paths that replay the operation in certain circumstances,
again only for user ports.

