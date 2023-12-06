Return-Path: <netdev+bounces-54425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2108070C0
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5188C1C2099C
	for <lists+netdev@lfdr.de>; Wed,  6 Dec 2023 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93D374F5;
	Wed,  6 Dec 2023 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="jskru8F1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D27D90
	for <netdev@vger.kernel.org>; Wed,  6 Dec 2023 05:18:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso4841840e87.0
        for <netdev@vger.kernel.org>; Wed, 06 Dec 2023 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701868709; x=1702473509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDTwDHCRWuW+8SGUNCtXjlLkMIUYse8e7FHqjq0scEQ=;
        b=jskru8F1mGSj123RMJDby7IswkAp6kBL+9x0Jh3DEtMRRKf4XG5FTq6FU+Xkx77nPt
         3zNEMDkhU471psyI3REtBR6Hkvoa0CFNZ2DXiLiBUXda/O2aHP8KTa6AwFQXDDQzUjIk
         kINs03Ig3oI5+Z/Qdwr56WzdOEjmP/8/eiX07PONmtSgDewDr8KdEh0NkA37k6L4Anch
         piTmX9IUaWqFobHYxovtMymRbKbsfrFFeGvko/Cp6VoEbxz59LetMPraR5fPMJpNeiJ1
         xR7anbbu3ZfQPMMCIC3wVzcN78Alpf5S+K9b3r4ESbDfDZDGlrTDYg1icj5LaP0BZ/OG
         NYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701868709; x=1702473509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDTwDHCRWuW+8SGUNCtXjlLkMIUYse8e7FHqjq0scEQ=;
        b=a/z7iUOx1eg8LUkhTDQZ4cJaSnQGz6DF3Absi+Dzquf8hPB6jVHSWKBZ+WwM5I8/0t
         i8zl6PUDGZGrOAzmoMnKeiCX4jhNoxs4cLm6bpmoweSpwKEGrXs1dy0BrxA4ubdhRV30
         VPcBWP9XJjefdu00bK2MHH9Hmv660ZpcWykwhDV/cO8jXnF1Q2i8yrGrpNzbEurhLG/b
         5Y7OSmD9GJXnbONVVzm6znhVzIYV219myRa0lDwKFN6/wFkQM1Fu6DqStRBA/Q4BvXHY
         x50MPVZlelSCC0KNLYuD+ecRWU6N0Adj1YWkvpNq3W36+tR0Rnk9HmcPhQjV2Hy5GDZL
         WHig==
X-Gm-Message-State: AOJu0YwQFHdUDF0M0nkNt4sTsHCncsPvyjq7G+w1yemi+vEH4IiikyDL
	Sma7T2W08I1SCkpp9oezBQK70A==
X-Google-Smtp-Source: AGHT+IHGPdAmhlvXT+Vge0GRetYiSG4tNh3rzPhqCs5f/AhesQOITByE07cRqXmOYPJ/q2WjehDG6A==
X-Received: by 2002:a05:6512:1254:b0:50b:efbb:c59e with SMTP id fb20-20020a056512125400b0050befbbc59emr793735lfb.29.1701868709129;
        Wed, 06 Dec 2023 05:18:29 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b0054cc903baadsm2423798edr.30.2023.12.06.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:18:28 -0800 (PST)
Date: Wed, 6 Dec 2023 14:18:27 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v5] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXB0oyBiE0C/5laE@nanopsycho>
References: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202123048.1059412-1-swarupkotikalapudi@gmail.com>

Sat, Dec 02, 2023 at 01:30:48PM CET, swarupkotikalapudi@gmail.com wrote:
>Add some missing(not all) attributes in devlink.yaml.
>
>Re-generate the related devlink-user.[ch] code.
>
>Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
>Suggested-by: Jiri Pirko <jiri@resnulli.us>
>Suggested-by: Jakub Kicinski <kuba@kernel.org>
>Fixes: f2f9dd164db0 ("netlink: specs: devlink: add the remaining command to generate complete split_ops")

Remove the fixes tag. This patch is not a fix.

Overall, looks okay. I found couple of issues below, also pointed out
couple of nits to change:


>---
>V5:
>  - Keep stats enum as unnamed in /uapi/linux/devlink.h 
>    to avoid kernel build failure
>V4: https://lore.kernel.org/all/20231126105246.195288-1-swarupkotikalapudi@gmail.com/ 
>  - Change the commit message
>V3: https://lore.kernel.org/all/20231123100119.148324-1-swarupkotikalapudi@gmail.com/
>  - enum name added for stats and trap-metadata enum used by trap command
>    in include/uapi/linux/devlink.h
>  - Fix generated userspace file's compilation issue
>    due to V1 and V2 patchset
>  - Move some attributes e.g. nested-devlink and param again as a TODO,
>    which needs some discussion and will be fixed in a new patchset
>V2: https://lore.kernel.org/all/20231122143033.89856-1-swarupkotikalapudi@gmail.com/
>  - Rebase to net-next tree
>  - param-value-data data type is dynamic, hence to accomndate
>    all data type make it as string type
>  - Change nested attribute to use correct fields
>    based on driver code e.g. region-snapshots,
>    region-snapshot, region-chunks, region-chunk,
>    linecard-supported-types, health-reporter,
>    linecard-supported-types, nested-devlink
>    and param's attributes
>V1: https://lore.kernel.org/all/ZVNPi7pmJIDJ6Ms7@swarup-virtual-machine/
>
> Documentation/netlink/specs/devlink.yaml | 330 ++++++++++++++++++-----
> tools/net/ynl/generated/devlink-user.c   | 223 +++++++++++++++
> tools/net/ynl/generated/devlink-user.h   | 105 +++++++-
> 3 files changed, 595 insertions(+), 63 deletions(-)
>
>diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>index 43067e1f63aa..2fee16509e82 100644
>--- a/Documentation/netlink/specs/devlink.yaml
>+++ b/Documentation/netlink/specs/devlink.yaml
>@@ -75,6 +75,14 @@ definitions:
>         name: ipsec-crypto-bit
>       -
>         name: ipsec-packet-bit
>+  -
>+    type: enum
>+    name: rate-type
>+    entries:
>+      -
>+        name: leaf
>+      -
>+        name: node
>   -
>     type: enum
>     name: sb-threshold-type
>@@ -111,6 +119,16 @@ definitions:
>         name: none
>       -
>         name: basic
>+  -
>+    type: enum
>+    name: dpipe-header-id
>+    entries:
>+      -
>+        name: ethernet
>+      -
>+        name: ipv4
>+      -
>+        name: ipv6
>   -
>     type: enum
>     name: dpipe-match-type
>@@ -174,7 +192,16 @@ definitions:
>         name: trap
>       -
>         name: mirror
>-
>+  -
>+    type: enum
>+    name: trap-type
>+    entries:
>+      -
>+        name: drop
>+      -
>+        name: exception
>+      -
>+        name: control
> attribute-sets:
>   -
>     name: devlink
>@@ -194,23 +221,44 @@ attribute-sets:
>         name: port-type
>         type: u16
>         enum: port-type
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: port-desired-type
>+        type: u16
>+      -
>+        name: port-netdev-ifindex
>+        type: u32
>+      -
>+        name: port-netdev-name
>+        type: string
>+      -
>+        name: port-ibdev-name
>+        type: string
>       -
>         name: port-split-count
>         type: u32
>         value: 9

In general, when you remove fill-up the gaps, please remove the "value"
from the next attr after the gap. It is no longer needed. This applies
to all the gaps you fill in this file.


>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: port-split-group
>+        type: u32
>       -
>         name: sb-index
>         type: u32
>         value: 11
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: sb-size
>+        type: u32
>+      -
>+        name: sb-ingress-pool-count
>+        type: u16
>+      -
>+        name: sb-egress-pool-count
>+        type: u16
>+      -
>+        name: sb-ingress-tc-count
>+        type: u16
>+      -
>+        name: sb-egress-tc-count
>+        type: u16
>       -
>         name: sb-pool-index
>         type: u16
>@@ -233,15 +281,17 @@ attribute-sets:
>         name: sb-tc-index
>         type: u16
>         value: 22
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: sb-occ-cur
>+        type: u32
>+      -
>+        name: sb-occ-max
>+        type: u32
>       -
>         name: eswitch-mode
>         type: u16
>         value: 25
>         enum: eswitch-mode
>-
>       -
>         name: eswitch-inline-mode
>         type: u16
>@@ -347,6 +397,7 @@ attribute-sets:
>       -
>         name: dpipe-header-id
>         type: u32
>+        enum: dpipe-header-id
>       -
>         name: dpipe-header-fields
>         type: nest
>@@ -433,23 +484,27 @@ attribute-sets:
>         name: port-flavour
>         type: u16
>         enum: port-flavour
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: port-number
>+        type: u32
>+      -
>+        name: port-split-subport-number
>+        type: u32
>+      -
>+        name: param
>+        type: nest
>+        nested-attributes: dl-param
>       -
>         name: param-name
>         type: string
>         value: 81
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: param-generic
>+        type: flag
>       -
>         name: param-type
>         type: u8
>         value: 83
>-
>-      # TODO: fill in the attributes in between
>-

Don't remove this TODO comment. You still are missing couple of
attributes here.


>       -
>         name: param-value-cmode
>         type: u8
>@@ -458,16 +513,32 @@ attribute-sets:
>       -
>         name: region-name
>         type: string
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: region-size
>+        type: u64
>+      -
>+        name: region-snapshots
>+        type: nest
>+        nested-attributes: dl-region-snapshots
>+      -
>+        name: region-snapshot
>+        type: nest
>+        nested-attributes: dl-region-snapshot
>       -
>         name: region-snapshot-id
>         type: u32
>         value: 92
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: region-chunks
>+        type: nest
>+        nested-attributes: dl-region-chunks
>+      -
>+        name: region-chunk
>+        type: nest
>+        nested-attributes: dl-region-chunk
>+      -
>+        name: region-chunk-data
>+        type: binary
>       -
>         name: region-chunk-addr
>         type: u64
>@@ -502,9 +573,9 @@ attribute-sets:
>       -
>         name: info-version-value
>         type: string
>-
>-      # TODO: fill in the attributes in between
>-
>+      -
>+        name: sb-pool-cell-size
>+        type: u32
>       -
>         name: fmsg
>         type: nest
>@@ -525,15 +596,31 @@ attribute-sets:
>       -
>         name: fmsg-obj-name
>         type: string
>-
>+      -
>+        name: fmsg-obj-value-type
>+        type: u8

Empty line there please.

>       # TODO: fill in the attributes in between

Empty line there please.


>+      -
>+        name: health-reporter
>+        type: nest
>+        nested-attributes: dl-health-reporter

You need to specify "value: 114" for this attr, there is still a gap
in front of it.

> 
>       -
>         name: health-reporter-name
>         type: string
>         value: 115
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: health-reporter-state
>+        type: u8
>+      -
>+        name: health-reporter-err-count
>+        type: u64
>+      -
>+        name: health-reporter-recover-count
>+        type: u64
>+      -
>+        name: health-reporter-dump-ts
>+        type: u64
> 
>       -
>         name: health-reporter-graceful-period
>@@ -548,15 +635,27 @@ attribute-sets:
>       -
>         name: flash-update-component
>         type: string
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: flash-update-status-msg
>+        type: string
>+      -
>+        name: flash-update-status-done
>+        type: u64
>+      -
>+        name: flash-update-status-total
>+        type: u64
> 

Could you please make sure that the consistency in empty lines between
attributes is maintained after this patch is applied. For example, the
empty line above should be removed. Please check the rest of the file.


>       -
>         name: port-pci-pf-number
>         type: u16
>         value: 127
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: port-pci-vf-number
>+        type: u16
>+      -
>+        name: stats
>+        type: nest
>+        nested-attributes: dl-attr-stats
> 
>       -
>         name: trap-name
>@@ -566,8 +665,17 @@ attribute-sets:
>         name: trap-action
>         type: u8
>         enum: trap-action
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: trap-type
>+        type: u8
>+        enum: trap-type
>+      -
>+        name: trap-generic
>+        type: flag
>+      -
>+        name: trap-metadata
>+        type: nest
>+        nested-attributes: dl-trap-metadata
> 
>       -
>         name: trap-group-name
>@@ -577,8 +685,9 @@ attribute-sets:
>       -
>         name: reload-failed
>         type: u8
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: health-reporter-dump-ts-ns
>+        type: u64
> 
>       -
>         name: netns-fd
>@@ -591,8 +700,6 @@ attribute-sets:
>         name: netns-id
>         type: u32
> 
>-      # TODO: fill in the attributes in between
>-
>       -
>         name: health-reporter-auto-dump
>         type: u8
>@@ -610,15 +717,26 @@ attribute-sets:
>         name: port-function
>         type: nest
>         nested-attributes: dl-port-function
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: info-board-serial-number
>+        type: string
>+      -
>+        name: port-lanes
>+        type: u32
>+      -
>+        name: port-splittable
>+        type: u8
>+      -
>+        name: port-external
>+        type: u8
> 
>       -
>         name: port-controller-number
>         type: u32
>         value: 150
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: flash-update-status-timeout
>+        type: u64
> 
>       -
>         name: flash-update-overwrite-mask
>@@ -674,14 +792,14 @@ attribute-sets:
>         multi-attr: true
>         nested-attributes: dl-reload-act-stats
> 
>-      # TODO: fill in the attributes in between
>-
>       -
>         name: port-pci-sf-number
>         type: u32
>         value: 164
>-
>-      # TODO: fill in the attributes in between
>+      -
>+        name: rate-type
>+        type: u16
>+        enum: rate-type
> 
>       -
>         name: rate-tx-share
>@@ -697,22 +815,28 @@ attribute-sets:
>         name: rate-parent-node-name
>         type: string
> 
>-      # TODO: fill in the attributes in between
>+      -
>+         name: region-max-snapshots
>+         type: u32
> 
>       -
>         name: linecard-index
>         type: u32
>         value: 171
> 
>-      # TODO: fill in the attributes in between
>+      -
>+         name: linecard-state
>+         type: u8
> 
>       -
>         name: linecard-type
>         type: string
>         value: 173
>-
>+      -
>+        name: linecard-supported-types
>+        type: nest
>+        nested-attributes: dl-linecard-supported-types

Empty line here please.

>       # TODO: fill in the attributes in between
>-

Don't remove the empty line.

>       -
>         name: selftests
>         type: nest
>@@ -727,7 +851,6 @@ attribute-sets:
>       -
>         name: region-direct
>         type: flag
>-

Don't remove the empty line.


>   -
>     name: dl-dev-stats
>     subset-of: devlink
>@@ -1004,7 +1127,43 @@ attribute-sets:
>     attributes:
>       -
>         name: resource
>-

Again, could you please maintain consistency with empty lines between
the subsets?


>+  -
>+    name: dl-param
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: param-name
>+      -
>+        name: param-generic
>+      -
>+        name: param-type
>+      # TODO: fill in the attribute param-value-list
>+  -
>+    name: dl-region-snapshots
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: region-snapshot
>+  -
>+    name: dl-region-snapshot
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: region-snapshot-id
>+  -
>+    name: dl-region-chunks
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: region-chunk
>+  -
>+    name: dl-region-chunk
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: region-chunk-data
>+      -
>+        name: region-chunk-addr
>   -
>     name: dl-fmsg
>     subset-of: devlink
>@@ -1019,7 +1178,58 @@ attribute-sets:
>         name: fmsg-nest-end
>       -
>         name: fmsg-obj-name
>-
>+  -
>+    name: dl-health-reporter
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: health-reporter-name
>+      -
>+        name: health-reporter-state
>+      -
>+        name: health-reporter-err-count
>+      -
>+        name: health-reporter-recover-count
>+      -
>+        name: health-reporter-graceful-period
>+      -
>+        name: health-reporter-auto-recover
>+      -
>+        name: health-reporter-dump-ts
>+      -
>+        name: health-reporter-dump-ts-ns
>+      -
>+        name: health-reporter-auto-dump
>+  -
>+    name: dl-attr-stats
>+    name-prefix: devlink-attr-
>+    attributes:
>+      - name: stats-rx-packets
>+        type: u64
>+        value: 0


Why is 0 needed here?


>+      -
>+        name: stats-rx-bytes
>+        type: u64
>+      -
>+        name: stats-rx-dropped
>+        type: u64
>+  -
>+    name: dl-trap-metadata
>+    name-prefix: devlink-attr-
>+    attributes:
>+      -
>+        name: trap-metadata-type-in-port
>+        type: flag
>+        value: 0

Why is 0 needed here?



>+      -
>+        name: trap-metadata-type-fa-cookie
>+        type: flag
>+  -
>+    name: dl-linecard-supported-types
>+    subset-of: devlink
>+    attributes:
>+      -
>+        name: linecard-type
>   -
>     name: dl-selftest-id
>     name-prefix: devlink-attr-selftest-id-

[...]

