Return-Path: <netdev+bounces-212183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56592B1E968
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172E2A02565
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92CE252900;
	Fri,  8 Aug 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8I9scri"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A564C27C17F
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660704; cv=none; b=Yz+wl6KE9cVZ0SI6HF2X4pIQzfMt44+w3HT80hrNeylZtX9F3d2qYAY+1O7J89VJzxkzSnZvGonsU9u2mUmQBxXVVBcztT8Whc4zR80OiNkilCIPfyQojbsKZEa7/0S8fu39gcKIaVJa2xPP3mwL8aA7p17zuasFFphJ93x/WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660704; c=relaxed/simple;
	bh=KBYLWedCHRrxP1EnxZJ8XRu28Ig8rX3FT3YtyV4RbBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRMOqfqyf3YbkXPQj7FFE5KBUzHKG1tgbfbJhDu08OFr+XuyBRota8nuHrKq7Qoj5uJ4ncRizISOXDBw9/sUQ1crcVe/3ZOukiysMRQBe+h5L8VgoBt2kZoHFpBX25MpdW63UD+CucaMDXcGJgCky/dWVMJaMYKKEuLGla8lf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8I9scri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572EDC4CEED;
	Fri,  8 Aug 2025 13:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660704;
	bh=KBYLWedCHRrxP1EnxZJ8XRu28Ig8rX3FT3YtyV4RbBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8I9scrimov2VRGka2cegfcq1/leGvfBWLBNI4YosHEzMts1Y0av7uKjBV54c12Wn
	 ZNmDfRlZOEIOtFdluNGf+krIt5doZ6H7Ts0wUHfLkzuu+QR6AddD0w0oyZf3diZFGB
	 YlXdXCCRadd3FaInmEC5qjnrTWTqobOK/xDRClXgLcbDatMwbHz8SUXpLqt7s19FhJ
	 EGN6RJu8fSnMtTWbzG+pRDMh51xKqsZ1aWFxvYroTLyROVVEcWYkcjXnXpC/v3N62y
	 0nWMlBsO43XmtMrjCSNbvUeeVbYqS55bm2uyp6ysTF+EtBWf4RJ0VoUKNnzxj/BJ3K
	 CMRF/QXj9yQRw==
Date: Fri, 8 Aug 2025 14:45:00 +0100
From: Simon Horman <horms@kernel.org>
To: Jacek Kowalski <jacek@jacekk.info>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v3 5/5] ixgbe: drop unnecessary casts to u16 /
 int
Message-ID: <20250808134500.GE4654@horms.kernel.org>
References: <2f87d6e9-9eb6-4532-8a1d-c88e91aac563@jacekk.info>
 <9e21249d-b5a7-4949-b724-e29d7b7ea417@jacekk.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e21249d-b5a7-4949-b724-e29d7b7ea417@jacekk.info>

On Wed, Jul 23, 2025 at 10:55:37AM +0200, Jacek Kowalski wrote:
> Remove unnecessary casts of constant values to u16.
> C's integer promotion rules make them ints no matter what.
> 
> Additionally drop cast from u16 to int in return statements.
> 
> Signed-off-by: Jacek Kowalski <jacek@jacekk.info>
> Suggested-by: Simon Horman <horms@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


