Return-Path: <netdev+bounces-49205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE857F1205
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF3E1B21578
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F00414AAF;
	Mon, 20 Nov 2023 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/Tl0Duw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476E0E5
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:31:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54366784377so5826293a12.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 03:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700479891; x=1701084691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPzhvKUTnfl/wpB/1h9fKZLNVvkyoi0lbPnrcqBIRR0=;
        b=D/Tl0DuwEEsubFzlshumuSXiNZTi6ZKYo5zKT8TmFb3ikGli6FtWQfcTiooPjRaFoz
         3nXBB5wtg7tzV4mtSUzv06OL5/WcwS0fHv0pKz3salYzkrQp26zJBnnJatEvlBWf1qTE
         A/4g8d87QOlkO7GIOeqeNTRIgxns5x4GvK40LL/h1JxZf1FBCjJbvFlnVUJ98rHBACQ9
         fwQ+9wqz5OWup9e66/W9LMzO1SFTlF7KEta/wm2ZD8MHbXCTHU9GZuLZwPfj+UmcqEHZ
         bNHipKfsWqxY7k0qNYa5HZDRRNp0Rk7zj7BNh98PPHEy6u25sOnOEYHYo5rSZ6JTyeUa
         RtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700479891; x=1701084691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TPzhvKUTnfl/wpB/1h9fKZLNVvkyoi0lbPnrcqBIRR0=;
        b=uCSJzXmaUQ4zm9aYYhHngluf6US2MdIRDsQlf35pFftmL5FGuA4Eml233WD5InKLFk
         H1q0I3F6pEtYqTJfchhfsz0bx3jo+VrJ7JOt29Vs8oUn5Z4+JaZnocg/qbf5z/T/QgK+
         jSIgGL/cAPWL8XsY+bb8cNDyZU2qi7ar7qliSW2U7zPJlvg4N0pPDaZ5U4GewvIN4qxr
         sPsZjFWl2n3/XGYOgIFLzLfad/gElHOzZf7oEgl7F69sa576LnD9nqzslEYByXjP22+z
         cheLAUxdd1gKm5sqhLkkIEHv3e5vOpZCV9JSQBvjLi5V8fz+S+mVI9rTZiFFdWFFwMwb
         go0Q==
X-Gm-Message-State: AOJu0Yyh5HpIKMULN2cDdDqwf3S13ORoFMsDZCLLlhDXIo4vMqN8eiQz
	axZh8Ih6gL7xpNtZufx34Lk=
X-Google-Smtp-Source: AGHT+IGciVUAryBVRF8tPVSbNPqdj8C9NDjMWV2nsUGaYUO9eYLLnaPLmYM7oalRMe8Ulo59OpL+qA==
X-Received: by 2002:a17:906:d7:b0:9fb:c70f:9917 with SMTP id 23-20020a17090600d700b009fbc70f9917mr3943150eji.56.1700479890361;
        Mon, 20 Nov 2023 03:31:30 -0800 (PST)
Received: from skbuf ([188.26.184.68])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170906c80a00b009fdcc65d720sm1250756ejb.72.2023.11.20.03.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 03:31:30 -0800 (PST)
Date: Mon, 20 Nov 2023 13:31:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
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
Message-ID: <20231120113127.mih5yjsm2246jvrl@skbuf>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-3-liuhangbin@gmail.com>
 <20231117093145.1563511-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093145.1563511-3-liuhangbin@gmail.com>
 <20231117093145.1563511-3-liuhangbin@gmail.com>

On Fri, Nov 17, 2023 at 05:31:37PM +0800, Hangbin Liu wrote:
> + * @IFLA_BRPORT_LEARNING
> + *   Controls whether a given port will learn *source* MAC addresses from
> + *   received traffic or not. By default this flag is on.

Also controls whether dynamic FDB entries (which can also be added by
software) will be refreshed by incoming traffic.

This is subtle but important in certain use cases (below).

> + * @IFLA_BRPORT_LOCKED
> + *   Controls whether a port will be locked, meaning that hosts behind the
> + *   port will not be able to communicate through the port unless an FDB
> + *   entry with the unit's MAC address is in the FDB. The common use case is
> + *   that hosts are allowed access through authentication with the IEEE 802.1X
> + *   protocol or based on whitelists. By default this flag is off.

Here seems like a good place to add this warning:

Secure 802.1X deployments should always use the BR_BOOLOPT_NO_LL_LEARN
flag, to not permit the bridge to populate its FDB based on link-local
(EAPOL) traffic received on the port.

> + *
> + * @IFLA_BRPORT_MAB

Controls whether a port will use MAC Authentication Bypass (MAB), a
technique through which select MAC addresses may be allowed on a locked
port, without using 802.1X authentication. Packets with an unknown source
MAC address generate a "locked" FDB entry on the incoming bridge port.
The common use case is for user space to react to these bridge FDB
notifications and optionally replace the locked FDB entry with a normal
one, allowing traffic to pass for whitelisted MAC addresses.

Setting this flag also requires IFLA_BRPORT_LOCKED and IFLA_BRPORT_LEARNING.
IFLA_BRPORT_LOCKED ensures that unauthorized data packets are dropped,
and IFLA_BRPORT_LEARNING allows the dynamic FDB entries installed by
user space (as replacements for the locked FDB entries) to be refreshed
and/or aged out.

(source: https://lore.kernel.org/netdev/20221018165619.134535-11-netdev@kapio-technology.com/)

