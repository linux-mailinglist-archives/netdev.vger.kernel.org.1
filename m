Return-Path: <netdev+bounces-115676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCFF9477C1
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D64BE281178
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EBE14F9D7;
	Mon,  5 Aug 2024 08:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IY6zwe1V"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D1614F13E;
	Mon,  5 Aug 2024 08:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848259; cv=none; b=CDlCwCCq1qyf7pvzCh2MzxTK36uV02Lmnj4yJx0Cm60OhHMe56w+UNhLE08J6tqorfbyRmfOdjQ11qds5uYzGjZj8qqXE3NbpszMSIqA8doQr6sfrmahUQ7qUWZZB5nzrVVnBuQkNm+idvhSZlFC3qf/XDFaXHUIXGwoPAxmJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848259; c=relaxed/simple;
	bh=nXSKsJljPyQG2KjxP/RwqDOocnbp100QJWnOIcLrmDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTaX3h0XfGRh+EkD6krtHMXQx3WQhqtX51Z8zpyAQCiv8cnjzI688rt5+9XxUOvdh79OAxZbX6ZJm7U3nrKhfo3ZvoPK8/u2/IF+hctLRVoMGEYRtTzavzSCSvEsQu5Rml7Zl/G/czZh/OUZGGeyIlN2O5OO6kf8ps3bfAd9vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IY6zwe1V; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id E493740737D6;
	Mon,  5 Aug 2024 08:47:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru E493740737D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1722847645;
	bh=Z7DF68oI2SzqdSro69T/JCd/OeieWIA/rbRyTPztJUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IY6zwe1Vm+PWAzF+cfL6r8t2zDqQF+iHfcZiPwziJdL6iB5uJe1FJKQJvxRMmHysw
	 wgby3H3g9l6ckD7yIwGd3sqlQvTXwXE+xvGQWA1bqRPaGSfVy6ighxBD/XPO72YedW
	 J2KeSXG5eH6Y8Ldd9Zawn26lIchKq8nedMl3Kqqc=
Date: Mon, 5 Aug 2024 11:47:12 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Aleksandr Mishin <amishin@t-argos.ru>
Cc: Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] nfc: pn533: Add poll mod list filling check
Message-ID: <20240805-feadcc5dfd3905e1110a5068-pchelkin@ispras.ru>
References: <20240702093924.12092-1-amishin@t-argos.ru>
 <d146fb2c-50bb-4339-b330-155f22879446@kernel.org>
 <4899faf4-14cc-4e68-86e5-8745b38e5ab1@t-argos.ru>
 <ed68c600-aca8-4773-94e3-92347e79877c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed68c600-aca8-4773-94e3-92347e79877c@kernel.org>

On Thu, 04. Jul 14:07, Krzysztof Kozlowski wrote:
> On 03/07/2024 09:26, Aleksandr Mishin wrote:
> > 
> > 
> > On 03.07.2024 8:02, Krzysztof Kozlowski wrote:
> >> On 02/07/2024 11:39, Aleksandr Mishin wrote:
> >>> In case of im_protocols value is 1 and tm_protocols value is 0 this
> >>
> >> Which im protocol has value 1 in the mask?
> >>
> >> The pn533_poll_create_mod_list() handles all possible masks, so your
> >> case is just not possible to happen.
> > 
> > Exactly. pn533_poll_create_mod_list() handles all possible specified 
> > masks. No im protocol has value 1 in the mask. In case of 'im_protocol' 
> 
> Which cannot happen.
> 
> > parameter has value of 1, no mod will be added. So dev->poll_mod_count 
> > will remain 0.
> 
> Which cannot happen.
> 
> > I assume 'im_protocol' parameter is "external" to this driver, it comes 
> > from outside and can contain any value, so driver has to be able to 
> > protect itself from incorrect values.
> 
> Did you read what I wrote? It cannot happen.

An important thing which unfortunately wasn't mentioned in commit log is
that these protocol values actually come from userspace via Netlink
interface (NFC_CMD_START_POLL operation). So a broken or malicious program
may pass a message containing a "bad" combination of protocol parameter
values so that dev->poll_mod_count is not incremented inside
pn533_poll_create_mod_list(), thus leading to division by zero.

nfc_genl_start_poll()
  nfc_start_poll()
    ->start_poll()
    pn533_start_poll()

Looking at pn533_poll_create_mod_list() source code, seems there may be a
number of such "bad" combinations: e.g. when passed tm_protocols is 0 and
im_protocols is 1.

CAP_NET_ADMIN is currently required to perform device control operations
but it's not a point for the situation to be neglected.

Regarding the patch, maybe it'd be better to include the check inside
pn533_poll_create_mod_list() itself and return an error? That'd be more
convenient if someday this function would be called elsewhere in the code
and dev->poll_mod_count must still be guaranteed to be incremented at
least once.

