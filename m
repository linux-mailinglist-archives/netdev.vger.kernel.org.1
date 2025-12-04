Return-Path: <netdev+bounces-243649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8382ACA4B60
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 18:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CAA6303D605
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 17:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9A02F3C3F;
	Thu,  4 Dec 2025 17:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mon+il9C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD3B2ECE83
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 17:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868330; cv=none; b=qLAl0HIg29e0As0MTIAAqGqsmaPuy5gO3EgLwefYcqFXMqt/G24ijQEsQzHd2ZNzqrK+oAbktIhHbD6D4ghH5XOBy2B4eSE4CTlCPOF7c8rCR5hsy1cjlBd2DWI+Ja464yI2IqPYZ+2mJPAE4UEmkWiP6T2QLhZ+mAKCpIOrhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868330; c=relaxed/simple;
	bh=H0npc7pt+fWzWwL2KKJ68bLEJsgHQoGWt8OwzE015tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOrAxrQHqxR6RwUzmlvul6eHjJ8eKbdUbbjvKz29Bn6ckY+rCuSDJzehXUsnyEN78NNxPFZcI0RRqwtPUCl8DEFFbo+O+DdrWzXVlecOVsZIskyUSvdxK0oTmOvPQGtFY30uf0Z2gBoZRLBwEKBGDhG2hUT51iZmWIR4x5CG4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mon+il9C; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b2de74838so71487f8f.2
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 09:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764868323; x=1765473123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uGUWJRfLEGG5MQjirrXoFGblqtB6v7zhyuKgj/1LsZ8=;
        b=mon+il9ClZyaXPsE4GzldZaDECYDFr5jnsCHFpbCNnhfOH8r4UDm2MsD9eP8OCNzDt
         zqRj7p21tEDHAc7pwulNnBaqFDnV6/RwURG4T4K8+o7X3uw5XYb647CTvBoQf0tDOQ/m
         lJukzY3TQSd6DiEpgmv/uyLnsEvHXzCtJTWfyavCk/OBGRaOer+7oggOAln/0QD2sNIm
         5j+NNMArPCrhqS5PY0LkBNiz6xk9T1tyhzM0YNbm6W+QvWiYZ7iVHexQ46SekJGnb+OZ
         pc7rkqt22KsaCC5jFWpECm1t9jd27gFBQZtI74EPdKcb5GxPyyD+wlp0QxyXMiQPcbFk
         ie3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764868323; x=1765473123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGUWJRfLEGG5MQjirrXoFGblqtB6v7zhyuKgj/1LsZ8=;
        b=gIbK5wvmKOdzpn6tAyB8z1oE5SW7/V2SK0k9PmAO9WO8TrLCImoz+tN++sc+V/OlHh
         Xa2mEMePepb0nnc/vlQ96x68DzBiRiuRnfnmQK/z+MIQfvKnsYew0iR+kdp4vrTI6jYd
         31Igw8afDISNao6eo+2lHy+ce60CimKjR9IlhHdwU43yRC4X0Az3w6Z2rs6bYYtuo6q1
         TiRrtHZ0L1NYR5JVIEc70r/Nfem1oLsFhS3Y7l5crxgAap+QAWUgBJ/PD3ijmz1WB0qT
         GbPdu2MjWRm/p4cuX4oiPXaC7+GucB4xf1REJUWTdtgututZooP0G39BVHw/TtLajgqb
         +5qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFw3rjBz4qeTkPimp98VvivBs6lUnyM07RAQOTX9eXxt+5H6fvpKkcI0RrkeQQVgQ5YTo6NoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX0NMAgrD/YPjtaWaDL2LTYWSrNHJFEDgd4KE9GVNl3ij/i1/T
	L8khfWBYBfmkiU4JvbBcyeJpaIptfb2wlCMTn8Y05gmqxPGpp1draoEI
X-Gm-Gg: ASbGncvzkxz7ZCaKwS/qL758kzE6MibzoSiq5K898mCFeUbmYaIQcy5ufzRD53feq8b
	sgj85LOkLhW0uCvroNaOYtXgIS8CT5GQyTZWDGsFnBG/LEjzgZS3yWTw2RG1gl5fIFguF9OYQdr
	YX8yqZNuB2qXCZ64LOPrCVofjF4oXH2MaVTwKLGtbRcuJiyE8q4qeNUO4gwhY3VRk9oVOMcHktQ
	yekesqQnlmThpQcYfdwLgLcfpiHK0IgpTpXD6z3tr80ZTloo5WHvIUKfR8hFq+qQDWgkg+wJ9eM
	DWPclNtg9LjhUX4357t8uiTC/vCCv9YtOMR9Ej/TwQO8HRcElXIvfYSNRezp/n+CUKktgJjLf99
	LWc6NITNbTYjlzXt+jxNCvLe0wx+ITMQ4R+chBnszkzzrQNqO09WLEEMGrOdZaQ2OuFOe0GIsol
	tBp4w=
X-Google-Smtp-Source: AGHT+IGxkkIvEqrKzXYEjrd610hQ5Joilqojfn2sZR57wWJ4rYVFOquGZdhrsExO4Zfqp1zUdehCbA==
X-Received: by 2002:a05:6000:2f83:b0:42b:2dff:d394 with SMTP id ffacd0b85a97d-42f731e6940mr4153566f8f.8.1764868322949;
        Thu, 04 Dec 2025 09:12:02 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:dbb2:245d:2cf5:21d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbe9065sm4190267f8f.8.2025.12.04.09.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 09:12:02 -0800 (PST)
Date: Thu, 4 Dec 2025 19:11:59 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
	Andrew Lunn <andrew@lunn.ch>, Chen Minqiang <ptpt52@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] net: dsa: mt7530: Use GPIO polarity to generate
 correct reset sequence
Message-ID: <20251204171159.yy3nkvzttxecmhfo@skbuf>
References: <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <4170c560-1edd-4ff8-96af-a479063be4a5@kernel.org>
 <20251204160247.yz42mnxvzhxas5jc@skbuf>
 <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66d080f1-e989-451f-9d5e-34460e5eb1b0@kernel.org>

On Thu, Dec 04, 2025 at 05:48:07PM +0100, Krzysztof Kozlowski wrote:
> Both are the same - inverter or NOT gate, same stuff. It is just
> connecting wire to pull up, not actual component on the board (although
> one could make and buy such component as well...). We never describe
> these inverters in the DTS, these are just too trivial circuits, thus
> the final GPIO_ACTIVE_XXX should already include whatever is on the wire
> between SoC and device.

Please read what Andrew said:
https://lore.kernel.org/netdev/3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch/

  Assuming there is not a NOT gate placed between the GPIO and the reset
  pin, because the board designer decided to do that for some reason?
                   ~~~~~~~~~~~~~~

You two are *not* talking about the same thing. I dismissed the
probability of there being a NOT gate in the form of a discrete chip on
the PCB, *exactly because* you can most likely invert the signal in the
GPIO pin itself.

