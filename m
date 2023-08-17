Return-Path: <netdev+bounces-28652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763747801B5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 01:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18EA282252
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 23:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AE11BB43;
	Thu, 17 Aug 2023 23:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B45E100CA
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 23:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27221C433C9;
	Thu, 17 Aug 2023 23:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692315402;
	bh=RhegQx5uRaKcu1E0Rcckw5IZtC6q56UwuK3vF+HLjhU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oFbxa95Hfo/FdXazIXS1L4w163X1hkyZix7WC7BswVsZltRRJV70Ia5RhDke9RQmW
	 v5hMxYFTDPzxcMcC/GvJ3Y6U135ShOZAwlJqQ/LudBbm5whE1X7PpULwONQt8x2GYD
	 Az+eOYwcn5MjbP3m/psJ++7Fvg/c/ryL/n91X1rY5W4YzM4jMBtKNSJRV0qKYPc7Wy
	 ujm/9LHTqEDTlOq6wzgAehvprfFveA++VHaLyRvgActcHbER5qLtY2rU+RAJeFjmph
	 q9Vg1g8N/HCHlJIdko6OagOrS2NcV5TemgTsF+CEdKLCl4DtaFR6661uo6FA/+8WN/
	 WpXlldD11n9DQ==
Date: Thu, 17 Aug 2023 16:36:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, "Olech, Milena" <milena.olech@intel.com>, "Michalik,
 Michal" <michal.michalik@intel.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, poros <poros@redhat.com>, mschmidt
 <mschmidt@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net-next v4 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <20230817163640.2ad33a4b@kernel.org>
In-Reply-To: <DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
References: <20230811200340.577359-1-vadim.fedorenko@linux.dev>
	<20230811200340.577359-3-vadim.fedorenko@linux.dev>
	<20230814194336.55642f34@kernel.org>
	<DM6PR11MB4657AD95547A14234941F9399B1AA@DM6PR11MB4657.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Aug 2023 18:40:00 +0000 Kubalewski, Arkadiusz wrote:
> >Why are all attributes in a single attr space? :(
> >More than half of them are prefixed with a pin- does it really
> >not scream to you that they belong to a different space?
> 
> I agree, but there is an issue with this, currently:
> 
> name: pin-parent-device
> subset-of: dpll
> attributes:
>   -
>     name: id
>     type: u32
>   -
>     name: pin-direction
>     type: u32
>   -
>     name: pin-prio
>     type: u32
>   -
>     name: pin-state
>     type: u32
> 
> Where "id" is a part of device space, rest attrs would be a pin space..
> Shall we have another argument for device id in a pin space?

Why would pin and device not have separate spaces?

When referring to a pin from a "device mostly" command you can
usually wrap the pin attributes in a nest, and vice versa.
But it may not be needed at all here? Let's look at the commands:

+    -
+      name: device-id-get
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - type
+        reply:
+          attributes:
+            - id

All attributes are in "device" space, no mixing.

+      name: device-get
+        request:
+          attributes:
+            - id
+        reply: &dev-attrs
+          attributes:
+            - id
+            - module-name
+            - mode
+            - mode-supported
+            - lock-status
+            - temp
+            - clock-id
+            - type

Again, no pin attributes, so pin can be separate?

+    -
+      name: device-set
+        request:
+          attributes:
+            - id

Herm, this one looks like it's missing attrs :S

+    -
+      name: pin-id-get
+        request:
+          attributes:
+            - module-name
+            - clock-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+        reply:
+          attributes:
+            - pin-id

Mostly pin stuff. I guess the module-name and clock-id attrs can be
copy/pasted between device and pin, or put them in a separate set
and add that set as an attr here. Copy paste is likely much simpler.

+    -
+      name: pin-get
+        request:
+          attributes:
+            - pin-id
+        reply: &pin-attrs
+          attributes:
+            - pin-id
+            - pin-board-label
+            - pin-panel-label
+            - pin-package-label
+            - pin-type
+            - pin-frequency
+            - pin-frequency-supported
+            - pin-dpll-caps
+            - pin-parent-device
+            - pin-parent-pin

All pin.

+    -
+      name: pin-set
+        request:
+          attributes:
+            - pin-id
+            - pin-frequency
+            - pin-direction
+            - pin-prio
+            - pin-state
+            - pin-parent-device
+            - pin-parent-pin

And all pin.

