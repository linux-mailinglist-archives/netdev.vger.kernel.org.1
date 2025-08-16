Return-Path: <netdev+bounces-214265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1123B28B24
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 08:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8528D4E0273
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 06:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C935E21ABD5;
	Sat, 16 Aug 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLIL7fXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8F24C98;
	Sat, 16 Aug 2025 06:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326206; cv=none; b=RYxKrPsNPFoITeFdP6xKe0nsYKAKy0Y2aAEW2IReIX3Iq/Jkw1Oo24DHJBnomA+jbA052mUGXJJ1lokNzJ4CUlN3xWwb5NNlDDxgnYekhbNkucTZkT46lYFiAchfo/+IOh0Jl5vnRoDYz/gTmA8dPk3MyQ4E+q1V6cCMGFreeXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326206; c=relaxed/simple;
	bh=e3TlXsl7J6n+JnvZjD5JbNdTrBQalO3UQAygK254KNM=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=e/xgUczaEQ02ooM6dqxGoLURcMetqPScaAnaY9XqZe+56zXBNG21RawMn5s60pu1OhVefYROfm8tf7Yyw8KdOWBXCiuZeZ28Zp4X+o86N75SLPAjKyU44eyCEyIznLqVTJVYKni43WouFq4d5v7nnU0B5klf2vsGVVXjdRbWfE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLIL7fXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A9EC4CEEF;
	Sat, 16 Aug 2025 06:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755326206;
	bh=e3TlXsl7J6n+JnvZjD5JbNdTrBQalO3UQAygK254KNM=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lLIL7fXhYwsIl1etMnc+L0oCST/y05LNOoUjqE6rrNJGikJ5TNAofgHHA2UAUrrVI
	 9+GJZlsLaYc6BhKLITQMRHsRI+kGQAmWraxcWV0UCA/MbeEr6+e++DK3oHmVFBPzTT
	 LBMICY6GuPuK6K5/lIeXZm9ZRuM72UzDZ2iRBMrSfcCW2TR7tEhcEprvX1UUse+AhP
	 admkZSMWX3EUkF6Xjw1oSXOutofrLLDxojQLmU0qNqxrlHJQUKzxCGjg8vRPkKpkQL
	 42lo8SYfNas4D4RQ2EXcep638HZeBGRwkPdBkeGOjwbHDa0n/pB3OMIum5+KdBmbuc
	 w4bYrV6RV1liA==
Date: Sat, 16 Aug 2025 01:36:45 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, 
 Simon Horman <horms@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
In-Reply-To: <20250816052323.360788-2-mmyangfl@gmail.com>
References: <20250816052323.360788-1-mmyangfl@gmail.com>
 <20250816052323.360788-2-mmyangfl@gmail.com>
Message-Id: <175532620515.64739.11436044234817739491.robh@kernel.org>
Subject: Re: [net-next v3 1/3] dt-bindings: net: dsa: yt921x: Add Motorcomm
 YT921x switch support


On Sat, 16 Aug 2025 13:23:19 +0800, David Yang wrote:
> The Motorcomm YT921x series is a family of Ethernet switches with up to
> 8 internal GbE PHYs and up to 2 GMACs.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  .../bindings/net/dsa/motorcomm,yt921x.yaml    | 166 ++++++++++++++++++
>  1 file changed, 166 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml: properties:motorcomm,switch-id: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml: properties:motorcomm,switch-id:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250816052323.360788-2-mmyangfl@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


