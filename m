Return-Path: <netdev+bounces-82237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0532488CD35
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF0D2E88F8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6AE13D240;
	Tue, 26 Mar 2024 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anJXt3Nf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51EA3DABF5;
	Tue, 26 Mar 2024 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481381; cv=none; b=VJGn3nYIujpEkYs2Oda0Az8hzEKp1ddDy0WYF7tnNRTTfzVHndzuqPpEBy/ab3P3SP3QmRNNwcme+2YgyY2Y7GIzP/AY8ojRRlk0cuqNMPALpdKUDW9xQwKfGUg0m1Lh8NwZgrpZ5PnVoJN/A1sb1B/Ha/1hUZ4GnR/KbwMqWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481381; c=relaxed/simple;
	bh=/ZOKKbiOIJidOe7A6Rrw3EBU/sq8/cXDVEmyueoxy48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSKXgdrMa4fwCp3KEXGWOUYEBFfQv16wixZ2U6JlAkkgOrls/N6Lf1fhGD3AB0U4xmrD/W0Ieo5MUvFywwUfcUtOhe9aeUb+iSnhO8Yx+IBbpZuAxbVy56B/TPrgbkLfFe+y/qCOyvQtGLwWXScJGUKCBc5AAkdoe33wXMpAqOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anJXt3Nf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACBDC433C7;
	Tue, 26 Mar 2024 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711481381;
	bh=/ZOKKbiOIJidOe7A6Rrw3EBU/sq8/cXDVEmyueoxy48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anJXt3NftnfGovMuRfstSTZlzHtNIpPCUnnrelYgqeDjr45YJ9at+4e3lGKyLpigP
	 Jn2b6vAKKVIeaqv7E+2SieH+ZTx58fzw9VelBH0X/pazIgpEkbKYn+PuWd4PKeEkjF
	 8a9MtcHSDRjo8MEXVOZFE6scpJ5hKUiKoGLwHBG88r84y98q4AMTeJjxHnchFN6LoE
	 v3SGX31OQlpgHKwUikIB1zzma1RZU8P1EIUZjBw1Hpy5XvvBISuvGnuxG5C6KTq3oM
	 A0K7OBCmspZRxrndkOb1BvfOtu3t9Yz5vxrA6ttG3tFAwnD+pN6l2Eh1r76N8hk8co
	 ljr4q+T5Fpblw==
Date: Tue, 26 Mar 2024 14:29:39 -0500
From: Rob Herring <robh@kernel.org>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 net-next 1/2] dt-bindings: net: airoha,en8811h: Add
 en8811h
Message-ID: <20240326192939.GA3250777-robh@kernel.org>
References: <20240326162305.303598-1-ericwouds@gmail.com>
 <20240326162305.303598-2-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326162305.303598-2-ericwouds@gmail.com>

On Tue, Mar 26, 2024 at 05:23:04PM +0100, Eric Woudstra wrote:
> Add the Airoha EN8811H 2.5 Gigabit PHY.
> 
> The en8811h phy can be set with serdes polarity reversed on rx and/or tx.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Did you change something or forget to add Krzysztof's Reviewed-by?

> ---
>  .../bindings/net/airoha,en8811h.yaml          | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/airoha,en8811h.yaml

