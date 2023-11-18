Return-Path: <netdev+bounces-48939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1600B7F015A
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEEE91F22C7F
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1059D1865E;
	Sat, 18 Nov 2023 17:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eGCQe3hg"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935FE1AD;
	Sat, 18 Nov 2023 09:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ODf/EeD7TdfM/V4kFavfoqfzEFUPK1joSi1qIu1/vpo=; b=eGCQe3hghc9aC7kqR7Alui+/Y/
	Wd918gat2/NjcQkpHigcJScHVxcq/DLVNWKzkD+HFQ2J+T2m+AVawujJT/6g6HqDYVLeCdZYXKjVq
	fSCofpLsEC86sjc2Kmt3dhd7BKkCbqozrCVEHUGaZkmWN5kgWlx50j/BVbDWj0HUXxo0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4PHH-000WBY-3h; Sat, 18 Nov 2023 18:38:43 +0100
Date: Sat, 18 Nov 2023 18:38:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/9] ethtool: Expand Ethernet Power Equipment
 with PoE alongside PoDL
Message-ID: <04cb7d87-bb6b-4997-878d-490c17bfdfd0@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231116-feature_poe-v1-2-be48044bf249@bootlin.com>

On Thu, Nov 16, 2023 at 03:01:34PM +0100, Kory Maincent wrote:
> In the current PSE interface for Ethernet Power Equipment, support is
> limited to PoDL. This patch extends the interface to accommodate the
> objects specified in IEEE 802.3-2022 145.2 for Power sourcing
> Equipment (PSE).

Sorry for taking a while getting to these patches. Plumbers and other
patches have been keeping me busy.

I'm trying to get my head around naming... Is there some sort of
hierarchy? Is PSE the generic concept for putting power down the
cable? Then you have the sub-type PoDL, and the sub-type PoE?

>  struct pse_control_config {
>  	enum ethtool_podl_pse_admin_state podl_admin_control;
> +	enum ethtool_pse_admin_state admin_control;

When i look at this, it seems to me admin_control should be generic
across all schemes which put power down the cable, and
podl_admin_control is specific to how PoDL puts power down the cable.

Since you appear to be adding support for a second way to put power
down the cable, i would expect something like poe_admin_control being
added here. But maybe that is in a later patch?

      Andrew

