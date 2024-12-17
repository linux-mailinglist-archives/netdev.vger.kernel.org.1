Return-Path: <netdev+bounces-152639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7F9F4F36
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 16:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710A6188305C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2927E1F6695;
	Tue, 17 Dec 2024 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evm6DoKh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21531F4E3D;
	Tue, 17 Dec 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448689; cv=none; b=ZqaVbbOBa469BgNOPcxZspZjpBiu0n6/Y30he4894txm2GFahVwlHOPodDxEujj+2Ba7XSAcc36OXxx/GLYYZ8XY7cd7mldh7oA1sjRZudbMFfja7g5kPceiB7Hj6r/EWIPLx/mRCPuMeAAqjNMerOykPGQf/DbEFr+pmPidl8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448689; c=relaxed/simple;
	bh=kJdbCSApHTGeLrjLWjlJ37Pv4MTdyLTou3Eas8n6+CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1hpszDzN5mneEjGIjMThPWn9ftllSH6QyMSxfwJoREF/u1T1VCv8YPXeEHBLphHfIfEXC4Y8j59wH+NrZssK4i6Ru7ScuwX/lr/wEXlruuILm4ArmeFKWjOxVP6FNuDBEwd4kL0uv3HCbIgud96ccy9SlRP4uRiBuCS5BXmtZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evm6DoKh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220CAC4CED3;
	Tue, 17 Dec 2024 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734448688;
	bh=kJdbCSApHTGeLrjLWjlJ37Pv4MTdyLTou3Eas8n6+CA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evm6DoKhGbtnN66T2rGxebwCaMPJN5wCUQnzDzcYi895uShtuKFsIQsmI2Posiwsm
	 Ss62qsZnNBsMju7aDSNxrnkTaluO26XIfYRl+c7K8ElHfWG5Gio4UD+C7GhDQzSGBj
	 DXst+ypL9PwNDq3STt7UYpGkmFP0/kA4IaXCjPO8deHZNjUO/NSKqsSN2z8Oopa3JK
	 byA7ZX5/6s992NZpESNySQABxKOPGRCVbPHsApL1QGmamhgYVIb+2vseCwcwq7wH2k
	 Q59Y21EEGYlofpJgHXG+p/gqk0aUehbBKVxDRPjkfEY8zC/i36nV4l5LyxxwZm/YQs
	 yVUK23SLtroKw==
Date: Tue, 17 Dec 2024 09:18:06 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: conor+dt@kernel.org, krzk+dt@kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>, jacob.e.keller@intel.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	devicetree@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
	robert.marko@sartura.hr, linux-arm-kernel@lists.infradead.org,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v4 9/9] dt-bindings: net: sparx5: document RGMII
 delays
Message-ID: <173444868627.1811657.3055323155605621690.robh@kernel.org>
References: <20241213-sparx5-lan969x-switch-driver-4-v4-0-d1a72c9c4714@microchip.com>
 <20241213-sparx5-lan969x-switch-driver-4-v4-9-d1a72c9c4714@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213-sparx5-lan969x-switch-driver-4-v4-9-d1a72c9c4714@microchip.com>


On Fri, 13 Dec 2024 14:41:08 +0100, Daniel Machon wrote:
> The lan969x switch device supports two RGMII port interfaces that can be
> configured for MAC level rx and tx delays. Document two new properties
> {rx,tx}-internal-delay-ps in the bindings, used to select these delays.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>  .../bindings/net/microchip,sparx5-switch.yaml          | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


