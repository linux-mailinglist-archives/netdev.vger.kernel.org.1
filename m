Return-Path: <netdev+bounces-152596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0490F9F4C14
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 14:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE8F27A66CC
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D61F1F4E24;
	Tue, 17 Dec 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="al8BK7E2"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9061D1730;
	Tue, 17 Dec 2024 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734441493; cv=none; b=JfnrfqlxXmrfuTrJcJ9mZkSXNA2yK//L09Lz2HMd2UFnTzeiMyhmldtbe83x6efLMUwLK1L1TxXSNsQbZJ6QaKJQNVIGNEBD+kMW2a9ZP7wGPMm8RWX+dkxpt4th6MYSC7F5kLDIYS2Rw3hlJ4R6RH0DeTSlm/g9v3VF3KjNqUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734441493; c=relaxed/simple;
	bh=D2JaLFEKc+GbNoonDD2I5Rzfe/D1YqHtUmoEG90PrBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vBCwaOV3ioeE8B0bwS6tbDKN86Q+icetmomIr/LoWDlCu7sNqPHBeyVJbbNdqxyy/cy7JD9Nsa2nqY0EMkLZvhitEUY1XhTflrlefUNiT9gmzdQh0K+eAR1gS0Vrikc2UlwxsPhMU+R0+H4LLtGG5+z5JpXxMRuCkFf4ctgUwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=al8BK7E2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E0091C0003;
	Tue, 17 Dec 2024 13:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734441488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kd3IGr2V/i3QibsHAOuhQzdc631DeRvaF4HW0sqEduU=;
	b=al8BK7E2vHr/Dm3yUxFxnfQiHaN4/I5+qErruTpojlLNU/xCWEWsK4wytoRPFVK9ShwuwW
	+VACykAtQfs51b0Cl5BpikGyuUusr+0ckSEsOOI21yss47v9txcQnFnsYTvV6dwC0Hy85a
	rySjiIKZnB1BtIx9U4Z/a9JMQP/h9yAyLMBHvU5c2uQzrFshkLlyx3pnTHZglaryyHZZn+
	bC+qXNlMGuJoRaT15SxaSWC/cePRHTFfHv0goQX4roXaDMfUhJygC3RqQC4zu+s3Qs6f0L
	07RHH9lHZf4GFYjJY5DDEPzn1VCxPKmgvoDyPTRbp/XIO6AH/SfV7+xNRJv4sQ==
Date: Tue, 17 Dec 2024 14:18:07 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexis =?UTF-8?B?TG90aG9yw6k=?=
 <alexis.lothore@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 4/5] net: pcs: lynx: fill in PCS
 supported_interfaces
Message-ID: <20241217141807.6b1ed05a@fedora.home>
In-Reply-To: <E1tMBRL-006van-3c@rmk-PC.armlinux.org.uk>
References: <Z1yJQikqneoFNJT4@shell.armlinux.org.uk>
	<E1tMBRL-006van-3c@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 13 Dec 2024 19:35:07 +0000
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Fill in the new PCS supported_interfaces member with the interfaces
> that Lynx supports.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

