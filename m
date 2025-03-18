Return-Path: <netdev+bounces-175532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EC6A66527
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 02:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597851784F4
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177D1EEE6;
	Tue, 18 Mar 2025 01:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="RgpdrTVA"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540885626;
	Tue, 18 Mar 2025 01:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261636; cv=none; b=IuY9XxDNlJbTFiTu5NGPEGakJQ6tZpdHm9zdBKWp5wM04gLI+aKHax1MOjCw6na3LLX65bbhLiq03hwvWO2D8ZFgabt1a7I7R0wH5+OGuTkOehttyghAWs8dWE+7KxSqullv10EDMDBODNVScWWzmMMQpVJP0kxJ0TyJ1kz82nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261636; c=relaxed/simple;
	bh=PoRoAAkPPBuR69LGmDgJzLuMGmZ8psP041boRYo8zvU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bmvn4PrcqE/bvphsSk63mgtqC4EPbXJIjXHIRx66lslJiHKuqMgLy0OkkZ9b2qma5U+sJTuwy7eUAzVXITt5sDDzMkaBfqHO5zL90w+QfQ+WEOj9qiudd2r0WddXbu836jmqWxq5uwWcmWgU8L/Xjm213h0aiv5SRil8OQLazMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=RgpdrTVA; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742261633;
	bh=PoRoAAkPPBuR69LGmDgJzLuMGmZ8psP041boRYo8zvU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RgpdrTVAI0X/Bp7kAD0o3uQI+apgWXfXXglB+hBR8dgCNRQIG6CdgyvUrhjOjEnjg
	 9GdgnsQjosBOqJXz71WW3TgrVmdWnOIL48yhskDwK6idlAH/Y7IddHuo2smrcbVndQ
	 5kYYjX5+fZ3Js/lGbtH+LEHjGFeC6im5tuF7N6OSxvwS2ziPZkRe++0I4HW/Jiut6v
	 jOn3do/4O5CrQbkAfJlOnz2osaT0Ydh2EuWACE1uC2rTdLan8nrTpLG4oOiYfFkCsU
	 ZyqNxihU56U4b+PxXCThwfFDNON3zegoknyvxpj00jQwtQRBIr/clfN3MVcSpf/OvJ
	 GqqvwjTghX33w==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D6A6777BB4;
	Tue, 18 Mar 2025 09:33:51 +0800 (AWST)
Message-ID: <57f42b7d08b816bc1a2e25d7f5932c3b2166c074.camel@codeconstruct.com.au>
Subject: Re: [PATCH] usb: gadget: aspeed: Add NULL pointer check in
 ast_vhub_init_dev()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>, gregkh@linuxfoundation.org, 
	joel@jms.id.au
Cc: linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Date: Tue, 18 Mar 2025 12:03:51 +1030
In-Reply-To: <20250311012705.1233829-1-chenyuan0y@gmail.com>
References: <20250311012705.1233829-1-chenyuan0y@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-10 at 20:27 -0500, Chenyuan Yang wrote:
> The variable d->name, returned by devm_kasprintf(), could be NULL.
> A pointer check is added to prevent potential NULL pointer
> dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
>=20
> This issue is found by our static analysis tool

Which tool is this? Can it be run by others (me)?

>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

