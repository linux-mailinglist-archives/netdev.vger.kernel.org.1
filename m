Return-Path: <netdev+bounces-49532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8362B7F2483
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 04:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E431EB21637
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EB514ABA;
	Tue, 21 Nov 2023 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOH6Hwql"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8A3BA
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:11:04 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bddf66ed63so3514004a12.1
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 19:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700536264; x=1701141064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TwGtNbQW78uLNE+wqhpEVkCH8ZUA5hCaesTv9H4uKQ=;
        b=VOH6Hwqlk1kN6uO3MX/85YOvEd2LWh5h6Qx4OeV2FTjW4WBnojr12oswe+zG+JDTQv
         U51Rgr1UX/yL1nT6s+t5ruapfDgr/LQ+rafMExGZZcJZy69vH13kvDUzGIqX5hOyd9Ew
         R3X+elCsJBZ8oqanKkjC0/r9JKeg0zo2YkYn/97zTZl2A3WrcuCuTuMzcJywPxEQfL78
         oGZgINhpPaxDLpCN4sLU72VHR6ZrzF7+82qRS9B1BYDoS5C8zZqaSGulm1CtaWb00H2w
         hHtc+k/r+rfOV9fQHRpMIzks2yeR+rViV7oXu6OMdamULZixvbmSH4LL10FBW+HjD2KK
         UgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700536264; x=1701141064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TwGtNbQW78uLNE+wqhpEVkCH8ZUA5hCaesTv9H4uKQ=;
        b=MQ2x2ezKj9jBBA45t01iMi0/RI6xk/vUZOiyywCW8R1m7QGLHdslJBjrF/JGMKxi1S
         +9gS5i9hZJucGRS3A7xUbFqlA+4gF/vKkH5X9jtyfNY9oKsZGE3iUSdc0tT+wB6fQQ+d
         VLsXcHIHvUzaixKxDFrr1abgNuq6Vlz4kAqHI2JiVDu3a1YPLFcsZ/zkfDGghtO8ejgR
         NiuiA71hLvAQlIMtdZXDjY0cDxTLItVSORqIeCDNWEka4lOUysyiRyODQLPoszLcpJ22
         P+EqTmfsZqBru9wOyBhcsU2vb2QsAYeJuUryM2POiqodazquPxkpJaAMwa/h2P8AEJbd
         QDVA==
X-Gm-Message-State: AOJu0YxcNMa5HUT+reorhsaFwGJPZPVWt4bho13cUWTr6w+2pSootC3V
	FpSCf7Wd45Bsvr/nbN4r2Zs=
X-Google-Smtp-Source: AGHT+IFa0gesUKxinUR0P7azYEIl2tkBD4Q15zlaiVjLMG7XXmnJ9UCyq3dM6TI/Fy08CGxb6nWcCw==
X-Received: by 2002:a17:90b:2347:b0:285:117a:deb2 with SMTP id ms7-20020a17090b234700b00285117adeb2mr1973504pjb.23.1700536264342;
        Mon, 20 Nov 2023 19:11:04 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kk8-20020a17090b4a0800b00282ec3582f1sm6124569pjb.34.2023.11.20.19.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 19:11:03 -0800 (PST)
Date: Tue, 21 Nov 2023 11:10:58 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@idosch.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, Marc Muehlfeld <mmuehlfe@redhat.com>
Subject: Re: [PATCH net-next 02/10] net: bridge: add document for IFLA_BRPORT
 enum
Message-ID: <ZVwfwjanYLhH63Mn@Laptop-X1>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-3-liuhangbin@gmail.com>
 <20231117093145.1563511-3-liuhangbin@gmail.com>
 <20231120113127.mih5yjsm2246jvrl@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120113127.mih5yjsm2246jvrl@skbuf>

On Mon, Nov 20, 2023 at 01:31:27PM +0200, Vladimir Oltean wrote:
> On Fri, Nov 17, 2023 at 05:31:37PM +0800, Hangbin Liu wrote:
> > + * @IFLA_BRPORT_LEARNING
> > + *   Controls whether a given port will learn *source* MAC addresses from
> > + *   received traffic or not. By default this flag is on.
> 
> Also controls whether dynamic FDB entries (which can also be added by
> software) will be refreshed by incoming traffic.
> 
> This is subtle but important in certain use cases (below).
> 
> > + * @IFLA_BRPORT_LOCKED
> > + *   Controls whether a port will be locked, meaning that hosts behind the
> > + *   port will not be able to communicate through the port unless an FDB
> > + *   entry with the unit's MAC address is in the FDB. The common use case is
> > + *   that hosts are allowed access through authentication with the IEEE 802.1X
> > + *   protocol or based on whitelists. By default this flag is off.
> 
> Here seems like a good place to add this warning:
> 
> Secure 802.1X deployments should always use the BR_BOOLOPT_NO_LL_LEARN
> flag, to not permit the bridge to populate its FDB based on link-local
> (EAPOL) traffic received on the port.
> 
> > + *
> > + * @IFLA_BRPORT_MAB
> 
> Controls whether a port will use MAC Authentication Bypass (MAB), a
> technique through which select MAC addresses may be allowed on a locked
> port, without using 802.1X authentication. Packets with an unknown source
> MAC address generate a "locked" FDB entry on the incoming bridge port.
> The common use case is for user space to react to these bridge FDB
> notifications and optionally replace the locked FDB entry with a normal
> one, allowing traffic to pass for whitelisted MAC addresses.
> 
> Setting this flag also requires IFLA_BRPORT_LOCKED and IFLA_BRPORT_LEARNING.
> IFLA_BRPORT_LOCKED ensures that unauthorized data packets are dropped,
> and IFLA_BRPORT_LEARNING allows the dynamic FDB entries installed by
> user space (as replacements for the locked FDB entries) to be refreshed
> and/or aged out.
> 
> (source: https://lore.kernel.org/netdev/20221018165619.134535-11-netdev@kapio-technology.com/)

Tanks for the doc, I will update the patch.

Hangbin

