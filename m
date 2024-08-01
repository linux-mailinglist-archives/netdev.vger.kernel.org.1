Return-Path: <netdev+bounces-114956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0396F944CE0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26DEC1C26AA6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 13:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540151A57F4;
	Thu,  1 Aug 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="c0WJZLmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4121A57F6
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722517856; cv=none; b=tP7soyjTyxUexc0LuaHBj1x3xJdVLSZTk20CPnCV/Hk7iYQYfqtQYj/zmBgUPCgaa4ftVPEfoheni+hXkpw/57VxYWrXurfcIyFbSw7O/soWDyqgNJQk/U63KncUpQIAG6BXVbaLNF+kVlQ8qWXZujxTanqu/6gpJwvEcXarqVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722517856; c=relaxed/simple;
	bh=rk8WdsxPZEwIT4MOnwW6atcBldPNyq6uFmLawlBvZMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXfB0Vtpii/Q4V/UY6RVhblw2gyK2wiseXMyxkRB3rbxM9wCqrtlRm5745LJWheuROTIoTM0dZ3ISlKNDgQiBndCr+5SMsnCgIWy/dKHWuMzDGE7PusVycN9rAqHAdz3MnFXlh5L0tdUK+VEVR4Dj8I5UiAwCb0oxDzIS9lov0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=c0WJZLmn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efaae7edfso7235012e87.2
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 06:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722517852; x=1723122652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PdUjrVyDnQZZtC1vy1hw9QKrbJZQT/h5jWjI6oR0gEI=;
        b=c0WJZLmn2tcVqXcPFzV8go88KUbBAlVbdl2QAGFpUfmiob70FDST+W9JM+aPowRr8o
         meY5/bwoDBP/ZXqsAhm2wYNBpK+xSsOAGTT2rhBgKYaYEVkrdrJYCFZywlRcoXzsi6Y0
         EpP4RYbpFTxoAsTdD34l8um+4DeFaPVOkpx+Vpjp6CFfQyMzaV95AnYHncZAgG5xtZlU
         DCkwyJNrrBt7/Cc/rwWV/LZuXa3/kWpJ443MmxW9/wnOeUn+/UARHQJ8bwnB4kkQKgtb
         ycsOt7Sx1VjycvJ8SJ+sTdvyYhBfri01CqA3qeiipktEuE8SUi3okqb1by0qNg5bRXjK
         3hMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722517852; x=1723122652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdUjrVyDnQZZtC1vy1hw9QKrbJZQT/h5jWjI6oR0gEI=;
        b=msomFnLFBCaYXgxM+jtmB+ayHpZ0F1SrXq/8PgjMu9gYg/QIl0n+uypU7QSsxeju1x
         R+2UkFXh0Tp8K1V7Z4WbX7CfV9VpYWBliAHjhU2s8//u4Nfnvu2qwcmyHEAtQUgdvzXE
         41ipGcK+QLLrQwl3WuWDLJvOTVM0lNM0glu8n7e7zrXirMN7/8llgXxfZCW4Bi3laFY9
         7vN1UQ56WVz6X8dAie6KcMS5c/CULS6XTgpSi7SDxCx2j/2xgDIRygayoOSjflb5Jlwc
         ywKC/miBwQL4Jk9GBP04MZ7jXz++zzzlWkxFqk+7vTa4RSYl3V1iVP7oKAgPphDDlqe4
         PM7g==
X-Gm-Message-State: AOJu0Ywiz5W5LdK6a5u2f27zIqx8/xZNG131VoFsOkErpQiEA8Z5y+f7
	TPIRs293Yz/SAlfFZJwdZ5hgvW5cpDCCXFPk7rAPK1b1vr4bMFAu5oXq83ChnxQ=
X-Google-Smtp-Source: AGHT+IE05g5aRKhZUsmavUmyZKElNzyOnveAue7m6mOQiCwWa446HgLph2bfUMmvHMXhD0KbNcF9mw==
X-Received: by 2002:a05:6512:4db:b0:52f:cdb0:11c0 with SMTP id 2adb3069b0e04-530b61af876mr1243048e87.21.1722517851705;
        Thu, 01 Aug 2024 06:10:51 -0700 (PDT)
Received: from localhost (78-80-9-176.customers.tmcz.cz. [78.80.9.176])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90264sm908698166b.148.2024.08.01.06.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:10:51 -0700 (PDT)
Date: Thu, 1 Aug 2024 15:10:50 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 02/12] netlink: spec: add shaper YAML spec
Message-ID: <ZquJWp8GxSCmuipW@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
 <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13747e9505c47d88c22a12a372ea94755c6ba3b2.1722357745.git.pabeni@redhat.com>

Tue, Jul 30, 2024 at 10:39:45PM CEST, pabeni@redhat.com wrote:
>Define the user-space visible interface to query, configure and delete
>network shapers via yaml definition.
>
>Add dummy implementations for the relevant NL callbacks.
>
>set() and delete() operations touch a single shaper creating/updating or
>deleting it.
>The group() operation creates a shaper's group, nesting multiple input
>shapers under the specified output shaper.
>
>Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>---
>RFC v1 -> RFC v2:
> - u64 -> uint
> - net_shapers -> net-shapers
> - documented all the attributes
> - dropped [ admin-perm ] for get() op
> - group op
> - set/delete touch a single shaper
>---
> Documentation/netlink/specs/shaper.yaml | 262 ++++++++++++++++++++++++
> MAINTAINERS                             |   1 +
> include/uapi/linux/net_shaper.h         |  74 +++++++
> net/Kconfig                             |   3 +
> net/Makefile                            |   1 +
> net/shaper/Makefile                     |   9 +
> net/shaper/shaper.c                     |  34 +++
> net/shaper/shaper_nl_gen.c              | 117 +++++++++++
> net/shaper/shaper_nl_gen.h              |  27 +++
> 9 files changed, 528 insertions(+)
> create mode 100644 Documentation/netlink/specs/shaper.yaml
> create mode 100644 include/uapi/linux/net_shaper.h
> create mode 100644 net/shaper/Makefile
> create mode 100644 net/shaper/shaper.c
> create mode 100644 net/shaper/shaper_nl_gen.c
> create mode 100644 net/shaper/shaper_nl_gen.h
>
>diff --git a/Documentation/netlink/specs/shaper.yaml b/Documentation/netlink/specs/shaper.yaml
>new file mode 100644
>index 000000000000..7327f5596fdb
>--- /dev/null
>+++ b/Documentation/netlink/specs/shaper.yaml
>@@ -0,0 +1,262 @@
>+# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>+
>+name: net-shaper
>+
>+doc: Network device HW Rate Limiting offload
>+
>+definitions:
>+  -
>+    type: enum
>+    name: scope
>+    doc: the different scopes where a shaper can be attached
>+    render-max: true
>+    entries:
>+      - name: unspec
>+        doc: The scope is not specified
>+      -
>+        name: port
>+        doc: The root for the whole H/W

What is this "port"?


>+      -
>+        name: netdev
>+        doc: The main shaper for the given network device.
>+      -
>+        name: queue
>+        doc: The shaper is attached to the given device queue.
>+      -
>+        name: detached
>+        doc: |
>+             The shaper is not attached to any user-visible network
>+             device component and allows nesting and grouping of
>+             queues or others detached shapers.

What is the purpose of the "detached" thing?



>+  -
>+    type: enum
>+    name: metric
>+    doc: different metric each shaper can support
>+    entries:
>+      -
>+        name: bps
>+        doc: Shaper operates on a bits per second basis
>+      -
>+        name: pps
>+        doc: Shaper operates on a packets per second basis
>+

[..]


>+
>+operations:
>+  list:
>+    -
>+      name: get
>+      doc: |
>+        Get / Dump information about a/all the shaper for a given device
>+      attribute-set: net-shaper
>+
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+            - handle
>+        reply:
>+          attributes: &ns-attrs
>+            - parent
>+            - handle
>+            - metric
>+            - bw-min
>+            - bw-max
>+            - burst
>+            - priority
>+            - weight
>+
>+      dump:
>+        request:
>+          attributes:
>+            - ifindex
>+        reply:
>+          attributes: *ns-attrs
>+    -
>+      name: set
>+      doc: |
>+        Create or configures the specified shaper.
>+        On failures the extack is set accordingly.
>+        Can't create @detached scope shaper, use
>+        the @group operation instead.
>+      attribute-set: net-shaper
>+      flags: [ admin-perm ]
>+
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+            - shaper
>+
>+    -
>+      name: delete
>+      doc: |
>+        Clear (remove) the specified shaper. If after the removal
>+        the parent shaper has no more children and the parent
>+        shaper scope is @detached, even the parent is deleted,
>+        recursively.
>+        On failures the extack is set accordingly.
>+      attribute-set: net-shaper
>+      flags: [ admin-perm ]
>+
>+      do:
>+        request:
>+          attributes:
>+            - ifindex
>+            - handle
>+
>+    -
>+      name: group
>+      doc: |
>+        Group the specified input shapers under the specified
>+        output shaper, eventually creating the latter, if needed.
>+        Input shapers scope must be either @queue or @detached.
>+        Output shaper scope must be either @detached or @netdev.
>+        When using an output @detached scope shaper, if the
>+        @handle @id is not specified, a new shaper of such scope
>+        is created and, otherwise the specified output shaper
>+        must be already existing.

I'm lost. Could this designt be described in details in the doc I asked
in the cover letter? :/ Please.


>+        The operation is atomic, on failures the extack is set
>+        accordingly and no change is applied to the device
>+        shaping configuration, otherwise the output shaper
>+        handle is provided as reply.
>+      attribute-set: net-shaper

[..]

