Return-Path: <netdev+bounces-242766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03A1C94A80
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 03:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C3233A6826
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 02:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0869022A7F9;
	Sun, 30 Nov 2025 02:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTkSgaS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DC0229B38;
	Sun, 30 Nov 2025 02:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764469754; cv=none; b=K06vFnUR5dT8iDL5HTnTQvdKMUUsD+nsb8hQfKTeyf4ePxmHU5VQ5gNXsDcaJsKwBelDNeWBsEGwttXnTcSwfRAYvzSUb98v8M6vdV1Qt04QEZHmWWA29E8UfhbEKT/ja7ZncUiaej6Vim+KiaeD2MO1MV4nArawazo9P7VDhKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764469754; c=relaxed/simple;
	bh=qUKIZZf1mingDdfuoG4S+7lVTG9QSVgYtpaGJRUy7PA=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=iDLqUYr63+x70PsYqdlSau+0MluAimuu1x2OrtvWYPpcgGRMatuvxSk6b6+5uhsdmakedmd+F6jFQaKJej27XdExBS8+dv7WQr3l6ryROQWJZZ+9gBVHDJn+BRboL4Ddf/mTl/70lMolR4BbCsTBS71rNngk1MiBGHHtMDUIQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTkSgaS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A735C4CEF7;
	Sun, 30 Nov 2025 02:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764469754;
	bh=qUKIZZf1mingDdfuoG4S+7lVTG9QSVgYtpaGJRUy7PA=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=kTkSgaS7jRxNRNpCLyseBRMj5QVZkpa17EDSFSltfj7QzCdFIqyhhcRVrv8kB1yB2
	 nfjOk5DLDWOOWzxida6xyMdrBqeqm6G6a+FHOlY40J0bON+D8QPfmbSBrxbvCwbZVE
	 qSgnHprw4HxKe+h3djw6d5kPqOBqo9Oe3zxDp9oV2vE7hK03vnL0rBbzFt4wbxgIlj
	 kVvE1EhTAvmUeZRMn7oEuuFJlFpynUP+/HYnWxBpby/CfxlSuc9nq6OOd8S9Dh3jcQ
	 pbjHUpjTcFpUL4VjT+UFiUKks1uUM6T8ZhA5b3cx3zj0BpvOtRKBZJpu873IBx30VX
	 B0ClbC6ihzzkg==
Date: Sat, 29 Nov 2025 20:29:13 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Michael Klein <michael@fossekall.de>, 
 Aleksander Jan Bajkowski <olek2@wp.pl>, Jakub Kicinski <kuba@kernel.org>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>
To: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251130005843.234656-2-marek.vasut@mailbox.org>
References: <20251130005843.234656-1-marek.vasut@mailbox.org>
 <20251130005843.234656-2-marek.vasut@mailbox.org>
Message-Id: <176446975120.162513.5605923049281982109.robh@kernel.org>
Subject: Re: [net-next,PATCH 2/3] dt-bindings: net: realtek,rtl82xx:
 Document realtek,ssc-enable property


On Sun, 30 Nov 2025 01:58:33 +0100, Marek Vasut wrote:
> Document support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. Introduce new DT property
> 'realtek,ssc-enable' to enable SSC mode for both RXC and SYSCLK clock
> signals.
> 
> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Michael Klein <michael@fossekall.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251130005843.234656-2-marek.vasut@mailbox.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


