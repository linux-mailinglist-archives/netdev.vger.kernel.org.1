Return-Path: <netdev+bounces-194516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD0AC9C86
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9096D3A20FE
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254F318D63A;
	Sat, 31 May 2025 19:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBcHksD+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17214F70;
	Sat, 31 May 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748719291; cv=none; b=shKhDC1kscBpFPmEdQJynrR6StRSA162TGTpGjAHNNtNrRTusD/Gkzbu8q4hHiJnm+1llU8YQTs64X64FyDlrzH8607LZNb55hMdqfNwZiLz8AkFq6C1szhEI4y1WMC+RyBYcbOhmIY4o95Rm6l75JWmr4PPpBbtzm06Hp6lj6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748719291; c=relaxed/simple;
	bh=KBQV2QoLOKFlpmeZPl3AqTE9sws1seuovCFalTgbV9A=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kVMr3a9uW+NsSbq0AnOYH9V/XH7DaNBtWCGn9VI0fsuJNvIVxhXLfD30Sj7eEWGy7Bs1val57gAb5K9XLy7GfI+1gn1TFXCZdTRINZBU0Xd+dl36BzMIAF55F401GBJ8pDasne02XSkMvozMFh1Vb58pGAna9IUQsrPKwWPFCkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBcHksD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E345C4CEE3;
	Sat, 31 May 2025 19:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748719290;
	bh=KBQV2QoLOKFlpmeZPl3AqTE9sws1seuovCFalTgbV9A=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=VBcHksD+WjkQ6iYc5Cth9A7OuE1UiWEzJRHIzEHbHWWia6iveS89CjbOmvCdcvNSA
	 RL1TQxnkGs/IJfUhlUWejJZWtk/qxaapeJTY43Q9S1ViMqf47MTBo1NsXaA2Z83YK9
	 xIwWeKSbT3EwmPo8WrqDap82wP2RVJEFp/Pfw38oDWwoyeBT914hzwRYBFIepE10jv
	 CE/aVIXDIihz3dLoIh7m3rjEuYB9NrTTMnquW7ZdjRpCUSud+eobC7eNYUoI7Ie4v9
	 v4mw2fTY0jFZEXEaXFHhStyP+NuKxJmE/xQa3OpDg0fbWuJQx5IKknZ6kFfwSw4jAg
	 sNJPPaS6hteXQ==
Date: Sat, 31 May 2025 14:21:28 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, noltari@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 devicetree@vger.kernel.org, jonas.gorski@gmail.com, 
 "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>
To: Kyle Hendry <kylehendrydev@gmail.com>
In-Reply-To: <20250531183919.561004-4-kylehendrydev@gmail.com>
References: <20250531183919.561004-1-kylehendrydev@gmail.com>
 <20250531183919.561004-4-kylehendrydev@gmail.com>
Message-Id: <174871928827.1012132.17536935109974520742.robh@kernel.org>
Subject: Re: [PATCH RESEND net-next v4 3/3] dt-bindings: net: phy: add
 BCM63268 GPHY


On Sat, 31 May 2025 11:39:14 -0700, Kyle Hendry wrote:
> Add YAML bindings for BCM63268 internal GPHY
> 
> Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
> ---
>  .../bindings/net/brcm,bcm63268-gphy.yaml      | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/brcm,bcm63268-gphy.yaml: maintainers:0: 'TBD' does not match '@'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250531183919.561004-4-kylehendrydev@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


