Return-Path: <netdev+bounces-101872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6040900598
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56421C20ABE
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFDC194C8B;
	Fri,  7 Jun 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="km+n87ht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D58018732D;
	Fri,  7 Jun 2024 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768256; cv=none; b=gJhHajpGZqz5REBK6qn9gU5I/zwmjKxVTS8NWWryHkiO/1FAb9zoTnXdHm3DONniSN/7pJlJTNjTFCCeRfiBqd7vX0z8Cej5thHHIKFWRVltdD0zrIxygGZ7TWRU/VRMRS0B1CP5nhekhvufPgPB9SFPGitYlObzixF8C+lJ/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768256; c=relaxed/simple;
	bh=K2yEhBrrJmzEMEJkO7h2wh02vSlcZThLBDjMqLRfL8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lhR2bCtQHs8OORWHep7DqMapfH0du6Cbtrcv6JxQbMS8rblUjV5MTHgS36PYKWZK077Ef1p8nTSTOtUoPjomFN0SjLoWcDoZtwHwIvsjMyPnwRFx02GTNUpEAUp/D6OeSjPBTFuu4uEG6Z5JxzWzpYfXEgAV2h/1/34Q04dhoyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=km+n87ht; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a63359aaaa6so320636766b.2;
        Fri, 07 Jun 2024 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717768253; x=1718373053; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k9ILw3DW/LbfDC7ruUvOLnjFz5aQo28QFVXghAmH3qQ=;
        b=km+n87htbd/s1nmzeYmEW0qXNCnE1dTmVueqlXUQ/aC5NaOEZLH09TGUN8jqB3NZcX
         Ho1NSGcBweFo5fN3jfZqVwzi+GJJI1WksRgQ+DJoPTqD8gnm/b29RAJBuXnaE+RmgY/m
         yg49w3aesFzcEAJFQh/ABvFca+pym1y2KejSC6WsStA3XcQfyDvkc1b23WePTKsYJp1r
         13biQHCUW73UWfQzsSTKE4FpKCazHFRRCsPpRfckwGlc9r9abKDubvArUIu/G1b0c5zR
         buL9ENTjl4VYPH9V6/rlnuTHrkktQqKxbsXG//NEBs2/oL+gk4FmXYB++7XxZ8zgLQpO
         XeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768253; x=1718373053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k9ILw3DW/LbfDC7ruUvOLnjFz5aQo28QFVXghAmH3qQ=;
        b=BxUqun7GkmJ/6eH4/nuRgNn3GcZjVDjp4A7GgM0e1fw/ULBByvHTJqF0Sgu/O1IEVe
         ugIYdRPactjrzfEXhlvpvbQNtoRamq7RbC1m6KSB98WFRzKlp8cCaMWxcjqh0OhMCL8w
         Sug0khn4OduP1K0vazB2Kn/KMDORFLQ/XIy9Hma4gkj7n3ifAaYl3Ksbc9iFe4P+Vbxh
         k6/cNJ+q3btmOfAP5/2IqJv/F0csLOvi1Mh2/x+wtlPeNdzc3IHFa50HcYV5abXHUEff
         hoJ3ftEYR/K6DJ2xI0yEYYoAzOKsmKMmR+u1uagRPU/gFlc6YEt0Em1Aq3RK6nyaUAv9
         UCvw==
X-Forwarded-Encrypted: i=1; AJvYcCXyEVqmx+sH43LSPPnnbKqIzI8kkSs5w/z5PwBiJDjfkWo6B7NnHv3HciVTMSywLdle0ZRIKF8dYiwcEakFXLeql69sxcvrJypQn9PAuwOLlAx3J1yFQBXTAQ9KRF4RcoAY6Ur3e/DKqOBlEwbkkaqzIjFF12RFMgAFyCwP06mGog==
X-Gm-Message-State: AOJu0YyVeguhwicGMvkPRarRCZ0rtXUYLkkVZ5LE5vX7wMC4czfuZN/V
	LihT5NE1Pt9zxOWb3urhayrZvc66W1gPoOniNg+4FJzUYBneaQhB
X-Google-Smtp-Source: AGHT+IEG9tz51KJ7lXuMH87GIjZV+3iZBM/59OX0wzwUwItIiWggvj9gB0DHXynCeWVgfPoALaTsPg==
X-Received: by 2002:a17:906:12c1:b0:a67:b440:e50f with SMTP id a640c23a62f3a-a6cdbcfa817mr178244666b.63.1717768253256;
        Fri, 07 Jun 2024 06:50:53 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c805c59a2sm248166166b.50.2024.06.07.06.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:50:46 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:50:41 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 10/13] net: dsa: lantiq_gswip: Fix error message
 in gswip_add_single_port_br()
Message-ID: <20240607135041.4lo36yeybwa2tkue@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-11-ms@dev.tdt.de>
 <20240607112710.gbqyhnwisnjfnxrl@skbuf>
 <07b91d4a519c698bb80c0f50a0d00067@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07b91d4a519c698bb80c0f50a0d00067@dev.tdt.de>

On Fri, Jun 07, 2024 at 03:34:13PM +0200, Martin Schiller wrote:
> On 2024-06-07 13:27, Vladimir Oltean wrote:
> > Isn't even the original condition (port >= max_ports) dead code? Why not
> > remove the condition altogether?
> 
> I also agree here if we can be sure, that .port_enable, .port_bridge_join and
> .port_bridge_leave are only called for "valid" (<= max_ports) ports.

dsa_switch_parse_ports_of() has:

		if (reg >= ds->num_ports) {
			dev_err(ds->dev, "port %pOF index %u exceeds num_ports (%u)\n",
				port, reg, ds->num_ports);
			of_node_put(port);
			err = -EINVAL;
			goto out_put_node;
		}

