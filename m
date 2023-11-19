Return-Path: <netdev+bounces-49044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDB97F0794
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E1F61C20442
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1231F13FEE;
	Sun, 19 Nov 2023 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVf/Trvc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14824C2
	for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 08:46:30 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso2261226f8f.1
        for <netdev@vger.kernel.org>; Sun, 19 Nov 2023 08:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700412388; x=1701017188; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yew85HukruHEIfiVkzSCVXbKQFzW/CoGnMWrA/YD6Qc=;
        b=GVf/TrvcxibNo67XNpomKq4njqDxwnfQLM3EuVWVkI0w542aX+evi4CjVpOk9m58Yd
         lPpWzfACIfms70nArTRGrcfGA0Nb3lqPHZ1mpvBzBmCTkHV9ORMbfgfLJChgbnoCMif8
         qZlqRzMdFoUFTB85+n9aYyD2MAby0R5VPo1gSzkPsk/HsuFauSiSzvHZjLOX0/nXbOFS
         rVcr7lpxW5PWVfFL9W/hIRoTFk4kEpLBWjRJWtDqejaRCnZzrfQ9Bp0xOnqAgwc2TArW
         8qnRZp3nbbwULjnxS2VpWGEa66HLrTsHboUduYpJnTEPo9FUeXTS0tOTbkCKcig/+Va8
         PX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700412388; x=1701017188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yew85HukruHEIfiVkzSCVXbKQFzW/CoGnMWrA/YD6Qc=;
        b=WrtqSTmNpP1dfXt+mLKFtvZ1RGN/whE7ohKWzvjhUEcSnO2N3ZQLcrWzTJX5vdHzVk
         XKE8H+wC6/s9NoiWjGFH/rRqD7VirwC3Mkfkmy++lToniXy6/2Mtyc7QVqW+FUkcsGI8
         7YBPZ/G50zwV0boi5ZoQ0XEjgP7hlsKD7OFAALwj1gpyuBFB2LrK8yUMgltB9v5EDfvB
         gK/Q6mtpzo6B0SWe6ILsEclW4Dvpn+Jy78pqgVn6Z+6ry3c8iT4LjsoaWdXQg/gawGUE
         fWUj6Px7Ay2HXq9rYx1qmeTOH1VpVAj7/XBLqZntdfWN5cZoxl1GSpfH6UkZE212TRaC
         oi5A==
X-Gm-Message-State: AOJu0YxqHlDu4OJhyh8AQJ1MXYIlwf07AHZVTxMb9G0EUB2kJC+zSbcc
	MJjtyQKVgZ6+s8ptUjDO5ze4jD7Tyfw=
X-Google-Smtp-Source: AGHT+IGHjTXsj482taPiGXBKG+xjnMcjGCp7Hci8dpHC7e8jbCHXTEq4DmRZKsyGcaSTBP9eXwU6CQ==
X-Received: by 2002:a5d:5f42:0:b0:331:3cec:215a with SMTP id cm2-20020a5d5f42000000b003313cec215amr5265779wrb.8.1700412388257;
        Sun, 19 Nov 2023 08:46:28 -0800 (PST)
Received: from skbuf ([188.26.185.114])
        by smtp.gmail.com with ESMTPSA id r12-20020adfda4c000000b003232380ffd7sm8446846wrl.102.2023.11.19.08.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 08:46:28 -0800 (PST)
Date: Sun, 19 Nov 2023 18:46:25 +0200
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
Subject: Re: [PATCH net-next 01/10] net: bridge: add document for IFLA_BR enum
Message-ID: <20231119164625.d2yzi3mpxv72t6pp@skbuf>
References: <20231117093145.1563511-1-liuhangbin@gmail.com>
 <20231117093145.1563511-2-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117093145.1563511-2-liuhangbin@gmail.com>

On Fri, Nov 17, 2023 at 05:31:36PM +0800, Hangbin Liu wrote:
> + * @IFLA_BR_MAX_AGE
> + *   The hello packet timeout, is the time until another bridge in the

No comma between subject and predicate.

> + *   spanning tree is assumed to be dead, after reception of its last hello
> + *   message. Only relevant if STP is enabled.
> + *
> + *   The valid values are between (6 * USER_HZ) and (40 * USER_HZ).
> + *   The default value is (20 * USER_HZ).
> + *
> + * @IFLA_BR_GROUP_FWD_MASK
> + *   The group forward mask. This is the bitmask that is applied to
> + *   decide whether to forward incoming frames destined to link-local
> + *   addresses. The addresses of the form is 01:80:C2:00:00:0X, which
> + *   means the bridge does not forward any link-local frames coming on
> + *   this port).
> + *
> + *   The default value is 0.

I'm confused by this description, I believe some of the wording is
misplaced. Maybe:

   The group forwarding mask. This is the bitmask that is applied to
   decide whether to forward incoming frames destined to link-local
   addresses (of the form 01:80:C2:00:00:0X).

   The default value is 0, which means the bridge does not forward any
   link-local frames coming on this port.

> + * @IFLA_BR_VLAN_DEFAULT_PVID
> + *   The default PVID (native/untagged VLAN ID) for this bridge.

I don't think that "native VLAN" is a good description of this.
The native VLAN should be the only egress-untagged VLAN of a port.

I would say "VLAN ID applied to untagged and priority-tagged incoming
packets".

> + *
> + *   The default value is 1.

I would also mention that the special value of 0 makes all ports of
this bridge not have a PVID by default, which means that they will
not accept VLAN-untagged traffic.

