Return-Path: <netdev+bounces-53351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21CA802735
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 21:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB0EF1C20843
	for <lists+netdev@lfdr.de>; Sun,  3 Dec 2023 20:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F1818B15;
	Sun,  3 Dec 2023 20:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="ZanCAnPZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF47CC8
	for <netdev@vger.kernel.org>; Sun,  3 Dec 2023 12:12:53 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d098b87eeeso3341645ad.0
        for <netdev@vger.kernel.org>; Sun, 03 Dec 2023 12:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1701634373; x=1702239173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xO24qM7L3FZejklSl13rahZfpSL5EcfZ0L0IpjvAw9U=;
        b=ZanCAnPZTcj6PPlhfcjDgtVJQT8S54GD/6WnuArbbQDGZKn+ua3jlw/cwMoZ8k3Rwd
         FfS1PY9o4+qFiqdsmC1EHke9beKEet3TqqFbGSh87R77ziFwVefyaW6DSGj4PD28Vd+G
         6hjwxP7AlFcBFUctQjlB0CzMrFTJH/VHVZWwz+WbV8RGlNZ9ONSVXsnZVw9bk/pEXYOd
         wtVuBCMfIlT9v0GnUS4nxkkK+MH3n+zYcJH6XfiP3ZEEbBJbZIqovRYSwmYkVh7A17ru
         WQmEPv7+t0gFtOPd+jMXP6AOvStBs+OWyv+08G6IZOHpg4K4Fy8k2zKlLlttYqXiF0hB
         BV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701634373; x=1702239173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO24qM7L3FZejklSl13rahZfpSL5EcfZ0L0IpjvAw9U=;
        b=IgaJ3uH8oy2GilRYcM+oAW9Km0BGzfEi0GCcgPxWzAIMbIp22tvK+8EphzepWso8uQ
         cQF8hs4IubK7X9jGMQPy1dGMS6yvVof2H1lgulifglX4KmOoO1rHWBUQzju/beA7Zyd2
         Q7xos9MxHiVSzAnDGvWTHKh2+s5XnKPfS48W7Mn+sTWvqZxxUH15lDylTwG6Ogl3rCcO
         HNSycQW9luEwIpDEqe3j4XGs6hGPnhIP4r4CAswrqfLNVwuYULDpAZkiiE2VKRQI6B0s
         MCdBNEx/HhHANfLaMo4UZXBWnM9Egw5QR9uT5kHp7oZ8v40nBE72xDpmUWMOi6xpMp/l
         TYfA==
X-Gm-Message-State: AOJu0YzhclpzK+P/9BRW99Ty4zRXHAmPuaJbJymZKYIV0MpkW1eCj9Gd
	SIlQcls24OYu/ylogQsu2wPQ7A==
X-Google-Smtp-Source: AGHT+IGh/FAI2fFdl6MYPlAGAZ9FtArqBwRE1Q77Q+97ClLSZriCaOW/xw/yAzC14dXwefDRx3AX4g==
X-Received: by 2002:a17:903:11cc:b0:1d0:6ffd:9e1c with SMTP id q12-20020a17090311cc00b001d06ffd9e1cmr3869207plh.110.1701634373407;
        Sun, 03 Dec 2023 12:12:53 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ab8d00b001cc20dd8825sm3453399plr.213.2023.12.03.12.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 12:12:53 -0800 (PST)
Date: Sun, 3 Dec 2023 12:12:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>, netdev@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Ido Schimmel <idosch@idosch.org>, Vladimir
 Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, Florian
 Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld
 <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 05/10] docs: bridge: add STP doc
Message-ID: <20231203121250.35110a99@hermes.local>
In-Reply-To: <ZVwd31WaAsy6Cmwy@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
	<20231117093145.1563511-6-liuhangbin@gmail.com>
	<20231120113947.ljveakvl6fgrshly@skbuf>
	<ZVwd31WaAsy6Cmwy@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 11:02:55 +0800
Hangbin Liu <liuhangbin@gmail.com> wrote:

> On Mon, Nov 20, 2023 at 01:39:47PM +0200, Vladimir Oltean wrote:
> > On Fri, Nov 17, 2023 at 05:31:40PM +0800, Hangbin Liu wrote:  
> > > +STP
> > > +===  
> > 
> > I think it would be very good to say a few words about the user space
> > STP helper at /sbin/bridge-stp, and that the kernel only has full support
> > for the legacy STP, whereas newer protocols are all handled in user
> > space. But I don't know a lot of technical details about it, so I would
> > hope somebody else chimes in with a paragraph inserted here somewhere :)  
> 
> Hmm, I google searched but can't find this tool. Nikolay, is this tool still
> widely used? Do you know where I can find the source code/doc of it?
> 
> Thanks
> Hangbin

Older one is here (no longer maintained):
  https://github.com/shemminger/RSTP
Other version is here:
  https://github.com/mstpd/mstpd

