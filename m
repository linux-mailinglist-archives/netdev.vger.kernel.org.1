Return-Path: <netdev+bounces-152572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B559F4A55
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C447188F833
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309EC1EF088;
	Tue, 17 Dec 2024 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8zjB58V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BDA1EE002
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 11:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734436496; cv=none; b=ptITXHP7eVAn4zM6KiY26k/C2sC8u+1OycBXwtpPD+lzZJnO/6FAgRN/7Ja/GBHdCEgItt/+s/+gzClAKA5cCjneB4fDDymb15yB/6Bleu7FARv1BeQq8EBHNaeLbB9wyCgp6gl6l7ZqfExqoZjfiZpFy8FVXe7r09eqOsHqm9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734436496; c=relaxed/simple;
	bh=E2+x91swcD7kP0KanP0uvqZuz7Svi5/spt0/nkuj7yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S7lhjeWMd9IRxvoVPwk3MKzJCNMtIAHUnclFRU6uCEKejfsKgRK62rm04Vz9OIgF3YGuEdn83yP4iLTGVZr5+UqXjML65jRtpiNBqnPqoCVuc2HRDonr9GChl1z/FOvklnyWBK9MyjdyKjMfQXL4Dy+WQfbrbK2u4ln0xQYIxCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8zjB58V; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa551d5dd72so93047266b.3
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734436492; x=1735041292; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q3nVE5hfc48K26j9DHTNBzXyzDOp1j/KJVGS8G9Hr+k=;
        b=L8zjB58VEnhnfI7twUIbt1eLc9bGyUdpQk8twhNpFE7ic7bX/Aet/u3qP0NWJjPiDi
         MtmS3qqCRF7etoT/ii9ZrNBvKp8i9VLMrcdqS+ropPka+e7Cb7thNDRWqA1osWYfKPuY
         CjbW2EV/Nki08LfP9j/f9m2q2u3BKZkV/yHmCcG6eysNNCOCfOlxvr+bxUhvRgGbYS9c
         4jJoRbyIKkrw4iG5DICt4JBoUf71KTwdfIF1E5METrQuIMKz9Qkd6u9KFMnhkIpn80ZT
         vZg2EsAEE2xGw9K8Rwx4VRl8WHSCFgZaUgHKI5U9cIlAXln1dZJQz1AlgXwfFViLPW5k
         C2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734436492; x=1735041292;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3nVE5hfc48K26j9DHTNBzXyzDOp1j/KJVGS8G9Hr+k=;
        b=CkG2J+wTNYMJVrw0Y8lZ2Jxxqvqo6jYmzDEOPddSUcJ9rjpOwmF9dhSg9vecLw+Nqw
         /KPp1tHW8eyMZoTHZLvDnp/zCI0Ol++ikvJWny6lTGtruuneKx7SjDYU8cMuDcZrhyxi
         /OngplJIMOLfQCPeHI39Jc+lYZxq/gLrkBrQsRT/5N3KR2Kr1Wt2hcj5kKM/vuwDSeMv
         pzkDQlZbNsRYEAOU1Wy6P9QQ3gvg6XQq2ZeVACQ0/wrk7f75MBzOwNb2oK0YLweWrUW7
         1kGoTf3TWJ4vImrbmHjPt4kfkj5Bw/8K34MayV3ZveUyRMb5VuxcUie1QFhsNJJ0sxqF
         9qEw==
X-Forwarded-Encrypted: i=1; AJvYcCUS27RGaP/21e/6b0Pm5NpI9Ge8wTN92D79SBiRErZK+6cMECd7OfrQl94+g+4Rx2ucykjpbCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMs9RB9TURV8yUAanz/uz/VPXs8K8LdGPKhY+7LZtNQJAiLbcd
	FW2C/e216MMal+GQ8G77sNx57sasrL263Y7KInrDJJpD6KELTxnW
X-Gm-Gg: ASbGncsINI3kHza34nULZsywoU2vK60HQ+3lbQbP5W1wThpURkLlA9Ix/g2Nanr13+g
	I6+xvmLnCzNFz67bj823erdcCjn5fXszD4ooxtCyaypbaypAcpWFHtajyOJcSKyX6iOONYExtjO
	VPmtP+LA8uqxnJtfC+580oHYaJfhGiJFtro0E584wk31GfYmbTOXuxxdRqmW0pJKBv7nQ6OhkBp
	DgXm+EloXVeBedhVosrGBVF5X2Mpj+/ZdW8Yn/xpz1z
X-Google-Smtp-Source: AGHT+IEFAQ7A4pxeycvbNbfQGUDsM2HPu5UChwTWsxddExiaSSUHMB27F+f93jMlC47SiisbE0RShQ==
X-Received: by 2002:a17:907:9410:b0:aa6:74ed:4f31 with SMTP id a640c23a62f3a-aab77e90452mr661758366b.10.1734436492209;
        Tue, 17 Dec 2024 03:54:52 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aabcab0431dsm180029566b.196.2024.12.17.03.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 03:54:51 -0800 (PST)
Date: Tue, 17 Dec 2024 13:54:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Lorenzo Bianconi <lorenzo@kernel.org>,
	Oleksij Rempel <linux@rempel-privat.de>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, nbd@nbd.name,
	sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	lorenzo.bianconi83@gmail.com
Subject: Re: [RFC net-next 0/5] Add ETS and TBF Qdisc offload for Airoha
 EN7581 SoC
Message-ID: <20241217115448.tyophzmiudpxuxbz@skbuf>
References: <Z1qqrVWV84DBZuCn@lore-desk>
 <20241212150613.zhi3vbxuwsc3blui@skbuf>
 <Z1sXTPeekJ5See_u@lore-desk>
 <20241212184647.t5n7t2yynh6ro2mz@skbuf>
 <Z2AYXRy-LjohbxfL@lore-desk>
 <20241216154947.fms254oqcjj72jmx@skbuf>
 <Z2B5DW70Wq1tOIhM@lore-desk>
 <f8e74e29-f4b0-4e38-8701-a4364d68230f@lunn.ch>
 <Z2FGjeyawnhABnRb@pengutronix.de>
 <Z2FGjeyawnhABnRb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z2FGjeyawnhABnRb@pengutronix.de>
 <Z2FGjeyawnhABnRb@pengutronix.de>

On Tue, Dec 17, 2024 at 10:38:21AM +0100, Oleksij Rempel wrote:
> Hi,
> 
> You are absolutely correct that offloading should accelerate what Linux already
> supports in software, and we need to respect this model. However, I’d like to
> step back for a moment to clarify the underlying problem before focusing too
> much on solutions.
> 
> ### The Core Problem: Flow Control Limitations
> 
> 1. **QoS and Flow Control:** 
> 
>    At the heart of proper QoS implementation lies flow control. Flow control
>    mechanisms exist at various levels:
> 
>    - MAC-level signaling (e.g., pause frames)
> 
>    - Queue management (e.g., stopping queues when the hardware is congested)
> 
>    The typical Linux driver uses flow control signaling from the MAC (e.g.,
>    stopping queues) to coordinate traffic, and depending on the Qdisc, this
>    flow control can propagate up to user space applications.

I read this section as "The Core Problem: Ethernet".

> 2. **Challenges with DSA:**
>    In DSA, we lose direct **flow control communication** between:
> 
>    - The host MAC
> 
>    - The MAC of a DSA user port.
> 
>    While internal flow control within the switch may still work, it does not
>    extend to the host. Specifically:
> 
>    - Pause frames often affect **all priorities** and are not granular enough
>      for low-latency applications.
> 
>    - The signaling from the MAC of the DSA user port to the host is either
>      **not supported** or is **disabled** (often through device tree
>      configuration).

And this as: "Challenges with DSA: uses Ethernet". I think we can all
agree that standard Ethernet, with all the flexibility it gives to pair
any discrete DSA switch to any host NIC, does not give us sufficient
instruments for independent flow control of each user port.

Food for thought: strongly coupled MAC + integrated DSA switch systems,
like for example Broadcom, have custom methods of pacing transmission to
user ports by selectively stopping conduit TX queues associated with
those user ports on congestion:
https://lore.kernel.org/netdev/7510c29a-b60f-e0d7-4129-cb90fe376c74@gmail.com/

> ### Why This Matters for QoS
> 
> For traffic flowing **from the host** to DSA user ports:
> 
> - Without proper flow control, congestion cannot be communicated back to the
>   host, leading to buffer overruns and degraded QoS.  

There are multiple, and sometimes conflicting, goals to QoS and strategies on
congestion. Generally speaking, it is good to clarify that deterministic latency,
high throughput and zero loss cannot be all achieved at the same time. It is
also good to highlight the fact that you are focusing on zero loss and that
this is not necessarily the full picture. Some AVB/TSN switches, like SJA1105,
do not support pause frames at all, not even on user ports, because as you say,
it's like the nuclear solution which stops the entire port regardless of
packet priorities. And even if they did support it, for deterministic latency
applications it is best to turn it off. If you make a port enter congestion by
bombarding it with TC0 traffic, you'll incur latency to TC7 traffic until you
exit the congestion condition. These switches just expect to have reservations
very carefully configured by the system administrator. What exceeds reservations
and cannot consume shared resources (because they are temporarily depleted) is dropped.

> - To address this, we need to compensate for the lack of flow control signaling
>   by applying traffic limits (or shaping).

A splendid idea in theory. In practice, the traffic rate at the egress
of a user port is the sum of locally injected traffic plus autonomously
forwarded traffic. The port can enter congestion even with shaping of
CPU-injected traffic at a certain rate.

            Conduit
               |
               v
  +-------------------------+
  |         CPU port        |
  |            |            |
  |   +--------+            |
  |   |                     |
  |   +<---+                |
  |   |    |                |
  |   v    |                |
  | lan0  lan1  lan2  lan3  |
  +-------------------------+
      |
      v Just 1Gbps.

You _could_ apply this technique to achieve a different purpose than
net zero packet loss: selective transmission guarantees for CPU-injected
traffic. But you also need to ensure that injected packets have a higher
strict priority than the rest, and that the switch resources are
configured through devlink-sb to have enough reserved space to keep
these high priority packets on congestion and drop something else instead.

It's a tool to have for sure, but you need to be extremely specific and
realistic about your goals.

> ### Approach: Applying Limits on the Conduit Interface
> 
> One way to solve this is by applying traffic shaping or limits directly on the
> **conduit MAC**. However, this approach has significant complexity:
> 
> 1. **Hardware-Specific Details:**
> 
>    We would need deep hardware knowledge to set up traffic filters or disectors
>    at the conduit level. This includes:
> 
>    - Parsing **CPU tags** specific to the switch in use.  
> 
>    - Applying port-specific rules, some of which depend on **user port link
>      speed**.
> 
> 2. **Admin Burden:**
> 
>    Forcing network administrators to configure conduit-specific filters
>    manually increases complexity and goes against the existing DSA abstractions,
>    which are already well-integrated into the kernel.

Agree that there is high complexity. Just need to see a proposal which
acknowledges that it's not for nothing.

> ### How Things Can Be Implemented
> 
> To address QoS for host-to-user port traffic in DSA, I see two possible
> approaches:
> 
> #### 1. Apply Rules on the Conduit Port (Using `dst_port`)
> 
> In this approach, rules are applied to the **conduit interface**, and specific
> user ports are matched using **port indices**.
> 
> # Conduit interface  
> tc qdisc add dev conduit0 clsact  
> 
> # Match traffic for user port 1 (e.g., lan0)  
> tc filter add dev conduit0 egress flower dst_port 1 \  
>     action police rate 50mbit burst 5k drop  
> 
> # Match traffic for user port 2 (e.g., lan1)  
> tc filter add dev conduit0 egress flower dst_port 2 \  
>     action police rate 30mbit burst 3k drop  

Ok, so you propose an abstract key set for DSA in the flower classifier
with mappings to concrete packet fields happening in the backend,
probably done by the tagging protocol in use. The abstract key set
represents the superset of all known DSA fields, united by a common
interpretation, and each tagger rejects keys it cannot map to the
physical DSA tag.

I can immediately think of a challenge here, that we can dynamically
change the tagging protocol while tc rules are present, and this can
affect which flower keys can be mapped and which cannot. For example,
the ocelot tagging protocol could map a virtual DSA key "TX timestamp
type" to the REW_OP field, but the ocelot-8021q tagger cannot. Plus, you
could add tc filters to a block shared by multiple devices. You can't
always infer the physical tagging protocol from the device that the
filters are attached to.

> #### 2. Apply Rules Directly on the User Ports (With Conduit Marker)
> 
> In this approach, rules are applied **directly to the user-facing DSA ports**
> (e.g., `lan0`, `lan1`) with a **conduit-specific marker**. The kernel resolves
> the mapping internally.
> 
> # Apply rules with conduit marker for user ports  
> tc qdisc add dev lan0 root tbf rate 50mbit burst 5k conduit-only  
> tc qdisc add dev lan1 root tbf rate 30mbit burst 3k conduit-only  
> 
> Here:  
> - **`conduit-only`**: A marker (flag) indicating that the rule applies
> specifically to **host-to-port traffic** and not to L2-forwarded traffic within
> the switch.  
> 
> ### Recommendation
> 
> The second approach (**user port-based with `conduit-only` marker**) is cleaner
> and more intuitive. It avoids exposing hardware details like port indices while
> letting the kernel handle conduit-specific behavior transparently.
> 
> Best regards,  
> Oleksij

The second approach that you recommend suffers from the same problem as Lorenzo's
revised proposal, which is that it treats the conduit interface as a collection of
independent pipes of infinite capacity to each user port, with no arbitration concerns
of its own. The model is again great in theory, but maps really poorly on real life.
Your proposal actively encourages users to look away from the scheduling algorithm
of the conduit, and just look at user ports in isolation of each other. I strongly
disagree with it.

