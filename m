Return-Path: <netdev+bounces-242539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6268C91BAB
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 11:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AFB504E38F1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 10:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB8830BB86;
	Fri, 28 Nov 2025 10:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="oHp3Bvpn"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36EB2DEA95
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764327121; cv=none; b=aPHiEpH+O2Ewo1a9KTvdE16I7+QwJbCeBEccVff8BjOpOWjsa0v6pzHSITF25TI4xvMS4l7/i1nQsnDa0QCFlpD5ZrSHX69/Z9fHLU3jpniOSh0oh7ikwLM3ww/F3opTnp1PrbTLkbPPMDt+cnHGYxNzlHhTrcJ8i/bW186plh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764327121; c=relaxed/simple;
	bh=s2W+CGm1ydgHosXgZ5VtKN7w3QquYidK8/usKzb5qys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnoJKWAde0HzyR8ianm/zwhlnYGiPFPMgZ0zO4YddzaGtVxXrdZWh69Qq4I3HX6Cl36lffluOJbsN9sJvJ0+AZhOecy7OirdBEMP26tf2FH8k4jmUphKiL7CQhJH/SAo6A8vmlVnCEYHexXSnEfPXzHbAZBvZywBZGWdHXzX03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=oHp3Bvpn; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=runbox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight@runbox.com>)
	id 1vOw4w-00FVID-KH; Fri, 28 Nov 2025 11:51:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
	bh=5LAGWU24LAU0h0j/NvqBTpzMROCwg3fkVbLSxyxE29s=; b=oHp3BvpnIoghlHcA05sFKgOsDD
	bgNMo2XFdKYk1gN5X8SG3/UUS9CNylCNIW6pGaq3bLPZg5qhGJ4JUaneZP1opHpgtq5iqXDgi9PbW
	ElH3mUG89HlaNn3d4ODH+9JQoV20KGRNKXLyCKwaLXHfeK61ppUMqD6z+Vqz6U4WwihrmShsnLSxn
	5A4+D+snRBefnWsPxAU9ZBdAiOt/ESTJDgn+RHSoLdBDT8VU7wnoD2bYiD+uqvWj5oPLSZ2ppYgMD
	l7LX54K4fzmSLQQ/hHRq3yQZkeE/uXe82SEOi3ifyGmedemumYPcCpTtoP33c4JuCchqm/sRbDZiD
	iNKxqY7g==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight@runbox.com>)
	id 1vOw4v-0005SO-Jh; Fri, 28 Nov 2025 11:51:53 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vOw4l-000PRy-V6; Fri, 28 Nov 2025 11:51:44 +0100
Date: Fri, 28 Nov 2025 10:51:41 +0000
From: david laight <david.laight@runbox.com>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: dsa: yt921x: Use *_ULL bitfield
 macros for VLAN_CTRL
Message-ID: <20251128105141.50188c6f@pumpkin>
In-Reply-To: <20251126093240.2853294-2-mmyangfl@gmail.com>
References: <20251126093240.2853294-1-mmyangfl@gmail.com>
	<20251126093240.2853294-2-mmyangfl@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 17:32:34 +0800
David Yang <mmyangfl@gmail.com> wrote:

> VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
> macros use unsigned long as the underlying type, which will result in a
> build error on architectures where sizeof(long) == 4.

I suspect GENMASK() should generate u32 or u64 depending on the value
of a constant 'high bit'.

I found code elsewhere that doesn't really want FIELD_PREP() to
generate a 64bit value.

There are actually a lot of dubious uses of 'long' throughout
the kernel that break on 32bit.
(Actually pretty much all of them!)

	David



