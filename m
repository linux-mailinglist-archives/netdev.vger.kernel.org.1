Return-Path: <netdev+bounces-19139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C49759D81
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 20:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E334281971
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90587275AB;
	Wed, 19 Jul 2023 18:36:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3715486
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 18:36:29 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 56CEFB6
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 11:36:26 -0700 (PDT)
Received: (qmail 1652203 invoked by uid 1000); 19 Jul 2023 14:36:25 -0400
Date: Wed, 19 Jul 2023 14:36:25 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
  edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
  hayeswang@realtek.com, jflf_kernel@gmx.com, bjorn@mork.no,
  svenva@chromium.org, linux-kernel@vger.kernel.org, eniac-xw.zhang@hp.com,
  stable@vger.kernel.org
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
 <20230719173756.380829-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719173756.380829-1-alexandru.gagniuc@hp.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 05:37:56PM +0000, Alexandru Gagniuc wrote:
> For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> in U3 state. If it is not, and the host "disappears", the chip will
> no longer respond to WoL triggers.
> 
> To resolve this, add a notifier block and register it as a reboot
> notifier. When WoL is enabled, work through the usb_device struct to
> get to the suspend function. Calling this function puts the link in
> the correct state for WoL to function.

How do you know that the link will _remain_ in the correct state?

That is, how do you know that the shutdown processing for the USB host 
controller won't disable the link entirely, thereby preventing WoL from 
working?

Alan Stern

