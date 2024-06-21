Return-Path: <netdev+bounces-105722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767A912756
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 16:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8A51B219FF
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 14:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563817BA1;
	Fri, 21 Jun 2024 14:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vlq2uwXQ"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFEB4C90
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718979354; cv=none; b=sH8D8tUmpX+45G+TbgfWlAXRwaR79t0DHnUvAIuOA8yaKh9AAafaQjxaW4n9dIvJ2L0QR5Sd6Yw6aPqHqA3w6qWBefKeYqttz3r4BI/6mpDIZQtSNw8GIOJf9qgaXkTDAv/M71SpE/hu1jOeo6vtDa+ZL7xRula/9sJKLTZ0Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718979354; c=relaxed/simple;
	bh=XSKQJassmJrAeDK88fFKuacpjMvBSGRorZNGTqqXnOU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=rpy/POD203t88DUoXkXhvPwNQ2JT2gokCKbfyCmb2luEmkCojNj4rcIAZp5sCjEJgsXFJWomJu9WkFnNx7Cx3cg7RenEnJ4boWHesfCuwC0bCtPbGGsVflY/WRmYqv4e/ERz9Gf4zWeo/YBpGeOrC9zzQBaRqr08Cm6cYF/SJNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vlq2uwXQ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2290F1C000D;
	Fri, 21 Jun 2024 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718979344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XSKQJassmJrAeDK88fFKuacpjMvBSGRorZNGTqqXnOU=;
	b=Vlq2uwXQ+PqkToPDEKBNE5mG0+hGxmJQv37EZlCpvWdmcyCtLdUucqgKJmnKQAi2UT3f5p
	B0SNuVFVTPYr02zqgcDpkCMxxuJa+pQF535Rha55XeHZ9ntHUn2+lYFX2gJ2PHqGJxfKkC
	9fWPlfdUeKJ7caqKYN3BHmyyHmtbV5nqTvh30SP2Bbckk2Hp2PXDp/AmpISFJOn1pOfkg1
	jueK56Pir9Opn6JBlc7K7VaDepPAoJLOSL6ZmUa8M317FM/x1kubdHFzFtoyI+6GmzL33J
	PSj9pcI+JRz2O9fBjHR/B0B+ikmjb0hv4ohTSAK3Uc9m6+HAQ6VA5FHXXx+9mA==
Date: Fri, 21 Jun 2024 16:15:43 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Donald Hunter
 <donald.hunter@gmail.com>
Subject: Netlink specs, help dealing with nested array
Message-ID: <20240621161543.42617bef@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello Jakub, Donald or other ynl experts,

I have an issue dealing with a nested array.

Here is my current netlink spec and ethtool patches:
https://termbin.com/gbyx
https://termbin.com/b325

Here is the error I got:
https://termbin.com/c7b1

I am trying to investigate what goes wrong with ynl but I still don't know.
If someone have an idea of what is going wrong with ynl or my specs it woul=
d be
lovely!=20

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

