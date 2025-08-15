Return-Path: <netdev+bounces-214221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4579B288B0
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 01:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C445AC1C46
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED7D2D29B1;
	Fri, 15 Aug 2025 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pZRyxAUf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AB2D23B6;
	Fri, 15 Aug 2025 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300093; cv=none; b=tJC6xhCvX8uSJwKecnSzI+kBMqFTXAyu6KeAp0r9+WjH7aTqPivOz0jIH1pWcmHd/MwzHG27XWazw/l+NndRLdtFGyo1lGZJjUGLqi1VqV4zaUOlIFW+J7GWCZoqp8EyNtgi0cgHH9HTdUPLetwkuKnHB8m/tRYOHJrpS6QwKlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300093; c=relaxed/simple;
	bh=WlC4a5oslz2GOhgCe2D2ulxeXoaX9MH8oYE1raTsaWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHlf0ZeA1sF8iUVg7yJbNOTAXBE+qhs/uSU8E+wArTzHPV0Fphqwc/NsZA3Mru1LqT4btM3bDw9qgjCyiK0aLxIp/bQQCFsaVepN/te2Kcxh/hErszu5NAGjudwNJHyL3Jj7x/lHG0wqX6ZjPKhjXM2DXqslw1A9eDu3unTtsuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pZRyxAUf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xCezYSDSsCuqM8sg8Tr/57n1gkR3xbFoqEKjIBgBpHA=; b=pZRyxAUf88P+iOjYysq/FeqY4t
	8xwB6jCaFpBXeFyV15umOHZv2iU6UKak/upLK1Kb7JADKkKJqY/WilMwDz+e/RWmEGTFjy9NuT04P
	q7Dr9nz3qCYGj+CuhLJOKIvo63260dTl5tAHS27ZhtHnPOfh4OwE2ZjFlrGZpuNOOqxA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1un3jZ-004s4q-1e; Sat, 16 Aug 2025 01:21:17 +0200
Date: Sat, 16 Aug 2025 01:21:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, mschmidt@redhat.com, poros@redhat.com,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH net-next] dt-bindings: dpll: Add per-channel Ethernet
 reference property
Message-ID: <366b1990-78b2-483f-bda5-2958274939e4@lunn.ch>
References: <20250815144736.1438060-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815144736.1438060-1-ivecera@redhat.com>

On Fri, Aug 15, 2025 at 04:47:35PM +0200, Ivan Vecera wrote:
> In case of SyncE scenario a DPLL channels generates a clean frequency
> synchronous Ethernet clock (SyncE) and feeds it into the NIC transmit
> path. The DPLL channel can be locked either to the recovered clock
> from the NIC's PHY (Loop timing scenario) or to some external signal
> source (e.g. GNSS) (Externally timed scenario).
> 
> The example shows both situations. NIC1 recovers the input SyncE signal
> that is used as an input reference for DPLL channel 1. The channel locks
> to this signal, filters jitter/wander and provides holdover. On output
> the channel feeds a stable, phase-aligned clock back into the NIC1.
> In the 2nd case the DPLL channel 2 locks to a master clock from GNSS and
> feeds a clean SyncE signal into the NIC2.
> 
> 		   +-----------+
> 		+--|   NIC 1   |<-+
> 		|  +-----------+  |
> 		|                 |
> 		| RxCLK     TxCLK |
> 		|                 |
> 		|  +-----------+  |
> 		+->| channel 1 |--+
> +------+	   |-- DPLL ---|
> | GNSS |---------->| channel 2 |--+
> +------+  RefCLK   +-----------+  |
> 				  |
> 			    TxCLK |
> 				  |
> 		   +-----------+  |
> 		   |   NIC 2   |<-+
> 		   +-----------+
> 
> In the situations above the DPLL channels should be registered into
> the DPLL sub-system with the same Clock Identity as PHCs present
> in the NICs (for the example above DPLL channel 1 uses the same
> Clock ID as NIC1's PHC and the channel 2 as NIC2's PHC).
> 
> Because a NIC PHC's Clock ID is derived from the NIC's MAC address,
> add a per-channel property 'ethernet-handle' that specifies a reference
> to a node representing an Ethernet device that uses this channel
> to synchronize its hardware clock. Additionally convert existing
> 'dpll-types' list property to 'dpll-type' per-channel property.

It would be normal to include an implementation of the binding as
patch 2/2. Looking at the implementation sometimes makes
errors/omission in the binding obvious.

> +        channels {
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          channel@0 {
> +            reg = <0>;
> +            dpll-type = "pps";
> +          };
> +
> +          channel@1 {
> +            reg = <1>;
> +            dpll-type = "eec";
> +            ethernet-handle = <&ethernet0>;
> +          };

If i'm reading this correctly, eec requires a ethernet-handle. pps
does not. You should describe that in the binding using constraints.

Otherwise, this looks reasonable to me.

	   Andrew

