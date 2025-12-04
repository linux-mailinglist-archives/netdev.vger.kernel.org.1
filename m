Return-Path: <netdev+bounces-243591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2BCA456E
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 16:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37890302A136
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28601220F21;
	Thu,  4 Dec 2025 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3LfED9MB"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F429165F1A;
	Thu,  4 Dec 2025 15:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863428; cv=none; b=LmJG9K7KLaP/vuwhRzsiyY/q4wrKyeQVbxYUA+DG0j/TVe56RykiJvSYjUU4oW/2GEqpG4zic8vrJkRn64RCOB0gPqVHGTkOF4D9FbbaeeqGKyTRNTp7JbmTfxMMaIfpb9xeyiKx6vMNCJy8CFgBh+u3342OyHFZEyyQA7rXlTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863428; c=relaxed/simple;
	bh=izJb++fclm+O1RyxSOCpKLGhbHfwFzuu8JEZtxkRF+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjGjEKeGENyPaaeKFmxRivqkMnwAYLlWCt94iKbZU+wbEHWT7HamoCvea3CZwBjv424GMCBXmaWyct+lhgJnTmw96AjTNqgu562NX8/uKnDDj1fZXZX/laodEJbEizg/Q+FdBNNJnZ03EoOuRCFVqBR6jYNok2EGa5xrskcDruM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3LfED9MB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JmHDN9+FyKNF3nnMHF6majqVZS/gMkdAchuPv+k0xHU=; b=3LfED9MBH0dJRu7fQSVVplD8hy
	Lv5De7HAy35OaF0KkYOQFpAoHNhJvhvSelH6Ii6tLyHPlIuB9fXP+fxND1y/ESkBfRaoEkKNPpjzn
	id5bQQcfraNL/ZvFwbcosE8lbT+J00hj0Ba19bmW+Rh9fzSjk3ToNhFX9sQI7FsWXHgU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vRBau-00Fz8U-9Q; Thu, 04 Dec 2025 16:50:12 +0100
Date: Thu, 4 Dec 2025 16:50:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Daniel Golle <daniel@makrotopia.org>, Frank Wunderlich <frankwu@gmx.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Chen Minqiang <ptpt52@gmail.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <16038b9d-11f4-4995-b0c2-7e7d55bb494a@lunn.ch>
References: <20251129234603.2544-2-ptpt52@gmail.com>
 <0675b35f-217d-4261-9e3f-2eb24753d43c@lunn.ch>
 <20251130080731.ty2dlxaypxvodxiw@skbuf>
 <3fbc4e67-b931-421c-9d83-2214aaa2f6ed@lunn.ch>
 <0d85e1e6-ea75-4f20-aef1-90d446b4bfa1@kernel.org>
 <00f308a1-a4b1-4f20-8d8e-459ddf4c39b1@gmx.de>
 <aS7Zj3AFsSp2CTNv@makrotopia.org>
 <20251204131626.upw77jncqfwxydww@skbuf>
 <7aacc2c2-50d0-4a08-9800-dc4a572dffcb@lunn.ch>
 <20251204153721.ubmxifrev4cre6ab@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204153721.ubmxifrev4cre6ab@skbuf>

> Frank said that the fact the driver expecting a wrong device tree is
> forcing him to keep introducing even more wrong device trees for new
> boards.

So it sounds like there is no technical reason to fix this, it is just
aesthetics?

	Andrew

