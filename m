Return-Path: <netdev+bounces-50847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDA47F748D
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 14:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC662812FF
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 13:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C40F168A6;
	Fri, 24 Nov 2023 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="OKLGS4M7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A8CD71
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:07:07 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54a945861c6so2719951a12.3
        for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 05:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700831226; x=1701436026; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ATnXe0tXz0WfDFcnKgGwBJdl/aMP6w8NQWBKxOi2hX0=;
        b=OKLGS4M78thab8ucrNZvWZSWMvIetF1499Bik3RD57TMBATCc2L7KXCw1yIlcTEkfY
         RR1IQytxnYnk8jY4ltdyvgpJEMzp3NX3yhsxnjt6z7ilKHic4rIj2dvVvX8Ud9IVZfDW
         4+bYA80KN+rJIIZOKLrfwZU/eha9WiTphScoBwvYfq4XthXX6UybiBKIj6EFoPWJ/vec
         K1qeIoiNxrGizwesGhSPVmtX9O1yLvG0pnnwH21rMDbrLpG6eiyIY6LvDRC4qV2rQHlF
         GnOD/AQNlKCt7vRbTitpJfvHnkOlVuFvxhcObfOGfKtJm3E591S5n8VX73gxK+xCN3hT
         pzpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700831226; x=1701436026;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ATnXe0tXz0WfDFcnKgGwBJdl/aMP6w8NQWBKxOi2hX0=;
        b=j8xoi8c22vNkJnnfRyvckdWIi6jOL5vkX7to0LH9DCysWSAj3XqV3630KoeovQxxmi
         mmPu5oL7BMjRAfuQ0Bv5TJWNe3Zh5d4DuMn7A180qd18kPlU3OzVEgoEqzG5m3mMHoR9
         qTAz0rIBtT69qWeFX70LwnicS2FbwOdPX910xmD9EuhbR3srS4ftrWHrYKZ7gyXWjR+y
         G3io5ueFjqlcv/XFZY+DqHmkAEde4YwsaWXrbnH+lWcv9yHNoEwxpKG9S+k1RdEz/VT6
         sDOmVBiUcGdMGqKZLD6emENhw9RskkOBPDLTKwaxDuGJUQuQL7AwDbV0ZYZ95S3nDLz8
         fxbg==
X-Gm-Message-State: AOJu0Yz1gABeNMS8pWb+lyRokCV3qzeBPQ8NRiL7gd5cxmrXkBDyunel
	tMkdZuuusmZDdppz31Kez0sZfg==
X-Google-Smtp-Source: AGHT+IF61aUp4+PEg3ARzHAyXmgFJIxdNhKlor+umLyubKz0TqKH78R3OwZ1lCRD+yuDtzE9IIKjYw==
X-Received: by 2002:a50:9b18:0:b0:548:a227:b09c with SMTP id o24-20020a509b18000000b00548a227b09cmr2251507edi.36.1700831225761;
        Fri, 24 Nov 2023 05:07:05 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id j8-20020a50ed08000000b00536031525e5sm1740964eds.91.2023.11.24.05.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 05:07:05 -0800 (PST)
Message-ID: <ec5bf712-62a6-39bb-3b33-d1c214ce33f5@blackwall.org>
Date: Fri, 24 Nov 2023 15:07:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCHv2 net-next 05/10] docs: bridge: add STP doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Marc Muehlfeld <mmuehlfe@redhat.com>
References: <20231123134553.3394290-1-liuhangbin@gmail.com>
 <20231123134553.3394290-6-liuhangbin@gmail.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231123134553.3394290-6-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/23 15:45, Hangbin Liu wrote:
> Add STP part for bridge document.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   Documentation/networking/bridge.rst | 85 +++++++++++++++++++++++++++++
>   1 file changed, 85 insertions(+)
> 
> diff --git a/Documentation/networking/bridge.rst b/Documentation/networking/bridge.rst
> index 84aae94f6598..1fd339e48129 100644
> --- a/Documentation/networking/bridge.rst
> +++ b/Documentation/networking/bridge.rst
> @@ -51,6 +51,91 @@ options are added.
>   .. kernel-doc:: net/bridge/br_sysfs_br.c
>      :doc: Bridge sysfs attributes
>   
> +STP
> +===
> +
> +The STP (Spanning Tree Protocol) implementation in the Linux bridge driver
> +is a critical feature that helps prevent loops and broadcast storms in
> +Ethernet networks by identifying and disabling redundant links. In a Linux
> +bridge context, STP is crucial for network stability and availability.
> +
> +STP is a Layer 2 protocol that operates at the Data Link Layer of the OSI
> +model. It was originally developed as IEEE 802.1D and has since evolved into
> +multiple versions, including Rapid Spanning Tree Protocol (RSTP) and
> +`Multiple Spanning Tree Protocol (MSTP)
> +<https://lore.kernel.org/netdev/20220316150857.2442916-1-tobias@waldekranz.com/>`_.
> +
> +Bridge Ports and STP States
> +---------------------------
> +
> +In the context of STP, bridge ports can be in one of the following states:
> +  * Blocking: The port is disabled for data traffic and only listens for
> +    BPDUs (Bridge Protocol Data Units) from other devices to determine the
> +    network topology.
> +  * Listening: The port begins to participate in the STP process and listens
> +    for BPDUs.
> +  * Learning: The port continues to listen for BPDUs and begins to learn MAC
> +    addresses from incoming frames but does not forward data frames.
> +  * Forwarding: The port is fully operational and forwards both BPDUs and
> +    data frames.
> +  * Disabled: The port is administratively disabled and does not participate
> +    in the STP process. The data frames forwarding are also disabled.
> +
> +Root Bridge and Convergence
> +---------------------------
> +
> +In the context of networking and Ethernet bridging in Linux, the root bridge
> +is a designated switch in a bridged network that serves as a reference point
> +for the spanning tree algorithm to create a loop-free topology.
> +
> +Here's how the STP works and root bridge is chosen:
> +  1. Bridge Priority: Each bridge running a spanning tree protocol, has a
> +     configurable Bridge Priority value. The lower the value, the higher the
> +     priority. By default, the Bridge Priority is set to a standard value
> +     (e.g., 32768).
> +  2. Bridge ID: The Bridge ID is composed of two components: Bridge Priority
> +     and the MAC address of the bridge. It uniquely identifies each bridge
> +     in the network. The Bridge ID is used to compare the priorities of
> +     different bridges.
> +  3. Bridge Election: When the network starts, all bridges initially assume
> +     that they are the root bridge. They start advertising Bridge Protocol
> +     Data Units (BPDU) to their neighbors, containing their Bridge ID and
> +     other information.
> +  4. BPDU Comparison: Bridges exchange BPDUs to determine the root bridge.
> +     Each bridge examines the received BPDUs, including the Bridge Priority
> +     and Bridge ID, to determine if it should adjust its own priorities.
> +     The bridge with the lowest Bridge ID will become the root bridge.
> +  5. Root Bridge Announcement: Once the root bridge is determined, it sends
> +     BPDUs with information about the root bridge to all other bridges in the
> +     network. This information is used by other bridges to calculate the
> +     shortest path to the root bridge and, in doing so, create a loop-free
> +     topology.
> +  6. Forwarding Ports: After the root bridge is selected and the spanning tree
> +     topology is established, each bridge determines which of its ports should
> +     be in the forwarding state (used for data traffic) and which should be in
> +     the blocking state (used to prevent loops). The root bridge's ports are
> +     all in the forwarding state. while other bridges have some ports in the
> +     blocking state to avoid loops.
> +  7. Root Ports: After the root bridge is selected and the spanning tree
> +     topology is established, each non-root bridge processes incoming
> +     BPDUs and determines which of its ports provides the shortest path to the
> +     root bridge based on the information in the received BPDUs. This port is
> +     designated as the root port. And it is in the Forwarding state, allowing
> +     it to actively forward network traffic.
> +  8. Designated ports: A designated port is the port through which the non-root
> +     bridge will forward traffic towards the designated segment. Designated ports
> +     are placed in the Forwarding state. All other ports on the non-root
> +     bridge that are not designated for specific segments are placed in the
> +     Blocking state to prevent network loops.
> +
> +STP ensures network convergence by calculating the shortest path and disabling
> +redundant links. When network topology changes occur (e.g., a link failure),
> +STP recalculates the network topology to restore connectivity while avoiding loops.
> +
> +Proper configuration of STP parameters, such as the bridge priority, can
> +influence which bridge becomes the Root Bridge. Careful configuration can
> +optimize network performance and path selection.

"Proper configuration..." and then "Careful configuration..."

I'd say just continue the first sentence as "can influence network 
performance, path selection and which bridge becomes the Root Bridge."

> +
>   FAQ
>   ===
>   


