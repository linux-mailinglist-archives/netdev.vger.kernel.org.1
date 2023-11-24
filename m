Return-Path: <netdev+bounces-50864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3FB7F75DF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00204B20F4C
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3182C1BE;
	Fri, 24 Nov 2023 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROL0TwwM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8F11987
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 06:01:33 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc2575dfc7so14730275ad.1
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700834493; x=1701439293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OvrPiuXW0c3purOlilcPM8LbEgqsxs2HGYxRPko2vaY=;
        b=ROL0TwwMAlQE97sLlFmX+UvYyJi8dLsMDYalS0trT4sh/KUTRtnYmzv24mBc3/I5wO
         jULcm+9SQfOvz+bwmnKKyHfanWlHbyWIpEDobvwso3zNxYkEJvezNdGbzAXCnyzfRYNO
         lHw7f6/dHs7LZGQge8lhU7hL4Xv8nr16Rkygo2nGtCK8ytBY6oLgo0vY1NXtnbTNKjRo
         32Eenu+NMlOJiBBiUUNqZSdqBVQe64IG0eegyTl11s6Nqc5H7T2C6ysVHekF/FaJBGTh
         sXOOK7LwtWuXH2e60xbHLR2xV6zynbcrKMKjG4POCI9uIZ0oVJuZ6hVJrsjN7uJGlm9W
         Bh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700834493; x=1701439293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvrPiuXW0c3purOlilcPM8LbEgqsxs2HGYxRPko2vaY=;
        b=sIPrs7g9Gy4dkTGB4idzI6LxeJ3ZhsZjAeu+Q1qCO7GO6EsSTwiePrZwJdUgKM3zAS
         7EuJcmm3fgLoWBAxnrXvEa2vUPt4AnphoDQm1cdl2h5tsMOJpavOI6bgp1TrWoa1k5hC
         /tarHuC1NOIhHBeY26GeVJfOQAl8HPPssdu7IiEA+UatqLkIbbD/c+vxRwqa4JaUmoFX
         bfhNIz81tF7BeGJivtOmLy2S5u59hE8itZQTGjnkg7PQeACALqg4amrG0zJ7VX+mWgiZ
         Ur4xaxBF1yBxqTYMWnH0RMSt1s1sjRmnP0Rooy4USE8ALq51DAmultSKwMX1syZIE+r5
         mjjQ==
X-Gm-Message-State: AOJu0YzArYCVfUYDbJljokauC+ChpJanmvK8LrVr/M+/jPW7312v2mp0
	wZ9GjB82lNlezUebmwUYiQ8=
X-Google-Smtp-Source: AGHT+IEAQmoKjfETu5ftgKcS3ok7nNrTSYvMmD2Au9TmeLqOT16vZCaU50oc84hriDl7t5beG3dnow==
X-Received: by 2002:a17:903:32cf:b0:1ce:95a:9210 with SMTP id i15-20020a17090332cf00b001ce095a9210mr3248047plr.63.1700834493120;
        Fri, 24 Nov 2023 06:01:33 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jj14-20020a170903048e00b001c73f3a9b7fsm3222461plb.185.2023.11.24.06.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 06:01:31 -0800 (PST)
Date: Fri, 24 Nov 2023 22:01:24 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 05/10] docs: bridge: add STP doc
Message-ID: <ZWCstM3IQwTA7zKK@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-6-liuhangbin@gmail.com>
 <20231120113947.ljveakvl6fgrshly@skbuf>
 <ZVwd31WaAsy6Cmwy@Laptop-X1>
 <07156f26-6360-e3ca-1dd0-475fce2a235e@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07156f26-6360-e3ca-1dd0-475fce2a235e@blackwall.org>

Hi Nikolay,

On Fri, Nov 24, 2023 at 03:18:19PM +0200, Nikolay Aleksandrov wrote:
> On 11/21/23 05:02, Hangbin Liu wrote:
> > On Mon, Nov 20, 2023 at 01:39:47PM +0200, Vladimir Oltean wrote:
> > > On Fri, Nov 17, 2023 at 05:31:40PM +0800, Hangbin Liu wrote:
> > > > +STP
> > > > +===
> > > 
> > > I think it would be very good to say a few words about the user space
> > > STP helper at /sbin/bridge-stp, and that the kernel only has full support
> > > for the legacy STP, whereas newer protocols are all handled in user
> > > space. But I don't know a lot of technical details about it, so I would
> > > hope somebody else chimes in with a paragraph inserted here somewhere :)
> > 
> > Hmm, I google searched but can't find this tool. Nikolay, is this tool still
> > widely used? Do you know where I can find the source code/doc of it?
> > 
> > Thanks
> > Hangbin
> 
> Man.. you're documenting the bridge, please check its source code and
> you'll have your answer. "bridge-stp" is not a single tool, rather than

Thanks for your reply. I'm not very familiar with the bridge STP part. The
#define BR_STP_PROG     "/sbin/bridge-stp"
mislead me to think that the bridge-stp is a userspace tool..

> a device for the bridge to start/stop user-space stp when requested.
> As an example here's the first google result:
> https://github.com/mstpd/mstpd/blob/master/bridge-stp.in

Last time I just searched bridge-stp and didn't find any useful result.
This time with "sbin/bridge-stp" I saw the doc you pointed. Thanks for your
reference.

So for the STP part, How about add a paragraph like:

The user space STP helper *bridge-stp* is a program to control whether to use
user mode spanning tree. The `/sbin/bridge-stp <bridge> <start|stop>` is
called by the kernel when STP is enabled/disabled on a bridge
(via `brctl stp <bridge> <on|off>` or `ip link set <bridge> type bridge
stp_state <0|1>`).  The kernel enables user_stp mode if that command returns
0, or enables kernel_stp mode if that command returns any other value.


Thanks
Hangbin

