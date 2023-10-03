Return-Path: <netdev+bounces-37704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EACC7B6AED
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 17E7C2811D6
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAAD2AB2E;
	Tue,  3 Oct 2023 13:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD661548D
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 13:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4BCC433C9;
	Tue,  3 Oct 2023 13:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696341342;
	bh=RehqYHD6T9b4MqkacWDHh6XWfs2/J+zU49r0P9HOHb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KXpPCd6PFi2WwOjKwlOgrSI7MBF5fd6TGaZIcrzCeCExQos1tKIg5hjcRx+z9rOu+
	 7tOuJu2YCqW4ZHEUwCoSJyKDUyuk2eqdlU/qrHmSBx2bSJBiAkViz3ooZUKQFEbP6d
	 kxEPB8YrkHzGm+DBjNVSwslBHxraQ7Uib6VjvUliQIwqwPTqCLcGgZGReHxMz5dUNR
	 79XWxmSmCRLQP/kosQh4SKpONj3URHPYbAkKXY1kw0gATD6ILvSNFLJT2uL/c8sHW3
	 fAG7WSzjJvUPF74EQ6hdCzbWL5ZNILVkqp/yz4yoqsD3bBN9bldBa8wRhbXxLsnG78
	 1QwGjzWuHZcWg==
Date: Tue, 3 Oct 2023 06:55:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, Russell
 King <linux@armlinux.org.uk>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Oleksij Rempel <linux@rempel-privat.de>, =?UTF-8?B?Tmljb2zDsg==?= Veronese
 <nicveronese@gmail.com>, thomas.petazzoni@bootlin.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [RFC PATCH net-next 6/7] net: ethtool: add a netlink command to
 get PHY information
Message-ID: <20231003065535.34a3a4e0@kernel.org>
In-Reply-To: <20230914113613.54fe125c@fedora>
References: <20230907092407.647139-1-maxime.chevallier@bootlin.com>
	<20230907092407.647139-7-maxime.chevallier@bootlin.com>
	<20230908084606.5707e1b1@kernel.org>
	<20230914113613.54fe125c@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Sep 2023 11:36:13 +0200 Maxime Chevallier wrote:
> I'm currently implementing this, and I was wondering if it could be
> worth it to include a pointer to struct phy_device directly in
> ethnl_req_info.
>=20
> This would share the logic for all netlink commands that target a
> phy_device :
>=20
>  - plca
>  - pse-pd
>  - cabletest
>  - other future commands
>=20
> Do you see this as acceptable ? we would grab the phy_device that
> matches the passed phy_index in the request, and if none is specified,
> we default to dev->phydev.

You may need to be careful with that. It could work in practice but=20
the req_info is parsed without holding any locks, IIRC. And there
may also be some interplay between PHY state and ethnl_ops_begin().

=46rom netlink perspective putting the PHY info in the header nest makes
perfect sense to me. Just not sure if you can actually get the object
when the parsing happens or you'd need to just store the index and
resolve it later? PHYLIB maintainers may be best at advising on the
lifetime expectations for phys..

Sorry for the delayed response, #vacation.

